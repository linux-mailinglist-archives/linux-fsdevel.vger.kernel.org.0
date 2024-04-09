Return-Path: <linux-fsdevel+bounces-16387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93B89CF90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 02:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A86F1F23276
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 00:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E605660;
	Tue,  9 Apr 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nro8Bp50"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593C23A6;
	Tue,  9 Apr 2024 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712623983; cv=none; b=Q+irdK0mKvmbzCU7eF19Vna4rvV8jOe6ZR5UY42mJPhD2OowLU3HESeKFvRaGmDuPQ5qSXIlive6F8jL7gV6+xE9opldXMG8n6pn4ZIX8D9mjmM1rboOttKLLrZo/v2sD2QSiac095bgVR0NY1Ta+8bI7OEbI7aS9plnkik5OuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712623983; c=relaxed/simple;
	bh=yus4baOhquA5Y6H2Qk7Vcs7DDe8zOVhBstmQl7pENJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfyH9VJwfIj8d+4CrBvBybzomMaPmPQJpyRwTUXP2oJ62YxvppC4HUuhAG7aOIZOHU+TS0CHT5gTH2yO5B4FBKfAEui8pWNuHgiRN6kffhoKESXRM3Wd4rzXtzGVTyeGQmQNHu5jaFGw1p15uPwLhxC4Pup7UalZLrQ5EiJpWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nro8Bp50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8518C433F1;
	Tue,  9 Apr 2024 00:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712623982;
	bh=yus4baOhquA5Y6H2Qk7Vcs7DDe8zOVhBstmQl7pENJU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nro8Bp50ys+tBqWGF+GIktpE1D5so/YqYdmTWZmxMGR7vrJa1V7CXJZlLv5r7Uzoz
	 AuDHl6frWGxP+38U4NLYi3xTmJRNYeVHm0IU1i2q4QfTb9RncOShVCP38qhmhY8MAg
	 TSccKP1D0ktVJJY46z6gmUCGTzqgsRA95MSopB2F3EqojwTLr4GUNgG9pkj6/p9t8s
	 x2JE7qt21Yeji82PJLAVlElv6nvdVW4Prii2v7FOwqehsNTR7t1tII0MY45Pj8FrkM
	 3BpJOoZzOTBnyvnvZEGdKKXMa4otJMrozHmgaO9d2P7Bz9vwM0j3qGwXOdDvB9kxE/
	 NxammYt01MxCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5C9DCCE118A; Mon,  8 Apr 2024 17:53:02 -0700 (PDT)
Date: Mon, 8 Apr 2024 17:53:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH fs/proc/bootconfig] remove redundant comments from
 /proc/bootconfig
Message-ID: <d429b1af-b7c2-42d6-85c6-ce318d058cb6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
 <20240404085522.63bf8cce6f961c07c8ce3f17@kernel.org>
 <26d56fa5-2c95-46da-8268-35642f857d6d@paulmck-laptop>
 <20240405102324.b7bb9fa052754d352cd2708e@kernel.org>
 <20240405115745.9b95679aa3ac516995d4d885@kernel.org>
 <ef8cf3e7-9684-4495-a70e-c8f13ad188c5@paulmck-laptop>
 <20240406111108.e9a8b8c4cb8f44a8fb95b541@kernel.org>
 <bacfd3b9-5a2a-43ee-8169-4d8bf5a3ddc8@paulmck-laptop>
 <20240409092540.44cadc511429545d3052fe79@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409092540.44cadc511429545d3052fe79@kernel.org>

