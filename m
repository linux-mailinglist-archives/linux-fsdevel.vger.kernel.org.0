Return-Path: <linux-fsdevel+bounces-4645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF98016AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06445281F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A63F8EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mPl+enRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF99FD50
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:27 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d226f51f71so29287687b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468747; x=1702073547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mgqq6E721isnoR2dH2C/hG8cphDsR22LsNDoTUSxfc=;
        b=mPl+enRhConyUzPaV8kPHSruBzynmVEIJuUeKWTGvTROkAmgKOIjhQiLw6An8DkP/8
         Mw4hH6PzDEQ0+cKOGkA2GGk/l0cNxqoPVjXPcl/2dUt6/aDWbgc+FSJSvy1T0nrbw5JY
         iLdVj4RgGiMgoBkGbIq7P7q09cSrw+VKPqrrzX9xZVTLbwDg66JRWtVbT9zsiKoJHYOm
         0cERtPNYojpjnew83rkBdT3X+iAvPtdwa7KhXSfHq449/JrpnUwRoCYpHego7K5dgv9T
         HqyutrYi7/27B612SjPF0vqC615s3BX3PtSWZqzT5XIroRF1WJOyr6If2z/eorR/gSb4
         dpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468747; x=1702073547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mgqq6E721isnoR2dH2C/hG8cphDsR22LsNDoTUSxfc=;
        b=Rv4YkFkXzMMohVddnvmSvRYZDT8IMqw90IVH++uWwvStpuCZVjOKELmYqzkBzJyaab
         ivkrSr12vXWW6vtSrUfHYIX45J6AGfBDJ3vabbhJ3xvPErQIaFCu4KZYvvnz4jSYREMR
         ythDmJTu5GOb83QtLStQslgw7u2LcxGuwsEBtGDjyy3qZcZd69YIKw4vTqgxML24wWVL
         ob0PnDSmPcferYwbYVS2PCpqeJTz0pOZFO+67pGZhOJpSuUeWkLnpYLV55Zxp3cW57bv
         Ln7NMY6vbrqf7tmwVtpZBdo/DJtI6AKfNdiqx9PKZvRLCAdGYBs92cHAY5gpr/UaByDc
         8GBA==
X-Gm-Message-State: AOJu0Yx4c75HvpqL+uIZgNKvvlFAZR0ytMyY5A/CATAFv6ELy9wGSr2z
	H2Gjt9AeDJwuHWkZ5M/SA57El4UMX8K/i1Zo5ZHMTg==
X-Google-Smtp-Source: AGHT+IHt7hvUvh7DsYdtQPnlAuZ8fHvTnnhmbNy558zezYxZ3eRdR17HSWBvqeyrMYhURbY+W1G15g==
X-Received: by 2002:a0d:eaca:0:b0:5d7:1940:dd7f with SMTP id t193-20020a0deaca000000b005d71940dd7fmr176879ywe.85.1701468747192;
        Fri, 01 Dec 2023 14:12:27 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i2-20020a816d02000000b005d721755ca8sm64192ywc.29.2023.12.01.14.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:26 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 26/46] btrfs: keep track of fscrypt info and orig_start for dio reads
Date: Fri,  1 Dec 2023 17:11:23 -0500
Message-ID: <5e74c0395e4f58082b9446fb0105c0cb99e8338d.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We keep track of this information in the ordered extent for writes, but
we need it for reads as well.  Add fscrypt_extent_info and orig_start to
the dio_data so we can populate this on reads.  This will be used later
when we attach the fscrypt context to the bios.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9c704b1cfe05..dbdc01f25215 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -83,6 +83,8 @@ struct btrfs_dio_data {
 	ssize_t submitted;
 	struct extent_changeset *data_reserved;
 	struct btrfs_ordered_extent *ordered;
+	struct fscrypt_extent_info *fscrypt_info;
+	u64 orig_start;
 	bool data_space_reserved;
 	bool nocow_done;
 };
@@ -7767,6 +7769,10 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 							       release_len);
 		}
 	} else {
+		dio_data->fscrypt_info =
+			fscrypt_get_extent_info(em->fscrypt_info);
+		dio_data->orig_start = em->orig_start;
+
 		/*
 		 * We need to unlock only the end area that we aren't using.
 		 * The rest is going to be unlocked by the endio routine.
@@ -7848,6 +7854,11 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		dio_data->ordered = NULL;
 	}
 
+	if (dio_data->fscrypt_info) {
+		fscrypt_put_extent_info(dio_data->fscrypt_info);
+		dio_data->fscrypt_info = NULL;
+	}
+
 	if (write)
 		extent_changeset_free(dio_data->data_reserved);
 	return ret;
-- 
2.41.0


