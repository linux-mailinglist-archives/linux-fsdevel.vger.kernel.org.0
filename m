Return-Path: <linux-fsdevel+bounces-66457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C3C1FD83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F73F4E9B0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47C31770B;
	Thu, 30 Oct 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPIvBRaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC121B142D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824108; cv=none; b=a+92QSQyJA003AEFx83NyJUSwadnuqO3wxeMcV8v81Dk17a0LPkhkiY/dCF9BknHMA52yYLi6viiA2ihpMM4hJaaC2qy7Ei/fWf7OCrhrNroguR5IpGtAEEe6rhULZOmW1tAWJoTmj1joXGAPXQfpkf1JOCxbGC5KF1vxJhrFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824108; c=relaxed/simple;
	bh=KlaYOnB2zIrOGxYethYD5P8DhWL9RjFbSyuNDnc9yxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCeEcZOxZphB7HM/5xXUYuTp+fnNXiiGKkTubOfgpfBt2ttSvbo6DBKD5RqtB5mTz008mIEw0cRzMX+l4Y/g/tu4lsr9IM0zkMGXi0H2qxGWBGC43ASKnDqOaENnsW0JYAGyf50Qer/q7g/xa6KaAiGLtwHmS8DAXGCM2PxInXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPIvBRaM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so1710833a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761824105; x=1762428905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1jQRJbq3W7ySqtjHUuXZDxThzL24ICiKDNUdWjz+YrM=;
        b=RPIvBRaME0TzsEGkqGarsH6SLFhE3ns4F76uwbg3lAuRG6dx3c5uZX2lji/hMPa7Hj
         8wepcqZ9WTr1W0X8UBzDjBmDB2QG1v47Z6bL5LRN5q6Yq7BDjop1Rx3JjEAi64v8pO/y
         uTsJx0LmEhqegYzK2+8DBQCPEFrS/wm/JGMaBMqRX8he2ozic6Gwwxv1XZcO0meZpyxy
         hnyV3FNtxCRClKuyYIi7VgtSAvfLLQMkaJ2RjO7fJJRDKyNA0fgp+eR9iryw7KmnKfxK
         9w4jTG8zGKTxe7Rd6GOCl6W6JBFc4TqgMuN8c96EAF81UDcPHkF+IasPKAb31pg7f25Q
         4n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761824105; x=1762428905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jQRJbq3W7ySqtjHUuXZDxThzL24ICiKDNUdWjz+YrM=;
        b=jTvEe/3U5bLP0jm2lDBV4clrR7dXn0JcuuxhTFVZY3nma2bXrQ2eY6n3jtJhz2PA/g
         I11LvNeS712jnvFYGbIgld0JzD1NjxLV0VL4y1JECubxa6VDPsFeXWMD6rkR5ZlLCYIk
         fNCIoMogAK9qM43acG+MTGcsDmGYYflsz7sO8L5+5ot1IgB07pr5s0XOghynMKlPjOqE
         /8vgi88QW/j2ouSqH+0koQ4iPanvJbf51TTtzEOH0RB+nj4da1RVsSnZy8f8G2l2DEdb
         RYgKaNgdneL1fOK2FUYqaXFlSRG3gUkTTQ0t3fM+J+i7RniGsqLoLzKwT9RYVskqc4lM
         qNlg==
X-Forwarded-Encrypted: i=1; AJvYcCV+/JG4WbdP/r3//+g2pOEJXdrqYxFetJLYnzVU/DHPaVjCdo2mJkTJkgx3wcZxakrKY4SAYLtYq1Dx3ngO@vger.kernel.org
X-Gm-Message-State: AOJu0YygGyF+OITrqovd7tC6lAVGEZW+2zbbBdSVibPLooO9lzcDa0cS
	0mQmouYei7raM5PVzC/oSgqJcDPXKr3HAO02mwM4R5+pZ7HPaFiAuQXi
