Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB1519A01B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgCaUrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 16:47:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34818 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbgCaUrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id d5so27885773wrn.2;
        Tue, 31 Mar 2020 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AdEViMXBRjDxwOLzH210LJAZ7Il4kdlQLv6bFidnE8=;
        b=E1B9naPE51Rj83Qxr+cgWNDj6fpddYFOWLp5D8koXxFkaUSk2bhToLFxd21a1Ba6az
         VrcwzvoRuKk2EYnYfF1vEbrAOQzKCKQyBOiuXLb3u/Mv7vglD04NHhxpMJP8RdPWEoFH
         bvXNazG1v+mpHjB+Pdqs65M91FT8Lo88jeK/wwgOa9ASQx/iViOd9jX2NrNedyIwajKz
         Rr5NINH8nnmiQ26uwXG2UWz/NDBlpg3h10jjWWBJSyCrnPo0cPw+tRL9DMNWslBuqbyB
         lIS5l3s4jX5iK75m6J1LZyMssO7COL4Htr4+kHngklccNH3wc3DliVF8nmCs1L9knxTr
         +dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AdEViMXBRjDxwOLzH210LJAZ7Il4kdlQLv6bFidnE8=;
        b=RWk1xdbHrsvhU0GgattA0tHWcaYW/Zk9rJMQQlXl8dGJkmFVJBiuSvttvRQn11N27Y
         WzWcwu7Yai+b/C82oEBhh9Eg2H76Km/v7S+4TTxVlfEBO2Yk9x5+1xl1IBiuz7ltA5Jg
         2wPlHCxTS3HWdglw8UgTB4JwlzrPV17EsIOxRxsl0XZgHlpeTbMwDSQXFWv594YxzjOh
         qG1GXYQrrgOEYTKzYVVKBgRdsMysk4pJKrV0ZxroX6oSiCn9Ex0qn+j4mwQZU41IAuWx
         TDMHavzAUtECjEnQBozaf+IXGETmBwlOdYxfZ6eKaELPr+9IRvLY717jK2YokYMhl1Aq
         Nwqg==
X-Gm-Message-State: AGi0PubyuRQqWyg9eZT+oQQduDGnA8MY5rnO4S8ohCdAFylTO7cwVZ2J
        QzbHFyZcdVs7K/e5jdyi+xn/PRCqjA==
X-Google-Smtp-Source: APiQypJJ8slhMDWYWjJBrx+erJOUIfKMzZFXp90keTB4tBk6rVakx4kL5Rfgj/8CcUhW5drk/hSJ4w==
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr595410wro.246.1585687634658;
        Tue, 31 Mar 2020 13:47:14 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:14 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org (open list:PROC SYSCTL)
Subject: [PATCH 4/7] sysctl: Add missing annotation for start_unregistering()
Date:   Tue, 31 Mar 2020 21:46:40 +0100
Message-Id: <20200331204643.11262-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331204643.11262-1-jbi.octave@gmail.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at start_unregistering()

warning: context imbalance in start_unregistering()
	- unexpected unlock

The root cause is the missing annotation at start_unregistering()
Add the missing __must_hold(&sysctl_lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/proc/proc_sysctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c75bb4632ed1..d1b5e2b35564 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -307,6 +307,7 @@ static void proc_sys_prune_dcache(struct ctl_table_header *head)
 
 /* called under sysctl_lock, will reacquire if has to wait */
 static void start_unregistering(struct ctl_table_header *p)
+	__must_hold(&sysctl_lock)
 {
 	/*
 	 * if p->used is 0, nobody will ever touch that entry again;
-- 
2.24.1

