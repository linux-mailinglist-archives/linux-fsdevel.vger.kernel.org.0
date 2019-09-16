Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD7B34A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 08:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfIPGQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 02:16:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfIPGQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 02:16:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8G68Zbo192214;
        Mon, 16 Sep 2019 06:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=CtWrTL0K6xN/JkonUsZEyZ20Ju4VQZE9wyDzSkQvLZ0=;
 b=EU/k4kkex7ckgIxckUEnMImdZWwBOgjB5oLB9IdltnLI4Drj/yXlGpKiEO2mYZAXjyd6
 cAg2dvO9HPQMv42KYZOVlbSpPQtTg378CJCFrf76N1vViVzgeKNceQLc69merzi+zSB6
 doFYDleRlvRUmkyX42WL7sErlZdLI9C24r+mZo5evL38qmWHpyHsWHRYvgungyJWlTZp
 9BdccL6rj4CMEcKfkFsgg/8wYo7ZIrrpJHeNxjmvRVjA2vdTv2L0u7T+7HQ6p+0CkTUZ
 T56xqahP1F5Rqd6RzU9ARJtlvPZaXEmZOzDNZDk4llkALwALEgd4tuGPndbYjzJGyNvs iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v0ruqd7qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 06:16:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8G69TNN013659;
        Mon, 16 Sep 2019 06:16:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v0qhnw3h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 06:16:37 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8G6GaLJ016047;
        Mon, 16 Sep 2019 06:16:36 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 15 Sep 2019 23:16:35 -0700
Date:   Mon, 16 Sep 2019 09:16:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, David Howells <dhowells@redhat.com>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:uncertain.shmem 18/18] mm/shmem.c:3577 shmem_reconfigure()
 warn: inconsistent returns 'spin_lock:&sbinfo->stat_lock'.
Message-ID: <20190916061630.GX20699@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160067
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/viro/vfs.git uncertain.shmem
head:   dc28c12a0e98f33ed0923135cfb5136caaa2e92d
commit: dc28c12a0e98f33ed0923135cfb5136caaa2e92d [18/18] vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
mm/shmem.c:3577 shmem_reconfigure() warn: inconsistent returns 'spin_lock:&sbinfo->stat_lock'.
  Locked on:   line 3577
  Unlocked on: line 3575

git remote add vfs https://kernel.googlesource.com/pub/scm/linux/kernel/git/viro/vfs.git
git remote update vfs
git checkout dc28c12a0e98f33ed0923135cfb5136caaa2e92d
vim +3577 mm/shmem.c

