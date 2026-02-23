Return-Path: <linux-fsdevel+bounces-78112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBb2MPnhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:25:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975517F562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 821993032D02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3DA37F8A0;
	Mon, 23 Feb 2026 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/3cT8Qd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A52334C35;
	Mon, 23 Feb 2026 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889138; cv=none; b=psObJAEdzBaV6x0i6KrbBt7UyeC4pGTOQQ4oAVq8zNXgrIXQZRRJwMunAdQEweqWg7yqjluPbXTnR0i6unfIq8Vw/0pC6uSjjH/nVOAcmCxMxou7vrDOwMDvpo4feRjOO9Qybu5AxKn17klCL3PCdE0+neZ4zACJJi+vFTDDysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889138; c=relaxed/simple;
	bh=DmKeCRsVHDGf3dDqKsEI8WZZVC/Y0EBlCkgdCbOix+Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwr9G9n6ynWV3MVb4UcyaAxnh/d8k/mqkm2eoSKvD+CGJ/SqAfqBTEdZXmbjBBAxSskx+l3dG5RFwQPL8YJNQEJwayTv3QCe57ivvoxpFCAzfgoU0WC7LtujjhjraQwNv3NK3j78tIb6L+og01QszLQOtUWPazDepzCe5admZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/3cT8Qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0F0C116C6;
	Mon, 23 Feb 2026 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889137;
	bh=DmKeCRsVHDGf3dDqKsEI8WZZVC/Y0EBlCkgdCbOix+Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=H/3cT8QdZ3FeAslf2GNVpOgEiB5MKoFSXbqQRx2esoJ0D6yKQVeA0ojpz/62iGr5T
	 6JH3EnF7wBySLfXoLe2CQJ8WINsuCiUj2d+mK40FZs6dL7nqRlg9vtbCO/dn81YiKf
	 zjnNhYiobzzgXEo6UH4Dh/gwrPJbvMhcpwktkALdoY2KRA3W+f/fVtEfE+JfMvVPbU
	 Q4QgC8cIuWiZlORr9GAIIg89UJqXLo++bsVmddJaxK/4wX0WlqYrMYyKDt2q//fCK3
	 +3B8GItgYE9qZm0kojrp3I4mh0VysAf0FHl5uGIErrXomA0QhTFDTkJTGip1VUwL7H
	 uBmeGA1pBYHHA==
Date: Mon, 23 Feb 2026 15:25:37 -0800
Subject: [PATCH 01/25] libfuse: bump kernel and library ABI versions
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188739956.3940670.16460908513690924498.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78112-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6975517F562
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Bump the kernel ABI version to 7.99 and the libfuse ABI version to 3.99
to start our development.  This patch exists to avoid confusion during
the prototyping stage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h  |    5 ++++-
 ChangeLog.rst          |    5 +++++
 lib/fuse_versionscript |    3 +++
 lib/meson.build        |    4 ++--
 meson.build            |    2 +-
 5 files changed, 15 insertions(+), 4 deletions(-)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index f0dee3d6cf51b0..842cc08a083a6f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -240,6 +240,9 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *
+ *  7.99
+ *  - XXX magic minor revision to make experimental code really obvious
  */
 
 #ifndef _LINUX_FUSE_H
@@ -275,7 +278,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 45
+#define FUSE_KERNEL_MINOR_VERSION 99
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
diff --git a/ChangeLog.rst b/ChangeLog.rst
index 15c998cf1623b8..3cb95081d42d06 100644
--- a/ChangeLog.rst
+++ b/ChangeLog.rst
@@ -1,3 +1,8 @@
+libfuse 3.99-rc0 (2025-12-19)
+===============================
+
+* Add prototypes of iomap and syncfs (djwong)
+
 libfuse 3.18.0 (2025-12-18)
 ===========================
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index cce09610316f4b..826d9fee00a8ee 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -229,6 +229,9 @@ FUSE_3.19 {
 		fuse_lowlevel_notify_prune;
 } FUSE_3.18;
 
+FUSE_3.99 {
+} FUSE_3.19;
+
 # Local Variables:
 # indent-tabs-mode: t
 # End:
diff --git a/lib/meson.build b/lib/meson.build
index fcd95741c9d374..a3d3d49f9ba42b 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -44,12 +44,12 @@ fusermount_path = join_paths(get_option('prefix'), get_option('bindir'))
 libfuse = library('fuse3',
                   libfuse_sources,
                   version: base_version,
-                  soversion: '4',
+                  soversion: '99',
                   include_directories: include_dirs,
                   dependencies: deps,
                   install: true,
                   link_depends: 'fuse_versionscript',
-                  c_args: [ '-DFUSE_USE_VERSION=317',
+                  c_args: [ '-DFUSE_USE_VERSION=399',
                             '-DFUSERMOUNT_DIR="@0@"'.format(fusermount_path) ],
                   link_args: ['-Wl,--version-script,' + meson.current_source_dir()
                               + '/fuse_versionscript' ])
diff --git a/meson.build b/meson.build
index 80c5f1dc0bd356..8359a489c351b9 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('libfuse3', ['c'],
-        version: '3.19.0-rc0',
+        version: '3.99.0-rc0',  # Version with RC suffix
         meson_version: '>= 0.60.0',
         default_options: [
             'buildtype=debugoptimized',


