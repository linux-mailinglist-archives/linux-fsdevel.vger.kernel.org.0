Return-Path: <linux-fsdevel+bounces-74720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMp9L9X7b2mUUgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:04:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 316EE4CAF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3A978CDA0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8131AA80;
	Tue, 20 Jan 2026 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiIR0XVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEA3A4AB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939575; cv=pass; b=H4smTxQzKsS0KdAqvb6umsHp6bUXst934WSIOA3Bg1nR1cIVbHqxaIemFpQV/egzsqMo9gQz7jKGymK1vX2ZM7UzDFViIt8c/2ekP4b9QEsgY729ViZuq//rtOc8vLSNfjYAqAgsjp0ffjGl39NF9AbNrcnW70tUFoITupCYwJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939575; c=relaxed/simple;
	bh=HInNVGmzTf64k56n2s/jQ4dMr6uvCvfQvPVKtwkgAbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr8hkoZpyhmjC2MpnQmpFfwlJpe+zExlXJRc6cAfr2T6WBnu3cE9emc0DRbOSvOagMaYDJ4YPLZcmFEdb/N7MZT2ojx4ZK+84iEjb/+fWp/JRkwrBqNyy9ArBjVhKL1YMxVaGG4Jow+Qhzs3jNKqJYZXPwRqwxp/SgG9+qvh7tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiIR0XVk; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014d4ddb54so61691841cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:06:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768939572; cv=none;
        d=google.com; s=arc-20240605;
        b=UVv9XBeN5O41hN3Pvbi+miICVat+qGteiNvbfKUjGLpFl+ebVkC9NhgivJFw5kFJDy
         0t7RUgl25IxoS45iwET5cejvhLoVmTgMKygN8F+INsUmSeJQO5g//8+NOcGnJrs8NPMW
         csfz+ghgeu4kyCvhWg5WMctEQ/05Xve1y3i1dMPcE1W2fY56zHqkzNyBevjcmegXeM97
         P0DIbpnM8HdLKmqrsBA/3xwFTOZWgnkr3ZlTMoTKgDQvoQ1W2Oc0/mXfyqLSIf1ztvs4
         GaW4EA8wkhaL+se7fmilQ70Y2bgY8EKJeyJJmv6RnHMvehkg3Cljoo/rUaWgKaGaNYTg
         vX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HMxS9a3nR6P4ef6rYsFRs7BSEtWZeGELtFwdoWQtCCU=;
        fh=/aHkVhd92VbJ/y7jZ+rcqiFMjhPgQ22P+rwd5NuIMec=;
        b=V4ugkXQWkq6vJ1RsQoH8wNXn4eHGLK3r5+ylib5Jk60OJcZCFP65sRT3A2otoPIbSg
         ApeQFQGvLYiKEJ53QdTgaWekvQJaasAL7f3TpQ0z/BI53Ebk5DMbNafaajhIv1xfR/GZ
         4KnuZuwTB1xjy4vXGozcIFo9ccy5yXJ3xA7k84jGnLbl8uyH19tzcwMPYe/HkA/jXpDV
         jt641TQ0Ce87dNavh6LfxhZSyrXXZDa32msSuaad9VY78IObuUVQo8rYOKojE4fbyKlm
         X/fx24anhYrRigY2PLZid6kjRjNRZa030gPg+rFG6b3/368aRHIS0e2qvqRzyrZC6dq5
         NsIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939572; x=1769544372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMxS9a3nR6P4ef6rYsFRs7BSEtWZeGELtFwdoWQtCCU=;
        b=CiIR0XVkFfGCnE4ceWgDogUbpQoipY2o2APPUX6/xm7m3J7Pf4BBgqTqfnpUGF3u0f
         5dvMdJa75B/2utYyTxbDrqM8X1h9KkyPQpgsROo6MYxJPMnaWSs+YRxgPmGvblHGyoM/
         5oe9X5K6uvmukIk64OR/jlxLTEZgo+uuBKlA3c0Wx0a0zxR8cBeaheK/ZB7Idg5Yqyi/
         HQLXl7LQKikKhwVku4ng53f+NltUNepnBrB1oeEddCfAghC/kfpIoaM75Whape/3jisF
         JBgJK+nHbw7eUtuh3jkcANFOsUs44ZHjwT1V2VWYSCR+1FClsVNT1/gLxOx/iUsOXWgr
         X/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939572; x=1769544372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HMxS9a3nR6P4ef6rYsFRs7BSEtWZeGELtFwdoWQtCCU=;
        b=OKBhlOLgjkvWTiCKGE5HeFsC5w+WmBS2JLcGhJ0H62hVbfL+WYIf8etodmaoHVk8zD
         RSa+P/lESMP5xCHxJXP4bBnehcKtb8o1UTvr1CYa0ws6THJxS1B3L/71epWntiRJcGhT
         IeULxXodnTR6Edex+z98tBH6ITZNlNz5hMkllv1EgLfU38phCJl8XAZnUpz0ZNftgdix
         5slE5gs3Q+/+QwglihaKlGEpQ2bPUse+pL06bNgS/A2vNHGdlKQPxbAdAXE7XD3XcUQL
         g21y5EAgxUkJb2O5GmxREkjyiS+k3CMgHGZe5evbpdtOKVCjNHdFRyB3ThNQnuRDiYGc
         fYvw==
