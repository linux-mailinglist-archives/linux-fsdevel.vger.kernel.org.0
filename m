Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7E33CAD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 02:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCPBSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 21:18:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17677 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhCPBR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615857477; x=1647393477;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9z0MvJxcXTtlfhgD1wYLBN65iBgDpLkkpdsBrh1lyBs=;
  b=Q+28cUbyYPqA0HACJs2qkEK6dcuIa7pwfJYhc9pMElCGZ+tJIeAGruZy
   4hC9vRViyDzwyIQgF1cV9yVJPKeruN8kSsFYqUml+z4uiMvHL/uELyeF7
   76FmldAw8HURpRvbvaJoaeSQGXOKfmudJDgcGndt5AP133p0Igy5FLqii
   5hiFiVnsgUK8szCmm3Pbg6joT/iLpADUa/jJhyAehygXZwFYXQnB7A5SA
   aCMEkkmKXbJs6WA2/IcGi33S8VMwwihD4jGMu+AEMgBkHu/16CbCt9x4A
   FDdeE5X7xTi4UPNRLzAvmrulVwbdrgy8CbvtEDIlFSotWKn/UsLWQhgMi
   A==;
IronPort-SDR: SlSdrt7vkD+dQBUivh62qAfxnMR4oUsJl8qm6jW4Lo6CxA2xc20ru+dF7Iba0niiSmxyBRug60
 Zk9/LycD4ROveeK+UKjcJIMZUfbKu8i4lglNrk8rTS2rX/qbJy1lCfLe8pv1iuKaHHVw5PjDAy
 qpvfmlZsFWHKVxuPoMb3aJ/Rmr02ZU8yY4wdYUUeqZgxjLys+oCVWorFxTQ39OoB8j+IiYndyu
 kgE+EFIjR/XRh2WA8DoSJGPcaItgrZ04yzIACfwaFDsCh8MaPYn1T1HVUO7AVhVvuf9GTAptW9
 3us=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="166702694"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 09:17:57 +0800
IronPort-SDR: RUadaf/7LgtBovm7viKqeziTlSejz/8o6Du1kpbAEgN+Rvf/3I9mE4nm8mbAvzmP8+ME12gGPU
 MtlLMuFMEW4yS0wAYgjKFTYnAXsEH6rTB3Y4RB/sdABJvQDEdFBqZPB+GzdCkOpbRXTkZUOccf
 cfuKBhcr7ClpQpyLIV48g4yZANGMJ6YJt8HTH20GZZAqZzGFt16tyPRZKqyCpDvcDCtCyycng6
 /ruspP9UoR0Dtm8aOsGygXGsySBYXBQnN+agFM/ioSfG+K5sAVABcOtpwyuBJPYgJLOK4g0lIQ
 Em0ck9aIt6kVjU8mjG3iWvax
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 17:58:34 -0700
IronPort-SDR: iilD0uqOKfHHL2fgw8+e9PtT1acKkNG81fSDOPQfzbO30CeIHDQE+4/JwX3fib8m19nCBm+VI2
 E5R1FZGVR79hDsH2NI1QOcnil5LLqD5tcpUtCOOx/ic8iUeP8KCAYw29+0eM8HP11qo47uv2bL
 7qSVLX8CBp8XpSvIDAXYdQsdm/Li3cv7jS88OgCXLDJ3vPDwnwRytrORjGFA0o+ur1Zy2oUtq0
 npUvcRPh4B1BTUGNm0CwZX9CPvdvA70vLac1bjn4d9iJajMxZk10Z7151IKtXZXVZwM6zsKpCP
 SLY=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Mar 2021 18:17:56 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] uapi: fix comment about block device ioctl
Date:   Tue, 16 Mar 2021 10:17:55 +0900
Message-Id: <20210316011755.122306-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the comment mentioning ioctl command range used for zoned block
devices to reflect the range of commands actually implemented.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/uapi/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..4c32e97dcdf0 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -185,7 +185,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 /*
- * A jump here: 130-131 are reserved for zoned block devices
+ * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
  */
 
-- 
2.30.2