dc28c12a0e98f3 David Howells    2019-03-25  3526  static int shmem_reconfigure(struct fs_context *fc)
^1da177e4c3f41 Linus Torvalds   2005-04-16  3527  {
dc28c12a0e98f3 David Howells    2019-03-25  3528  	struct shmem_options *ctx = fc->fs_private;
dc28c12a0e98f3 David Howells    2019-03-25  3529  	struct shmem_sb_info *sbinfo = SHMEM_SB(fc->root->d_sb);
0edd73b33426df Hugh Dickins     2005-06-21  3530  	unsigned long inodes;
dc28c12a0e98f3 David Howells    2019-03-25  3531  	const char *err;
^1da177e4c3f41 Linus Torvalds   2005-04-16  3532  
0edd73b33426df Hugh Dickins     2005-06-21  3533  	spin_lock(&sbinfo->stat_lock);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

0edd73b33426df Hugh Dickins     2005-06-21  3534  	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
dc28c12a0e98f3 David Howells    2019-03-25  3535  	if (ctx->seen & SHMEM_SEEN_BLOCKS) {
1054087b0658a7 Al Viro          2019-09-08  3536  		if (percpu_counter_compare(&sbinfo->used_blocks,
dc28c12a0e98f3 David Howells    2019-03-25  3537  					   ctx->blocks) > 0) {
dc28c12a0e98f3 David Howells    2019-03-25  3538  			err = "Too small a size for current use";
0edd73b33426df Hugh Dickins     2005-06-21  3539  			goto out;
                                                                        ^^^^^^^^^

dc28c12a0e98f3 David Howells    2019-03-25  3540  		}
dc28c12a0e98f3 David Howells    2019-03-25  3541  		if (ctx->blocks && !sbinfo->max_blocks) {
dc28c12a0e98f3 David Howells    2019-03-25  3542  			err = "Cannot retroactively limit nr_blocks";
1054087b0658a7 Al Viro          2019-09-08  3543  			goto out;
1054087b0658a7 Al Viro          2019-09-08  3544  		}
dc28c12a0e98f3 David Howells    2019-03-25  3545  	}
dc28c12a0e98f3 David Howells    2019-03-25  3546  	if (ctx->seen & SHMEM_SEEN_INODES) {
dc28c12a0e98f3 David Howells    2019-03-25  3547  		if (ctx->inodes < inodes) {
dc28c12a0e98f3 David Howells    2019-03-25  3548  			err = "Too few inodes for current use";
0edd73b33426df Hugh Dickins     2005-06-21  3549  			goto out;
dc28c12a0e98f3 David Howells    2019-03-25  3550  		}
dc28c12a0e98f3 David Howells    2019-03-25  3551  		if (ctx->inodes && !sbinfo->max_inodes) {
dc28c12a0e98f3 David Howells    2019-03-25  3552  			err = "Cannot retroactively limit nr_inodes";
1054087b0658a7 Al Viro          2019-09-08  3553  			goto out;
1054087b0658a7 Al Viro          2019-09-08  3554  		}
dc28c12a0e98f3 David Howells    2019-03-25  3555  	}
0edd73b33426df Hugh Dickins     2005-06-21  3556  
dc28c12a0e98f3 David Howells    2019-03-25  3557  	if (ctx->seen & SHMEM_SEEN_HUGE)
dc28c12a0e98f3 David Howells    2019-03-25  3558  		sbinfo->huge = ctx->huge;
dc28c12a0e98f3 David Howells    2019-03-25  3559  	if (ctx->seen & SHMEM_SEEN_BLOCKS)
dc28c12a0e98f3 David Howells    2019-03-25  3560  		sbinfo->max_blocks  = ctx->blocks;
dc28c12a0e98f3 David Howells    2019-03-25  3561  	if (ctx->seen & SHMEM_SEEN_INODES) {
dc28c12a0e98f3 David Howells    2019-03-25  3562  		sbinfo->max_inodes  = ctx->inodes;
dc28c12a0e98f3 David Howells    2019-03-25  3563  		sbinfo->free_inodes = ctx->inodes - inodes;
1054087b0658a7 Al Viro          2019-09-08  3564  	}
71fe804b6d56d6 Lee Schermerhorn 2008-04-28  3565  
5f00110f7273f9 Greg Thelen      2013-02-22  3566  	/*
5f00110f7273f9 Greg Thelen      2013-02-22  3567  	 * Preserve previous mempolicy unless mpol remount option was specified.
5f00110f7273f9 Greg Thelen      2013-02-22  3568  	 */
dc28c12a0e98f3 David Howells    2019-03-25  3569  	if (ctx->mpol) {
71fe804b6d56d6 Lee Schermerhorn 2008-04-28  3570  		mpol_put(sbinfo->mpol);
dc28c12a0e98f3 David Howells    2019-03-25  3571  		sbinfo->mpol = ctx->mpol;	/* transfers initial ref */
dc28c12a0e98f3 David Howells    2019-03-25  3572  		ctx->mpol = NULL;
5f00110f7273f9 Greg Thelen      2013-02-22  3573  	}
0edd73b33426df Hugh Dickins     2005-06-21  3574  	spin_unlock(&sbinfo->stat_lock);
dc28c12a0e98f3 David Howells    2019-03-25  3575  	return 0;
dc28c12a0e98f3 David Howells    2019-03-25  3576  out:
dc28c12a0e98f3 David Howells    2019-03-25 @3577  	return invalf(fc, "tmpfs: %s", err);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Need to unlock before returning.

^1da177e4c3f41 Linus Torvalds   2005-04-16  3578  }
680d794babebc7 Andrew Morton    2008-02-08  3579  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
