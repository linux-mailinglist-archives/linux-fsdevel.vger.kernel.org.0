Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50992502AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354051AbiDONeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 09:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354005AbiDONd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:33:58 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE29AC07A;
        Fri, 15 Apr 2022 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650029486;
        bh=WB5+gqhKBmXL4XWWl1q/CCSs3+c9rEipLl4naNYjVAk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Kb2zQPPsE3nrZw356730HYEuY0RVbFB2Ug6LcLKkpAyrzwCumA/WCwWNHoCeyQagi
         c0UUEncCNcMLTC4sw/pSheej9Yt8dpZQ5gUXFF+cyu9Jm/1J4iBf2f315PTjBo547P
         xxM77yWHH2UbRrX1no2iSGPgcC5I0OBzR008yZEA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C1F4E1287ACE;
        Fri, 15 Apr 2022 09:31:26 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kfEv0bp6Z-7e; Fri, 15 Apr 2022 09:31:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650029486;
        bh=WB5+gqhKBmXL4XWWl1q/CCSs3+c9rEipLl4naNYjVAk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Kb2zQPPsE3nrZw356730HYEuY0RVbFB2Ug6LcLKkpAyrzwCumA/WCwWNHoCeyQagi
         c0UUEncCNcMLTC4sw/pSheej9Yt8dpZQ5gUXFF+cyu9Jm/1J4iBf2f315PTjBo547P
         xxM77yWHH2UbRrX1no2iSGPgcC5I0OBzR008yZEA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E137312878DF;
        Fri, 15 Apr 2022 09:31:25 -0400 (EDT)
Message-ID: <df41ae9d0f02953cbfe9491f69247a8035f64562.camel@HansenPartnership.com>
Subject: Re: Fwd: Adding crates
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Chris Suter <chris@sutes.me>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Stappers <stappers@stappers.nl>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 15 Apr 2022 09:31:24 -0400
In-Reply-To: <20220330204353.57w3fxtaw4wwqvi3@moria.home.lan>
References: <CAKfU0DKvQYjhgiKN83+DZW3CQOkSEdQcy9nXUfFLVn1Uju6GkQ@mail.gmail.com>
         <CAKfU0DLS5icaFn0Mve6+y9Tn1vL+eLKqfquvXbX4oCpYH+VapQ@mail.gmail.com>
         <20220328054136.27mt2xdaltz4unby@gpm.stappers.nl>
         <CAKfU0D+gaC6s6kBBQ9OV+E9PFcm997efY-cUwP3bFWmuDDugbA@mail.gmail.com>
         <YkKXvnsvr0qz/pR2@kroah.com>
         <CAKfU0DLv3K7benXuofXqJwsgxUHA10bu8XWmyBZ0Z_PpZFMACg@mail.gmail.com>
         <CANiq72mrBpJm_6rjapicBoO_mkg4_hEpi9aRTAkj+gtiGkC3Aw@mail.gmail.com>
         <CAKfU0DJ1AqR4cy4=706qRGESozHii9dPL5BYQV047cZkyn3RzA@mail.gmail.com>
         <YkPdIMowqBsJORiK@kroah.com>
         <20220330204353.57w3fxtaw4wwqvi3@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[added cc to linux-fsdevel, since they've long grappled with this
problem]
On Wed, 2022-03-30 at 16:43 -0400, Kent Overstreet wrote:
> On Wed, Mar 30, 2022 at 06:31:28AM +0200, Greg KH wrote:
> > On Wed, Mar 30, 2022 at 11:03:50AM +1100, Chris Suter wrote:
> > > Hi Miguel,
> > > 
> > > On Wed, Mar 30, 2022 at 2:47 AM Miguel Ojeda
> > > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > > On Tue, Mar 29, 2022 at 9:49 AM Chris Suter <chris@sutes.me>
> > > > wrote:
> > > > > I'm interested in quite a few crates but the first and
> > > > > perhaps most significant would be futures. I'm not
> > > > > necessarily looking for a "generic" solution at this point,
> > > > > any solution would do — just enough to help me make a little
> > > > > progress and then maybe I could contribute back later. I can
> > > > > probably figure it out myself, but I was hoping to save some
> > > > > time.
> > > > 
> > > > If you are just looking to experiment with some third-party
> > > > crates, then as mentioned in the other thread, what you could
> > > > do is copy and adapt the code. For instance, if the crates you
> > > > need do not use Cargo build scripts, this may be as simple as
> > > > copying the sources of the Rust modules into your kernel module
> > > > (which is a crate), so that you do not need to deal with build
> > > > systems.
> > > 
> > > I'm working with an existing code base and there are quite a few
> > > crates I need to bring in or find replacements for. I'm hoping to
> > > minimise or isolate the changes I need to make to the existing
> > > code base. Obviously, some changes are going to be unavoidable.
> > 
> > What type of existing Rust codebase should be ported to be inside
> > the kernel?
> 
> Greg, I think your point of view made sense in the past, but the
> world is changing. We used to not want to share code between kernel
> space and userspace as much in the first place, and in C it has
> historically been impractical, but consider the following:
> 
>  - We already have large swaths of code being imported from userspace
> into the kernel as-is - e.g. zstd, and I bet I could find a lot more
> if I went digging.

