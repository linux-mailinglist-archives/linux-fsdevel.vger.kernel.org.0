Return-Path: <linux-fsdevel+bounces-1725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8F27DE05D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1C71C20D68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E12111A6;
	Wed,  1 Nov 2023 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XNLINxVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15587C8E2
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 11:32:49 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D933FD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 04:32:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9cf83c044b7so932850866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698838363; x=1699443163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+re5r6pgYsT+VpL/978qoxVyEmYWKtmPI7O/HCFWkY=;
        b=XNLINxVctfEgx/7WYsvnglDrd4RMbiRtYHjN81fUs7K5r01kxL515qg/+lIbcDSxsA
         RIDzNoOzPCol6Ov/jAjaH7fbRmnXOGQ3+iwP0u9U04i4IgBajx5TSwzY6h5tNBxhO+8p
         ZBKao5eqvMhyLSGPGvKOg8rmnt8oA7yUm0Flg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698838363; x=1699443163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+re5r6pgYsT+VpL/978qoxVyEmYWKtmPI7O/HCFWkY=;
        b=KcjKvgqOxBSBr4AwpSru2iLq7lfSKfKxh5aOyXHRzhqcJ5l80aO3RY+8VezkjK2/1e
         vB1ixUajjjj27hz4LGoMU8MdrZmWyYaURAYVqt/H88LAQUhrBNw6GS/b5YRlCpGZitnf
         wFNMOg2W8ENmi4FUukD2m3prZtzbwCGWdL58evGaD3PFUxYcAJWwIY+Dv/TaxUxDszMf
         nPjkKA5TIxQiY31RK8vVvgz5asX+5EEK0ABSprgkrvbX2GiYEvJHV2Ro+V4Z5yFWcvGN
         lp7h9hgKU4HjCca0GTAMZrtnWI/xiwXhXDII5UCyHPy4rio1r9Fop+Lk007WTDMzv2Ah
         FHvw==
X-Gm-Message-State: AOJu0YwMbakYb3gC8m5lFgRLXs+y86iGV4QTEaDU68MzYG8yHtgobvX1
	5/kSa0CO4oAGzP5GpIP1PtxpYj4QPdT4/3dFXXvz7Q==
X-Google-Smtp-Source: AGHT+IGN7lEZfOpz/jeB3GVirGnYWeDVh3Db2YIbTFMzNSXXH5np65E5qhSv6m6O9RDdFYqVNtCbWTwtlK6TswPJ9Yg=
X-Received: by 2002:a17:907:25c6:b0:9b2:82d2:a2db with SMTP id
 ae6-20020a17090725c600b009b282d2a2dbmr1481692ejc.28.1698838363449; Wed, 01
 Nov 2023 04:32:43 -0700 (PDT)
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
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com> <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
In-Reply-To: <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 1 Nov 2023 12:32:32 +0100
Message-ID: <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Oct 2023 at 18:44, Amir Goldstein <amir73il@gmail.com> wrote:

> In that case, we would be able to "attach" the fuse_backing object
> to fuse_inode on CREATE response. If we end up with a backing map
> conflict at this point, we can return -EBUSY error to the user and forget
> the inode, but the server would have no easy feedback on its mistake.
> Also, -EBUSY to user would be confusing if user did not request O_EXCL.

I think -EIO is more appropriate.  Server is broken, WARN_ON_ONCE
could also be used to indicate that.

> Do you consider the described "atomic_open conflict" case an API problem?
>
> It is true that with v14 patches that do not enforce backing inode conflicts,
> the attribute coherency model that I proposed may result in attribute
> cache thrashing if the backing inode of a fuse inode is ambiguous.
>
> Do you have an idea how to handle this case elegantly?

Let me add some perspective.

Currently we have FOPEN_DIRECT_IO that disables caching.  My feeling
when dealing with this interface is that it was a mistake to make this
a property of the open file.  It should insted be a property of the
inode and all open file instances should respect this property
equally.  It makes no sense to have one file do cached reads while the
other is doing direct writes, etc.  Also it should be possible to turn
this on or off for all open file instances at any time.

Passthrough is similar, I think.  At any point in time all I/O should either be

 - cached
 - direct
 - passthrough to a specific backing file

Allowing these to be mixed leads to confusing semantics, especially
cached and non-cached

OTOH allowing passthrough to be switched on at any point in time
presents challenges.   If passthrough is turned on for an inode that
didn't have it previously means that the backing file needs to be set
up before the actual I/O.    So it's definitely more complex than just
setting up the backing at open.  But I feel that longer term we'll end
up with a better interface.

For the first version we can just bypass this whole mess, and say that
passthrough can only be turned on for the first open.  I.e. if there
are already open instances and passthrough has not yet been set up,
then FOPEN_PASSTHROUGH will be ignored.  Similarly if it has already
been set up, then the lack of FOPEN_PASSTHROUGH is also ignored.

Hmm?

Thanks,
Miklos

