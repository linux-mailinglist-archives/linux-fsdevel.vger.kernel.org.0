Return-Path: <linux-fsdevel+bounces-76482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCIgOPfzhGkq7AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:48:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204DF6EF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87ABC301D07B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F130BB80;
	Thu,  5 Feb 2026 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxj1D0Cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C732A3C8
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320878; cv=pass; b=f5h27dr7MozXdI/UuhMIYcdsFd5PV/mXUD3OsACOLe6GM6XO6fRqYy3X/akVlPlYdxocfDD8w+u7UrDiO3OvTdQ03bainq4OwjET3UUtiYiCSo+k8z2QvvP5E2miEvZXlrIDyj9fy09XpNMVXBbVSeuJtejWGzSkn06xHsG5bUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320878; c=relaxed/simple;
	bh=xMipxxaS1jf8fI9UvS/zGLVXSrAmECyos0ZCNaRRuNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr3hz7l7zx+rra3fyMMRe8pqbQDjENjxrdIZVKfk0Qtu40AsfCQyIOX4kV7WlA8UCJez5+9tXQr9yPZ3K4HOhSnrz0Of5FLz/uz+XuBw1eO9XJ4kZ1VdxvZUkuxTYUpz/yr5B5ICVlyfji1dCGWhBbCGPiSAXwUaW1fsAypVZu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxj1D0Cf; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-894770e34afso18866356d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 11:47:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770320877; cv=none;
        d=google.com; s=arc-20240605;
        b=YKaF4h3v9Sg+ssjx/RLwmmaQQBeoR/TQNl617AL9klS0pOW4gYyRvI+P4zsinqDflO
         6Bb/24LptUbTNcIk8bNd8dZptAQguiaoxenCGMf1g8jF34GIKQzXfyQEKt7T+5DkY2rZ
         KfGJ8pZ/VPkmnz0YFoweJ1iosL3mczdFS1kI1wUnINxcA4sFANqASX5IyTKyqwChAFRT
         igFuoq1AMIP9ik0UBX3iycuikyjzC2Yd4VkGBR6I5fjC3rcAwfm1Ar1naj0DmpoWzi/c
         PB8+vGw6NvHkQSBfRH9v91ib3DbYlZru65THxfPo5ZG+OCuCEuRKzxwG1+Wwaj4RcZRY
         alTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFlhr6RPDkRedt0OgucOsRX5uExdwYqqByKKZziXS4g=;
        fh=LANFu9nudW4KRmxqDPaFbXxs8dr3LdB+/Z+w/mHQfXY=;
        b=H3hbmsKI4n4FUGN7kveruyUilZ/HAYC5VjTTOBI2HtGAd60owIrzC64xbFX9bfVY+r
         Y5+lFfQcyyf7Tsi6DXKmGtB4tngaMiXlDJjeMx6ovszXxa+oUD/5iAjKNvHs8RThxmSs
         77MO58um0RpBLpIDozCp/yc5xQ+U0ZR8wK86NAnOli4SEfvBXF9G9dBFQ7G2I0bY4Hng
         inPGeqpv/KpyYDCxgF/CwEi08q3uGObZU/9MxWT2nx8kSg6W9o4BJStUr9CtbTb5QQze
         ov3C5/Xwq03H1xpzBOFCZ58wtdPifhIFC0lZWTOFClSTSjhhTBCaoDD+a/KXUY/9cNl5
         VCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770320877; x=1770925677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFlhr6RPDkRedt0OgucOsRX5uExdwYqqByKKZziXS4g=;
        b=Yxj1D0CfTfSBg8AuHMrsHtnFQvZdQlu3ezJ9JpaYX+3cihUn0wjjNn8ii2IBj9lOMh
         F6MLptOHNw83CB/ZSnHSSGcdPYnYWLV8V9+0uJdU6aq8uQ65EgS14v+MpmOHEPUoS3e2
         dJS3wL6HicsciWQ5wYPBsDTlKCVb275fxCemz1rZiovhwEqTZempZXcDNFiX2JY3ngjF
         5PUQ+fkmorXbkycKaCaqTZacq09wi+7GC0cFdLI4OWMts1c+GhllpJcW0jmFqMUEhG1l
         bWf/HhcbCtdVHmysdTJ1B3uFQbI8OJDRJ0sBjs4/knusYAiLEuK0u4NFuCDXk99d6LLS
         nYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770320877; x=1770925677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFlhr6RPDkRedt0OgucOsRX5uExdwYqqByKKZziXS4g=;
        b=OUVTIUv1V8oJprcc0uKaPxR+MIrgIfca6JZnqE1jA0kNiU31xGHDH++vJ2Xt3hz9tr
         kBetdva8QF9jW8r8sqp67i6Jq6M8ZwdiBf+XfB1m5Lo4OlZZADEwCqhjQ5TIrlyhMJdi
         iLSAi3RpvNw3MQxlcD+DSybODoRzTkMYygXvpuSddT1zG8pLY2q4ugGTDAzGZLf9btpj
         B5Q97sXz3pRNxBxBdk4g39GeY7Pwe7ArdfbmZlChh5l9K+7l28Js43AN2vZnWkJPh2Er
         4XUC17RKa4d3qok4kSub3RTXxBSSt5Ci8hvPz86A/mNxfV+veL2ouo2SuJ6ap9AivH2O
         2YJw==
