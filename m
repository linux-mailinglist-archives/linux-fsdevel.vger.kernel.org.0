Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6447C6D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 19:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbhLUSpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 13:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhLUSpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:45:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A637C061574;
        Tue, 21 Dec 2021 10:45:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1493315wmb.1;
        Tue, 21 Dec 2021 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sP8tGVLSq+J8OoY4ZEIZdlL5ioBYvuT3xm7rNvUEflw=;
        b=Jg3B9hSImyqr8JAxuDtr8VSKOk2Y/dAXnQlgy7Gs0O7lNN48oonawsgfd5T0X99BMo
         3prOZpl0lcyHbJkGoeQwRcYztxCp+92XIxOGuuSg6El7mc6aTdhK+T+tTj/i2VYsIkqU
         gY4zk7gyYyq74X4e4k7hJkOwXU8o37tJO+WpnIyFLBAnAOWNNONTc1q9kMAwmb9jkEnt
         I91RZjm6gypNO5i37RPnL531XZMYwFlPpkaU+lQ8bkzy9e7gkPtEg11oida65UkuZBiX
         g6SwKhPOWCEuCI3L3WC3qL/CvbAbkOjUohDi9YCu83hiYtcqFyy60QjlVj1VsEQut2Go
         lp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sP8tGVLSq+J8OoY4ZEIZdlL5ioBYvuT3xm7rNvUEflw=;
        b=viOibeA3xtFisKTuL82WURXpMRrWLw3FuGd1rqtESA/rA+/1lVau51cDVho6eG426o
         98xeLCxPV9neGLNnsqoks/LQrnDUXgoX/peImMW3z/RUsdwgYxlCdERncKxOyPsif+Rr
         4ZZQFjEQNrZkNicYWVn20lPqMhcIyXwai7yXjVjp4gDBZ7MIOMSJP61quYyF30kdeC7h
         1YQljHMYv0QGrkGZ8TosTTxJ/UxyK+e+H+XSEImaCk91rIKdVSQtKt7BB12fGMxF0s6Q
         spBoiqS3Fa4mQrfWKzYDIWywgIcwmEfTg+UKYVowghyxq5CBIy3PMxCokN3Gl/STmy3a
         t68w==
X-Gm-Message-State: AOAM531rClg+gtYQcG717gNPX/3PpwU22/Bf5oTPjaLHuDXxOZ+RrGjA
        YIvK9648r2lpFiZ1pDYGPmc=
X-Google-Smtp-Source: ABdhPJwNmb5CLJkrtrJvYyjtqY1LRirngqPgqUNRGYXV+tkZmmmRO1HN1TdmGtt0k3LRJ6c2lALRaQ==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr3892023wml.79.1640112302147;
        Tue, 21 Dec 2021 10:45:02 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n8sm20269308wri.47.2021.12.21.10.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:45:01 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH][next] kernel/sysctl.c: remove unused variable ten_thousand
Date:   Tue, 21 Dec 2021 18:45:01 +0000
Message-Id: <20211221184501.574670-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The const variable ten_thousand is not used, it is redundant and can
be removed.

Cleans up clang warning:
kernel/sysctl.c:99:18: warning: unused variable 'ten_thousand' [-Wunused-const-variable]
static const int ten_thousand = 10000;

Fixes: c26da54dc8ca ("printk: move printk sysctl to printk/sysctl.c")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/sysctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7f07b058b180..ace130de4a17 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -95,9 +95,6 @@
 
 /* Constants used for minimum and  maximum */
 
-#ifdef CONFIG_PRINTK
-static const int ten_thousand = 10000;
-#endif
 #ifdef CONFIG_PERF_EVENTS
 static const int six_hundred_forty_kb = 640 * 1024;
 #endif
-- 
2.33.1

