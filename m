Return-Path: <linux-fsdevel+bounces-75676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M/vESxXeWlIwgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:24:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A629BA38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6618300603D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05621E376C;
	Wed, 28 Jan 2026 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRzZEruv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527C1DE8BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559844; cv=pass; b=PUxuE/BXQjjnTRg8Hfu9D4TnkZA8ULNX+19PYhBA70Zxts9z7OnAk0waZ/qCXF55OWyR5fRaEKzs5E3LflsKYpQ75szpYvyCAGwO5KVCrrOI2TUeuxBJuxnTNs1b9aJPbzWJDL2i+NSjcoHc/6+HG/mZfCx7FX88VXXFd6DwTQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559844; c=relaxed/simple;
	bh=0GspXgWsHUw0HtKJEjHl03JT3ieeDCqtlNN1s+BpAS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sh9V5kKfMXbiFfKmdQwBprUzdsbsbdSemCb8pODCuyrc1Mf8tlv6wfenj3xrP0L/4jOG9ke3w+zGxCfmU+7qGbjUvRintrbCQI2TNwrTPtlGvLi8wB9ZGrr7TeNP7CRSMhiTyNBRhL1TYrWHLcTnNreIOAV1lhW1EVWRlfR8juc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRzZEruv; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50146483bf9so72503731cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 16:24:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769559841; cv=none;
        d=google.com; s=arc-20240605;
        b=QB0m/AZA5A3nVdOFhZz/Ns33NG1yZgR82os1IAJ/9+2kZSrLnzbOu+o/1cb/WKfOce
         o35HbAIWKeKqgqdalBioSZVOVcLUAbRVCBfz37AGYBNHfCsTlNlV+uKdzU0S6WiufOBt
         oQcpsSDac/0bZfo7XALAeOg1QyiagGufmcYrWi/GcwG6sMdmNNhunj+l5zKJkD0SM3yG
         e4QSBO909SyGFK67s42B0GWi8e8I6dvCtcsjAoTAQ+9hLP0oWDlqV9XDbf4j3q7iCIfm
         q/vPdjib4OOi3zR9ffcOWoqLQIplFL10NpY+YoFWfZ11gB+zwA58eQJMkkBgeQhmfPTV
         bNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1EjESLmOpCL5ig1bPZ18vIZ3pfdUDJZgNOcnQHoP2QM=;
        fh=JARXeucGGxSmmFoQVDNXLSiMw0C1aKD7hJrXPbx/kGs=;
        b=DuuyDJiJPNtJvD0q3gn3vRd97NvOPTGUI2ua4zsWFbhXbriCBlrwaEjZQbT9hFbWZB
         K7Y7sauXDbp7F6V7QIx/vePvLTpWSrXmL5QLHlJxi497kvUD4kn24OV6/pCcWJPMNGHg
         JoVf0vrFWJ+b0Nk54dxdmLL+tq6whrFo2E6Lb2sKgWLUeORE0WsIKjeH0TiMmrFEmCxW
         HcmWmTfdmi1GhPcbraOTb+D/urpnhm0vofHuypeBRzHnnWs1YWpaLiG26w8yGnHVLzgP
         clb8rr8VRUOfW+9bm92zU7DOqDkKYzlv2nmrdCr0gMVytI8iTVc+2GVReoPn2lDjdGPD
         bDMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769559841; x=1770164641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EjESLmOpCL5ig1bPZ18vIZ3pfdUDJZgNOcnQHoP2QM=;
        b=NRzZEruvbrWr/HHcOCLclGvKEX2UQjRgs2ke6BcRzEMnhUDsdwa9Dzlgi/rc7IKvFw
         eVVLN+0IjXRQkMO/mb0XpInnb0X2tDyb1XM1v7ef+nckU9oNn+v7T9B+cypmw9/Cds/F
         sLrylNrtXI+ljgJJblfIew3xgnNpqCYfiHFX2Db5jd/tHwxGw2U0L66WMK8mFWw+xbPi
         UFvLjWhq+r/Q/BHI+mNnQNwTrsE6/212iv0bFm/KZ0pG+2tdDfrSoXM7E3PFOF5YwsRL
         TTNsogpxlKUY90yTA3X9quzCoMNsgxidBIu63u4Q7jCrjgqzE6hcwF05sGL2oT4cx8UP
         O3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769559841; x=1770164641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EjESLmOpCL5ig1bPZ18vIZ3pfdUDJZgNOcnQHoP2QM=;
        b=WOjZCZ+l6XUagQeTRLTOsOUOSuM6D0aZPm3PB7E+jFW/rLYArHjScXlo53zOI78mEC
         2pWOFKc8MXh3dryVftFlC81aNYWc4P5c0gTA01ADVE8Q+ly/3crltXjKz6frCCakb7Oa
         A0rw7xfuOO7Us2OR2+VvHOZoXgudwuJ+MB0nFWc5Df6fGdTVZ80K94yBbstsad5kKlQh
         5bKLL+vGIPwnPilfJMS+lP74J7jG9Sq/XwnE4Y6VYQbTnmkV9hcuQfQ1ljwE4Mjo4MJi
         fU+1chniK3aAufNPCoH2dRNc8CddCdm+1YK2IjKad6PMsQj4N/MaKZZykDDCa8zXrsPu
         Hs4g==
