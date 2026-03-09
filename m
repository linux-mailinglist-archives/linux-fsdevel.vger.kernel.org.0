Return-Path: <linux-fsdevel+bounces-79795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJsnIsvgrmnsJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:01:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D8523B2CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAE5730138F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D83D668F;
	Mon,  9 Mar 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S+ci9FTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C53D332F;
	Mon,  9 Mar 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068398; cv=none; b=iyjWcl5Qt0cFIetb5YHvxZ89GSCTkLIsWnpRbHuIgeyQJZtLttcabY+VJzFX1WCq2vzOJ+rYGqCCdenqDQ4qUDMkFyImLWhmBzQgdUdESTp88r7SD4ZVOg5xCU4qj6p8WkN53PjmjO/WoTI+ehl2Sl+jhTqbMilNxBrZeRlLg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068398; c=relaxed/simple;
	bh=NIQoHdad/L9zSF9CIqAPdz1Q0KePcEBNa0APNpb+WyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I13WCXnQaiwlzGvbJMVLDmRADOJy6qBYSkAH+w5MoOCsdqDNjkGHWPeNhYJeARk4eUTnpCAod2vTtZZeuS6ZtCUOaVPnwmr313BwayZ4WQR6pM/sVwRM+IC7RNHpVrP0g9I3iYpBUnf2maNf2Tsj298ftCI3i4XZOZ+UP4Mo79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S+ci9FTn; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fKbgxeemlY0bzwjy7ceqTCiKehVLFazEzHftfhYY8kI=; b=S+ci9FTnSVPTp0PG6gQok7Yd7/
	Jcau2N3l9ZG9VMM9Yk2ZPC0DB+vYbbdnerpe6TBMffcKfRThzpqkUDSiyBlVU7B3z2M1VbfNXhJAm
	rArXMQtlOvHb+KRY04XTExTjuQHxTxyOrMv5ts2ygWVgc+2nXKaC+xzkHKSctlGTaaN+LT6DxLPqH
	RRn8ogX9ZxeQ8QEhec0+3xdAuvJsW5DXzb/XDR2qumolgLD5iCvKZO3Qai2Pjpg+DIGkk7ZPbp7cw
	lUW/MhWIrjfChIEVAF7eXh+YH43CcmarKghOVNkW4PrEr9GrrV4yKGRb/goV232H2TvHtmzaBNbSP
	hNYNvLKQ==;
Received: from bl21-120-186.dsl.telepac.pt ([2.82.120.186] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vzc5I-00C6B3-Dy; Mon, 09 Mar 2026 15:59:52 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH 0/1] fuse: restructure requests extensions handling
Date: Mon,  9 Mar 2026 14:59:43 +0000
Message-ID: <20260309145944.40000-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87D8523B2CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79795-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.011];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi!

This patch was going to be included in the lookup_handle patchset.  But
since it is self-contained and it can eventually be picked independently,
I've decided to send it as a separate RFC.

It basically re-implements the idea of extensions, making it easier to add
new ones: a extension can be simply added to the 'ext_args' array in
fuse_args.

Luis Henriques (1):
  fuse: restructure requests extensions handling

 fs/fuse/dev.c    |  35 +++++++++++++++-
 fs/fuse/dir.c    | 104 +++++++++++++++++++++--------------------------
 fs/fuse/fuse_i.h |  11 ++++-
 3 files changed, 89 insertions(+), 61 deletions(-)