On Tue, Apr 09, 2024 at 09:25:40AM +0900, Masami Hiramatsu wrote:
> On Mon, 8 Apr 2024 12:18:19 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Sat, Apr 06, 2024 at 11:11:08AM +0900, Masami Hiramatsu wrote:
> > > On Thu, 4 Apr 2024 21:25:41 -0700
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > On Fri, Apr 05, 2024 at 11:57:45AM +0900, Masami Hiramatsu wrote:
> > > > > On Fri, 5 Apr 2024 10:23:24 +0900
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > > 
> > > > > > On Thu, 4 Apr 2024 10:43:14 -0700
> > > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > > 
> > > > > > > On Thu, Apr 04, 2024 at 08:55:22AM +0900, Masami Hiramatsu wrote:
> > > > > > > > On Wed, 3 Apr 2024 12:16:28 -0700
> > > > > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > > > > 
> > > > > > > > > commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
> > > > > > > > > /proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.
> > > > > > > > > 
> > > > > > > > > /proc/bootconfig shows boot_command_line[] multiple times following
> > > > > > > > > every xbc key value pair, that's duplicated and not necessary.
> > > > > > > > > Remove redundant ones.
> > > > > > > > > 
> > > > > > > > > Output before and after the fix is like:
> > > > > > > > > key1 = value1
> > > > > > > > > *bootloader argument comments*
> > > > > > > > > key2 = value2
> > > > > > > > > *bootloader argument comments*
> > > > > > > > > key3 = value3
> > > > > > > > > *bootloader argument comments*
> > > > > > > > > ...
> > > > > > > > > 
> > > > > > > > > key1 = value1
> > > > > > > > > key2 = value2
> > > > > > > > > key3 = value3
> > > > > > > > > *bootloader argument comments*
> > > > > > > > > ...
> > > > > > > > > 
> > > > > > > > > Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> > > > > > > > > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > > > > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > > > > > Cc: <linux-trace-kernel@vger.kernel.org>
> > > > > > > > > Cc: <linux-fsdevel@vger.kernel.org>
> > > > > > > > 
> > > > > > > > OOps, good catch! Let me pick it.
> > > > > > > > 
> > > > > > > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > > > 
> > > > > > > Thank you, and I have applied your ack and pulled this into its own
> > > > > > > bootconfig.2024.04.04a.
> > > > > > > 
> > > > > > > My guess is that you will push this via your own tree, and so I will
> > > > > > > drop my copy as soon as yours hits -next.
> > > > > > 
> > > > > > Thanks! I would like to make PR this soon as bootconfig fixes for v6.9-rc2.
> > > > > 
> > > > > Hmm I found that this always shows the command line comment in
> > > > > /proc/bootconfig even without "bootconfig" option.
> > > > > I think that is easier for user-tools but changes the behavior and
> > > > > a bit redundant.
> > > > > 
> > > > > We should skip showing this original argument comment if bootconfig is
> > > > > not initialized (no "bootconfig" in cmdline) as it is now.
> > > > 
> > > > So something like this folded into that patch?
> > > 
> > > Hm, I expected just checking it in the loop as below.
> > > 
> > > ------------------------------------------------------------------------
> > > diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> > > index e5635a6b127b..98e0780f7e07 100644
> > > --- a/fs/proc/bootconfig.c
> > > +++ b/fs/proc/bootconfig.c
> > > @@ -27,6 +27,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> > >  {
> > >  	struct xbc_node *leaf, *vnode;
> > >  	char *key, *end = dst + size;
> > > +	bool empty = true;
> > >  	const char *val;
> > >  	char q;
> > >  	int ret = 0;
> > > @@ -62,8 +63,9 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> > >  				break;
> > >  			dst += ret;
> > >  		}
> > > +		empty = false;
> > >  	}
> > > -	if (ret >= 0 && boot_command_line[0]) {
> > > +	if (!empty && ret >= 0 && boot_command_line[0]) {
> > >  		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > >  			       boot_command_line);
> > >  		if (ret > 0)
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > The difference is checking "bootconfig" cmdline option or checking
> > > the "bootconfig" is actually empty. So the behaviors are different
> > > when the "bootconfig" is specified but there is no bootconfig data.
> > 
> > Ah, understood, the point is to avoid the comment in cases where its
> > content would be identical to /proc/cmdline.
> > 
> > > Another idea is to check whether the cmdline is actually updated by
> > > bootconfig and show original one only if it is updated.
> > > (I think this fits the purpose of the original patch better.)
> > > 
> > > ------------------------------------------------------------------------
> > > diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> > > index e5635a6b127b..95d6a231210c 100644
> > > --- a/fs/proc/bootconfig.c
> > > +++ b/fs/proc/bootconfig.c
> > > @@ -10,6 +10,9 @@
> > >  #include <linux/bootconfig.h>
> > >  #include <linux/slab.h>
> > >  
> > > +/* defined in main/init.c */
> > > +bool __init cmdline_has_extra_options(void);
> > > +
> > >  static char *saved_boot_config;
> > >  
> > >  static int boot_config_proc_show(struct seq_file *m, void *v)
> > > @@ -63,7 +66,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> > >  			dst += ret;
> > >  		}
> > >  	}
> > > -	if (ret >= 0 && boot_command_line[0]) {
> > > +	if (cmdline_has_extra_options() && ret >= 0 && boot_command_line[0]) {
> > >  		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > >  			       boot_command_line);
> > >  		if (ret > 0)
> > > diff --git a/init/main.c b/init/main.c
> > > index 2ca52474d0c3..881f6230ee59 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -487,6 +487,11 @@ static int __init warn_bootconfig(char *str)
> > >  
> > >  early_param("bootconfig", warn_bootconfig);
> > >  
> > > +bool __init cmdline_has_extra_options(void)
> > > +{
> > > +	return extra_command_line || extra_init_args;
> > > +}
> > > +
> > >  /* Change NUL term back to "=", to make "param" the whole string. */
> > >  static void __init repair_env_string(char *param, char *val)
> > >  {
> > > ------------------------------------------------------------------------
> > 
> > This one looks good to me!
> > 
> > I had to move the declaration from /fs/proc/bootconfig.c to
> > include/linux/bootconfig.h in order to avoid a build error.  (The
> > build system wants the declaration and definition to be visible as
> > a cross-check.)
> > 
> > Does the resulting patch below work for you?
> 
> Yes, this looks good to me. BTW, shouldn't we push this with the
> previous fix (from the viewpoint of memory usage, this is a kind
> of fix for redundant memory usage)?

Makes sense to me!  Let me run a few tests on it.

For whatever it is worth, I have them both queued on their own branch
on -rcu:

4facfdfaec7a ("fs/proc: remove redundant comments from /proc/bootconfig")
8d95b50c523f ("fs/proc: Skip bootloader comment if no embedded kernel parameters")

							Thanx, Paul

> Thank you!
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 8d95b50c523fba7133368650b3b5f71b169c76b5
> > Author: Masami Hiramatsu <mhiramat@kernel.org>
> > Date:   Mon Apr 8 12:10:38 2024 -0700
> > 
> >     fs/proc: Skip bootloader comment if no embedded kernel parameters
> >     
> >     If the "bootconfig" kernel command-line argument was specified or if
> >     the kernel was built with CONFIG_BOOT_CONFIG_FORCE, but if there are
> >     no embedded kernel parameter, omit the "# Parameters from bootloader:"
> >     comment from the /proc/bootconfig file.  This will cause automation
> >     to fall back to the /proc/cmdline file, which will be identical to the
> >     comment in this no-embedded-kernel-parameters case.
> >     
> >     Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> > index e5635a6b127b0..87dcaae32ff87 100644
> > --- a/fs/proc/bootconfig.c
> > +++ b/fs/proc/bootconfig.c
> > @@ -63,7 +63,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> >  			dst += ret;
> >  		}
> >  	}
> > -	if (ret >= 0 && boot_command_line[0]) {
> > +	if (cmdline_has_extra_options() && ret >= 0 && boot_command_line[0]) {
> >  		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> >  			       boot_command_line);
> >  		if (ret > 0)
> > diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> > index ca73940e26df8..e5ee2c694401e 100644
> > --- a/include/linux/bootconfig.h
> > +++ b/include/linux/bootconfig.h
> > @@ -10,6 +10,7 @@
> >  #ifdef __KERNEL__
> >  #include <linux/kernel.h>
> >  #include <linux/types.h>
> > +bool __init cmdline_has_extra_options(void);
> >  #else /* !__KERNEL__ */
> >  /*
> >   * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> > diff --git a/init/main.c b/init/main.c
> > index 2ca52474d0c30..881f6230ee59e 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -487,6 +487,11 @@ static int __init warn_bootconfig(char *str)
> >  
> >  early_param("bootconfig", warn_bootconfig);
> >  
> > +bool __init cmdline_has_extra_options(void)
> > +{
> > +	return extra_command_line || extra_init_args;
> > +}
> > +
> >  /* Change NUL term back to "=", to make "param" the whole string. */
> >  static void __init repair_env_string(char *param, char *val)
> >  {
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

