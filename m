Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A8161EC82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 08:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKGH7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 02:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiKGH7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:59:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866DC13E87
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Nov 2022 23:59:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w14so14879546wru.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Nov 2022 23:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WjK9SpWGMh8WElKi6opABGutXyz9IghTvanr4w4CrU=;
        b=gBSicX4VGZDMAIYMIEGgDF97asRz0tAKTrhQMeO8ZGB5tzFegEKTW4cizEwer/sWfW
         kHeJYPkrEOKa6wtReBSA89sJ/EZFdX3REn0cy3SQaxmuW/x2LyzyafjQlvFl0s4Brw+3
         5qv6SHRhMuBR5soqelB7kKxGlxh4qModxTIqxUsSO0O5zn7tpY+cvwLbpWocGGJ7EU6c
         3sXxJZulfVuvYNTKBh552rpiNOfEsIqLXuBpOxeB3wx7ljWw8YZt/UIrRweiVh1FJO/C
         MOslM6x8NZxzyDkWr4XYA/nyzaGGtK3B+1SpPIQQva1Hst97Ce0L7e54llSZXAUzFRx7
         8jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WjK9SpWGMh8WElKi6opABGutXyz9IghTvanr4w4CrU=;
        b=gFrH/YmXwAH3dglMci3WQSFHRiJauKSdlpqgOwEjFCfQ65XACsDiYLOVfRTgvAedii
         LadOy57obd8S5yu9WY0AFkcT3y6lF8nREMYVfJsjGr9Ks64gqsr9/Yoe52dOFkxeJm8k
         worIIs8HaSYI2yb6v6MQMiT6wbZIegFqmlDcBdOM18jC6pOFp9AuIhRkoRmM0pXcXyqF
         K81V/qqkWCfut1m1OQFhL/bxM30Td5u6lEWbGziRdKUf39LXyIk8TviiEoVJbx7axLBw
         A5lZQ5pYvs/9a1BoGJf6OgCi/np8Q8Lo+NGP/3majupH4jy6ft+SSVaacSafiRQYc5qk
         hIwA==
X-Gm-Message-State: ACrzQf0zWIDTTZTqGnpWjZt92erdx2g/3s+W2oVEdodiyvKHGx6KxaDW
        bdJaM+TXjJtqa3YKjxaLAL1lLmOaB+c=
X-Google-Smtp-Source: AMsMyM63jbiD5kIdmk/KMHvaXEV64M3jubr2bt0LVb+dNa78RGvg943UvAb0Mb2cWKrd99xymGV7jg==
X-Received: by 2002:a05:6000:2c3:b0:236:dd92:16d1 with SMTP id o3-20020a05600002c300b00236dd9216d1mr24013119wry.50.1667807940928;
        Sun, 06 Nov 2022 23:59:00 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z3-20020adff1c3000000b00236e834f050sm6435580wro.35.2022.11.06.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:59:00 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:58:57 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@opensource.wdc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: add sanity check for aggregated conventional
 zones
Message-ID: <202211060620.c1JmfU3k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e4afaca0eb337bf18231358b7e764d4cdf5c5a.1667471410.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Johannes,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/zonefs-add-sanity-check-for-aggregated-conventional-zones/20221103-183404
patch link:    https://lore.kernel.org/r/f7e4afaca0eb337bf18231358b7e764d4cdf5c5a.1667471410.git.johannes.thumshirn%40wdc.com
patch subject: [PATCH] zonefs: add sanity check for aggregated conventional zones
config: ia64-randconfig-m031-20221104
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
fs/zonefs/super.c:1411 zonefs_init_file_inode() warn: add some parenthesis here?
fs/zonefs/super.c:1411 zonefs_init_file_inode() warn: maybe use && instead of &
fs/zonefs/super.c:1496 zonefs_create_inode() error: uninitialized symbol 'ret'.

Old smatch warnings:
fs/zonefs/super.c:797 zonefs_file_dio_append() error: uninitialized symbol 'size'.

