Return-Path: <linux-fsdevel+bounces-75834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHAfH+a2emma9QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:24:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F261AAAD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D53F8301D4D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3FA343D71;
	Thu, 29 Jan 2026 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFn7qH7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09B379972
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649417; cv=pass; b=BrPM4GkLVjhLaD08Pdn13YplYQlOq+5f7OGDrs2MPmxwNaVTZxXCPZCwQsYuk4zuXfh5QWgEQWwq6prkE8UJE8QFFQD5ZtPFHvudCpjn8gzGFmu0y5z2wZQPQmIHzbVK/0orlSXJOiyN7xVHWIao8/DFIN5yXUIiX4GWgAII42Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649417; c=relaxed/simple;
	bh=Ha1tIN7hHGKpkhiGYJaEWRTlSqz76f1xHZV/A88CtXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMIUsdNiQZNl6n64SJAes9l4y4FZBSYOPiAzEiR6iehydx/P/1OPoMkzJmhZkQMGN764ucWoNRgwh0b96mg4RCduxxPPpXj8Z7KIE9ccWSzH8Dyqh8EKqiAaKP5VdBfHWYsMAwSvHikFyePjwmPmsMXNBfC90dactuH5Y6qBGWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFn7qH7S; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6a7638f42so62619685a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 17:16:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769649414; cv=none;
        d=google.com; s=arc-20240605;
        b=fhlUZah2x00P0M7W9veBuSaaZCehthxU+ghTxyKZBif55m9iYa03xqvTOUSTZSAGgt
         dPmuUuNoMZjSZm/ZoMdppTCn9YuZwnzAMgjt8CZxjBfdKixjtIZX0IvYv8ww/s8mS0YQ
         DQfbYTse0qkW1zuCVbEhm0q4rN7EqLaUzKmOqxY1Vy4RQDwovoiF23vdUWQQyIzWbAJG
         U9swhazh0NdY6NSyR7+JwimKDLR7KmFiFBHu9j2LwJEccX8SDOhwwlfNi+J9k28lImvq
         tBYibMEgBx/elWs2sARfMCVDUFepkRFwGU+jrUXAQjhDDc7s6ZxVYT/LyjCbGL4x/XKH
         lz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=134hHTGFx4DsoZAW9zkpXmrMLO/ZOkI8ziAgMpQNXTI=;
        fh=L1e1MjGjVQfIwhvJxpQJpL905A/S21KGd6wE2w1Dzww=;
        b=iIiDEinJGbubCIZG+yvp/Dsc66zD3rzbL9Ee6VcZ4JH8e5628Ko1WUFopdHjtLBWY4
         CoSRyKE0ZpXrHYdLT2qGSB0u/b2/ahZ2huHRjkQYfYeDF5cEk//1KO7Y35tfGmMG5ps6
         rlWXNXookLxoUY/veW++ogFP2Z0kNMzfhpt5yWaBJFWn+b9KM8boHnElNkDQDORFyoZA
         EIeD6VvmW0OPZ3kjoNgBy74ksI2+M7dAqvL00NxGKsjHAB7rGsWDfXbWYItxsrqnT9as
         gDhfKnZowWbsSdnAQXOof3RDF/8NAEQOPA6UcTdl0AmdwcI1X6fSKjutx+qUB6XDSq7m
         NY/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769649414; x=1770254214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=134hHTGFx4DsoZAW9zkpXmrMLO/ZOkI8ziAgMpQNXTI=;
        b=gFn7qH7S8g8q3qAzcDll3SRs5GXqLNC8fJJJuwZtapJCyQ74XpyHl23OsR6xVB8bK/
         cstmS041f0JrEUUMlkZ+2ezn1VdYyTWLTBM4j9zDnS6L0zpbUX4K0kmVxz1rmT3YxP+T
         OGcXXaRJxJ9ESMk1BPXwWwrNTOngVGiqCUh9XwZ7e9MX9k4fdfHVaO1JgXi+PkXJdQk+
         JpomBbC2gKHra2mtsUNKhWiy1Dm8fhIpvv8EEVo9tnDDDhhO/6aDvLlahhsiVRKuzi6c
         lAx9T/RKznSxC+IDDnYgmcMF9gqzNIKbsJMTHn3V155irWCN+cUMzRGLR37EHWJpec1v
         2Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769649414; x=1770254214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=134hHTGFx4DsoZAW9zkpXmrMLO/ZOkI8ziAgMpQNXTI=;
        b=RWhPJS8lUDtN7goke6JY4ivN8WXYFlHjkOgriDN0JZmj0y15e6O2nZAGCcPUx2si3B
         DMwaXCJ4MGM+ZAxJHFwoqZj6h6hLpn0RPntZ0e+5xFFRWuRsVfuInslMmq4Fm3mEk32E
         F2eU6XIJmmlLNeK6Zw6EQkkgqwdiUfPUK2Fvdm/ekh2b2BDffZClBXgd15b4jI6oDKxs
         s9K1tjH+AYPXIkkTkYhEhqo6n85sXe4BKKcg4X+6nf8pK7yBs1uuKujyumpagME5FnrM
         uSHY375xw6+ssAraLtycT3+letohtTpRmTOeJpSd+i382OxqykAwflcIlnv1BMzyGqHz
         1R1g==
