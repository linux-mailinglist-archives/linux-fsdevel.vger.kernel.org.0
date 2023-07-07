Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D074A8BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 04:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGGCFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 22:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGGCFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:05:23 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9BC1FC4
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 19:05:22 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-26-156-107.bstnma.fios.verizon.net [108.26.156.107])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36724dQa006186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 22:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688695484; bh=TsNvuPyUlL4Y8qN5hDRwSDMRTqYJrjD+Crx5PjiM7RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=llAFptV0qus49wG9N9aii4eNOKcqrXwVjpnI1N2cKbafVw4DSo5wumqZHKa8iwbvP
         8lxGmujROmsufDc364Ddv7gM9ebx71J+3CemcGOFwhyi2nG00fKxuR3Hye3C+EWcBC
         8H+Yw9vmC6QMwl2CqpcUrn53eNsjmzfxH8RKMAZcRDWmCOkmHzIBPHgWXoIfHN8817
         V4JXv5mkGrCt+XZmwui2KGFH3fag1jyDyvrL9kkF2ghRnPg6RuvKIAevSTdJI+AH77
         Vqx4Z4SILF7Oji89JZDoxRBfGfTsgOUOl/BE3hqLVRx1ycLLx2rymWFuLf1uXNHyhX
         E1QbjSr2iuvmw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9914215C0294; Thu,  6 Jul 2023 22:04:39 -0400 (EDT)
Date:   Thu, 6 Jul 2023 22:04:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Josef Bacik <josef@toxicpanda.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        bfoster@redhat.com, jack@suse.cz, andreas.gruenbacher@gmail.com,
        brauner@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230707020439.GM1178919@mit.edu>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 01:38:19PM -0400, Kent Overstreet wrote:
> You, the btrfs developers, got started when Linux filesystem teams were
> quite a bit bigger than they are now: I was at Google when Google had a
> bunch of people working on ext4, and that was when ZFS had recently come
> out and there was recognition that Linux needed an answer to ZFS and you
> were able to ride that excitement. It's been a bit harder for me to get
> something equally ambitions going, to be honest.

Just to set the historical record straight, I think you're mixing up
two stories here.

*Btrfs* was started while I was at the IBM Linux Technology Center,
and it was because there were folks from more than one companies that
were concerned that there needed to be an answer to ZFS.  IBM hosted
that meeting, but ultimately, never did contribute any developers to
the btrfs effort.  That's because IBM had a fairly cold, hard
examination of what their enterprise customers really wanted, and
would be willing to pay $$$, and the decision was made at a corporate
level (higher up than the Linux Technology Center, although I
participated in the company-wide investigation) that *none* of OS's
that IBM supported (AIX, zOS, Linux, etc.) needed ZFS-like features,
because IBM's customers didn't need them.  The vast majority of what
paying customers' workloads at the time was to run things like
Websphere, and Oracle and DB/2, and these did not need fancy
snapshots.  And things like integrity could be provided at other
layers of the storage stack.

As far as Google was concerned, yes, we had several software engineers
working on ext4, but it had nothing to do with ZFS.  We had a solid
business case for how replacing ext2 with ext4 (in nojournal mode,
since the cluster file system handled data integrity and crash
recovery) would save the company $XXX millions of dollars in storage
TCO (total cost of ownership) dollars per year.

In any case, at neither company was a "sense of excitement" something
which drove the technical decisions.  It was all about Return on
Investment (ROI).  As such, that's driven my bias towards ext4
maintenance.

I view part of my job is finding matches between interesting file
system features that I would find technically interesting, and which
would benefit the general ext4 user base, and specific business cases
that would encourage the investment of several developers on file
system technologies.

Things like case insensitive file names, fscrypt, fsverity, etc.,
where all started *after* I had found a business case that would
interest one or more companies or divisions inside Google to put
people on the project.  Smaller projects can get funded on the
margins, sure.  But for anything big, that might require the focused
attention of one or more developers for a quarter or more, I generally
find the business case first, and often, that will inform the
requirements for the feature.  In other words, not only am I ext4's
maintainer, I'm also its product manager.

Of course, this is not the only way you can drive technology forward.
For example, at Sun Microsystems, ZFS was driven just by the techies,
and initially, they hid the fact that the project was taking place,
not asking the opinion of the finance and sales teams.  And so ZFS had
quite a lot of very innovative technologies that pushed the industry
forward, including inspiring btrfs.  Of course, Sun Microsystems
didn't do all that well financially, until they were forced to sell
themselves to the highest bidder.  So perhaps, it might be that this
particular model is one that other companies, including IBM, Red Hat,
Microsoft, Oracle, Facebook, etc., might choose to avoid emulating.

Cheers,

					- Ted
