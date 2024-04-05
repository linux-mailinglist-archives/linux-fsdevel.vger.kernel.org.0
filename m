Return-Path: <linux-fsdevel+bounces-16140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583BB8992C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 03:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13762287ED3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 01:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D50B656;
	Fri,  5 Apr 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT9kujUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C75258;
	Fri,  5 Apr 2024 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280209; cv=none; b=DFgIP9dcRABk7MEoInPewu/lDvOmvvzj05ZAicNXogNnwRRIZwXdxtfzx7zTwhc4jONA+nlub/FkRiP2srTNGH0h/KQ0kCc0NOQ1vpUXzQF33cfcYDtjULpy61vNi/DDwf55Sustdy3nS1WrM4Cx2OkkooV9rgJEpI7UtRZI4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280209; c=relaxed/simple;
	bh=Yj3fosI2py6gli0fQo4zYWZ/1MQ/0R+9tBHTb/oq+2M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IgVUuRnFS3XTvy2pCD78CseemaR1IA+4cIf34/De65kZvLIhJUXBuNruE7pmWwK3tUeoJQjQlBPceJ2oJ/l+qTijosgBFIyjgn4lL6ynU45OF/FCrfaNzaHuxe1Rc6jUF/BhqRadnkfGp9zbhsQlLCo9q/P26LSNLeZKRu9lGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT9kujUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5AFC433F1;
	Fri,  5 Apr 2024 01:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712280208;
	bh=Yj3fosI2py6gli0fQo4zYWZ/1MQ/0R+9tBHTb/oq+2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BT9kujUC2fD2iGCfeiEN5yf5qd+mJFKWKBFeiDtA+MSF15iuR4soG2SoNMKu7WWVy
	 XjaW9fOWNrosv5f4ICvjasfYDb9rThBENzcOxi3aVRcD4JKE6+yPFOpaV8CMvySI+M
	 1UQmNUTv3R8psOwGjKJcwW9I8jsw8L9rBvKJaHwh1Pi9Qm0XbYNBb2VOCMBhRTjgUN
	 F1X15W1c4ajaMdEiekdIZA8Atv579WjBEacA0ngJBN1/F2XGBwU8JfZk8rMhHDtVjT
	 tlsxsbfmyOVhXNzquOMBRmdgpaizQ4Dg5ozWBZcNQODbNjLCzLmT0cF4sHZkmx1wOm
	 eIcuH6MMy/7IQ==
Date: Fri, 5 Apr 2024 10:23:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH fs/proc/bootconfig] remove redundant comments from
 /proc/bootconfig
Message-Id: <20240405102324.b7bb9fa052754d352cd2708e@kernel.org>
In-Reply-To: <26d56fa5-2c95-46da-8268-35642f857d6d@paulmck-laptop>
References: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
	<20240404085522.63bf8cce6f961c07c8ce3f17@kernel.org>
	<26d56fa5-2c95-46da-8268-35642f857d6d@paulmck-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 10:43:14 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, Apr 04, 2024 at 08:55:22AM +0900, Masami Hiramatsu wrote:
> > On Wed, 3 Apr 2024 12:16:28 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
> > > /proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.
> > > 
> > > /proc/bootconfig shows boot_command_line[] multiple times following
> > > every xbc key value pair, that's duplicated and not necessary.
> > > Remove redundant ones.
> > > 
> > > Output before and after the fix is like:
> > > key1 = value1
> > > *bootloader argument comments*
> > > key2 = value2
> > > *bootloader argument comments*
> > > key3 = value3
> > > *bootloader argument comments*
> > > ...
> > > 
> > > key1 = value1
> > > key2 = value2
> > > key3 = value3
> > > *bootloader argument comments*
> > > ...
> > > 
> > > Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> > > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: <linux-trace-kernel@vger.kernel.org>
> > > Cc: <linux-fsdevel@vger.kernel.org>
> > 
> > OOps, good catch! Let me pick it.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you, and I have applied your ack and pulled this into its own
> bootconfig.2024.04.04a.
> 
> My guess is that you will push this via your own tree, and so I will
> drop my copy as soon as yours hits -next.

Thanks! I would like to make PR this soon as bootconfig fixes for v6.9-rc2.

Thank you,

> 
> 							Thanx, Paul
> 
> > Thank you!
> > 
> > > 
> > > diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> > > index 902b326e1e560..e5635a6b127b0 100644
> > > --- a/fs/proc/bootconfig.c
> > > +++ b/fs/proc/bootconfig.c
> > > @@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> > >  				break;
> > >  			dst += ret;
> > >  		}
> > > -		if (ret >= 0 && boot_command_line[0]) {
> > > -			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > > -				       boot_command_line);
> > > -			if (ret > 0)
> > > -				dst += ret;
> > > -		}
> > > +	}
> > > +	if (ret >= 0 && boot_command_line[0]) {
> > > +		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > > +			       boot_command_line);
> > > +		if (ret > 0)
> > > +			dst += ret;
> > >  	}
> > >  out:
> > >  	kfree(key);
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