X-Forwarded-Encrypted: i=1; AJvYcCUgwTU5fXoBW2iWO9vU5fwb7gci1ZDHpb0v6MBHvU/WAOooKZjVyyIiZmm2+7J/9T0KioYmAzcGCGrDI/Pn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi12zXerakAJk8POs4RFL4/cwEUUH27Htfp1+ZkTBjfC1B6Owq
	BKR1CtMWf627eF9Vg+JvYC91x7SbOlsuZjUUwBe7l3w8LcHYJ1ea/JfoQ6lHE3Fi2MbKmXgqy0T
	jzllOTONnuMgAz1UfYoyoTqTgX7YNWWY=
X-Gm-Gg: AZuq6aJaYZrpKzgVYxsjB94L7AcVjqs6RjeRFMPCTe6L9w8/OPX1NU1+9NJUp5BcUkC
	J8zOjlblLAI7Wc/3EeqB3F0wrg7T9tDwAyI1hkCDmFZAJguwcAdOh+xicNzOv2JptK70kkjgE/o
	IO1LvpjPnczFbb5VeEKdHoAdAyLREwaewvcTB1w1z1YBp+o2S4chb0iv7orfIrkN/BdnctIt3nx
	hENjXBEcPXZH0GgdN+eUCmoHqYk5LUwPTNYhHeXAgxGS0Iel45rcNMFftpH3/r3xUq3kg==
X-Received: by 2002:ac8:5dd1:0:b0:501:4e87:70b7 with SMTP id
 d75a77b69052e-5032f74b0f6mr93787571cf.1.1769649414123; Wed, 28 Jan 2026
 17:16:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-19-joannelkoong@gmail.com> <68b3ff9d-ebcf-45c9-a50a-b5a59d332f4c@ddn.com>
 <CAJnrk1bn6A2i4Kr-W=VTUVqeewhR-eVNZXoQtDi8v4=Qyme6DQ@mail.gmail.com> <be475a3b-fe3f-43b2-ace6-3a7158d4d96c@bsbernd.com>
