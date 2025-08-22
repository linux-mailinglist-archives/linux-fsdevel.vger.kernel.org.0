Return-Path: <linux-fsdevel+bounces-58776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C3B31679
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CE57BDD60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A82FABE9;
	Fri, 22 Aug 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH6xZFGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51AA2C029E;
	Fri, 22 Aug 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862779; cv=none; b=s/fz6UJSU/mff0/MDR6pq2gCpwvry0KV8tM7Ob2EY8xa85dfmX0DMA3f57ACxf5fRA1kO1QPC1Y+k1sFRDoF/WYlZ+LvC5jiA8VHmwNwnEflvOD94hYUeDgNYn6oXYvVK2mFcTBBZcalyrk0nim16ZyGpiZcOzv2PgGNWJUIy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862779; c=relaxed/simple;
	bh=/oLiMLxegsdBwnRXpnuzlhqafHTSVnT+dEn2Elw3DuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4IMnXzRDhNJHR9MK/mgs+w19fZjDvTGiV5rnzxLmVwj7uJ1YYP2rxzqbzBhoiCnRmHGkDpnMg5JH7flYOnv0mbl4Ae2J0H8jI4S0W3n5qYTwO3Mgx5Xw8F+yxgc+Pm5cFbiQtMuAqbQrlr61QaCN1AkkQ+4bgFDh92g03zMJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH6xZFGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286BAC4CEED;
	Fri, 22 Aug 2025 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755862779;
	bh=/oLiMLxegsdBwnRXpnuzlhqafHTSVnT+dEn2Elw3DuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uH6xZFGEBPnPVW98ZEux+QwU81VzixJUduoqCTZ6NNt7CvYrU/YzHZoIa48L3FFL/
	 dQ7W5WcfgXwfhAzWMSXE+LLD2k7BZU9U2YA6XED3WtWiXZcYaK3l9HeyVEutP1095H
	 ghqO3NST861mFRUPGBPx6Gt86kVGLK8b8qgDgkLT9Y4Gr9yKwxWQDmGKIpY0j3+KCw
	 Z+0V7YcHDcpzLafpieSpbiutOuWmiqigqcq2BM8vnb95x4FQp07ydtWY461CgiYB4R
	 T0jhIPbJCM0YKnlXvk4hCF8+o0Fk9pw2iFahUWlSNiHFWdMIBPRWHfnI/oZhqWZl3e
	 7zc7TU9+r7bKA==
Date: Fri, 22 Aug 2025 13:39:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <20250822133935.4e68d2d2@foz.lan>
In-Reply-To: <20250821122750.66a2b101@gandalf.local.home>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
	<20250821122750.66a2b101@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 21 Aug 2025 12:27:50 -0400
Steven Rostedt <rostedt@goodmis.org> escreveu:

> On Thu, 21 Aug 2025 09:56:15 +0100
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> What exactly do you mean by "feature inclusion"?
> 
> Something that requires a new maintainer? As with the bcachefs, the issue
> was with how the new maintainer worked with the current workflow.
> 
> Maybe you mean "maintainer inclusion and ejection"?
> 
> > However, I'm sure others will have different ideas.  
> 
> The thing is, I believe there's a lot of features and maintainers that are
> added. Most go unnoticed as the feature is a niche (much like bcachefs was).

On a side note: I never used myself bcachefs, and I'm not aware of its
current status and how much it depends on the current maintainer.

Yet, IMO, I don't like the idea that, if a maintainer leaves the
project for whatever reason (including misbehavior), features would
be excluded - even if they're experimental.

So, I'd say that, except if we would be willing to face legal issues, 
or the feature is really bad, the best would be to give at least one
or two kernel cycles to see if someone else steps up - and if the
feature is experimental(*), perhaps move it to staging while nobody
steps up.


(*) where IMHO it should be sitting in the first place when it got
    merged, being an experimental feature.

> 
> Perhaps we should have a maintainer mentorship program. I try to work with
> others to help them become a new maintainer. I was doing that with Daniel
> Bristot, and I've done it for Masami Hiramatsu and I'm currently helping
> others to become maintainers for the trace and verification tooling.
> 
> I share my scripts and explain how to do a pull request. How to use
> linux-next and what to and more importantly, what not to send during during
> the -rc releases.
> 
> I'm sure others have helped developers become maintainers as well. Perhaps
> we should get together and come up with a formal way to become a maintainer?
> Because honestly, it's currently done by trial and error. I think that
> should change.

Agreed with training: this can help getting things right.

Thanks,
Mauro

