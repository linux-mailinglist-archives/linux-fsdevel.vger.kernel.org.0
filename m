Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69F19A073
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgCaVJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 17:09:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35424 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgCaVJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:09:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id d5so27978681wrn.2;
        Tue, 31 Mar 2020 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=B6tP3lr4dsdouoEScHUU6AoHIj/KnpsdHoiuwt2FQlI=;
        b=QBEAqflkVr4c7Z+EqdZW6V8ozD9wyuQSrtALIOiej8I/g6IzRuBffynog5nlY1htxa
         uBDowuGrSKGLl001UxXtdVoPzAXK2nu2RdMK35lHBPOMyMXWmCrD7ZL4zgmvgMhPWwdR
         rEJQwYoci9SL6uCt5aHO7XhhJggFHAaGjP3ReLmQ4o7MXpbbV436n3kFaK+VbGCHMpLt
         1mcGnGxWGSPn7zqFE2zCivkvXRj6QyeMEMJ9A6UJw4fVAoyny6pZ7ZH49wVlDj1HVLXp
         HzwNv356YsGxiljki9Pi+k5sATTWWJkfi67qWd1IUG54lJbv8VL/2lujr/WlTi0clv3A
         gzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=B6tP3lr4dsdouoEScHUU6AoHIj/KnpsdHoiuwt2FQlI=;
        b=Mm7OAPtx61ClhUT4e9XA+xfTHvaZXTGEKe93A4qCmtMl1SRaKJiAcmRfr7+w5WsKkW
         zwZxrCY9cCdJADp7PJoZgFAzzXmss+5dZhu8aaAnOrM1IM/CWDvUrUySJc/ZsX70G4+u
         74HHB+g9yYsGf36nRxb6OxxvqWhS5tZET0/3Zh93K4KvJTrg6Y1An/3+h3p5m7YmjGJ/
         E3NDt5pcGs5YPlwkYURGvloEf13XXPt07/nde2RHDUOdTAQazem0aOLAhEVXOFVLHgsq
         PVd7H8XeqYcd5Eyf/VPpmdRaEjlNCWZ8Qv8A8/R4JCIAegW915CRvpIkQrFsNf5wdOwN
         omGw==
X-Gm-Message-State: ANhLgQ359Zmhk5sB/rptHeghlgIyvogeFphp6epvNHaU9Saqznpj/PEn
        ZEh5ysl2AoXfdDI52AwJcaYzihI=
X-Google-Smtp-Source: ADFU+vtnP7LYldKA1MpO9AVOo9mamivHtPoJiIQxvAeFNqobXfHXYKShtCmojhQAloJDSOy9tDZBcA==
X-Received: by 2002:a5d:5045:: with SMTP id h5mr21391859wrt.86.1585688948272;
        Tue, 31 Mar 2020 14:09:08 -0700 (PDT)
Received: from avx2 ([46.53.248.81])
        by smtp.gmail.com with ESMTPSA id g3sm29352194wrm.66.2020.03.31.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:09:07 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:09:05 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: rename "catch" function argument
Message-ID: <20200331210905.GA31680@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"catch" is reserved keyword in C++, rename it to something
both gcc and g++ accept.

Rename "ign" for symmetry.

Signed-off-by: _Z6Alexeyv <adobriyan@gmail.com>
---

 fs/proc/array.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -248,8 +248,8 @@ void render_sigset_t(struct seq_file *m, const char *header,
 	seq_putc(m, '\n');
 }
 
-static void collect_sigign_sigcatch(struct task_struct *p, sigset_t *ign,
-				    sigset_t *catch)
+static void collect_sigign_sigcatch(struct task_struct *p, sigset_t *sigign,
+				    sigset_t *sigcatch)
 {
 	struct k_sigaction *k;
 	int i;
@@ -257,9 +257,9 @@ static void collect_sigign_sigcatch(struct task_struct *p, sigset_t *ign,
 	k = p->sighand->action;
 	for (i = 1; i <= _NSIG; ++i, ++k) {
 		if (k->sa.sa_handler == SIG_IGN)
-			sigaddset(ign, i);
+			sigaddset(sigign, i);
 		else if (k->sa.sa_handler != SIG_DFL)
-			sigaddset(catch, i);
+			sigaddset(sigcatch, i);
 	}
 }
 
