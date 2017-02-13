#!/Users/miaoyujia/anaconda/bin/python
# -*- coding:utf8 -*-
import random
import sys

nums = sys.argv[1]
names = ['谈雪娇', '郭栋栋', '余文兵',  '汴欣桐', '贺伟', '曹国梁']
slic = random.sample(names, int(nums))
slic.append('苗雨佳')
print ','.join(slic)

