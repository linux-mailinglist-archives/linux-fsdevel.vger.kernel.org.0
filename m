Return-Path: <linux-fsdevel+bounces-74751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMQwOEIKcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:05:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3554D79C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 661E6963A8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430483D3496;
	Tue, 20 Jan 2026 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqrU9Mra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266953ED105
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949477; cv=none; b=OXl6LmfocX2Dgc2lQAAO1egX4mL97x/BtTUFABwERtxcKAfUaG8f18PIWxT04FbsE88qt8dpCRnRFxkP2kKPlwOYLiGcMkZ4/4wkx6btIKDbhzJo/7qGWzNNoTdu9rQBMSNIQO0PNe3QaqfaL07frFWUjMmg9ZJ4y48Wk8Jy7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949477; c=relaxed/simple;
	bh=sBiH3kHjXq4kkpEHlLNRk1CYeSOY5UsFqVEtiYtNDts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxs1NGYsMm9wjP4tCKUk9I75mJv3KvyO0n9vKEIxIDqb7IyzNLJ3IaubgC/qgFqWOIVRe9TDWNlaciF534iZW5wl0CRNJmp7JGR2Mx/pPiSeikmYfSOMky0MTXMBD2QLIIbMCcP+hHqaHwsUYgb9WfYMCR4WLlcypWOzRcr8I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqrU9Mra; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35305538592so8916a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768949474; x=1769554274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N5IpzxsDbHKTSxS2aEAvBEvlQTNm/HJfesgfGo191c=;
        b=bqrU9MrapSpuIUv10owAxq4gdsdjZc9KMZuBsnapo6kS0BL6M/SU1AWwLvDwQ2TaGD
         1NBVn20YnTdIZ5B0pT6aCBLk3ZqJw0vQajm2vqvT/DvziJCaFPd1USMvfrhP+vyzHKWg
         BISvzUBriBd35twGkNVznRI3A1scQYa9AoWEXX0mkYRBm2CSayJt5/39tiKr8/ympTPS
         Iu1YIxjPtk/LjCvFUiBcg3RCOiCj0Hvp2277gZ2z47cOe8s9+FUu7vd1ZH+FuuANRKcs
         1Ku+MrNFH4E5pCT3R+Zdz9AmI3yOzsm7KYTkRSaOHtEpcuhjjqXMZyJYfE8H+ah+WAQi
         5z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768949474; x=1769554274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7N5IpzxsDbHKTSxS2aEAvBEvlQTNm/HJfesgfGo191c=;
        b=eHEnv/OpiDdRsXYEM9S/rLUZBvW4b75nJwf6ywUwC86aoLK0gWX8JtqOZKEUPn1FAo
         ChwQwpAPw1JwLqK1+ehZ4QHXk+Yvq8eMYfBW7cciq6H7QHoeiwoeujnbtfg0/UwBEsM0
         NDbcqIsJjWZnPjYcuR6s3LwAYHh06R3DdzhSctHT25vb12cWQmJ1xBfuv0Fm/DvKIx0Z
         8Wvp0cpbjfYkJKODVAWoxhhJ0yumVo/RAzljKobS9htlHANR5mA86Ix0ch/Mw+gLqZd7
         jaUgyuuX6EMcDz7H6qMfWwV+7vzi7ID62ZRiUjUtXCvX/Fcl2Wdd7g+1lMh4YBGBoX6b
         bFww==
X-Forwarded-Encrypted: i=1; AJvYcCVihI6LkHd4M40BucMOwgljakFQDDDU9jz2k9tPCneyjan/orvNaMY47Fx1jdjDW8WLQoDcTg13nB/B0d8P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3blGcbixYFMT+MdyArUN9GdQZrxH2YtNCIl1PsJ4BRGM0A9Qy
	NGbWOzJfwuN6yRwVjDWAaw34KavhhGsgf6wgvC3UkKLMs5idrRguKwXuGJ7IjA==
X-Gm-Gg: AZuq6aLsiDm1B2Kv2rJFb9Gdo6fkKYzPoKGcBFaXAp11lfhFEu7uT2CYRl31qhakMwY
	VDfldrJ7V1dW3xz47Ba+28pOEf2OwcTrXhd2G3Y6T7Jy3Hl2IKdnt17T+s8cfmBVNxWbIp92QNG
	U2QGQ/PzqsG9a7GcytRi/FYBNjdqAGXgjnGUuRLQubptXpR+pPhdy1dEAnBI6Op+ARKi95pozi1
	jZYu00iWOV82wW0IqiP3dG+xXfCbwFIs78CDSvwbzwG2Pk/CwVhq3mbvXXhdWNkZQ45838Vklry
	DJyt+S4qfafkICiKt167x1snh4/OIi51UmckX10zad8glOviU3MPPYS11Fcntx23be+LGzZt61T
	c/cXzSEM59qR83BvrhQEAJHqvzc53Hw0eLW4gWJOA6xZ2bGRunbp6+GlMVv7G5G+T7/EIiTrhg/
	Qa/AKiVQ==
X-Received: by 2002:a17:90b:3d05:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-35273255e43mr13283713a91.20.1768949473628;
        Tue, 20 Jan 2026 14:51:13 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527310202dsm13051893a91.12.2026.01.20.14.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:51:13 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: jefflexu@linux.alibaba.com,
	luochunsheng@ustc.edu,
	djwong@kernel.org,
	horst@birthelmer.de,
	linux-fsdevel@vger.kernel.org,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v2 3/4] fuse: use DIV_ROUND_UP() for page count calculations
Date: Tue, 20 Jan 2026 14:44:48 -0800
Message-ID: <20260120224449.1847176-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120224449.1847176-1-joannelkoong@gmail.com>
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74751-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8B3554D79C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use DIV_ROUND_UP() instead of manually computing round-up division
calculations.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c  | 2 +-
 fs/fuse/file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9cbd5b64d9c9..adfedf436b17 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1882,7 +1882,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	else if (num > file_size - pos)
 		num = file_size - pos;
 
-	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	num_pages = DIV_ROUND_UP(num + offset, PAGE_SIZE);
 	num_pages = min(num_pages, fc->max_pages);
 	num = min(num, num_pages << PAGE_SHIFT);
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index eba70ebf6e77..a4342b269cb9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2170,7 +2170,7 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
 	WARN_ON(!ap->num_folios);
 
 	/* Reached max pages */
-	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
+	if (DIV_ROUND_UP(bytes, PAGE_SIZE) > fc->max_pages)
 		return true;
 
 	if (bytes > max_bytes)
-- 
2.47.3


