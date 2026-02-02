Return-Path: <linux-fsdevel+bounces-76111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPw1Dr0jgWmlEQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:22:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87924D21DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC1B304C7D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967734B410;
	Mon,  2 Feb 2026 22:21:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB234B19F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770070910; cv=none; b=hbdhLeA9dguJJcWNB7RjCr8M+A+3pdhqd0JqT5tqCQclrHBAlWHXN6EOx2t80hJljebo/KTlDt3EWFkU+dUXlsKjuqQr/UzdXsoOx750L4JNi5XndR6ypBVOwRs7Odke8Q7iE4xngKWefW2klaN3/TTekNTwjnlO3RTkrP7PK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770070910; c=relaxed/simple;
	bh=qIsACIMhslriEhiQTa5CM6EP3aeLfHepgJwOdBT3nEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=panHQ2/OfhzUfYxrjH9lvcvdbyjk0ZCW3gjwTXbSH98jDFLcc59JrpHoNLY1QweJWPWL1jpYcIpU2Ydm8nqbIIqvhzL5SQyosjRyyarUepw4D8tPT6IpCzjmY/BxGhJBLW09sxH+bZfEJ4wiaq417Thr/MaA9YKD8BvuTmnTeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a871daa98fso32141935ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 14:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770070907; x=1770675707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C24sTJzvWiJfSjj9cTXtwuMyinaZ+9glC5BRRHwlXDY=;
        b=rd78i/c1uYopJsx9Ae1HnUX6ttFitr8zSJzeNt0mAFr/4RX4jzJmHWLkwycsbYcl7p
         QEo4s07fM2Pf3sNWeAWef3W6kloWTkwQnJXvkB/7jcUZvva2rK/mTD6HS1aMEMuDQ8bN
         tdVanDtJ3V5ATBih210IwMZbv4ivz9EQyRjtUCMuWH9ToAgz7PbTVC+w6boScjT3n9m/
         57GpxoAcVqJ+MZUFRpKbD7/xzpH6tSSBuAyLa9LrWypbt8lCDZG7qXeBxCjyMvP2c0A+
         LL9FuFtPBPgwNuo5I2Utu/2nFlqKp2P7GD6iGgwrDge6VMXewq8J/mrYnv3x0EQ6t7nP
         hzAA==
X-Gm-Message-State: AOJu0YyaVY8fM7vWOlwR9pwpEAaOO1225fseK00fHlpbJba0kVfvDBSJ
	QwbUGaGwJVdp65u935J8Ta9MhAJxK1+GxJrSCfvP4kafnszQE2P7IKKXwnY0ag==
X-Gm-Gg: AZuq6aKbW+f7V/ZJljMjwRVCfQEMfgdVRSWncn9HbBIIu8DT9wmeiQjZewA2jc2c5NK
	mKex1113SyHAHFFmbeFVn0N89PQkFkMJT65o9wlBa+aZV0zAqK6yNqcBKgaRuBJYhzVexul8tjb
	qL0bk8RUtzAb+XIVdDzQnTE0FJ4UF3gC+cDs4yLwS4/GDTwKOjcZRM3hhjy68kvTgF23eBaGfcy
	krGhk581GoaejY9VBPPXMc+Oq0Z0cAFqDo63i4MLA/NZzQmGPHQwxHcyF8GYZSLldtV2kw80+f5
	RwJ/iLqLLUv2XTFSAR53QTgrvc7IYTvBICEyZmE7uNyhDKWgISwoeZIvbynYLEWMy4JGSzrh1Uk
	xaMqWN/0j+1hjnW9LWShkKlq9Jmz7D7snyAncIlNy478+hLtYgkuUq8o/u4wjnqz7pkyTw9K0d2
	8om1TSmRKFPb2N3l2gdfyX/2zadA==
X-Received: by 2002:a17:902:f78e:b0:2a0:9755:2e97 with SMTP id d9443c01a7336-2a8d9699b82mr124403205ad.15.1770070906686;
        Mon, 02 Feb 2026 14:21:46 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b277sm21019732b3a.29.2026.02.02.14.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 14:21:46 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Anton Altaparmakov <anton@tuxera.com>
Subject: [PATCH v6 16/16] MAINTAINERS: update ntfs filesystem entry
Date: Tue,  3 Feb 2026 07:02:02 +0900
Message-Id: <20260202220202.10907-17-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260202220202.10907-1-linkinjeon@kernel.org>
References: <20260202220202.10907-1-linkinjeon@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76111-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxera.com:url,tuxera.com:email,cam.ac.uk:url]
X-Rspamd-Queue-Id: 87924D21DD
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
index a8af534cdfd4..adf80c8207f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18647,12 +18647,11 @@ T:	git https://github.com/davejiang/linux.git
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


