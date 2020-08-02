Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841262354E4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 04:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHBCdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 22:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgHBCdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 22:33:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA40C06174A;
        Sat,  1 Aug 2020 19:33:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so32442828qkb.1;
        Sat, 01 Aug 2020 19:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qh76r0/R+rEXWnTlGb5P7btqSGU2SCfDlWiL6NIkY7c=;
        b=hYyQUks+AqVyPq7/q4lLsuKLhaTOp592VqDxfh+4bBwPILEMaEGFmDm98mqvaFEYd4
         scTN1rZYCU3dya+9yUfYM/Ii3TwfTS3KUh6kTHaRC2S7mamkZnDFcAAvJQmus78Ulwvv
         E/3mKP1UtgCr+eIpVfGJELWg3bD2xNS6KvoEDktgMjpnTWV7djBy1bo9KinS86H/BSt5
         IxC1U4ndkF/ByrZHJRXuhLgxbnsfPkX1XWIW6XxzqmBK9IKca+jCMCJfL7bTAECgfNi/
         GHq4OufZTW84FlksErc/99Xe7KOdbEnUTjC7Cx7vsayuklr/ixuYPQHe5kWrm46fu0Rw
         u5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qh76r0/R+rEXWnTlGb5P7btqSGU2SCfDlWiL6NIkY7c=;
        b=C0CJF/rw4fYA0AB7opjCnojx8inyoPWe6/zkUTWn1gtIsj7c0ZbE7cDAuPW6NM/ZKB
         1hMM8eEZTcSEmlpO/MIqaHCooIjpNlGlCvdcpv9AalroxZnD2CVUytZttX4CC/MkWMfI
         zARTrrelBhgU8Ux4k7O+Qinr7i4InzohkanzcOZzJF/Wrz05BVIJFPnzVHMc5behz3VI
         eRu0M0JJOj2pav2xrnuPuGtj1fKpcOpWjuCv32RttnVxd8jSIGFYsGmYIqZcMYliMVHa
         rZ2U0M7Kt2Uy5P0nAYj8B00/rKY6g60gEqtqoyuHg4MJVX1Moi04E1U8kpglf/XR4lXj
         ipeA==
X-Gm-Message-State: AOAM530wrADVu8jfafNapdhCT2HJc7cTOGL3LigWQ0yJg+dhS1/6mde/
        eDgCecCSjTzw8ggujmjY5Uc=
X-Google-Smtp-Source: ABdhPJy6UqPvoghO+l/O/yD9CRByuJospOw+gGGYEERjfM0CJS8Kn0NNaLtkI9aIJNpageB+6Rz0Hg==
X-Received: by 2002:a05:620a:230:: with SMTP id u16mr9991610qkm.387.1596335601213;
        Sat, 01 Aug 2020 19:33:21 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y24sm15359536qtv.71.2020.08.01.19.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 19:33:20 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 1 Aug 2020 22:33:18 -0400
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/22] bootconfig: init: Allow admin to use bootconfig
 for init command line
Message-ID: <20200802023318.GA3981683@rani.riverdale.lan>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
 <157867229521.17873.654222294326542349.stgit@devnote2>
 <202002070954.C18E7F58B@keescook>
 <20200207144603.30688b94@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200207144603.30688b94@oasis.local.home>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 02:46:03PM -0500, Steven Rostedt wrote:
> 
> diff --git a/init/main.c b/init/main.c
> index 491f1cdb3105..113c8244e5f0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -142,6 +142,15 @@ static char *extra_command_line;
>  /* Extra init arguments */
>  static char *extra_init_args;
>  
> +#ifdef CONFIG_BOOT_CONFIG
> +/* Is bootconfig on command line? */
> +static bool bootconfig_found;
> +static bool initargs_found;
> +#else
> +# define bootconfig_found false
> +# define initargs_found false
> +#endif
> +
>  static char *execute_command;
>  static char *ramdisk_execute_command;
>  
> @@ -336,17 +345,32 @@ u32 boot_config_checksum(unsigned char *p, u32 size)
>  	return ret;
>  }
>  
> +static int __init bootconfig_params(char *param, char *val,
> +				    const char *unused, void *arg)
> +{
> +	if (strcmp(param, "bootconfig") == 0) {
> +		bootconfig_found = true;
> +	} else if (strcmp(param, "--") == 0) {
> +		initargs_found = true;
> +	}
> +	return 0;
> +}
> +

I came across this as I was poking around some of the command line
parsing. AFAICT, initargs_found will never be set to true here, because
parse_args handles "--" itself by immediately returning: it doesn't
invoke the callback for it. So you'd instead have to check the return of
parse_args("bootconfig"...) to detect the initargs_found case.

>  static void __init setup_boot_config(const char *cmdline)
>  {
> +	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
>  	u32 size, csum;
>  	char *data, *copy;
>  	const char *p;
>  	u32 *hdr;
>  	int ret;
>  
> -	p = strstr(cmdline, "bootconfig");
> -	if (!p || (p != cmdline && !isspace(*(p-1))) ||
> -	    (p[10] && !isspace(p[10])))
> +	/* All fall through to do_early_param. */
> +	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> +	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> +		   bootconfig_params);
> +
> +	if (!bootconfig_found)
>  		return;
