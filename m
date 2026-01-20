Return-Path: <linux-fsdevel+bounces-74712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIPYMfXgb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:09:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3174B0B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD5566CD548
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555646AF1B;
	Tue, 20 Jan 2026 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob83r/k8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252544CAFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935617; cv=pass; b=RcP3Q7YrvLd/XxUwIaRS/NpE+EsQKHvZmwPx+4jcO7YzX3EDMbUSs5EWTTSs+APUuzlNTMDDxsRjQRQcWjahJF8vg2RFEIBzH8LBuZxB/u/a6tAZ24zvNLPdUHnSrm8nT2+RqFudJgUuro9JHArHiYgt5HLWrRN6JYdKC00OBMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935617; c=relaxed/simple;
	bh=P1Ew2JummgK9rduj25GEB4DjIs1FY7DqzBx0Y6vvOac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dilXavi7f2H/SGkDtNLiaXxqNQuEbkTv1CbL8N9wW3eyj4yevsmxlNflsIQULGWTM5xhxCUfG8oLtxmK6x+a3GwLvD2pgj8It4yjZRS4Vb/89rvgjaVTdrKJCcO/op+ouWfzdesN5No43aY9jHZx0iYCTfJf8rAayJMJPEgBN7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob83r/k8; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b6df3d6b4so7121024e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768935611; cv=none;
        d=google.com; s=arc-20240605;
        b=XoXBQy2meN+am84+3MqvT9u8mhUZsA8qmezMYy/MAC+jx4gucYeZ208YDuG9cyqS+C
         A8I6RL1Koi23+yP3nBrHhNFpHKrDt6KFVg4F/VN5jiAV3qyawonYR5pjlRL1Y9QgHT57
         syjNh9vWAhwHD1kxEbG/qARbKMsVEwlU/ZRgjdnVzVV+Wmf2Fm3drre1b/uNGwYvVuNz
         hiK0WLEnhaewkdtP8h6vVdsFHPAhRddD4DAfI8yyByP7rAICRRPevsDWS9HocHSiYyJL
         SZgG+47WeHkXLyV8mdwVzIEO+cMMLqae8Mk+RW0TN5kWp/t9IUlPYxKc/cvYUYVxokYQ
         xFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xHbgTcHOHLKjqz/J3LjsfmxBgH0hErogAowAu1ESJW0=;
        fh=3hyqHrcHTSVyWSZlK4GDyXKw/eoh7B+wx6AUC7p7F6I=;
        b=NTFY77YBIfzq6/OVFwqSu6T5gq1Srh7xIqArbsoR/t+lT5OAQts465RglpHiM6Pkvs
         tWGVDDhBMj1pW/F24ZJwpmwDhojdPQbLFtDju4m7y4UMB7vgANueBRxAJ6rY39J/QqOf
         g/4+Iw42VJlycrJRmnybFkids07mm+1Xq2aN3rn/zGzLmj6IeCtYeT87DCWNEF5sJenF
         XB5geic4ga8N1/1yRYt6feW6rbidxb5k4lfXuN+rRNBLDJxMPSWkGnE5+9fgnQVInTlc
         JH25ee9+TnxrYSvXjEhCwtITvo5Q7k63mYTbSKhqutShUw7DqZIm5QfPg1Ios/spydcc
         Tbng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768935611; x=1769540411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHbgTcHOHLKjqz/J3LjsfmxBgH0hErogAowAu1ESJW0=;
        b=Ob83r/k8ivrzsEpFQbqE8J0gSq36pw2exowITFrF+LG7y9GCqv/cK0lZiDxWw59/YP
         kJoay7myCMj/MgjNAWTnADfVzrtzrzFVKr+Y044IgJes9npV9PKHyx6zc+2rHaRbVBeK
         Jucc82chiHfznvsucdVgubhTJyYSGs5aWq1VCv4BK2dpt9z/TjZ1LUmgh1EjB/PjN7De
         Dgf/qWglhvcUxSRLsaVkKJeEawSTi1rJgMPzG/EyD7zFpgUgxgQRfOfHTPWpIOiBLkHZ
         yHnv9sDCTeO4fKEjlvEm2v9g5tJZJCFpmkjBWJUqstWu/C6VnCAg8Et5v7tFwosweAQm
         xDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935611; x=1769540411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHbgTcHOHLKjqz/J3LjsfmxBgH0hErogAowAu1ESJW0=;
        b=VUdQ0Ict6gjoYatt/EwUbpmW2Sbwj8HGsPaNyf3rX2y4z+dGlu606rY9T7c3Z0pb/s
         hrO6p/KBSoKUo8x7Hp0iHhW0f6UDjlMeoDYDcOWlRgYJ/KMyD7EX/NpYXiv2dqN/w6lA
         9K9pkW4vQYY0ToYoMkp0Pgn66j28vECJUoTyB3Qn4xoxQfIOvXkEHlzwNgMliUoefK0V
         Yui2U+Z52Dt66DdiLjqfzlCIJmUb+G5j5PRj8pYCG0kfKfL77gPnEipk/AAuvUHxurL3
         R4AhbCmNilz9Wt297OCC330TA4TlPvBNGI+sqQaTpmaAw3ZI2IdLT/mXB3G/EKSX7JPO
         nCMw==
