Return-Path: <linux-fsdevel+bounces-75311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMSvDubYc2lXzAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:24:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E63047A954
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02358302255D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291582DBF4B;
	Fri, 23 Jan 2026 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF+opV+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB62DA757
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199834; cv=none; b=J3zVvvk4/EeD7kpYzS3wqmBljWTWs9n0oRI/uGnL/+NjJcpv3WXy4xlbltws3XvYls07iu9S482VSbfisfqN0fqXuFHhkMaOm0ilzFfExuGojlP/jJOTGvq84lUzPvozrOfJ3K9wlncTwFX13f5eGwbffgZ2ZzyQplHqNARWzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199834; c=relaxed/simple;
	bh=TCYJ9pm4u9pY8XA2MVmsOObmE6D7jsYdHa39/d5HMcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rr7V2Dt1plI/ZmpgOI3wovAIyNwN6gsokRaba+CLSgiQmjBKpA70SCCHi5FMj4NKgCTSIlBObemZn4gWxCXx4IYMwQ9L9HA4nTjwQeiQeNkTnl/hFxe5ZEqXz988WXcDIbKMU/U6FFrcH1Ir7yNOonwjNU1d7ebLaTjgcOP3gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF+opV+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0E4C2BC87
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769199834;
	bh=TCYJ9pm4u9pY8XA2MVmsOObmE6D7jsYdHa39/d5HMcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SF+opV+gFpElpTEh5dma1Eqc4cd2BEVKbsd1ucMgZXsVvZkwYMxw12y67TwcT416k
	 G7pAyXs3qgWL5pYemOAEW/+DdPJBAivrosXeIIGFoULmCKta1RNVokMDrM9nk9xYHR
	 tGWoAVRdDhFPwOD8y+jvyB6vkDFon31QT1fcN3FiLzs0rVDfpRUSSuHGRydHrWJeEx
	 q4LtYid2aCM0SpFBS9Zn6r2joNSLUkCvzY5kA/gZno4TJfAbYDUR2z57SnlpfwxkrZ
	 QanPVyPwBeTHvb/42HPUQBmjwQuK+M6FsHAhZVOOR0RnuXxIDTfMv7pwRdAKJVvr7g
	 U0mSvlWc5z7hQ==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8947ddce09fso24289096d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:23:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX82fSdyFvZOCWi9LwDkpDS8S3cj4br33HATeQuqcClpmTqOMHKmuuFfzNirTLuEOBd52w6N1B3BeDAIwQS@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkSYH+Is9VMbpPIHtuI2kGjqURswt3misl2KoGtr6No+JHu/p
	ROW21cQbjoy9ynoy9i6qW0WcIlBr9ESZ32i14K9v55nNg8Q6KzxE2znjQFvaZ9YbQ7alkIuieby
	NkgWEwl0YFpleO1Iv1s0FzsxlcBE6hVg=
X-Received: by 2002:a05:6214:cc1:b0:894:3c57:dbc0 with SMTP id
 6a1803df08f44-8949020dac1mr58981856d6.39.1769199833659; Fri, 23 Jan 2026
 12:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
 <94bf50cb-cea7-48c1-9f88-073c969eb211@schaufler-ca.com> <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
 <633aa038-4356-4db3-b61f-191cf56c73b4@schaufler-ca.com>
In-Reply-To: <633aa038-4356-4db3-b61f-191cf56c73b4@schaufler-ca.com>
From: Song Liu <song@kernel.org>
Date: Fri, 23 Jan 2026 12:23:42 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5-m9oVraESqht_OMwOf-b80LBC0w+DSKk9Kru7sF8d4Q@mail.gmail.com>
X-Gm-Features: AZwV_Qil2W6hJzceDSRZxA4srphedhZgK-8wrWEE_IAEq6nCZVjDWj78lZ3LHwg
Message-ID: <CAPhsuW5-m9oVraESqht_OMwOf-b80LBC0w+DSKk9Kru7sF8d4Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75311-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E63047A954
X-Rspamd-Action: no action

Hi Casey,

On Thu, Jan 22, 2026 at 6:38=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
[...]
> > Could you please share more information about this issue?
>
> LSMs assume that any mount options passed to them are options
> they provide. If an option isn't recognized, it's an error. If
> two LSMs provide mount options the first will report an error for
> a mount option recognized by the second. Since hook processing
> uses a "bail on fail" model, the second LSM will never be called
> to process its options and the mount operation will fail.
>
> The option processing needs to change to allow option processing
> in an LSM to differentiate between a failure in processing its
> options from finding an unrecognized option. The infrastructure
> needs to be changed to allow for multiple LSMs to look at the
> options and only fail if none of them handle the options.

Thanks for the explanation!

This issue is indeed tricky. Since we are talking about to major
refactoring of LSM hooks around mount operations, it is good
timing to also solve this issue. I will look more into this.

Song

