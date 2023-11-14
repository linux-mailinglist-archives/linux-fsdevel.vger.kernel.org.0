Return-Path: <linux-fsdevel+bounces-2826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6737EB3BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA63428125C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AAF4175D;
	Tue, 14 Nov 2023 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNQkRNmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095D41763
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:30 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF9182
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40859c466efso44898125e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976008; x=1700580808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DJ80duKXbFNKp+jJOZcJpxIS0hpPvz6Pb+tJw0y7TM=;
        b=mNQkRNmk/xMEQvgfgbgnELXh8nVmxj8TEY2I29TxKpW7FmlCxlCx3rBHCcs1HkNnCE
         JAzF/3xRzqGvBnzPy4thYuwnhXhKiPtAGcO+oiav9vXdwmBaJ+wL3hIwnFfXlXTyM5m2
         sAjPNd8nDB/jdhYYtTN6j1lvGLDxdgrYT3JDW78WNJUfS9vSl9crYgFjOoQgo6n8RH/9
         pZ0AJyfStd+cW/jjTdoEvrecBk3IHw1b2tKC4Eycc3Fdz4mI8ShhILqg+Ryk/7pP6tPs
         F4+7l1txWiWXcgFmsMTH39lLvOXBFAvwIvQOGBccBmyDo+/Fz+K790UMH6+LB5mwmKGs
         j25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976008; x=1700580808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DJ80duKXbFNKp+jJOZcJpxIS0hpPvz6Pb+tJw0y7TM=;
        b=ILvFZktNDlSXBvBwKoUb0BcvIL3QOK/3Xl/fJNWrqvTv9wwf7mcM0BW1IuTCLTDr12
         8IOa/azjoqWjmWTVxIXHviGLGq1N0fOTjlnICmmaX9a8XZQCP3MXchN3xrFACXKOL7I6
         EGjKiF66VjX6AHydVtsYkwtoxMuQF9WqYfi9v2s6o9hFkSfL3pDssxMwjCNNtrZwQ0Tk
         a5NQ1pf3qIV/aHkrjvRWyt9hmPunP0IdVb/+fnJalaePNL7gIa2XWlrVt46GlQRdGLbW
         iGn7dEOvA/uqUGY9qTA6ILb+tWZ1NWpsy32DetYnK/q6NZzSUxLz1P/gkdweaZY6hgpd
         JmIg==
X-Gm-Message-State: AOJu0Yy4MIaU/2quFIuLak/lKV/m2zzeSf38X78NRxuRUwleg6OW+BjA
	DBGjZsxOUpANkk8vi2w+Ti0=
X-Google-Smtp-Source: AGHT+IGnCQ9gUvV0KlIS7BQUp+hp1I93W3QI3yzVuj/h1RwfbuvtwYGmL29wNKPOFd5L27LYR4DjOw==
X-Received: by 2002:a05:600c:4e91:b0:40a:44ed:27f3 with SMTP id f17-20020a05600c4e9100b0040a44ed27f3mr8033392wmq.8.1699976008016;
        Tue, 14 Nov 2023 07:33:28 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:27 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/15] splice: remove permission hook from do_splice_direct()
Date: Tue, 14 Nov 2023 17:33:08 +0200
Message-Id: <20231114153321.1716028-3-amir73il@gmail.com>
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

All callers of do_splice_direct() have a call to rw_verify_area() for
the entire range that is being copied, e.g. by vfs_copy_file_range() or
do_sendfile() before calling do_splice_direct().

The rw_verify_area() check inside do_splice_direct() is redundant and
is called after sb_start_write(), so it is not "start-write-safe".
Remove this redundant check.

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/splice.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index d983d375ff11..6e917db6f49a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1166,6 +1166,7 @@ static void direct_file_splice_eof(struct splice_desc *sd)
  *    (splice in + splice out, as compared to just sendfile()). So this helper
  *    can splice directly through a process-private pipe.
  *
+ * Callers already called rw_verify_area() on the entire range.
  */
 long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 		      loff_t *opos, size_t len, unsigned int flags)
@@ -1187,10 +1188,6 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 	if (unlikely(out->f_flags & O_APPEND))
 		return -EINVAL;
 
-	ret = rw_verify_area(WRITE, out, opos, len);
-	if (unlikely(ret < 0))
-		return ret;
-
 	ret = splice_direct_to_actor(in, &sd, direct_splice_actor);
 	if (ret > 0)
 		*ppos = sd.pos;
-- 
2.34.1