X-Forwarded-Encrypted: i=1; AJvYcCVgjNhCUjWpZJ27/A6zjJZf/OpRNTSISxRVv2n8r+D3T8E8/gWt0kiZ76PFTkLxLs2sDjIWzUYNn+XujdO1@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEGLiAOvv7zRf7MqZTT4X1qBCv53FOmRCrwjVKEMOrM9h0eUk
	ANiNoVAl8hL+xghsa8yMDcHOLXRz3jgNMpHFMfy2yacjKiwhs+jAc0NhXOrBhAw9h+bKQNWr87V
	sOXFDq7p2t+cULIapRyobpmRzDcieH7U=
X-Gm-Gg: AZuq6aKXQ7nJs3B9tD6CyUreqdhDjUq0x4v/ggcrxI9N3+VjTJ/NY9wCafdj466nmWm
	tfba+VWHbexZWQegpXOcvmUDLhUHVlcBNEyskguka4Sp8DsB3A6HnpfO3xJ1944dyBW2c/7MvcM
	DJY3sbIP1soz0bhFpT21J5YnsqR4OTNxFwS7DlQYICZ34GbTIavb4kHVqyV9H7Us41pD3OK49lm
	YQSFDMAp7svjpjKj2Cv3uMZIqNz59K94KTMT/9PkWB2xsL7EWGKkAy1NGvQC/HkA7POQg==
X-Received: by 2002:a05:6512:2158:b0:59b:b2f3:7d49 with SMTP id
 2adb3069b0e04-59bb2f37edbmr3255204e87.1.1768935611240; Tue, 20 Jan 2026
 11:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
 <20260116235606.2205801-3-joannelkoong@gmail.com> <041320b0-c11a-4332-965b-b0698ac89092@ustc.edu>
In-Reply-To: <041320b0-c11a-4332-965b-b0698ac89092@ustc.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Jan 2026 10:59:55 -0800
X-Gm-Features: AZwV_QjjYNgG7KS2296EZKnQju7j0Th3NN0OoN6lECtIlPXyvZhc-MUYDx68Xlk
Message-ID: <CAJnrk1ZMB2eN8EOt0c8x4o_P=7ZAvDR3NkqfKVWEdyJ3y4Vb+Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fuse: use offset_in_folio() for large folio offset calculations
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com
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
	TAGGED_FROM(0.00)[bounces-74712-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,ustc.edu:email]
X-Rspamd-Queue-Id: 3A3174B0B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 8:41=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc.ed=
u> wrote:
>
> On 1/17/26 7:56 AM, Joanne Koong wrote:
> > Use offset_in_folio() instead of manually calculating the folio offset.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >   fs/fuse/dev.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 698289b5539e..4dda4e24cc90 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1812,7 +1812,7 @@ static int fuse_notify_store(struct fuse_conn *fc=
, unsigned int size,
> >               if (IS_ERR(folio))
> >                       goto out_iput;
> >
> > -             folio_offset =3D ((index - folio->index) << PAGE_SHIFT) +=
 offset;
> > +             folio_offset =3D offset_in_folio(folio, outarg.offset);
>
> offset is a loop variable, and later offset will be set to 0. Replacing
> it with outarg.offset here would change the behavior. The same applies
> to the cases below. Will there be any problem here?

Hi Chunsheng,

Good catch, the offset variable should get replaced entirely by
outarg.offset. I'll make this change in v2.

Thanks,
Joanne

>
> Thanks,
> Chunsheng Luo
>
> >               nr_bytes =3D min_t(unsigned, num, folio_size(folio) - fol=
io_offset);
> >               nr_pages =3D DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
> >
> > @@ -1916,7 +1916,7 @@ static int fuse_retrieve(struct fuse_mount *fm, s=
truct inode *inode,
> >               if (IS_ERR(folio))
> >                       break;
> >
> > -             folio_offset =3D ((index - folio->index) << PAGE_SHIFT) +=
 offset;
> > +             folio_offset =3D offset_in_folio(folio, outarg->offset);
> >               nr_bytes =3D min(folio_size(folio) - folio_offset, num);
> >               nr_pages =3D DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
> >
>

