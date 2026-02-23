Return-Path: <linux-fsdevel+bounces-78200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCK2HxLonGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:51:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D53CA1800C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A2E4318CE8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B537FF7F;
	Mon, 23 Feb 2026 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdUUkO7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFD23AB9D;
	Mon, 23 Feb 2026 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890500; cv=none; b=D8Noxr3kjDM2COJdgvwhwTIng+PrzzKJ4aRC/C7MJcpfagd+mHayiX3KaAEtDaQXoweC3dSmbm1H5DYz5ZTyK0oVDYawjYj+bARK7nKah2TPr5riUQwKYI5GrNTFFuqF4Ubxtpmgyx4QtDfDZR43Q5ZVuP8Yy+MtSkMem7FL7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890500; c=relaxed/simple;
	bh=KHl4n625Af6eME5dUyAG8Q8ffCdeA4hxnNyL0y08xbY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qv8hRP73x77IvPSSHjQPG45qTyh9RSPx6t/ahRShqpg+gb1nMnUk34Ls7NSXdwGTbyvC4ymJ3rzGsloF3ZKHGZRG51HnyJ6wkT5kRtjXlj1wNqtsTNDPLfmipTSKxmyv2hwsVxSifNPoMcDYpHmRV/vi7HfK4eFUc0ITC4OmZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdUUkO7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B28C19421;
	Mon, 23 Feb 2026 23:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890499;
	bh=KHl4n625Af6eME5dUyAG8Q8ffCdeA4hxnNyL0y08xbY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FdUUkO7mq3aspQuRS/slrkQ59v5c4x1hgGS+LSqwHTo9RkpzV6k9C9EcyUAYA798o
	 3xFj16W2NtavO2S1asdSii0jma+s6NdJQQo4bLnyOHdWdxl4GD3UVDaHB0R2G4e6TI
	 /nHhSVZ8CsUPqf0BSHS3ExENw/5tD1pTbxF60huYUxOukZwUnu79HBBch8HSUn0Owy
	 txA5gPUtUIoZ+Lt8iaOZkKTaHAiKGGMVqqWU+O7T805lqggdHC9otMtMgqYR4F2p9t
	 lCbpkSLUQbdbEAQC0/B44an5tJrCZ09eO7dNT1zSHYZZCKCICuvcaCQiWifAESVuYn
	 0DIaebzvzUe0Q==
Date: Mon, 23 Feb 2026 15:48:19 -0800
Subject: [PATCH 8/8] debian: update packaging for fuse4fs service
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746099.3944907.7569877819844045765.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
References: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78200-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53CA1800C0
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Update the Debian packaging code so that we can create fuse4fs service
containers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 debian/e2fsprogs.install |    7 ++++++-
 debian/fuse4fs.install   |    3 +++
 debian/rules             |    3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 debian/fuse4fs.install


diff --git a/debian/e2fsprogs.install b/debian/e2fsprogs.install
index 17a80e3922dcee..808474bcab1717 100755
--- a/debian/e2fsprogs.install
+++ b/debian/e2fsprogs.install
@@ -50,4 +50,9 @@ usr/share/man/man8/resize2fs.8
 usr/share/man/man8/tune2fs.8
 etc
 [linux-any] ${deb_udevudevdir}/rules.d
-[linux-any] ${deb_systemdsystemunitdir}
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub@.service
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub@.service
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub_all.service
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub_all.timer
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub_fail@.service
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub_reap.service
diff --git a/debian/fuse4fs.install b/debian/fuse4fs.install
old mode 100644
new mode 100755
index 17bdc90e33cb67..56048136c2b28b
--- a/debian/fuse4fs.install
+++ b/debian/fuse4fs.install
@@ -1,2 +1,5 @@
+#!/usr/bin/dh-exec
 usr/bin/fuse4fs
 usr/share/man/man1/fuse4fs.1
+[linux-any] ${deb_systemdsystemunitdir}/fuse4fs.socket
+[linux-any] ${deb_systemdsystemunitdir}/fuse4fs@.service
diff --git a/debian/rules b/debian/rules
index b680eb33ceac9e..b5c669c58c3a9b 100755
--- a/debian/rules
+++ b/debian/rules
@@ -173,6 +173,9 @@ override_dh_installinfo:
 ifneq ($(DEB_HOST_ARCH_OS), hurd)
 override_dh_installsystemd:
 	dh_installsystemd -p e2fsprogs --no-restart-after-upgrade --no-stop-on-upgrade e2scrub_all.timer e2scrub_reap.service
+ifeq ($(SKIP_FUSE2FS),)
+	dh_installsystemd -p fuse4fs fuse4fs.socket
+endif
 endif
 
 override_dh_makeshlibs:


