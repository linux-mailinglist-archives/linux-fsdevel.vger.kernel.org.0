Return-Path: <linux-fsdevel+bounces-77110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OVvEabjjmluFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:41:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B70CA134259
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B2C3070B0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7833DEC9;
	Fri, 13 Feb 2026 08:40:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D733DEED
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770972049; cv=none; b=OMLlNIj18juyiQwaD+Al/Kd7a2Inlea2JJN9YVHWHk1nBmeO+AX4B3JaPiXQWyCcOvuDf2Pupz7SWFOqIe7iw2A2uZgAjg2bawmSSbturigEP1b520GJaGm3oflOlWTsEcj8yb/vtsJ3dW/yqIZAdnHJwjFCgY1hRyBCNW1zKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770972049; c=relaxed/simple;
	bh=RfcOvw5yN33+tXsa55Q8cuBx0+mtbmhjRrjKaSuxylY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X03SWYHxCbdff8SCUEmMhJu3VLaQr/GRKM7yEIRndJKNofmU/qDv+vajOFAzNIM1+EVHZyfzvSoszjbJZf0HvnXvaVC0XJivHFV6EOHrgwlJHHFoFRv6RaMD6lJJwXw81BezecjHQFTiAp/MSpObOakZl7zS++l8jQ9rcg7hpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a8fba3f769so3052015ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 00:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770972048; x=1771576848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OeHnuiAfBG5nnkXA1A6CIwnItbqrfQoFZ8wRxTD8QCU=;
        b=IxCtGp/9bzGMeFBUkaZSpawyqNhwcxAMarKWAuggXjmvm1i4EN4WCoSoP2dkjX3S6d
         wv8Z3pQvp2flLXv5nh+kna98nHIHpPzaKOw/y9EiYqd9es+j6qaBKPziUw+FvJypvLO9
         ZhXxSuQWxwecfx6Dnmi+FohWZqRpRZDe2f3HtGwjog2LYiquujfeyr2I74IiiZ0ccUIa
         y2i0fRElBcdsK5p/lYUX2kGkZDRm4zP8zzyOssnw0XD0ltN8I6X6BS43PyuxqczJv7Ec
         nGNd2frPBh5BfF/uq/9+VRZ6ULvFwC51HGQIi/jFY2QqS0ZIlopnw3YDumLoAy2eHx86
         liUQ==
X-Gm-Message-State: AOJu0Yx3JTD2ltDNjHzVql4VAs8DFM/o1mUWczh+XQqt52KpBZAJxOhm
	qH+FDxDeaSXqr1MCjDSr0sTLU37GEGF1sliY4EvFkk7+UxxYgG7c60N2
X-Gm-Gg: AZuq6aImDyFpWznYR8JP90TPdNYKV7u9dYknieA1zeVrLiflR5pCQBSQdOoDjdDXeSI
	xefXFRJRHG1pxJzUJ1mP5kbMBAp3JN02bKarsSsmz3qb1G0CZ+GLcWM/oYE91qsXuRWjFr5Z76W
	BX3RS7hcaaMXcZKOXxflRprhsxJXsAKLmZklToV+W+Zp3J9pvYpp4J/bpnEdyqkgyu90tATdWDj
	jSyA76mcqMa76XyJ9kZXVGn7a4bOq4RoiEFQekI9sulGSupPitSdaR9PUE/v0+a34toXpD1uByX
	0ZfiGtYKU8BrMt6DKFCwyt9RX0T/d+vOhZwT9+pv0lFHPWPuZMpojx/Vbpsk2+sutQtKWXGRCfZ
	D+c53NEZlWABcMafrueDpGqBmo5OE1UGldTlbHiXCbE3ZgXE4/5FojC3AW9GEvltsDf+L4ddykA
	NbygNZujQj9DCcM8HMrzMv3kmJm1QMqQYMFFDQVvxl/WdzKLG7
X-Received: by 2002:a17:902:ea0a:b0:2a9:63de:b374 with SMTP id d9443c01a7336-2ab50521f0dmr11074055ad.3.1770972047655;
        Fri, 13 Feb 2026 00:40:47 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm75236495ad.6.2026.02.13.00.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 00:40:46 -0800 (PST)
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
Subject: [PATCH v9 17/17] MAINTAINERS: update ntfs filesystem entry
Date: Fri, 13 Feb 2026 17:18:04 +0900
Message-Id: <20260213081804.13351-18-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213081804.13351-1-linkinjeon@kernel.org>
References: <20260213081804.13351-1-linkinjeon@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,suse.com,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-77110-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tuxera.com:url,tuxera.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cam.ac.uk:url]
X-Rspamd-Queue-Id: B70CA134259
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
index c0fc6ec7db13..04a57d164044 100644
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
index ca37f4b27301..9ca0d93a4a70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18811,12 +18811,11 @@ T:	git https://github.com/davejiang/linux.git
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