Compression algorithms are somewhat "special".  The reference
implementation can often be imported as is with a few minor
modifications because if we're lucky it only really needs heap
alloc/free which we can provide.  The bigger problem is the use API. 
most compression algorithms eventually find themselves reimplemented in
many ways in many crypto systems even in userspace ... if zstd ever
gets standardized for compressed TLS, it will find itself wrappered in
openssl, for instance.  So, really, what the kernel is doing is no
different from what a lot of user space will do.

>    Right now we do this by just importing the code wholesale, but
> when changes end up needing to be applied for it to work in the
> kernel, this is a    maintenance nightmare when we then need to re-
> merge from upstream.

lib/zstd is ~300 lines of code, it's it doesn't seem to be that
difficult to maintain.  The bigger problem is that the "reference"
implementation is controlled by facebook and arbitrarily modified by
them to support their applications (Facebook isn't unique here, this
happens to a lot of reference implementations).  If you do a wc -l in
lib/ in the zstd repository it's ~74,000 lines.  So basically all we
care about is 0.4% of the supposed "reference" implementation.  Pulling
in the other 99.6% would serve no purpose other than to bloat our
attack surface, confuse the security analysis of the code and generate
a huge amount of static checking noise.

>    It would be far better to get the changes needed for use in the
> kernel merged  with upstream, and then just use upstream directly
> like any other package (with version pinning, so that when upstream
> changes, we review those changes before updating the version the
> kernel depends on).

As I already think I demonstrated, we don't want or need 99.4% of the
upstream ... most of the changes if you read the commit log are in API
areas the core compression algorithm doesn't change that much.  An even
bigger problem is a lot of that API surface uses C library interfaces
we don't support so we'd either have to grow pointless support or find
a way of stripping them anyway.

The point I'm making is that in its current form we really, really
don't want to sync with upstream.  It would be really great if upstream
maintained a usable core of pure compression algorithms that we could
sync with, but it currently doesn't.

The above is also the rust crate problem in miniature: the crates grow
API features the kernel will never care about and importing them
wholesale is going to take forever because of the internal kernel
support issue.  In the end, to take rust async as an example, it will
be much better to do for rust what we've done for zlib: take the core
that can support the kernel threading model and reimplement that in the
kernel crate.  The act of doing that will a) prove people care enough
about the functionality and b) allow us to refine it nicely.

I also don't think rust would really want to import crates wholesale. 
The reason for no_std is that rust is trying to adapt to embedded
environments, which the somewhat harsh constraints of the kernel is
very similar to.

>  And Rust's conditional    compilation & generics story is _much_
> better than what we've had in the past in C and C++, meaning writing
> Rust code that works in both userspace and kernelspace is much saner
> than in the past.
> 
>  - People are also starting to want to take kernel code and use it in
> userspace more often. In filesystem land, where I want, you need to
> do this or else you have massive duplication (& corresponding
> maintenance nightmare) between kernelspace and e.g. userspace fsck.
> In other areas, people just want to be able to write and run tests in
> userspace - e.g. xarrays, maple trees, and this is something we
> should encourage!

But the key point is if there were a reference core of just the bare
implementation separated from API wrappers, we could share it way more
easily.  It's not about having to import any old crap into the kernel,
it's about the maintainers of the reference implementation having to be
aware of all the possible uses of their code.

The counter example to everything you cite below is libxfs.  That's a
reference library that's shared between the xfs user space tools and
the kernel.  The point being that if you're willing to maintain just
the core of what you need in a style that's easily importable in
various environments, the task of importing it as the reference
implementation becomes easier.

>    But, when the kernel space & userspace environments are completely
> different, this is a massive undertaking. For bcachefs I had to write
> shim implementations for a _ton_ of code, most of which was quick and
> dirty  throwaway code that's a pain in the ass to work with and that
> I would really like to delete.
> 
> The solution to problems like these are to stop thinking that
> kernelspace and userspace _have_ to be completely different beasts -
> they really don't have to be! and start encouraging different
> thinking and tooling improvements that will make our lives easier.
> 
> In the kernel we also reinvent the wheel a _lot_ with our core data
> structures. Some of the stuff we have is awesome, some is... amazing
> in some ways but terrifying to have to deal with when it breaks
> (rhashtables, I'm looking at you), but often the glaringly obvious
> basic stuff is missing - why do we have nothing like CCAN darray?
> never mind, I finally just wrote one...
> 
> But code sharing for core data structures is finally starting to look
> tractable: kernel side GFP flags is getting deprecated in favour of
> memalloc_no*_save/restore (thank you Willy!) - that's a big one. And
> the Rust people, to their credit, have been taking seriously kernel
> land's needs to always check for memory allocation failure - Rust is
> explicitly targeted at bare metal, kernel stuff!
> 
> Anyways. Just try and keep an open mind...

I think the solution to the problem is to try to maintain highly mobile
reference implementations and also keep constantly considering what the
requirements are for mobility (both on the part of the reference
implementation and the kernel).  I also think that if we ever gave
impementors the magic ability just to dump any old code in the kernel,
they'd use it to take the lazy way out because it's a lot easier than
trying to keep the reference implementation separate.

The fact that most "reference" implementations don't conform to the
above isn't something we should be encouraging by supplying
compatibility APIs that paper over the problem and encourage API bloat.

James


