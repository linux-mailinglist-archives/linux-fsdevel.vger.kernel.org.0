Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CCE3154B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfEaTYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:24:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42438 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfEaTXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:23:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id r22so6760806pfh.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 12:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=aiQIM6f9frALGlBHOVEXZviohTaEbE7nb+FTGwUVD4A=;
        b=ClQkWdfeqYcEibklPxIXlSyiEBQzg9shl4/ToMbIDAZLf/58Qwl8qzvMJvvtAKUHrM
         NxLwvJ+YrNqVbHnegxBauQrTUc4OGjs2jhvDM+T3zIUoXAMHTrDKaONq4zLciH+EOsnk
         LKzhyfSH5B/x3jXXlxRqxov8G5zoW60x6zs8hdzgcwhh8/xOUT2zjv7gX4cqiIM48eD+
         k6rbVvRauy3ezeZA9s7JH3KiHR0Wulw5IsFiM7IR224iWDqdSXH9dhCWFWfukIyp1PZS
         HBYFWq3hlUSJAxW0Ls1NvKIzeDNKvCAJaL2++FOv9wbqhg/7BRjODJjAJbf8S6ap/egd
         qt3Q==
X-Gm-Message-State: APjAAAVLKtcJLAhUSmb2AHUnvVrw/x2qFFHwmfLz67vt6lfnKZQffQdE
        e+onit8Ka/3e1GDWrF9HMucgAg==
X-Google-Smtp-Source: APXvYqxnHH048gsRvFfx6yXHqqmSGXwu8SiZWTfESkHE4QP5Ki/bYzl/4Onunf3wDQIsChfj3cuqqg==
X-Received: by 2002:a62:a511:: with SMTP id v17mr11832352pfm.129.1559330634068;
        Fri, 31 May 2019 12:23:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x16sm6569182pff.30.2019.05.31.12.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:53 -0700 (PDT)
Subject: [PATCH 4/5] x86: Add fchmodat4 to syscall_64.tbl
Date:   Fri, 31 May 2019 12:12:03 -0700
Message-Id: <20190531191204.4044-5-palmer@sifive.com>
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

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 92ee0b4378d4..998aa3eb09e2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -349,6 +349,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	fchmodat4		__x64_sys_fchmodat4
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
2.21.0

