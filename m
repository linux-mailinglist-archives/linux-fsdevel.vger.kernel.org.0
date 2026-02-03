Return-Path: <linux-fsdevel+bounces-76214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EUAIZEtgmlFQAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 18:17:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91599DCA25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C811C300A583
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44D13D522C;
	Tue,  3 Feb 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="YQEdKaoq";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="S659JPgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a10-70.smtp-out.amazonses.com (a10-70.smtp-out.amazonses.com [54.240.10.70])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261FB31AF25
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.10.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138821; cv=none; b=sZUjAcHk6wpJ0HnTNcvI/XQniOOLcSag4X8yH8AcYF3BHUtBcZ/fRW1BXGsLki3Pcz653k0tNv8p9/TifXaWm1b/DP2Q1h/sWsx3JDaQTR4NQSCFz/DeEH0NsGTSnIKeR9b1QjjkQisnAK8tSM8XiSE5e2x7yJ3lmc0tgRum0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138821; c=relaxed/simple;
	bh=Fs1Pnax7C6WGnOU6Gwi74/7UWOiZlFIKwN9irIfAa0Q=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=Nwlln9E49X4I/4+ZHcyrC+/DWIZ44AwaphbL4+pUqN5payH24E5bz2rhPXvXXHx06IAERJnMrtBvfGIQpLUtbjUPdCUBcT8Tuzxl+m2jWFpQARW/DMxjAR+rwJql9JTcrBwKIxOakCvpCG/7ifoP7/ZvMbfh9k7OJoWAEk8svh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=YQEdKaoq; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=S659JPgG; arc=none smtp.client-ip=54.240.10.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1770138817;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Reply-To:Message-Id;
	bh=Fs1Pnax7C6WGnOU6Gwi74/7UWOiZlFIKwN9irIfAa0Q=;
	b=YQEdKaoqYbd3ALalswl7q9JY7w89mBpj4a7s0P2D9FxfGHrCH3JM7jBFocbQ9cq8
	nW0czK5CZwDbPBT7+zWWgv/P7pB8Yfa2h4+0WAyPrSisrZt8pfVeP3X2MSGrVZqJCkj
	icStg+CfzngJeZTeLjgvOTNOesMTYKEMK/6RUa24=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1770138817;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Reply-To:Message-Id:Feedback-ID;
	bh=Fs1Pnax7C6WGnOU6Gwi74/7UWOiZlFIKwN9irIfAa0Q=;
	b=S659JPgGCsAYj9YjGT+7n/IDy4ajE4zTYFqujBp2YqO5Vnv4gDv19P3XMqszHOrt
	yP/xkLp02xJQYZRNiFf+lYhptUakbaHyHhpYFeOFCH8snEggHytQGEELCF6L2LNMphd
	4FUDNLs3L+ucM2p6d5+HOL+OfJqwRrFc/ioRPvsE=
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>
Cc: 
	=?UTF-8?Q?f-pc=40lists=2Elinux-foundation=2Eorg?= <f-pc@lists.linux-foundation.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Eke?= =?UTF-8?Q?rnel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Darrick_J_=2E?= =?UTF-8?Q?_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?John_Groves?= <John@groves.net>, 
	=?UTF-8?Q?Bernd_Schubert?= <bernd@bsbernd.com>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Luis_Henriques?= <luis@igalia.com>, 
	=?UTF-8?Q?Horst_Birthelmer?= <horst@birthelmer.de>
Date: Tue, 3 Feb 2026 17:13:36 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: 
 <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
References: 
 <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com> 
 <aYIsRc03fGhQ7vbS@groves.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHclTBulzBvpdDlRkWaruEdNxtF6g==
Thread-Topic: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Reply-To: john@groves.net
X-Wm-Sent-Timestamp: 1770138815
Message-ID: <0100019c247ed1a1-966e181f-c23b-47ba-bb45-bbc80bcf1c56-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.02.03-54.240.10.70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.75 / 15.00];
	TO_EXCESS_QP(1.20)[];
	CC_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jagalactic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[jagalactic.com:s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq,amazonses.com:s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76214-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,gmail.com,kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[jagalactic.com:+,amazonses.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john@jagalactic.com,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FROM_EXCESS_QP(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	HAS_REPLYTO(0.00)[john@groves.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 91599DCA25
X-Rspamd-Action: no action

On 26/02/02 02:51PM, Miklos Szeredi wrote:
> I propose a session where various topics of interest could be
> discussed including but not limited to the below list
> 
> New features being proposed at various stages of readiness:
> 
>  - fuse4fs: exporting the iomap interface to userspace
> 
>  - famfs: export distributed memory

I plan to attend, and have been on the fence about whether a proper famfs
session is needed. I'm open to ideas on that, but would certainly
participate in this sort of overview session too.

JG

> 
>  - zero copy for fuse-io-uring
> 
>  - large folios
> 
>  - file handles on the userspace API
> 
>  - compound requests
> 
>  - BPF scripts
> 
> How do these fit into the existing codebase?
> 
> Cleaner separation of layers:
> 
>  - transport layer: /dev/fuse, io-uring, viriofs
> 
>  - filesystem layer: local fs, distributed fs
> 
> Introduce new version of cleaned up API?
> 
>  - remove async INIT
> 
>  - no fixed ROOT_ID
> 
>  - consolidate caching rules
> 
>  - who's responsible for updating which metadata?
> 
>  - remove legacy and problematic flags
> 
>  - get rid of splice on /dev/fuse for new API version?
> 
> Unresolved issues:
> 
>  - locked / writeback folios vs. reclaim / page migration
> 
>  - strictlimiting vs. large folios

