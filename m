Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4DA1560AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 22:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGVUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 16:20:17 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33617 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726947AbgBGVUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:20:17 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 76A4A6E35;
        Fri,  7 Feb 2020 16:20:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 07 Feb 2020 16:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ophMmMwMLLaKjOJP0ctw12O67B1
        zRQvfdgS0jTuIqR8=; b=KMEycsMBR2DnW931V6xgvAiSmfOPGSb/NzAgL/pUhV6
        5Wyq45jpDjzVcopHjYYbqZijtAuNRMfgYIQi7LiqW/O/iQfZQ1tGF7fzmQhKLSTq
        BmwiHEUOycWjA1B1zkY+lAhcNja0B3sFoFAvuu8sjlDsfnND+cZxqXWEqS2JDtsn
        uflCLJhpFozpBlwWjUB66JvFSpQGAh2jAnursgJ5o1tDHAvMDlexrbjw2LWuvZ8M
        0vQ1L31ji3aAqt8+SKKzihxOpwahDPVPWE55oAi7xrkKiDFgwDmnIeAmQJydYVBA
        ITkZJBNpxvWVIBhNLXsm62+sAaKQghNrsnXJGcWBocw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ophMmM
        wMLLaKjOJP0ctw12O67B1zRQvfdgS0jTuIqR8=; b=aIESVf2XQNaAvI8kV/eGNj
        DpIOgPq2aDuAYiRubi/463C7rfC2j0eCrDe8JqsjUiigi1YRevlnGYQuuh8VvL0j
        PrT/lH9WY/B6UcIPN+rrCdkHCzdLhFW7WlZceoCfW9pTb7bzt9ZNbiD+MY0MPf7m
        5ruYOpscaPr67hXGgOeYmrBbGttGed/VWhvoejqbEgCwLR33xvqDje7DuMLmRcRh
        2JfrO6PdYFwe9iYRy4SreANfcCDpOAkkrbEtJxTf4LS/jXreYB9VblH92sjsLNJn
        0MXqEkK5LsK6HSg9A3dcK5HAs7FmJiEOBiBKkXTmJIOiF/Y8JFOPVG1KwFTzLVaA
        ==
X-ME-Sender: <xms:jdQ9XoTJtFlc5W3IHH2OBIsaDO6a0p7uAw0kbQTBG3eR7UqxveRR_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrheehgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucfkphepie
    ejrdduiedtrddvudejrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:jdQ9XmUZZ-_FSV-IM74x0z_eWM0QRuXdBHt_meHAVrD9el-QHdi_ig>
    <xmx:jdQ9XhOh5PkuKN4saFpDH3fvsf78LC2ede3OApXrzxd9oBdiNZMCMQ>
    <xmx:jdQ9XuqzLQeFCVMh5mjXxU7FhJsDHzR9ZAg6IHdDLqmqQ5HXl2e98g>
    <xmx:kNQ9Xk5a7Cg59MVa46ri30azMwfznxfhuviaSQLqsbNDR2cz9HFKvQ>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id C1C1A3060272;
        Fri,  7 Feb 2020 16:20:13 -0500 (EST)
Date:   Fri, 7 Feb 2020 13:20:12 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
Message-ID: <20200207212012.7jrivg2bvuvvful5@alap3.anarazel.de>
References: <20200207170423.377931-1-jlayton@kernel.org>
 <20200207205243.GP20628@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207205243.GP20628@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2020-02-08 07:52:43 +1100, Dave Chinner wrote:
> On Fri, Feb 07, 2020 at 12:04:20PM -0500, Jeff Layton wrote:
> > You're probably wondering -- Where are v1 and v2 sets?

> > The basic idea is to track writeback errors at the superblock level,
> > so that we can quickly and easily check whether something bad happened
> > without having to fsync each file individually. syncfs is then changed
> > to reliably report writeback errors, and a new ioctl is added to allow
> > userland to get at the current errseq_t value w/o having to sync out
> > anything.
> 
> So what, exactly, can userspace do with this error? It has no idea
> at all what file the writeback failure occurred on or even
> what files syncfs() even acted on so there's no obvious error
> recovery that it could perform on reception of such an error.

Depends on the application.  For e.g. postgres it'd to be to reset
in-memory contents and perform WAL replay from the last checkpoint. Due
to various reasons* it's very hard for us (without major performance
and/or reliability impact) to fully guarantee that by the time we fsync
specific files we do so on an old enough fd to guarantee that we'd see
the an error triggered by background writeback.  But keeping track of
all potential filesystems data resides on (with one fd open permanently
for each) and then syncfs()ing them at checkpoint time is quite doable.

*I can go into details, but it's probably not interesting enough


> > - This adds a new generic fs ioctl to allow userland to scrape the
> >   current superblock's errseq_t value. It may be best to present this
> >   to userland via fsinfo() instead (once that's merged). I'm fine with
> >   dropping the last patch for now and reworking it for fsinfo if so.
> 
> What, exactly, is this useful for? Why would we consider exposing
> an internal implementation detail to userspace like this?

There is, as far as I can tell, so far no way but scraping the kernel
log to figure out if there have been data loss errors on a
machine/fs. Even besides app specific reactions like outlined above,
just generally being able to alert whenever there error count increases
seems extremely useful.  I'm not sure it makes sense to expose the
errseq_t bits straight though - seems like it'd enshrine them in
userspace ABI too much?

Greetings,

Andres Freund
