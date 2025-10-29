Return-Path: <linux-fsdevel+bounces-66169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BFBC17EC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B901889480
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9062DC77F;
	Wed, 29 Oct 2025 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp/gG8Yi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B72D8390;
	Wed, 29 Oct 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701310; cv=none; b=ucHIoUzqal22OeA4XonwVi7wUzwKpJ3cynZ3hYDpRppALrijWBjj44arpNEZ+EOuuJmS1QciWOgliS5sirLk6RJ6ezqXdCQP10/T2yve4alxMmFHCWU3xrVS1e1LMHgt3xWsC7bEp6umWf6quvzTcMZu8HVPXXsCd2DzRO3HN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701310; c=relaxed/simple;
	bh=6x3ob25e8IhFZ6Hr14J/1VNWj93K1EHjZ5SJqhaK1wg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/YU2cBo/IIrGvGMNonhUACH8uTFk46LNKanFB85JdbiMCCy4+lz3FTlLVHZHLGcQiJFhsqi8Uyy8tJLgjNQzP9/14LDGLdPtXfB9h+LEVkpELI5v3L7VJDRgp9gF3p5OaiZm4BQFGZXuetW/jHHjywo1t2ficH08Ee1xVaWjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp/gG8Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C8AC4CEE7;
	Wed, 29 Oct 2025 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701310;
	bh=6x3ob25e8IhFZ6Hr14J/1VNWj93K1EHjZ5SJqhaK1wg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kp/gG8YibNPMKXYrhYw854rDmnlm0qV8DfYEA16KhdWyqmD+VOINAe+iSUKPhAJf3
	 eQB2Xeeu7OEPbJvppcnqi6J0nzM3khkoRzzC7/BfrshXAwyEQGAcjN3WWiDvak8Nkh
	 y2iVR7Br2oAkInsZ4ZGH6UWv/5yi0TQfso4ju4L6cGCwgXJnPq6xu0x1/9p6LGfD6w
	 cZ0vTPwCRAgI7KNaytYtwlf/Z/93t2kcWYouHwb2cA82nBsMAwALF3/JzjCeMpPa6E
	 yOF90+UGgCRkm0IHQuPuKB/rf9ogqfsZSQHnhgUMyDQhc6G5rQKtY5vDaG+NN6o6d6
	 I65dgU9JjaVdw==
Date: Tue, 28 Oct 2025 18:28:30 -0700
Subject: [PATCH 31/33] ext4/022: enabl
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820554.1433624.16533934556600338284.stgit@frogsfrogsfrogs>
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


---
 tests/ext4/022             |    9 +
 tests/ext4/022.cfg         |    1 
 tests/ext4/022.out.default |    0 
 tests/ext4/022.out.fuse2fs |  432 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 442 insertions(+)
 create mode 100644 tests/ext4/022.cfg
 rename tests/ext4/{022.out => 022.out.default} (100%)
 create mode 100644 tests/ext4/022.out.fuse2fs


diff --git a/tests/ext4/022 b/tests/ext4/022
index eb04cc9d900069..5440c9f7947d16 100755
--- a/tests/ext4/022
+++ b/tests/ext4/022
@@ -6,6 +6,7 @@
 #
 # Test extending of i_extra_isize code
 #
+seqfull=$0
 . ./common/preamble
 _begin_fstest auto quick attr dangerous
 
@@ -21,6 +22,14 @@ do_setfattr()
 _exclude_fs ext2
 _exclude_fs ext3
 
+features=""
+if [[ "$FSTYP" =~ fuse.ext[234] ]]; then
+	# fuse2fs doesn't change extra_isize after inode creation
+	features="fuse2fs"
+fi
+_link_out_file "$features"
+
+
 _require_scratch
 _require_dumpe2fs
 _require_command "$DEBUGFS_PROG" debugfs
