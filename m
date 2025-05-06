Return-Path: <linux-fsdevel+bounces-48265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88EAACA64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 18:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73036188926C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2E283FF5;
	Tue,  6 May 2025 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJSsrXAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B32836A1
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547381; cv=none; b=Gy4lcOyPxA86hrW8U00AyjtzcmRJHd+ii5U1MCwqQX8sdEjMYNnYcQh/TfGlp85cxyRDCyWcxkPz+kIllNzJfz59PsehG0i+nUsh4ggHFSa/4WN83npL7HnQhAhM0TmZaycUVdjhRQhKz/mBVi7LR9WZ8KYWGMoSAfNtsunHk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547381; c=relaxed/simple;
	bh=GfX1nTFezZeREFCc7cbz+QTDMqbI2Ud4Musyc7cwTy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMmcTEsne7AmZqlKHLJNtVFgp0fFefVVvyEjC63arjXXqNl6R8dvxoPTSMfjBPao4NjkQIZT8tN13gRryjWhFEl1I1ZR0lTPIIrieUXejalgZL8vthUtgvsHNvqETq+wNI9LIcxOU/YUeqBifa7TeEpAjKYBeONCNraiGtJCMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJSsrXAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD74C4CEE4;
	Tue,  6 May 2025 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746547381;
	bh=GfX1nTFezZeREFCc7cbz+QTDMqbI2Ud4Musyc7cwTy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJSsrXAAp/M49taRaxcSt8fv3j/aIbEUjpjKsJoa/QwQ7ElukBpbGNIYUAtpuqhnw
	 ChjnC8kmi6IIZU8dHhvbsItJIVAR7yPf6AUn/guUlBPMxkmQ/LW12NRd9QpmYobV6p
	 bKMKLaFAuBkFPQAS36SpEW8tihea4mwjaPAHA3mO3c7mGTQruAd5v+YZywVnvmt23e
	 otrqVMbY7h2MHGVQBU7BvvT0x6OrCyhBp4urGcLZ3TfAT+gEFMgz3b1fiAUr5o8dF+
	 BKayjOe74sbc0jkzOvfcHiR6k8ugRth97fSao1nFAq3dZDDyjdHDfevrJMS7hqiZ/g
	 pc863tLVByCeg==
Date: Tue, 6 May 2025 16:02:59 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
Message-ID: <aBoys-gkIcu2AARF@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <b673458e-98b6-42ad-b95f-7a771cd56b03@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b673458e-98b6-42ad-b95f-7a771cd56b03@redhat.com>

On 05/05, Eric Sandeen wrote:
> Hi all - it would be nice to get some review or feedback on this;
> seems that these patches tend to go stale fairly quickly as f2fs
> evolves. :)

Thank you so much for the work! Let me queue this series into dev-test for
tests. If I find any issue, let me ping to the thread. So, you don't need
to worry about rebasing it. :)

Thanks,

> 
> Thanks,
> -Eric
> 
> On 4/23/25 12:08 PM, Eric Sandeen wrote:
> > V3:
> > - Rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
> >   dev branch
> > - Fix up some 0day robot warnings
> > 
> > This is a forward-port of Hongbo's original f2fs mount API conversion,
> > posted last August at 
> > https://lore.kernel.org/linux-f2fs-devel/20240814023912.3959299-1-lihongbo22@huawei.com/
> > 
> > I had been trying to approach this with a little less complexity,
> > but in the end I realized that Hongbo's approach (which follows
> > the ext4 approach) was a good one, and I was not making any progrss
> > myself. 😉
> > 
> > In addition to the forward-port, I have also fixed a couple bugs I found
> > during testing, and some improvements / style choices as well. Hongbo and
> > I have discussed most of this off-list already, so I'm presenting the
> > net result here.
> > 
> > This does pass my typical testing which does a large number of random
> > mounts/remounts with valid and invalid option sets, on f2fs filesystem
> > images with various features in the on-disk superblock. (I was not able
> > to test all of this completely, as some options or features require
> > hardware I dn't have.)
> > 
> > Thanks,
> > -Eric
> > 
> > (A recap of Hongbo's original cover letter is below, edited slightly for
> > this series:)
> > 
> > Since many filesystems have done the new mount API conversion,
> > we introduce the new mount API conversion in f2fs.
> > 
> > The series can be applied on top of the current mainline tree
> > and the work is based on the patches from Lukas Czerner (has
> > done this in ext4[1]). His patch give me a lot of ideas.
> > 
> > Here is a high level description of the patchset:
> > 
> > 1. Prepare the f2fs mount parameters required by the new mount
> > API and use it for parsing, while still using the old API to
> > get mount options string. Split the parameter parsing and
> > validation of the parse_options helper into two separate
> > helpers.
> > 
> >   f2fs: Add fs parameter specifications for mount options
> >   f2fs: move the option parser into handle_mount_opt
> > 
> > 2. Remove the use of sb/sbi structure of f2fs from all the
> > parsing code, because with the new mount API the parsing is
> > going to be done before we even get the super block. In this
> > part, we introduce f2fs_fs_context to hold the temporary
> > options when parsing. For the simple options check, it has
> > to be done during parsing by using f2fs_fs_context structure.
> > For the check which needs sb/sbi, we do this during super
> > block filling.
> > 
> >   f2fs: Allow sbi to be NULL in f2fs_printk
> >   f2fs: Add f2fs_fs_context to record the mount options
> >   f2fs: separate the options parsing and options checking
> > 
> > 3. Switch the f2fs to use the new mount API for mount and
> > remount.
> > 
> >   f2fs: introduce fs_context_operation structure
> >   f2fs: switch to the new mount api
> > 
> > [1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/
> > 
> > 

