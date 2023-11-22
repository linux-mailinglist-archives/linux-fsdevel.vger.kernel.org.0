Return-Path: <linux-fsdevel+bounces-3403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B47F4623
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8098F280F1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639ED4C60E;
	Wed, 22 Nov 2023 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiffeyuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C46CD40
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so5273505e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656043; x=1701260843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcAsvQKeH8bD+t1fjlddSBVl33kkt23lj2i5eRHaGwA=;
        b=HiffeyuHnkeH+FATQVxtnFKVmXquGuk5YUiSHqpcJweYv/8I429/tSSNjfpzLUwRXF
         7YglvrhkC1TN6X+RsAmYs3Z30MNWE3k7mvMLSVGqHXqFkiv2Z88se+LTNp74kzvwPaXn
         q7YPJ7GzoZRd7zVBZhYh249YpZyL8wjjEP7xe+jwsFHtmaaKqADoh0pG9IqqH33tNnBz
         ALDe4NIXX+mwaRBdJtn/k4FeXQATAEByXydj5Sj9jx3B6MsQ8O44VfyD1niFWPsrKbtG
         ERgmDTSMbkFr4j++gFcqE75uIaSzWimzMXwIYzkNzGYE3a++IWCeTDPkuZYyPPFCUla3
         xaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656043; x=1701260843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcAsvQKeH8bD+t1fjlddSBVl33kkt23lj2i5eRHaGwA=;
        b=F0v7bS72A64rdFT1/bpxNAWkUQxoe00689EhOeXRGXZPNDS7150XPG7dXhGezIhAl6
         OmG9rFFmIop8euPTGVfy9Qn+qvJz22O0t/oaZOUGEITHMtTsx3OE4Ir4MdDUbOmPpXc+
         kjFygQ741TD30MP1wer68beVGwVkeYXh1BsQ20E6n0XJn+SjAiH/EtZZ1oGt7/LP/Y6s
         1JzpztMsWDCndxQ0FlbvEPplOiF/vTlCFsn9WLXpQ6K/lxrvJeCStLbv2w3ox3HMoUbT
         inshV1dR9F9u5nwFE7lf5p10jXbsh5/FU/ffYJFabKzDWGz5L3v69waYBIhUL/itV6P1
         EmCA==
X-Gm-Message-State: AOJu0YzV1+X6O5Ibv5Z0N07LIa+q9Kr98ehTcJPBOlDAUXG9hu6uDdSW
	fpxECTHLxgTMzawGwPYTvec=
X-Google-Smtp-Source: AGHT+IFa6t6v3VdOtA/5/w7d/0wbdv+lE0fjWfOCpettExcJ89Fk+ZMnA+GwJ+TgLpwhSthUZhquDw==
X-Received: by 2002:a7b:cb8e:0:b0:40a:4c7e:6f3e with SMTP id m14-20020a7bcb8e000000b0040a4c7e6f3emr185525wmi.21.1700656043450;
        Wed, 22 Nov 2023 04:27:23 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:22 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/16] splice: remove permission hook from do_splice_direct()
Date: Wed, 22 Nov 2023 14:27:01 +0200
Message-Id: <20231122122715.2561213-3-amir73il@gmail.com>
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

All callers of do_splice_direct() have a call to rw_verify_area() for
the entire range that is being copied, e.g. by vfs_copy_file_range() or
do_sendfile() before calling do_splice_direct().

The rw_verify_area() check inside do_splice_direct() is redundant and
is called after sb_start_write(), so it is not "start-write-safe".
Remove this redundant check.

This is needed for fanotify "pre content" events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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


