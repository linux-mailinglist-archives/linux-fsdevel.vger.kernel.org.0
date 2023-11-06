Return-Path: <linux-fsdevel+bounces-2165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7C7E2F74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C7C280DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509D2EB0C;
	Mon,  6 Nov 2023 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qbobeG9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B12EAFE
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:38 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2CC1BC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:37 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6cd09f51fe0so3178831a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308516; x=1699913316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm+FRJ/W+NXgd6Kwdpc/Qv1uQRM6BXRjdtybkaEGYq4=;
        b=qbobeG9xGxap184SxHyGKgyGq2PgyS6IpoWlojmwYfDuh3dn00WHg4W8ucCbcq2+ug
         jPPEQQRxoPpmmPkruCwdmTI9bAY4mLVzW3g2y8m/TvZugY5MKdSooovR/zz6D3vfoWEf
         iCAi20t/6gzW1ymaXBRPfbu1Nv806mksHMgL3soRLo88BEFMNcY/CvIt7jU/E2YuTlPW
         YbKhIAvYxSSLpYbmjaRDNCvzwKDnth12HlWljgUn4u5kQPSrrfgLmQDAZDa2yyeCdzq6
         aW1dJXfVN7BO9opBONdYZluLpPrZ2KPhe5U+PLg8LqO5rlj/jeXlBdgPA+YKRR+B2QHi
         SpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308516; x=1699913316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tm+FRJ/W+NXgd6Kwdpc/Qv1uQRM6BXRjdtybkaEGYq4=;
        b=r3y7Dl/sNLij6nd759t81rXnvJkILCUOWC8r28oDeh4WWaYLYZAk/aByGgISyBhZfq
         LLM4kJ5h1IlPPK9XRwZ/T4f3DFJCqG96xJXv4j8IkINQoW4hGcJyneeC/Fe+Jfkm/R6d
         g0m++/epibW1dnAmc1mK5tqyMSOdHGQ4peEsFkEE5liUAJo9HUWXNIbIWR3MgS6ZShVL
         Nnj1MCES8IERKmSoQShDQ9lmBwFqxyZhp6O+oOchEeoWjRu2TEhWFlYIRhnOEPcuq2U6
         I2dWOyamTBDL2/fyldCvd7xxVQRaHku4fA7s+L7vPas7NVCLT3s7GtjsJK8Jh3KnDpsf
         knvA==
X-Gm-Message-State: AOJu0Yxfzy6RKeSzOTf5HiS0Wl290ayg1K7tdvznnxYcXL6ASvYv02aL
	+LnI7P1YCJ0oEH2AgqQVDl8spUH4aQmUh2SgaqHhlw==
X-Google-Smtp-Source: AGHT+IE8UYS4BfJoDg85VHDCQdvWtIH0Rgry8aTYWqwQxNAxbD70mCkr6GJphA7w4l+kl1LzcZM44w==
X-Received: by 2002:a9d:6657:0:b0:6cd:a63:6ed4 with SMTP id q23-20020a9d6657000000b006cd0a636ed4mr28750100otm.14.1699308516501;
        Mon, 06 Nov 2023 14:08:36 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p16-20020ac87410000000b00419732075b4sm3760788qtq.84.2023.11.06.14.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 01/18] fs: indicate request originates from old mount api
Date: Mon,  6 Nov 2023 17:08:09 -0500
Message-ID: <75912547b45b70df4f5b7d19e2de8d5fda5c8167.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

We already communicate to filesystems when a remount request comes from
the old mount api as some filesystems choose to implement different
behavior in the new mount api than the old mount api to e.g., take the
chance to fix significant api bugs. Allow the same for regular mount
requests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..bfc5cff0e196 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2873,7 +2873,12 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the remount request is coming
+	 * from the legacy mount system call.
+	 */
 	fc->oldapi = true;
+
 	err = parse_monolithic_mount_data(fc, data);
 	if (!err) {
 		down_write(&sb->s_umount);
@@ -3322,6 +3327,12 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the mount request is coming
+	 * from the legacy mount system call.
+	 */
+	fc->oldapi = true;
+
 	if (subtype)
 		err = vfs_parse_fs_string(fc, "subtype",
 					  subtype, strlen(subtype));
-- 
2.41.0


