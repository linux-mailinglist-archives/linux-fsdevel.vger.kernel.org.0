Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09F27E4ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfHAVn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 17:43:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36662 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfHAVn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:43:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so32791336plt.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRJWWqPxe4v7OGh5SzFgwfV47CyOeIABo0H7U+M+pdg=;
        b=S/P5gz+a9jUw7SwOiz84JEbZSB3baAlVLSphUNs8eZlN3ZPowtpH0MpNodRchncDaL
         h/pwktm3ZoMM5ur9uIqRsyskaBqjhXhPvxaJG//b32Uphj0PG1ynA9CUTm1TW0sAsjm6
         HvrHFAepLSyokzes/1ht5wjMSnlrEgSRbO09yXW02SG1IbAd8mAQKhoiLKJYr6VkLWg+
         7rO55CqVAf6utB/oO5cCFpNjfcdHsW2PZ6e5nZCbdexwb5KuZDKGxSTHr3F16NHksaHQ
         xyoTxMhvtaSYfpReQiXJpspTpAAqnNeKDN71dNMH70NnoXLk5zU84jZ89voAQsdAyikW
         53ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRJWWqPxe4v7OGh5SzFgwfV47CyOeIABo0H7U+M+pdg=;
        b=eA8GN4QS2MivwPfoWlbA8q2ajM/g7GFVcTrMiALeCgbq6t7E6MWfj10vSkSmPQvOH/
         4V7IkpF8Ex89R1rKRfVKGuu1qNaH0iJrCmh2sj6qXGMiv5dHTNLceZ7IpDhHpHTD66o1
         QMJDxWfzX4Da7LVzZ4wQ90N4KAQKGyTtcS/IqwlZabznl2b0cqdqC6y+2U4QUTSMYnR/
         TBSqL6JimPx9zE0ad3Ossgqb4P5JYbt0x402jej0bMVouP+wAGLOcCi+Lq+Ah9dKst4v
         1pip8uEUs60VxUPVpT+srI9SPSnoqa4G0SGmRnJ2qgumWTbQGvQ+g6BzQv5rGq6OrVks
         9mXw==
X-Gm-Message-State: APjAAAVNIkbayH7msTWOE1BdioS4C1xTrQh956gMOLPqwdBwCk0q9BIl
        BKu3b8p5kpqUi7WmPr1UGwmc0czJHv+ZvNHdKcPCgQ==
X-Google-Smtp-Source: APXvYqyQJ3oYuIkR4HxnjqcvX8HB7OCTCVhJ4Fku+hNPqOUYjGToK6i2G0j1xWhCd4v39RwFH1V7C/0k5dVHTOnW45I=
X-Received: by 2002:a17:902:347:: with SMTP id 65mr32846391pld.232.1564695834770;
 Thu, 01 Aug 2019 14:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190716175021.9CA412173C@mail.kernel.org> <20190719000834.GA3228@google.com>
 <20190722200347.261D3218C9@mail.kernel.org> <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
 <20190722235411.06C1320840@mail.kernel.org> <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
 <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com>
 <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz> <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com>
 <CAFd5g473iFfvBnJs2pcwuJYgY+DpgD6RLzyDFL1otUuScgKUag@mail.gmail.com> <20190801211447.6D3D7206A2@mail.kernel.org>
In-Reply-To: <20190801211447.6D3D7206A2@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 1 Aug 2019 14:43:42 -0700
Message-ID: <CAFd5g47tk8x5iet=xfPVO6MphD3SsLtYQLrCi5O2h0bvdXwHtA@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>, Jeff Dike <jdike@addtoit.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Vetter <daniel@ffwll.ch>,
        Amir Goldstein <amir73il@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@google.com>,
        David Rientjes <rientjes@google.com>,
        kunit-dev@googlegroups.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        wfg@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Knut Omang <knut.omang@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        John Ogness <john.ogness@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 1, 2019 at 2:14 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-01 11:59:57)
> > On Thu, Aug 1, 2019 at 11:55 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Fri, Jul 26, 2019 at 1:31 AM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > > To be honest I do not fully understand KUnit design. I am not
> > > > completely sure how the tested code is isolated from the running
> > > > system. Namely, I do not know if the tested code shares
> > > > the same locks with the system running the test.
> > >
> > > No worries, I don't expect printk to be the hang up in those cases. It
> > > sounds like KUnit has a long way to evolve before printk is going to
> > > be a limitation.
> >
> > So Stephen, what do you think?
> >
> > Do you want me to go forward with the new kunit_assert API wrapping
> > the string_stream as I have it now? Would you prefer to punt this to a
> > later patch? Or would you prefer something else?
> >
>
> I like the struct based approach. If anything, it can be adjusted to
> make the code throw some records into a spinlock later on and delay the
> formatting of the assertion if need be.

That's a fair point.

> Can you resend with that
> approach? I don't think I'll have any more comments after that.

Cool, will do.

Thanks!
