Return-Path: <linux-fsdevel+bounces-76658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DLIFkyGhmn7OQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 01:24:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC163104470
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 01:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2EC30342A4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE3A1E7C34;
	Sat,  7 Feb 2026 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8TSQrwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358F1DF75C
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Feb 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770423875; cv=pass; b=BANS4TWj+ogTYrFQQSjhR4d6ZY+kvbKjrZ0Q7dvAIIUg7m/OzTjssWNdyHS+YLFr8r42o34vw09ApUkpDTT6dd93YYNKmKFYaMtWUbw+wlz7/dX5O745NHE3fXqjIucXzHGMNeg0PaE9gkeDoa90Ya8elRNdj9L9Ob94PYN4S34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770423875; c=relaxed/simple;
	bh=nz/X6BTvr+nL3B3hjTqOBHfNkcoeCHJoAFxDQVFk7AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXwn26RIEjkI4CqdZIJeAZSk1D4l8W7oBSP3Zs4ocrbz/QS6IYwItat5SYieHGjzcYRZ6mH5at98WUONevrMnEgwVo+g86ofDQXXg0fBhWoy/P3QsRuMxWRhJ6FERarKM9Z1lNF4gjdfM6ezKwlGFzJOdmalyWNqA09t63FCnJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8TSQrwK; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88888c41a13so32023526d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 16:24:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770423874; cv=none;
        d=google.com; s=arc-20240605;
        b=NWzy240oAKet9tqrDy8/2ao5cOrTUtUXqp//LANk4AVP1Id/iC9XvhZ2odCeem94Eu
         H/uEov4KI3njmmT1jWA5YJFIqqJzJaxODQg4cNkm7GbdZoTCodwMQnavy7Myql1I5NzJ
         EzWKKhuf9dLA+y6SjNV9yMYz20Bp/S6CpM0dgmmijFRzq+2OrUNhSaK399S3jIGheDr4
         8CLRtLuVp4Y5XPXFxtvVraVONO8D2kd6raqDeSpGC3k+r+wCopj+c8Yf1iQGyrFLPkMp
         x3FBHgtfTC2soZ5YMRXXtG+P1bk3TF9qCLMf9v21kWiONKQGC/SpkYvrBxMlE/T9X09W
         uSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nz/X6BTvr+nL3B3hjTqOBHfNkcoeCHJoAFxDQVFk7AE=;
        fh=bzsjsZObl+3f3X2d3YYM5I3a/5Rt/moTbco/RsNUexI=;
        b=WSUr45wP9NBybgUvRF+VnR+Wu0Wnc5HV654+tAYVGCRecTdlp31AyqRYM4wq8YehSN
         648brdVTQ7QhaZgdroLVBYlSp/aXHuGJJhTmJwCaBTbTC8Wu9HDTpe9dzrIyT8YN/j3l
         g14afpRsuVGhVLrz5xaIizb7kDPgTd+Qx1w57nEfTc8LXI5Ji6RnAHDmHWK+8Wz4gDFj
         /gcSGNXpm1kvDALylahHTCuEylUm+ooPO684eq9bQ4JPbF/3RvlZUX66exskhIT79goQ
         KIxztHsfhwxxLhYoyZXxgBPyF3D6Eznle3iQA04Ipipu/Y7lG1L5MCR/RXo+pIyWIuR8
         J+OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770423874; x=1771028674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz/X6BTvr+nL3B3hjTqOBHfNkcoeCHJoAFxDQVFk7AE=;
        b=h8TSQrwKj071jpHdqpAZ6FqpsWwGYuu18s9LA20Fg2mFmqADrOC3byZ0e5iELbpIOE
         RbwQIJgmPzTPV8gFxvelENrMrqPjUwWw6vyFOf0H+OFkXCKLJBrMcZohbXV59bZPHvuR
         5VKHFv6Qn09GRnDemMHW2l19GaB9SB/c0U9cmxuzFtE6vcIopcqOmjS1Jt8q0aOWvxBY
         9LyJBkidnXjC2JAQgxpRLn7/dqvM3LgGKf8GpTGo4+OCgBDeqeIqWK07wXAXJIpMxIuS
         2Kro9yagOoJDg9S1FEzFy97+hYVmkdyeBrDb/YKQvH33/s+D9zeJcZZH3Zas8OA3RTmR
         6+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770423874; x=1771028674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nz/X6BTvr+nL3B3hjTqOBHfNkcoeCHJoAFxDQVFk7AE=;
        b=J3AnR3DWhdVanHUgbjMqqiPzrm10ZFRDaDT8uUKWZ05xBVMm+gOyx3CN3+Sb64+RnO
         YVhH/Dfii504QPLKCm5FgnfUmAqqyDWxtlohUlOmZBd2gemXUdz3Q2L8IZ5nvl64O8jL
         IoN4BElqZyTAybDnmZD046kyireBjMqv0+0hVPR5DM0HvGPsmR2XQvcGmZDyiTUeEO5V
         wRTWJj8s4moQ7ztHLRhxM4vTD0v0kWJXotBUAN19f28pLwQ5Y4UhIFhcYJ7WZHP3zFlx
         9hFNNUsBI8nmdxGFzuYNMYtWZ5dXeqdhruim5+hjiGBRdrdSmpNGI17MIzvrpR8UBvQP
         a9eA==
