Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33E96DC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 01:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfHTXXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 19:23:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41577 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfHTXXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:23:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so236392pls.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgeboBXYdH2mwUYNdA3OBv6wqHBTlo9IT3Q8RNantq8=;
        b=Rni4clsu++7h96C43S+JbBXXkW3gKlVOYt85WpUO9PVUNOQAyZoV9ZeqzedJ1OVMFx
         8rIO1yErMiuPpLQ9sjtVMHG1jFX4fJklQ/PjHt12vwHBikcFbmL+JH4XebCtdX0yR6Ne
         /Ku/wtLkEaRcfVrBLNhoOWWl506znCj2wEM8/+jrC4flwkKt3STFQoP7x3bxbt5r7719
         hdp/sy/7uU7ZgdFgwJ1AO9EAvZQT6mQ9FyOhMFksTEDFwGUKQRR3mFtVrfEUr8Q5ksgi
         nF8kmhxSBCnQuM25k/D9rldBfN5XmkaaeL1KNxMPXXyinqbNL7GUBH09SVaM/WlOuE59
         VQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgeboBXYdH2mwUYNdA3OBv6wqHBTlo9IT3Q8RNantq8=;
        b=ZHEH6GjkfJYLnrfSP3S0cvadaLuBPoNtIZN7kZ0NxkfENtiAxB4e9wT5eTx7lSWsQ2
         tIXsrdOHZsbfuiP/q1cq9HpYFwLTAAf7Z2RAgoJJOOy78TW6pFn/j6PLX5/2lnPEKje5
         8CM9aCQOEc5qXn0+imZzGfBMp6zcSpSsd3xH1bieFceb+MHH8hMO1gFFYrCB9NrP47O6
         ZlMOMXXLDDpDHNvSUxuWFoYduqmxNrma9SERlv0ta7aOggXBTYNveSHoCqUrD9ksFpmA
         IX9vI1Wj8snqgeiGOrgImuW+tG6aoDWPxe7sgVSJfiIzhc2wwEohzieEcynL1nzBBCzL
         ISjA==
X-Gm-Message-State: APjAAAWBb93pqP4ZMaP6n+4O62lbOyBU6Vb78e3/UllUuBFxLTuWM8xX
        wrhwPeAffnMzXVts6AQ7eBaHDtP6MDXfIiFgs4EwFQ==
X-Google-Smtp-Source: APXvYqxXREKtyoSmqThzifpm0xupcZJncgCG4zF1cdnP+ZHsoxUg77sjBGnyRvdHt5/5lrCrktItt1lg4/mEcxF/N4g=
X-Received: by 2002:a17:902:7049:: with SMTP id h9mr31488817plt.232.1566343416854;
 Tue, 20 Aug 2019 16:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org> <20190820182450.GA38078@google.com>
 <e8eaf28e-75df-c966-809a-2e3631353cc9@kernel.org> <CAFd5g44JT_KQ+OxjVdG0qMWuaEB0Zq5x=r6tLsqJdncwZ_zbGA@mail.gmail.com>
In-Reply-To: <CAFd5g44JT_KQ+OxjVdG0qMWuaEB0Zq5x=r6tLsqJdncwZ_zbGA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 20 Aug 2019 16:23:25 -0700
Message-ID: <CAFd5g44aO40G7Wc-51EPyhWZgosN4ZHwwSjKe7CU_vi2OD7eKA@mail.gmail.com>
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 2:26 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Aug 20, 2019 at 12:08 PM shuah <shuah@kernel.org> wrote:
> >
> > On 8/20/19 12:24 PM, Brendan Higgins wrote:
> > > On Tue, Aug 20, 2019 at 11:24:45AM -0600, shuah wrote:
> > >> On 8/13/19 11:50 PM, Brendan Higgins wrote:
> > >>> ## TL;DR
> > >>>
> > >>> This revision addresses comments from Stephen and Bjorn Helgaas. Most
> > >>> changes are pretty minor stuff that doesn't affect the API in anyway.
> > >>> One significant change, however, is that I added support for freeing
> > >>> kunit_resource managed resources before the test case is finished via
> > >>> kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
> > >>> KUnit on certain configurations (like the default one for x86, whoops).
> > >>>
> > >>> Based on Stephen's feedback on the previous change, I think we are
> > >>> pretty close. I am not expecting any significant changes from here on
> > >>> out.
> > >>>
> > >>
> > >> Hi Brendan,
> > >>
> > >> I found checkpatch errors in one or two patches. Can you fix those and
> > >> send v14.
> > >
> > > Hi Shuah,
> > >
> > > Are you refering to the following errors?
> > >
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > #144: FILE: include/kunit/test.h:456:
> > > +#define KUNIT_BINARY_CLASS \
> > > +       kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT
> > >
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > #146: FILE: include/kunit/test.h:458:
> > > +#define KUNIT_BINARY_PTR_CLASS \
> > > +       kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT
> > >
> > > These values should *not* be in parentheses. I am guessing checkpatch is
> > > getting confused and thinks that these are complex expressions, when
> > > they are not.
> > >
> > > I ignored the errors since I figured checkpatch was complaining
> > > erroneously.
> > >
> > > I could refactor the code to remove these macros entirely, but I think
> > > the code is cleaner with them.
> > >
> >
> > Please do. I am not veru sure what value these macros add.
>
> Alright, I will have something for you later today.

I just sent a new revision with the fix.

Cheers
