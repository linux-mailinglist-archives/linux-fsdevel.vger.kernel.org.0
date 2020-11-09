Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9B72AB010
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 04:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgKIDo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 22:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgKIDo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 22:44:59 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4CC0613CF;
        Sun,  8 Nov 2020 19:44:57 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f27so2501847pgl.1;
        Sun, 08 Nov 2020 19:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eea6zQzJnJ9eA7HnJ2YfFEvj37BcqFJYPrY/BCrW/rY=;
        b=cv0M03PnYv2BxL97DwQZRefwhnCIh6DvqEm2Rv2lMCUHG8wmPGFlv1uq5YQW17+xlG
         qs/b2c0thv6kL4s2CTXEIsWeIvGn2x30NOReUsonkg93kcGWWQ3XjeQqr2z4nltY3aYv
         30h9GO+hiH/hWi1WThleHO+pZUplEum7r2pbKyBmwFW110B4dGbzJ8wEsnOiKmibyMg3
         OzFJwchI4xeX9F20M3iKj7/a1Km3gRhft9YKnG3Lm/qD8QbcMVgZCN+FkoA4aaQQVnQn
         a6dGd1M1ZNNRmWkzM3BhukKwjWBF8mN38HiKPsJ320ynPzp3MG/zq/OkCAnuWWoIEdUI
         YyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eea6zQzJnJ9eA7HnJ2YfFEvj37BcqFJYPrY/BCrW/rY=;
        b=XkhrxQkVp/ymeK3UsGNEj2q8ZnFGlbLIiGltKLgOtZ0pmH8KhFg71n5tJ4ZbSKCOeL
         ylUSXgf+dYwufqXyBhoK2jM/AL9XBxVMV9yDVk7iceNxQ697PPt6BUGAoEyyCHsL5BPd
         oDSK7+71v/W7km360hMkx78nDdAvbjC5hUpQT46KnQNEwFADfQTJ4vl/866+0prNH6om
         8uRtaIWpDOFxyyQSpBWNbrVD2+EBDASi6Iwr755E5XYbcahZ/42IUVa/l+8vTAXKiP2h
         FFSIvAvreni1vV4Bxx4ECh/1w38COcBvGcfFzck+2R7hg7LQ2Fb17x0QcUSAhVfFUnEK
         ShFw==
X-Gm-Message-State: AOAM531k0SSvMmtAeRbUqclh29s2j/zj5gn1yA4F7JNKxEB2IiBh3Xgg
        HgRN+HoIqPVt9DdrYw6KIqhY+t4XJVre0xf2
X-Google-Smtp-Source: ABdhPJxC53PMig/F5lgk8kR+OPHKAEABOtyQ7xgL9LLAc0ORnEVf9tgtiVlfMyAf2OLTSH5CE314EA==
X-Received: by 2002:a17:90a:4881:: with SMTP id b1mr11038048pjh.32.1604893497170;
        Sun, 08 Nov 2020 19:44:57 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:ea:ea00:9c82:98af:199f:6674])
        by smtp.gmail.com with ESMTPSA id 5sm9697382pfx.63.2020.11.08.19.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 19:44:56 -0800 (PST)
From:   n01e0 <reoshiseki@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        n01e0 <noleo@vanillabeans.mobi>
Subject: [PATCH] fix typo
Date:   Mon,  9 Nov 2020 12:44:47 +0900
Message-Id: <20201109034447.202151-1-reoshiseki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: n01e0 <noleo@vanillabeans.mobi>

---
 Documentation/admin-guide/sysctl/vm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f455fa00c00f..9142ecadcad3 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -876,7 +876,7 @@ unprivileged_userfaultfd
 This flag controls whether unprivileged users can use the userfaultfd
 system calls.  Set this to 1 to allow unprivileged users to use the
 userfaultfd system calls, or set this to 0 to restrict userfaultfd to only
-privileged users (with SYS_CAP_PTRACE capability).
+privileged users (with CAP_SYS_PTRACE capability).
 
 The default value is 1.
 
-- 
2.25.1