X-Forwarded-Encrypted: i=1; AJvYcCVJuDmdszDd6hbtQ3sIwnHfyw/cjYDfXSiOFyiWeWyVtsmjKlXEobpl2JOeLIsumL0LkzwpcBk2LfjPjVzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4m84Y/P9rcCHOdBtN7e98Lf9gD31qSOguB/MwOVOQkVjcbV/
	2d1Me2uZbkkNk59uLwSoBl6n48yR+1nFlaC3EiiUX2g774xvS9jMRsLAYHWecrCnfqT02ElKVaH
	UohBJ5/AjVxsDlGQ79rdnYoMb8gyS+Yg=
X-Gm-Gg: AZuq6aLRIgmeSvmBrFT5l9S4wH8YtkYJwb1Lt5K8oDTgf9rprOWxtz+sCrkHPNb2k/L
	1zpuMS/3MtP5U5JeE4YWIIb2661gxJQodboPypYF05Fc83e4w3rq+qYsG21IYrvs5IEsWHO/4im
	GFvqu/7gg/GL0ixbmWlKx27V/I7H5hFklcXWDwfQhOsOhhaJf3btlWbAjZDxR4y0x+yURhYCSwh
	M71+Xbsses+UJE13Nao9f0aWAqMELf6MWRTNQzzbYTBtfUK+ZOS5PscJEmwewKEzfwWrA==
X-Received: by 2002:ad4:5d66:0:b0:890:65fa:1ec2 with SMTP id
 6a1803df08f44-8953c7f44f3mr64930806d6.29.1770423873655; Fri, 06 Feb 2026
 16:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com> <aYWbXV9pfyLwfy-t@infradead.org>
In-Reply-To: <aYWbXV9pfyLwfy-t@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Feb 2026 16:24:22 -0800
X-Gm-Features: AZwV_QjQPVTnRHLmKm2-KYoVtk3n3ilApukoJS2L6ExyYn8j59z2lc-kHUOdX6M
Message-ID: <CAJnrk1aQ2aQ9NZyGkrXGH78j+dKPfN7cHnp+GxtMriKh9h=-Bg@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] fuse/io-uring: add kernel-managed buffer rings
 and zero-copy
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com, 
	csander@purestorage.com, krisman@suse.de, io-uring@vger.kernel.org, 
	asml.silence@gmail.com, xiaobing.li@samsung.com, safinaskar@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,ddn.com,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-76658-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: CC163104470
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 11:42=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jan 16, 2026 at 03:30:19PM -0800, Joanne Koong wrote:
> > This series adds buffer ring and zero-copy capabilities to fuse over io=
-uring.
> > This requires adding a new kernel-managed buf (kmbuf) ring type to io-u=
ring
> > where the buffers are provided and managed by the kernel instead of by
> > userspace.
> >
> > On the io-uring side, the kmbuf interface is basically identical to pbu=
fs.
> > They differ mostly in how the memory region is set up and whether it is
> > userspace or kernel that recycles back the buffer. Internally, the
> > IOBL_KERNEL_MANAGED flag is used to mark the buffer ring as kernel-mana=
ged.
>
> Can you split that series out as it also has other applications
> and smaller series might be easier to review?

I'll split this out and send it by itself.

Thanks,
Joanne
>

