Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB4390C11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhEYWVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhEYWVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:21:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0DC061574;
        Tue, 25 May 2021 15:20:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id v4so24326227qtp.1;
        Tue, 25 May 2021 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mn8Q53wlifLTa0WvkY7Jksh0Xjl0mA8Gm4pP8e3OZQI=;
        b=kv954D00tM6ek/CV5hyl++Pe3kYvM31zUGDlgw+djtqQqz5GqWSwUthM42LfzJ6PCK
         dsjXhYSeWFOvSf9npa0hf1ZwGsCiiHa+7+asH66OUEdq3df23UC7usxIjzw9L2pNExmy
         WVm1C7ZyDYzdlOwoNyWHW2myj2FIosn0Y7vQsOz6S5nu9qkb0LpoM7OSzjA9qct7GiJH
         e1xMPQ29JHBIUUZD/s9K3zSw3ZA49mw1AR4a3dD3H3UiYUoCAaomcMExIqVWhW7yDUbf
         GrSRZvv8/l2flynbwNWpEzkCHAheGcZYFDTLzGkOQlQaErD2zeejJyxXAzmSvLEqoRjt
         C57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mn8Q53wlifLTa0WvkY7Jksh0Xjl0mA8Gm4pP8e3OZQI=;
        b=C80wSqiImR8Batl82E3hYBXWrJRn+lstURQWkzppz8GN2n6o6+1m23GDFdrGcXctDT
         s9qEJQzxFcDg30P+iNp4u8FL6IxshRMOu+9LVBvcCjoAx2Frd6Pf3PygNVYmUpnvx/mg
         jYYSMvcnZk0ZwGJmhc9kAthuKV/p1Le3URi6TD5IyX4wLCzfvkS22ulsV3j9xi2ODzuw
         2WkkWHy6TE+CrhcyWX9LCPl4THAe71AUX6qvJ+09zQPVS2r1ohZcpBMRyjKpDeeztt0s
         0R4RyrKzHKWDaGtpwwZq408pOU/mCsPtVVyVQDGZVhrOBTdkLx81JUd2XkkU5jvUwwlu
         ofLg==
X-Gm-Message-State: AOAM532LIfHqYOHoqai7qOyQQjMnAbpX5Fx6/o+v7BV9mJG/tRT1V9Yz
        oGHCOxt8ESZ0xTLJPhd4/VyU6wlkCwP7
X-Google-Smtp-Source: ABdhPJwSTTViOlyf6jZmOmnl7d9rxE6TwqKX1N89bydicuBo7MMOOrlJlXCgaOputn3BvZwrH4c2cQ==
X-Received: by 2002:ac8:7ed2:: with SMTP id x18mr33538716qtj.26.1621981203430;
        Tue, 25 May 2021 15:20:03 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m10sm333445qkk.113.2021.05.25.15.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:20:03 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/4] Improved .gitignore
Date:   Tue, 25 May 2021 18:19:48 -0400
Message-Id: <20210525221955.265524-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
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