X-Forwarded-Encrypted: i=1; AJvYcCWKAhOh33KHLs1xv+CqDNvxMgEHWpQpur7kMdq0CYi4z7EEiEo3VnPcgmE1Kgc7a8rbhv3+JBYQbH6IO00A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xdYNNnZefjJSC+VfqpvneGOEROC6k77SDCIuX9tdn2EgGwkh
	8ApBdf/cXe+Tsj5Etg/Ona/gynEaq7gdRVadXytSo6moTwG7VEUFzn8YLaqbzUOdC/mvuQSfLmG
	z+jsF+I0BDW5Ks0h5ItZCkZHQf5dazYxzsbHF9oI=
X-Gm-Gg: AY/fxX57oMGa7CsD1A4Zf8xCasLoBVt7hSmf3fuBO+WB8mkP6xfLhmI2mIC6ZeNmq0v
	l+gZFrb+UzI5DQx7GxvPtjmLWnG0VHzq/NkOdoHf129aEZpnyV2jUbMDm857kZQ5AFxp6j4vaWA
	xr7e0ALIHsM9tmpN1VUSrOxP2yDpuwM6BnvVTVG5AJISP2+KGZlxhxsLgwQtWE/AAtJxbU4e3yb
	brOw4ViKi+CoiJlSzm740CYKJ11W19QRzlSoA/yW/z9uzKkOQydX//5hA1QDsNZVh3u4Q==
X-Received: by 2002:a05:622a:1ba9:b0:4ee:42e5:f5ae with SMTP id
 d75a77b69052e-502a16893acmr220127291cf.25.1768939572368; Tue, 20 Jan 2026
 12:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
 <20260116235606.2205801-2-joannelkoong@gmail.com> <2295ba7e-b830-4177-bccb-250fca11b142@linux.alibaba.com>
 <CAJnrk1Y1SkEgEjsJx9Ya4N2Nso08ic+J1PUzYySiyj=MR1ofKA@mail.gmail.com>