X-Gm-Gg: ASbGncs1wtuauXDojoVIGubQ5Fo1aCg9RWRgCCQRFS7araMHSEMY1aL12cZtzx/Nmj+
	6rw1rzZ40fIKVEFBpAi5QftDm753Jm6+rwimA3RhtIW/Ew3tNkmdzELyxCTykfdEycTJXZrlQ3R
	Ygsbfr3qKwtbdCGIWSwxq3ROgjsWK8FcKDgqxdXAh6Ba0qgSenKUXCoGA0fgl6L45ihPxgJySHI
	AFNkyGouYx9dGnZcgr9dbeXmMRfOsxw4dqGXIDm45xIW153CB9hKUx6QnKsOFekFImkSyUuBwKQ
	RJoM06E1THqIwE0+DwOdylANWwdfGULmsqr3sDjrpf+VQ3naHUBDjtFBTZ6mnPMaIZLqzpyFcJS
	s8Qb9HjP4nsHb4GeJ/DI5Fb42NpANkkVwiL3QwcNmBBqVbfYM6B91qDtFZLxVBJymkqKUi72Sro
	tH5b9aR6cWBvwi9DOirHJpKPAhbqsMAKX0OL78INPFaCjxCPz3CC0Me/8tO6YhqlXyYZV8/uclv
	CSynQ==
X-Google-Smtp-Source: AGHT+IHwPDKpUkOtm37RUMhU0moYLn2XhmQqKXqCiHnNlwZMBqWVtEYi/CrdV0k+N7ak8l8WbmVrkA==
X-Received: by 2002:a05:6402:1ecd:b0:63e:19ec:c8e4 with SMTP id 4fb4d7f45d1cf-64044375786mr5486197a12.28.1761824104954;
        Thu, 30 Oct 2025 04:35:04 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-c54a-34bd-5130-fdd5.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:c54a:34bd:5130:fdd5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef95e8dsm14189735a12.20.2025.10.30.04.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:35:03 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:35:03 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 22/33] generic/631: don't run test if we can't mount
 overlayfs
Message-ID: <aQNNZ6lxeMntTifa@amir-ThinkPad-T480>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820388.1433624.12333256574549591904.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZpygF3SuZCs2oZOn"
Content-Disposition: inline
In-Reply-To: <176169820388.1433624.12333256574549591904.stgit@frogsfrogsfrogs>


