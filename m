Return-Path: <linux-fsdevel+bounces-78219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHiQOBccnWmPMwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 04:33:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E793181687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 04:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6EE630080BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E226B755;
	Tue, 24 Feb 2026 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giBN8ySj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31213635C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904019; cv=pass; b=ZYNuvmHV5nsrbeBQR7MhGCDIjRdvUHpPUYuxImLv1lbs2C8Kf6aFVdlV1PIrLm+6IMTwiuQEZd/E+gEhqXv10Fj/ot2LwPYURA2JqUg9ZdW5Agq5nVT6c4qaK7WrOL9BXdhVZ9SS9ie0z9k2gdur+384H4cvIM1LwPAr4LCiekg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904019; c=relaxed/simple;
	bh=iJ1Xbe4wgQdzpLHpWKAWzR1x8I4Idd27NmjrfIEaqGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQoBM8NChMqIeBNi5vNLZsJvSHlcC7esrd193yym5me/8TphbQktU5hDhj1t5AQxV3eAXC5QjvDCcokNdGhoOc4rmNWvsYDQ/zKNAhYSRJaB4CeYRwa+D3t1Y02rtoJASRdEy5CIQeK7rX/zcR3v4WOvD44p6PFLg1bSozF2FmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giBN8ySj; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65807298140so7508491a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 19:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771904016; cv=none;
        d=google.com; s=arc-20240605;
        b=hkPIUeeByJQhUiM4gqt8Q3n1wsNg3RDYfYQSeFJv68sEktkt4XeXHJgAGC1ihLHNDc
         TzK0hp6szLmS8or628H+d1s0YhfUg21WqfS4l/YrrBr6EIjVKBC07HFc14ayzcqUdfZT
         oKcwZQ3S2nxwkZhcXD8BaXDrqYqzUE0R6BUp+NLnRvJJ9kHSy0jTTH13SuJe1e2w0rjd
         iIZmIGSWFapa/+eMZCUTH4FH3uWPFz9SO/ZEnhvbIC1xJEXAoADuX0OidnIqGwekiPD5
         n2GyyYpbvwddrpl9O169h+/gNWQV9jIOnYOKQ1Dr5XN8ADVWzE08K1JiqhOy6Ru+1lOn
         LU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iJ1Xbe4wgQdzpLHpWKAWzR1x8I4Idd27NmjrfIEaqGc=;
        fh=uEni2qxK/2JoDgod2OJoRao3LAL6rQKhQdTvsLMrZeM=;
        b=ihSSI6h277jjLYZCDaq93fREkekM+4EbnUJm+tOGjWgaW3KFlShd3PayUlHJcUbg3s
         Tre16kMKQgcwYQ6DgXmVIQMGvpQpy86gIt70QagnYq1ca0hi5fzvRthSHL4cMr8cGVZP
         tJ1jESBJKuDdBinA5sMXu7fY0tsW0jVXOwJFBLuaZIOwhgWBlt7n7q2FgL+GRFNImzGK
         Em8yLpMaZvhXxi9VWEHKI4tpIXQEq/0/oRl2I/gdJGbv/7Oh3reGgXTWYQP2sbS6raxN
         wTC2Y91u95ZfLRkXzqoZkMqurkCktAFBm2jwi8KzWfq9DecTJFvKDVI3oE6fpk6ABf6/
         UeNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771904016; x=1772508816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJ1Xbe4wgQdzpLHpWKAWzR1x8I4Idd27NmjrfIEaqGc=;
        b=giBN8ySjwkQQFYIxsnKRdoyCTfBNoEmuVC+UR61SEZV2Dr0JiOQQaXXoQxnHTjJrAo
         6Td3VAgsHPyrc6C+E8Tfkq08KJMGUUHtmuVra9n0rtYQbjkS6yduLGmw0jgEk+/qeJtY
         LIThk3lOtuVh44R767g00pfD+/Mtzu2xT+l32Jl+hDbCX4w0DlOouC4ol+mccvMlX1ug
         iG1FIdogRF/iXPiFUAR1bVpiJ1n+oF6qIgALTknAZaJcLQpM4EZ0K0I0RJ58JxeFlgM4
         NP4FzJtqrkoozSS4hh4PvHSezeRvbAHKzwL4kxryPXecmLLqG3F5TPLk5L9PYtJ0TF5D
         67hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904016; x=1772508816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJ1Xbe4wgQdzpLHpWKAWzR1x8I4Idd27NmjrfIEaqGc=;
        b=W/SSMnVB7u+3jPFpToXLwOcvZa2FsuG9oidbKOIGpNFZrHnJK+E6NesaCMIwL4wQYY
         2VwlYzMwPdfOM0m/9wFnh3VL4IhG1DMtIQuKeo1QE5lwbfXMMNz27OkAUT2EayJFyrkw
         PV8RUZznHXa6yGZwjG7Tc9/DjsMwfdvxj3SttPtpQzs8NsURtX+NVIjOS52+9jWsBxHX
         /Kvh/grl5MaZOJ8Jq4qwUh9YuyC1F1+gdOw2YL8BM15jhjnw9QXgLcgDEWzGVEKETKnY
         qFhLLrqZmDS2iyL8lW1FAqDwgp78Yz3Sg3vkxhcO/LzbQQY/q6tNUTxPP2rTMJtzVJes
         pWOg==
