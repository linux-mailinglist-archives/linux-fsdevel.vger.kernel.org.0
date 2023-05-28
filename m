Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A0713AA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjE1Qox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjE1Qov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 12:44:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BDBAD;
        Sun, 28 May 2023 09:44:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d24136663so1718721b3a.0;
        Sun, 28 May 2023 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685292290; x=1687884290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b44Rf60oUaAcGpO0dqWTBH48dBelIzQdyh7QejEWNW4=;
        b=pfMkzO7iNYYyZrGO1+4DEegnXhVL43zkPA6I4WmsGPE/Djny/b8Zbi/CnZtiGT5WyF
         Tmv75y5Ud8nyfAQiMuy6YLhVtp/jSudbXQwepjI53+JkbBSQjA17u/+HBMez8/wTPTKQ
         leHQcXo00D5Q2DCjCh+xJoYGRlObwF+Cl5w4Exe6umO0DMzKfsmk/J+EI2vdn/7jBqLT
         LzL15LzivOPhD65Tq4kjUvds43lF3RLSIX4H5kGjjLgcjfBD6ixs9qcMPF8XSIhzuuab
         N2HXvCnYBRFQUSAatsqN8/BEyeEKIpzx30pbck1KggfYExilo5TjoyRaWshHH7oUH6pc
         BWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685292290; x=1687884290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b44Rf60oUaAcGpO0dqWTBH48dBelIzQdyh7QejEWNW4=;
        b=NS4HjWGUPUy/XfeKDE4j7pR6cAz5xsfp+UY8jXpAMP8yW55ZwdBIevakPe5WZmVNMd
         VAHQFJI/XPOiRi0XDCi/lcNdypOmeaKLgTh/UmyddEx0/pEkz0Hde9xJ0V1dmsO5OpR+
         +B+Ijo2jTerChqDP09f8Ryy+DZxUxUBLn8Dd2+rZvHwBYCb0bhjsABGVrIrcy7hUv643
         DSdCDxYESqHoQHQRKH21T5sO/MLNshqa/IZRPM/kARGWN787Un4in5Dl+fTQPvFRjnKt
         e0zxEIAtz0FVpUkIENEj7KB1Mute10FjLb4DhKBiZmn428a7U72gY3smJmzV1onkxlJA
         8xow==
X-Gm-Message-State: AC+VfDwvECe7IxIC0PiULIdmk+IYDaL+KtKIY/Ib8kDRmFU7pFzKK2ta
        vrRdNFuz6Zij7fP6951+FnY=
X-Google-Smtp-Source: ACHHUZ7NSNvNbKHvtljwEOul0/xFQWnk69MdXE4dhsxoVDz0dqkfiMeSNHYtR3tsToLehH0gaL1olA==
X-Received: by 2002:a05:6a00:b89:b0:64f:bf12:a7f7 with SMTP id g9-20020a056a000b8900b0064fbf12a7f7mr8603253pfj.5.1685292289703;
        Sun, 28 May 2023 09:44:49 -0700 (PDT)
Received: from fedora.hsd1.wa.comcast.net ([2601:602:9300:2710::f1c9])
        by smtp.gmail.com with ESMTPSA id p24-20020a62ab18000000b0063b7b811ce8sm5303810pff.205.2023.05.28.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 09:44:49 -0700 (PDT)
From:   Prince Kumar Maurya <princekumarmaurya06@gmail.com>
To:     skhan@linuxfoundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chenzhongjin@huawei.com
Cc:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Null check to prevent null-ptr-deref bug
Date:   Sun, 28 May 2023 09:44:00 -0700
Message-Id: <20230528164400.592092-1-princekumarmaurya06@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <000000000000cafb9305fc4fe588@google.com>
References: <000000000000cafb9305fc4fe588@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on that leads to the null-ptr-deref bug.

Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
---
 fs/sysv/itree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index b22764fe669c..3a6b66e719fd 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -145,6 +145,8 @@ static int alloc_branch(struct inode *inode,
 		 */
 		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh)
+			break;
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
-- 
2.40.1

