Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1EE169AB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 00:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBWXSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 18:18:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50832 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgBWXSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so7183499wmb.0;
        Sun, 23 Feb 2020 15:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tp05cGAxe3eIAI8tMjX09BksdgimN4FGWQ4p10y87E=;
        b=IHcYEAyD7OH6N4cL0P01zGS1LY6NLpg17xhAMUoQ4l2qCBTShJSU+V+GD8NffSJ4yR
         4nUyMeDByIIBzyKyaGsDY397cpdL7irHiYrtXcT8bIav5QzTbLZ21z10LtnrPhNPhzdN
         YgDkNRYklHfcShlp9+zlNXf1OwyoW3NiKKrF4NLRP56+3ZynTZNypVrzhDKxWOTlAMBu
         gBZFN+bbP+cSq4lf7ViI9IVFtM/7fl6ywIL+fgxJGILSK8hXqIcE/vmXuvYfRR74OtP3
         ZucYROCXTgAw4psyntFEkwA6PDaYyuYum7csOkeZhg76TaUFLSz3AWx7t8TmAlFb/+qE
         PXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tp05cGAxe3eIAI8tMjX09BksdgimN4FGWQ4p10y87E=;
        b=uDQCbRQUJLla6BWdyE6JuH66kUUIThlDkYabclQBCe7CiszVl/A18xKIhg7rjxZ0kh
         6IL9y7nAFMzg2vXg9cW5fFJgqYHMXF8S637l+6kz0k441XU6s4550/eDteOjZDW72BWS
         8sBaBMJ7dlH/i/pCQvGZtgR2E7ujJ75BhoOG+GJoHrhx4vSerIj6xL7rlbEuBlIMiWyx
         nS6sobe6atnHhOkxFxtYJGhyeMABmCb7CsNIta2Ji7EtbEDH2l7cuKCfAmmKVqHCTSoI
         jGNMHMsV+cP3jOFg2BwXziy7O2AiIJpFItMZCc0FLYTBdmvZlAF4PEt7+Lk5yl5VDVU2
         RhZQ==
X-Gm-Message-State: APjAAAWzZlaYBFfcNrUkJRtXpTQkt+s83v7w+IN+78VDUkf3nqJRMw+y
        2I8AcB2fwietXPnq5dx8uw==
X-Google-Smtp-Source: APXvYqxmP9PDF4LsKT7mYYTv0s5mGlu+CW99N9R7sNSqlyQ8gB98iLC5Vz0HHbfaWWhib/bujdpbZw==
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr7703539wmt.114.1582499894164;
        Sun, 23 Feb 2020 15:18:14 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:13 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM)
Subject: [PATCH 16/30] proc: Add missing annotation for close_pdeo()
Date:   Sun, 23 Feb 2020 23:16:57 +0000
Message-Id: <20200223231711.157699-17-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at close_pdeo()
warning: context imbalance in close_pdeo() - unexpected unlock
The root cause is the missing annotation at close_pdeo()
Add the missing __releases(&pde->pde_unload_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/proc/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 6da18316d209..1f33cb7a6c47 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -139,6 +139,7 @@ static void unuse_pde(struct proc_dir_entry *pde)
 
 /* pde is locked on entry, unlocked on exit */
 static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
+	__releases(&pde->pde_unload_lock)
 {
 	/*
 	 * close() (proc_reg_release()) can't delete an entry and proceed:
-- 
2.24.1

