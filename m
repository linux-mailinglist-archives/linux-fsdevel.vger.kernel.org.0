Return-Path: <linux-fsdevel+bounces-813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA57D0C63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D9D1C20F7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9B14F97;
	Fri, 20 Oct 2023 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdr6ofa4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7413AF6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 09:56:11 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0F7D57
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 02:56:08 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d093265dfso3972346d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697795768; x=1698400568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWFQiaCfCSJlroVxi8tTCVlq3J3aPdkjM7+lH81+pdU=;
        b=hdr6ofa4rDEClAeeio/YF2FtOGW83vm6O6Zp4lZxNkwCKIo8QbQ3HL7X+zzP7YJjUw
         Zv/hqbja0HhMXTy+hh/EaCnAkeXTzKRkAxH+OreDTjKj/2jm+gQVap7WST9K3j+hv209
         3/bmCCl/tyL4FexdURUTDqOkNwA2uVPwqAJPBOHltaurOQs8oWyTB7EMDzjBBMgmNLN7
         IX6q3INJQ3KkVSwvyNckCvEW+1IeN+y1K3UpLUZREjIq6lkzTzbpdrxN01z2vTB2W9Cq
         99bEsD8aPTLnu/4gGq/5tUn3PGeO6Be0tRS79PiyDd3fg2lxoVMU75DqKaZ3DQNsuD05
         gMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697795768; x=1698400568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWFQiaCfCSJlroVxi8tTCVlq3J3aPdkjM7+lH81+pdU=;
        b=h65FYl66upsQs1HdKDC8Q8ZCoCsFZvWVfA5ujUg9ipreQ1o+o+BVX1vcdkuttJ31F5
         OW6/zITRPQ3BZIBmTXLiQsMMKZeL2aUKy+1TsYcc+W7xbqdN7BgKeul1RKnlWvQrlLpM
         74myoibQ2EB4Wp3kVLEGrZ1w8BZaTWBe0u9K1l9orgzSiBQSBigHRa2RpeXbm2cEoWS+
         jpkbYjIaA3G63QYFH1G6cweWs7P3Zr/a7pQj54TESAP8CPYCBuFyqX3EYcwpP5PQ3Dzh
         sWXClf/gWlOnAuC63O8AFqn7TFE0IN6iEAyBv13Z2526zJpr646TPg6qiVZki2Tb9t55
         nxow==
X-Gm-Message-State: AOJu0YwKbivuaQpN/+LQZl0CI4ud3X0Zxf4c8qNkDjcu3gnFo1d+MO5F
	cS5j0OYbqw7Xli5vbatAt4oEBog2h/K3o7rKnYLoIg==
X-Google-Smtp-Source: AGHT+IFfVuM4b2oWPlZVsGqOyBhZnphXp7n3tWSgnmT9tnohCaVzutuV804E/00C52kTI3LGQDoFXOQpUrXncjpQn04=
X-Received: by 2002:a05:6214:508f:b0:66d:55b7:e3d with SMTP id
 kk15-20020a056214508f00b0066d55b70e3dmr1612177qvb.28.1697795768031; Fri, 20
 Oct 2023 02:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
In-Reply-To: <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 20 Oct 2023 11:55:57 +0200
Message-ID: <CADYN=9+HDwqAz-eLV7uVuMa+_+foj+_keSG-TmD2imkwVJ_mpQ@mail.gmail.com>
Subject: Re: autofs: add autofs_parse_fd()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	autofs@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	"Bill O'Donnell" <bodonnel@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
> > The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
> > it as compat mode boot testing. Recently it started to failed to get login
> > prompt.
> >
> > We have not seen any kernel crash logs.
> >
> > Anders, bisection is pointing to first bad commit,
> > 546694b8f658 autofs: add autofs_parse_fd()
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
>
> I tried to find something in that commit that would be different
> in compat mode, but don't see anything at all -- this appears
> to be just a simple refactoring of the code, unlike the commits
> that immediately follow it and that do change the mount
> interface.
>
> Unfortunately this makes it impossible to just revert the commit
> on top of linux-next. Can you double-check your bisection by
> testing 546694b8f658 and the commit before it again?

I tried these two patches again:
546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots

>
> What are the exact mount options you pass to autofs in your fstab?

cat /etc/fstab
# UNCONFIGURED FSTAB FOR BASE SYSTEM

Cheers,
Anders

