Return-Path: <linux-fsdevel+bounces-7707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3433829B8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 14:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B0228A45C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF17495D8;
	Wed, 10 Jan 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FvtbhynD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DD495CD
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28da6285c1so739809466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1704894195; x=1705498995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxoWcecCZExIIFdN0xtey41fgRaKWC8kWgC6rhb/9dY=;
        b=FvtbhynDeAZzJAeE4FygbcENptRvCzftVGzuSnYU/AjtGyK/P9cyVoIloJPB0H/Dqa
         PP+8LsVlwLDDm0zpHfYB+LYdsUSTa4dvyN3afb0VdXyLTGTvnHy9P1is2hIQBqNF1p1G
         /zX0/KkjbFxq3fdpq/GovpQAUIBmCxQY3nIyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704894195; x=1705498995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxoWcecCZExIIFdN0xtey41fgRaKWC8kWgC6rhb/9dY=;
        b=ILpf6tKM5mq+iS7h4qE52ZwePjli4nATnMPtKa9DX25RjzBeZ/0yPzc3cRWhHxT0A3
         w0U70FgTPmqEBXBD7C0YlADMp4ehJb5Sq1NGmmuuxjahjSmKat/NavdR6ecurKANDMKi
         9tVHBFJ8s+Ahd56sIkGAUxmC88SAToOr4pCgCjvCa8Uc6NneZAsRTvRA8ZlhTLz4x2MD
         WDkplYfgWiWcF+iRQ04xYF5/jazsKdkBACqQ8jLTGpX0zGxaRet3JoPG5hGlNKPVpC4h
         GjhpLesOrMXXfxStmcBfyO8x8KJj2kGjdh6KfYrgfwE+pf4kc0+NBlSMNLb+V/jWLD89
         c71A==
X-Gm-Message-State: AOJu0Yx71SfVPrU3iq6o5Z9AqioJfwANUsG2XGHFB+iI0QmBioDB6HEj
	LE5+e/QaH8H1D5R+Jlma8vRWQZ7Vf4U5j8QXiKPfKESK8JXVcw==
X-Google-Smtp-Source: AGHT+IE7qXen0WzP3eRsTcPJeemmFisOpVGUmxTT0jNIjPU7JJsIbdU7hVIVpCEM3HkGIuIOnfGDYc1af8uv1zg7w4Q=
X-Received: by 2002:a17:906:fa85:b0:a2c:dfa:4f6 with SMTP id
 lt5-20020a170906fa8500b00a2c0dfa04f6mr92733ejb.16.1704894195507; Wed, 10 Jan
 2024 05:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz> <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jan 2024 14:43:04 +0100
Message-ID: <CAJfpegugS1y4Lwznju+qD2K-kBEctxU5ABCnaE2eOGhtFFZUYg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] fuse: file: limit splice_read to virtiofs
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 at 04:09, Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Potentially-blocking splice_reads are allowed for normal filesystems
> like NFS because they're blessed by root.
>
> FUSE is commonly used suid-root, and allows anyone to trivially create
> a file that, when spliced from, will just sleep forever with the pipe
> lock held.
>
> The only way IPC to the fusing process could be avoided is if
> !(ff->open_flags & FOPEN_DIRECT_IO) and the range was already cached
> and we weren't past the end. Just refuse it.

How is this not going to cause regressions out there?

We need to find an alternative to refusing splice, since this is not
going to fly, IMO.

Thanks,
Miklos