--ZpygF3SuZCs2oZOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2025 at 06:26:09PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test fails on fuse2fs with the following:
> 
> +mount: /opt/merged0: wrong fs type, bad option, bad superblock on overlay, missing codepage or helper program, or other error.
> +       dmesg(1) may have more information after failed mount system call.
> 
> dmesg logs the following:
> 
> [  764.775172] overlayfs: upper fs does not support tmpfile.
> [  764.777707] overlayfs: upper fs does not support RENAME_WHITEOUT.
> 
> From this, it's pretty clear why the test fails -- overlayfs checks that
> the upper filesystem (fuse2fs) supports RENAME_WHITEOUT and O_TMPFILE.
> fuse2fs doesn't support either of these, so the mount fails and then the
> test goes wild.
> 
> Instead of doing that, let's do an initial test mount with the same
> options as the workers, and _notrun if that first mount doesn't succeed.
> 
> Fixes: 210089cfa00315 ("generic: test a deadlock in xfs_rename when whiteing out files")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/631 |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> 
> diff --git a/tests/generic/631 b/tests/generic/631
> index 72bf85e30bdd4b..64e2f911fdd10e 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -64,6 +64,26 @@ stop_workers() {
>  	done
>  }
>  
> +require_overlayfs() {
> +	local tag="check"
> +	local mergedir="$SCRATCH_MNT/merged$tag"
> +	local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
> +	local u="upperdir=$SCRATCH_MNT/upperdir$tag"
> +	local w="workdir=$SCRATCH_MNT/workdir$tag"
> +	local i="index=off"
> +
> +	rm -rf $SCRATCH_MNT/merged$tag
> +	rm -rf $SCRATCH_MNT/upperdir$tag
> +	rm -rf $SCRATCH_MNT/workdir$tag
> +	mkdir $SCRATCH_MNT/merged$tag
> +	mkdir $SCRATCH_MNT/workdir$tag
> +	mkdir $SCRATCH_MNT/upperdir$tag
> +
> +	_mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir || \
> +		_notrun "cannot mount overlayfs"
> +	umount $mergedir
> +}
> +
>  worker() {
>  	local tag="$1"
>  	local mergedir="$SCRATCH_MNT/merged$tag"
> @@ -91,6 +111,8 @@ worker() {
>  	rm -f $SCRATCH_MNT/workers/$tag
>  }
>  
> +require_overlayfs
> +
>  for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
>  	worker $i &
>  done
> 

I agree in general, but please consider this (untested) cleaner patch

Thanks,
Amir.


--ZpygF3SuZCs2oZOn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-generic-631-don-t-run-test-if-we-can-t-mount-overlay.patch"

From 470e7e26dc962b58ee1aabd578e63fe7a0df8cdd Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 12:24:21 +0100
Subject: [PATCH] generic/631: don't run test if we can't mount overlayfs

---
 tests/generic/631 | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/tests/generic/631 b/tests/generic/631
index c38ab771..7dc335aa 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -46,7 +46,6 @@ _require_extra_fs overlay
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount
-_supports_filetype $SCRATCH_MNT || _notrun "overlayfs test requires d_type"
 
 mkdir $SCRATCH_MNT/lowerdir
 mkdir $SCRATCH_MNT/lowerdir1
@@ -64,7 +63,7 @@ stop_workers() {
 	done
 }
 
-worker() {
+mount_overlay() {
 	local tag="$1"
 	local mergedir="$SCRATCH_MNT/merged$tag"
 	local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
@@ -72,25 +71,43 @@ worker() {
 	local w="workdir=$SCRATCH_MNT/workdir$tag"
 	local i="index=off"
 
+	rm -rf $SCRATCH_MNT/merged$tag
+	rm -rf $SCRATCH_MNT/upperdir$tag
+	rm -rf $SCRATCH_MNT/workdir$tag
+	mkdir $SCRATCH_MNT/merged$tag
+	mkdir $SCRATCH_MNT/workdir$tag
+	mkdir $SCRATCH_MNT/upperdir$tag
+
+	mount -t overlay overlay -o "$l,$u,$w,$i" "$mergedir"
+}
+
+unmount_overlay() {
+	local tag="$1"
+	local mergedir="$SCRATCH_MNT/merged$tag"
+
+	_unmount $mergedir
+}
+
+worker() {
+	local tag="$1"
+	local mergedir="$SCRATCH_MNT/merged$tag"
+
 	touch $SCRATCH_MNT/workers/$tag
 	while test -e $SCRATCH_MNT/running; do
-		rm -rf $SCRATCH_MNT/merged$tag
-		rm -rf $SCRATCH_MNT/upperdir$tag
-		rm -rf $SCRATCH_MNT/workdir$tag
-		mkdir $SCRATCH_MNT/merged$tag
-		mkdir $SCRATCH_MNT/workdir$tag
-		mkdir $SCRATCH_MNT/upperdir$tag
-
-		mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir
+		mount_overlay $tag
 		mv $mergedir/etc/access.conf $mergedir/etc/access.conf.bak
 		touch $mergedir/etc/access.conf
 		mv $mergedir/etc/access.conf $mergedir/etc/access.conf.bak
 		touch $mergedir/etc/access.conf
-		_unmount $mergedir
+		unmount_overlay $tag
 	done
 	rm -f $SCRATCH_MNT/workers/$tag
 }
 
+mount_overlay check || \
+	_notrun "cannot mount overlayfs with underlying filesystem $FSTYP"
+unmount_overlay check
+
 for i in $(seq 0 $((4 + LOAD_FACTOR)) ); do
 	worker $i &
 done
-- 
2.51.1


--ZpygF3SuZCs2oZOn--

