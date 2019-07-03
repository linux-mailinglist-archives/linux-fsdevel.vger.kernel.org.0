Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858595EFB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 01:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGCXlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 19:41:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33853 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfGCXlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:41:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so1985162pgn.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2019 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVKYoZ7M1neTWMWNkSfarm1kLLkAZh2a4u3Pqo3SzOU=;
        b=OWhUfNT+x+l9tKNcHcOr8kuP2qdhGyE+B0e411zUg/nxqHy1v3vbklBPjWBIPWd1+X
         lw5aHflM74n2xt/OAAiQhlNPGrSQVQRa+4MjJybCNy2xt94ieU8axV/bh19o4WGfWzwW
         bc7SeBseK2dfjfJAMouw6pY81wBVOyVQijUmOr6rIyxetCcz2tD+r9Vrdt1IxtPYRepK
         Nbi/7inGd9MhBPjN3BDpD4xzbLxIX311D6atZ8neX7oEcRDtH4k/c+3mNfaUqCqIHwqh
         gffewpeSSQuFiFnvGzd3H0SEAPr2VegAZ8NlEv0Yl6KNzakq7kQ12TioJjvvu6bdkP5c
         sjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVKYoZ7M1neTWMWNkSfarm1kLLkAZh2a4u3Pqo3SzOU=;
        b=NyfIpih1fKF/qJJcsBwGOIEfWqXpfwDaBIDjund229JjxfMZl7Au7XmEOB9TUL8b+W
         ZzPV6UHpiVkglOL2Pv2zTOTKl1u/XFKvVWj0oIkBNKDQjJNdB55/qyTBm5dLq6SHjiiA
         cGYDP47J3lbP/I9DvX7Q9bU9YZtL5JxgDjQJvG/yvlrcPF9OEQY96BSZAUp0Kjw8uxh3
         0TYcuD7Gb7yNYJ+7rNTbS7I69FJlHWBLY0dArjjmnl+y509iHaWpj8mcxjbF0Sq5euet
         Tn7AsPNPvtQultKZhyZbWgCBNkDfw5ZHWc/2KWx+2NFLU4/1fL8iRScR9IUTRxPeoQ0o
         AVoA==
X-Gm-Message-State: APjAAAXSxZh/x7xkZpY2kGCgqM98bKwj4OR2EusW8Ul7iby38BtyaGx+
        5EGw1FUqNjGi6F7xPv5q0KLfB/M75vnab8/I7LgdMQ==
X-Google-Smtp-Source: APXvYqwXB8g3qJfj0dB5mvs+S7ESPDvYCMhtPXvQDa6QHJcnwrHQejsvEjyf5gqWIAbwtcABAn5rOnSpZi2/GaX3pAc=
X-Received: by 2002:a63:b919:: with SMTP id z25mr39509300pge.201.1562197262480;
 Wed, 03 Jul 2019 16:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com> <69809117-dcda-160a-ee0a-d1d3b4c5cd8a@kernel.org>
 <20190621181342.GA17166@mit.edu> <6f3f5184-d14e-1b46-17f1-391ee67e699c@kernel.org>
 <CAFd5g46W1u+6JKLW0WX9uicK5utvJe9tvq4YBsCkghuo0rCmng@mail.gmail.com>
