Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB0149C53
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 19:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAZSaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 13:30:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:6046 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgAZSaz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 13:30:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 10:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,366,1574150400"; 
   d="scan'208";a="228785343"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2020 10:30:27 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ivmfz-000E7W-Gx; Mon, 27 Jan 2020 02:30:27 +0800
Date:   Mon, 27 Jan 2020 02:30:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: [RFC PATCH] ubifs: tnc_next() can be static
Message-ID: <20200126183001.dimlxbpzerc6fjiq@f53c9c00458a>
References: <20200124131323.23885-9-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124131323.23885-9-s.hauer@pengutronix.de>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Fixes: 7eb604185a12 ("ubifs: Add quota support")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 tnc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 624568365ad3d..188fa036e6556 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -600,7 +600,7 @@ struct ubifs_znode *ubifs_get_znode(struct ubifs_info *c,
  * This function returns %0 if the next TNC entry is found, %-ENOENT if there is
  * no next entry, or a negative error code otherwise.
  */
-int tnc_next(struct ubifs_info *c, struct ubifs_znode **zn, int *n)
+static int tnc_next(struct ubifs_info *c, struct ubifs_znode **zn, int *n)
 {
 	struct ubifs_znode *znode = *zn;
 	int nn = *n;
