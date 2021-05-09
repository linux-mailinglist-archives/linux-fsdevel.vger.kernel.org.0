Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B93778CF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 May 2021 23:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhEIVpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 17:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhEIVpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 17:45:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D0C06175F;
        Sun,  9 May 2021 14:44:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so14536147wrt.12;
        Sun, 09 May 2021 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBusF/KbjHCWghHBMnMPpKehqCL6Xa7jSi7F9W8BPnw=;
        b=NquJH4ELcrfZ2CwqHRFyicsGjSC/dPUMr2Ze4RjmfN9UV3IuIYC/wTeu3VUXiJc0k4
         eRYV/Tia9lgtkPZar7Jchn2M8DbxiW4m8VU+lYi3bTm8yEJRXyGM26o+r7Qqq9v4KjIY
         86hPtSo1qPmNBySrGzJtvpvw2iOYQMlSuB5nGbAYsCxaya+iLxPWR6lZP+GrBfqtGqXY
         LIspv5q48vmDsY3biUOXnNteFTYsspNhIJisj5I4zmibBXpZqR+JDTtmlPuhyHGIK7jL
         iH/E9TH7q1bl/WV94KzbN0pY10zRDDt3CBuqTCIH1Sk+lGlnype2XnSdwdehOT02hvtE
         9bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBusF/KbjHCWghHBMnMPpKehqCL6Xa7jSi7F9W8BPnw=;
        b=cdu2bnIB1euN/z2X0q9UbaURrHCAu7R6mBHdfd6V5YQrcU/5Enap7JDFST8HKcC2H0
         5gVy/8V/Dy2XwK9WtbXAyH7wE/maDZrsToSPwzd7Cf9XUaeP8Tg18EkJZFIPUZmDuZAN
         9DCu06cTEJcVgmdJKyvqU4ctpLx89NiIztU2s7uPjwLZ75YNTeU0tRznaXsBt3LLReQW
         H45Z5ngPc24Ci1vcSyPc2e86lrubDbCA4movexpZeJHjxY+E9nvSoF6HeTo5/EYX+wGY
         ZDxuPf2BgVIA1W3mG2aixhe4SoVjBKBdP0GoxIZAhtcLRA5X3NLpjVxMINmjs/cKnnpc
         6tRQ==
X-Gm-Message-State: AOAM531CJbH0o0fr6dN9GobxBFPeYt4cF/pragFn6FUa5OMV669pUobs
        c6AfEHTbM8cHmOxaSaJirgUt7Mw9fu/rWA==
X-Google-Smtp-Source: ABdhPJzvo/vbcHXbIH58HJbFF3QSN4voQDezYqeXyuqC8KbYNbm3j7DNhei/2xk3i0xTQLH+8Z/R6w==
X-Received: by 2002:adf:a316:: with SMTP id c22mr26126159wrb.202.1620596645039;
        Sun, 09 May 2021 14:44:05 -0700 (PDT)
Received: from localhost.localdomain ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id u6sm16495530wml.6.2021.05.09.14.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 14:44:04 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man@vger.kernel.org, Luis Henriques <lhenriques@suse.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Walter Harms <wharms@bfs.de>
Subject: [PATCH] copy_file_range.2: Update cross-filesystem support for 5.12
Date:   Sun,  9 May 2021 23:39:06 +0200
Message-Id: <20210509213930.94120-12-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509213930.94120-1-alx.manpages@gmail.com>
References: <20210509213930.94120-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linux 5.12 fixes a regression.

Cross-filesystem (introduced in 5.3) copies were buggy.

Move the statements documenting cross-fs to BUGS.
Kernels 5.3..5.11 should be patched soon.

State version information for some errors related to this.

Reported-by: Luis Henriques <lhenriques@suse.de>
Reported-by: Amir Goldstein <amir73il@gmail.com>
Related: <https://lwn.net/Articles/846403/>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Steve French <sfrench@samba.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Ian Lance Taylor <iant@google.com>
Cc: Luis Lozano <llozano@chromium.org>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Olga Kornievskaia <aglo@umich.edu>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Cc: CIFS <linux-cifs@vger.kernel.org>
Cc: samba-technical <samba-technical@lists.samba.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Walter Harms <wharms@bfs.de>
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/copy_file_range.2 | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
index 467a16300..843e02241 100644
--- a/man2/copy_file_range.2
+++ b/man2/copy_file_range.2
@@ -169,6 +169,9 @@ Out of memory.
 .B ENOSPC
 There is not enough space on the target filesystem to complete the copy.
 .TP
+.BR EOPNOTSUPP " (since Linux 5.12)"
+The filesystem does not support this operation.
+.TP
 .B EOVERFLOW
 The requested source or destination range is too large to represent in the
 specified data types.
@@ -184,10 +187,17 @@ or
 .I fd_out
 refers to an active swap file.
 .TP
-.B EXDEV
+.BR EXDEV " (before Linux 5.3)"
+The files referred to by
+.IR fd_in " and " fd_out
+are not on the same filesystem.
+.TP
+.BR EXDEV " (since Linux 5.12)"
 The files referred to by
 .IR fd_in " and " fd_out
-are not on the same mounted filesystem (pre Linux 5.3).
+are not on the same filesystem,
+and the source and target filesystems are not of the same type,
+or do not support cross-filesystem copy.
 .SH VERSIONS
 The
 .BR copy_file_range ()
@@ -200,8 +210,11 @@ Areas of the API that weren't clearly defined were clarified and the API bounds
 are much more strictly checked than on earlier kernels.
 Applications should target the behaviour and requirements of 5.3 kernels.
 .PP
-First support for cross-filesystem copies was introduced in Linux 5.3.
-Older kernels will return -EXDEV when cross-filesystem copies are attempted.
+Since Linux 5.12,
+cross-filesystem copies can be achieved
+when both filesystems are of the same type,
+and that filesystem implements support for it.
+See BUGS for behavior prior to 5.12.
 .SH CONFORMING TO
 The
 .BR copy_file_range ()
@@ -226,6 +239,12 @@ gives filesystems an opportunity to implement "copy acceleration" techniques,
 such as the use of reflinks (i.e., two or more inodes that share
 pointers to the same copy-on-write disk blocks)
 or server-side-copy (in the case of NFS).
+.SH BUGS
+In Linux kernels 5.3 to 5.11,
+cross-filesystem copies were implemented by the kernel,
+if the operation was not supported by individual filesystems.
+However, on some virtual filesystems,
+the call failed to copy, while still reporting success.
 .SH EXAMPLES
 .EX
 #define _GNU_SOURCE
-- 
2.31.1

