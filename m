Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D33154F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfEaTYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:24:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41068 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfEaTXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:23:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so6773454pfq.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 12:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=09OzKsWEH6pa0xbQSX5bdUX7ramAnBw1m5XpBBMtl8s=;
        b=sfkoijjDvxufcUusLBPUx0ZQWzEPs2JIQPXA9hca782o4/kknLIYWJq5o69d1co5zx
         k1+E4n5QXuWndKENOAJCABlbVmDnfyBG73nAdHUWKjHK1YBKtgOS+5GbXgp8C9u+J0+w
         2hCjfsGOt1VQbNQE9xhEXRYd/yb7TImUT8i6GHADlpnEdQ2UckjYqWa7LQn+nDVfGuu4
         zf1wzMQjJgzsD5qps8vTcC3rIXj152bEqlVwmF1pZaAidgb8x9iT944gbfQtVdHFSrE7
         BLqm+9v0sbve2EcbLGNKMJyYLfe4LqZDRE3WpoUEbEkoT649gdV6dSku0GyE/CX84rU0
         ea5g==
X-Gm-Message-State: APjAAAWkvMrsBkSA4Gj8Z40LKn+lq7VVtoGdkxECofjiSmQ8OSIaSnf8
        eW/eSJsN3HWjL9ZO7D/uRAuY7Q==
X-Google-Smtp-Source: APXvYqxvwP9LM12Xj44vBpACJtjdlNkpDxKvsKPHlpq7EZ6IL5RMgGPU0jVOgflGjcQSa2MLBHPa4g==
X-Received: by 2002:a17:90a:204a:: with SMTP id n68mr11635594pjc.31.1559330632786;
        Fri, 31 May 2019 12:23:52 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e6sm2346642pfi.42.2019.05.31.12.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:52 -0700 (PDT)
Subject: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
Date:   Fri, 31 May 2019 12:12:02 -0700
Message-Id: <20190531191204.4044-4-palmer@sifive.com>
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
 include/uapi/asm-generic/unistd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..f0f4cad4c416 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -833,8 +833,11 @@ __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
 
+#define __NR_fchmodat4 428
+__SYSCALL(__NR_fchmodat4, sys_fchmodat4)
+
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 429
 
 /*
  * 32 bit systems traditionally used different
-- 
2.21.0

