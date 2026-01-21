Return-Path: <linux-fsdevel+bounces-74928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB71CcxNcWkahAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:06:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F1B5E78B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AE4B862446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669013A63E1;
	Wed, 21 Jan 2026 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmVeZkSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1E30E0F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032808; cv=pass; b=o0JxF8yKf81vjLlTxsuh/RGn5TETlkBnXbgtoApWW/f3JMNeUbBbqlp6pCOOlpQ/EvDBNLCPDWeadHcsDateCIG7ZnIjKOqtOT3IcV6EK5mbJ9pp5sldBQJ1A9Kzrd6JxWDWbpykT9KO9TdQz9zcFsl4NiRwKR4YxaVC0U9uevo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032808; c=relaxed/simple;
	bh=n20Sikp2SQk665H3G3YoOFEXUaHIXKBbVteNoP7xLbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsaETXbbey1ZvA4xjNmsWBS9Nf8AZ/QagWSO1S1NE1tXDlyNfroA6xKbSL7WDXGVElyjD0Du8ycCILufBxt8jYTXW26aWC+UuSNX9tfSRvSrISj84lyonCU0S7360DnCViEY1SXY9+3ANhFcubHNqbF3yE9NsZB358TkisuWhds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmVeZkSA; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014453a0faso3677031cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 14:00:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769032806; cv=none;
        d=google.com; s=arc-20240605;
        b=Mk6X+2IduecBY2UGYQdggJjO5spL6UjLEFXe6tPFZuHtGNLLwiZE8N1BziIHHy8WqN
         CwNAnv1RcuLrqm1E7TyoZ6MWJR4G+RurEaJqLWlgguPIK6sSqpVFCYxhRQGx//c3amwx
         w0+0+OGIT+DOFazVkRTEj6aYCVsjOke+YaXBVljLYzp5AMlyIDrm0GaWDb5Lov3FrZo/
         1gD1sSAQq2cGWjn+9TTrBNSEXCaAKywKLNYIXsPUkzi7smoUy8t7fTnYsOB1TVGdDOTK
         HX36Ztwgz5p6ibo45+bCcnZLNSlUv/rVPXpimZssjmrjk/ZoiS7LqSWDTW8CMKtS5wsS
         yrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4TtHRUW7xlWrbSqOnU+cgX0N50pyMyRiQunz+jW81SM=;
        fh=sGWwN8uTrAN9JazyS8Ew5AkZTF5BImhxGZgtaH88teo=;
        b=caWc2k1Egxo89QwtI80DHnONBLdr6as1AZUrAaaU0QfqjhkWKJ7zpDt9zD3hy2nzpS
         7PC1N7ogh6Ex9GOfQKVQd/AYotwRayNVCHyEobWRmEflFb2KD1n+MoIxfojoBYeYyBRU
         6EoH77bZiv0/fmpvpOzmYsjik8cnscH5U6TOIFuJw3t3VdWtlx0U7zrfSWrfKF2vydoV
         rc3hF5uLk9PxCCReQTV3EHKacacIVGU5qroYbyE+QbHP7LvNnQzV4zjc/RkM1Sfy26ev
         f17iPc2NnPDtUmtofV8zqcVHijkPNFx+bIHoUfVxRBVMQNlcygNbAtRQ93qtQbPl1fEF
         +xTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769032806; x=1769637606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TtHRUW7xlWrbSqOnU+cgX0N50pyMyRiQunz+jW81SM=;
        b=AmVeZkSAu+Og23cwQPyyy7RCYvmvmhstcBeU928TdcCTkwaKsdjQrft7SB61Xu/AXI
         0L0VvnFJNyvwe759LpV+MTigjc4vQS2sVhK2AGX4ERMVYlm0NG40Cfx2s6XEzckwHbml
         DmYhNRS7C3sH1vgRDln2IDNWgBmqoBpqFnhE1bUlDHpVUGtvE2AlrS9rlT5nxsePECDm
         ixlJKWVRwarVF8TPaDBcH1sCzBuV4puxBRezFH7aEH5PinXP+i20mLWUWu6rh2pWOOWv
         z0z6/NEHJ+uDT5k7JMAByuy1tmWv+KmvU5SgZASUBgeqXSMhMSd4DB0Vzsn1vPfR2oHg
         c0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032806; x=1769637606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4TtHRUW7xlWrbSqOnU+cgX0N50pyMyRiQunz+jW81SM=;
        b=vSo9NZw5d+Johil482xFb3lG6EI5SekzI4P+CtCmy5Wav4MeiAmrxp9nZ2FKvf6I1H
         A2/vcg9iKGBJHMNcuICuCIU4LbockPK+fSXpABZHxNMvkRZ95vzrnaUAw7q6+60Osiyo
         SLf5yCCh1x6AUR2USR4PKhabvOQDOKLxeTlfIkwBNWhCxZtv5S/HqRnrbsYXyrRCXFNv
         7KnknVmhJ9Bbc/kZD291KazVdZ00aDwZkS9JC3rvr9m2hS0WMYYVaMxMG2/8fBlEFpW6
         9ev7Mq3rFXSmf4xfrsgk5bUJ1AdKaKl2D7YuoL/+HCfyXkuyY9RQfYvrDcaGNXIar6uN
         sxfw==
