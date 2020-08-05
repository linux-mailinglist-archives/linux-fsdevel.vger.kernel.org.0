Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4609323C7A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgHEISU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 04:18:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:18340 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgHEIST (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:18:19 -0400
IronPort-SDR: rpXm4H6gbrKxtp3SskOrATkoJwzdIPJT+vkoAKcVYVdPRdmp+1DFMfptnxN9kkv2lI6TFcRarH
 RR0IoI6bUnSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="214022895"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="214022895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 01:18:19 -0700
IronPort-SDR: ASmk9kk8VKanGzp/ne7r+C1ASc9zeMFeRoVPS6SNGsa2QzXGGqLJUV5LHLGkmZr0ZObCBMNF6s
 78HgUHq2jw0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="396846698"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2020 01:18:16 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3Ecp-0000fU-Ge; Wed, 05 Aug 2020 08:18:15 +0000
Date:   Wed, 5 Aug 2020 16:17:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: [RFC PATCH] fs: namespaces_dentry_operations can be static
Message-ID: <20200805081750.GA61141@34299a1dbcdc>
References: <159611041929.535980.14513096920129728440.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159611041929.535980.14513096920129728440.stgit@localhost.localdomain>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 namespaces.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index ab47e15556197..63f27f66a96a4 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -182,7 +182,7 @@ static int namespace_delete_dentry(const struct dentry *dentry)
 	return 0;
 }
 
-const struct dentry_operations namespaces_dentry_operations = {
+static const struct dentry_operations namespaces_dentry_operations = {
 	.d_delete	= namespace_delete_dentry,
 };
 
