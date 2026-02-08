Return-Path: <linux-fsdevel+bounces-76675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGaFJ4OWiGnzrgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Feb 2026 14:58:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B75108D7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Feb 2026 14:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A4330160DA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Feb 2026 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394DF2C11D3;
	Sun,  8 Feb 2026 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlzhZwPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD07258ED4
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Feb 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770559064; cv=none; b=orMVHOnM9RUy/VHzuznMJQ/k8abMzGE8atcKGARAln5OKANU88kmXp6YKjieVkRW3XXdbJT930SAasr1jJDnJ0diYt6Aqe6+Y74eCBkILLP/93qVgvNmXDAA+TzZvAm6++g8sc1o3GoHkVp8P1kyBmy8VudlmJaVrBSfsQqcxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770559064; c=relaxed/simple;
	bh=xhyTR7L1Xk6xLLsc4Uh67Ujk2OaxH/3rxSWzd/DZhkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKSV1dmwt+SPRVM9szIc1vVPgI6NmvHP4jY9PVoMqodGeTbaPvaynoyTBQquBGkbSexLnXmLLyQHpufd18jdTYRS4Cimc1QfaYSFnpe0dq74tIa+XOobjLAuLFGC9Q8SiES9w5X7YySakSZT/1RtJuIBUd6unSVOzDYBmWxkHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlzhZwPl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4359a302794so1358589f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Feb 2026 05:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770559063; x=1771163863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laAbqFSG/YMXdSL9qlzHaO6Y+AMdhAXScO1IYuxjFow=;
        b=hlzhZwPlANcBcxQLxNRAe5dBpJAt4GiGn4kTw3wc3bECOqfBzEhy2FFfzAnYdGwJ/T
         yKKoj1mNm6BLu4H4w9vW0OBOge6RtbxSBNLBJ0Le+sh7ZNvrem9wrBCAc/6o4hhHac8P
         Szpqndn1Dvju5oCuDYeBSOr6xQKSJhPc5/xUfYCfztKPa0goi3HQnd+zUy4rMCFLkYm4
         lvibiBVp+inD0migRqtUrm0FJzB1mlz0l9utNRPDtIk4ksoemqlydTPnmEUKSaoRK21M
         OJUJILCsywSzVc5aEJnfKIOWyEX/LUP0re6PYHocHJVoAZ122G8tFDH4YsCfS7oNmaa1
         Lnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770559063; x=1771163863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laAbqFSG/YMXdSL9qlzHaO6Y+AMdhAXScO1IYuxjFow=;
        b=p7uJOI/CJwwHYDvmF2aWhQXWhDIB+oD4wa5cSm5D7aiDs0BhLIPTqagTZ96bBWteHR
         ZfUYC+rCYuLrmXTdc/X/l9prFYaLpo25osEjQTrBQVevB9Jk3vQAcQwC9u94BCZCnPhS
         ij8XmZJSTnwyUHAbEx/1EL6Kzn0//Un9vscGNWCj5A5luYt+p1lEfx/s3KbIby7vUQTe
         Kbg28biagKFeqTE/ZUUYVJS/cRlJ1GEXi/I0NJypwtdY51fEraGiHO6mpjrcDAPW3GU9
         J5jC3Hgxxw1xVoapeyjrfzRLR0mChz+tTpUbD+Tj43I9k2/zZDh1g6o2ku3wkHaJte4u
         KNww==
X-Forwarded-Encrypted: i=1; AJvYcCVpB++oL/FQWxSijPFVrFsS3OV9YFrHAqfQmipa8mssRjTIV+S/vhBP/MQQCCnMsZCn9C2/MUCBMs8lRp4L@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2U0Cg0/ESV18LFPnZcBTrmK80iCugTUt4aUBOVxrQwnhvFDw
	bPxKurKohm23PlnTbVj7O0aZ2e2SZ8hq43qwcDJWDnVANLgd4QW7MoXC