X-Forwarded-Encrypted: i=1; AJvYcCXDASc3taSzHPMoRQDy0vQD5qKENzVBDfFQU8T3IEq/hgGsNd/JXSAEUh5Z9lqwOutwM9giRtCxuSwZgqTZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwALmzaydr9BaQDkvWEQ6PyJbo0UVgSkwe1X13pwCqRxMjWrSn2
	CvgPjAZRRi8X1YimprJh/1S9vZVk4Db+C00RvxZ9WQyw2e0TwKe3/CRemUHdiBuFR+HInHc9ALC
	qzVBtCkdm4cHA1SQFHzAVVq1+XTlhYc8=
X-Gm-Gg: AZuq6aKUNW0FXTRYCW5HvN61S3o9tvSRMvbsChKbLlyf7j4woppCPZPXUNCJYFJ88Tp
	yrMTpMAVa3WfoP+cXgsQIP+rAK0oI9//Rk00m5xgFHUl8kSFfFhDqW2LxgPSsqmF6VWUq29a+sB
	ZfPU6KrdXOsoUQwY7WjPwHaqiJsI54rIVxhAQn71Vs5R+ovpZIRUyDZ4xH6LfQhFSM0BvLIp4Do
	7cZ2mrUgVScC9ISArirlZMyzmdF4fEy5iV+H1DGRtCWCAx5At/CF1Spz1PlNfGy0tu+WQ==
X-Received: by 2002:ac8:4452:0:b0:4f1:cce1:fc0 with SMTP id
 d75a77b69052e-502e047a4f0mr43394391cf.37.1769032805960; Wed, 21 Jan 2026
 14:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
 <20260116235606.2205801-2-joannelkoong@gmail.com> <2295ba7e-b830-4177-bccb-250fca11b142@linux.alibaba.com>
 <CAJnrk1Y1SkEgEjsJx9Ya4N2Nso08ic+J1PUzYySiyj=MR1ofKA@mail.gmail.com>
 <CAJnrk1YNmN1rcZ8sa8SHzBt-M1AcO9bsQv1090W=po+vFVMr5g@mail.gmail.com> <90a1bb2f-3c21-4ab8-86e8-b94677c0976b@linux.alibaba.com>
