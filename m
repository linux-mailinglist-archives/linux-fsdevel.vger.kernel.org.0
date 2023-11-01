Return-Path: <linux-fsdevel+bounces-1742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758147DE2A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 16:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373CC281613
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 15:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A713FE7;
	Wed,  1 Nov 2023 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAO9HoXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C833D9
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 15:07:02 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F441AD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 08:06:46 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so8571656d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698851205; x=1699456005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEifcg8wCzXmpasyJ5eRP+C9xePWQ1eqagUVsdT/rbA=;
        b=jAO9HoXeI9gpLaECPUWDdvuM3HaH7AQNg2NqN7AWEUDI311aC2IsCEYxXF3z9YSV13
         d+cgtiJ6gPmqUjsD/yWTeHTadjboFhx9JejWkNBWI98jahwi7Iq9LnvMt9el02s4VhWh
         OGbL9NryagiaBZ2XBqkuerKPf6opSsm9S3Uvs7ZBJc/mrxk+WYH7UZZ+deMeDVvymIU+
         wDD0MjI0XplJa5qCq67oxCCKKsONE0+2l92gefJG2BypqYtLAyXohRdgELSx9z1fICRo
         FYRG1Cum0+m/XMX29x0t4ZFiSmCBz+WoKfdTW2ws3d4hx55DaTe0K/BUo8A25o0J0euw
         oW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851205; x=1699456005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEifcg8wCzXmpasyJ5eRP+C9xePWQ1eqagUVsdT/rbA=;
        b=HjobTVVIP7i2PrigL1gpCtHigcBnk+R/PhLdRknqWdzpD0sTdiidZ9MukFa4NIEkA0
         fZTFI5rqZ5g0XNiKQ1Y6etNeYIUnkUl4F9f1a1NIzUvBLPaci/4pjj2MccD+8ujOyAum
         +U3tpWFaqKb35IdaPufDaGCWemb9vpFvXQelNOvx93UIFTT9b0DjNFc7vazTPs24vZtK
         8+hoVkixGDMQLRaVjpuCnFu8FL7eH52eUi6ok2QOZ9P2d+M2DSAuTVgNbqIOe/jnb4qS
         1iIoa6PzDHCvihWQKxTj+lPdqHrQJK2D9D6uzK2Hi/nMjbeU5bX8NLU6DKlRtq1ofmqS
         cyyA==
X-Gm-Message-State: AOJu0YzJWxCr+BLe8rT0qckFAXe38Nv2pbSFRZUW2cViFbjHwvy3GS/I
	Kf/cucJvk+h74N+Pn0410pQRMkRR9/dLTg9Vqgs=
X-Google-Smtp-Source: AGHT+IEH3XISERjDY/bEGbnOe2mDPNiEXQORysNxQicAGTfvzREbf8A9Kul2xGf+MsRPXcWFHg6F2+FfPw6QNQ6mp/s=
X-Received: by 2002:a05:6214:48f:b0:66d:9b75:750b with SMTP id
 pt15-20020a056214048f00b0066d9b75750bmr9172392qvb.8.1698851205075; Wed, 01
 Nov 2023 08:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com> <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
In-Reply-To: <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 1 Nov 2023 17:06:32 +0200
Message-ID: <CAOQ4uxja2G2M22bWSi_kDE2vdxs+sJ0ua9JgD-e7LEGsTcNGXw@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 4:42=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 1 Nov 2023 at 14:23, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > However, I can imagine users wanting to do passthrough for read-only
> > fd without doing passthrough for read-write fd, for example, if data is
> > never manipulated by the server, but it is inspected on write.
>
> Okay, that could make sense in a read-mostly use case.  But I think
> that special case could be enabled with FOPEN_DIRECT_IO since we have
> that anyway.  I.e. FOPEN_DIRECT_IO would override the per-inode state,
> which is what it does now.
>
> What doesn't make sense is to mix cached I/O with non-cached (direct
> or passthrough) I/O.
>

That can work.

> > I have one problem with my in-house server and passthough of readdir.
> > readdir passthrough cannot do readdirplus to populate inode cache.
> > For readdir of a large, read-mostly directory, cached readdir is prefer=
red
> > because of readdirplus.
> > For a large, write-often directory, when only readdir is needed, readdi=
r
> > passthough is preferred.
> > No one size fits all here.
>
> But in this case the cache part of readdirplus is not useful, only the
> prepopulation part.  So why cache in that case?
>

In my use case, most users use cached readdirplus, so cache is important.
There is one user (samba case insensitive create) that opts-out of
readdirplus.

This user gets passthrough readdir without populating cache nor
prepopulate inodes, which is important because in that use case
(file create) readdir cache always gets invalidated.

This user does not contribute to cache populate of other readdirplus
users and does not use cache populated by other readdirplus users.

> Now using readdirplus for prepopulation might be the right interface,
> but it also might make sense to use it _only_ for that and use
> passthrough for the actual readdir.
>

That would make sense if readdirplus request is sent to server
in parallel to executing readdir passthrough and readdirplus
response does the prepopulation asynchronously.

> > I don't mind dropping the last readdir passthrough patch for the first
> > version, if you want to take more time to think this over.
> > I'd just like to know that there is a path forward to make conditional
> > passthrough per fd possible in future versions.
>
> I think first version should just do regular file passthrough.
>

OK.

> > BTW, the FUSE BPF patches that map a backing inode to
> > fuse inode allow fallback to server depending on BPF program result.
>
> Yep, that also makes sense.  What we need to make sure is that cache
> and non-cache access are not mixed, because that way lies madness.
>

Are you also referring to mixing cached and uncached readdir?
because that seems fine to me.

I will try to add these rules to FOPEN_PASSTHROUGH:
- ignore request on backing inode conflict
- ignore request if inode is already open in caching mode
- make FOPEN_PASSTHROUGH implicit if inode is already open
  in passthrough *unless* file is open with FOPEN_DIRECT_IO

Thanks,
Amir.

