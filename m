Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4071B2D1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgDUQt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgDUQt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:49:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A01C061A41;
        Tue, 21 Apr 2020 09:49:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h2so4317119wmb.4;
        Tue, 21 Apr 2020 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T410BgQnQuXKYxEscOwjOVqkA5eP3x59KmpAyvDkg4s=;
        b=l0Bm/taxusuNTxZw1FbXGtXDpfSusKDst3J4oiI9sMkyBNO92zGgBZEvRDjytEhR6X
         sB/4KTOtNLlSxcjR6/4guGlb5P5XX8fKUqAAPtLWS5GFAfm106bRNkpHF8/mZoJTe04u
         dtqfbHV4XrVi1WAtZ7jce6ZnnbjqSAvv0uB1+VwHUMFZ8YhkKTPvPQMbdIudkIjGQzIx
         oAwj6DIDHJhxi8hmuNAZsSlYkXuinZzdmnU0ZwjzHUrCgyFEE1BgIMc4ng71EE9W3edY
         7440FDFYLkQpT0FVi6xrpzsUsvqqDL+iDRBuX9UTajdAA3Kqfe+n6oHBe0o21cyL4Yri
         xYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T410BgQnQuXKYxEscOwjOVqkA5eP3x59KmpAyvDkg4s=;
        b=pOcuCpSNqY5DZ5O2tRyPU0bq3XmdECqjo0nKTJftjG6Vzq24tYzyZay4O2WJs0T0x/
         k4+qe0RNeT9xZNExyI2v2+1wiJlLHV/UQDIyMcPtdyYGv6UTiA2r2Dq+6X7ofph9P0Hb
         NMWMDpp7KQloXmTmfTBqnl1jYik4eAvIHOhzeuhDLwYSLgkqZtcWikMoOfx/jnABdlo2
         GCggvVlYaDuAedpvHHdh0KNGfKiWqRG311MbhlJcK2owG/K5EM0i+AMxIaMUICPDhobh
         e2KNB/Dtt/jSFxafDHlsn3t8euVF5Tc2UdgIkPDBCyYvRz0nrV2NNnjpjATMDPfZoepU
         QY/g==
X-Gm-Message-State: AGi0PubDin/liPWfcYf9dAwkL8sQK5y2+TQ0poDKDsqueWTyzUQoOwEw
        x83B9awDSsEqiwwH5c0loQ==
X-Google-Smtp-Source: APiQypImaX4lCCdm1ARp3k//LAraQn8166oj7y7Phe1pcfSwcjV1Xs/Aq5v8GXULdw9f5bdOUeyq9g==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr5730030wmi.88.1587487766805;
        Tue, 21 Apr 2020 09:49:26 -0700 (PDT)
Received: from avx2 ([46.53.252.84])
        by smtp.gmail.com with ESMTPSA id h3sm4336863wrm.73.2020.04.21.09.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:49:26 -0700 (PDT)
Date:   Tue, 21 Apr 2020 19:49:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 03/15] print_integer: new and improved way of printing
 integers
Message-ID: <20200421164924.GB8735@avx2>
References: <20200420205743.19964-1-adobriyan@gmail.com>
 <20200420205743.19964-3-adobriyan@gmail.com>
 <20200420211911.GC185537@smile.fi.intel.com>
 <20200420212723.GE185537@smile.fi.intel.com>
 <20200420215417.6e2753ee@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420215417.6e2753ee@oasis.local.home>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:54:17PM -0400, Steven Rostedt wrote:
> On Tue, 21 Apr 2020 00:27:23 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > >   
> > > > 	TODO
> > > > 	benchmark with mainline because nouveau is broken for me -(
> > > > 	vsnprintf() changes make the code slower  
> > > 
> > > Exactly main point of this exercise. I don't believe that algos in vsprintf.c
> > > are too dumb to use division per digit (yes, division by constant which is not
> > > power of two is a heavy operation).
> > >   
> > 
> > And second point here, why not to use existing algos from vsprintf.c?
> 
> Exactly. The code in _print_integer_u32() doesn't look as fast as the
> code in vsprintf() that happens to use lookup tables and converts
> without any loops.
> 
> Hint, loops are bad, they cause the CPU to slow down.

Oh, come on! Loops make code fit into icache and μop decode cache.

> Anyway, this patch series would require a pretty good improvement, as
> the code replacing the sprintf() usages is pretty ugly compared to a
> simple sprintf() call.

No! Fast code must look ugly. Or in other words if you try to optimise
integer printing to death you'll probably end with something like
_print_integer().

When the very first patch changed /proc/stat to seq_put_decimal_ull()
the speed up was 66% (or 33%). That's how slow printing was back then.
It can be made slightly faster even now.

> Randomly picking patch 6:
> 
>  static int loadavg_proc_show(struct seq_file *m, void *v)
>  {
>  	unsigned long avnrun[3];
>  
>  	get_avenrun(avnrun, FIXED_1/200, 0);
>  
> 	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
> 		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
> 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
> 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
> 		nr_running(), nr_threads,
> 		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
>  	return 0;
>  }
> 
>   *vs* 
> 
>  static int loadavg_proc_show(struct seq_file *m, void *v)
>  {
>  	unsigned long avnrun[3];
> 	char buf[3 * (LEN_UL + 1 + 2 + 1) + 10 + 1 + 10 + 1 + 10 + 1];
> 	char *p = buf + sizeof(buf);
> 	int i;
> 
> 	*--p = '\n';
> 	p = _print_integer_u32(p, idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
> 	*--p = ' ';
> 	p = _print_integer_u32(p, nr_threads);
> 	*--p = '/';
> 	p = _print_integer_u32(p, nr_running());
> 
>  	get_avenrun(avnrun, FIXED_1/200, 0);
> 	for (i = 2; i >= 0; i--) {
> 		*--p = ' ';
> 		--p;		/* overwritten */
> 		*--p = '0';	/* conditionally overwritten */
> 		(void)_print_integer_u32(p + 2, LOAD_FRAC(avnrun[i]));
> 		*--p = '.';
> 		p = _print_integer_ul(p, LOAD_INT(avnrun[i]));
> 	}
>  
> 	seq_write(m, p, buf + sizeof(buf) - p);
>  	return 0;
>  }
> 
> 
> I much rather keep the first version.

I did the benchmarks (without stack protector though), everything except
/proc/cpuinfo and /proc/meminfo became faster. This requires investigation
and I can drop vsprintf() changes until then.

Now given that /proc/uptime format cast in stone, code may look a bit ugly
and unusual but it won't require maintainance
