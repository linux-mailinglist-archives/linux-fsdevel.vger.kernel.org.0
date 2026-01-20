Return-Path: <linux-fsdevel+bounces-74752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIN9ELULcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:11:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B34D8E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD8B20764
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3EA3ECBE8;
	Tue, 20 Jan 2026 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqo30YzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF758261593
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949478; cv=none; b=pyZcaguRB5vhmardLcmaLBffBKLgNoSB4QOQmZxo4a41b0yQ92Z6y+lTRyJ1YKlt7m2DYrCGSGaTKT/CknvEdv5ieC34CMh3IldVgmJov8JINAePJEaNFNdVJrm5eHkKFlEoiLVBOhEFyHKj8+JANRWqyQMrneZrYNmALwA3sqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949478; c=relaxed/simple;
	bh=in4l6ea534K4B9h5VMidaAMdcjaJMOlDmL3L2SuZroI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3IuPbeN1WWPk/KVmkA5SbvpykwK7uEZ6fdfKPcIR81yE/vBMFiMZbNwJZDPpk5qeaGYVgrb8ArMBcyerfvtJDM1wrOkf5R0QpKjbLAG7Ws7phWUTOtCojMN/o5+Mzheco3CMGY81LD8WUruJ3bF2aqQvhketp7998c2kTvDPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqo30YzG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f2676bb21so59189625ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768949475; x=1769554275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adfnU7dd00uOgz6Q0IUZakHTx9U4nFjh6IfLsBFaVhM=;
        b=Hqo30YzG22pUfZ2AbKN9BXnfEXg5AV4cbUZw8chEtc0jscrYj3pWSv9tqMQVaH0VkD
         C/uob0yrpuKaPHb1rCZBU6mkTaksHsdG6y7Wmg5T75HAQA5QXQFj2FFPmY4zRBB7oj1f
         Z+iuEewvBOvPINDWeOMfy+b2QYYcMEqREdbgPnJ19h7VFFRcs6a/1ZJ3lShYI2cuj7J8
         tYgieWNYeS0/WIFK2sQ8Th3ZoXmTSasMCJJHM2I5znpYZ2xvf/oCHUs7JzMwgwpD6yGm
         NSTe6Jgz19qVDtfZ5VrHhKBUD4jflRe9hJjlXL7BYyBj6pSFPXayzB1QBfkWVpjRV0mS
         AcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768949475; x=1769554275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adfnU7dd00uOgz6Q0IUZakHTx9U4nFjh6IfLsBFaVhM=;
        b=lzSFWi7HcG9zophpHl9y4Mp41Jj8/JIdpZdvPWBmzRf6zZyj/ae7bRU6pRgFsacQiC
         nX/DXph1rWijM74zR4lc7OJAfcH8VLnoG2nwmGP/S+KKFRNVyNhK93u/uqXtersorEP+
         0iGcR8RdmF5Yh1V7uljY0jdPB8b0/paaA+aa5EBEaHv+Xhu2NHNPtIVTM+v/+nqBdQ+l
         6GAWokFuD/5dOYc0CBxlgYhuenvLlRyWg/OysdqB6fptGVFRO9gjlkjcskEz6lxURTgl
         mi/R6ez+CzG2I9/DYujiTadod0y/a6Lrj9Gis8KVLfV3uT6v1UBkMFK8NGcN9rf4lIlV
         E8jA==
X-Forwarded-Encrypted: i=1; AJvYcCVpQYn/t8L//TPwJsvb5akSZknE8fGpRH5PoPLBCfinyIsj1NLrv1DxcrxNl3CEUVhieR8A/YV+c90T0XUb@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+6VHKiiYlWKgeXSlkU9Mz3ZqXppk3akDeFx3T6uaBKWVB9Ua
	yNM7JxhJwkOFxzNOzUzUhncRxN5aRG547NJfG++qK7mYAla4szalBdmB
X-Gm-Gg: AZuq6aJsKqtqeD+/zX3QrjT6rriKHL81JiV253Tvn2wp973y2NMmnVVJu0GWn63SD9q
	YxeiQ49WNsF+GugqTeVg4aF4YpD82WDZQpoiXZwHAtW7iSBcp/cPsNVz3uib+SpyguKfOwFosMr
	U9f96VVes+dV+8AXXmDdcgXTHfQy6IBD4FK2w3H8xMher8G6/rbUXWokt73G7f2+KZbwulysI0u
	Wu1ovcOHIZyvWGZX4H52oeABRqBaXZahznHQPMveAeWPqTEZGu0ubNW3elC/G0rgFvarvRet1iQ
	sIdrSgVE4JM/C9XyyFp8JmKN64KwjsTwkxsaMXrt29JEVc72UFsunnF9AeGrPkY2KyniMk7DjOl
	FdRA90fTmDYkw50ANSd/cX5U97/2qwMQH7+HOuwM2D48ME5sjaBnxlnaq1ZjYfL21XDDtRrzv+T
	cU6LQm
X-Received: by 2002:a17:903:40ce:b0:2a7:a6fa:ede4 with SMTP id d9443c01a7336-2a7a6faf37bmr1051475ad.48.1768949475043;
        Tue, 20 Jan 2026 14:51:15 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193da7cfsm134490565ad.61.2026.01.20.14.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:51:14 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: jefflexu@linux.alibaba.com,
	luochunsheng@ustc.edu,
	djwong@kernel.org,
	horst@birthelmer.de,
	linux-fsdevel@vger.kernel.org,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v2 4/4] fuse: use offset_in_page() for page offset calculations
Date: Tue, 20 Jan 2026 14:44:49 -0800
Message-ID: <20260120224449.1847176-5-joannelkoong@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-74752-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ddn.com:email]
X-Rspamd-Queue-Id: A75B34D8E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace open-coded (x & ~PAGE_MASK) with offset_in_page().

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/readdir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..c88194e52d18 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -52,7 +52,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	}
 	version = fi->rdc.version;
 	size = fi->rdc.size;
-	offset = size & ~PAGE_MASK;
+	offset = offset_in_page(size);
 	index = size >> PAGE_SHIFT;
 	/* Dirent doesn't fit in current page?  Jump to next page. */
 	if (offset + reclen > PAGE_SIZE) {
@@ -392,7 +392,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 					       void *addr, unsigned int size,
 					       struct dir_context *ctx)
 {
-	unsigned int offset = ff->readdir.cache_off & ~PAGE_MASK;
+	unsigned int offset = offset_in_page(ff->readdir.cache_off);
 	enum fuse_parse_result res = FOUND_NONE;
 
 	WARN_ON(offset >= size);
@@ -518,13 +518,13 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	index = ff->readdir.cache_off >> PAGE_SHIFT;
 
 	if (index == (fi->rdc.size >> PAGE_SHIFT))
-		size = fi->rdc.size & ~PAGE_MASK;
+		size = offset_in_page(fi->rdc.size);
 	else
 		size = PAGE_SIZE;
 	spin_unlock(&fi->rdc.lock);
 
 	/* EOF? */
-	if ((ff->readdir.cache_off & ~PAGE_MASK) == size)
+	if (offset_in_page(ff->readdir.cache_off) == size)
 		return 0;
 
 	page = find_get_page_flags(file->f_mapping, index,
-- 
2.47.3


