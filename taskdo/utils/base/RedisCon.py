# -*- coding=utf-8 -*-

import redis
from django.conf import settings


class RedisConPool(object):
    REDSI_POOL = 10000

    @staticmethod
    def getRedisConnection(db):
        '''根据数据源标识获取Redis连接池'''
        if db==RedisConPool.REDSI_POOL:
            args = settings.REDSI_KWARGS_LPUSH
            if settings.REDSI_LPUSH_POOL == None:
                settings.REDSI_LPUSH_POOL = redis.ConnectionPool(host=args.get('host'), port=args.get('port'), db=args.get('db'))
            pools = settings.REDSI_LPUSH_POOL
        connection = redis.Redis(connection_pool=pools)
        return connection


class DsRedis(object):
    @staticmethod
    def lpush(redisKey,data):
        try:
            redisConn = RedisConPool.getRedisConnection(RedisConPool.REDSI_POOL)
            redisConn.lpush(redisKey, data)
            redisConn = None
        except:
            return False

    @staticmethod
    def rpop(redisKey):
        try:
            redisConn = RedisConPool.getRedisConnection(RedisConPool.REDSI_POOL)
            data = redisConn.rpop(redisKey)
            redisConn = None
            return data
        except:
            return False
    @staticmethod
    def delete(redisKey):
        try:
            redisConn = RedisConPool.getRedisConnection(RedisConPool.REDSI_POOL)
            data = redisConn.delete(redisKey)
            redisConn = None
            return data
        except:
            return False
    @staticmethod
    def setlock(rkey,value):
        try:
            redisConn = RedisConPool.getRedisConnection(RedisConPool.REDSI_POOL)
            redisConn.set(rkey, value)
            # redisConn.expire(redisKey, 1800)
            redisConn.expire(rkey, 1800)
            redisConn = None
        except:
            import traceback
            print traceback.print_exc()
            return False
    @staticmethod
    def get(rkey):
        try:
            redisConn = RedisConPool.getRedisConnection(RedisConPool.REDSI_POOL)
            result = redisConn.get(rkey)
            redisConn = None
            return result
        except:
            return False
