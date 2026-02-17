Return-Path: <linux-fsdevel+bounces-77332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEzVC8Drk2ls9wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 05:17:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CB6148B18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 05:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECAAF3008D68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 04:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8B18D636;
	Tue, 17 Feb 2026 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+HXpIHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AF14F112
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 04:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771301816; cv=pass; b=BH8ZB2q3ddPh7CqnTrMqnNgo9KcsqtPWaRKLQLqsQgOJP2tQyysD/GHh/f4Wy7d7D8P552UvRWIzgqBq9Hc0gBraML9z+4qlurCuKet3B4JyugTvPWzlPBJiNWlCOMEWrZOCkA5qcUswv5dZ6X8LsXRW8xmZDYwWGQ6M7fuArd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771301816; c=relaxed/simple;
	bh=qe+7XX/L5syn+cLvVHmf9Bl620oz//ebyw08Uel5J18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG39l69hfxcbMI/OQ/jnbnW3YIF9RoLTI+vLcrB8qcshOP2jTTrKx1p7UhvlMIotg2AE242dUU7ZFAHvJLEmBhXt6fKJCCLsRvfNO2irbjY4vr0kfktTIbvl4ZTiPgAd+aZyCbS/MlwDkJS9t2XYbbMMKMoqGf5Q+c9EQp9UkKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+HXpIHG; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65bebcbffe8so3142492a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 20:16:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771301813; cv=none;
        d=google.com; s=arc-20240605;
        b=M5JPyoognUt/bGUca+54LKPFuPMtGmtEVLhZ/1M3u+T3MRtLtjgj6eVsnnbwQTR/OE
         RqzfPftb90/HBExrfFaZnlRpduLgwNAI6VQAv3N8Gf1yMN1cSsT7dEzfZO7E5rQBEyQ9
         pAC246tAb4KjDVS2E6EaK/pREocjKNYiLnY7ifzktjf/jTmuq1GOo+OhCWn09dP+SnjX
         4mdKV3TaQrEdxd7HgvvIDdH3elOd44jM35hifQFNr8/Ffru1JqnAHL2jbasZLBmu8lIt
         xtPbpZ+l0fPnLIRTfaReoP8C6QXyvacd9TONaTz/o/eaTcaY+brsCLH3F0BCclbkOcU1
         VySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qe+7XX/L5syn+cLvVHmf9Bl620oz//ebyw08Uel5J18=;
        fh=B0Mn0P4Vuf34XpDbuOIrdZQDBys8XfHZbYvsAFJY+Qo=;
        b=gWcDt5y3mxiBZ7GYr6YcZS1reipGgamPQ4G7UJRHCRLTMgghNsWFDBEYkoOcDTx4qA
         /hncJUsiwWQUtF4Lp0fYCBIJyor0MD/btHrfCMKKFpm3auDUzGp/Lqep6eYSeDDWmONg
         Jjw8SXAZfFLY7mg4unIRXzoreJGsZOfWbKuAkuJ27zE9qnDzhg04FrvFAZGKHEeMEpSd
         UHZyObzalS10dcn78HD4BaXYhiur2JY5DliWFP+IXB72Qj2/3ktfebe9Kjj8RMe6rci8
         R3xNtYJFhJfCaQrvHcXYbg6wg4NUhQD9jHjkEIoUT9zkVB3m6YomyWIFpuzkos0MNBX2
         ZW3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771301813; x=1771906613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe+7XX/L5syn+cLvVHmf9Bl620oz//ebyw08Uel5J18=;
        b=B+HXpIHG0tSTxiI9EhZ0HTLNVrd3JB4Xvv9hlsXrPnUq9zZhsBfOYL7wVgqO8iCBF5
         SWKUfVzoc4N1pQmQ1IQKOUlIsVnZj+lfAjxA7H4GHZyI3kpkMzeRiX3YobR2jN2wqRz8
         WQTQcHTJBcgBnEvVz5XSNNPrZqz1f6/m2R5rlNI/0PZiYY+MGywlsDPuYgzXF3FLKGgJ
         kzo1KOc5b7GMMQTnuV75QA6P9bj8PLhz2JzuIeMuak0GyoHUiteY8AlgXuYF7Vqrc1wl
         cjTs4XuGF3YfbzY6i4QuSuaGGVPokJYkg9lnYv84pHCSpu8bT7DRa0zHVScqPqV4E9wm
         NGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771301813; x=1771906613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qe+7XX/L5syn+cLvVHmf9Bl620oz//ebyw08Uel5J18=;
        b=HrpJT38kAKfOBbqoLzXmyg7onwGV4EiK+Hg+VTChiiGKs8Ok29itdS2btmU6rNW6HW
         tQ/olnt9z0OqVnhh2DeQWhAymLfRq8ToKC4o2T1snRPwvQxlhBnEFYUY5MbgyxRU8cK/
         cUsInrh024L7I/+Al/ujbiyYVKBZxtOVNCeAO1wSHt7YQGKcWa65j9f2xcqm5B2kj3n/
         9R9utJHTFiYaJArcftC0pyuD1CiDhQ3PeQreugrTD1VU80VOFmub8CDT+bjmOSMXEGpN
         06HzOSn1taNE9GSpqswCoyDEnl3ejmUxtpR48OoYk/vLmHQMiNjRfyWdVKvQFOPRB7u6
         YReA==