X-Gm-Gg: AZuq6aIEIHPLwUy69dLjwH3Qx2w6oDfdejV96u3h/vGMMh5IW+I6oxCtqxiC0QHNMpW
	W4B68iGcOfH2bEjIq7/PVo+qFgJlgJazmRPupzZaiCBVkbKhS7ppY7Y0+NGJThSDKx3WRalKD0x
	TWqUWD26WnKJzWl0pty4hC+pTRXT7WKDNZ/Ko4B/4RJstvRdCuHXFj/2zAi9onDKYcpraKeENry
	AtM7wwhb5XLKiRry36/lUBRhf0ydj9xJdoToypeRMqLP6M0CUEgYem20Mpf+ug9zjYaS5NL3tz2
	5r1SonJzBVNu5lNQ4UaiBIpSjaOKFMpswdpxTOlWdBdqG/dgoczv17t2YPxww1z2Hao0L1f2whM
	lFI7SC+25B9ig9NxcksCNqDKvHWl5s9laTJce+cZjb8Z8cjgaPi/7LXYxXx/Lf7r1BTrMVqLifI
	AXhZqACMZk977Kvh+aW/XvXKHHk8K7Gz+2ZobIyPw6OZNqsgKz+M/LkzO6VffIXILxzu2ifoZ+H
	1AYTiRVNhskvJcil8zy6NnsRrxQwHKuEQPpmCisalGzTHmagZtoRt6CZCGOyI7ZlwufqHk=
X-Received: by 2002:a05:6000:186c:b0:435:a135:7772 with SMTP id ffacd0b85a97d-43629244604mr11519638f8f.4.1770559062461;
        Sun, 08 Feb 2026 05:57:42 -0800 (PST)
Received: from 2a01cb0006769b001185461c960a9b50.ipv6.abo.wanadoo.fr (2a01cb0006769b001185461c960a9b50.ipv6.abo.wanadoo.fr. [2a01:cb00:676:9b00:1185:461c:960a:9b50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4desm20045169f8f.18.2026.02.08.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 05:57:42 -0800 (PST)
From: klourencodev@gmail.com
To: linux-mm@kvack.org
Cc: jack@suse.cz,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	vbabka@suse.cz,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Kevin Lourenco <klourencodev@gmail.com>
Subject: [PATCH v2] mm/fadvise: validate offset in generic_fadvise
Date: Sun,  8 Feb 2026 14:57:38 +0100
Message-ID: <20260208135738.18992-1-klourencodev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAFveykMPrkb=VYwQAjCEARsC_WAGfQXMz_gf8Q0CTHWHooNHVA@mail.gmail.com>
References: <CAFveykMPrkb=VYwQAjCEARsC_WAGfQXMz_gf8Q0CTHWHooNHVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,linux-foundation.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76675-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[klourencodev@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0B75108D7F
X-Rspamd-Action: no action

From: Kevin Lourenco <klourencodev@gmail.com>

When converted to (u64) for page calculations, a negative offset can
produce extremely large page indices. This may lead to issues in certain
advice modes (excessive readahead or cache invalidation).

Reject negative offsets with -EINVAL for consistent argument validation
and to avoid silent misbehavior.

POSIX and the man page do not clearly define behavior for negative
offset/len. FreeBSD rejects negative offsets as well, so failing with
-EINVAL is consistent with existing practice. The man page can be
updated separately to document the Linux behavior.

Signed-off-by: Kevin Lourenco <klourencodev@gmail.com>
---
 mm/fadvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index 67028e30aa91..b63fe21416ff 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -43,7 +43,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		return -ESPIPE;
 
 	mapping = file->f_mapping;
-	if (!mapping || len < 0)
+	if (!mapping || len < 0 || offset < 0)
 		return -EINVAL;
 
 	bdi = inode_to_bdi(mapping->host);
-- 
2.52.0