In-Reply-To: <CAFd5g46W1u+6JKLW0WX9uicK5utvJe9tvq4YBsCkghuo0rCmng@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 3 Jul 2019 16:40:50 -0700
Message-ID: <CAFd5g4515jAOzEtiZfXP0d6YUgOxOZCknw0Nd-2wsY=mPFdGqg@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     shuah <shuah@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 21, 2019 at 5:54 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jun 21, 2019 at 12:21 PM shuah <shuah@kernel.org> wrote:
> >
> > On 6/21/19 12:13 PM, Theodore Ts'o wrote:
> > > On Fri, Jun 21, 2019 at 08:59:48AM -0600, shuah wrote:
> > >>>> ### But wait! Doesn't kselftest support in kernel testing?!
> > >>>>
> > >>>> ....
> > >>
> > >> I think I commented on this before. I agree with the statement that
> > >> there is no overlap between Kselftest and KUnit. I would like see this
> > >> removed. Kselftest module support supports use-cases KUnit won't be able
> > >> to. I can build an kernel with Kselftest test modules and use it in the
> > >> filed to load and run tests if I need to debug a problem and get data
> > >> from a system. I can't do that with KUnit.
>
> Sure, I think this point has been brought up a number of times before.
> Maybe I didn't write this section well because, like Frank said, it
> comes across as being critical of the Kselftest module support; that
> wasn't my intention. I was speaking from the perspective that
> Kselftest module support is just a feature of Kselftest, and not a
> full framework like KUnit is (obviously Kselftest itself *is* a
> framework, but a very small part of it is not).
>
> It was obvious to me what Kselftest module support was intended for,
> and it is not intended to cover the use case that KUnit is targeting.
>
> > >> In my mind, I am not viewing this as which is better. Kselftest and
> > >> KUnit both have their place in the kernel development process. It isn't
> > >> productive and/or necessary to comparing Kselftest and KUnit without a
> > >> good understanding of the problem spaces for each of these.
>
> Again, I didn't mean to draw a comparison of which is better than the
> other. I was just trying to point out that Kselftest module support
> doesn't make sense as a stand alone unit testing framework, or really
> a framework of any kind, despite how it might actually be used.
>
> > >> I would strongly recommend not making reference to Kselftest and talk
> > >> about what KUnit offers.
>
> I can see your point. It seems that both you and Frank seem to think
> that I drew a comparison between Kselftest and KUnit, which was
> unintended. I probably should have spent more time editing this
> section, but I can see the point of drawing the comparison itself
> might invite this confusion.
>
> > > Shuah,
> > >
> > > Just to recall the history, this section of the FAQ was added to rebut
> > > the ***very*** strong statements that Frank made that there was
> > > overlap between Kselftest and Kunit, and that having too many ways for
> > > kernel developers to do the identical thing was harmful (he said it
> > > was too much of a burden on a kernel developer) --- and this was an
> > > argument for not including Kunit in the upstream kernel.
>
> I don't think he was actually advocating that we don't include KUnit,
> maybe playing devil's advocate; nevertheless, at the end, Frank seemed
> to agree that there were valuable things that KUnit offered. I thought
> he just wanted to make the point that I hadn't made the distinction
> sufficiently clear in the cover letter, and other reviewers might get
> confused in the future as well.
>
> Additionally, it does look like people were trying to use Kselftest
> module support to cover some things which really were trying to be
> unit tests. I know this isn't really intended - everything looks like
> a nail when you only have a hammer, which I think Frank was pointing
> out furthers the above confusion.
>
> In anycase, it sounds like I have, if anything, only made the
> discussion even more confusing by adding this section; sorry about
> that.
>
> > > If we're past that objection, then perhaps this section can be
> > > dropped, but there's a very good reason why it was there.  I wouldn't
> > > Brendan to be accused of ignoring feedback from those who reviewed his
> > > patches.   :-)
> > >
> >
> > Agreed. I understand that this FAQ probably was needed at one time and
> > Brendan added it to address the concerns.
>
> I don't want to speak for Frank, but I don't think it was an objection
> to KUnit itself, but rather an objection to not sufficiently
> addressing the point about how they differ.
>
> > I think at some point we do need to have a document that outlines when
> > to KUnit and when to use Kselftest modules. I think one concern people
> > have is that if KUnit is perceived as a  replacement for Ksefltest
> > module, Kselftest module will be ignored leaving users without the
> > ability to build and run with Kselftest modules and load them on a need
> > basis to gather data on a systems that aren't dedicated strictly for
> > testing.
>
> I absolutely agree! I posed a suggestion here[1], which after I just
> now searched for a link, I realize for some reason it didn't seem like
> it reached a number of the mailing lists that I sent it to, so I
> should probably resend it.
>
> Anyway, a summary of what I suggested: We should start off by better
> organizing Documentation/dev-tools/ and create a landing page that
> groups the dev-tools by function according to what person is likely to
> use them and for what. Eventually and specifically for Kselftest and
> KUnit, I would like to have a testing guide for the kernel that
> explains what testing procedure should look like and what to use and
> when.
>
> > I am trying to move the conversation forward from KUnit vs. Kselftest
> > modules discussion to which problem areas each one addresses keeping
> > in mind that it is not about which is better. Kselftest and KUnit both
> > have their place in the kernel development process. We just have to be
> > clear on usage as we write tests for each.
>
> I think that is the right long term approach. I think a good place to
> start, like I suggested above, is cleaning up
> Documentation/dev-tools/, but I think that belongs in a (probably
> several) follow-up patchset.
>
> Frank, I believe your objection was mostly related to how KUnit is
> presented specifically in the cover letter, and doesn't necessarily
> deal with the intended use case. So I don't think that doing this,
> especially doing this later, really addresses your concern. I don't
> want to belabor the issue, but I would also rather not put words in
> your mouth, what are your thoughts on the above?
>
> I think my main concern moving forward on this point is that I am not
> sure that I can address the debate that this section covers in a way
> that is both sufficiently concise for a cover letter, but also doesn't
> invite more potential confusion. My inclination at this point is to
> drop it since I think the set of reviewers for this patchset has at
> this point become fixed, and it seems that it will likely cause more
> confusion rather than reduce it; also, I don't really think this will

Since no one has objected to dropping the "### But wait! Doesn't
kselftest support in kernel testing?!" section in the past almost two
weeks, I am just going to continue on without it.

Cheers

> be an issue for end users, especially once we have proper
> documentation in place. Alternatively, I guess I could maybe address
> the point elsewhere and refer to it in the cover letter? Or maybe just
> put it at the end of the cover letter?
>
> [1] https://www.mail-archive.com/kgdb-bugreport@lists.sourceforge.net/msg05059.html
