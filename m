Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D4B55BF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 01:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFYXDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 19:03:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33866 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYXDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:03:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so264298plt.1;
        Tue, 25 Jun 2019 16:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K5ErWoFi/JRH3gFgmKoboUdo26AiFjxGcMAHhZYf05o=;
        b=G3+PFVxz/Ueu9IpY307Sscrf8TByxdIljL5dy6ohg3ye5EyQUzKMZHr6KWd0KMGfs+
         Qe5kmTvH6CwF8ocTmAQ1VhNDDqX10TOOMnLgTQPM/ArJlpmjHFBzZmiEcqg1wgDyvMp3
         IG9JAcIcFkC6epjYXSy/3qtNdwbs5/1Xs+dJ3M7t/rzgO5qwk7my4jZAlQ9b2tA9WSeE
         Gfy8ha+bUCQ89d0ha+suoYU3FmC1hAVwzMQR10F1Vpzk9K6LO2Ujx2q2pzV9a1ce9z6R
         hy7oLNUMIAZcxo42/S/8TDGLTNkOn/CZ7SvUgfLW1j3HO+MUnuB5PP0NqSy3mwQltZOb
         M7/A==
X-Gm-Message-State: APjAAAWtfKGR6p+32lpYOjoZHqzhoLbhxJa2nEgbTHFN3wRYw9RH7N6H
        ZAOmeYpK+y5YFa2zSRgr7gE=
X-Google-Smtp-Source: APXvYqz0M1IYGUwmvhT0NQpAoWP4ae2xshnXaqUSrqM3bOHQ06wFfedsHIaIBAncXtAoSDKV5lQq7Q==
X-Received: by 2002:a17:902:467:: with SMTP id 94mr1238634ple.131.1561503828687;
        Tue, 25 Jun 2019 16:03:48 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 10sm9969046pfb.30.2019.06.25.16.03.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 16:03:47 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BAAA5401EB; Tue, 25 Jun 2019 23:03:46 +0000 (UTC)
Date:   Tue, 25 Jun 2019 23:03:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Subject: Re: [PATCH v5 06/18] kbuild: enable building KUnit
Message-ID: <20190625230346.GR19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-7-brendanhiggins@google.com>
 <20190625221318.GO19023@42.do-not-panic.com>
 <CAFd5g448rYqr3PHg0cfoddr70nktkWXcRfJoZHmuPJjTW53YYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g448rYqr3PHg0cfoddr70nktkWXcRfJoZHmuPJjTW53YYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 03:41:29PM -0700, Brendan Higgins wrote:
> On Tue, Jun 25, 2019 at 3:13 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Jun 17, 2019 at 01:26:01AM -0700, Brendan Higgins wrote:
> > > diff --git a/Kconfig b/Kconfig
> > > index 48a80beab6853..10428501edb78 100644
> > > --- a/Kconfig
> > > +++ b/Kconfig
> > > @@ -30,3 +30,5 @@ source "crypto/Kconfig"
> > >  source "lib/Kconfig"
> > >
> > >  source "lib/Kconfig.debug"
> > > +
> > > +source "kunit/Kconfig"
> >
> > This patch would break compilation as kunit/Kconfig is not introduced. This
> > would would also break bisectability on this commit. This change should
> > either be folded in to the next patch, or just be a separate patch after
> > the next one.
> 
> Maybe my brain isn't working right now, but I am pretty darn sure that
> I introduce kunit/Kconfig in the very first patch of this series.
> Quoting from the change summary from the first commit:

Indeed, my mistake, thanks!

  Luis
