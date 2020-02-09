Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AED156CE9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2020 23:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBIWpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Feb 2020 17:45:15 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42356 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgBIWpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:45:14 -0500
Received: by mail-wr1-f52.google.com with SMTP id k11so5225450wrd.9;
        Sun, 09 Feb 2020 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVP2j5hojVUnvExz7h+Dl9IGi6ObrFT+yP+vPJn46Fk=;
        b=E87quC/WyQvcfYE8jyDGskI0G5kqta1rYzX89Ega0VBibHyNaLz2fCoXur0nz5s9sY
         GvG1Q/HkVGOQMT9wfFkybclkEwSSymAZmOzPsN5WPRXMjzeowVlJT5LlaxRuPDTFq4ES
         Qs6XLHECLjoQ2X5Jqo57gK2thu96WumHGJ5gPIE7WPqUajFXpfGOOMHNHvu5WrxTpBnY
         UlTJaIcYJBeWRGGnAaSmyBpngLbkOO2vU7sDRGAxi6SvDW+lPxwr5eR56XCo1RGlEuKw
         4sg9glYD1/6fYWTqxPAoIRKzfjNRHStnSaAH0fWcXjZXM/q/mD6K1W4B7yXgEk51ynhd
         TZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVP2j5hojVUnvExz7h+Dl9IGi6ObrFT+yP+vPJn46Fk=;
        b=iNjUuPbnNlK639wX4AaMHKRRsSHPNUQ2jiPfes2uO9u+0tmObfRNosz/abZL6NeNdh
         HYc6aKehqQJmRdLlz9JQa7+th5KQFAc8oQ2rRY4JXLpk9+U93nXRgJbpYduHKKd1aabc
         WD/mlobLHQGBnFWK2SMk/6Zr0x7ktUC4iuczkMvn6yBZI4ZFwz/zXqoCq41apEDbfEDa
         8WsyuJMz5tk9UycomPxgQJirykL47Kbw1a6m2Qkm4JjkLYBRSperZKE8773Mx9wdZPg1
         joVpUpRiNaAxTgov7F7Hs5ZJQkR0ON+zut94C51xk+2V7YgAswxXQXRLxPV+8VuPA8zK
         Yhfw==
X-Gm-Message-State: APjAAAX8QF3XpKJQYDwZCQvAWtvy84fUph0QTIgjDUf4um1Aoomx65D/
        e9HkX71UG6GFkOUCM7ss+Q==
X-Google-Smtp-Source: APXvYqwZmk3N6/MkX2G4a2g2CWgKx1vrnunrlTLyWq1+bXHUkiJB24+qoRSMZdHJfIAFtc0Bg76CdA==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr13140950wrv.148.1581288312665;
        Sun, 09 Feb 2020 14:45:12 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id n10sm13500343wrt.14.2020.02.09.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:45:12 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 08/11] fs_pin: Add missing annotation for pin_kill() definition
Date:   Sun,  9 Feb 2020 22:45:02 +0000
Message-Id: <431ee9914abbd46e929860bea5a7de7f5edc0a38.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at pin_kill()
warning: context imbalance in pin_kil() - unexpected unlock

The root cause is a missing annotation for pin_kill()

Add the missing annotation __releases(RCU)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/fs_pin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index 47ef3c71ce90..972168453fba 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -27,7 +27,7 @@ void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 	spin_unlock(&pin_lock);
 }
 
-void pin_kill(struct fs_pin *p)
+void pin_kill(struct fs_pin *p) __releases(RCU)
 {
 	wait_queue_entry_t wait;
 
-- 
2.24.1

