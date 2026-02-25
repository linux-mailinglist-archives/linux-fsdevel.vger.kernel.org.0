Return-Path: <linux-fsdevel+bounces-78358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKf1G6TcnmkTXgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:27:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D717196768
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 438D13052504
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F54B395275;
	Wed, 25 Feb 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EnuDIEtN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07695393DD4;
	Wed, 25 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018722; cv=none; b=RZbGSIBvRZ56EYvQU0/z5nTDw+ZeicTwZJ4i5+Lht5gZ1Qgq/d8D2Z9VB73UF4ugqQak/OOpMQl870rZDm21okr3QVtVuUYL4fHqtpmpUaglDQKSQt7ZZhhQD0gkFpmalVDZKKoegvHMFTqYuPvzAOU6i6WA7lHhFV0WDv0Uutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018722; c=relaxed/simple;
	bh=lT22izI8sgoW/C/t80ZowtaCweHrvDkXSOs99B7bHPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aT5s19mjARf4NXxGEhwp151yWIAX4+mufos2taz8xu/rIvKbyoavjPXwwfCn5mVlTHOAfsCbAZtR/xTrOEGtFIeAcurYFh5U2AQfAm0w+/EyrlxQ5k49fQ/1yP1iAVz1Uc/DfMU7D8aPy+HL62TiV+muHcPJ5vnQI3J2wm21H1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EnuDIEtN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KCnleIjzefa5kbSjtVoZ+JQuA9tYgVXcHWLh9iNoYMA=; b=EnuDIEtNI/G/PsYvSXx5lGzawH
	dl9aXVIHsJIAg3xUxqMqF9j5LZX1v6IXJZhacnsIQushns1nXwnJeqXsQjP5woXzNHoAA+6U8SpnW
	851TMEZSr92L3uysnyMazOh7SEqhnkgkQ47Xx8pG5CiUJFQVYnzHyLPivsgOGU4WyQg6/nz6bIAwL
	GNrFxcoafRBvEEMBm6clIvsEEeVRlySN50+Duo+OxMW343H1XYJAJYdVw0pWX6rZK7WlpHdCRx1fq
	JbWZUtj5kZWLlajNLW5L+3N5728kAsvv9cvfCykp2hXHLwRm4MuWvU63MgEhhtb5Z96g1qpyrg6Mu
	eC1Gr0NA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvD0l-005CmC-Vg; Wed, 25 Feb 2026 12:25:00 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kevin Chen <kchen@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v3 0/8] fuse: LOOKUP_HANDLE operation
Date: Wed, 25 Feb 2026 11:24:31 +0000
Message-ID: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78358-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D717196768
X-Rspamd-Action: no action

Hi,

I'm sending a new version of my work on lookup_handle, even though it's
still incomplete.  As suggested elsewhere, it is now based on compound
commands and thus it sits on top of Horst's patchset [0].  Also, because
this version is a complete re-write of the approach presented in my previous
RFC [1] I'm not going to detail what changed.

Here's a few notes:

- The code isn't yet fully testable as there are several pieces missing.
  For example, the FUSE_TMPFILE and FUSE_READDIRPLUS operations are not yet
  implemented.  The NFS-related changes have also been dropped in this
  revision.

- There are several details still to be sorted out in the compound
  operations.  For example, the nodeid for the statx operation in the
  lookup+statx is set to FUSE_ROOT_ID.

- The second operation (mkobj_handle+statx+open) is still draft (or maybe
  just wrong!).  It's not handling flags correctly, and the error handling
  has to be better thought out.

- Some of the patches in this set could probably be picked independently
  (e.g. patch 4 or even patch 1)

So, why am I sending this broken and incomplete patchset?  Well, simply
because I'd feel more confidence getting this approach validated.  I don't
expect any through review, but I would appreciate feedback on anything that
would help me correct major flaws.

[0] https://lore.kernel.org/all/20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com
[1] https://lore.kernel.org/all/20251212181254.59365-1-luis@igalia.com

Cheers,
-- 
Luis

Luis Henriques (8):
  fuse: simplify fuse_lookup_name() interface
  fuse: export extend_arg() and factor out fuse_ext_size()
  fuse: store index of the variable length argument
  fuse: drop unnecessary argument from fuse_lookup_init()
  fuse: extract helper functions from fuse_do_statx()
  fuse: implementation of lookup_handle+statx compound operation
  fuse: export fuse_open_args_fill() helper function
  fuse: implementation of mkobj_handle+statx+open compound operation

 fs/fuse/compound.c        |   1 +
 fs/fuse/cuse.c            |   1 +
 fs/fuse/dev.c             |   4 +-
 fs/fuse/dir.c             | 650 +++++++++++++++++++++++++++++++++-----
 fs/fuse/file.c            |   3 +-
 fs/fuse/fuse_i.h          |  42 ++-
 fs/fuse/inode.c           |  50 ++-
 fs/fuse/ioctl.c           |   1 +
 fs/fuse/readdir.c         |   2 +-
 fs/fuse/virtio_fs.c       |   6 +-
 fs/fuse/xattr.c           |   2 +
 include/uapi/linux/fuse.h |  25 +-
 12 files changed, 679 insertions(+), 108 deletions(-)


