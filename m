Return-Path: <linux-fsdevel+bounces-16128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C38898D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 19:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081D51F2996A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754812E1E8;
	Thu,  4 Apr 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2M3VFtJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9812B95;
	Thu,  4 Apr 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252595; cv=none; b=RkKXmZoWBesY2eK3vf3fka73jYIUjA8MqaCHFbBIafK4dtvw+8SjW25WZHAR/O4x3fwsqUOvMORG+S2o02pSwX9fepjw5R7WCMtzeGvQ1dlozBxGa2Pnn1p8Yisxqu4jxV07RXAYeN1lHMcia1Y80/3hFr5ePMsh6Sp1VeI6grU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252595; c=relaxed/simple;
	bh=XVqjP0+idGhkMlRNHlBMQ51jpiOeoZ7Hg495Orxy1ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4Azi1aqdp0W3bkA/43p2KcDTq2fXAwZ3wnqDw4NmfWlK+QLknIJEjGV9RviDfVfM8EW9gqa9cZeB9lwJUHd9wuYlyQrVw4NW+GUdjGr0QGd76ggwOqooopwKhfQumGZslmhUVDpCq9OZ8pxFo3qYOO4NUoL/57F9K9NcR7XCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2M3VFtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955F4C433F1;
	Thu,  4 Apr 2024 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712252594;
	bh=XVqjP0+idGhkMlRNHlBMQ51jpiOeoZ7Hg495Orxy1ig=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=N2M3VFtJ/uVjhjss0pSDO+miIyL0kv0tnP3bK3Ejy1PENtrqVQjt8kVeN5qwmX91C
	 VhNHoLDEfNTRbwj6p7ve1uJRZtpS5zxsGY2fag1ngIK11ruWoa97v38jNWGQoCsoPG
	 oIGdDyUDkHvZx/xc/x0TacdbNwZu2RTUulQtWGj5suyyja5/N/vjoiIWrKilycqRtn
	 lkLD9sZpVeKCoQw9eLyggh3gnMTqgersYDnXavDtJm2HzmcDCZt/7yhkr0iwPf3LOj
	 8nZgCmRYzScG29KZlWBGi187i7dR18vt6U1ctORI9y4tw7QOpCE9ZeKk0NDjJ0NHAx
	 4iUvQFZt8wHJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 337B5CE0D0C; Thu,  4 Apr 2024 10:43:14 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:43:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH fs/proc/bootconfig] remove redundant comments from
 /proc/bootconfig
Message-ID: <26d56fa5-2c95-46da-8268-35642f857d6d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
 <20240404085522.63bf8cce6f961c07c8ce3f17@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404085522.63bf8cce6f961c07c8ce3f17@kernel.org>

On Thu, Apr 04, 2024 at 08:55:22AM +0900, Masami Hiramatsu wrote:
> On Wed, 3 Apr 2024 12:16:28 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
> > /proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.
> > 
> > /proc/bootconfig shows boot_command_line[] multiple times following
> > every xbc key value pair, that's duplicated and not necessary.
> > Remove redundant ones.
> > 
> > Output before and after the fix is like:
> > key1 = value1
> > *bootloader argument comments*
> > key2 = value2
> > *bootloader argument comments*
> > key3 = value3
> > *bootloader argument comments*
> > ...
> > 
> > key1 = value1
> > key2 = value2
> > key3 = value3
> > *bootloader argument comments*
> > ...
> > 
> > Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: <linux-trace-kernel@vger.kernel.org>
> > Cc: <linux-fsdevel@vger.kernel.org>
> 
> OOps, good catch! Let me pick it.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you, and I have applied your ack and pulled this into its own
bootconfig.2024.04.04a.

My guess is that you will push this via your own tree, and so I will
drop my copy as soon as yours hits -next.

							Thanx, Paul

> Thank you!
> 
> > 
> > diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> > index 902b326e1e560..e5635a6b127b0 100644
> > --- a/fs/proc/bootconfig.c
> > +++ b/fs/proc/bootconfig.c
> > @@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> >  				break;
> >  			dst += ret;
> >  		}
> > -		if (ret >= 0 && boot_command_line[0]) {
> > -			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > -				       boot_command_line);
> > -			if (ret > 0)
> > -				dst += ret;
> > -		}
> > +	}
> > +	if (ret >= 0 && boot_command_line[0]) {
> > +		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > +			       boot_command_line);
> > +		if (ret > 0)
> > +			dst += ret;
> >  	}
> >  out:
> >  	kfree(key);
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

