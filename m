Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF10523A95A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHCPaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCPaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:30:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8966C06174A;
        Mon,  3 Aug 2020 08:30:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l64so28658434qkb.8;
        Mon, 03 Aug 2020 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OMhY71TYhIpQ58Fii8pWBwWswtVlW8CJODU9kCbY3/U=;
        b=o0k5n7eaBR20GSUZPKeqWlBn0CweK6sVQ7UUSjeOuNQBFuw89IiGlcuaGueTxPMRPY
         7zbyA0Z3NFkwInzGHlEFfdHYvcfAWDpZFbIlc4H1QfKHMf0lnLwgyinURc6ITKGeI6gz
         6OB9a+J3UbjDqNvOLmViKvjXLhm6YgHgvAvxpiMZLJwZ4yLfW3nrAzgDbGn55TIX1CDp
         SDABD4FT6a+agwVPPhOM+GHjW2NBqj0pcrxO7XEWuQwKr8AYrT3Nyaa1tTexzddwUgNI
         OOTpPVd+VoKn5ydheEDwPbrKCUj06W56W3DOq3Nq2jDXrO0/dpyYZCpImbI5PG60sy3K
         IlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OMhY71TYhIpQ58Fii8pWBwWswtVlW8CJODU9kCbY3/U=;
        b=Y04aTo94EIgUZxKBGwn+RKH7LxjnfBdecSJo7c+A3PaLwcMhTixu2Om6W298pe0dvl
         OZIhe+vQzdHFEytEVUfgw4a/mzPR2LFr9On7J8yItrxZHFgjvOxl5BnhHPzZKDLNzH0E
         b3BTndQDOcOAHabbn9JvIgvrEPZ35t6UhHR6wUqIZxqtSGJaTd8kwdnD2A2yK74ts6Wi
         HGuXAnNZu4eV/s+ckJxC6rG8nc2N0JPGMhJKx5AV512Cps92jBUMN5GLKVA7+zp2+rYs
         nzbw85Dqhcas6oBVoFAj+99O8N4Vzex5YuhYeac8Ebt1CV4PApmCfNZFlAMptRRkqv2o
         jmMQ==
X-Gm-Message-State: AOAM533BFM9fXLzJD0eGcsPMUMWadi6KOck0rN8XYsZR0KorQe9xYQQ6
        BFKiQrraGPbXWb0nQCC2oec=
X-Google-Smtp-Source: ABdhPJzRBkzm3T5R70vwD3kXwb8PED/sN1IlSegMrVygUPMhyNSjXdIHiypE+Tei2fqltxXyDy5R6g==
X-Received: by 2002:a37:9b15:: with SMTP id d21mr17317313qke.9.1596468601800;
        Mon, 03 Aug 2020 08:30:01 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l64sm18811222qkc.21.2020.08.03.08.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:30:01 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 3 Aug 2020 11:29:59 -0400
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20200803152959.GA1168816@rani.riverdale.lan>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
 <157867229521.17873.654222294326542349.stgit@devnote2>
 <202002070954.C18E7F58B@keescook>
 <20200207144603.30688b94@oasis.local.home>
 <20200802023318.GA3981683@rani.riverdale.lan>
 <20200804000345.f5727ac28647aa8c092cc109@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804000345.f5727ac28647aa8c092cc109@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 12:03:45AM +0900, Masami Hiramatsu wrote:
> On Sat, 1 Aug 2020 22:33:18 -0400
> Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > 
> > I came across this as I was poking around some of the command line
> > parsing. AFAICT, initargs_found will never be set to true here, because
> > parse_args handles "--" itself by immediately returning: it doesn't
> > invoke the callback for it. So you'd instead have to check the return of
> > parse_args("bootconfig"...) to detect the initargs_found case.
> 
> Oops, good catch!
> Does this fixes the problem?

Note I found the issue by code inspection, I don't have an actual test
case. But the change looks good to me, with one comment below.

> 
>  	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> -	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> -		   bootconfig_params);
> +	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> +			 bootconfig_params);
>  
> -	if (!bootconfig_found)
> +	if (IS_ERR(err) || !bootconfig_found)
>  		return;
>  
> +	/* parse_args() stops at '--' and returns an address */
> +	if (!IS_ERR(err) && err)
> +		initargs_found = true;
> +

I think you can drop the second IS_ERR, since we already checked that.

>  	if (!data) {
>  		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
>  		return;
> -- 
> 2.25.1
