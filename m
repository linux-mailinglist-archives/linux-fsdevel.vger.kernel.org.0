Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7828230FAEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbhBDSKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbhBDSBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:01:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E229C06178A;
        Thu,  4 Feb 2021 10:01:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a9so6984688ejr.2;
        Thu, 04 Feb 2021 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZHBEJ8FwkupWZ7bmcsgrO3m9sgXuJNn38vNKuN1edjA=;
        b=JVFnL4KodfaMnCMCz67JPa7+zW7Jv3bt2nRxoNOFqx26A1jl3X+KoYJNEMjRYeAnwm
         bVblKp35bKqQpYiThUicQRP417Ild1HbxZu5Z89b/hfQTXYvQbCkT7QD14Q6l2zBDOhP
         xzeTZ5uSpqyZlXCeYQCfgoml0HbQKSY2VrRq4qWSKbBapPLx4iOkWrUTXkGsnyHgZJlr
         T9tn2P2bA3uYK0fn5TsSy5KY7KPzH8ZxH+IhexafvIuzjXujWkQRJshHQ6lW1SDH70ae
         p7Jx7dkFUdf6rz2TV1ekgFPLJjxOm/7WOPhsBo9Oaakpbknwx3COnqMlfMvbvCE/taS1
         fAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZHBEJ8FwkupWZ7bmcsgrO3m9sgXuJNn38vNKuN1edjA=;
        b=L1tjCEcN4WwaCKTF44osdxnWy1EZNtHoEABp7/lrL+pjr7pck/3sVz940UJZ+kQdk0
         mXLeEvsrNqkNdDldbd9VgtmbO0ZEal9MrY0CBmH07VCaHAZuuleKj6sDwGdWb5piCA0X
         GK7o47v+1J3w9DiLw8N6rA60Ddn9HzVcpApy9fpSfPb05UqaLQTyJR5E5NjcWHLBh8mb
         MI1H8jGwy3UqJv57gRS7a6kpMkPmFT70GCjNiKp5OA140FhbPhcpw4BXg7gUtYPZ8aNn
         rbz3lZqvsFMBU4WHv6G9gpqnvtGXYhYQiO5aYJhDOHOS7T+0qOUZHzQtg5zCwlmWws3v
         o94w==
X-Gm-Message-State: AOAM531dZgpoarJ4thGwshRz6ZEwVLEMwAg/vussN8HAYAGhUr05NK8T
        w31qvToqmi/3cojOLEfu/2g=
X-Google-Smtp-Source: ABdhPJweEt6yOwCwmrZgmwJRRPGNGJr7KlH1bVPQyMpTIOz6P2t+SszEqseExdEPr5IBmw3CLcS0yg==
X-Received: by 2002:a17:906:2495:: with SMTP id e21mr315799ejb.280.1612461673716;
        Thu, 04 Feb 2021 10:01:13 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de7:9900:24e0:4d40:c49:5282])
        by smtp.gmail.com with ESMTPSA id bo24sm2810326edb.51.2021.02.04.10.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:01:13 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/5] fs: turn some comments into kernel-doc
Date:   Thu,  4 Feb 2021 19:00:55 +0100
Message-Id: <20210204180059.28360-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
References: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reviewing ./include/linux/fs.h, I noticed that three comments can
actually be turned into kernel-doc comments. This allows to check the
consistency between the descriptions and the functions' signatures in
case they may change in the future.

A quick validation with the consistency check:

  ./scripts/kernel-doc -none include/linux/fs.h

currently reports no issues in this file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3482146b11b0..04b6b142dfcf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1739,7 +1739,7 @@ static inline void sb_start_pagefault(struct super_block *sb)
 	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
 }
 
-/*
+/**
  * sb_start_intwrite - get write access to a superblock for internal fs purposes
  * @sb: the super we write to
  *
@@ -3162,7 +3162,7 @@ static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
 
 void inode_dio_wait(struct inode *inode);
 
-/*
+/**
  * inode_dio_begin - signal start of a direct I/O requests
  * @inode: inode the direct I/O happens on
  *
@@ -3174,7 +3174,7 @@ static inline void inode_dio_begin(struct inode *inode)
 	atomic_inc(&inode->i_dio_count);
 }
 
-/*
+/**
  * inode_dio_end - signal finish of a direct I/O requests
  * @inode: inode the direct I/O happens on
  *
-- 
2.17.1

