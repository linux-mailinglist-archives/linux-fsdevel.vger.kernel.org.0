Return-Path: <linux-fsdevel+bounces-31103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01917991C39
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 05:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7B1F21F3E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 03:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE40166F1B;
	Sun,  6 Oct 2024 03:06:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.carlthompson.net (charon.carlthompson.net [45.77.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81628EC;
	Sun,  6 Oct 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.7.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728183995; cv=none; b=bbPJlITUfbdaa6ry8rbj/f8OUGj+r1s1a/DMw9fCIoGYoZsh1l78qqKk2ZXZ5Ha089F45VxncsZvieqG0FQLg025/nXzRsY6FTn4oIoaYESA2jaDT2nnxWZJYB48CMTlxNfnpPCowaPjFF8pesNKO3FZvjRJ8WXlQkilxvNTdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728183995; c=relaxed/simple;
	bh=sU5PrTKMwVrIYv9TM+OplCdzFx5vQ/ct6h42t3ydNOQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YCGgQUuoOPTWSmKciSZEtKCVAiE5Aj3Q+kZ09FXuYRo3/QNgvz6sIFKk1OIFi1Kikq8k4GUBoOEwK4nraNZg8WwM3ItNLFjGvdnPhJUlzKt+/SgqcxtAOTOdtC9501M39v2dsRxIf9b54O+LCHWgPZYoaL5yHrJbb/OTMGAKx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net; spf=pass smtp.mailfrom=carlthompson.net; arc=none smtp.client-ip=45.77.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlthompson.net
Received: from mail.carlthompson.net (mail.home [10.35.20.252])
	(Authenticated sender: cet@carlthompson.net)
	by smtp.carlthompson.net (Postfix) with ESMTPSA id 92A3B60195EDA;
	Sat,  5 Oct 2024 20:06:31 -0700 (PDT)
Date: Sat, 5 Oct 2024 20:06:31 -0700 (PDT)
From: "Carl E. Thompson" <list-bcachefs@carlthompson.net>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <941798317.650.1728183991400@mail.carlthompson.net>
In-Reply-To: <coczqmiqvuy4h74j462mjyro3skeybyt2y3kcqdcuwy4bwibjy@pquinazt4h22>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <345264611.558.1728177653590@mail.carlthompson.net>
 <coczqmiqvuy4h74j462mjyro3skeybyt2y3kcqdcuwy4bwibjy@pquinazt4h22>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev53
X-Originating-Client: open-xchange-appsuite

Yeah, of course there were the disk accounting issues and before that was the kernel upgrade-downgrade bug going from 6.8 back to 6.7. Currently over on Reddit at least one user is mention read errors and / or performance regressions on the current RC version that I'd rather avoid.

There were a number of other issues that cropped up in some earlier versions but not others such as deadlocks when using compression (particularly zstd), weirdness when using compression with 4k blocks and suspend / resume failures when using bcachefs. 

None of those things were a big deal to me as I mostly only use bcachefs on root filesystems which are of course easy to recreate. But I do currently use bcachefs for all the filesystems on my main laptop so issues there can be more of a pain.

As an example of potential issues I'd like to avoid I often upgrade my laptop and swap the old SSD in and am currently considering pulling the trigger on a Ryzen AI laptop such as the ProArt P16. However, this new processor has some cutting edge features only fully supported in 6.12 so I'd prefer to use that kernel if I can. But... because according to Reddit there are apparently issues with bcachefs in the 6.12RC kernels that means I am hesitant to buy the laptop and use the RC kernel the carefree manor I normally would. Yeah, first world problems!

Speaking of Reddit, I don't know if you saw it but a user there quotes you as saying users who use release candidates should expect them to be "dangerous as crap." I could not find a post where you said that in the thread that user pointed to but if you **did** say something like that then I guess I have a different concept of what "release candidate" means.

So for me it would be a lot easier if bcachefs versions were decoupled from kernel versions. 

Thanks,
Carl

> On 2024-10-05 6:56 PM PDT Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
>  
> On Sat, Oct 05, 2024 at 06:20:53PM GMT, Carl E. Thompson wrote:
> > Here is a user's perspective from someone who's built a career from Linux (thanks to all of you)...
> > 
> > The big hardship with testing bcachefs before it was merged into the kernel was that it couldn't be built as an out-of-tree module and instead a whole other kernel tree needed to be built. That was a pain.
> > 
> > Now, the core kernel infrastructure changes that bcachefs relies on are in the kernel and bcachefs can very easily and quickly be built as an out-of-tree module in just a few seconds. I submit to all involved that maybe that's the best way to go **for now**. 
> > 
> > Switching to out of tree for now would make it much easier for Kent to have the fast-paced development model he desires for this stage in bcachefs' development. It would also make using and testing bcachefs much easier for power users like me because when an issue is detected we could get a fix or new feature much faster than having to wait for a distribution to ship the next kernel version and with less ancillary risk than building and using a less-tested kernel tree. Distributions themselves also are very familiar with packaging up out-of-tree modules and distribution tools like dkms make using them dead simple even for casual users.
> > 
> > The way things are now isn't great for me as a Linux power user. I
> > often want to use the latest or even RC kernels on my systems to get
> > some new hardware support or other feature and I'm used to being able
> > to do that without too many problems. But recently I've had to skip
> > cutting-edge kernel versions that I otherwise wanted to try because
> > there have been issues in bcachefs that I didn't want to have to face
> > or work around. Switching to an out of tree module for now would be
> > the best of all worlds for me because I could pick and choose which
> > combination of kernel / bcachefs to use for each system and situation.
> 
> Carl - thanks, I wasn't aware of this.
> 
> Can you give me details? 6.11 had the disk accounting rewrite, which was
> huge and (necessarily) had some fallout, if you're seeing regressions
> otherwise that are slipping through then - yes it's time to slow down
> and reevaluate.
> 
> Details would be extremely helpful, so we can improve our regression
> testing.

