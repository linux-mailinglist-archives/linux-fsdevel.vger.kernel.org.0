Return-Path: <linux-fsdevel+bounces-75625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNSxH4bteGkCuAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:53:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B93A97FFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C712306BC59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77886360745;
	Tue, 27 Jan 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ieDUOjSF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176CE3002CF;
	Tue, 27 Jan 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531005; cv=none; b=uaNr6bi2GgMDEWwWG9VjnE4YHJDcMCoYTnotEvMX23KON/KNO+QgH9cdBskgsk4ro87dhaUTHBM9h52cdNEliJljcnO0Q96JDhRn8gLPCr6qmKH2GiK+yCmwB1NdTfrvrLDtoxfZp7QZY5Jvn2LJoD9fvHWrQkh0IAfXR/NY6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531005; c=relaxed/simple;
	bh=rtvMuO7zIBnMNSBoiBctJP+aSGce1F/3zIpriAFByZc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Bn299qyPtsbu9HUU1gTodMNN8olluKrXcV4apdzpySnQUB4RHT0uRNRicF9AQZco5SHtkAUT7cu2hzUl8EqKpTCvDyBO9toXEjPQmWagxuGZy8dTO9jUwPePuSrW0cMhx3gJXRE6F6YsOaXLdc7heOhccciPXdnn2seST48d2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ieDUOjSF; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769531000; x=1770135800; i=markus.elfring@web.de;
	bh=rtvMuO7zIBnMNSBoiBctJP+aSGce1F/3zIpriAFByZc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ieDUOjSFupVygcu430tOjOJigfCH4JSvGYxZMz+HnPb65jboCuP36zvk0TdkFii2
	 XQ/jGIZQ/snek0emeeWZpuu0cv4P5oNSKEdN6KocBMAX6fBh+V8okv4DZ6uWwtyDC
	 XcqkVrMtIhVTGomPrjrDuWSxiZTLZJUviH1aonWEUKJV0TDnK2rasLQfrTJq97pMO
	 RASwCKe9SOQ1/Cl5mtfMzuzL1+bxV2rTgsuMI8ZRBTE9fzdpfh9ZmV1NX1+wWetGD
	 0YCOqKQx6/9F+6/Qj70nLcff6P5g6CVQahFBphq+/XjZYF6uuuE36FktlIqLsFkXv
	 N61irJDixRBApOpvHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.251]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mft7j-1wDX9N2bbV-00olRv; Tue, 27
 Jan 2026 17:23:20 +0100
Message-ID: <9a89566c-c979-4a77-9c4c-6f80408c61fa@web.de>
Date: Tue, 27 Jan 2026 17:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Tianci <zhangtianci.1997@bytedance.com>,
 linux-fsdevel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Geng Xueyu <gengxueyu.520@bytedance.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Wang Jian <wangjian.pg@bytedance.com>,
 Xie Yongji <xieyongji@bytedance.com>
References: <20251225110318.46261-1-zhangtianci.1997@bytedance.com>
Subject: Re: [PATCH] fuse: fix the bug of missing EPOLLET event wakeup
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251225110318.46261-1-zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G5y/bVMa644lC8D8X8ux8l6dYcvVN46Q0bADPpMWaJM+MI/8tUj
 W2vygx1i7ZKiveHzPxu6HqivEJD2X6BIznkdyFMC4iUhTUSlDX9XfnQ09rVpFrfq09FKdAJ
 YmI5YaPaqHtaBaG7Hj2ldQSHqiY72iUGzHDt+P3mk9bHwe4m0A2EHScC7rze5IoxK86ndyY
 huLYem0fjx1xAyoJkP2oA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:72YRB650Ds0=;Fr/W0nAcg064FqzFPMW4WWu7zBq
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75625-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B93A97FFB
X-Rspamd-Action: no action

=E2=80=A6
> After receiving EAGAIN during read/write operations,
> the goroutine calls epoll_wait again, but then results in
> permanent blocking. This is because a wake-up event
> is required in EPOLLET mode.
=E2=80=A6

You may occasionally put more than 57 characters into text lines
of such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc7#n659

Regards,
Markus

