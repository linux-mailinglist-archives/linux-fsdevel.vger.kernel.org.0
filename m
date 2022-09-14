Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80B5B869C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiINKuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiINKuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:50:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3F06068F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:50:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i19so10689148pgi.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LYcxOKu2hY3Ck4lzUI/59K93yUcPpPY2I3tWA+VQB5o=;
        b=aadbHEusxVFO24XXVWyu75Q05FIobqxakoxHouAFdwoxQ+FHrZDSlGzoPP0O4swNXH
         04lGwh4QXhef8MKGYrdZ8AtqRbgoNctImTGvoEZdf1O00zeRfAArnsStWoo9K7I6GnrH
         MOznkgq6WTje0gwqZDfuuD5QsOFQ433jThDTTN1iRE1RXbT979RqvEAUrzp5UHTRsw2f
         U7D6J4yycRG2/MYQJF66KzvrBAf/TkY6dvq504JO39VYTM3eLfTzULSLruFngwzB9uUA
         zvPeN7P9E7KgIUtW0G8oUAP7W3ZDezCw6F48XWb9lnNHDdVhF8dIK2hiBfywJNSwH85/
         p3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LYcxOKu2hY3Ck4lzUI/59K93yUcPpPY2I3tWA+VQB5o=;
        b=xQqUGh2B+R1osAbJ74Plw9B/ulBQexjI41ov/LtO6zkCTDdQpFDEJ8qgMslgh0HXff
         l3mvs2rrOvTljbThlqLZrRV0K5+u+K+lLLE/OtDs0C1dXVQVmAsaJ6xSJ0QwISxzskPM
         luxk1FFC46sdY5QXQey7PlI3LTZ+n6K+iSpsm/IUiNa4lEasY+K/aiKgsDKYiRW0g4xV
         2yOWc/AdkNuYmiv/5UoDciSjF/+BThgVnBjb9m1/jQwFJ6SQbEki+e5K4VxIfY8K50kp
         mVsBlRpB+cEogaEu9t/C4RPuNHp6N+EKcSM5VtQPEBE+zBY6LNurLVE7LEDrg2kh9zLs
         FZDQ==
X-Gm-Message-State: ACgBeo3uQpJjHNJVY7TaTRQb6H5Tn+4FUuJ8fgwhqCk6RG+aQMzLvWGP
        T4+k/41BXv/Ow53wplpPEntKvQ==
X-Google-Smtp-Source: AA6agR5UmOf8xiYOHDqG2HuC3BnGe7b3tZudyHKgr1zTMddExE1WruGJK+GWTYLKlTmiP1Nvqkaxfg==
X-Received: by 2002:a05:6a00:f86:b0:547:6910:4ae0 with SMTP id ct6-20020a056a000f8600b0054769104ae0mr3316718pfb.5.1663152650260;
        Wed, 14 Sep 2022 03:50:50 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:50:49 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 0/6] Introduce erofs shared domain
Date:   Wed, 14 Sep 2022 18:50:35 +0800
Message-Id: <20220914105041.42970-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since V2:
1. Some code cleanups:
   1.1 Optimize the input parameters and return values of some functions.
   1.2 Only reserve a pair of function declarations for fscache related codes.
   1.3 Remove useless null check.
   1.4 Replace some ternary operators to make the code more intuitive.
2. Increase the granularity of @domain->mutex to a global lock.
3. Adjust patchset structure and order.

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v3
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v3

[User Daemon for Quick Test]
============================
Git web:
	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain
More test cases will be added to:
	https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache 

[E2E Container Demo for Quick Test]
===================================
[Issue]
	https://github.com/containerd/nydus-snapshotter/issues/161
[PR]
	https://github.com/containerd/nydus-snapshotter/pull/162

[Background]
============
In ondemand read mode, we use individual volume to present an erofs
mountpoint, cookies to present bootstrap and data blobs.

In which case, since cookies can't be shared between fscache volumes,
even if the data blobs between different mountpoints are exactly same,
they can't be shared.

[Introduction]
==============
Here we introduce erofs shared domain to resolve above mentioned case.
Several erofs filesystems can belong to one domain, and data blobs can
be shared among these erofs filesystems of same domain.

[Usage]
Users could specify 'domain_id' mount option to create or join into a
domain which reuses the same cookies(blobs).

[Design]
========
1. Use pseudo mnt to manage domain's lifecycle.
2. Use a linked list to maintain & traverse domains.
3. Use pseudo sb to create anonymous inode for recording cookie's info
   and manage cookies lifecycle.

[Flow Path]
===========
1. User specify a new 'domain_id' in mount option.
   1.1 Traverse domain list, compare domain_id with existing domain.[Miss]
   1.2 Create a new domain(volume), add it to domain list.
   1.3 Traverse pseudo sb's inode list, compare cookie name with
       existing cookies.[Miss]
   1.4 Alloc new anonymous inodes and cookies.

2. User specify an existing 'domain_id' in mount option and the data
   blob is existed in domain.
   2.1 Traverse domain list, compare domain_id with existing domain.[Hit]
   2.2 Reuse the domain and increase its refcnt.
   2.3 Traverse pseudo sb's inode list, compare cookie name with
   	   existing cookies.[Hit]
   2.4 Reuse the cookie and increase its refcnt.

RFC: https://lore.kernel.org/all/YxAlO%2FDHDrIAafR2@B-P7TQMD6M-0146.local/
V1: https://lore.kernel.org/all/20220902034748.60868-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20220902105305.79687-1-zhujia.zj@bytedance.com/

Jia Zhu (6):
  erofs: use kill_anon_super() to kill super in fscache mode
  erofs: code clean up for fscache
  erofs: introduce 'domain_id' mount option
  erofs: introduce fscache-based domain
  erofs: introduce a pseudo mnt to manage shared cookies
  erofs: Support sharing cookies in the same domain

 fs/erofs/fscache.c  | 252 +++++++++++++++++++++++++++++++++++++++-----
 fs/erofs/internal.h |  30 ++++--
 fs/erofs/super.c    |  72 ++++++++++---
 fs/erofs/sysfs.c    |  19 +++-
 4 files changed, 321 insertions(+), 52 deletions(-)

-- 
2.20.1

