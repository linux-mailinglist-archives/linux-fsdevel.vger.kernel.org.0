Return-Path: <linux-fsdevel+bounces-76483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMxVE3v8hGlh7QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 21:24:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A84BDF71C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 21:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83BE301DE12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 20:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324730B52B;
	Thu,  5 Feb 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g33K86yr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8C30BB83
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323059; cv=pass; b=TqRw7hthuTkWm9awNNZ8qIca7I1TF1CQYuj67MutSE/N1BjYwlwoVXeqPC7BW247ISxZPLWydDHfd8ENt1qlqI7w8eDB49tg7bmptApXffq7RSRdWR5B0gb5srW3R9BZKarmnvU5v0Ga18FRXZUMBE0a2lK6BjQDAnz58AJN2Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323059; c=relaxed/simple;
	bh=S3+HUgc5xhKsZqB0NcPLqa2ZSEuW7f1/uiPG5ri3vLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZV6y5fSDnwGVifyt8ewMVoylN9jd2bX1Hw7o4N8why/4QatHDxwEQ3u7/VArvgTrWhTOv2N0FyIRIS2qGsVvh7OsnqhK1LyQtTFtXqw5t5HQXszUzUt0d2UlfRWmKjDKR3wD0GrUGZnqeon6hwKOt3hwb+TwS2Yy3ejAln+8pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g33K86yr; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50331ac1fedso17071711cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 12:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770323058; cv=none;
        d=google.com; s=arc-20240605;
        b=OGSIqAoYX8Bz8U9epaepEQ6elHfyBOpxczMsDuLxwqO2Ckygzz5wMQBErOOO/Ma57F
         a6jKjTHE8/bw6TfzJ0hyAsVQiyFM8PtoUOcQdk7Vocu8ghUKckRYUpM4j6IzobZEItYH
         eB9vrPnpm5bfceroHEVW5kZ6pHcIqJ8sOSoamKQjrMX9pUXRpGRQTsxyWQ8eAyheNPuu
         3BXXxd6Lp3IUWca3aLOA7YMLPEIryZKn/r9uNK/ULn+2jwjGxwrDNd+N8tOZvJeVjYBo
         lraRfeFh8iVMnm367qa2GPwgwTIODyjFTYBY5dI8qp2DX4IKRJYet1NjaUX0T8GfuP7B
         k6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A4rQAHYa4uo41YSDNy9tKjoHnPR55il07V0VEJ7EG3g=;
        fh=X+kTYDzY8Wh0sUN/eE7eppOyOD23rQV6umGLuek7YKo=;
        b=MNtVvRnn1zJ5V46ihNGAo/y6LwpoJSPa4gs/xV5OTKkTN9+JCUQO1Ui1azV8+zvlYy
         XbV8520Hoj/rrFNYCaEgueZ6YMotcGTT1jyueMDVvnKSKYxrlOBPcSvJ7z7zJCsMEfQX
         Le4YjOb4pnwIF0/W6xOwVaiSs14ynofFHcg0Tiq2DTUiw3ImQAF/r/oZL3ze6+sKyJ0b
         hGPQi7Q+Y8wjTqQw/4vXo9QIU3CbSTnyI2tfnDFPC5yQE85qWtuRi544+5J3xr9PsZsG
         8aQS/e084hkTywbnF8uAT0LKgBgDDQR3nBrXwQPtrBpBeoJp/ffkCiW376jcdXw3+k/k
         yEmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323058; x=1770927858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4rQAHYa4uo41YSDNy9tKjoHnPR55il07V0VEJ7EG3g=;
        b=g33K86yrqA5IaP9f/NTcL9agDzPopLZs312ek5wJnr5LYpGGh826hlE/rxCUqmHD3N
         DrOIDuceDF4Dk3rW3KsPMafxGBejsDiG5c6vFLLv3LjlbfghYiJ4AXGQjEGEjaYELOwF
         5mMYRJguAbBILrzrB2sPEptDD/0cnvvShMburqhNX8m73AN6yLOK9FBF84rtcSL2r50A
         J3F2NPBi3SP0cnIatppCAYUnnWYBi0lGj6GaizlQIxJ3rF1zemQkkMd4PhgwM0v27Ttd
         Vn/tlqXFomppdT3LGpeAaFoPpwTVQIpVdgJB7yE2it9+DZ88pxdFS2gBXsPcmWpf4Ppd
         eaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323058; x=1770927858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4rQAHYa4uo41YSDNy9tKjoHnPR55il07V0VEJ7EG3g=;
        b=hUVe/CQTVaPC6zztLJ+mMkTO8fok7qEwwr9YFZaVrh1u7sRoStfGgr/Zl1yM6ykE9e
         g1lxG2vEecU2PTw13MMBmffxz1quUtvE+DoyP8Gw6BmejO5p0qt2nWUsHP9HE57Sz0rG
         ODd1CcGX9dDdpybAlly5ST7hRNaL8xgD8liywgQ+533ABIXTCpmDZx7N37lMVPmvJf7J
         SKu5oBQl9apnMVi7fQmFphi4Azg3sAmN+6cLUIGRdvePuEfwqgb3g1GKm/vp4tB063rx
         b/Jen/UhbGNeCxuf5waD6/9ppaE5oypHHybms5OvtEbSVWzoHt2+KAqh408grzjb7meQ
         T/bA==
