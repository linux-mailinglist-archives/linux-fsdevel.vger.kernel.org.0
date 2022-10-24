Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2690A60B4B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiJXSCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiJXSBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:01:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6F256D3A;
        Mon, 24 Oct 2022 09:41:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l14so9896467wrw.2;
        Mon, 24 Oct 2022 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OA/Z9xCdVitKa7txwUGEIh39zKNcVwd7tmN/SLXpQyA=;
        b=Kr2odBPfaREIMS89TUOgxkHuPnSExeykas2gFXBgZOStedVK12KnyzY1LPGBRl6X00
         IPrTasbyQy63eICFRMKdpyJfLHxam+vEK5vgp3yvkUb4YpVdy+KAmWky4IEboFRkx1lC
         Oz/L5atsAH8NTlZh4DUgFCdW75bH7V11F0mj77yB8jSsS0fFdACjaIOKqpLlHGP7tSXm
         5LJA2MSZXoA4j/6EtgCvbUyKNDQ/P6BOBdWxJec3BYFsjJpeN7OOmCdxMTz3Ip+um/5u
         viVBqKZXgAnvH+Dqp83aKuYe37IdhUDvzpWglB4/bWSKro1JJzgHuwBJRINcFJutHqXv
         qmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OA/Z9xCdVitKa7txwUGEIh39zKNcVwd7tmN/SLXpQyA=;
        b=0eWx+8N7ky3B7/K839MdV8FWCxaHA6lsiWu20rxlGtLcBwT470mHifA3kt7GblOsWz
         w/Iuc1rRnCpWlUTNv1lmeRtZykrrhMbJvPHn9qdBEBZvOv+JDgmA5zue78YLeEOL1+sn
         nlYo7GzcQ64zg65mzG8wd++vtRvGFyHLPi21T/mWXzU9VxOzXPJXbNicSnJseAieZ7vx
         B1nThBWasa8QZ/jNISavCXVVtiUTnF906ZQWDh8gzlu/WAGPLBN/Jv5vWT6ahq3LsLXv
         xkpmJ3mQKZXFL0rz/xuVywqhW3RMjacmMNI3VypEHk6WXbW4MfxS9iTokNMxUsfw75iK
         G7Xg==
X-Gm-Message-State: ACrzQf1h9WbNxsuXLEsGELqGzzQbEL3n0GQuMZf932al2M/DIPH4mQ1S
        a5fKLtn7FNIraP1VSBauoKA=
X-Google-Smtp-Source: AMsMyM4A3e0RORb79M5v8LbwGkHK/i0MGxreVgtquUzRG4Tj6y6bxhMLYNifPu1ZmfsthLtnSe1g+g==
X-Received: by 2002:adf:ed41:0:b0:225:3fde:46ea with SMTP id u1-20020adfed41000000b002253fde46eamr22223742wro.345.1666629613139;
        Mon, 24 Oct 2022 09:40:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p5-20020adfaa05000000b002366f9bd717sm145161wrd.45.2022.10.24.09.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:40:12 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vboxsf: Remove variable out_len
Date:   Mon, 24 Oct 2022 17:40:11 +0100
Message-Id: <20221024164011.2173877-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Variable out_len is just being incremented by nb and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/vboxsf/utils.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index e1db0f3f7e5e..7f2838c42dcc 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -439,7 +439,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 {
 	const char *in;
 	char *out;
-	size_t out_len;
 	size_t out_bound_len;
 	size_t in_bound_len;
 
@@ -447,7 +446,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 	in_bound_len = utf8_len;
 
 	out = name;
-	out_len = 0;
 	/* Reserve space for terminating 0 */
 	out_bound_len = name_bound_len - 1;
 
@@ -468,7 +466,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 
 		out += nb;
 		out_bound_len -= nb;
-		out_len += nb;
 	}
 
 	*out = 0;
-- 
2.37.3