vim +1411 fs/zonefs/super.c

8dcc1a9d90c10f Damien Le Moal     2019-12-25  1395  
1da18a296f5ba4 Damien Le Moal     2022-04-12  1396  static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1397  				  enum zonefs_ztype type)
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1398  {
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1399  	struct super_block *sb = inode->i_sb;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1400  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1401  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
14bdb047a54d7a Damien Le Moal     2022-05-24  1402  	int ret = 0;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1403  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1404  	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1405  	inode->i_mode = S_IFREG | sbi->s_perm;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1406  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1407  	zi->i_ztype = type;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1408  	zi->i_zsector = zone->start;
e3c3155bc95ab6 Johannes Thumshirn 2020-07-21  1409  	zi->i_zone_size = zone->len << SECTOR_SHIFT;
4113036e1dcbb0 Johannes Thumshirn 2022-11-03  1410  	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
4113036e1dcbb0 Johannes Thumshirn 2022-11-03 @1411  	    !sbi->s_features & ZONEFS_F_AGGRCNV) {

Needs to be !(sbi->s_features & ZONEFS_F_AGGRCNV)) {

4113036e1dcbb0 Johannes Thumshirn 2022-11-03  1412  		zonefs_err(sb,
4113036e1dcbb0 Johannes Thumshirn 2022-11-03  1413  			   "zone size %llu doesn't match device's zone sectors %llu\n",
4113036e1dcbb0 Johannes Thumshirn 2022-11-03  1414  			   zi->i_zone_size,
4113036e1dcbb0 Johannes Thumshirn 2022-11-03  1415  			   bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT);
4113036e1dcbb0 Johannes Thumshirn 2022-11-03  1416  		return -EINVAL;
4113036e1dcbb0 Johannes Thumshirn 2022-11-03  1417  	}
e3c3155bc95ab6 Johannes Thumshirn 2020-07-21  1418  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1419  	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
e3c3155bc95ab6 Johannes Thumshirn 2020-07-21  1420  			       zone->capacity << SECTOR_SHIFT);
ccf4ad7da0d9c3 Damien Le Moal     2020-03-20  1421  	zi->i_wpoffset = zonefs_check_zone_condition(inode, zone, true, true);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1422  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1423  	inode->i_uid = sbi->s_uid;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1424  	inode->i_gid = sbi->s_gid;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1425  	inode->i_size = zi->i_wpoffset;
e3c3155bc95ab6 Johannes Thumshirn 2020-07-21  1426  	inode->i_blocks = zi->i_max_size >> SECTOR_SHIFT;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1427  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1428  	inode->i_op = &zonefs_file_inode_operations;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1429  	inode->i_fop = &zonefs_file_operations;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1430  	inode->i_mapping->a_ops = &zonefs_file_aops;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1431  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1432  	sb->s_maxbytes = max(zi->i_max_size, sb->s_maxbytes);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1433  	sbi->s_blocks += zi->i_max_size >> sb->s_blocksize_bits;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1434  	sbi->s_used_blocks += zi->i_wpoffset >> sb->s_blocksize_bits;
1da18a296f5ba4 Damien Le Moal     2022-04-12  1435  
87c9ce3ffec906 Damien Le Moal     2022-04-12  1436  	mutex_lock(&zi->i_truncate_mutex);
87c9ce3ffec906 Damien Le Moal     2022-04-12  1437  
1da18a296f5ba4 Damien Le Moal     2022-04-12  1438  	/*
1da18a296f5ba4 Damien Le Moal     2022-04-12  1439  	 * For sequential zones, make sure that any open zone is closed first
1da18a296f5ba4 Damien Le Moal     2022-04-12  1440  	 * to ensure that the initial number of open zones is 0, in sync with
1da18a296f5ba4 Damien Le Moal     2022-04-12  1441  	 * the open zone accounting done when the mount option
1da18a296f5ba4 Damien Le Moal     2022-04-12  1442  	 * ZONEFS_MNTOPT_EXPLICIT_OPEN is used.
1da18a296f5ba4 Damien Le Moal     2022-04-12  1443  	 */
1da18a296f5ba4 Damien Le Moal     2022-04-12  1444  	if (type == ZONEFS_ZTYPE_SEQ &&
1da18a296f5ba4 Damien Le Moal     2022-04-12  1445  	    (zone->cond == BLK_ZONE_COND_IMP_OPEN ||
1da18a296f5ba4 Damien Le Moal     2022-04-12  1446  	     zone->cond == BLK_ZONE_COND_EXP_OPEN)) {
1da18a296f5ba4 Damien Le Moal     2022-04-12  1447  		ret = zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
87c9ce3ffec906 Damien Le Moal     2022-04-12  1448  		if (ret)
87c9ce3ffec906 Damien Le Moal     2022-04-12  1449  			goto unlock;
1da18a296f5ba4 Damien Le Moal     2022-04-12  1450  	}
1da18a296f5ba4 Damien Le Moal     2022-04-12  1451  
87c9ce3ffec906 Damien Le Moal     2022-04-12  1452  	zonefs_account_active(inode);
87c9ce3ffec906 Damien Le Moal     2022-04-12  1453  
87c9ce3ffec906 Damien Le Moal     2022-04-12  1454  unlock:
87c9ce3ffec906 Damien Le Moal     2022-04-12  1455  	mutex_unlock(&zi->i_truncate_mutex);
87c9ce3ffec906 Damien Le Moal     2022-04-12  1456  
14bdb047a54d7a Damien Le Moal     2022-05-24  1457  	return ret;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1458  }
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1459  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1460  static struct dentry *zonefs_create_inode(struct dentry *parent,
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1461  					const char *name, struct blk_zone *zone,
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1462  					enum zonefs_ztype type)
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1463  {
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1464  	struct inode *dir = d_inode(parent);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1465  	struct dentry *dentry;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1466  	struct inode *inode;
1da18a296f5ba4 Damien Le Moal     2022-04-12  1467  	int ret;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1468  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1469  	dentry = d_alloc_name(parent, name);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1470  	if (!dentry)
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1471  		return NULL;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1472  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1473  	inode = new_inode(parent->d_sb);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1474  	if (!inode)
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1475  		goto dput;

"ret" not initialized on this path.

8dcc1a9d90c10f Damien Le Moal     2019-12-25  1476  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1477  	inode->i_ctime = inode->i_mtime = inode->i_atime = dir->i_ctime;
1da18a296f5ba4 Damien Le Moal     2022-04-12  1478  	if (zone) {
1da18a296f5ba4 Damien Le Moal     2022-04-12  1479  		ret = zonefs_init_file_inode(inode, zone, type);
1da18a296f5ba4 Damien Le Moal     2022-04-12  1480  		if (ret) {
1da18a296f5ba4 Damien Le Moal     2022-04-12  1481  			iput(inode);
1da18a296f5ba4 Damien Le Moal     2022-04-12  1482  			goto dput;
1da18a296f5ba4 Damien Le Moal     2022-04-12  1483  		}
1da18a296f5ba4 Damien Le Moal     2022-04-12  1484  	} else {
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1485  		zonefs_init_dir_inode(dir, inode, type);
1da18a296f5ba4 Damien Le Moal     2022-04-12  1486  	}
1da18a296f5ba4 Damien Le Moal     2022-04-12  1487  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1488  	d_add(dentry, inode);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1489  	dir->i_size++;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1490  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1491  	return dentry;
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1492  
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1493  dput:
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1494  	dput(dentry);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1495  
4113036e1dcbb0 Johannes Thumshirn 2022-11-03 @1496  	return ERR_PTR(ret);
8dcc1a9d90c10f Damien Le Moal     2019-12-25  1497  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
