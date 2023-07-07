Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDC74B584
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 19:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjGGRE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGGRE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:04:28 -0400
X-Greylist: delayed 2277 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jul 2023 10:04:25 PDT
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D6213B;
        Fri,  7 Jul 2023 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688749460;
        bh=21VLDhi85H/fUtYk9/1oxFtVp3WxHwXrr9P/axAY0Ow=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YZbt81N6y3eV9qkum3yBaZ0T5LD5yHbh6YptmqONlv3PtxuTTT2OMHbVEXNj79Jx8
         d3CMQL6T5D6wDVZMBHdqgEN/HggnZYxmRC5ekM46ZEUyZQ7rzjTBypT/Z8Dc+ofak6
         JnM+0z7vUjl78e9z77PjZKfZCUur2E88xlqcl1q4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 588F912861BE;
        Fri,  7 Jul 2023 13:04:20 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id DjaEFW3jjPpi; Fri,  7 Jul 2023 13:04:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688749457;
        bh=21VLDhi85H/fUtYk9/1oxFtVp3WxHwXrr9P/axAY0Ow=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=a1EZjGONOEij2LOuHroG4+TxPYEXzx0RsLu8/Yl3LgmNbE/OWHQr9v4ksTRXZyIoV
         LBYT9SSEcJad1F1r9KKiX9/yV4/lSKPYSCDjcQULu1+A7lwK6iGlSqVbRT/ZDmlGvx
         VpXri+7pkAD5fiKXPY2jLTOHMReXC9yk3POFgBZM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C7B5E1285F14;
        Fri,  7 Jul 2023 13:04:15 -0400 (EDT)
Message-ID: <85ec096ee90e3d62ebb496b3faeb4dce25e3deab.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] bcachefs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Date:   Fri, 07 Jul 2023 13:04:14 -0400
In-Reply-To: <20230707164808.nisoh3ia4xkdgjj3@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
         <20230706155602.mnhsylo3pnief2of@moria.home.lan>
         <20230706164055.GA2306489@perftesting>
         <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
         <20230706211914.GB11476@frogsfrogsfrogs>
         <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
         <20230707091810.bamrvzcif7ncng46@moria.home.lan>
         <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
         <20230707164808.nisoh3ia4xkdgjj3@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-07-07 at 12:48 -0400, Kent Overstreet wrote:
> On Fri, Jul 07, 2023 at 12:26:19PM -0400, James Bottomley wrote:
> > On Fri, 2023-07-07 at 05:18 -0400, Kent Overstreet wrote:
[...]
> > > In that offlist thread, I don't recall much in the way of actual,
> > > concrete concerns. I do recall Christoph doing his usual schpiel;
> > > and to be clear, I cut short my interactions with Christoph
> > > because in nearly 15 years of kernel development he's never been
> > > anything but hostile to anything I've posted, and the criticisms
> > > he posts tend to be vague and unaware of the surrounding
> > > discussion, not anything actionable.
> > 
> > This too is a red flag.  Working with difficult people is one of a
> > maintainer's jobs as well.  Christoph has done an enormous amount
> > of highly productive work over the years.  Sure, he's prickly and
> > sure there have been fights, but everyone except you seems to
> > manage to patch things up and accept his contributions.  If it were
> > just one personal problem it might be overlookable, but you seem to
> > be having major fights with the maintainer of every subsystem you
> > touch...
> 
> James, I will bend over backwards to work with people who will work
> to continue the technical discussion.

You will?  Because that doesn't seem to align with your statement about
Christoph being "vague and unaware of the surrounding discussions" and
not posting "anything actionable" for the last 15 years.  No-one else
has that impression and we've almost all had run-ins with Christoph at
some point.

James

