Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9994B35A454
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhDIREZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 13:04:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:11836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhDIREX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:04:23 -0400
IronPort-SDR: zZDtX4wESFRLub8mF4iK65U+DBtsP15tVmwRu6ihLStvJUFjx42fsd75AYJyLS4o+KQvZnI1hz
 tIb3LpCt4skQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="214239727"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="214239727"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 10:04:10 -0700
IronPort-SDR: dnbxdqsiG77/wixzH5lWqnkRiWMQI07zEGBf32N5e8CWUR4MoeLD8bYXSM7kIDDrsUtxceCl4G
 leaS+eu3V8HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="459297461"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Apr 2021 10:04:05 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUuY9-000H6a-5K; Fri, 09 Apr 2021 17:04:05 +0000
Date:   Sat, 10 Apr 2021 01:03:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: [RFC PATCH] __dm_attach_interposer() can be static
Message-ID: <20210409170341.GA6890@00727235a09e>
References: <1617968884-15149-4-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617968884-15149-4-git-send-email-sergei.shtepa@veeam.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 dm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 04142454c4eed..2a584c2103f3a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2679,7 +2679,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	return r;
 }
 
-int __dm_attach_interposer(struct mapped_device *md)
+static int __dm_attach_interposer(struct mapped_device *md)
 {
 	int r;
 	struct dm_table *map;
@@ -2721,7 +2721,7 @@ int __dm_attach_interposer(struct mapped_device *md)
 	return r;
 }
 
-int __dm_detach_interposer(struct mapped_device *md)
+static int __dm_detach_interposer(struct mapped_device *md)
 {
 	struct dm_table *map = NULL;
 	struct block_device *original_bdev;