In-Reply-To: <be475a3b-fe3f-43b2-ace6-3a7158d4d96c@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 28 Jan 2026 17:16:43 -0800
X-Gm-Features: AZwV_Qhx5ybxot0C94y6kD51M3S2Jxwo3z5pmQyFPryjEscwAW9LSyz9j8Fsg3w
Message-ID: <CAJnrk1bBQYW6rVXK=nHis+emO2v-rif-GnvXGbSaSk1if-fo9w@mail.gmail.com>
Subject: Re: [PATCH v4 18/25] fuse: support buffer copying for kernel addresses
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, axboe@kernel.dk, miklos@szeredi.hu, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75834-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ddn.com,kernel.dk,szeredi.hu,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bsbernd.com:email]
X-Rspamd-Queue-Id: 1F261AAAD6
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 1:14=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 1/28/26 01:23, Joanne Koong wrote:
> > On Tue, Jan 27, 2026 at 3:40=E2=80=AFPM Bernd Schubert <bschubert@ddn.c=
om> wrote:
> >>
> >> On 1/17/26 00:30, Joanne Koong wrote:
> >>> This is a preparatory patch needed to support kernel-managed ring
> >>> buffers in fuse-over-io-uring. For kernel-managed ring buffers, we ge=
t
> >>> the vmapped address of the buffer which we can directly use.
> >>>
> >>> Currently, buffer copying in fuse only supports extracting underlying
> >>> pages from an iov iter and kmapping them. This commit allows buffer
> >>> copying to work directly on a kaddr.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> ---
> >>>  fs/fuse/dev.c        | 23 +++++++++++++++++------
> >>>  fs/fuse/fuse_dev_i.h |  7 ++++++-
> >>>  2 files changed, 23 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >>> index 6d59cbc877c6..ceb5d6a553c0 100644
> >>> --- a/fs/fuse/dev.c
> >>> +++ b/fs/fuse/dev.c
> >>> @@ -848,6 +848,9 @@ void fuse_copy_init(struct fuse_copy_state *cs, b=
ool write,
> >>>  /* Unmap and put previous page of userspace buffer */
> >>>  void fuse_copy_finish(struct fuse_copy_state *cs)
> >>>  {
> >>> +     if (cs->is_kaddr)
> >>> +             return;
> >>> +
> >>>       if (cs->currbuf) {
> >>>               struct pipe_buffer *buf =3D cs->currbuf;
> >>>
> >>> @@ -873,6 +876,9 @@ static int fuse_copy_fill(struct fuse_copy_state =
*cs)
> >>>       struct page *page;
> >>>       int err;
> >>>
> >>> +     if (cs->is_kaddr)
> >>> +             return 0;
> >>> +
> >>>       err =3D unlock_request(cs->req);
> >>>       if (err)
> >>>               return err;
> >>> @@ -931,15 +937,20 @@ static int fuse_copy_do(struct fuse_copy_state =
*cs, void **val, unsigned *size)
> >>>  {
> >>>       unsigned ncpy =3D min(*size, cs->len);
> >>>       if (val) {
> >>> -             void *pgaddr =3D kmap_local_page(cs->pg);
> >>> -             void *buf =3D pgaddr + cs->offset;
> >>> +             void *pgaddr, *buf;
> >>> +             if (!cs->is_kaddr) {
> >>> +                     pgaddr =3D kmap_local_page(cs->pg);
> >>> +                     buf =3D pgaddr + cs->offset;
> >>> +             } else {
> >>> +                     buf =3D cs->kaddr + cs->offset;
> >>> +             }
> >>>
> >>>               if (cs->write)
> >>>                       memcpy(buf, *val, ncpy);
> >>>               else
> >>>                       memcpy(*val, buf, ncpy);
> >>> -
> >>> -             kunmap_local(pgaddr);
> >>> +             if (!cs->is_kaddr)
> >>> +                     kunmap_local(pgaddr);
> >>>               *val +=3D ncpy;
> >>>       }
> >>>       *size -=3D ncpy;
> >>> @@ -1127,7 +1138,7 @@ static int fuse_copy_folio(struct fuse_copy_sta=
te *cs, struct folio **foliop,
> >>>       }
> >>>
> >>>       while (count) {
> >>> -             if (cs->write && cs->pipebufs && folio) {
> >>> +             if (cs->write && cs->pipebufs && folio && !cs->is_kaddr=
) {
> >>>                       /*
> >>>                        * Can't control lifetime of pipe buffers, so a=
lways
> >>>                        * copy user pages.
> >>> @@ -1139,7 +1150,7 @@ static int fuse_copy_folio(struct fuse_copy_sta=
te *cs, struct folio **foliop,
> >>>                       } else {
> >>>                               return fuse_ref_folio(cs, folio, offset=
, count);
> >>>                       }
> >>> -             } else if (!cs->len) {
> >>> +             } else if (!cs->len && !cs->is_kaddr) {
> >>>                       if (cs->move_folios && folio &&
> >>>                           offset =3D=3D 0 && count =3D=3D size) {
> >>>                               err =3D fuse_try_move_folio(cs, foliop)=
;
> >>> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> >>> index 134bf44aff0d..aa1d25421054 100644
> >>> --- a/fs/fuse/fuse_dev_i.h
> >>> +++ b/fs/fuse/fuse_dev_i.h
> >>> @@ -28,12 +28,17 @@ struct fuse_copy_state {
> >>>       struct pipe_buffer *currbuf;
> >>>       struct pipe_inode_info *pipe;
> >>>       unsigned long nr_segs;
> >>> -     struct page *pg;
> >>> +     union {
> >>> +             struct page *pg;
> >>> +             void *kaddr;
> >>> +     };
> >>>       unsigned int len;
> >>>       unsigned int offset;
> >>>       bool write:1;
> >>>       bool move_folios:1;
> >>>       bool is_uring:1;
> >>> +     /* if set, use kaddr; otherwise use pg */
> >>> +     bool is_kaddr:1;
> >>>       struct {
> >>>               unsigned int copied_sz; /* copied size into the user bu=
ffer */
> >>>       } ring;
> >>
> >>
> >> I'm confused here, how cs->len will get initialized. So far that was
> >> done from fuse_copy_fill?
> >
> > With kaddrs, cs->len is initialized when the copy state is set up (in
> > setup_fuse_copy_state()) before we do any copying to/from the ring.
> > The changes for that are in the later patch that adds the ringbuffer
> > logic ("fuse: add io-uring kernel-managed buffer ring"). The kaddr and
> > len correspond to the address and length of the buffer that was
> > selected from the ring buffer (in fuse_uring_select_buffer()).
>
>
>
> Maybe we could add a sanity check into fuse_copy_do() or even into
> fuse_copy_fill in the cs->is_kaddr condition that cs->len is > 0?

I will add a WARN_ON for this in the next version. Thanks for reviewing thi=
s.

Thanks,
Joanne
>
> Otherwise looks good.
>
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

