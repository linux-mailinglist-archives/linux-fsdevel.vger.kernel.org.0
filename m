Return-Path: <linux-fsdevel+bounces-1269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF37D89E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 22:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116B4281967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C73B7BE;
	Thu, 26 Oct 2023 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCY+V4e9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B038FA5
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:56:01 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54461A5;
	Thu, 26 Oct 2023 13:55:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so978474f8f.3;
        Thu, 26 Oct 2023 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698353758; x=1698958558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMi4W6YmVE9+Uq6mWL07obv28BYYpRn7XsezstwpvPc=;
        b=FCY+V4e9Nu28Ff3jvJv18Bvn7DOnCxH3PJH08wJ7l/M7pOIEBv9DFczYqqY3JPGVBB
         PQIQfQAGTbW8xnOqc/qjIORx+woRzFT1x/FWEfLSVgV4bffEB1c+Gq7IqHSeSAn8na/z
         nVBpvi94FJ42o/bYm7PYS82X1mCBRoxXdtS7ANhgBElos803XbWPGIdhbCtbywe6aq5k
         TZtSCKYRLDvKVwIsQsVhH5oHaRXaqo6+9debQuZZGisf/PWzGbrdAmAOzF4oepn3MK07
         OmILVNVmkfTXIpWBQhVJEPHEkzmH1UYw8IadI8Wbizcl1ZW70b64W0MfwlMd3mhyi0Rk
         F/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698353758; x=1698958558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMi4W6YmVE9+Uq6mWL07obv28BYYpRn7XsezstwpvPc=;
        b=XwbWDICgnbldHkj8ftTCmmgrxr7GtoJkmoGXkytVqxmYB0egltaT1g72g1zFEmHK60
         hAFGJUkdLII1e8G6Bk02rhVFzt+S9ellwpEpSo3t/UmE7/t4020q17ivLl8PmFZJx2Zd
         cHTL3WfAs565pzy0NBJdmmP1RwCyJm9wBDLwjeAhPZWf9XtOfqJ0LjSLIAQ7nFDk64yj
         XQmEmRpqokGOstVQ/bvmmoKB3IwdEwd41BbZuywUK6A6imOYd8ugSEzHulFx28TKL+jj
         Sqh++tKuGwpPUbYavy/SBFZqPg2eqWAH+a2CCvdRJkxbLELqI1IBFsKHGVMz1TTmHRsu
         AVhA==
X-Gm-Message-State: AOJu0Yy9YkwCx2DGz0bBfysOXTtf/TmDqrMl8rJ88Jf7+ftx9PvOsHtg
	5mNQwvw+Iu8GZrmt/75ANx3zhhVQcuo=
X-Google-Smtp-Source: AGHT+IHBLiRPdgBqiFtvORwvUa5V9+HHK7oJlw9WyRfDtBywXdUoY85Tc0OjIp60hOu/hTF/voryRQ==
X-Received: by 2002:a5d:6b92:0:b0:32d:9a26:4d57 with SMTP id n18-20020a5d6b92000000b0032d9a264d57mr598765wrx.20.1698353757878;
        Thu, 26 Oct 2023 13:55:57 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id j15-20020adfb30f000000b0032d8eecf901sm250278wrd.3.2023.10.26.13.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:55:57 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@redhat.com>
Subject: [PATCH] MAINTAINERS: create an entry for exportfs
Date: Thu, 26 Oct 2023 23:55:53 +0300
Message-Id: <20231026205553.143556-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the exportfs entry from the nfsd entry and add myself as reviewer.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

Chuck has suggested that I send this patch to you.
If you prefer that Chuck merges this patch though his tree
that's fine by me.

Thanks,
Amir.

 MAINTAINERS | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2894f0777537..a194e6b0bcd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8051,6 +8051,18 @@ F:	include/linux/fs_types.h
 F:	include/uapi/linux/fs.h
 F:	include/uapi/linux/openat2.h
 
+FILESYSTEMS [EXPORTFS]
+M:	Chuck Lever <chuck.lever@oracle.com>
+M:	Jeff Layton <jlayton@kernel.org>
+R:	Amir Goldstein <amir73il@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+L:	linux-nfs@vger.kernel.org
+S:	Supported
+F:	Documentation/filesystems/nfs/exporting.rst
+F:	fs/exportfs/
+F:	fs/fhandle.c
+F:	include/linux/exportfs.h
+
 FINTEK F75375S HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	Riku Voipio <riku.voipio@iki.fi>
 L:	linux-hwmon@vger.kernel.org
@@ -11420,7 +11432,6 @@ S:	Supported
 W:	http://nfs.sourceforge.net/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
 F:	Documentation/filesystems/nfs/
-F:	fs/exportfs/
 F:	fs/lockd/
 F:	fs/nfs_common/
 F:	fs/nfsd/
-- 
2.34.1


