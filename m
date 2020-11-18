Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB72B7FB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgKROq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 09:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgKROqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:46:25 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419EC0613D6;
        Wed, 18 Nov 2020 06:46:24 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id v11so1701535qtq.12;
        Wed, 18 Nov 2020 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBrOgwo+GJ85Z/YgTrj9ndUl0swY/lnhNtqzHqownuU=;
        b=P6cGEf1a9pSl9Ii7fUNyrKgr83IhlBWca3tQfgIwSLMWRkqPbDlnCa1S0xHg94y3m1
         Sc1SmsXxnpW/zYLqGz8smHyRyDasxMVBKqpTaRqMA2LmNmpxXW4Escaz+XQarbpqbunY
         NrOeOotfZ9d4Pf+qCMUfW0jI0/DxTROYvQYmZQCYf9PI9hUw+rHQPL6V9gmT9m2Ejqva
         pu0xPwt69KFGXAHk5jHxkcpi5onSPd0igLLFWQPvQ9WmQ0ADDpB2IWZiFWOE5bciuaA5
         +pUVILCoVMJb4Bw8DuKAJrZEJao+gpeyaPQrVYciTT+NuPkg1sz+aPPX/f1NqTx2U7VT
         zuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBrOgwo+GJ85Z/YgTrj9ndUl0swY/lnhNtqzHqownuU=;
        b=UZe85gpHg93GQcH5bum0L8qU5EEwOM2r+pfJ4s+F4IIIKRWFTNqROLqzGnLVuB3qf3
         ytvazVvopoy9BOp8tGFoBkIi34Ym9s5UPDCNw7T6xzY+7LR1yRXyb74wSXQDpO/UDg7p
         KbTLPdp5UFAk847vVIXZqJzZLaJmnTrVlRO/4GUadUvj8Bm+UEgmMxXuueeK0THnO9Lj
         V/NNnvlLue2fmjhZtQARRaS7NNMMvBvvoPSy39ZYB+PWTeBDkoGV++df7YnCXCftKWQB
         o/fHZDWaeJWxf8DWC7ylvzF5B6nkMUXiKQAw9WH8Bbal3xOlsK5Vo/J7dbByfuvnTOTX
         BnHA==
X-Gm-Message-State: AOAM531r25p5Fc68GIzibeqpMU4kWP5eMYg4AnWvX9vV7p/jGdYb9B3G
        WCVIBsME95lJD5suRbga7gx9KwhT/xc=
X-Google-Smtp-Source: ABdhPJwRzF9bB4oavbLNPBdTKHIAK+dgpnINYOB6bWcEnPhy6iVKYHKI5GVY6sXHwDo32AjdQJ8YhA==
X-Received: by 2002:ac8:6943:: with SMTP id n3mr5048618qtr.22.1605710783594;
        Wed, 18 Nov 2020 06:46:23 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id k188sm4910810qkd.98.2020.11.18.06.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:46:22 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com, arnd@arndb.de,
        shuochen@google.com, linux-man@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH manpages RFC] epoll_wait.2: add epoll_pwait2
Date:   Wed, 18 Nov 2020 09:46:16 -0500
Message-Id: <20201118144617.986860-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
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
 man2/epoll_wait.2 | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/man2/epoll_wait.2 b/man2/epoll_wait.2
index 55890c82a53a..01047df28cb1 100644
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
+to be able to specify nanosecond resolution timeouts. This argument functions
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
 When successful,
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
 is Linux-specific.
@@ -267,7 +292,9 @@ this means that timeouts greater than 35.79 minutes are treated as infinity.
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
2.29.2.454.gaff20da3a2-goog