X-Forwarded-Encrypted: i=1; AJvYcCX4VHFJixUQ8+mM+NXDeRxyQ1wVKWnVmmlSmrMBavP49UGHZ0H9Ca8aOvJ/2hQKMUrGTX5M+jhJ6qWnDD2I@vger.kernel.org
X-Gm-Message-State: AOJu0YxifjspjRxeugsaPmPAMOfp2bZMCS88IQxNFOPwlYvYNfEzmH/K
	hlcUS78g0MSp8/QZnzTve9jLZcKiKEFBDmHRcsZdGaSfJfwH5WRyYwfV9IzIXIjBNCZKHcvQKid
	5kGzXO2iBUN02g922bzn0maErBoY3wYA=
X-Gm-Gg: AZuq6aKq5dr5jrkDo/j9PXxxjR1AN5GeqdzB6otOC6/1Bu8i2hwOkKi9jo2tEKr9YTj
	BVYoy1Ac4hggyIuMlE85381Y8k8Gni8wk2zuA0BjzvFLB9TonPJn+L0UTjMQgYOH2ch+m9UfOZx
	sNoupRaUjq9UGe2XSsmb71q8B7HhqC/ELj52bfIpPpqXEMlX+Z2zBHFnv8OH5WNbnjYhfM7lwt0
	MWnT+9dx45BIHeGPJAS+NfdVRTCQSSj7wXeT9LAskMj/CysSLi5YoeceF4HYNmUlcOv5QZW9zI9
	bW3X
X-Received: by 2002:ac8:7fcf:0:b0:503:2c49:34b0 with SMTP id
 d75a77b69052e-50639a01b8emr3334781cf.62.1770320877157; Thu, 05 Feb 2026
 11:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-8-joannelkoong@gmail.com> <4f96f8b5-7f51-449c-9717-8c8392a3d671@bsbernd.com>
In-Reply-To: <4f96f8b5-7f51-449c-9717-8c8392a3d671@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Feb 2026 11:47:46 -0800
X-Gm-Features: AZwV_QhYBWmYp9BycNAQzsrtgDVQ5VuhGaSXHDxbgGR7nom0RYEUnDrPs6UIVo0
Message-ID: <CAJnrk1aQs99+xjTy01zTF2MpbaOe-TgkyazJ1pKgkHz+TNZ9AA@mail.gmail.com>
Subject: Re: [PATCH v4 07/25] io_uring/kbuf: add recycling for kernel managed
 buffer rings
To: Bernd Schubert <bernd@bsbernd.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76482-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,ddn.com,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,bsbernd.com:email]
X-Rspamd-Queue-Id: 3204DF6EF2
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:44=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 1/17/26 00:30, Joanne Koong wrote:
> > Add an interface for buffers to be recycled back into a kernel-managed
> > buffer ring.
> >
> > This is a preparatory patch for fuse over io-uring.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/cmd.h | 11 +++++++++
> >  io_uring/kbuf.c              | 44 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 702b1903e6ee..a488e945f883 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -88,6 +88,10 @@ int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, =
unsigned buf_group,
> >                         unsigned issue_flags, struct io_buffer_list **b=
l);
> >  int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_gro=
up,
> >                           unsigned issue_flags);
> > +
> > +int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_=
group,
> > +                        u64 addr, unsigned int len, unsigned int bid,
> > +                        unsigned int issue_flags);
> >  #else
> >  static inline int
> >  io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> > @@ -143,6 +147,13 @@ static inline int io_uring_buf_ring_unpin(struct i=
o_uring_cmd *cmd,
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > +static inline int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd,
> > +                                      unsigned int buf_group, u64 addr=
,
> > +                                      unsigned int len, unsigned int b=
id,
> > +                                      unsigned int issue_flags)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> >  #endif
> >
> >  static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_r=
eq tw_req)
> > diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> > index 94ab23400721..a7d7d2c6b42c 100644
> > --- a/io_uring/kbuf.c
> > +++ b/io_uring/kbuf.c
> > @@ -102,6 +102,50 @@ void io_kbuf_drop_legacy(struct io_kiocb *req)
> >       req->kbuf =3D NULL;
> >  }
> >
> > +int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_=
group,
> > +                        u64 addr, unsigned int len, unsigned int bid,
> > +                        unsigned int issue_flags)
> > +{
> > +     struct io_kiocb *req =3D cmd_to_io_kiocb(cmd);
> > +     struct io_ring_ctx *ctx =3D req->ctx;
> > +     struct io_uring_buf_ring *br;
> > +     struct io_uring_buf *buf;
> > +     struct io_buffer_list *bl;
> > +     int ret =3D -EINVAL;
> > +
> > +     if (WARN_ON_ONCE(req->flags & REQ_F_BUFFERS_COMMIT))
> > +             return ret;
> > +
> > +     io_ring_submit_lock(ctx, issue_flags);
> > +
> > +     bl =3D io_buffer_get_list(ctx, buf_group);
> > +
> > +     if (WARN_ON_ONCE(!(bl->flags & IOBL_BUF_RING)) ||
> > +         WARN_ON_ONCE(!(bl->flags & IOBL_KERNEL_MANAGED)))
> > +             goto done;
>
> Misses "if bl"?

A buffer shouldn't be recycled back into the bufring if the bufring
has already been unregistered. I'll add a WARN_ON to make this more
clear. For the fuse case, this is ensured by the kmbuf ring pin which
prevents unregistration.

Thanks,
Joanne

>
>
>
> Thanks,
> Bernd

