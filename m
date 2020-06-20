Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7283B202266
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgFTHo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgFTHoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:44:25 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C01C06174E;
        Sat, 20 Jun 2020 00:44:25 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so13877745iow.8;
        Sat, 20 Jun 2020 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=R3DIeUaXv04N92HP3WFMAv9JRTr9DLfjsPtXt3CI6Tc=;
        b=I3udPM4LUAU735jznatS8AR+IH1rD5XL+ktc1ev9knbyqIMQJhEzVB6x0+U0GN1M+P
         Sg6NvO1I/0YxOmZI0K71uARUW7eicLqpyZw83s8x4Dg+1wyz/0tt7gmkY3LKY1xXA6U+
         qvnr+ZJyeJ1P/BnrHiV+G5QeGSqqcFkaLXeLGunIBUKnYLo1YhK9icEifr/zEJVCi0r1
         DJJwYIF0K7WrZx0TfnpbYqqAJS1k9Ph3Y0qyX/10Pe+n87gndkzGY/qVURatAeMTxtPL
         z/1kuOFWZnIpVSFgKHpUfX8K8zJjFAtq6jTu9P9bonNQBvYiSassIA165oRfGI9RNbgU
         Zthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=R3DIeUaXv04N92HP3WFMAv9JRTr9DLfjsPtXt3CI6Tc=;
        b=eiLtur44kS9S1IKvN25MVxmQfT6ntLBworXgp5Pfc2EY9n44ZYopnCK1V4MRU+vmzU
         WztRG+OEjsZxt2BnRgQ9UZ5E47ryXDeaFg30uM2WHVCFS/+hKVa18GkQv3K3MMqu2z37
         w2s+CCP+0WPduo0WeRop+/Sz3a4kjRV49yMLcusQpiq6eo/cyCxNy/m9RDz1ZN3fUyFf
         uTu9cjEQ6QDDHnv5V8sD8Ocfp9FCeEJM05mDGhEw8Tp3xBH+MzaaTmLAPMaau23jmO/c
         U7lMl4ir4OoE+EeZQeniJjRTIllr2lSLeVjrsTkTigT9cgYFP7I0nniTUQp8jhpu0es6
         d66g==
X-Gm-Message-State: AOAM531xsRRuD5QU4tEr1lfQd+dnc2rdi/doRTRi3G6H5N4mp1kJX2CD
        iSF3AZdoeBmOzNhbtuZJNyqwV1P2ACN6ug50kro=
X-Google-Smtp-Source: ABdhPJxT6aTrvzVXVZfaZQXlxk5xLyxN6TlYGQxy8b2/fW7uWBZtuTtwPl4kSlc6YmqQt4b54+St+in2RtL5E3TUfM4=
X-Received: by 2002:a05:6602:2dca:: with SMTP id l10mr8269728iow.163.1592639064282;
 Sat, 20 Jun 2020 00:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <a1bafab884bb60250840a8721b78f4b5d3a6c2ed.camel@intel.com>
 <20200619010513.GW8681@bombadil.infradead.org> <bf968a2887536459293eaeb40d354fb365b1438d.camel@intel.com>
In-Reply-To: <bf968a2887536459293eaeb40d354fb365b1438d.camel@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 20 Jun 2020 09:44:12 +0200
Message-ID: <CA+icZUWTTdR42atb9FNYa90wwuvfFngksBWJBn2BLarkJsztxA@mail.gmail.com>
Subject: Re: Parallel compilation performance regression
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 5:53 AM Derrick, Jonathan
<jonathan.derrick@intel.com> wrote:
>
> On Thu, 2020-06-18 at 18:05 -0700, Matthew Wilcox wrote:
> > On Thu, Jun 18, 2020 at 11:52:55PM +0000, Derrick, Jonathan wrote:
> > > Hi David,
> > >
> > > I've been experiencing a performance regression when running a parallel
> > > compilation (eg, make -j72) on recent kernels.
> >
> > I bet you're using a version of make which predates 4.3:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ddad21d3e99c743a3aa473121dc5561679e26bb
> >
>
> I am!
>
> # make --version
> GNU Make 4.2.1
>
>
> Thank you Matthew!

Check your distribution and included patches on top of a vanilla make v4.2.
Debian had some important ones I described in [1].

When proposing "make version 4.3" for tc-build - an opportunity to
build a llvm-toolchain the easy way - we saw different numbers.
I pointed in [1] to the Linus patch Matthew did here.

Personally, with switching to Debian's make version 4.3-3 I have seen
no big differences when using "make -j3" to build Linux v5.7+.
That might be different with "make -j72"...
...can I have SSH access to this machine, please :-),

You forgot to tell which Linux version you use.

If you are interested please look at closed tc-build issue #72 for our analysis.
For tc-build it did not matter - (Debian's) make v4.2 had some
slightly better performance.

BTW, with that pipe improvements in Linux v5.7 I see some better
numbers when using pipebench to benchmark my devices:

Example: SanDisk iSSD 16GB

root# cat /dev/sdb | pipebench > /dev/null
Summary:
Piped   14.91 GB in 00h01m25.20s:  179.23 MB/second

Before: approx. 100MB/s

BTW, I heard of hyperfine benchmark tool the first time when dealing
with make performance (see [2]) in ClangBuiltLinux.
I would like to see some benchmark numbers with hyperfine from you if
you do not mind.

Stay OPEN minded and curious.

Thanks.

- Sedat -

[1] https://github.com/ClangBuiltLinux/tc-build/issues/72
[2] https://github.com/sharkdp/hyperfine
[3] https://github.com/sharkdp/hyperfine/releases
