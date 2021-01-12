Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB442F251E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbhALAtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbhALAtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:49:05 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD86C061575;
        Mon, 11 Jan 2021 16:48:24 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id w17so1234884ilj.8;
        Mon, 11 Jan 2021 16:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87y6pk/menMH/KPEOfCyPdYq2rtpbnqpuEjMgDXF1QI=;
        b=d2ZR+ah0lewdO3lArQUp72eK1tMEOIiMAm7UxKdCWAAO2m78i+Hggj5Gkxu9VHSWuY
         4SJ5Od3ODKOYqhsJtpo9PNfQ/Oe8kE1fOg33U/wLH2bCP6HSLzm/+pXjA3m01klQV9GG
         I2ajZVjnHSoPBAgUG1bKEIYlO/EAIIqANVY0dHkBx7dt6PXMfebW8Oh+T6kdnJvkqc39
         +353zbC8JBm9xzNWGm4hKe9TNgErwtqtnB3po4RmEa+UZqE5at44ZrxuTCLLPD7PMaUh
         8bT184WKqxdtPonHTKreF2DpNULaoULHVVBm2uKcDr6T032TtRefJ6EVtsjjoDM3Ve21
         VqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87y6pk/menMH/KPEOfCyPdYq2rtpbnqpuEjMgDXF1QI=;
        b=qxH7aQVUjOChH56FM7xfV6DEL0m/IsQJw6anC8QshkKgOKT67pcu5GiAQlPpglvKvN
         3wL0R6GdlM5JkgU7+gLQx4GBZP5rSgkF+MOr4puiZLEKrdr1rT4GqAQccQR91Xsd8qx0
         gIE7fJeKfXqWVoj3PAbuqVqARGfaXQfAwLAhSrTWyoNyXEH2d5YR0ub6Uiq0xXxJohvq
         qvIX4hvmVJKEcWkBLRMg7VLiDBqs88bllxIJObOdC5yqOuMJWwMuTQH7FHYiu+UNd9b+
         ICzAT/AgBcpQ6pvsu2EAwynyNyFMUwny+WNyBVwhJkyxRNnidGryu8qK5HCaHAWmUgF2
         MNNA==
X-Gm-Message-State: AOAM531j0R5z700uel/jTa6t+Bn8o3Odxsdncwx+Xr1WPqnNSVGKHo9n
        Zl3pfDgP/+7XVn3BVhquVEN6iu6CiDI=
X-Google-Smtp-Source: ABdhPJznMLzvolCJYLLP6OLaW1fMMluc2yHSyCy1vXVRrH6F18g+9N108vdijG+sjHPw8MFUJRNVhw==
X-Received: by 2002:a92:d40a:: with SMTP id q10mr1675115ilm.20.1610412504003;
        Mon, 11 Jan 2021 16:48:24 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id s12sm1118762ilp.66.2021.01.11.16.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:48:23 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-man@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mtk.manpages@gmail.com,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH manpages] epoll_wait.2: add epoll_pwait2
Date:   Mon, 11 Jan 2021 19:48:20 -0500
Message-Id: <20210112004820.4013953-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Expand the epoll_wait page with epoll_pwait2, an epoll_wait variant
that takes a struct timespec to enable nanosecond resolution timeout.

    int epoll_pwait2(int fd, struct epoll_event *events,
                     int maxevents,
                     const struct timespec *timeout,
                     const sigset_t *sigset);

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

This is the same as an RFC sent earlier.

epoll_pwait2 is now merged in 5.11-rc1.

I'm not sure whether to send for manpages inclusion before 5.11
reaches stable ABI, or after. Erring on the side of caution. It
could still be reverted before then, of course.
---
 man2/epoll_wait.2 | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/man2/epoll_wait.2 b/man2/epoll_wait.2
index 36001e02bde3..21d63503a87f 100644
--- a/man2/epoll_wait.2
+++ b/man2/epoll_wait.2
@@ -22,7 +22,7 @@
 .\"
 .TH EPOLL_WAIT 2 2020-04-11 "Linux" "Linux Programmer's Manual"
 .SH NAME
-epoll_wait, epoll_pwait \- wait for an I/O event on an epoll file descriptor
+epoll_wait, epoll_pwait, epoll_pwait2 \- wait for an I/O event on an epoll file descriptor
 .SH SYNOPSIS
 .nf
 .B #include <sys/epoll.h>
@@ -32,6 +32,9 @@ epoll_wait, epoll_pwait \- wait for an I/O event on an epoll file descriptor
 .BI "int epoll_pwait(int " epfd ", struct epoll_event *" events ,
 .BI "               int " maxevents ", int " timeout ,
 .BI "               const sigset_t *" sigmask );
+.BI "int epoll_pwait2(int " epfd ", struct epoll_event *" events ,
+.BI "                int " maxevents ", const struct timespec *" timeout ,
+.BI "                const sigset_t *" sigmask );
 .fi
 .SH DESCRIPTION
 The
@@ -170,6 +173,25 @@ argument may be specified as NULL, in which case
 .BR epoll_pwait ()
 is equivalent to
 .BR epoll_wait ().
+.SS epoll_pwait2 ()
+The
+.BR epoll_pwait2 ()
+system call is equivalent to
+.BR epoll_pwait ()
+except for the
+.I timeout
+argument. It takes an argument of type
+.I timespec
+to be able to specify nanosecond resolution timeout. This argument functions
+the same as in
+.BR pselect (2)
+and
+.BR ppoll (2).
+If
+.I timeout
+is NULL, then
+.BR epoll_pwait2 ()
+can block indefinitely.
 .SH RETURN VALUE
 On success,
 .BR epoll_wait ()
@@ -217,6 +239,9 @@ Library support is provided in glibc starting with version 2.3.2.
 .BR epoll_pwait ()
 was added to Linux in kernel 2.6.19.
 Library support is provided in glibc starting with version 2.6.
+.PP
+.BR epoll_pwait2 ()
+was added to Linux in kernel 5.11.
 .SH CONFORMING TO
 .BR epoll_wait ()
 and
@@ -269,7 +294,9 @@ this means that timeouts greater than 35.79 minutes are treated as infinity.
 .SS C library/kernel differences
 The raw
 .BR epoll_pwait ()
-system call has a sixth argument,
+and
+.BR epoll_pwait2 ()
+system calls have a sixth argument,
 .IR "size_t sigsetsize" ,
 which specifies the size in bytes of the
 .IR sigmask
-- 
2.30.0.284.gd98b1dd5eaa7-goog

