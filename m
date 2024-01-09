Return-Path: <linux-fsdevel+bounces-7586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C383D827F7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 08:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BFCB25B55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8911CAF;
	Tue,  9 Jan 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3CzXvWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FFBE50;
	Tue,  9 Jan 2024 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d427518d52so18461005ad.0;
        Mon, 08 Jan 2024 23:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704785449; x=1705390249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krqLKG5UOqxyA1Aens1gk3nu0vyc0FzjmHFyZVfO4sQ=;
        b=H3CzXvWfsdtqlBgFC8wyDQezrLf7W0GFC3GBzLPqNXPMZMX4wf1x7YGsMEXq82CHek
         DNQEjKZE/SILq1WVQ8R1QqMTBUOwp3l8ObgUTQHtWRWf0mkYUDmBNMQnFnRvl9eiIFrD
         wZdpMWt8HduDlXl50slfpRWPWj6ynV1L+RFJCKxDJJMZ+wEcXEBbjl3A5CRv157CRfHI
         qvgOTTddFdd4nJwSTIyW3c+sJeuj1FIXJxGVqCh86wVbFVj+mGH6SB0iXvhicHk/ziZt
         9Vuvbfcw6lnthl8xayROXQ+ou8eQV9Uie38KyCCX9a68DqsOIvNAk3xDXv6eqEVGmju3
         U/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704785449; x=1705390249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krqLKG5UOqxyA1Aens1gk3nu0vyc0FzjmHFyZVfO4sQ=;
        b=uOIqx1Nq3BZJ1cn0JcYVNeR1j2icpVZ0HsSrzwHxNJmOE13Fly72FGHx2xJmKxPJBS
         AQyzoQFlxyrSJ463iurBo7KQ6JCUk9feURSRETWbCqtAu66Di1itqhyExdkUmTDoWR+3
         NPPYKeqaJg6WeTJCvM51kmML4K7+6e6v2l3D4VtYk2JUTD8moOhh3OaKlyl3NmVodj9e
         +pKeg6N+ZtzAPOjG77uC2VbindM6A7B2MbJnu/oQGwlGh24O0MLXfHhkjWkkXmp3ttIH
         MDoepNrhYSdohQgLjmvmA1nWDZLtCqv0Ti8Tj4AXfbgHghZPHcgNe1ip1ifC30u6eydh
         QWKw==
X-Gm-Message-State: AOJu0YyAkVOR0BVNiOrRDgE7AH/AkLfdTIPuVlQhsvMUBo0CupulXoJH
	xH8JABc1uoVfAoDB/+9L4Gg=
X-Google-Smtp-Source: AGHT+IGpFWBlcdY5FaNQrKFpFhcSn0cIbZ3a5D4qqLtg9NET2pkZuiznPpTh0sWukiB0SrG0/88v7w==
X-Received: by 2002:a17:902:a70b:b0:1d4:b37a:e08d with SMTP id w11-20020a170902a70b00b001d4b37ae08dmr335428plq.25.1704785448705;
        Mon, 08 Jan 2024 23:30:48 -0800 (PST)
Received: from jay.. ([140.116.245.228])
        by smtp.gmail.com with ESMTPSA id jk11-20020a170903330b00b001d4b1d190e3sm1066127plb.58.2024.01.08.23.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:30:48 -0800 (PST)
From: Jay <merqqcury@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jay <merqqcury@gmail.com>
Subject: [PATCH] fs: fix a typo in attr.c
Date: Tue,  9 Jan 2024 15:29:27 +0800
Message-Id: <20240109072927.29626-1-merqqcury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word "filesytem" should be "filesystem"

Signed-off-by: Jay <merqqcury@gmail.com>
---
 fs/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/attr.c b/fs/attr.c
index bdf5deb06..b05869bcd 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -352,7 +352,7 @@ int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 EXPORT_SYMBOL(may_setattr);
 
 /**
- * notify_change - modify attributes of a filesytem object
+ * notify_change - modify attributes of a filesystem object
  * @idmap:	idmap of the mount the inode was found from
  * @dentry:	object affected
  * @attr:	new attributes
-- 
2.34.1


