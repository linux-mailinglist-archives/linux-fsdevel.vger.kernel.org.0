Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD46D5AA976
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 10:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiIBIIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 04:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiIBIIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:08:02 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AD99B7776;
        Fri,  2 Sep 2022 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=geMGW
        HtVXqDG7bcKU0V9M+d902V0xBjLtVwQc+DtB0k=; b=khJFcYMM7cNbrVqZ3gZdA
        UeH/5Yy7ru17hCOVpK8H/42N4nb1u4MvHX55hk8GueHEI3o8PkA40Bh8Qry5MTyK
        UXvEt6J7idViZFGtETvZO5ynWbxQ3AgEbT6bOzcJt/bn9ley5Fo0VIhz+aEr/CUY
        ZOj3KlwmeuWbWHoeDJRRbI=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp4 (Coremail) with SMTP id HNxpCgA3YtLUuRFj+4I9Zg--.5745S2;
        Fri, 02 Sep 2022 16:07:51 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] fs/nls/nls_euc-jp.c: Fix spelling typo in comment
Date:   Fri,  2 Sep 2022 16:07:38 +0800
Message-Id: <20220902080738.1807198-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgA3YtLUuRFj+4I9Zg--.5745S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4rGr1UAF1rtry7Xr45Awb_yoW8Jw45pF
        n5uaykta1DAr12qa4Yva1xGw4DJ3yvqF4jgr1jgrWrAF9rJrnIq3Zaq3WxCwnFyF4rKay7
        A3s2yw13Xayjgr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGtCcUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbi8A1o+1uoh9WV9AABsv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/nls/nls_euc-jp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nls/nls_euc-jp.c b/fs/nls/nls_euc-jp.c
index 162b3f160353..64ea8bdb596b 100644
--- a/fs/nls/nls_euc-jp.c
+++ b/fs/nls/nls_euc-jp.c
@@ -15,7 +15,7 @@
 static struct nls_table *p_nls;
 
 #define IS_SJIS_LOW_BYTE(l)	((0x40 <= (l)) && ((l) <= 0xFC) && ((l) != 0x7F))
-/* JIS X 0208 (include NEC spesial characters) */
+/* JIS X 0208 (include NEC special characters) */
 #define IS_SJIS_JISX0208(h, l)	((((0x81 <= (h)) && ((h) <= 0x9F))	\
 				 || ((0xE0 <= (h)) && ((h) <= 0xEA)))	\
 				 && IS_SJIS_LOW_BYTE(l))
@@ -522,7 +522,7 @@ static int char2uni(const unsigned char *rawstring, int boundlen,
 				MAP_EUC2SJIS(rawstring[0], rawstring[1], 0xF5,
 					     sjis_temp[0], sjis_temp[1], 0xF0);
 			} else if (IS_EUC_JISX0208(rawstring[0], rawstring[1])) {
-				/* JIS X 0208 (include NEC spesial characters) */
+				/* JIS X 0208 (include NEC special characters) */
 				sjis_temp[0] = ((rawstring[0]-0x5f)/2) ^ 0xA0;
 				if (!(rawstring[0] & 1))
 					sjis_temp[1] = rawstring[1] - 0x02;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

