Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C7799816
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjIIMux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 08:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjIIMuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:50:51 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7185E40
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Sep 2023 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1694263842;
        bh=isEerib5SWvsMoxF1NbrZcLu/kLf4dgXjZGd4YKJlgg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=nL8SnV4o9dfrCSv7XQL3omOnB0AXNbL4zdztRMduss20ABtFLUi4gDbFb/r+fbvHX
         +PgRps33AHi9GYMGm/XnCXMimXf/qO8se1OxugtNq6l4ZvukgksfTWQAOxp0aQ1Qkm
         azOnlNod0VpUZXqoY1y7e5xTnPGtoamLdS6O8LVw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 189491288B4A;
        Sat,  9 Sep 2023 08:50:42 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ACRfUgCY5kQp; Sat,  9 Sep 2023 08:50:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1694263841;
        bh=isEerib5SWvsMoxF1NbrZcLu/kLf4dgXjZGd4YKJlgg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=u16KPGedeUzbkFfJHIMgiQAd30OmMeCS1hRvkAUZeVFaXNlu/AuoidOB7EuBsEf1w
         HYIzUbRZsWSQeVGs3CDQGaOic575KL35iIP9qyd/cAudiyoj8n9k0wBmb3J3w3AVw3
         aMZb+oaJdrqrlGR2A5lwGn6h2sd6LP24thgA1LBg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 132EB1288B49;
        Sat,  9 Sep 2023 08:50:40 -0400 (EDT)
Message-ID: <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Date:   Sat, 09 Sep 2023 08:50:39 -0400
In-Reply-To: <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
         <ZPe0bSW10Gj7rvAW@dread.disaster.area>
         <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-06 at 00:23 +0100, Matthew Wilcox wrote:
> On Wed, Sep 06, 2023 at 09:06:21AM +1000, Dave Chinner wrote:
[...]
> > > E.g. the hfsplus driver is unmaintained despite collecting odd
> > > fixes. It collects odd fixes because it is really useful for
> > > interoperating with MacOS and it would be a pity to remove it. 
> > > At the same time it is impossible to test changes to hfsplus
> > > sanely as there is no mkfs.hfsplus or fsck.hfsplus available for
> > > Linux.  We used to have one that was ported from the open source
> > > Darwin code drops, and I managed to get xfstests to run on
> > > hfsplus with them, but this old version doesn't compile on any
> > > modern Linux distribution and new versions of the code aren't
> > > trivially portable to Linux.
> > > 
> > > Do we have volunteers with old enough distros that we can list as
> > > testers for this code?  Do we have any other way to proceed?
> > > 
> > > If we don't, are we just going to untested API changes to these
> > > code bases, or keep the old APIs around forever?
> > 
> > We do slowly remove device drivers and platforms as the hardware,
> > developers and users disappear. We do also just change driver APIs
> > in device drivers for hardware that no-one is actually able to
> > test. The assumption is that if it gets broken during API changes,
> > someone who needs it to work will fix it and send patches.
> > 
> > That seems to be the historical model for removing unused/obsolete
> > code from the kernel, so why should we treat unmaintained/obsolete
> > filesystems any differently?  i.e. Just change the API, mark it
> > CONFIG_BROKEN until someone comes along and starts fixing it...
> 
> Umm.  If I change ->write_begin and ->write_end to take a folio,
> convert only the filesystems I can test via Luis' kdevops and mark
> the rest as CONFIG_BROKEN, I can guarantee you that Linus will reject
> that pull request.

I think really everyone in this debate needs to recognize two things:

   1. There are older systems out there that have an active group of
      maintainers and which depend on some of these older filesystems
   2. Data image archives will ipso facto be in older formats and
      preserving access to them is a historical necessity.

So the problem of what to do with older, less well maintained,
filesystems isn't one that can be solved by simply deleting them and we
have to figure out a way to move forward supporting them (obviously for
some value of the word "support"). 

By the way, people who think virtualization is the answer to this
should remember that virtual hardware is evolving just as fast as
physical hardware.

> I really feel we're between a rock and a hard place with our
> unmaintained filesystems.  They have users who care passionately, but
> not the ability to maintain them.

So why is everybody making this a hard either or? The volunteer
communities that grow around older things like filesystems are going to
be enthusiastic, but not really acquainted with the technical
intricacies of the modern VFS and mm. Requiring that they cope with all
the new stuff like iomap and folios is building an unbridgeable chasm
they're never going to cross. Give them an easier way and they might
get there.

So why can't we figure out that easier way? What's wrong with trying to
figure out if we can do some sort of helper or library set that assists
supporting and porting older filesystems. If we can do that it will not
only make the job of an old fs maintainer a lot easier, but it might
just provide the stepping stones we need to encourage more people climb
up into the modern VFS world.

I'd like to propose that we add to this topic discussion of mechanisms
by which we assist people taking on older filesystems to fit into the
modern world.

James

