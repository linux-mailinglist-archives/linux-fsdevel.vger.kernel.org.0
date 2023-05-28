Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386EA713B44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjE1Rgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 13:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjE1RgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 13:36:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD51125;
        Sun, 28 May 2023 10:36:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ae8ecb4f9aso15940355ad.1;
        Sun, 28 May 2023 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685295380; x=1687887380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT9S1V0tn+Qui24xPwzImeTWa71ArxoGK/RfxcM2d0g=;
        b=DRIPVUuedYZtjirHGYj5dUvMQIum7vUn6Z71/nqVBaB0lVHj+RMRCsG2Fe+dupaXlY
         1VBKgfxlvABZtmcYfkY8K7MiVMYHFAs0Tk/IMJjuplh9Qvz1S1VXcjROJ9gBFUyNMSRN
         smEAms53NIZ1sXp+ibCs3wzLuKwSFtsEzuHGBEj26uDjPIcbXqw4iLObhTu79C7zdXVu
         qqqwBlF3vQ8AeeC9LUOaXkb8XD9bqTxgU/udzGdFTC34d5aZeZEW8AoRqM0jitAIWASu
         MvGZJvbf9L9uEDQHXP0JzndLFA8GcmMskYxmMPwLyJsHbuF3uF8Wj9VhIbLnuP1HEUa6
         5IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685295380; x=1687887380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT9S1V0tn+Qui24xPwzImeTWa71ArxoGK/RfxcM2d0g=;
        b=HGJHCKg7uPRYV9tFuQ2QlqIqcCL4MHbCkqAnlD3CwDfS+qWzQ0KLqoMKdeigC/AHcD
         V8esbzJwvyaqXsSogz5qZExWYwek1XHaHWvQzgWy8LW1TQLO8QmQtkfUl5f532F85WbL
         XuH5ovCT6E83pfEJI2gb7ernM715ae07f7OKj/rbkcSTT4yX8xQQf+Mi0ye1JHiCkTky
         OrHbb29Hpc45wJeYWQXL05zRj7DlovaazwXhMraHNNiWO+XnM/v0R5QmU3H/eG6ibJhJ
         1zv/mMYoEyaB0I7BiX4MTp2u6TgpFJBg5CgKJCbyz7o/7DsFGAhhp3Ga/dDphAJoLw/r
         KSfQ==
X-Gm-Message-State: AC+VfDzkKTVnYT9xxw2W3m9YMy4nqPRz88+TqE34sOKFeCe9G5z8XN81
        xkfgbp1P9/T4/AkHdCad5Uk=
X-Google-Smtp-Source: ACHHUZ6qqGWC9hVv+TK7lpazsLsOWxoZOc/uttkq1ZXUkoJLGkiKn9TJqT5eH2JYww8vrvNBIWpOFg==
X-Received: by 2002:a17:903:2451:b0:1b0:39d8:2fc2 with SMTP id l17-20020a170903245100b001b039d82fc2mr2702102pls.49.1685295379709;
        Sun, 28 May 2023 10:36:19 -0700 (PDT)
Received: from fedora.hsd1.wa.comcast.net ([2601:602:9300:2710::f1c9])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902b71600b001b03f208323sm828575pls.64.2023.05.28.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 10:36:19 -0700 (PDT)
From:   Prince Kumar Maurya <princekumarmaurya06@gmail.com>
To:     skhan@linuxfoundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chenzhongjin@huawei.com
Cc:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Null check to prevent null-ptr-deref bug
Date:   Sun, 28 May 2023 10:35:46 -0700
Message-Id: <20230528173546.593511-1-princekumarmaurya06@gmail.com>
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

sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on
that leads to the null-ptr-deref bug.

Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
---
Change since v1: update the commit message.
The bug was reproducible using the reproducer code and assets found in
bug report:https://syzkaller.appspot.com/bug?extid=aad58150cbc64ba41bdc
I used qemu to reproduce the bug and after the code fix I rebooted the 
qemu with updated bzImage containing the fix.

qemu-system-x86_64 -m 4G -nographic -drive \
file=./asset/disk-4d6d4c7f.raw,format=raw \
-enable-kvm -net nic -net user,hostfwd=tcp::2222-:22

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

