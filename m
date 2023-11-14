Return-Path: <linux-fsdevel+bounces-2830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6157EB3C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A1B20CE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E15441A88;
	Tue, 14 Nov 2023 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKHreDh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5B41768
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:37 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC1E198
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32deb2809daso3441414f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976014; x=1700580814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EABgM0PGthLo9c3qNgFDIuspwPfs4M2r4qGK2JQEz90=;
        b=fKHreDh/QFgFdmtxyNTbUCgmWouD6oaUo1OtGOuG3Fmr4PTxTwNdz/aTcl5hobd9ap
         HVJss4yn31Dytgmlv6RpNUhjbST4SAem873ZKwLvGD3PM5qbzTBJib7uC4Xb/3v12m3k
         1BL//s4voVl1YuYAsHNaDzBjw4zjEhy7GmUbRXY9XgzaRQuzFq55pNPtXIXQ+3ieuniz
         cYFmzqEDWEQtgosa1PzYF/oL96Q3uoEWSwS+oRGcmAMw2f+MbIErHWXBYTjTNFK/uacs
         umowIiwR7S1Z2l4Ft62QFkycmBKwTo/CRdXoyM+/YGnbvb1p2uO1cyioMDbCtJ3WxnUQ
         rWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976014; x=1700580814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EABgM0PGthLo9c3qNgFDIuspwPfs4M2r4qGK2JQEz90=;
        b=OzBCR2fEmIev1rwtZ07NJoDpEKdYBnkptJUI4Bnkvp/pJxmFYsn2g8V8Ny++itVQCA
         aWGIVrnpQUDiEpoYhxas2FVkcX7WEylAN1lbGuzJLSvtmLMKrlVFNGJ+oNfqtqoNu8TB
         28BN4c+fGc8Ug54gHn4RiVdXjdZlhGaTAc44B7wyfPnj53gp1wi1HiF7epvQp1mbZTyl
         J5MwCckwLytXAe/8uJWKpaYFNHXUk29CWEIONvwJGCvVY+i3vhtBDFzzwa1c9A6GBiTz
         oiI50taPeNPdh80tZaaEzvQIAKe5pvy37YKvD/jT04UA9PDLICVwfCTHGgyimy/H7Mf2
         Ukbw==
X-Gm-Message-State: AOJu0YzwMCnFQu5DMwu6NxwkeQEsN3avKmAOp1/k9Tv32KWIVtAHTuwg
	q2Q+pGDemBQhlNislBNa4Gc=
X-Google-Smtp-Source: AGHT+IEecxSDB/lBD3X6f2ebN2uzloTr+FAA+spHGTYnwqYaV7sxwUfdepuJGzIxv8srV/YDel/mnw==
X-Received: by 2002:adf:a3da:0:b0:32f:7db1:22fb with SMTP id m26-20020adfa3da000000b0032f7db122fbmr6380350wrb.28.1699976014181;
        Tue, 14 Nov 2023 07:33:34 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:33 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/15] remap_range: move permission hooks out of do_clone_file_range()
Date: Tue, 14 Nov 2023 17:33:12 +0200
Message-Id: <20231114153321.1716028-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114153321.1716028-1-amir73il@gmail.com>
References: <20231114153321.1716028-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many of the vfs helpers, file permission hook is called before
taking sb_start_write(), making them "start-write-safe".
do_clone_file_range() is an exception to this rule.

do_clone_file_range() has two callers - vfs_clone_file_range() and
overlayfs. Move remap_verify_area() checks from do_clone_file_range()
out to vfs_clone_file_range() to make them "start-write-safe".

Overlayfs already has calls to rw_verify_area() with the same security
permission hooks as remap_verify_area() has.
The rest of the checks in remap_verify_area() are irrelevant for
overlayfs that calls do_clone_file_range() offset 0 and positive length.

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/remap_range.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 87ae4f0dc3aa..42f79cb2b1b1 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -385,14 +385,6 @@ loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 	if (!file_in->f_op->remap_file_range)
 		return -EOPNOTSUPP;
 
-	ret = remap_verify_area(file_in, pos_in, len, false);
-	if (ret)
-		return ret;
-
-	ret = remap_verify_area(file_out, pos_out, len, true);
-	if (ret)
-		return ret;
-
 	ret = file_in->f_op->remap_file_range(file_in, pos_in,
 			file_out, pos_out, len, remap_flags);
 	if (ret < 0)
@@ -410,6 +402,14 @@ loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 {
 	loff_t ret;
 
+	ret = remap_verify_area(file_in, pos_in, len, false);
+	if (ret)
+		return ret;
+
+	ret = remap_verify_area(file_out, pos_out, len, true);
+	if (ret)
+		return ret;
+
 	file_start_write(file_out);
 	ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len,
 				  remap_flags);
-- 
2.34.1


