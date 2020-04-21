Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A391B2DD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDURGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDURGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:06:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93A3C061A41;
        Tue, 21 Apr 2020 10:06:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so17270686wrm.13;
        Tue, 21 Apr 2020 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hRby/GaY4ncpy7xXsgQhDkX3RBVaqXic4ZU9biVTX/M=;
        b=RUDNecfnjYrJmr+hFUi5bG1OlRyIRXcFPWEbOz+cNMgTuapSQeOvXp+91Nu5u/h65a
         kVHiu2E/e2yOM7L5YbjDYeDu2vALohoMTi+cyleLuWgk0YL3N3JO7teWCmh+im6TAh9F
         bWJXRhZVrfr3+18kXwEM8Ql+I/uP7auoepsXGSemaesvzkCggAlyT7tz8P6HbTEvkqo3
         ltxN7P2h5JXTtu92ykaPHPZ5K5PnQMbEodK9Dj7vYWkN2n95+YZl+bfSQaZ86U+C7pKP
         iHwjtyTczyfZCkikBd3zJwZdWCdyiezhRIIbPWLLz6AKj2vUXbXRZv/jCI2bRklOtZ7R
         bA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRby/GaY4ncpy7xXsgQhDkX3RBVaqXic4ZU9biVTX/M=;
        b=Ab5tkhKVhdkDaxCABJcuTJ8tWxQ9csQyQKsatpfeDG7kLAtHAsLK7nYyezz0wXRb4F
         TjnZueI6ScL4wQ/OHEm/tM6A78ezQMlENqTHBaZTdCNs+fepnzFshGLJjvgJcwjVYcTP
         gwPXMMRerkbtN3ufunrpJtlUYgREwnIrljOIBTrtn2T0Qgs6Pw7eQlaDbHL5jpmEhwxl
         ML2s7tOUYxN2zGyd5M6RjtbGHASwRGhfZ811eO+OInHKwqT9WUpjSxpg7bB5MyaEU8qE
         PnIt+79VJIJ0so0GvrSmBGSvgDIg1Shqc6n7XlBbTWo633nnr3h10O0Bc2fvD9hwzCvD
         y+Fg==
X-Gm-Message-State: AGi0PubnvT5N8XdtCg0PBUYtmDhv9YO0/rpMQ8pRsnMWdPMzHKi/QhlC
        yxhjL6bA2a6wza+eUJZIJg==
X-Google-Smtp-Source: APiQypJxUZJy3HyvKPVhz8Qax15+yRpUuaFg555QpaaDLpVMBAUS6QYq6+pxY49PIHmGXdRih3nljQ==
X-Received: by 2002:adf:8363:: with SMTP id 90mr23739359wrd.233.1587488796755;
        Tue, 21 Apr 2020 10:06:36 -0700 (PDT)
Received: from avx2 ([46.53.252.84])
        by smtp.gmail.com with ESMTPSA id l5sm4051806wmi.22.2020.04.21.10.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 10:06:36 -0700 (PDT)
Date:   Tue, 21 Apr 2020 20:06:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 01/15] sched: make nr_running() return "unsigned int"
Message-ID: <20200421170634.GA31089@avx2>
References: <20200420205743.19964-1-adobriyan@gmail.com>
 <20200420210557.GG5820@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420210557.GG5820@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:05:57PM -0700, Matthew Wilcox wrote:
> On Mon, Apr 20, 2020 at 11:57:29PM +0300, Alexey Dobriyan wrote:
> > I don't anyone have been crazy enough to spawn 2^32 threads.
> > It'd require absurd amounts of physical memory,  and bump into futex pid
> > limit anyway.
> > 
> > Meanwhile save few bits on REX prefixes and some stack space for upcoming
> > print_integer() stuff.
> > 
> > And remove "extern" from prototypes while I'm at it.
> 
> It seems like there's a few more places to fix in this regard?
> 
> kernel/sched/fair.c:static u64 __sched_period(unsigned long nr_running)
> kernel/sched/sched.h:   unsigned long           dl_nr_running;
> kernel/sched/core.c:unsigned long nr_iowait_cpu(int cpu)
> kernel/sched/core.c:unsigned long nr_iowait(void)
> kernel/sched/loadavg.c: long nr_active, delta = 0;
> kernel/sched/sched.h:   unsigned long           rt_nr_migratory;
> kernel/sched/sched.h:   unsigned long           rt_nr_total;
> kernel/sched/sched.h:   unsigned long           rt_nr_boosted;
> kernel/sched/sched.h:   unsigned long           dl_nr_running;
> kernel/sched/sched.h:   unsigned long           dl_nr_migratory;
> kernel/sched/sched.h:   unsigned long           nr_uninterruptible;

Sure. I changed nr_running() and nr_iowait() because they're in format
strings in /proc as %lu.
