Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4F3153C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfEaTXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:23:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44102 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfEaTXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:23:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so4548745pgp.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 12:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=hoDa1EoVZiT7Wkw8tpQ8ZdnhUm/f8Zh3zGc2U04HgkQ=;
        b=UwUa7R0UmLcODWMZ1cH1ObrJkyQ/7PUMYLAndY5VWboEVP7mM7G6DsMfe7qYTwIfiH
         LTIdbz+7GIAFsUbMbfchsqDw8EFJS1g6pW3TuYze5NDW0PdrtQxmN0slOwgIXpz01uyC
         FPA3duUgn9OEDJLB7sG+GpMAJ4VvdkPV5Map5mNJJeeTk6Jz5lvUsgmrNxdQBPTRTn75
         HefiJCZU9nt5xXSllmfL0m8r0TgVyCpWTJDbCP9SeY3RD54mBzouQj7c9Jv1Edz+AniO
         KKb1wdISkJxljOc8S5r8qsGKhkG7cJsiEH7jVW3zX0erUrtj7XSh2FTOeEDDV6SwfMok
         0tfg==
X-Gm-Message-State: APjAAAX46fieTnVBIbxilc0GfecIufk/i4Wkgu3YP0sdlRob3MVjcL8J
        dE+d553zPeUhrOi6uvv5bN53Jw==
X-Google-Smtp-Source: APXvYqwDdSFL7PzpLwvQOw94atoCEpoQ4xG/ZVsYwEVets4vEXAhhAUnBPue1jzZcGz3S4VsZQtyqQ==
X-Received: by 2002:a63:31d8:: with SMTP id x207mr10539257pgx.403.1559330630266;
        Fri, 31 May 2019 12:23:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o2sm5753489pgm.51.2019.05.31.12.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:49 -0700 (PDT)
Subject: [PATCH 1/5] Non-functional cleanup of a "__user * filename"
Date:   Fri, 31 May 2019 12:12:00 -0700
Message-Id: <20190531191204.4044-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The next patch defines a very similar interface, which I copied from
this definition.  Since I'm touching it anyway I don't see any reason
not to just go fix this one up.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e446806a561f..396871b218f4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -433,7 +433,7 @@ asmlinkage long sys_chdir(const char __user *filename);
 asmlinkage long sys_fchdir(unsigned int fd);
 asmlinkage long sys_chroot(const char __user *filename);
 asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
-asmlinkage long sys_fchmodat(int dfd, const char __user * filename,
+asmlinkage long sys_fchmodat(int dfd, const char __user *filename,
 			     umode_t mode);
 asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
 			     gid_t group, int flag);
-- 
2.21.0

