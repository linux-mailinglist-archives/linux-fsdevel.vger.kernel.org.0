Return-Path: <linux-fsdevel+bounces-2527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 256DD7E6CB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AE41C20A39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A01E52F;
	Thu,  9 Nov 2023 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="tRxVX7Yc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EXVyeR8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0B1D6A8;
	Thu,  9 Nov 2023 14:58:27 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A678C325B;
	Thu,  9 Nov 2023 06:58:26 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 9FB163200B77;
	Thu,  9 Nov 2023 09:58:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 09 Nov 2023 09:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1699541903; x=1699628303; bh=jW
	dS6GkJOycSu70WYEYSDlUZAEtt7yUOuuE+eluEIcE=; b=tRxVX7Ycq9mg0RkTk5
	68Lnt1Ue7Ljxgl1DKoOBsOMC6Yq3BBuOYVqAG6idR7uwYlBscvlKFPgDc+N8tt/D
	Qa2f8D8juC+Pw8+NU7Wu4uNcRh697+bNLuKcmY0joqbzra/wDOwLWDVl/lXsWqak
	TbmD3DsIenmyUMJZe4nKo7bNFUKkuOGPWJmkZh10zhxQqUIKVslQONA7uSd8Hof6
	5XWFJA/4k6ETnqVP6tn8NydNQX6TWMTBs9ejDTD8iV80WsHUTmhwW2z8l8C8q6uq
	bCZIJ/mAZt7v6eVxAttekDeW3/4VTL3S/PWydNUq3RnJ1ZtIYFxaBuufdG5f8wVk
	4ibA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699541903; x=1699628303; bh=jWdS6GkJOycSu
	70WYEYSDlUZAEtt7yUOuuE+eluEIcE=; b=EXVyeR8hvIv06aYAHOjdORgUpspXJ
	ZwaTo7Xo0uJcHAjOidX8/U5AHdxK9VCa6+6ugr+0hUfA1KXG6Q52q3QPYs6JJVgX
	iPOjARSs9a/NZiNGuHm/4A/bl1mT6RcGaUoe8jQH7iBNtBGs1VmMvv/D+R0hOLn1
	NPc4r4qoC9xUzvm/g/CmMX/HzA9Gmbs4SLIrVOMlWd+ACR3VudinRttPmwYXL/WD
	eydMs4cvyR4txcC0AFIFBrIoFcP2QPqQHU+FCraJcCvturcjfGapds0IHL0cG2J1
	/ahbx/S5CSKRUJfWxmPg78SHMbFLLI541CIVKJtTKg0zUhnuFUfh1kLCA==
X-ME-Sender: <xms:jvNMZTmQCy-4t-N65EHKGEkcNS-6V0lSO5eH8D-sZSv0gieJrzlePA>
    <xme:jvNMZW26ARYnp2y5tG7btXygYraJQqb6dHHoHgkSXGKimfRjkHqNns2bEhHuUf5rv
    16Vy9a_ZEs_xl2_nSg>
X-ME-Received: <xmr:jvNMZZqmFkZKfK_-9sLNwCDH0CzCcafq2C070FA0Fuq4G2VmDXc1QKi68GG4_yvfFI_NeF6673Y_CiSoUMkGGZZp8OZ9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:jvNMZbm3Lpjr6SN57Mbdg6s3jjq8AmaUfmSS6QrG2TvihklUZe4-qA>
    <xmx:jvNMZR00xM0LhJdWXoDyxxLVWTyWYNyLxZCCQdOUVLpS294jmVXARw>
    <xmx:jvNMZava_pRODLPqdYr_5ZXJYBjkjd_TUXCxBUvW-eM-o1udOoYXYw>
    <xmx:j_NMZem5suVIzkjk9zhSJLCt36E0E-x9bqUOfz6dSbVUxtz3YxToxQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 09:58:21 -0500 (EST)
Date: Thu, 9 Nov 2023 07:58:19 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 4/6] misc cgroup: introduce an fd counter
Message-ID: <ZUzzi5rY92aQ3D/b@tycho.pizza>
References: <20231108002647.73784-1-tycho@tycho.pizza>
 <20231108002647.73784-5-tycho@tycho.pizza>
 <20231108-ernst-produktiv-f0f5d2ceeade@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-ernst-produktiv-f0f5d2ceeade@brauner>

On Thu, Nov 09, 2023 at 10:53:17AM +0100, Christian Brauner wrote:
> > @@ -411,9 +453,22 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
> >  
> >  	rcu_assign_pointer(newf->fdt, new_fdt);
> >  
> > -	return newf;
> > +	if (!charge_current_fds(newf, count_open_files(new_fdt)))
> > +		return newf;
> 
> 
> > @@ -542,6 +600,10 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
> >  	if (error)
> >  		goto repeat;
> >  
> > +	error = -EMFILE;
> > +	if (charge_current_fds(files, 1) < 0)
> > +		goto out;
> 
> Whoops, I had that message ready to fire but didn't send it.
> 
> This may have a noticeable performance impact as charge_current_fds()
> calls misc_cg_try_charge() which looks pretty expensive in this
> codepath.
> 
> We're constantly getting patches to tweak performance during file open
> and closing and adding a function that does require multiple atomics and
> spinlocks won't exactly improve this.

I don't see any spin locks in misc_cg_try_charge(), but it does walk
up the tree, resulting in multiple atomic writes.
If we didn't walk up the tree it would change the semantics, but
Netflix probably wouldn't delegate this, so at least for our purposes
having only one atomic would be sufficient. Is that more tenable?

> On top of that I really dislike that we're pulling cgroups into this
> code here at all.
> 
> Can you get a similar effect through a bpf program somehow that you
> don't even tie this to cgroups?

Possibly, I can look into it.

Tycho

