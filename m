Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86991621
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHRK3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 06:29:07 -0400
Received: from sonic304-23.consmr.mail.gq1.yahoo.com ([98.137.68.204]:43026
        "EHLO sonic304-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbfHRK3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 06:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566124146; bh=Kq3kG4vAUTdrMObVCPRyVFAuMwHfmEs/ZHn6FCCJbTg=; h=From:To:Cc:Subject:Date:From:Subject; b=T8LPYUxiK2xlJg2Fy5rLX2tujh8JLR7y/ZFfzKeBxK5Vqv6MzRURmAYMLgjzqwOnlJG9qLVt7NIDAtD3hkjmy1iOnMPlsnr9kdKJwFNilXyMkQJhVAmBAHcctzr3xumZm9qZS/9zA/3Um5TAvwbxqmW2UINFuvklkEwYG7RCcPETJ8autuhTRwpWCP6SNjcGGZ53KnV83avOWr8DADUmBf9Oc9vbdFj25cTMKjOMR8oUHDizDE4KkpqlSBPIX/VrNiiNNvNz43ZoPjN020c6aYnIJAXyEy/1PPQEADD5Z/z9WFRcHbS/OABwwUxWx5nXBqt/d/o3RBmUYnvtWyKd4w==
X-YMail-OSG: R9wyiRIVM1nJGeM4ooCmnAtiGCARjGMIdIm1Jn9dPh1eVJPW3qpdky8oSNJjDE0
 HOyc0knEDE2TAjq.rXJlci4YH6wD6ru6hIgqrxW0y77V1j7q0IwYyn2Bv_ZskOT9XG2MQ2Jt4MG0
 wQ07vLlF4HlH9vX5A91rdH8hCNhHfckm6iMibhglR91BAvJqqDeJSjwHkhG4O1yA_ndTdVxV2u1N
 lF40I1bKXwa0hf5O4JzyCVNd5Zm3pXntP8NW9qbe.kaOQQ.m.RadUdcJXJ2S76C.lHoR9sev4oOQ
 TBVrro.QpBPJ0DCno41OSjXUkYAvV.6KRpsl.gsPMuDDfUU38I3F7UKUxsCJMRQdMeNqXiDmlMcW
 zTw8e6NWn7iCXClk_HUJUY4LTw7pxDECUTRDdpbpSY0xd7G9FFBEyEdZcq8te2MvIRXOmPtFtGcK
 rL0_i2APUkb0gh9y9_rVx8Do2Z_UzN.ppZfupcCteCt9WKYf80oxz_NgooLH2kEQ0ydjgdxgxauj
 rh7o2OG.pMEAtaIy2KK5_gfRvtHJnhxgMscNJfPf9Nnz3x8L39NUHJDybtHlZ3X7LhcYNJYhyeiz
 NdbVvYUuz6HcXFyomsAocpVLOXgQQGXwqPskUQ4kXnRUyFKZxSDH9Y1M0MNxQ3fE_de6.hTrE6Ho
 Y_MKIH.PzIzwqVDGcOFeAzv5R2ALfzW4bOf_Ra1WJoiTsMYhYJufwKR712tFj0DzuJoEhPoMhd2I
 dsJV_JolkLNvu5fVpVYetPXe1NCDqKVXnViveAt2_0OR3r5KH3ivFNFxS.G_Gma9xt1flbC8Ne5z
 zqgYaY1LjvMEGa0DMzL_JVumpxecmMTZIYjPNHQIuHL2axCE_E63PKkZyS3IBZ.6kvgS5e7XQw7M
 p_0GpOoC9IpfatckJlUYcXK1fDxy0tWaCpWMdajCBQJ..rP7c5kHc_FR4mu8RikCGw3UQC.BrRyf
 Si.zmdQPpf6pUrj._60UCeLL873ryJHA1zldmGduuw1y3VDW.CVGJkxJdaRrrT7KPkz_xjgYiVc.
 HvIkE0iFlJ2U_3wqNKhDSt6qJsLCx.dZDTnoQppqmzjlwV1mSJm1wkwh2PdTdmpzb2yByPgcLzeG
 wVe8vniVbvuyv2EjzIM8tPAU.LFD_ij6ttz.e.kvDouRrHk1Dd3nYHy4HQJNRTC3qbtDG7Gh07rp
 VAhd.0QU1mvNr17rB4F23WcQaBguJDpr15LzAXQjRC5I8iSqiil6mON10eiqI81Op97Wrs0w_O7R
 WeWtgvLl4yXNq98DmdQyQfa0qjtCxEqz0c6asPnA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 18 Aug 2019 10:29:06 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2725d0128178f453485924e8f1102a96;
          Sun, 18 Aug 2019 10:29:05 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>, Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: refuse to mount images with malformed volume name
Date:   Sun, 18 Aug 2019 18:28:24 +0800
Message-Id: <20190818102824.22330-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

As Richard reminder [1], A valid volume name should be
ended in NIL terminator within the length of volume_name.

Since this field currently isn't really used, let's fix
it to avoid potential bugs in the future.

[1] https://lore.kernel.org/r/1133002215.69049.1566119033047.JavaMail.zimbra@nod.at/

Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index f65a1ff9f42f..2da471010a86 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -131,9 +131,14 @@ static int superblock_read(struct super_block *sb)
 	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
 
 	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
-	memcpy(sbi->volume_name, layout->volume_name,
-	       sizeof(layout->volume_name));
 
+	ret = strscpy(sbi->volume_name, layout->volume_name,
+		      sizeof(layout->volume_name));
+	if (ret < 0) {	/* -E2BIG */
+		errln("bad volume name without NIL terminator");
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ret = 0;
 out:
 	brelse(bh);
-- 
2.17.1

