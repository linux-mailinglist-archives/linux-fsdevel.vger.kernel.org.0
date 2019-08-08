Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C412F85E72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfHHJbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732202AbfHHJbs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256707; x=1596792707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84iCM2QxAe3BvyMZ1HFkjly71xFGsV5zPKdATf5w8MI=;
  b=YWY4DYuaKk0JWlWJx3BTGakabQMxmvOrFgX3dLg5m+Z+9eMlOfs6nU58
   LjZAFBNiPzv2s444ZpXaiGXzlD32KNJLd4+SRQDPv2ZPGAxXYkvnVwSWL
   cXQV6FIrQCgZ0L3mXKoiXmWaDakeMNjg8rfvFJ97fUTjLY9UG63df8RGl
   2zdDFZeJLl5ryTNuee1c98kLqdXCwrAqen9J3PHJC1iSXPcstvlJLyrxf
   j8QGnIhJHsrkndMyEDdQRx5KLY8sa7I4bG7TYgv5gTBNhnac5WvKv9Ks8
   hJCXdf+I2HcUYg+ulVaCu0+FQpMbWK6R3C5doS5t31hTxDFIBpLdtxCks
   g==;
IronPort-SDR: n0EpGsSMpcUlm+u/wBWAZvpw3vgugDLtRxiS+DK+sbk/9LVIgy+UDDjYwk/9Ek0JZFsB6rfSCm
 /D8oVDMkn8xYYClZE53I1TYe54pZK7XIF5RO1gKSiELG9zKrOJmgB2rUAIw+PGUCuGwvxki4Kh
 WFlQfnQtWH+f3ts/XpE8+7sPdozK6hbGRFFpBMebeajnmSDMTmgf1vQT15lzZmdDVFU+x+YxqL
 IwG5tSARs02n42WYRkB6Kyr+Iz1QoEtj83HGfxEyxhYzWA8GV4hXKTHP3TSbNa+ZdVqIRU9MYh
 TTY=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363394"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:47 +0800
IronPort-SDR: dckxEebWhcvrY3dcKettyhUGB41fhOK23EnIDlNs1w1k2Wv6tvvZ0kSUIOoIG30PfjB822rgNN
 QyTmTXkg4jzSiatYQpgd/6iYJdoQWsHqok06uSg4yhVWHq7zPtMsr5Cto0acvRHdT1p7dajIpf
 DXhQSkn+/YyZsGAEjd2SwvSdzQITP51MfLt38CNPxmAZNgIC/tmpovJYUIS3AjRdRAKG29yK+G
 mnW5d3jpKVN/HggqouLjXgFpD6wb2e0Mnb2a/yCmvfPURvAXks+ZjTxyX+xNYJgLKJ9106hCiQ
 y8499z10ZUWf9nPaTIWoI3++
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:31 -0700
IronPort-SDR: JmzZlMkNESd5XX8l2Bt+KoQLj68z+hn9uDjUNW16vRo7XdKaEeNcmbn/hOgfaIUhyWunoNQ/eW
 3nVoywTudUU2yPYnjFATU/E9urSHiP/SKjSqZes3DAGoiZgVffLVLHGYBuxqKk675L441n9JkJ
 DboAiofFNCKdB9Cr8hULMExG2mSZbGIWotEov6Z0wl6HWHChe4wQSrFHfR+vIphfsTngMfq1qR
 EvWvfmBncEb5NT/HLvvIXZJRGPgFtdYzvtu4b8fACIFdjb73ZuEtCPzLgsSGENJXjTpip3vY01
 5Eo=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 18/27] btrfs: support direct write IO in HMZONED
Date:   Thu,  8 Aug 2019 18:30:29 +0900
Message-Id: <20190808093038.4163421-19-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As same as with other IO submission, we must unlock a block group for the
next allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 283ac11849b1..d7be97c6a069 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8519,6 +8519,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	struct btrfs_io_bio *io_bio;
 	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
 	int ret = 0;
+	u64 disk_bytenr;
 
 	bio = btrfs_bio_clone(dio_bio);
 
@@ -8562,7 +8563,11 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 			dio_data->unsubmitted_oe_range_end;
 	}
 
+	disk_bytenr = dip->disk_bytenr;
 	ret = btrfs_submit_direct_hook(dip);
+	if (write)
+		btrfs_hmzoned_data_io_unlock_logical(
+			btrfs_sb(inode->i_sb), disk_bytenr);
 	if (!ret)
 		return;
 
-- 
2.22.0

