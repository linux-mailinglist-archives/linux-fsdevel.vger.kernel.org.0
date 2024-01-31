Return-Path: <linux-fsdevel+bounces-9667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E76844306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037F9285E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500F86AC5;
	Wed, 31 Jan 2024 15:28:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADC6A32B
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714890; cv=none; b=R6tJ0RWC8jEcMKEFOhi1pZyUZIEVHaecHD7qrYyb6XPnc73KMeGy9Gz7gv7Jl9a9fIoVBiZr7i4o55kcmG0NAaQmFgh9Nvlt3zEngYfxrVS7n6/l/ixpQOA1pfEPP0xlQDqdsfLWk57nYwMwgh6HebyXuhRjZIkAfyZN3SsIPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714890; c=relaxed/simple;
	bh=EsTmPxxbi2jxf0mZRK9ALLWdEvbp+A2acQWskh3H+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIWWtQqynpX38iLtsLIuYldCxz3/ppXja4eLi2f3kZc94t/3KwxxTM//fwnH/dPHtU0iL8K+v3ogDbWWUUAFrkwyUR3/pzKaonAIl+q+zDWqpoJCpzYR1J6ZRdCPKB5JZE0htXoqkWN2gLRcP2yCHDbg/Us4MOZmJPXh/WxVYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3F4C433C7;
	Wed, 31 Jan 2024 15:28:08 +0000 (UTC)
Date: Wed, 31 Jan 2024 10:28:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Amir Goldstein
 <amir73il@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH DRAFT 0/4] : Port tracefs to kernfs
Message-ID: <20240131102807.6a6c7b58@rorschach.local.home>
In-Reply-To: <20240131094117.7bccfe6c@gandalf.local.home>
References: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
	<20240131094117.7bccfe6c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 09:41:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > So I went and started a draft for porting all of tracefs to kernfs in
> > the hopes that someone picks this up and finishes the work. I've gotten
> > the core of it done and it's pretty easy to do logical copy-pasta to
> > port this to eventfs as well.  
> 
> tracefs yes, but I'm not so sure about eventfs.

BTW, I do want to thank you for doing this. I would *love* to have
tracefs switched over to kernfs. Unfortunately, I have no time to do
it. I also don't want to lose the memory savings that is done in
eventfs.

Even if kernfs couldn't do what is needed in eventfs, I'd still be
happy if just the tracefs portion was converted over to kernfs, as long
as it treated the eventfs the same as tracefs does today.

I never really wanted to be the tracefs/eventfs maintainer. I just
needed the interface for tracing. The more generic code it can use, the
better. This is why I'm ecstatic for the simplification changes that
Linus is making.

-- Steve