X-Gm-Message-State: AOJu0YzrJkkk2V8wJBEOR2Y726/Q3gUvpuaj1wekw6m8hlEnRq2MaMEN
	IIkLYRMvAhvu3iVzRGoyUIrVbMDqDciNYnwwyqYrBZq9LD4IApDSvSjZViSkHo7PYDN4jxuBVez
	se+vQcV5ZL4zqIeWlyEQ4V3AwqRNkqSs=
X-Gm-Gg: ATEYQzwVX7KUl0hdHTCHfWnd1tbwl/2RTtUooK4i/EXMaU0UWBKhH/NQzhh1qRGwkGM
	tT140VAKdaZp8tQPpXJHpXm98rsqOKOhUB4NhsL5ZEEsTyAWjoqVDFhXdxLfica4xI3ihHksv54
	PUpXhpA/7WQoHLzTUuKA7G23ITLXRtL1e22ule/5AvW/3fjnRN7x8zKQhsR4WcXVBKbvuwNkc2V
	dD+vvKV5yMaXQWe8G/DprXoQazAqN+HhNn8BZc7DII0BEBeq8rmedFMaV55IXY7R0Loz3rNS3o2
	CdH/Rg==
X-Received: by 2002:a05:6402:4410:b0:65c:5a7b:bd99 with SMTP id
 4fb4d7f45d1cf-65ea4f0cf7cmr5793513a12.31.1771904016311; Mon, 23 Feb 2026
 19:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
 <2026-02-17-grimy-washed-domes-aluminum-0HKtw9@cyphar.com>
In-Reply-To: <2026-02-17-grimy-washed-domes-aluminum-0HKtw9@cyphar.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 24 Feb 2026 09:03:21 +0530
X-Gm-Features: AaiRm51P7OHLrFnboWksjbRX-NAP89jcZmSdGRNEJR_eFtlS1Z-LxcXzLTEF0t4
Message-ID: <CANT5p=qNA=uYY5YHvE8MfEtM6dXMXn343F=GC5M5-0FX-OVPNA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78219-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1E793181687
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 8:30=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-02-17, Shyam Prasad N <nspmangalore@gmail.com> wrote:
> > Filesystems today use sget/sget_fc at the time of mount to share
> > superblocks when possible to reuse resources. Often the reuse of
> > superblocks is a function of the mount options supplied. At the time
> > of umount, VFS handles the cleaning up of the superblock and only
> > notifies the filesystem when the last of those references is dropped.
> >
> > Some mount options could change during remount, and remount is
> > associated with a mount point and not the superblock it uses. Ideally,
> > during remount, the mount API needs to provide the filesystem an
> > option to call sget to get a new superblock (that can also be shared)
> > and do a put_super on the old superblock.
> >
> > I do realize that there are challenges here about how to transparently
> > failover resources (files, inodes, dentries etc) to the new
> > superblock. I would still like to understand if this is an idea worth
> > pursuing?
>
> I gave a talk at LPC 2025 about making the mount API more amenable to
> reporting these kinds of confusing behaviours with regards to mount
> options[1].
>
> It seems to me that doing this kind of splitting is far less preferable
> than providing a more robust mechanism to tell userspace about what
> exact mount flags were ignored (or were already applied). This has some
> other issues (as Christian explains during the discussion segment) but
> it seems like a more workable solution to me and is closer to what
> userspace would want.
>
> [1]: https://www.youtube.com/watch?v=3DNX5IzF6JXp0
>
> --
> Aleksa Sarai
> https://www.cyphar.com/

Thanks for sharing this. Will go over the details shared to understand
more about what you said.

--=20
Regards,
Shyam

