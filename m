Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444A17514D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 01:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjGLX5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 19:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjGLX5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:57:41 -0400
Received: from out-37.mta0.migadu.com (out-37.mta0.migadu.com [IPv6:2001:41d0:1004:224b::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7461FCC
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 16:57:39 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689206257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ntdiH/9sZyPkX/RAlGtOauWZ/h52hcGnhVXlBm1OLYc=;
        b=FaqRzEurnql+rDFATLUYd/x9WAFOzSdHEuehQScMYfjIAqc3d1FAiOHkdy47VU+Nv5Y0w8
        kiTq+YqHDxKpNWR26v0707KjUtWeTjYjOBEXpkdds2y0JqiDQhYpNi2qRCmtzCBPpPrctC
        ws/HVv/J5q+UyVNpXv1b3bYgCRzSFAU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230712235731.l47sxuhfeonygciv@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <20230712221012.GA11431@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712221012.GA11431@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:10:12PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 11, 2023 at 10:54:59PM -0400, Kent Overstreet wrote:
> >  - Also: not directly related to upstreaming, but relevant for the
> >    community: we talked about getting together a meeting with some of
> >    the btrfs people to gather design input, ideas, and lessons learned.
> 
> Please invite me too! :)
> 
> Granted XFS doesn't do multi-device support (for large values of
> 'multi') but now that I've spent 6 years of my life concentrating on
> repairability for XFS, I might have a few things to say about bcachefs.

Absolutely!

Maybe we could start brainstorming ideas to cover now, on the list? I
honestly know XFS so little (I've read code here and there, but I don't
know much about the high level structure) that I wouldn't know where to
start.

Filesystems are such a huge world of "oh, that would've made my life so
much easier if I'd had that idea at the right time..."

> That is if I can shake off the torrent of syzbot crap long enough to
> read anything in bcachefs.git. :(

:(
