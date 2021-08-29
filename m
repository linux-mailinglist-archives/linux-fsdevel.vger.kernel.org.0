Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B791A3FAE9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 23:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhH2VHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 17:07:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:43494 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235370AbhH2VHG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 17:07:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="205393052"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="205393052"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 14:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="539931308"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2021 14:06:05 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKS0D-0004aG-99; Sun, 29 Aug 2021 21:06:05 +0000
Date:   Mon, 30 Aug 2021 05:05:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>,
        hirofumi@mail.parknet.co.jp
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Subject: [RFC PATCH] fat: msdos_ncache can be static
Message-ID: <20210829210537.GA61694@74a5018f4101>
References: <20210829142459.56081-2-calebdsb@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829142459.56081-2-calebdsb@protonmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/fat/namei_msdos.c:37:1: warning: symbol 'msdos_ncache' was not declared. Should it be static?
fs/fat/namei_msdos.c:38:1: warning: symbol 'msdos_ncache_mutex' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 namei_msdos.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 7561674b16a22..f44d590a11583 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -34,8 +34,8 @@ struct msdos_name_node {
 	struct hlist_node h_list;
 };
 
-DEFINE_HASHTABLE(msdos_ncache, 6);
-DEFINE_MUTEX(msdos_ncache_mutex); /* protect the name cache */
+static DEFINE_HASHTABLE(msdos_ncache, 6);
+static DEFINE_MUTEX(msdos_ncache_mutex); /* protect the name cache */
 
 /**
  * msdos_fname_hash() - quickly "hash" an msdos filename
