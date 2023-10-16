Return-Path: <linux-fsdevel+bounces-410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419E77CA946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 15:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B571C2093E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452A27EEC;
	Mon, 16 Oct 2023 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FNJW3Nv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C922773B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 13:21:17 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB50AB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 06:21:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1c66876aso724469866b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1697462474; x=1698067274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LWgqgRAYUetn5WIU4egeVRJhroPIe6WJMB+gUmRfD2E=;
        b=FNJW3Nv+iABkMFGw8A/eupOjp/K0cEHUH0os4Hez+gS7JuOnwOW6ZnBO7O2RDeo7zt
         dBtRaGvh5bBpnQ+gYkV02POqsS89BKh9idLECdfu6TYolXDB405Z3VtmNQCs3vnU6+Ci
         +Ebwlmpg+2/HVq1K7uB7ASjw/fY68iNvUxgPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462474; x=1698067274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWgqgRAYUetn5WIU4egeVRJhroPIe6WJMB+gUmRfD2E=;
        b=ZrwOu56YhZw+YLmRFEYz9I3YKGjFDUi5f/XhLaZHfw1FXDgK38lkbQYnprQMKPzksx
         b+evZDsaicpxmT1AvnAcQrPQ0kywVnhEvGOEYHetonJgjjes4dolhv4LcfBuR0Jshaby
         KgX9seiS2xlQxBeiPWCI3JWsUAs3cwgzd/r2TixL7CrGXzyyMz3Q/ScAVxUZzhegNBnF
         n9XSgNhCx/MlET/RGzjvBURCIvRxpo3Neok3P5J+h3KTX7HwTgUglzishGjBj+dGXZiu
         OAU3v323dSf5YoT61C+Tbvyi/5IPA/m7fOaKtJG+WzLDTODjoFS+xKYWLWQ5Tz5KbNBu
         kXug==
X-Gm-Message-State: AOJu0YxXpjQXx6+DUZu6NVW1gUgju2xdtzRq3YwwVZ2zPXPqQ95nKTFo
	AEcqfU4DEYfrKZaa3jrfz8NuTP0l0ruVYmVeL0XJNA==
X-Google-Smtp-Source: AGHT+IFptriAmdlSE8mvIaglVaNhrm4fxPvdgCCjWPSlWIougsaTLjOH7SP9BfBUmsaJabI/al3+90jmkPmSOmCFWAU=
X-Received: by 2002:a17:907:94d6:b0:9c5:7a7:3752 with SMTP id
 dn22-20020a17090794d600b009c507a73752mr1255019ejc.26.1697462473878; Mon, 16
 Oct 2023 06:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
 <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
 <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
 <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com>
 <CAOQ4uxjQx3nBPuWiS0upV_q9Qe7xW=iJDG8Wyjq+rZfvWC3NWw@mail.gmail.com>
 <CAJfpegtLAxY+vf18Yht+NPztv+wO9S28wyJp9MB_=yuAOSbCDA@mail.gmail.com> <CAOQ4uxg+8H5+iXDygA_8G+yZPpxkKOADVhNOPPfuuwo4wYmojQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+8H5+iXDygA_8G+yZPpxkKOADVhNOPPfuuwo4wYmojQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 Oct 2023 15:21:02 +0200
Message-ID: <CAJfpeguVU15L3igM8MAQT+t8VCTfCncECZU-Haaaw_7F++X07A@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 16 Oct 2023 at 12:30, Amir Goldstein <amir73il@gmail.com> wrote:

> OK, this was pushed to the POC branches [2][3].
>
> NOTE that in this version, backing ids are completely server managed.
> The passthrough_hp example keeps backing_id in the server's Inode
> object and closes the backing file when server's inode.nopen drops to 0.
> Even if OPEN/CREATE reply with backing_id failed to create/open the
> fuse inode, RELEASE should still be called with the server provided nodeid,
> so server should be able to close the backing file after a failed open/create.
>
> I am ready to post v14 patches, but since they depend on vfs and overlayfs
> changes queued for 6.7, and since fuse passthrough is not a likely candidate
> for 6.7, I thought I will wait with posting, because you must be busy preparing
> for 6.7(?).

Dont' worry about that.

> The remaining question about lsof-visibility of the backing files got me
> thinking and I wanted to consult with io_uring developers regarding using
> io_uring fixed files table for FUSE backing files [*].
>
> [*] The term "FUSE backing files" is now VERY confusing since we
>      have two types of "FUSE backing files", so we desperately need
>      better names to describe those two types:
> 1. struct file, which is referred via backing_id in per FUSE sb map
> 2. struct backing_file, which is referred via fuse file ->private
>     (just like overlayfs backing files)
>
> The concern is about the lsof-visibility of the first type, which the server
> can open as many as it wants without having any connection to number
> of fuse inodes and file objects in the kernel and server can close those
> fds in its process file table, making those open files invisible to users.
>
> This looks and sounds a lot like io_uring fixed files, especially considering
> that the server could even pick the backing_id itself. So why do we need
> to reinvent this wheel?
>
> Does io_uring expose the fixed files table via lsof or otherwise?

I don't think so.

>
> Bernd,
>
> IIUC, your work on FUSE io_uring queue is only for kernel -> user
> requests. Is that correct?
> Is there also a plan to have a user -> kernel uring as well?
>
> I wouldn't mind if FUSE passthrough depended on FUSE io_uring
> queue, because essentially, I think that both features address problems
> from the same domain of FUSE performance issues. Do you agree?

It's a good plan if it all fits together.  I'm not all that familiar
with io_uring to say for sure.

Thanks,
Miklos

