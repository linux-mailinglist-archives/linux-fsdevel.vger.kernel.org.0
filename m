Return-Path: <linux-fsdevel+bounces-2828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728D7EB3C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987001C20ADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF241761;
	Tue, 14 Nov 2023 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeS9Ozwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57741768
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:34 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5012F
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32dc918d454so3440523f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976011; x=1700580811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLHuuySI0a2thaSwrbe14268iMRgl+oSJWzW6vzbqSY=;
        b=SeS9OzwqKLdp9EO4SqIz+xcGlqvWKJuB9LT5fUWcEjQR33IaIfB6KG8DRTHoEAkzy4
         8sKVzSHZ+gcWzbH5OwfG8xjuJVrFL7stVd4UPEHFc7nKXyuXkEgA4J6fHNwXiOO7cpqS
         WqlG6ENIrFuGz33bWPdgG8K4tS7XHh4WwtIFasNOdkNhLN+gM8rjZ3Ih+I0YusfooSZ7
         1ZP5c/dEMxeD2NtTntxXsKUEDhlsYyqO49xpIQqLW+McGVxPYVrcURH9yN2h3BcEvXps
         F9k8n/6BmgnnwCSM0p/7fd1opWRwuV7wDbG/AOZiR0+rWYqeJ/VDxoDIlMxq5yyyCE1U
         Ndpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976011; x=1700580811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLHuuySI0a2thaSwrbe14268iMRgl+oSJWzW6vzbqSY=;
        b=GPm05eoBZb1ijmp2vdw14ecMH7krRhOS5mMt4+drVtKFdKDatmEp4uLyFYNtd/h3LY
         uVOrpmOEkQliD8aRaI3N+Xb5SjKwu7pKPD0E8w3vaBfZojyIPLKzsFGhFR/t+xBqwCG6
         WBoBqGZ7MRMqkLViORZpob+WKQ7wYyoUigwa/Zg18IeQSVOcbypIJ1cXYSGYDSZj2L5B
         2Divtuu59HjN1yQExvbLZbQKqAR+Id1iHlwUEs9n/AUzV+UOnAOcXPuWQUvef/B7ktPd
         ojhRjxkT4PCw65f6l+/wBLflARzL736MakZMi5CFDr9c0rUCD48Cw4Q9XXqX62PBNbI7
         IvbQ==
X-Gm-Message-State: AOJu0YzfINKPjiAvfF3FWm3RTNnBXWpQy/V9/18F+j69uxJxsPsChiqQ
	u7AocSXDvO+QZXYlQ0pgaNc=
X-Google-Smtp-Source: AGHT+IFcX/jmNVWbgtC4tTKLLmxZLK/3tiFcPnyZtLoELBOn1LoZ2pm8epR45vFd9uNvZBk78Cd2+A==
X-Received: by 2002:a5d:6daa:0:b0:32f:80cf:c3cd with SMTP id u10-20020a5d6daa000000b0032f80cfc3cdmr9043015wrs.4.1699976011407;
        Tue, 14 Nov 2023 07:33:31 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:30 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/15] splice: move permission hook out of splice_file_to_pipe()
Date: Tue, 14 Nov 2023 17:33:10 +0200
Message-Id: <20231114153321.1716028-5-amir73il@gmail.com>
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

vfs_splice_read() has a permission hook inside rw_verify_area() and
it is called from splice_file_to_pipe(), which is called from
do_splice() and do_sendfile().

do_sendfile() already has a rw_verify_area() check for the entire range.
do_splice() has a rw_verify_check() for the splice to file case, not for
the splice from file case.

Add the rw_verify_area() check for splice from file case in do_splice()
and use a variant of vfs_splice_read() without rw_verify_area() check
in splice_file_to_pipe() to avoid the redundant rw_verify_area() checks.

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/splice.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6fc2c27e9520..d4fdd44c0b32 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,7 +1239,7 @@ long splice_file_to_pipe(struct file *in,
 	pipe_lock(opipe);
 	ret = wait_for_space(opipe, flags);
 	if (!ret)
-		ret = vfs_splice_read(in, offset, opipe, len, flags);
+		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
 	if (ret > 0)
 		wakeup_pipe_readers(opipe);
@@ -1316,6 +1316,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 			offset = in->f_pos;
 		}
 
+		ret = rw_verify_area(READ, in, &offset, len);
+		if (unlikely(ret < 0))
+			return ret;
+
 		if (out->f_flags & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-- 
2.34.1