X-Forwarded-Encrypted: i=1; AJvYcCUAcBfNLQRho+PRLDneQpSkaP+Vj8/9uod0JsFq90vuyCCak37XLwlXTLKoAT8taI666Y+nQlLqZx8CJ37M@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnwYJPfbAC99ab99bRW7RrU9CwNyjOvi2g/MrZJRQANzIH4oP
	o0mjjz9BQ8JjH6NNsP1bV4WO0vT4Gye3lOTSasKAeek26inw1C6rtFKWFWV558OjSMBlTyyZTaq
	QRcXaZuK5hZaZ+1ps8DBA2+1WIPXDBLE=
X-Gm-Gg: AZuq6aLF2NgDxACJ5iEjXmumtCM10v96daMcmBjLd9NcBhAdO5BRIkHsx20v1hoeIO7
	mVQlY3rQX5OQbBj+cJBiOZMfUh93JUFK5AzSpafex7N9pYLDm0oLDuu7YRVeF8eMLua+1CZPk5e
	/Qvs2tsnn3xAr092Jm1VerFJBRSu6XuwqFa/oGiZwaFddeKrGtvFC46lTKIr2+Asum3puoWp2Sc
	/BEOZEbz0DfWI0hMOyb2VNKIxiD9BqVjCcChTTW3qvk93uJbSlsM2EzmOvd/o8ks0Kxpw==
X-Received: by 2002:a05:622a:188e:b0:4f4:bfc8:b7be with SMTP id
 d75a77b69052e-5032f742fe3mr41527551cf.12.1769559841448; Tue, 27 Jan 2026
 16:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-19-joannelkoong@gmail.com> <68b3ff9d-ebcf-45c9-a50a-b5a59d332f4c@ddn.com>
