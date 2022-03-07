Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7CB4D0279
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbiCGPIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbiCGPIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:08:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D32FFC7;
        Mon,  7 Mar 2022 07:07:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso71239wms.0;
        Mon, 07 Mar 2022 07:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/KGskNCElFlx9hP2T2sOELL9k2U6uGlQbATzaJwwdo=;
        b=k80UYM+tUm816dF5wxKmo1tLClMuSsc93kymU/e7vEIS+9XTutUIdalNnLVCV+q6CI
         zHxQcAXWvyBntZu1oIJGpwV6VUgit72aFs1htSxIWietf4hmhzGZSdBq7JiVkIMjTwW8
         2Kme7AdBvF67RYrPk4R8ULCv02zRXq6D4ubTURAfSP/jNzAUtUzZ+Enq24O+MFUiyYVS
         PRxBQl3TbP+k9LmUDSEfY9mNAvOdOrRfPn1oZE8yFjEC0GzpoA4I5/2mYG82QEKDkWlL
         ow36AXr/xKHEFVYRSL2NK62iqZUFBof0+H3RC60XMf0yjFBjyCdNNtWTY3LFTpT+vfNF
         f/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/KGskNCElFlx9hP2T2sOELL9k2U6uGlQbATzaJwwdo=;
        b=xboaccij19UzN5PB6C5N/3XCwfq3o6w/SJv9y6rVrfR4xsrOgggc8PztifoOuy4oKU
         25k+jdCb5beZonnCju04cZYVpsqin2MvwgjQaiq/rPoPtryfIIO722wGAfYBB/TvyMSs
         EsCmEpqpC24nEufr4b7OaOM0X0X1Kh/ZDrQBt+hqNwvtKz/tGWdgmAtIYUrwq4d0CSrW
         N9QzURh+Dusx4Y81pyZX37sHk5aBa1YNuf+L43MtbR1FCj5U8eoXXOx3nd2NmAdrj8Do
         +3yejU3znMjARCt4+W2PK3L3XNTEHask444HUPphuWfMTjjIOahWe38QucTKf69vYWey
         kYtA==
X-Gm-Message-State: AOAM530i17kUY8D2Vw4WNTQuJEZxFUEwRhJVsdjpnExPGTinF7byV56Y
        AtS1j+1e8PVVaotphP/pZHbPltXVFmc=
X-Google-Smtp-Source: ABdhPJy+VPLJ4gytCHsbhvLHzMzxNmYwK+e15gs5Cf90dhSycACJdfehjDEF98JWYsD5UlKHqM1U4w==
X-Received: by 2002:a05:600c:3486:b0:381:65ec:f8ed with SMTP id a6-20020a05600c348600b0038165ecf8edmr9344371wmq.68.1646665663605;
        Mon, 07 Mar 2022 07:07:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d554b000000b001f0326a23ddsm11802127wrw.70.2022.03.07.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:07:43 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/affs: remove redundant assignment to ch
Date:   Mon,  7 Mar 2022 15:07:42 +0000
Message-Id: <20220307150742.137873-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The assignment of ch after subtracting ('a' - 'A') is redundant and
can be removed. Fix this by replacing the -= operator with just -
to remove the assignment.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/affs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index bcab18956b4f..a1270deba908 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -19,7 +19,7 @@ typedef int (*toupper_t)(int);
 static int
 affs_toupper(int ch)
 {
-	return ch >= 'a' && ch <= 'z' ? ch -= ('a' - 'A') : ch;
+	return ch >= 'a' && ch <= 'z' ? ch - ('a' - 'A') : ch;
 }
 
 /* International toupper() for DOS\3 ("international") */
-- 
2.35.1

