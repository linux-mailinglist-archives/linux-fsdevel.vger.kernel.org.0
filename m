Return-Path: <linux-fsdevel+bounces-3418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8407F4633
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53051281238
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E541D5B1FB;
	Wed, 22 Nov 2023 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbdRpnXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4A1A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so29647765e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656053; x=1701260853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDIVWXbhkqa6xkTHrcgH3jzCqvya5cnSZ96T5i2rQQ4=;
        b=NbdRpnXNvG7vFyCxQEGlFg1hBGM6txLItpuixOX7/XhqkYh2C73NMgNotSXOIAI4TT
         nyuV/SPsn9oA9U+g3z7LFUbRtK0A/qxNHKP7kRgLF8hg4CbEsbSo8e4VNN73umA/g9K0
         tFpVuDNo6vNUfsFZboaHjc7pgp30kx/+N0zahH0QM3gjUC/a7vWWgFuv2SazrsP+wuzL
         HzAaLOYPaiUa7pE5NiWKUqP/kyRkxggbgmlu9aGDdwbvdaLo2zHMtOP/r7cElrPhEOmg
         cR7bUaOUlUx2DV8w9dVddWsFgMqkv6N2NVtBV0pbflQvJ2Cvv0ybNtOKOnuTwBkuRaym
         THxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656053; x=1701260853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDIVWXbhkqa6xkTHrcgH3jzCqvya5cnSZ96T5i2rQQ4=;
        b=skqk51N5c3dOxESR1HJsH0pwH/9rBkLuFq51aUjljT3RM4V+y9yxxvUpnllnBSdSyH
         lZup0lvz63vYP0w6jWLg9q7oWLbk2qK55jsknUsFu99PjdnEpf47jgX9z+nw5icmtbqq
         Z3KzzIe0laUWY2tQpK6xsmzu19mv99dJYN0jASLBED1w9+04ULRyeNevlS8V2T5cP3N9
         Xs401hD18AOmoIpvBZDDywvClYuuGfMxDD7UsZPsfusmYROQ11HHDGEzY02QSRrTd+9v
         425i262h1grMN0MNPM6sw5KlMOYJwHxuu2wyLHD1ICzX3SsoZukFvb3TGiWEDKAUOu5o
         jznA==
X-Gm-Message-State: AOJu0YxRMUPj9VeDFtE4THgW1VY7CCYQhH9qWRQGWxjQQmzpQQh1fefp
	N7zy8Ydw1OntR4PGsNLDjj/PEa7abGY=
X-Google-Smtp-Source: AGHT+IEAe1Ro/CFuplEagt3V8L1XdqjvroWQcTafc3M6o1sqVEAWSc0EmScbgrKEZnE7enjTo75v7g==
X-Received: by 2002:a05:600c:3c89:b0:40a:483f:f858 with SMTP id bg9-20020a05600c3c8900b0040a483ff858mr1705677wmb.6.1700656053168;
        Wed, 22 Nov 2023 04:27:33 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:32 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH v2 09/16] coda: change locking order in coda_file_write_iter()
Date: Wed, 22 Nov 2023 14:27:08 +0200
Message-Id: <20231122122715.2561213-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coda host file is a backing file for the coda inode on a different
filesystem than the coda inode.

Change the locking order to take the coda inode lock before taking
the backing host file freeze protection, same as in ovl_write_iter()
and in network filesystems that use cachefiles.

Link: https://lore.kernel.org/r/CAOQ4uxjcnwuF1gMxe64WLODGA_MyAy8x-DtqkCUxqVQKk3Xbng@mail.gmail.com/
Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/coda/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 16acc58311ea..e62315c37386 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -79,14 +79,14 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (ret)
 		goto finish_write;
 
-	file_start_write(host_file);
 	inode_lock(coda_inode);
+	file_start_write(host_file);
 	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));
-	inode_unlock(coda_inode);
 	file_end_write(host_file);
+	inode_unlock(coda_inode);
 
 finish_write:
 	venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
-- 
2.34.1


