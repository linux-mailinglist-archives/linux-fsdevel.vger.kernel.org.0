Return-Path: <linux-fsdevel+bounces-75832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFbwCs+0emma9QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:15:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1CAA8D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430D130416E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285C31618C;
	Thu, 29 Jan 2026 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtzeAgKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EC3168F7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649332; cv=pass; b=jPyaGBI6o0lIUv99lcxDe0CYKj/RasafO9ABeki81Lt0ICoHJs447CMrPaV/ddj+rFu6+gjKdKoR68nTH7MCGWxMAsVaQlZI1aKOJvjjB7udo0yarJUTlvWf5RLptsvBdyPNhcDn+SeGB6dZw/bqzW8iP6FgjLeynfM5lrh2Zzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649332; c=relaxed/simple;
	bh=LL7o4vy/NoO6zKG10NFswNY37j+yETGJ/86umDxUc18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAJs2tlQbEYfTaHKG1dTu8KJp/nl6Hv2ZNYA7o97PhxpEMSLanuVZ0gTdLHoklJwL0pk8bX63G+kfg7bee0joJdYqe3PV7kNoDjlRQKXFqCmJE0BCLCYGsUAioC0bNWxjf7s1a685m9ov7rkPBkCHQvE2Hue3/pWWgnAGVSriP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtzeAgKQ; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5032e15525aso4093481cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 17:15:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769649329; cv=none;
        d=google.com; s=arc-20240605;
        b=DmzE1DsoQO3Ny51Yh8I/vXZ8yZPi+ve+1UaiYVBR4DD0uDJv1rxWhsRBjcS2XSanza
         T2dF7kiS/rwoMtzqjEiAn/We80J2sVuwkrvy8tLEIXHIJ8p/oIV7bYMI8AGYmPuYHorm
         QMrX+wPI4AJU0aJVW+hiqaZN9et+jixT7jp5Vf4AWr2ffA66c5Z4zcHAXRwdUrkQOgOC
         HV5if8geLiB7vw+oepxj5KDvc1H494OLXToPW3vQzUxQVq4BJPY3Gorr4sf8dxZg3qPn
         tjzaHfGf3/7h0L0byKkZ+LL+Pf3kiATr+ol4oJngBwV90T9FmuAkY6sxcpfpMXCvnpE4
         s7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wDykPZ8EL1Im5WBOSDWsyNHmCwU4viR22qWxLrqJr+g=;
        fh=Rinc4FR7/f12th6yrZLCkLiEMOWByUfNcdVfJjXA0aA=;
        b=fGpmE2xsR7Ugv4kzWegXJH7sCuCOms0O7dZLUk8SXqxM5/VWPgJ6yvATvHlYa3Uxk/
         VaO5ITXLI+m9bnPiVnzUhRiKT2Qg/zbU2xZeeVLZngSGWj6/EIoG8xlbkqFZ2j/u4q4q
         rNgtFiwU7zkYVWLNsEm06jd3JNobL0ovtpRvLUkEjBIAOSMWqfqjDN0KZWic5/Z1qxId
         rm56bVHkLPFheSBe0eUrL6AdDdJ0ylmeDdCI3Su4vbC444HqFgZjlCqtkp/maRRvUdFu
         dOxLdbRbaeSOsJ6rd2QlB23oGXzuOpTZkS0trfIEiXpGMcvi7SeCJCcwo/uKjUwc7Fu3
         4A+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769649329; x=1770254129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDykPZ8EL1Im5WBOSDWsyNHmCwU4viR22qWxLrqJr+g=;
        b=NtzeAgKQ9KXbw/jACgLooyHqipRvH7dEmmGiCyyEfetxrWSKpuxCIUJXA6mS9FvFRR
         K2fnkoAB+630BLBgSfgGkuInZf4PXVn7YyuEAE2GbRbKFdrWInWfRwyvrMYAxc9cqFVK
         ebOoi1kaiITXRc88Q4H8oYjduHtpK0rvjw6GW9OoFM1HiFeom4hJ8kWcAV70yiD41pBX
         YUtusqR7GTlnlmrIiMRBWo/mVfpytl+m0zp0B6gHdrQg8hf2NzHjwUsmzOL9BUULoguE
         b+Rj07DijREK3PQtKIB6a2LOokO97agydLT0WQMh3n8kTqNUPMeQooR1N1Tx+3yS3VgO
         kRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769649329; x=1770254129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDykPZ8EL1Im5WBOSDWsyNHmCwU4viR22qWxLrqJr+g=;
        b=YQ5dee8eJPpe5hgneWqrMZQAOeYqlHYRxxCO1qJj5EIsNxojlAwBqukd3Qcdw8VZMt
         gSNnkh2UdDj1IOUUs9/ResaNzAheXlmaObjcv9Kg5/3fMXgu8n/I6kNOqL8OhtAGXLt9
         NxKG9VPXreUrttwV+9BbB6Fysu6c9onpClK/SCdkXmn5rpCk0UXrv08eW/JQ7DMmd4D5
         h/BX+oMZyCLFLGJtLZrmYMrUb2Q/OdV62FBqMt7vEmxTB6uFwmjeBRpD7Pq3YhMes/qw
         MOH9qnJRw0rQmOS+WLz3Br9eZVF4y4mR4TA+X4XcjfPnmUGgR4zoUfXm5q8UGfMncmkn
         C3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUy0/LXQeexpMUX+p9vn6UsYIqtgbq3vqDjy6Oe38N0nj2D48QALcHfPxPoU/GfKxtRw9Z+Fx1c9yPlpvdM@vger.kernel.org
