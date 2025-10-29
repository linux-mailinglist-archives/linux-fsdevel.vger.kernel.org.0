Return-Path: <linux-fsdevel+bounces-66165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D355C17E6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C74E4AE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE4A2DBF5B;
	Wed, 29 Oct 2025 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncaprMeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDC27B4F9;
	Wed, 29 Oct 2025 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701248; cv=none; b=p2Qxu7FXfblcPMMRuNLS0rk2APWtRxeZsNg+JFDWeprMvIOZE1cFp26HdpOZdkBVlewoPb4igXoqY0frsZISblLVFS18u2heinuNk+J2W+KMuL0FfsK7krPz5VKr4KN8UyRSlW6npEgx+HtApIcE90cMYwbQjWB370Rqp/htObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701248; c=relaxed/simple;
	bh=cJPoAu6kIZGqunxG+SLTJ049yxXsUabQgx+x2yd/zb4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQX7mmWhuqB25u/VGtD+FE/ndDyJYQRh05GDms9Q8qQOFMIGn4tg+0BnG1bPPY5houojLsJCAs6xaKbPYMdHWgTqMo/LHnVZENxCOY3chVbWtUe0NbpdWuQ6oMNc3Yg29UU2345CdgNqTxO8ZoPWBD14T2UzL3gw0CZZuNgnSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncaprMeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114FFC4CEE7;
	Wed, 29 Oct 2025 01:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701248;
	bh=cJPoAu6kIZGqunxG+SLTJ049yxXsUabQgx+x2yd/zb4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ncaprMehkBtyf7UPSY9VxXTb0HIR1ogr27JTmss8pTV1OrYe96G8hRZi2oAa08gmm
	 E7Tc4VdZvmGzN7kZw+lmj69vE8KHExG+aoOsnmLbRN8t3OqR1bIUedDck/xAkmrxcn
	 jeykBKyg5hM+/W4xRsxFx4bCyJ/t7K+qetkC2Z96u6d6udRkMH9vJ+bjpv/ABkfRyD
	 cLehVGdHU7HzGhB4eKUw+VNa04Jz+8Hc5J/E9xCP2F3/3uht+j7Lk4ABPVN5v380xU
	 o2oU/C2x+50EUj9rM7mflmdGrgH7s/w4XPiWkXnEyCR5WIZ9pqFLGKLM++IzcY6FGj
	 fiHCxsDs36NVg==
Date: Tue, 28 Oct 2025 18:27:27 -0700
Subject: [PATCH 27/33] generic/050: skip test because fuse2fs doesn't have
 stable output
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820480.1433624.3763033606730126640.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

fuse2fs doesn't have a stable output, so skip this test for now.

--- a/tests/generic/050.out      2025-07-15 14:45:14.951719283 -0700
+++ b/tests/generic/050.out.bad        2025-07-16 14:06:28.283170486 -0700
@@ -1,7 +1,7 @@
 QA output created by 050
+FUSE2FS (sdd): Warning: Mounting unchecked fs, running e2fsck is recommended.
 setting device read-only
 mounting read-only block device:
-mount: device write-protected, mounting read-only
 touching file on read-only filesystem (should fail)
 touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
 unmounting read-only filesystem
@@ -12,10 +12,10 @@
 unmounting shutdown filesystem:
 setting device read-only
 mounting filesystem that needs recovery on a read-only device:
-mount: device write-protected, mounting read-only
 unmounting read-only filesystem
 mounting filesystem with -o norecovery on a read-only device:
-mount: device write-protected, mounting read-only
+FUSE2FS (sdd): read-only device, trying to mount norecovery
+FUSE2FS (sdd): Warning: Mounting unchecked fs, running e2fsck is recommended
 unmounting read-only filesystem
 setting device read-write
 mounting filesystem that needs recovery with -o ro:

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/050 |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/tests/generic/050 b/tests/generic/050
index 3bc371756fd221..13fbdbbfeed2b6 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -47,6 +47,10 @@ elif [ "$FSTYP" = "btrfs" ]; then
 	# it can be treated as "nojournal".
 	features="nojournal"
 fi
+if [[ "$FSTYP" =~ fuse.ext[234] ]]; then
+	# fuse2fs doesn't have stable output, skip this test...
+	_notrun "fuse doesn't have stable output"
+fi
 _link_out_file "$features"
 
 _scratch_mkfs >/dev/null 2>&1


