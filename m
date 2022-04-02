Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75E4EFFD0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349511AbiDBItq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiDBItp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:49:45 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16781AA8F1;
        Sat,  2 Apr 2022 01:47:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id 10so3972230qtz.11;
        Sat, 02 Apr 2022 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fsubz5SlxAuGM72VzibPMlOmxFez1kWGrcQSufu8qOM=;
        b=IsmaR8ABleRm+6oVe1mXzrlLfe3Bw4vh73ABlIp1KaXMC5Nwfxn+4XU94FiEQnS3gI
         AiINyw49kmdfDR9pziKbUf3jP4S/0Mlk03KDKQUCajsPA/wyw9JBAyg9EqkWQ+0AXKWs
         MbVNgVM/JU9d/d+N/VAJ0giIHkUX7ry1WaqZpCxy5+dsxxiribXc3jjyrXQCsIAlIHPh
         yP204MCS660glqc2IV4YfZ8ywvLwkcN9AxhlolvokhB27PlL4iQltqUaC2MjLGZRNssf
         hS05niVcV0jZT7nPnoC4Ns/hfENGD6CVO2Iv804tMpeSkVlXUeVtjDhIy+gyW5Br10tU
         B+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fsubz5SlxAuGM72VzibPMlOmxFez1kWGrcQSufu8qOM=;
        b=kfZ/xxoeHbbaPZlqdJ7YURKcOrt7uQm3VNMBHSwBYR8ELcMwUkPPieAfc4Wd/pET8W
         yTX4rMGz3W0KbFzfFdX/C5K721o92RfsJHJCE2Y+BMErjNVakdE64WUpcGS4fvVxkHL5
         DlinNIqdOmiXIFt62jiz+QLmV3zaTOQbQ5dsUyGp2xNCbiejVbW9/XXvOlfeMsYnr/A/
         JloZ/bgAg4IdiYxZqdThSPLGfastju8i9EccsEy/VbTgH7UcYtB2g3lf1d5lSX4MJVqx
         8XNVvAcXfjENoZM3Cga3mERx4qtAAnkB2L5PDhfK5APxSqEbKxNWQemOZMx8nOnuC6DZ
         w87g==
X-Gm-Message-State: AOAM5336wOPTdQ6GBCs5mN5eL7fcD5l/Qx7vZVBG4+SymTnFquzbc5yf
        vP4+O0VOU+MOo4YKeOH4UJM=
X-Google-Smtp-Source: ABdhPJw5YqJ8EEi0P5ochvddolehJ2oQojL0Sdm9i1qI8ofY4WUdoMNRhtyAS63jEvr8ZfyD7WIG5A==
X-Received: by 2002:ac8:4417:0:b0:2e1:a82c:1a6f with SMTP id j23-20020ac84417000000b002e1a82c1a6fmr11148476qtn.375.1648889273627;
        Sat, 02 Apr 2022 01:47:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a12ac00b0067d4bfffc59sm2510938qki.118.2022.04.02.01.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:47:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs/buffer.c: remove unneeded code
Date:   Sat,  2 Apr 2022 08:47:46 +0000
Message-Id: <20220402084746.2413549-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

fix clang warning: Value stored to 'err' is never read in line 2944.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 fs/buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bfc566de36e5..b2045871e81c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2941,7 +2941,6 @@ int block_truncate_page(struct address_space *mapping,
 		pos += blocksize;
 	}
 
-	err = 0;
 	if (!buffer_mapped(bh)) {
 		WARN_ON(bh->b_size != blocksize);
 		err = get_block(inode, iblock, bh, 0);
-- 
2.25.1

