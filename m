Return-Path: <linux-fsdevel+bounces-16154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55839899418
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 06:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CD1B2716B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 04:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92BF1CF92;
	Fri,  5 Apr 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXQxDBlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3071179AE;
	Fri,  5 Apr 2024 04:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291143; cv=none; b=stRt7GDOks9XmblVA7hm90Y3VtlC3X7YfhgPCUyV5gGdj7aiQAcvoGP4rFs4YdF3EaIZBWRdHaKL4cMFHznslb1rDnYrd2IZVLoa1rSDH5g90PAYOvwe5KbkLEDG6qSt3wUyCzJLt5l2QworcJy5wuY6/MJ+/T/XJEm86eemv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291143; c=relaxed/simple;
	bh=kDYXQzRxOmhqnpbn/Cnzi+p50CCPy4r0h010nVamEu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oumusza6VFx2NV/vo+u2v6R4M4C+NiJIzPVHnWPm2V82c52chdOOew8A+WzoU1xWFfN0flPSQ8k9m0yDqIXnfYjzh1/jZEqTDKCaffjSdZcilQtgi8aosPMZeDFkt6ZVbEBnF1RqhaWtnG7CBtgXDmjFTGFBqkoJM6GZ/u+UVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXQxDBlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F21C433F1;
	Fri,  5 Apr 2024 04:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712291142;
	bh=kDYXQzRxOmhqnpbn/Cnzi+p50CCPy4r0h010nVamEu0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oXQxDBlUrKDU3PYeB2t21iTiI3AFU4sEjJb5tIU6nP+LDNB1p3765ICPL5vVJsSSr
	 8P3oX9faftsRhswpUuBu7yYhcJAHXhgLDMj7fqNf/D8yM9U6FsFBJDHQrPwSQHk5jU
	 qshRar/JiXd+hm7edYh1+qIU8QI2OY/ai9aIqNZKQQ4vuBCQWnLRI8n9YdhjMBh++T
	 yY1CwqjdIvQTXwch91FTOZ7P54bGhRvztPfRPPFBNcdr0gP3EBrrbh/hnqb98xh5hM
	 IZirPCKfHXMuaiMiE0OOPu6z28xuxhlYBKXGXkj5sEGHIjQ4DpY86RrbIuhY8i/cvS
	 TMx+uaF4SBuyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 00DDECE13D0; Thu,  4 Apr 2024 21:25:41 -0700 (PDT)
Date: Thu, 4 Apr 2024 21:25:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH fs/proc/bootconfig] remove redundant comments from
 /proc/bootconfig
Message-ID: <ef8cf3e7-9684-4495-a70e-c8f13ad188c5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
 <20240404085522.63bf8cce6f961c07c8ce3f17@kernel.org>
 <26d56fa5-2c95-46da-8268-35642f857d6d@paulmck-laptop>
 <20240405102324.b7bb9fa052754d352cd2708e@kernel.org>
 <20240405115745.9b95679aa3ac516995d4d885@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405115745.9b95679aa3ac516995d4d885@kernel.org>

On Fri, Apr 05, 2024 at 11:57:45AM +0900, Masami Hiramatsu wrote:
> On Fri, 5 Apr 2024 10:23:24 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 4 Apr 2024 10:43:14 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Thu, Apr 04, 2024 at 08:55:22AM +0900, Masami Hiramatsu wrote:
> > > > On Wed, 3 Apr 2024 12:16:28 -0700
> > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > 
> > > > > commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
> > > > > /proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.
> > > > > 
> > > > > /proc/bootconfig shows boot_command_line[] multiple times following
> > > > > every xbc key value pair, that's duplicated and not necessary.
> > > > > Remove redundant ones.
> > > > > 
> > > > > Output before and after the fix is like:
> > > > > key1 = value1
> > > > > *bootloader argument comments*
> > > > > key2 = value2
> > > > > *bootloader argument comments*
> > > > > key3 = value3
> > > > > *bootloader argument comments*
> > > > > ...
> > > > > 
> > > > > key1 = value1
> > > > > key2 = value2
> > > > > key3 = value3
> > > > > *bootloader argument comments*
> > > > > ...
> > > > > 
> > > > > Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> > > > > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Cc: <linux-trace-kernel@vger.kernel.org>
> > > > > Cc: <linux-fsdevel@vger.kernel.org>
> > > > 
> > > > OOps, good catch! Let me pick it.
> > > > 
> > > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Thank you, and I have applied your ack and pulled this into its own
> > > bootconfig.2024.04.04a.
> > > 
> > > My guess is that you will push this via your own tree, and so I will
> > > drop my copy as soon as yours hits -next.
> > 
> > Thanks! I would like to make PR this soon as bootconfig fixes for v6.9-rc2.
> 
> Hmm I found that this always shows the command line comment in
> /proc/bootconfig even without "bootconfig" option.
> I think that is easier for user-tools but changes the behavior and
> a bit redundant.
> 
> We should skip showing this original argument comment if bootconfig is
> not initialized (no "bootconfig" in cmdline) as it is now.

So something like this folded into that patch?

------------------------------------------------------------------------

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index e5635a6b127b0..7d2520378f5f2 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -63,7 +63,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 			dst += ret;
 		}
 	}
-	if (ret >= 0 && boot_command_line[0]) {
+	if (bootconfig_is_present() && ret >= 0 && boot_command_line[0]) {
 		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
 			       boot_command_line);
 		if (ret > 0)
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index ca73940e26df8..ef70d1b381421 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -10,6 +10,7 @@
 #ifdef __KERNEL__
 #include <linux/kernel.h>
 #include <linux/types.h>
+int bootconfig_is_present(void);
 #else /* !__KERNEL__ */
 /*
  * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
diff --git a/init/main.c b/init/main.c
index 2ca52474d0c30..720a669b1493d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1572,3 +1572,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	integrity_load_keys();
 }
+
+int bootconfig_is_present(void)
+{
+	return bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE);
+}

------------------------------------------------------------------------

Give or take placement of the bootconfig_is_present() function's
declaration and definition.

							Thanx, Paul

							Thanx, Paul

> Thank you,
> 
> 
> > Thank you,
> > 
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Thank you!
> > > > 
> > > > > 
> > > > > diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> > > > > index 902b326e1e560..e5635a6b127b0 100644
> > > > > --- a/fs/proc/bootconfig.c
> > > > > +++ b/fs/proc/bootconfig.c
> > > > > @@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> > > > >  				break;
> > > > >  			dst += ret;
> > > > >  		}
> > > > > -		if (ret >= 0 && boot_command_line[0]) {
> > > > > -			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > > > > -				       boot_command_line);
> > > > > -			if (ret > 0)
> > > > > -				dst += ret;
> > > > > -		}
> > > > > +	}
> > > > > +	if (ret >= 0 && boot_command_line[0]) {
> > > > > +		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > > > > +			       boot_command_line);
> > > > > +		if (ret > 0)
> > > > > +			dst += ret;
> > > > >  	}
> > > > >  out:
> > > > >  	kfree(key);
> > > > 
> > > > 
> > > > -- 
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