In-Reply-To: <90a1bb2f-3c21-4ab8-86e8-b94677c0976b@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 13:59:55 -0800
X-Gm-Features: AZwV_QgCR8VlFve9a_Y0rNQFiLEt017wkUbuLtvcpDPFz_QLyvSnohFOoUEo3os
Message-ID: <CAJnrk1Z-cSywcZ+0LyEb_tNWZRTLrHjFMSGSJPzNO4EqK4wozA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-74928-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: D7F1B5E78B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:21=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> Hi Joanne,
>
> Thanks for the replying ;)
>
> On 1/21/26 4:06 AM, Joanne Koong wrote:
> > On Tue, Jan 20, 2026 at 11:10=E2=80=AFAM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> >>
> >> On Sun, Jan 18, 2026 at 6:12=E2=80=AFPM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> >>>
> >>> On 1/17/26 7:56 AM, Joanne Koong wrote:
> >>>> Use DIV_ROUND_UP() instead of manually computing round-up division
> >>>> calculations.
> >>>>
> >>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>> ---
> >>>>  fs/fuse/dev.c  | 6 +++---
> >>>>  fs/fuse/file.c | 2 +-
> >>>>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >>>> index 6d59cbc877c6..698289b5539e 100644
> >>>> --- a/fs/fuse/dev.c
> >>>> +++ b/fs/fuse/dev.c
> >>>> @@ -1814,7 +1814,7 @@ static int fuse_notify_store(struct fuse_conn =
*fc, unsigned int size,
> >>>>
> >>>>               folio_offset =3D ((index - folio->index) << PAGE_SHIFT=
) + offset;
> >>>>               nr_bytes =3D min_t(unsigned, num, folio_size(folio) - =
folio_offset);
> >>>> -             nr_pages =3D (offset + nr_bytes + PAGE_SIZE - 1) >> PA=
GE_SHIFT;
> >>>> +             nr_pages =3D DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE=
);
> >>>>
> >>>>               err =3D fuse_copy_folio(cs, &folio, folio_offset, nr_b=
ytes, 0);
> >>>>               if (!folio_test_uptodate(folio) && !err && offset =3D=
=3D 0 &&
> >>>
> >>> IMHO, could we drop page offset, instead just update the file offset =
and
> >>> re-calculate folio index and folio offset for each loop, i.e. somethi=
ng
> >>> like what [1] did?
> >>>
> >>> This could make the code simpler and cleaner.
> >>
> >> Hi Jingbo,
> >>
> >> I'll break this change out into a separate patch. I agree your
> >> proposed restructuring of the logic makes it simpler to parse.
> >>
> >> Thanks,
> >> Joanne
> >>
> >>>
> >>> BTW, it seems that if the grabbed folio is newly created on hand and =
the
> >>> range described by the store notify doesn't cover the folio completel=
y,
> >>> the folio won't be set as Uptodate and thus the written data may be
> >>> missed?  I'm not sure if this is in design.
> >
> > (sorry, forgot to respond to this part of your email)
> >
> > I think this is intentional. By "thus the written data may be missed",
> > I think you're talking about the writeback path? My understanding is
> > it's the dirty bit, not uptodate,
>
> Not exactly. What I'm concerned is the uptodate bit.
>
> In the case where "the grabbed folio is newly created on hand and the
> range described by the store notify doesn't cover the folio completely,
> the folio won't be set as Uptodate", the following read(2) or write(2)
> on the folio will discard the content already in the folio, instead it
> triggers .readpage() to fetch data from FUSE server again.

Could you elaborate on why this concerns you? Isn't this necessary
behavior given that it needs to fetch the parts that the store notify
didn't cover? Or is your concern that the contents are discarded? But
the server already has that information stored on their side, so I'm
not seeing why that's a problem.

Thanks,
Joanne

>
> It seems that it is a deliberate constraint for FUSE_NOTIFY_STORE.
>
>  that determines whether the written
> > data gets written back. I think Darrick had the same question about
> > this. AFAICT, it's by design to not have writeback triggered for this
> > path since the server is the one providing the data so they already
> > know the state-of-truth for the folio contents and that should already
> > be reflected on their backend.
> >
> --
> Thanks,
> Jingbo
>

