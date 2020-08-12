Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A38242388
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 02:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHLAxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 20:53:54 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:53521 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgHLAxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:53:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 57EADB10;
        Tue, 11 Aug 2020 20:53:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Aug 2020 20:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        cPWWSWjp5+yRqK3+DqGTMH/lSARmGj5rks/w1/txg0w=; b=TQfG91XIX1ygqwLM
        4sfnV7xe4g4iEY5T2ZgoPGIvuSUQw+4Hf0WlavPnkJH899yiUIYsRzhXtEorXMX6
        JAjvuuyWT1VNZIPp5VFu+F/GckYHBFLgVBBlZX3enRz9VH6EXmkGNTuYIOF+Pfie
        N0Nc+c2F1+NDnBuqWPJZrMqWJcOSrBnnqHlWAYHiuaTQdT9c6JPPrReJyKqTh2zm
        No2QYEQU3HDNmmEoy/TTxJT8NjkMiNy7TnYqJSxosnnLuWRdzPKhyemSRNRdWOOX
        nJv1YGH8vIspNblClS2yjsYAnEuDv2lO8WXcUJOh1kj5w7MnPoVwFwYeRZ8fIj/K
        bsvHPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=cPWWSWjp5+yRqK3+DqGTMH/lSARmGj5rks/w1/txg
        0w=; b=GKFvGOVtMQ4f6ZSR6opBfHGjXI8/Gi3A9rXrmNwm17kxUUGeU/gCtQnQb
        wLMCvOJHSAJMdDPy/WOUoEYBESKjUUr4GrKdc2/d2uTtoVhOhqYs9EY65Xy2ZMUO
        Y8NBx/ctIdwH0H9DpWZet46rZr13YJby/IiCTlBYIQHDMaK0zOaTBxM+mCo2bCYg
        pHXAnI3K+nqlWKfqrESxED1CKyXKT+2gR/zo/upH3VBlDaWgQ8pUkpzGQBwWAHBH
        hoJXrRDIKWLWCQmMI/pm4/chCHou6osTKG0Kjdttd8wEHWZlv0b9Q8cTCHl1BK7a
        zqEnQqzoM+HB0wWq+tPKpw17f3Tdg==
X-ME-Sender: <xms:nz0zXzjMSOgJ2xYPBvOcU-Ha_7ok9jmXV1szTmzx9oAbUQylQwt_ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrledugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvddtfedruddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:nz0zXwBgD2ob41umt3OPIRxuqE-g0HsfHsGO8Ae0YGqbihrt08cUNQ>
    <xmx:nz0zXzE4LHDsOlcxqYR__fNM67Gt9hc6dTIOMjTlpFY0PrJeOvz26A>
    <xmx:nz0zXwRfXw2PKoUB9Y2MCwNnLb_YXNKnq7azqZl4ax9OitEysQiqTw>
    <xmx:nz0zX1q-mYvkP_QKgcFtn6lCIncYt0j7rJdpNseI8r85f0aJ5AKup7fACM4>
Received: from mickey.themaw.net (58-7-203-114.dyn.iinet.net.au [58.7.203.114])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4BC3F30600A6;
        Tue, 11 Aug 2020 20:53:45 -0400 (EDT)
Message-ID: <78ff6a85f5fc5f3e72f899728520a39b358b10c7.camel@themaw.net>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem
 Information)
From:   Ian Kent <raven@themaw.net>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Aug 2020 08:53:42 +0800
In-Reply-To: <20200811193916.zcwebstmbyvushau@wittgenstein>
References: <1842689.1596468469@warthog.procyon.org.uk>
         <1845353.1596469795@warthog.procyon.org.uk>
         <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
         <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
         <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
         <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
         <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
         <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
         <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
         <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
         <20200811193916.zcwebstmbyvushau@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-11 at 21:39 +0200, Christian Brauner wrote:
> On Tue, Aug 11, 2020 at 09:05:22AM -0700, Linus Torvalds wrote:
> > On Tue, Aug 11, 2020 at 8:30 AM Miklos Szeredi <miklos@szeredi.hu>
> > wrote:
> > > What's the disadvantage of doing it with a single lookup WITH an
> > > enabling flag?
> > > 
> > > It's definitely not going to break anything, so no backward
> > > compatibility issues whatsoever.
> > 
> > No backwards compatibility issues for existing programs, no.
> > 
> > But your suggestion is fundamentally ambiguous, and you most
> > definitely *can* hit that if people start using this in new
> > programs.
> > 
> > Where does that "unified" pathname come from? It will be generated
> > from "base filename + metadata name" in user space, and
> > 
> >  (a) the base filename might have double or triple slashes in it
> > for
> > whatever reasons.
> > 
> > This is not some "made-up gotcha" thing - I see double slashes
> > *all*
> > the time when we have things like Makefiles doing
> > 
> >     srctree=../../src/
> > 
> > and then people do "$(srctree)/". If you haven't seen that kind of
> > pattern where the pathname has two (or sometimes more!) slashes in
> > the
> > middle, you've led a very sheltered life.
> > 
> >  (b) even if the new user space were to think about that, and
> > remove
> > those (hah! when have you ever seen user space do that?), as Al
> > mentioned, the user *filesystem* might have pathnames with double
> > slashes as part of symlinks.
> > 
> > So now we'd have to make sure that when we traverse symlinks, that
> > O_ALT gets cleared. Which means that it's not a unified namespace
> > after all, because you can't make symlinks point to metadata.
> > 
> > Or we'd retroactively change the semantics of a symlink, and that
> > _is_
> > a backwards compatibility issue. Not with old software, no, but it
> > changes the meaning of old symlinks!
> > 
> > So no, I don't think a unified namespace ends up working.
> > 
> > And I say that as somebody who actually loves the concept. Ask Al:
> > I
> > have a few times pushed for "let's allow directory behavior on
> > regular
> > files", so that you could do things like a tar-filesystem, and
> > access
> > the contents of a tar-file by just doing
> > 
> >     cat my-file.tar/inside/the/archive.c
> > 
> > or similar.
> > 
> > Al has convinced me it's a horrible idea (and there you have a
> > non-ambiguous marker: the slash at the end of a pathname that
> > otherwise looks and acts as a non-directory)
> > 
> 
> Putting my kernel hat down, putting my userspace hat on.
> 
> I'm looking at this from a potential user of this interface.
> I'm not a huge fan of the metadata fd approach I'd much rather have a
> dedicated system call rather than opening a side-channel metadata fd
> that I can read binary data from. Maybe I'm alone in this but I was
> under the impression that other users including Ian, Lennart, and
> Karel
> have said on-list in some form that they would prefer this approach.
> There are even patches for systemd and libmount, I thought?

Not quite sure what you mean here.

Karel (with some contributions by me) has implemented the interfaces
for David's mount notifications and fsinfo() call in libmount. We
still have a little more to do on that.

I also have a systemd implementation that uses these libmount features
for mount table handling that works quite well, with a couple more
things to do to complete it, that Lennart has done an initial review
for.

It's no secret that I don't like the proc file system in general
but it is really useful for many things, that's just the way it
is.

Ian

