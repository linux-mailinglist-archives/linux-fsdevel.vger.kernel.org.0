Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F21F73E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 08:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgFLG3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 02:29:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:53559 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgFLG3S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:29:18 -0400
IronPort-SDR: 239C5Koa8YcKXBn6qRcIcBVu/y8VS8iPKgcv1HvbBe0n+NbApaEG4MqFkOnTX7el80OHQ5b3Z/
 XdfL8VG4SvcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 23:29:17 -0700
IronPort-SDR: GMfc7prak4JwHsRsrqnpLwU0QAgkwC1yomNRqgj1goocw8fVEm5urgtPANX4VNrH87aLMEiGjP
 fuQbXW5gN5pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="scan'208";a="474098231"
Received: from lkp-server01.sh.intel.com (HELO b6eec31c25be) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2020 23:29:14 -0700
Received: from kbuild by b6eec31c25be with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjdBh-0000ZX-Qb; Fri, 12 Jun 2020 06:29:13 +0000
Date:   Fri, 12 Jun 2020 14:28:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [RFC PATCH] hugetlb: hugetlbfs_file_operations can be static
Message-ID: <20200612062853.GA35019@0619708f5df1>
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612004644.255692-1-mike.kravetz@oracle.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 5c0c50a88c84b..98d044be8a5cf 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -41,7 +41,7 @@
 
 static const struct super_operations hugetlbfs_ops;
 static const struct address_space_operations hugetlbfs_aops;
-const struct file_operations hugetlbfs_file_operations;
+static const struct file_operations hugetlbfs_file_operations;
 static const struct inode_operations hugetlbfs_dir_inode_operations;
 static const struct inode_operations hugetlbfs_inode_operations;
 
