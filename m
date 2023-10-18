Return-Path: <linux-fsdevel+bounces-697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F17CE760
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 21:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58B1B211ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81B43A83;
	Wed, 18 Oct 2023 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvaDpDcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1924335CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 19:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D88C433C9;
	Wed, 18 Oct 2023 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697656174;
	bh=xU19FSPNYfDa/R8eFlBcqPYEGK7ETuE98UdV2M14E7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvaDpDcOGt7IGMbj0aSnBpKh339EOtEdR7g1l9HQZIVqVf/8FfWbFdZ2I9wRd3gY9
	 UEvuY7jHqMSkffUpe5WtzjMy63on9ICAQN3tV6lFIvr8kHRS7x3CqgwIRl+c7CcDtC
	 JnVCpQOuSQ1iRJOh6pDE6W9nhm3D11YOIJLSLu3I=
Date: Wed, 18 Oct 2023 21:09:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jesse Hathaway <jesse@mbuki-mvuki.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <2023101852-mundane-reoccupy-013c@gregkh>
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
 <2023101819-satisfied-drool-49bb@gregkh>
 <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>

On Wed, Oct 18, 2023 at 01:49:44PM -0500, Jesse Hathaway wrote:
> On Wed, Oct 18, 2023 at 1:40 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > Unfortunately, this has not held up in LTSes without causing
> > > regressions, specifically in crun:
> > >
> > > Crun issue and patch
> > >  1. https://github.com/containers/crun/issues/1308
> > >  2. https://github.com/containers/crun/pull/1309
> >
> > So thre's a fix already for this, they agree that symlinks shouldn't
> > have modes, so what's the issue?
> 
> The problem is that it breaks crun in Debian stable. They have fixed the
> issue in crun, but that patch may not be backported to Debian's stable
> version. In other words the patch seems to break existing software in
> the wild.

It will be backported to Debian stable if the kernel in Debian stable
has this change in it, right?  That should be simple to get accepted.

thanks,

greg k-h

