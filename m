Return-Path: <linux-fsdevel+bounces-63417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF0FBB8560
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 00:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EF54C284F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 22:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F92A2727FA;
	Fri,  3 Oct 2025 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rvCH3sk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D434BA2B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531355; cv=none; b=o1F46XvOw9lJ7bh1ReAxEV1zu6yxzPqvawruRkwpVXUoz/SbhIt1ARiUf53PD9hZCdvVqjsuJtPAERzFa1wYDqKRdPF7N3pSWAdaimu0Mokwg0QAX9CZPSkbbDFzWTz79I0nutL6KKI/1Yy/aILsOGf9ieT05Y19jUH00YMWYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531355; c=relaxed/simple;
	bh=761814KxcNLHCBenjV/PZD/IpHbYQP/NlZjfH8s1x9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRPCfq+TBU4vfihoLzybkBg2zBeLcUXWw9K5+ofc/i5ttW6P5aO7192R0WiDBmwAIdwO/znrjEIXlBU76xgVRgqlDw3Zj4wvAyLmsX4iEiXiE6FFA2rVjVx8qlwsp0HXrOXnusk21tbhl6EWqhbFtpsAbwlxxofVqt9M/prO1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rvCH3sk8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zf7ktasW6wJLFomyV/9B4nNBbh0TaTsAhxEsM/UV0Fc=; b=rvCH3sk8bf36+H1gGY+mzA+9rd
	SMRtzC2tS0JYIydmmAqdJSk5Jaa9hwOl1U3csKcRagHPOdg7FtSmST2dRt/5iLRPzR/GsXIEvzI2Q
	295wthGmmFhi3mPRivs6dUo8vgWi45dvTiAeLUQH+SKYaAQgF0SPPDuMGQKG1cHjSDY2dD2LvCBYY
	eO2XnK45zUYOMHf+Bg15fMJj1N9ALkB/+5qxUvNBdJQjiR8wUhW9aKt8m7TeuoQ/kHqwOY1hxbQaw
	fVhoEFV/9czYsAliA4Krg6pQfCEu9+elFBcynO0i27KRThzAiSlgSqnTQVmhTwv6flqRyKwEwIicW
	Vxw+QT/w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4oTw-0000000BgRz-1cla;
	Fri, 03 Oct 2025 22:42:32 +0000
Date: Fri, 3 Oct 2025 23:42:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [git pull] pile 6: f_path stuff
Message-ID: <20251003224232.GB2441659@ZenIV>
References: <20251003221558.GA2441659@ZenIV>
 <CAHk-=wjXC6mo5rFHbqsvJeTjjmw=PeoT9EfSE6KmL21Giej7MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXC6mo5rFHbqsvJeTjjmw=PeoT9EfSE6KmL21Giej7MA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 03, 2025 at 03:31:23PM -0700, Linus Torvalds wrote:
> On Fri, 3 Oct 2025 at 15:16, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git pull-f_path
> 
> I see the branch 'work.f_path', but no such tag. Forgot to push out?

D'oh...  Sorry, pushed now.  I wonder why this
git request-pull origin vfs pull-f_path >/tmp/y
(straight from history) has not generated the usual warnings...