diff --git a/tests/ext4/022.cfg b/tests/ext4/022.cfg
new file mode 100644
index 00000000000000..16f2eaa224bc50
--- /dev/null
+++ b/tests/ext4/022.cfg
@@ -0,0 +1 @@
+fuse2fs: fuse2fs
diff --git a/tests/ext4/022.out b/tests/ext4/022.out.default
similarity index 100%
rename from tests/ext4/022.out
rename to tests/ext4/022.out.default
diff --git a/tests/ext4/022.out.fuse2fs b/tests/ext4/022.out.fuse2fs
new file mode 100644
index 00000000000000..9dfe65eff48e08
--- /dev/null
+++ b/tests/ext4/022.out.fuse2fs
@@ -0,0 +1,432 @@
+QA output created by 022
+
+# file: SCRATCH_MNT/couple_xattrs
+user.0="aa"
+user.1="aa"
+user.2="aa"
+user.3="aa"
+
+# file: SCRATCH_MNT/just_enough_xattrs
+user.0="aa"
+user.1="aa"
+user.2="aa"
+user.3="aa"
+user.4="aa"
+user.5="aa"
+user.6="aa"
+
+# file: SCRATCH_MNT/one_extra_xattr
+user.0="aa"
+user.1="aa"
+user.2="aa"
+user.3="aa"
+user.4="aa"
+user.5="aa"
+user.6="aa"
+user.7="aa"
+
+# file: SCRATCH_MNT/full_xattrs
+user.0="aa"
+user.1="aa"
+user.2="aa"
+user.3="aa"
+user.4="aa"
+user.5="aa"
+user.6="aa"
+user.7="aa"
+user.8="aa"
+user.9="aa"
+
+# file: SCRATCH_MNT/one_extra_xattr_ext
+user.0="aa"
+user.1="aa"
+user.2="aa"
+user.3="aa"
+user.4="aa"
+user.5="aa"
+user.6="aa"
+user.7="aa"
+user.e0="01234567890123456789012345678901234567890123456789"
+
+# file: SCRATCH_MNT/full_xattrs_ext
+user.0="aa"
+user.10="aa"
+user.1="aa"
+user.2="aa"
+user.3="aa"
+user.4="aa"
+user.5="aa"
+user.6="aa"
+user.7="aa"
+user.8="aa"
+user.9="aa"
+
+# file: SCRATCH_MNT/full_xattrs_almost_full_ext
+user.0="aa"
+user.100="aa"
+user.101="aa"
+user.102="aa"
+user.103="aa"
+user.104="aa"
+user.105="aa"
+user.106="aa"
+user.107="aa"
+user.108="aa"
+user.109="aa"
+user.10="aa"
+user.110="aa"
+user.111="aa"
+user.112="aa"
+user.113="aa"
+user.114="aa"
+user.115="aa"
+user.116="aa"
+user.117="aa"
+user.118="aa"
+user.119="aa"
+user.11="aa"
+user.120="aa"
+user.121="aa"
+user.122="aa"
+user.123="aa"
+user.124="aa"
+user.125="aa"
+user.126="aa"
+user.127="aa"
+user.128="aa"
+user.129="aa"
+user.12="aa"
+user.130="aa"
+user.131="aa"
+user.132="aa"
+user.133="aa"
+user.134="aa"
+user.135="aa"
+user.136="aa"
+user.137="aa"
+user.138="aa"
+user.139="aa"
+user.13="aa"
+user.140="aa"
+user.141="aa"
+user.142="aa"
+user.143="aa"
+user.144="aa"
+user.145="aa"
+user.146="aa"
+user.147="aa"
+user.148="aa"
+user.149="aa"
+user.14="aa"
+user.150="aa"
+user.151="aa"
+user.152="aa"
+user.153="aa"
+user.154="aa"
+user.155="aa"
+user.156="aa"
+user.157="aa"
+user.158="aa"
+user.159="aa"
+user.15="aa"
+user.160="aa"
+user.161="aa"
+user.162="aa"
+user.163="aa"
+user.164="aa"
+user.165="aa"
+user.166="aa"
+user.167="aa"
+user.168="aa"
+user.169="aa"
+user.16="aa"
+user.170="aa"
+user.171="aa"
+user.172="aa"
+user.173="aa"
+user.174="aa"
+user.175="aa"
+user.176="aa"
+user.177="aa"
+user.17="aa"
+user.18="aa"
+user.19="aa"
+user.1="aa"
+user.20="aa"
+user.21="aa"
+user.22="aa"
+user.23="aa"
+user.24="aa"
+user.25="aa"
+user.26="aa"
+user.27="aa"
+user.28="aa"
+user.29="aa"
+user.2="aa"
+user.30="aa"
+user.31="aa"
+user.32="aa"
+user.33="aa"
+user.34="aa"
+user.35="aa"
+user.36="aa"
+user.37="aa"
+user.38="aa"
+user.39="aa"
+user.3="aa"
+user.40="aa"
+user.41="aa"
+user.42="aa"
+user.43="aa"
+user.44="aa"
+user.45="aa"
+user.46="aa"
+user.47="aa"
+user.48="aa"
+user.49="aa"
+user.4="aa"
+user.50="aa"
+user.51="aa"
+user.52="aa"
+user.53="aa"
+user.54="aa"
+user.55="aa"
+user.56="aa"
+user.57="aa"
+user.58="aa"
+user.59="aa"
+user.5="aa"
+user.60="aa"
+user.61="aa"
+user.62="aa"
+user.63="aa"
+user.64="aa"
+user.65="aa"
+user.66="aa"
+user.67="aa"
+user.68="aa"
+user.69="aa"
+user.6="aa"
+user.70="aa"
+user.71="aa"
+user.72="aa"
+user.73="aa"
+user.74="aa"
+user.75="aa"
+user.76="aa"
+user.77="aa"
+user.78="aa"
+user.79="aa"
+user.7="aa"
+user.80="aa"
+user.81="aa"
+user.82="aa"
+user.83="aa"
+user.84="aa"
+user.85="aa"
+user.86="aa"
+user.87="aa"
+user.88="aa"
+user.89="aa"
+user.8="aa"
+user.90="aa"
+user.91="aa"
+user.92="aa"
+user.93="aa"
+user.94="aa"
+user.95="aa"
+user.96="aa"
+user.97="aa"
+user.98="aa"
+user.99="aa"
+user.9="aa"
+
+# file: SCRATCH_MNT/full_xattrs_full_ext
+user.0="aa"
+user.100="aa"
+user.101="aa"
+user.102="aa"
+user.103="aa"
+user.104="aa"
+user.105="aa"
+user.106="aa"
+user.107="aa"
+user.108="aa"
+user.109="aa"
+user.10="aa"
+user.110="aa"
+user.111="aa"
+user.112="aa"
+user.113="aa"
+user.114="aa"
+user.115="aa"
+user.116="aa"
+user.117="aa"
+user.118="aa"
+user.119="aa"
+user.11="aa"
+user.120="aa"
+user.121="aa"
+user.122="aa"
+user.123="aa"
+user.124="aa"
+user.125="aa"
+user.126="aa"
+user.127="aa"
+user.128="aa"
+user.129="aa"
+user.12="aa"
+user.130="aa"
+user.131="aa"
+user.132="aa"
+user.133="aa"
+user.134="aa"
+user.135="aa"
+user.136="aa"
+user.137="aa"
+user.138="aa"
+user.139="aa"
+user.13="aa"
+user.140="aa"
+user.141="aa"
+user.142="aa"
+user.143="aa"
+user.144="aa"
+user.145="aa"
+user.146="aa"
+user.147="aa"
+user.148="aa"
+user.149="aa"
+user.14="aa"
+user.150="aa"
+user.151="aa"
+user.152="aa"
+user.153="aa"
+user.154="aa"
+user.155="aa"
+user.156="aa"
+user.157="aa"
+user.158="aa"
+user.159="aa"
+user.15="aa"
+user.160="aa"
+user.161="aa"
+user.162="aa"
+user.163="aa"
+user.164="aa"
+user.165="aa"
+user.166="aa"
+user.167="aa"
+user.168="aa"
+user.169="aa"
+user.16="aa"
+user.170="aa"
+user.171="aa"
+user.172="aa"
+user.173="aa"
+user.174="aa"
+user.175="aa"
+user.176="aa"
+user.177="aa"
+user.178="aa"
+user.17="aa"
+user.18="aa"
+user.19="aa"
+user.1="aa"
+user.20="aa"
+user.21="aa"
+user.22="aa"
+user.23="aa"
+user.24="aa"
+user.25="aa"
+user.26="aa"
+user.27="aa"
+user.28="aa"
+user.29="aa"
+user.2="aa"
+user.30="aa"
+user.31="aa"
+user.32="aa"
+user.33="aa"
+user.34="aa"
+user.35="aa"
+user.36="aa"
+user.37="aa"
+user.38="aa"
+user.39="aa"
+user.3="aa"
+user.40="aa"
+user.41="aa"
+user.42="aa"
+user.43="aa"
+user.44="aa"
+user.45="aa"
+user.46="aa"
+user.47="aa"
+user.48="aa"
+user.49="aa"
+user.4="aa"
+user.50="aa"
+user.51="aa"
+user.52="aa"
+user.53="aa"
+user.54="aa"
+user.55="aa"
+user.56="aa"
+user.57="aa"
+user.58="aa"
+user.59="aa"
+user.5="aa"
+user.60="aa"
+user.61="aa"
+user.62="aa"
+user.63="aa"
+user.64="aa"
+user.65="aa"
+user.66="aa"
+user.67="aa"
+user.68="aa"
+user.69="aa"
+user.6="aa"
+user.70="aa"
+user.71="aa"
+user.72="aa"
+user.73="aa"
+user.74="aa"
+user.75="aa"
+user.76="aa"
+user.77="aa"
+user.78="aa"
+user.79="aa"
+user.7="aa"
+user.80="aa"
+user.81="aa"
+user.82="aa"
+user.83="aa"
+user.84="aa"
+user.85="aa"
+user.86="aa"
+user.87="aa"
+user.88="aa"
+user.89="aa"
+user.8="aa"
+user.90="aa"
+user.91="aa"
+user.92="aa"
+user.93="aa"
+user.94="aa"
+user.95="aa"
+user.96="aa"
+user.97="aa"
+user.98="aa"
+user.99="aa"
+user.9="aa"
+Size of extra inode fields: 640
+Size of extra inode fields: 640
+Size of extra inode fields: 640
+Size of extra inode fields: 640
+Size of extra inode fields: 640
+Size of extra inode fields: 640
+Size of extra inode fields: 640
+Size of extra inode fields: 640
+Size of extra inode fields: 640