In-Reply-To: <68b3ff9d-ebcf-45c9-a50a-b5a59d332f4c@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 16:23:50 -0800
X-Gm-Features: AZwV_QixoyPCKDZ9lsSn6AbAznznwN4XRB9QfPbQSHTxY-QSZMbMl5eRsC76f9M
Message-ID: <CAJnrk1bn6A2i4Kr-W=VTUVqeewhR-eVNZXoQtDi8v4=Qyme6DQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/25] fuse: support buffer copying for kernel addresses
To: Bernd Schubert <bschubert@ddn.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75676-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ddn.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 56A629BA38
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 3:40=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 1/17/26 00:30, Joanne Koong wrote:
> > This is a preparatory patch needed to support kernel-managed ring
> > buffers in fuse-over-io-uring. For kernel-managed ring buffers, we get
> > the vmapped address of the buffer which we can directly use.
> >
> > Currently, buffer copying in fuse only supports extracting underlying
> > pages from an iov iter and kmapping them. This commit allows buffer
> > copying to work directly on a kaddr.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c        | 23 +++++++++++++++++------
> >  fs/fuse/fuse_dev_i.h |  7 ++++++-
> >  2 files changed, 23 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 6d59cbc877c6..ceb5d6a553c0 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -848,6 +848,9 @@ void fuse_copy_init(struct fuse_copy_state *cs, boo=
l write,
> >  /* Unmap and put previous page of userspace buffer */
> >  void fuse_copy_finish(struct fuse_copy_state *cs)
> >  {
> > +     if (cs->is_kaddr)
> > +             return;
> > +
> >       if (cs->currbuf) {
> >               struct pipe_buffer *buf =3D cs->currbuf;
> >
> > @@ -873,6 +876,9 @@ static int fuse_copy_fill(struct fuse_copy_state *c=
s)
> >       struct page *page;
> >       int err;
> >
> > +     if (cs->is_kaddr)
> > +             return 0;
> > +
> >       err =3D unlock_request(cs->req);
> >       if (err)
> >               return err;
> > @@ -931,15 +937,20 @@ static int fuse_copy_do(struct fuse_copy_state *c=
s, void **val, unsigned *size)
> >  {
> >       unsigned ncpy =3D min(*size, cs->len);
> >       if (val) {
> > -             void *pgaddr =3D kmap_local_page(cs->pg);
> > -             void *buf =3D pgaddr + cs->offset;
> > +             void *pgaddr, *buf;
> > +             if (!cs->is_kaddr) {
> > +                     pgaddr =3D kmap_local_page(cs->pg);
> > +                     buf =3D pgaddr + cs->offset;
> > +             } else {
> > +                     buf =3D cs->kaddr + cs->offset;
> > +             }
> >
> >               if (cs->write)
> >                       memcpy(buf, *val, ncpy);
> >               else
> >                       memcpy(*val, buf, ncpy);
> > -
> > -             kunmap_local(pgaddr);
> > +             if (!cs->is_kaddr)
> > +                     kunmap_local(pgaddr);
> >               *val +=3D ncpy;
> >       }
> >       *size -=3D ncpy;
> > @@ -1127,7 +1138,7 @@ static int fuse_copy_folio(struct fuse_copy_state=
 *cs, struct folio **foliop,
> >       }
> >
> >       while (count) {
> > -             if (cs->write && cs->pipebufs && folio) {
> > +             if (cs->write && cs->pipebufs && folio && !cs->is_kaddr) =
{
> >                       /*
> >                        * Can't control lifetime of pipe buffers, so alw=
ays
> >                        * copy user pages.
> > @@ -1139,7 +1150,7 @@ static int fuse_copy_folio(struct fuse_copy_state=
 *cs, struct folio **foliop,
> >                       } else {
> >                               return fuse_ref_folio(cs, folio, offset, =
count);
> >                       }
> > -             } else if (!cs->len) {
> > +             } else if (!cs->len && !cs->is_kaddr) {
> >                       if (cs->move_folios && folio &&
> >                           offset =3D=3D 0 && count =3D=3D size) {
> >                               err =3D fuse_try_move_folio(cs, foliop);
> > diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> > index 134bf44aff0d..aa1d25421054 100644
> > --- a/fs/fuse/fuse_dev_i.h
> > +++ b/fs/fuse/fuse_dev_i.h
> > @@ -28,12 +28,17 @@ struct fuse_copy_state {
> >       struct pipe_buffer *currbuf;
> >       struct pipe_inode_info *pipe;
> >       unsigned long nr_segs;
> > -     struct page *pg;
> > +     union {
> > +             struct page *pg;
> > +             void *kaddr;
> > +     };
> >       unsigned int len;
> >       unsigned int offset;
> >       bool write:1;
> >       bool move_folios:1;
> >       bool is_uring:1;
> > +     /* if set, use kaddr; otherwise use pg */
> > +     bool is_kaddr:1;
> >       struct {
> >               unsigned int copied_sz; /* copied size into the user buff=
er */
> >       } ring;
>
>
> I'm confused here, how cs->len will get initialized. So far that was
> done from fuse_copy_fill?

With kaddrs, cs->len is initialized when the copy state is set up (in
setup_fuse_copy_state()) before we do any copying to/from the ring.
The changes for that are in the later patch that adds the ringbuffer
logic ("fuse: add io-uring kernel-managed buffer ring"). The kaddr and
len correspond to the address and length of the buffer that was
selected from the ring buffer (in fuse_uring_select_buffer()).

Thanks,
Joanne
>
>
> Thanks,
> Bernd
>
>

