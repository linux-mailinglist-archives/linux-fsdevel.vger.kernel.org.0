Return-Path: <linux-fsdevel+bounces-817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE77D0DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 12:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75A02824E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008BE179B9;
	Fri, 20 Oct 2023 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMhub7YJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E91775C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:47:44 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A4170A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 03:45:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d9cb5e0fcso492603f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697798714; x=1698403514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RvEQ8mt8eYMykZs5TLAkFCakeg9wZKE+HYZHsSkpNlI=;
        b=TMhub7YJJ6Kumjgh3cuyIvXeJlO0LtaDBeRJ8HP9UJroMNC/RC+g4LnKQJgXtHVFdy
         YY+/iicyhq3BRmUZlfaeXt8uotCIlc3YLiThblvLvyMS00DFhgVr08cHJ4bBRYz6VKlq
         7VQYKFpYHQMzHAwV8DNP4GaeD7ZS76uLVToelA/lJ1nWx5iQBjB0UJmGKOXJNBCtJz3A
         aciGuWmvGdXm1hcLQ+PnotmcY+l5czMwfU/RycCcqbF5o6UkU5mlJgFk8K1nHjSvGRIE
         exxJeMtK1TvLXhhdC1dQ9QkTnHKvAvc4Lth8Cn69C5DP4MJgwtfyXzdaWhzt20+ae4EG
         D5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697798714; x=1698403514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvEQ8mt8eYMykZs5TLAkFCakeg9wZKE+HYZHsSkpNlI=;
        b=n0Tt6erEzWGcoTvj1PreGSMKKeKyEyur9oDTk8ol/A486mRATKQpfqxR3WfqTK24Mi
         dcAOMWXYIRJcRh4r4e0lsexGYLgslLNYl/IJC7ioKLFXPxvECFe7K+80aJcHoYKNtIZK
         d7Owjt9aKt5JKbMPyZ3zpMtJQvi30z9a5pwRey2977+ZtsAjuQBoG8ktn5trPLWlOvKD
         KpSt6AbdKFdFPPJnChn+NA67uaKuu0Ka3syXgd5AtndzvD0JCO8iCrZ2PmLcMKF6ENkx
         2if6rFoH91XDwDydQiDxuPSNOFok4fiAAcGfAVYOWIrtg7loqx3QrJsJUrwg6564goar
         RllQ==
X-Gm-Message-State: AOJu0Yzv5v3DyfYP/RzWRihhrDp9ZDL/4EY65/bvWD34Pkr2TXRoKPnX
	CuezMW6V7WPSfYv450RMOgwA8WglBTrCBhjL/io=
X-Google-Smtp-Source: AGHT+IEj6fj7TraRCzQIK7M+eAhjdrJaD5M6Xk8G59vkZU7mWDhQ4Woe+azc7YxNTxe46KLfNZ83IA==
X-Received: by 2002:a05:6000:1244:b0:32d:a409:84c8 with SMTP id j4-20020a056000124400b0032da40984c8mr1056752wrx.67.1697798714225;
        Fri, 20 Oct 2023 03:45:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d68d1000000b0032d687fd9d0sm1425968wrw.19.2023.10.20.03.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:45:13 -0700 (PDT)
Date: Fri, 20 Oct 2023 13:45:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org,
	autofs@vger.kernel.org, Ian Kent <raven@themaw.net>,
	Bill O'Donnell <bodonnel@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: autofs: add autofs_parse_fd()
Message-ID: <432f1c1c-2f77-4b1b-b3f8-28330fd6bac3@kadam.mountain>
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
 <CADYN=9+HDwqAz-eLV7uVuMa+_+foj+_keSG-TmD2imkwVJ_mpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9+HDwqAz-eLV7uVuMa+_+foj+_keSG-TmD2imkwVJ_mpQ@mail.gmail.com>

On Fri, Oct 20, 2023 at 11:55:57AM +0200, Anders Roxell wrote:
> On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
> > > The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
> > > it as compat mode boot testing. Recently it started to failed to get login
> > > prompt.
> > >
> > > We have not seen any kernel crash logs.
> > >
> > > Anders, bisection is pointing to first bad commit,
> > > 546694b8f658 autofs: add autofs_parse_fd()
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> >
> > I tried to find something in that commit that would be different
> > in compat mode, but don't see anything at all -- this appears
> > to be just a simple refactoring of the code, unlike the commits
> > that immediately follow it and that do change the mount
> > interface.
> >
> > Unfortunately this makes it impossible to just revert the commit
> > on top of linux-next. Can you double-check your bisection by
> > testing 546694b8f658 and the commit before it again?
> 
> I tried these two patches again:
> 546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
> bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots
> 

One difference that I notice between those two patches is that we no
long call autofs_prepare_pipe().  We just call autofs_check_pipe().

regards,
dan carpenter