X-Forwarded-Encrypted: i=1; AJvYcCUo76qJtacK7luXJmQrrsvNWL0q0IwGSxU79QGzuWmorwkThWYq1uVN/bx71e9ipzwLHr1+RgoTe7gS6x+n@vger.kernel.org
X-Gm-Message-State: AOJu0YwseaF0B8nJY6g2hmj+rfPSQOaP/eJ+f1C6QLgqGqlJ+uVAdtXX
	sL2Y/NfvkP+aEyBppjpF+KIQ91g28kQaGVxmcpIOiq2GXEI24rAtQo1bb/PajEnYZQ4LiijFcWn
	AlilssCCVttvCecqK7cqeG0sNAoC9x5E=
X-Gm-Gg: AZuq6aLjRHHadcIwhSxhLFH2rVWZ1rkEsoIwDb+2dIrFcDidjaf7n6+ratCeHQpfrqT
	X6ujpWULpP/4A3H+seNbu2ZV7mQRdbwchQEnb2OJ/xRr05bjFQzBpPnHeCvgp2WqYYKOg/qyWMF
	ZvhRwy7WmsiyvGCRTIE4QMSMUoRHLIychzSdIwAFAtM0dL0/tTHCWvRJZYpFN2LS2GavKUUEDPS
	ih75FQYW0Yslr4MUM0sWciaOl6dtCXzGUOx0JLnl2YC30yUsc2V/CzeiwMICNzDWeltPvHGewXU
	vqag
X-Received: by 2002:a05:622a:11c4:b0:4d2:4df8:4cb5 with SMTP id
 d75a77b69052e-50639846a02mr5424461cf.4.1770323057856; Thu, 05 Feb 2026
 12:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-20-joannelkoong@gmail.com> <4e406b1f-723b-4dc7-8e50-1a5ef6ea11b3@bsbernd.com>
In-Reply-To: <4e406b1f-723b-4dc7-8e50-1a5ef6ea11b3@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Feb 2026 12:24:05 -0800
X-Gm-Features: AZwV_QiDCR3_x1geRa_vjmXwrXH4h6mSf95NjPk0KIk9g9JYArpB8f3NvqNm8LM
Message-ID: <CAJnrk1YDa6=ygmaNhtoDudGdLKmWsP52+_aYNz3E_VNzQUVsDg@mail.gmail.com>
Subject: Re: [PATCH v3 19/25] fuse: add io-uring kernel-managed buffer ring
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, csander@purestorage.com, 
	xiaobing.li@samsung.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76483-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,kernel.dk,ddn.com,gmail.com,vger.kernel.org,purestorage.com,samsung.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bsbernd.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A84BDF71C6
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:58=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
>
>
> On 12/23/25 01:35, Joanne Koong wrote:
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
> >  fs/fuse/dev_uring.c       | 423 ++++++++++++++++++++++++++++++++------
> >  fs/fuse/dev_uring_i.h     |  30 ++-
> >  include/uapi/linux/fuse.h |  15 +-
> >  3 files changed, 399 insertions(+), 69 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > @@ -824,21 +1040,29 @@ static void fuse_uring_add_req_to_ring_ent(struc=
t fuse_ring_ent *ent,
> >  }
> >
> >  /* Fetch the next fuse request if available */
> > -static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent=
 *ent)
> > +static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent=
 *ent,
> > +                                               unsigned int issue_flag=
s)
> >       __must_hold(&queue->lock)
> >  {
> >       struct fuse_req *req;
> >       struct fuse_ring_queue *queue =3D ent->queue;
> >       struct list_head *req_queue =3D &queue->fuse_req_queue;
> > +     int err;
> >
> >       lockdep_assert_held(&queue->lock);
> >
> >       /* get and assign the next entry while it is still holding the lo=
ck */
> >       req =3D list_first_entry_or_null(req_queue, struct fuse_req, list=
);
> > -     if (req)
> > -             fuse_uring_add_req_to_ring_ent(ent, req);
> > +     if (req) {
> > +             err =3D fuse_uring_next_req_update_buffer(ent, req, issue=
_flags);
> > +             if (!err) {
> > +                     fuse_uring_add_req_to_ring_ent(ent, req);
> > +                     return req;
> > +             }
>
> Hmm, who/what is going to handle the request if this fails? Let's say we
> have just one ring entry per queue and now it fails here - this ring
> entry will go into FRRS_AVAILABLE and nothing will pull from the queue
> anymore. I guess it _should_ not happen, some protection would be good.
> In order to handle it, at least one other ent needs to be in flight.

If the queue only has one ring ent and this fails, the request gets
reassigned to the ent whenever ->send_req() is next triggered. I don't
think this is a new edge case introduced by kmbufs; in the existing
code, fuse_uring_commit_fetch() -> fuse_uring_get_next_fuse_req() ->
fuse_uring_send_next_to_ring() -> fuse_uring_prepare_send() could fail
if any of the copying fails, in which case we end up in the same
position of the ent getting assigned the next request whenever
->send_req() is next triggered.

Thanks,
Joanne

>
> Thanks,
> Bernd

