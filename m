Return-Path: <linux-fsdevel+bounces-76570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN5pHzGbhWmUDwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 08:41:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8D6FB141
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 08:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6806303C80C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9970F32571A;
	Fri,  6 Feb 2026 07:41:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249431D372
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363689; cv=none; b=HDd3a/+fsOxznoi+OSVw2LefEvQR7Jdj8b7Qzs8nXXeq7c7JHP6TwBWf6ZIlkkKi05phDwRf72r62pHFjQvAt2F5rEk67RjBCnrgjuroihDDvBlxYMdA1reiGJKdCAinEasmpRhXIbuf92gdvN9CGaEbqkddN9vV/zwyfNy5NGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363689; c=relaxed/simple;
	bh=bWFJs6r263JtjQNMFvJD5zRnrK9Z06Zx7sQEkDqhWnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hj9LSMh7d2Q0O1BaaKs+EpxCjyzonNOSZhqKV0bzMHwM6Rvbefmmw8rmw2TpXJJiuWsdXoM5krgWg8KDGvVaQQR2rIetLkHXj0ydChuZXHWqIJoPw4H5+GhuRKAMh6oFJIwELevaQE0I7J8TBacvx+zynszrXBVq1ogF5VbVX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7bceb6cd0so12884185ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 23:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363688; x=1770968488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSziNcqCzi3scPg6UFzBIzYNZ5dqi/bOe+UUAaW7TX8=;
        b=t3c98iaV7I4Glnc4fo2MlO+nQIgyk3WtnkKKGMnIzdYOvH/sjBMyZ1CLMbKzkSbFis
         oPWS8J/dZbzitXMw/GqDIsGPicPifqp4jjyjMOJgA5TUW9r28S9T1oK6XwHe3X4RFs+f
         /519JnOhYlAbFpnSC6LvTzkOcP6gfnzTB/jm9yQuxhCwvzgcCDIDe62U5skQjNvRk4YH
         tshZWvAkLFwDYmbxqF0sFd274wvAzU8r3CsWJRieUu3e9p+CzTl9Jq2YMlBPGCyvqYVH
         ftG0bfvWUTA3JiPBR6q55LWalwWjWTF9oqu+vbIcpfLHwXBqCQ2698Yv5rSxy4KTmwex
         XGlw==
X-Gm-Message-State: AOJu0Yxms3GQiF+pzTauinCtnR/9Crb/QEmvOavSBuOhN3+9RhKK0O8X
	IdKamdIsBZsvuyF56ezEI7L6nu9lK9gHFIyLg+on5bniIOIkcXzZEJJ7
X-Gm-Gg: AZuq6aKQ6q4KxTLbw5r1WIs1gm2pWxzol/9L5aK6+8KNjw9Dif3l5mSUG2WvP+DB134
	1hDhatJCOFJcnGZ/HyOvVyZX53J+vcJvtimuj4wQnRRvPwM2DJzhKcF/qRoLtZdExS8nUPcjqhb
	LqHLQwppQQv1xGGF5iOybKUjzdKla/COdLStCM2ERQFWR0nhm027Pd1FqVXYHUtBmCUeApYRQaj
	mJxR+vjh3/pJeX/56f7QAwlGu70+bgHSA+HwR3rbBhhzRrpztsFv6Uoeajt4WUO/riFWUn4gova
	7oonCSui+qw2HvuZ4MhQgaSvGLERlIZq389vVVaaDKUslc8gcWanZIGDdwyN238Fq8wYoq8SyMp
	roJrYp1m8Bt08/DTIchX30KH7SPl+ZuY6ge9mZl9I/dXOE8og8JrvlovznifjF8zP49aaOaNOdn
	Bdw/r4ZI0tlhVxl3l/vWEuLlBHBg==
X-Received: by 2002:a17:902:da83:b0:2a7:d7dd:8812 with SMTP id d9443c01a7336-2a9516d5133mr22647835ad.38.1770363688610;
        Thu, 05 Feb 2026 23:41:28 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c7a047sm13575125ad.27.2026.02.05.23.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:41:27 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	amir73il@gmail.com,
	xiang@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Anton Altaparmakov <anton@tuxera.com>
Subject: [PATCH v8 17/17] MAINTAINERS: update ntfs filesystem entry
Date: Fri,  6 Feb 2026 16:19:00 +0900
Message-Id: <20260206071900.6800-18-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260206071900.6800-1-linkinjeon@kernel.org>
References: <20260206071900.6800-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76570-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,suse.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cam.ac.uk:url,tuxera.com:url,tuxera.com:email,lst.de:email]
X-Rspamd-Queue-Id: 1B8D6FB141
X-Rspamd-Action: no action

Add myself and Hyunchul Lee as ntfs maintainer.
Since Anton is already listed in CREDITS, only his outdated information
is updated here. the web address in the W: field in his entry is no longer
accessible. Update his CREDITS with the web and email address found in
the ntfs filesystem entry.

Cc: Anton Altaparmakov <anton@tuxera.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 CREDITS     |  4 ++--
 MAINTAINERS | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/CREDITS b/CREDITS
index 52f4df2cbdd1..4cf780e71775 100644
--- a/CREDITS
+++ b/CREDITS
@@ -80,8 +80,8 @@ S: B-2610 Wilrijk-Antwerpen
 S: Belgium
 
 N: Anton Altaparmakov
-E: aia21@cantab.net
-W: http://www-stu.christs.cam.ac.uk/~aia21/
+E: anton@tuxera.com
+W: http://www.tuxera.com/
 D: Author of new NTFS driver, various other kernel hacks.
 S: Christ's College
 S: Cambridge CB2 3BU
diff --git a/MAINTAINERS b/MAINTAINERS
index 8b2476a91e7c..d813e9b120b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18651,12 +18651,11 @@ T:	git https://github.com/davejiang/linux.git
 F:	drivers/ntb/hw/intel/
 
 NTFS FILESYSTEM
-M:	Anton Altaparmakov <anton@tuxera.com>
-R:	Namjae Jeon <linkinjeon@kernel.org>
-L:	linux-ntfs-dev@lists.sourceforge.net
-S:	Supported
-W:	http://www.tuxera.com/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
+M:	Namjae Jeon <linkinjeon@kernel.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
 
-- 
2.25.1