X-Gm-Message-State: AOJu0YzRn7WEVxipR9gh/p+hjM59YkO46+IHrhMIiplFj1zn0/DbYtSQ
	XDdwhZrauIRha+wseuetr7Oae9/4v49njWyUTzIdiJPVqXxZwTv2izz7y/puycSKOXkZfcW3cW9
	Q/Qg6USu6Q119kcx2Xpdgcki/dlgGo/PCar9R
X-Gm-Gg: AZuq6aJ7QU2mv6xjERMwU3rnFHUbsMECHBbfBW0DYYRZ2HgCRAEe1I2z3XeB05tD6oX
	MVEQkdr6k2C/KRszx0aPK1isLekaWBLOJl8ONIBAPeZA/GPNuYdLgV4t6htDHzqfWj4DdxXNFJk
	QKig2OI/zZuZwtnMSA9skIjEM7gC+z3aQnmf+ber8iYpPmxH7J4zQl7K4+FAz9JyrKyTqE9Bf90
	SWlHBPuDhuXG3gx7vRq4uhh+3WmtWmtBalM9aXVUAMfyIhmsWfzS5NJRXOMycyNkrYuuQ==
X-Received: by 2002:a05:622a:1882:b0:4d2:4df8:4cb5 with SMTP id
 d75a77b69052e-5032f76dde8mr98794071cf.4.1769649329274; Wed, 28 Jan 2026
 17:15:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-20-joannelkoong@gmail.com> <2f14fb1a-0ee2-4d86-98be-ed6112ed706d@bsbernd.com>
In-Reply-To: <2f14fb1a-0ee2-4d86-98be-ed6112ed706d@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 28 Jan 2026 17:15:18 -0800
X-Gm-Features: AZwV_QihjUupbTeTFwTH7T-OHXs2qBZqfWRz2D4du-sr6Dv92w_b7RDQ6DzSz6U
Message-ID: <CAJnrk1b6gpxyFJWe44ryvBfdJqf5h8pCQAf1vAShGqoSFw9-ng@mail.gmail.com>
Subject: Re: [PATCH v4 19/25] fuse: add io-uring kernel-managed buffer ring
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, csander@purestorage.com, 
	krisman@suse.de, io-uring@vger.kernel.org, asml.silence@gmail.com, 
	xiaobing.li@samsung.com, safinaskar@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75832-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9B1CAA8D5
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 1:44=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 1/17/26 00:30, Joanne Koong wrote:
> > Add io-uring kernel-managed buffer ring capability for fuse daemons
> > communicating through the io-uring interface.
> >
> > This has two benefits:
> > a) eliminates the overhead of pinning/unpinning user pages and
> > translating virtual addresses for every server-kernel interaction
> >
> > b) reduces the amount of memory needed for the buffers per queue and
> > allows buffers to be reused across entries. Incremental buffer
> > consumption, when added, will allow a buffer to be used across multiple
> > requests.
> >
> > Buffer ring usage is set on a per-queue basis. In order to use this, th=
e
> > daemon needs to have preregistered a kernel-managed buffer ring and a
> > fixed buffer at index 0 that will hold all the headers, and set the
> > "use_bufring" field during registration. The kernel-managed buffer ring
> > will be pinned for the lifetime of the connection.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c       | 412 ++++++++++++++++++++++++++++++++------
> >  fs/fuse/dev_uring_i.h     |  31 ++-
> >  include/uapi/linux/fuse.h |  15 +-
> >  3 files changed, 389 insertions(+), 69 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index b57871f92d08..40e8c2e6b77c 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c

> > @@ -1305,7 +1311,14 @@ struct fuse_uring_cmd_req {
> >
> >       /* queue the command is for (queue index) */
> >       uint16_t qid;
> > -     uint8_t padding[6];
> > +
> > +     union {
> > +             struct {
> > +                     uint16_t flags;
> > +             } init;
> > +     };
> > +
>
> I won't manage to review everything of this patch today, but just
> noticed this. There is already an unused flags, why don't you use that?
> I had edded it exactly for such things.

Oh nice, I missed seeing that. I'll just use that flags variable then.

Thanks,
Joanne
>
> > +     uint8_t padding[4];
> >  };
> >
> >  #endif /* _LINUX_FUSE_H */
>
> Thanks,
> Bernd

