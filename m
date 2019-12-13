Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A385911DD03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfLMELl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbfLMELl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210301; x=1607746301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=13Xj/2Q3e/31YLvSZL3B4rqcPrjvoVC0rWnzkBnhSLo=;
  b=g6fzT0HxB6OgRd2IPfJr/921Eh+kkxDprPHWPzS3qBREmQrqu7IXMjRh
   i8R15xzcYG5Z2k/482qcThUenGYdbmha+VYz17c7ynDjz1X6+1x5muDDy
   3RCgCn/gTSR2xbTzwcDyLvu6rSjHBjivRAk0yAGV8EzyGBMyvW6J/knEX
   7hdo08UAZ2ZiT5aF9pN+tkIkNK5Zk78RRwCGnOn0Xwp/wXSCFlQ+yReG7
   squjdeNxTQploySHkY8UOH71bDBZ9OJHyhSeNsCclaMquDJOjYAqPDwRg
   LY3Yk0kF7rSglxQkRgic8VY/QqSpDjg+1MAbSeNrytuCH+gSjrhjLKimS
   Q==;
IronPort-SDR: oLY0Liw0/7/XLXI6q3gckpQEqaLa2SyKNLaiwvQSmG2gonQfM4Kg2vo5GTjNjLJP6ghDbVNS61
 pYaA75x+s3TWN5Je7wRylcPOxWWbXBZeKhJyLdE8I7b43qiJAfPXuov1E16rY/lvqpqmHcQQo5
 bVdrF8PG3+Y4YDPHNJ23jieYTjmkq4SYFQEFBIf8p0Uob7tJGig00pO+W7Q/f5eO2NSpSaaV7r
 GAbgwt+nWCfvoYUQZeh2shwcbaENuIMJFaTMSNCrYuyRPGWRfRl5chQhvVKgRiGMCHqLLSTA6/
 Rhc=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860183"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:41 +0800
IronPort-SDR: bTNUqjyeB1ScBrt2cNm8bGo4KdAGGhkWzG2lrQDqTk5ymzaESBUJM6EjkJpBe/W8qhd/3PLnsp
 J3fBCzDjrMFy75jDdgA/Mzh/W4tu3aEwCvLCwvQK42Wf1Wh26yOk7lzNRes5YJW+tj+i7BiYrs
 H4+reuP/1DR13TubHCgjsopG2LyJKfxUHntmHm2d/dO5RQiApLwmdsNBgZyJ7NPRHWePSYCYvy
 ZCgwWVKXhffXB29CJTD5NUK/UE23cb9CnuopgjI5Zg2Zhyo3EE9x6hREs4OlI1vTygnSXtmV4Z
 O99B9FEJL3J+nEbjSTQPqvOa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:06:13 -0800
IronPort-SDR: Ud1UygR2smZjObKJolFWCH6HmYv+v3E8fzVq2C75ROmMxXyv2Pr+bL+soCLPbKeT56r0L9/jyc
 R6xlZ3MQ9VbE9HGnCR/A6n4FrFXpRlJhn+zoo9DEpgiefKh5e0Ojlfh2gW+/gZWpT814qSd2Y5
 lx4VQBAg1rRYjjbrkQVmm5zPD6dup6bzKOZc5/YHF+EdA6PoZoWX0f8djmrzW0Cu7cdw5HZvQJ
 LihbLYodJ9BLABcjvHxrt/9PzjBocMH/UA6QGhB71SRVclKIj/YW1kdntKtvSRJm26MSj60y+5
 zE8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:39 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 28/28] btrfs: enable to mount HMZONED incompat flag
Date:   Fri, 13 Dec 2019 13:09:15 +0900
Message-Id: <20191213040915.3502922-29-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the HMZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount HMZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cba8a169002c..79c8695ba4b4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -293,7 +293,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.24.0

