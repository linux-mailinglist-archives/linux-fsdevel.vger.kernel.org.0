Return-Path: <linux-fsdevel+bounces-44221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC33A65EE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 21:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711CA179C85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4BE1EB5D6;
	Mon, 17 Mar 2025 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUn0gG1+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038F14A8B;
	Mon, 17 Mar 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242564; cv=none; b=ZX46VUjkor/D/aJX+KEgqpQR4dMMkPfE+nvPUInXINIwY1CtmJGErGLbzFYQaaqSCPlJRe+uecQKEfXKXDabQ+ETxkYvJGppAQP64IHjvYLcRM1fZmg5N/0ClWjAj6swXym67KWzHPiABXLEQvy5jSdHr/6PZxGY5aKaNpo1QWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242564; c=relaxed/simple;
	bh=36nuEkg/wj+vxl7Pqk2I+OAgs73XticS9qh3Exp7GiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh/Nr/tODz+vpHyLZYqedMj8Eanc4gPIFkoNY8wUGfLx8e0OGsnQ8EomLMn51nNOte/DJgNArLM3Q8AGkG3YJ9kROc2N7qCsouWKSWzR8TfSUnlvcYAPe4Au5JcE9TikPMmBdGFmqWq7S5LigeczZBcpiXGrIkcj3cj9xJLJ0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUn0gG1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85D7C4CEE3;
	Mon, 17 Mar 2025 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742242564;
	bh=36nuEkg/wj+vxl7Pqk2I+OAgs73XticS9qh3Exp7GiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUn0gG1+klSzkhmFSl1FdnWugyPCluelq2Ll2Z7hSwyyOam+ohbJS0tCEgNO6iSDV
	 NsuxZahOMmOPbxAQuNGdQTeKrGGuLqFSbCcFMxjRpNWyUL9Uct7AhL2jWB2/XFYJT3
	 zirZay3VBugsRSZhzWwMQ9sCWGuNwR0Rtgjgk2h3ketbFdyQLyA5mgTviOnGo7p3oE
	 4Tt6k5vxz50LqX9ENnZ7ovsWvh3CX1Orjufwl7kqqOixjKFHANrAebpGBXRIqjJ4Tz
	 e2X/kDN6gtedc3apK1Lbqwo3EhImYGcm5ffwf+AhowGeoTnq5inBHqRPjX3rL8SXhh
	 sBvaYeuFQBYTA==
Date: Mon, 17 Mar 2025 21:15:57 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Ruiwu Chen <rwchen404@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] drop_caches: Allow re-enabling message after disabling
Message-ID: <jdddmxrwys6kqvovuvwo7o7ie2qpnubmdbzcmcz5eywy5qw2xx@soveljw6isz2>
References: <20250317-jag-drop_caches_msg-v2-1-e22d9a6a3038@kernel.org>
 <Z9h9wKcAD2iiO7dS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9h9wKcAD2iiO7dS@casper.infradead.org>

On Mon, Mar 17, 2025 at 07:53:36PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 17, 2025 at 08:40:04PM +0100, Joel Granados wrote:
> > After writing "4" to /proc/sys/vm/drop_caches there was no way to
> > re-enable the drop_caches kernel message. By replacing the "or"
> > assignment for the stfu variable, it is now possible to toggle the
> > message on and off by setting the 4th bit in /proc/sys/vm/drop_caches.
> 
> I don't like the toggle.  Nobody wants to toggle, which means that you
> need to keep track of what it is in order to make it be "on" or "off".
> And you can't keep track of it, because it's system-wide.  Which means
> you might turn it off when you wanted it on, or vice versa.
Don't really have a strong opinion here. Posted V2 thinking that
toggling might be preferable. If it is not, then V1 is the way
to go as it just sets the value by looking at the 4th bit.

> 
> Did I miss the discussion which promopted this change?  It seems like
> terrible UI to me.

As I understand it, the motivation is to be able to turn the messages
back on. This is not possible as the 4th bit stays set (no message)
after setting it for the first time.

Best
> 
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> > Changes in v2:
> > - Check the 4 bit before we actualy toggle the message
> > - Link to v1: https://lore.kernel.org/r/20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org
> > ---
> > 
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst | 2 +-
> >  fs/drop_caches.c                        | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index f48eaa98d22d2b575f6e913f437b0d548daac3e6..75a032f8cbfb4e05f04610cca219d154bd852789 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -266,7 +266,7 @@ used::
> >  	cat (1234): drop_caches: 3
> >  
> >  These are informational only.  They do not mean that anything is wrong
> > -with your system.  To disable them, echo 4 (bit 2) into drop_caches.
> > +with your system.  To toggle them, echo 4 (bit 2) into drop_caches.
> >  
> >  enable_soft_offline
> >  ===================
> > diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> > index d45ef541d848a73cbd19205e0111c2cab3b73617..15730593ae39955ae7ae93aec17546fc96f89dce 100644
> > --- a/fs/drop_caches.c
> > +++ b/fs/drop_caches.c
> > @@ -68,12 +68,13 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
> >  			drop_slab();
> >  			count_vm_event(DROP_SLAB);
> >  		}
> > +		if (sysctl_drop_caches & 4)
> > +			stfu ^= 1;
> >  		if (!stfu) {
> >  			pr_info("%s (%d): drop_caches: %d\n",
> >  				current->comm, task_pid_nr(current),
> >  				sysctl_drop_caches);
> >  		}
> > -		stfu |= sysctl_drop_caches & 4;
> >  	}
> >  	return 0;
> >  }
> > 
> > ---
> > base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> > change-id: 20250313-jag-drop_caches_msg-c4fbfedb51f3
> > 
> > Best regards,
> > -- 
> > Joel Granados <joel.granados@kernel.org>
> > 
> > 
> > 

-- 

Joel Granados

