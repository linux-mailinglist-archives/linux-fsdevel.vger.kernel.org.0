Return-Path: <linux-fsdevel+bounces-7740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47BE82A084
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 19:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839EC286237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F214D5A5;
	Wed, 10 Jan 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1pJ7uAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B574CE11
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e4f71288bso23479105e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704912885; x=1705517685; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZN9Wo59ib8rrxmGmkNNqnPBXMYJ/gbEqO2erlBDFegk=;
        b=H1pJ7uAZ/WvGsOGgHHd+lbhQUFMdCRJ5yM91bcgbZG20RwJWbL4bpYvEzQLMV5CiCu
         sku1Nxgr+Lu3iDe4A+sgs7J0wDBkY+RZL7TwVxVrTk+gP7l4J4YTHQjePoks+qMh/Pvc
         WUipjJweNSq7uSIA6e2hI7AyuYCX4Uo/NcTsp06Hg0VZuGDCFaAIxDb5hfh5/8QHHYHQ
         S+C87mF3C5MKLDlDUbnYtbzOAeLlr/Guy/dhIxo+Z4a2aO7uzmqLnU6NtnwdhoDJdU5s
         Dm6sACHTHdHlObZK7LyQNWF55a9IE0d8jzNEQ4wnIEKB38tkzoTkjNLW+pKOMfa7sSRh
         VmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912885; x=1705517685;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN9Wo59ib8rrxmGmkNNqnPBXMYJ/gbEqO2erlBDFegk=;
        b=YZmHhXvhEiQkHkzoDmuPRpWuzRcugopzDwEgHUwNcSz57w4KLN95SAYlrBonHaE4Lh
         sl56rjzM8A06fR9CygYA6eKE0cEGl6kCEhrTPWTdvn7VmaTziN7bUJcheDfvgtTbnGzp
         Zdrbyq9G1AuKBLc5pgGgTZ/u6VEQ1JnyiHN1i7sYNVk2pOV3jj0UjbfLmwRH+auhkI9S
         ctlDNae3U1OM5I3TjDY8l9k+4dFMMjdpAeTG7htfRvPeSennzlCj4a0Mu5eg7LNg0i/Z
         N0ZRtfTPFnH1nMeuQSLPxOMCIFNQLoDydNM2dRAfvYz1XpEzH5VXKVy7TjHSP89kMXzf
         tmFA==
X-Gm-Message-State: AOJu0YydQPO6HMcapSin/LM/mLyQVtUg9/pumIdBdoZqm5qtFgDI2qem
	vbVsC1lkOD6WPtKZvEWISvLmVzlsl7msGA==
X-Google-Smtp-Source: AGHT+IGo4oaNW6eXAvoWkHjodOro7xOyXIT4jd7O3rnAWXBHkEooUa8VsjrMm00Kq644jt0paq7FUw==
X-Received: by 2002:a7b:cd10:0:b0:40d:86a8:2fe9 with SMTP id f16-20020a7bcd10000000b0040d86a82fe9mr573312wmj.280.1704912885337;
        Wed, 10 Jan 2024 10:54:45 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b0040e55ee7fa7sm3173186wmq.8.2024.01.10.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:54:45 -0800 (PST)
Date: Wed, 10 Jan 2024 21:54:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: Fix a NULL vs IS_ERR() check in netfs_perform_write()
Message-ID: <29fb1310-8e2d-47ba-b68d-40354eb7b896@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The netfs_grab_folio_for_write() function doesn't return NULL, it returns
error pointers.  Update the check accordingly.

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for buffered write")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/buffered_write.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index a69e6e655320..25d861702bd8 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -205,10 +205,11 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(fault_in_iov_iter_readable(iter, part) == part))
 			break;
 
-		ret = -ENOMEM;
 		folio = netfs_grab_folio_for_write(mapping, pos, part);
-		if (!folio)
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
 			break;
+		}
 
 		flen = folio_size(folio);
 		offset = pos & (flen - 1);
-- 
2.43.0


