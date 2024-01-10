Return-Path: <linux-fsdevel+bounces-7704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E460829ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 13:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E65128782F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC454878C;
	Wed, 10 Jan 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr9M+lOm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AB48CD2
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67fe0210665so22744366d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 04:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704891351; x=1705496151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x59FLoPFKwis7T0DeMcmoqy57tbzntCIgEpCDkcCH1Q=;
        b=Rr9M+lOmvRuHjPnW/ql6Dp+RfvJon3IFAvk9tm8ocHwmkGX8+Q9/bM7UphyN6DrxSQ
         N5IqMtt8Fe9obCuSbttFMa372tsbBs2p+LUDJjREzfUTVNdvTmAT4seMQJtYhXe0jyp8
         SqwB1Ga1yDS2mxyf41kj6UpJq+VBFnseCR7PpZosQb7bGUPtvHDeW0SleVbiZ8H9EAzP
         uQPXoazbSVe8g64VWkPaEMMxpPCdRSBLRVOOOZHERHlhcoj2NJpORYzDDVQk8oz2BUVi
         vqmKWvS3zzEZ56q8jm6N3J+YoWcbGsbUACz5dpwXPuBxthzpsYsutk+RGL26TZtMqQeI
         V+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891351; x=1705496151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x59FLoPFKwis7T0DeMcmoqy57tbzntCIgEpCDkcCH1Q=;
        b=NZ55Uh2H0yympwEhMi8lwklVcVNPaMA8GuatvMEsESnMnqk49HQjkIjCKDd2HkH/Up
         bYQNCf8oly99entatQ/Q3b11u7oa41fepZuj73ioCWlVewgM9827BK6dANxVW62OQWuR
         3Vr5NPitKi9GBbgPLwVz0ILApay7egJZ0Lm80ga6vbFKRXqqK3iWBOEziooRmj1kQFzg
         ymBHJ8op5/+XyzpfHtjf7zsrhmRXBI+f+TRMyikKtJvIWh5We8gR1G/xSzTqyPGncC36
         MSHftiQz058lCPAVxvuAd7ACCCfKqcoFGpsP/GeylN4puRbTivqFJcd+gWg4B2TkTbNs
         DLYA==
X-Gm-Message-State: AOJu0YycH1PbPF6QVJytBQACeCtLtt1KOHycznoEEJG4Zk206VKr8nJ+
	oMASRvqe0ApcUhh/H4CJmEHQ3+73cM9cQbWjDRkCl5ZaT7o=
X-Google-Smtp-Source: AGHT+IG5OSZwjZ0QRK6z5VVggw5hgGyN8OVwo/grAcLTDSpXBMDQyBLhtZHWcRImKeoW7f8StwlCWgG30XFTXFQhF9E=
X-Received: by 2002:ad4:5ae8:0:b0:680:b957:b275 with SMTP id
 c8-20020ad45ae8000000b00680b957b275mr952798qvh.122.1704891351358; Wed, 10 Jan
 2024 04:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109194818.91465-1-amir73il@gmail.com> <91797c50-d7fc-4f58-b52a-e95823b3df52@kernel.dk>
 <2cf86f5f-58a1-4f5c-8016-b92cb24d88f1@kernel.dk> <CAOQ4uxjtKJ_uiP3hEdTbCh5NNExD5S3+m0oEgB2VjhnD2BrvPw@mail.gmail.com>
 <ZZ6RnO0b4AIFOY7p@casper.infradead.org>
In-Reply-To: <ZZ6RnO0b4AIFOY7p@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Jan 2024 14:55:40 +0200
Message-ID: <CAOQ4uxgU+6qjqZJVc=a3P-gntd+Uuisf+1kyhnwfm7kXp+JtFQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event watchers
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:46=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 10, 2024 at 11:08:17AM +0200, Amir Goldstein wrote:
> > My thoughts are that the optimization is clearly a win, but do we
> > really want to waste a full long in super_block for counting access
> > event watchers that may never exist?
>
> Would it make more sense for it to be global,

Ironically, we once tried to disabled fsnotify hooks on pipefs and
found out (the hard way) that some people are using IN_ACCESS
event to get notified on pipe reads or something like that, so the
global option may result in less predictable performance.

> and perhaps even use the
> static key infrastructure to enable/disable fsnotify?

We are talking about disabling specific fsnotify hooks fsnotify_access()
and fsnotify_perm().

I doubt that static key infrastructure is required, because with this patch=
,
Jens did not observe any regression compared to the code being compiled out=
.

Thanks,
Amir.

