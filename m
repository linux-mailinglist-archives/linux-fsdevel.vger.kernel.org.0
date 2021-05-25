Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D99390C16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhEYWVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhEYWVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:21:39 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4930C061756;
        Tue, 25 May 2021 15:20:07 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 76so32074165qkn.13;
        Tue, 25 May 2021 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mn8Q53wlifLTa0WvkY7Jksh0Xjl0mA8Gm4pP8e3OZQI=;
        b=O0ahpcf/yEV11GpRDEysSxvq2XmXur98JTv1nwTQdPs6wXoHFd0eQSvAS4T+62fMCq
         OF6JP3tU0Z//e4sXy/9Lr/3pNEAHBWU7koAuQ0LwaQXj8nqLg3HYSqmeg2C46Z9V4HzY
         FbLZW6b84NgFD/AQjxjztyg4N0Yb0c46jshusXNoUeFjd2VvuX1F2NoNEN9lq5WFU8xh
         f9iWKl3oHgca4PfpuxeOWQYRKLcgZChzYlK5zJY2A4h8/QeHXN5uvpHMmeUc8JRGaNn8
         K/j8QUkdqoeDyEHswD8paddY6GS0NXQmGUuRF5mNJDqFl7bKoYTIphJzh4gzJcIbrOyE
         lwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mn8Q53wlifLTa0WvkY7Jksh0Xjl0mA8Gm4pP8e3OZQI=;
        b=fy+gW1PnC7L5efl+8/8yLk1PtEgkbee5jypZ3hMo3fbRpRonG0NfPrMmws/I/K2fa3
         THMahH+AI9XjM1DArMkm1p4CPMsg3h5ZbyuSaGpd5qr4G+BMZPgLZSsYSm6LLB9ICv+M
         xsIdTLRzgp+kzytvmj2kGOf9VFoqevi+4Mntw0jJaDRdcqLjXISghWcyXvX2s0Wkhxr1
         4XQIOdtTMrCQ+utqF+uOeflO6GNBsgRcIWCzwi3HL1905L6MqUMLMBvoCMTEVundARCf
         KeY8TX2EBXj96Yzc66ncfxGKyy+SgFrf1u+R/SiiJoipJgaOkpp5Ctfi+5hsweA+3Fch
         pT/Q==
X-Gm-Message-State: AOAM530kK8B/4njWurWdcitDxdkO6zQjaoVFL+lmB0m8MKawIS4aHwY4
        M4nFpvxE1YDVnRyiB4IQGdCzdyGLu/Il
X-Google-Smtp-Source: ABdhPJwY5cs6R8R0ndWSa6WzA5rymVRLA5NO3O+lBDKh4IjJpIhtD1yhf5MuG6jBfDInY+q3+9qRZw==
X-Received: by 2002:a37:a454:: with SMTP id n81mr36930805qke.302.1621981206754;
        Tue, 25 May 2021 15:20:06 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m10sm333445qkk.113.2021.05.25.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:20:06 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 1/4] Improved .gitignore
Date:   Tue, 25 May 2021 18:19:52 -0400
Message-Id: <20210525221955.265524-5-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525221955.265524-1-kent.overstreet@gmail.com>
References: <20210525221955.265524-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ignore dotfiles, tags, and verifier state.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 4cc9c80724..64e4ed253f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -4,6 +4,9 @@
 .dep
 .libs
 .ltdep
+.*
+*.state
+tags
 
 /local.config
 /results
-- 
2.32.0.rc0