In-Reply-To: <CAJnrk1Y1SkEgEjsJx9Ya4N2Nso08ic+J1PUzYySiyj=MR1ofKA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Jan 2026 12:06:01 -0800
X-Gm-Features: AZwV_QhX98XRoXxsti0aQa1pipc1gOxpsshAAMDmsRFcP1V3djdVCuW1jdf1oEM
Message-ID: <CAJnrk1YNmN1rcZ8sa8SHzBt-M1AcO9bsQv1090W=po+vFVMr5g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] fuse: use DIV_ROUND_UP() for page count calculations
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74720-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 316EE4CAF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:10=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Sun, Jan 18, 2026 at 6:12=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba=
.com> wrote:
> >
> > On 1/17/26 7:56 AM, Joanne Koong wrote:
> > > Use DIV_ROUND_UP() instead of manually computing round-up division
> > > calculations.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  fs/fuse/dev.c  | 6 +++---
> > >  fs/fuse/file.c | 2 +-
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 6d59cbc877c6..698289b5539e 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -1814,7 +1814,7 @@ static int fuse_notify_store(struct fuse_conn *=
fc, unsigned int size,
> > >
> > >               folio_offset =3D ((index - folio->index) << PAGE_SHIFT)=
 + offset;
> > >               nr_bytes =3D min_t(unsigned, num, folio_size(folio) - f=
olio_offset);
> > > -             nr_pages =3D (offset + nr_bytes + PAGE_SIZE - 1) >> PAG=
E_SHIFT;
> > > +             nr_pages =3D DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE)=
;
> > >
> > >               err =3D fuse_copy_folio(cs, &folio, folio_offset, nr_by=
tes, 0);
> > >               if (!folio_test_uptodate(folio) && !err && offset =3D=
=3D 0 &&
> >
> > IMHO, could we drop page offset, instead just update the file offset an=
d
> > re-calculate folio index and folio offset for each loop, i.e. something
> > like what [1] did?
> >
> > This could make the code simpler and cleaner.
>
> Hi Jingbo,
>
> I'll break this change out into a separate patch. I agree your
> proposed restructuring of the logic makes it simpler to parse.
>
> Thanks,
> Joanne
>
> >
> > BTW, it seems that if the grabbed folio is newly created on hand and th=
e
> > range described by the store notify doesn't cover the folio completely,
> > the folio won't be set as Uptodate and thus the written data may be
> > missed?  I'm not sure if this is in design.

(sorry, forgot to respond to this part of your email)

I think this is intentional. By "thus the written data may be missed",
I think you're talking about the writeback path? My understanding is
it's the dirty bit, not uptodate, that determines whether the written
data gets written back. I think Darrick had the same question about
this. AFAICT, it's by design to not have writeback triggered for this
path since the server is the one providing the data so they already
know the state-of-truth for the folio contents and that should already
be reflected on their backend.


Thanks,
Joanne

> >
> > [1]
> > https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jefflexu@l=
inux.alibaba.com/
> >
> >
> > > @@ -1883,7 +1883,7 @@ static int fuse_retrieve(struct fuse_mount *fm,=
 struct inode *inode,
> > >       else if (outarg->offset + num > file_size)
> > >               num =3D file_size - outarg->offset;
> > >
> > > -     num_pages =3D (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > +     num_pages =3D DIV_ROUND_UP(num + offset, PAGE_SIZE);
> > >       num_pages =3D min(num_pages, fc->max_pages);
> > >       num =3D min(num, num_pages << PAGE_SHIFT);
> > >
> > > @@ -1918,7 +1918,7 @@ static int fuse_retrieve(struct fuse_mount *fm,=
 struct inode *inode,
> > >
> > >               folio_offset =3D ((index - folio->index) << PAGE_SHIFT)=
 + offset;
> > >               nr_bytes =3D min(folio_size(folio) - folio_offset, num)=
;
> > > -             nr_pages =3D (offset + nr_bytes + PAGE_SIZE - 1) >> PAG=
E_SHIFT;
> > > +             nr_pages =3D DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE)=
;
> > >
> > >               ap->folios[ap->num_folios] =3D folio;
> > >               ap->descs[ap->num_folios].offset =3D folio_offset;
> >
> > Ditto.
> >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index eba70ebf6e77..a4342b269cb9 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -2170,7 +2170,7 @@ static bool fuse_folios_need_send(struct fuse_c=
onn *fc, loff_t pos,
> > >       WARN_ON(!ap->num_folios);
> > >
> > >       /* Reached max pages */
> > > -     if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
> > > +     if (DIV_ROUND_UP(bytes, PAGE_SIZE) > fc->max_pages)
> > >               return true;
> > >
> > >       if (bytes > max_bytes)
> >
> > --
> > Thanks,
> > Jingbo
> >

