Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62F155E9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 20:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGTbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 14:31:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39167 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgBGTbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:31:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id w15so211595qkf.6;
        Fri, 07 Feb 2020 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZkpXb/Mvw8qZyRJM76GkT3rnAFfUOKULtUPg4iPdeJU=;
        b=CREEuByZvw6a7GdcLO3uMXiq/E3wUDW+KQRbosp7l0VVBD5NLfSK60uQKE5SB9q3no
         zKhlfLbHLIj4TR2SQpcpPtlPTEr47jEaxgDMdCbyAcXAOJ1fuYIwe+BnntP1HrhkemGn
         qG0K7J8ZiVCRPK5FsT3rCX/S5hLSfA3vZSNooF6UJ8EATZKijS3lT1QIuceiUzyC5PJI
         L53pt//TSTOGqs+SyRjZoo03alTjFDx+JBqbWs/rOUYYcRQhb5e4W/lOVOTeVzRdtct+
         eW6RxdDLfsyPx2KHxYxwiE8GFY6Ivtsb/h6EoofuGU7URSsAjehav7ss5+//4lk3WSZu
         8bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZkpXb/Mvw8qZyRJM76GkT3rnAFfUOKULtUPg4iPdeJU=;
        b=maqgi1IWYQHWq10EQ+nDSeiK1oPCMbRNQmGeJSxKXBWjtNI63upu4i44YDiIb3NVoR
         sNwmoeXsy5oW8nhz/s+yPcjrpBsCri1VO80RFIWLMSoULAHjASswpZWDOZ30pjNhFoxI
         RX0e1wQoGvEpVRtU2pCLp+D9KgkJ3bIiN/p+QEWM3FzMS06+2QOlJaedyXRiQeh5h9OM
         dILrKDJztYhlQ0KZlxZUGxBiqixVpgYPQ2Ihmuge/xNIIqPMdxPDsSogc4WlAjp+WkZ7
         gkf2Y37NHMH91bsdTY8gEegYlMgbEqwwLaik3+U+vt/rue0XcCewqJYQWrwAWeJrMmnm
         DoqA==
X-Gm-Message-State: APjAAAVEbPOmxT8yEWAwG71Dflivf61gfhOI4wA3sDR4/0NbJP2KxvkB
        6k7YWr8mINhNIUsOHDHqCUQ=
X-Google-Smtp-Source: APXvYqxy6o6177LHJnLryDQqD0y55xKipDKCoLo5JYvFEJ5gBxdU3RRLew7swNn1gJfRZTXayQF65w==
X-Received: by 2002:a05:620a:9d9:: with SMTP id y25mr439287qky.41.1581103877782;
        Fri, 07 Feb 2020 11:31:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k37sm1896821qtf.70.2020.02.07.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 11:31:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 7 Feb 2020 14:31:15 -0500
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20200207193113.GA3438946@rani.riverdale.lan>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
 <157867229521.17873.654222294326542349.stgit@devnote2>
 <202002070954.C18E7F58B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202002070954.C18E7F58B@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 10:03:16AM -0800, Kees Cook wrote:
> > +
> > +	if (ilen) {
> > +		/*
> > +		 * Append supplemental init boot args to saved_command_line
> > +		 * so that user can check what command line options passed
> > +		 * to init.
> > +		 */
> > +		len = strlen(saved_command_line);
> > +		if (!strstr(boot_command_line, " -- ")) {
> > +			strcpy(saved_command_line + len, " -- ");
> > +			len += 4;
> > +		} else
> > +			saved_command_line[len++] = ' ';
> > +
> > +		strcpy(saved_command_line + len, extra_init_args);
> > +	}
> 
> This isn't safe because it will destroy any argument with " -- " in
> quotes and anything after it. For example, booting with:
> 
> thing=on acpi_osi="! -- " other=setting
> 
> will wreck acpi_osi's value and potentially overwrite "other=settings",
> etc.
> 
> (Yes, this seems very unlikely, but you can't treat " -- " as special,
> the command line string must be correct parsed for double quotes, as
> parse_args() does.)
> 

I think it won't overwrite anything, it will just leave out the " -- "
that should have been added?

I wonder if this is necessary, though -- since commit b88c50ac304a ("log
arguments and environment passed to init") the init arguments will be in
the kernel log anyway.