X-Forwarded-Encrypted: i=1; AJvYcCXzhduoVAZCh+eoFfmj8qlAjJWI2ZwTbX5SZN0f6qXBmH/5Qj1pZLJMJz4epxsSWSRed+akBZvAPZkOBntB@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjD5FNYSsOul60pwyP36vKJa285+gWIFecqGW1B5dgUSPKTQX
	5pDKv7fL63eJ92AHk2UrDULg4M/IkRtb+Xvx+Z7Cj0jjfgV9ZmruTRe40MKLTa5/heXffpeJegt
	LJqnlqroAeSdH085uPxGb6Yk8oiBWS3o=
X-Gm-Gg: AZuq6aJsWJY2ked/Av0yiCuzsid4Qbr+uDewwVllMY/qRq09bqiX+ZlchJwMXdM47Rf
	aZnH2oVqZAdxHoIkNrgFm8jLldbRitdHdYyD0wI6a5atSo0LWrXlDdFvl54YZX2fOOYEtsHjnpA
	N8rB3CV5dckNjMqhZXR7ywTpyitd4+JfgD8yFm2OrMjPDuJ8LCpDtNnDQXR1oTh0tucwpWp7IXf
	8lxIAsSGqgFs1ZbADYRFWCr/nhH9Y7XAH5M0k0iTh9PTtBqU8sNA0GJ0CFvgMZgXoDpEaSWDFcn
	pyj8UA==
X-Received: by 2002:a17:907:3da2:b0:b87:d186:19e3 with SMTP id
 a640c23a62f3a-b8fb44a3778mr761877266b.43.1771301812795; Mon, 16 Feb 2026
 20:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <aZJmthYtk33KYDud@melos.hm.i.d.cx>
In-Reply-To: <aZJmthYtk33KYDud@melos.hm.i.d.cx>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 17 Feb 2026 09:46:41 +0530
X-Gm-Features: AaiRm51QHtefjwH_4aVN8UbkRPTl2or_N2X9XdmE9IAJs0YnwmTtQVL_DTyVRpY
Message-ID: <CANT5p=p6yw3eYJVXZc2CA2fBgBYpZ4W0uKivt2tCmtgos3GVdw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: David Leadbeater <dgl@dgl.cx>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, brauner@kernel.org, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77332-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8CB6148B18
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 6:25=E2=80=AFAM David Leadbeater <dgl@dgl.cx> wrote=
:
>
> On Sat, Feb 14, 2026 at 03:36:22PM +0530, Shyam Prasad N wrote:
> > I tried to prototype a namespace aware upcall mechanism for kernel keys=
 here:
> > https://www.spinics.net/lists/keyrings/msg17581.html
> > But it has not been successful so far. I'm seeking reviews on this
> > approach from security point of view.
>
> I have more context from the containers side, but to me this doesn't
> appear safe. Entering the right namespaces isn't enough to safely run
> code within a container. The container runtime may have set up seccomp
> or other limits which this upcall won't respect.

Hi David,
Thanks for these comments.
Let me look into seccomp to see if kernel will have any visibility into it.

>
> I would like to see a solution to this though, we currently have custom
> callback code to make this work. I'm not familiar enough with the
> interfaces but an approach where something registers also seems
> desirable because it is able to preserve backwards compatibility, which
> changing the namespace the upcall runs in doesn't.

Ack. Will explore the options and get back to this thread.

>
> David
>


--=20
Regards,
Shyam

