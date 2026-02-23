Return-Path: <linux-fsdevel+bounces-77982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPBhOrSDnGm7IwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:43:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF617A097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5ABDB300AD60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8B313E38;
	Mon, 23 Feb 2026 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EdJsEJA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC141C3C08;
	Mon, 23 Feb 2026 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865002; cv=none; b=Pz/t/Ig5iGh2hxerbOomjnVphXAPiGUPzUiA4jZN1BjCFZUSeQ+bhGeW5Dk640kqe3h/xRDtW8DqKOA7gS0NTB0FoK6wn36D/8twSWmEVueluhpkN56vFO3nTYMP6GXm8vVaNccwwuBIvo03h5091+Wao2nzrca99iHhZifgfio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865002; c=relaxed/simple;
	bh=qtDr+aFQmyRgNg7N5Ok+7BM4Szik93lbZP+gD9/tIwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZP2BTRpbtT+ggxsUtz3QEK6PVRxzRy/VIn2VczxijXTo7IToZ5bjwsw8EyDup3uZyeWP3/BltSseY50Mqcya1WZRnJ/TY64EXfFRL0KzedVCRn13nP3Kl3rFZZ7eirqn7O0Nf69FS4SY0Xwvsc7PJV/aDlA1JrorxS82u3SRZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EdJsEJA5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2GKRN5XvDP26mqQnbzXys2FxqUf2pJih5vywszULBwk=; b=EdJsEJA5KglMlR+xlWSJbS3evg
	IifS0bx8jjuZBb3a4O2eL5XJzYgxkMDZBHO3DL4xQ1SRFPa0VKMKHrjMeqipkvMnMq9NJl/nL5Og5
	C11orKQV/jepeI2kTphEPwKiJ7z+Ktj18bIy8n1G/lHBjse8SfqdG7mrUnfRSlAwD+tVEL3qQyqKs
	5rgmNzbTNi8WvelA8bpzP1OOHqQApBKWcY7HVqKY20BI+ZFtess7Ji3D1j0SN4pPLT85EbtMPkkSb
	eCN9NP9P/NohDTwqcrzD9dB5jL+MNNbv8PFmadDivPzkuqZvXtFL9x99VeMeNyWlAsIFrj9T1IIkj
	1wKuY7uQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vuZ1W-004Kcj-GU; Mon, 23 Feb 2026 17:43:06 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Horst Birthelmer
 <horst@birthelmer.de>,  Jim Harris <jim.harris@nvidia.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  mgurtovoy@nvidia.com,  ksztyber@nvidia.com
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is set
In-Reply-To: <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 23 Feb 2026 16:53:33 +0100")
References: <20260220204102.21317-1-jiharris@nvidia.com>
	<aZnLtrqN3u8N66GU@fedora-2.fritz.box>
	<CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
	<fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com>
	<CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
Date: Mon, 23 Feb 2026 16:43:06 +0000
Message-ID: <874in7wgv9.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77982-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wotan.olymp:mid]
X-Rspamd-Queue-Id: EBCF617A097
X-Rspamd-Action: no action

On Mon, Feb 23 2026, Miklos Szeredi wrote:

> On Mon, 23 Feb 2026 at 16:37, Bernd Schubert <bernd@bsbernd.com> wrote:
>
>> After the discussion about LOOKUO_HANDLE my impression was actually that
>> we want to use compounds for the atomic open.
>
> I think we want to introduce an atomic operation that does a lookup +
> an optional mknod, lets call this LOOKUP_CREATE_FH, this would return
> a flag indicating whether the file was created or if it existed prior
> to the operation.
>
> Then, instead of the current CREATE operation there would be a
> compound with LOOKUP_CREATE_FH + OPEN.
>
> Does that make sense?

FWIW, what I've been doing is something slightly different.  I have been
working on implementing MKOBJ_HANDLE+STATX+OPEN.  And the plan was to rely
on the compound flags, leaving it to user-space to handle the atomicity
(e.g. MKOBJ_HANDLE would fail if O_EXCL was set).

I was hoping to share a draft of this very soon, though it's still
incomplete.  For example, not all required compound operations are already
implemented, most notably readdirplus!

Cheers,
--=20
Lu=C3=ADs

