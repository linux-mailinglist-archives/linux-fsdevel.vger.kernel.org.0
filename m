Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9883CCC643
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 01:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfJDXKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 19:10:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46814 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbfJDXKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so3789693plr.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tysgl1R46fdU3OksVKZHpW9zLqbqvPnl2oWqc0PQOqg=;
        b=oPja2LZ+ZjzWwIIgczPMTwtg+FNGcSbm7xxAV/JCINpx/yp1vQ08IQzQiHGs4wRyly
         YbCXc4ZHHHV54r6XkfIGN2kCtHFVjwM+le57/4du+XEYDcy5wbcSN0nM+dJDI0b12LcX
         ZikwBUxxg3PiGd3obfKj/XNiIWOlooyLyOV9DjUwS3qE50KzPo9cDH1z7dSJIljdr/Z7
         tZQByU/xEELr2sdcAOpmxavLs2sFF6O48uaUgeMrxepiwS44UUpA/LYAKV5RslwaYo6g
         n/2r9eiMcS73JaD7vmFn8z6h6xmtSUZ7znleGhm4+7S7T8FLqi/xStUsiRfiN3NRdDY9
         6J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tysgl1R46fdU3OksVKZHpW9zLqbqvPnl2oWqc0PQOqg=;
        b=B490JrTNXveHZ5OaexTFMoI2MW5CF04Y3NUp+cJM/Qcv2Tn4wa+KsM9qAS/aOC1b3p
         4qhjOCSvtSaUfL6W9+9kZ1rKN7i35Qqom5IKyn6NltX4iBTI4kTPLgD/ZCuZRZxJQcfI
         Pq76+inuysZnOwiqoAyA/L8NgJRRBgaLaneHnj8noHl5TgKnXYmo/r9Kuj+Et6RagLe9
         uhxEb53TlGRaGD63E9buPYaqZYTcigPhbBzolfGdwzfLhD+w2xPJb+lA8XCIf/74jZpX
         ePRUYzr+iqvzoYU1qDCQUTxhTtI0XzBreFUWydTHKffAmI2zoV3xaks+m02roxBecgJm
         CtWg==
X-Gm-Message-State: APjAAAWTh3Pdyf8zlAMFik9Pr9RbdALupVTdm83rjve6LiT3R5R6Av3i
        oeIMjUmlPyRxgtGsKBXTIeExgy1oTtr9wUam50I7oA==
X-Google-Smtp-Source: APXvYqy2qn5i4A0WcBwjew4hCMmMwzQqLgVpE7PF0Xq4XlJnxlfT1jMDjTbCtnSFUQdVesOmn5ze08RzDHkU7ftVGYQ=
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr18021468plj.325.1570230641399;
 Fri, 04 Oct 2019 16:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu> <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
In-Reply-To: <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 4 Oct 2019 16:10:30 -0700
Message-ID: <CAFd5g46pzu=Bh5X7-ttfhTP+NYNDCAxN16OCGFxc5ohjTL-v0g@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     shuah <shuah@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 4, 2019 at 3:47 PM shuah <shuah@kernel.org> wrote:
>
> On 10/4/19 4:27 PM, Brendan Higgins wrote:
> > On Fri, Oct 04, 2019 at 03:59:10PM -0600, shuah wrote:
> >> On 10/4/19 3:42 PM, Linus Torvalds wrote:
> >>> On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >>>>
> >>>> This question is primarily directed at Shuah and Linus....
> >>>>
> >>>> What's the current status of the kunit series now that Brendan has
> >>>> moved it out of the top-level kunit directory as Linus has requested?
> >>>
> >>
> >> The move happened smack in the middle of merge window and landed in
> >> linux-next towards the end of the merge window.
> >>
> >>> We seemed to decide to just wait for 5.5, but there is nothing that
> >>> looks to block that. And I encouraged Shuah to find more kunit cases
> >>> for when it _does_ get merged.
> >>>
> >>
> >> Right. I communicated that to Brendan that we could work on adding more
> >> kunit based tests which would help get more mileage on the kunit.
> >>
> >>> So if the kunit branch is stable, and people want to start using it
> >>> for their unit tests, then I think that would be a good idea, and then
> >>> during the 5.5 merge window we'll not just get the infrastructure,
> >>> we'll get a few more users too and not just examples.
> >
> > I was planning on holding off on accepting more tests/changes until
> > KUnit is in torvalds/master. As much as I would like to go around
> > promoting it, I don't really want to promote too much complexity in a
> > non-upstream branch before getting it upstream because I don't want to
> > risk adding something that might cause it to get rejected again.
> >
> > To be clear, I can understand from your perspective why getting more
> > tests/usage before accepting it is a good thing. The more people that
> > play around with it, the more likely that someone will find an issue
> > with it, and more likely that what is accepted into torvalds/master is
> > of high quality.
> >
> > However, if I encourage arbitrary tests/improvements into my KUnit
> > branch, it further diverges away from torvalds/master, and is more
> > likely that there will be a merge conflict or issue that is not related
> > to the core KUnit changes that will cause the whole thing to be
> > rejected again in v5.5.
> >
>
> The idea is that the new development will happen based on kunit in
> linux-kselftest next. It will work just fine. As we accepts patches,
> they will go on top of kunit that is in linux-next now.

But then wouldn't we want to limit what KUnit changes are going into
linux-kselftest next for v5.5? For example, we probably don't want to
do anymore feature development on it until it is in v5.5, since the
goal is to make it more stable, right?

I am guessing that it will probably be fine, but it still sounds like
we need to establish some ground rules, and play it *very* safe.
