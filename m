Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAC7788CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjHKIOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKIOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB49E40;
        Fri, 11 Aug 2023 01:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 498F864005;
        Fri, 11 Aug 2023 08:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA37AC433C7;
        Fri, 11 Aug 2023 08:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691741642;
        bh=edR2zur+bFxUd9x5fKxTHjd2SgPSX/TK3B60G1Frk7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhWPu158gpjN8z2NjWySDFOrt5INZL+mSeVPo/rm4eKzV1dEw/xcjDf2TCZdgZ4J4
         dcCIMZeDDRwkfr2i1Lfcvee4qf+6+DaNS9JzLkrPXE+6p5S3dsxWsfITYJLgxYLysv
         B84svb9jPrYUrEdLAkqKtI2oFPUeq5UrRYmdCG5AqMrV8/Z9fg9dFWSteX6AQygXg/
         wzM5E7BuQaBARDeSHtE8lMyoTivD62wzH//hG7CyxnQhBaMWUHD3lgOudZYReqpdqC
         jv4mMhBHuABcffiKSDpbNZ8ptFsoW96/nV1gh7JG1tO7WHCAH94aepNGemNuR4bQIv
         vUt9JJ3Flct1A==
Date:   Fri, 11 Aug 2023 10:13:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811-golden-shoppen-dd2f14d64cda@brauner>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810175205.gtlkydeis37xdxuk@quack3>
 <20230811024703.7dhu5rz5ovph7uop@moria.home.lan>
 <20230811081042.4zgtvemgtocfsthz@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811081042.4zgtvemgtocfsthz@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:10:42AM +0200, Jan Kara wrote:
> On Thu 10-08-23 22:47:03, Kent Overstreet wrote:
> > On Thu, Aug 10, 2023 at 07:52:05PM +0200, Jan Kara wrote:
> > > On Thu 10-08-23 11:54:53, Kent Overstreet wrote:
> > > > > And there clearly is something very strange going on with superblock
> > > > > handling
> > > > 
> > > > This deserves an explanation because sget() is a bit nutty.
> > > > 
> > > > The way sget() is conventionally used for block device filesystems, the
> > > > block device open _isn't actually exclusive_ - sure, FMODE_EXCL is used,
> > > > but the holder is the fs type pointer, so it won't exclude with other
> > > > opens of the same fs type.
> > > > 
> > > > That means the only protection from multiple opens scribbling over each
> > > > other is sget() itself - but if the bdev handle ever outlives the
> > > > superblock we're completely screwed; that's a silent data corruption bug
> > > > that we can't easily catch, and if the filesystem teardown path has any
> > > > asynchronous stuff going on (and of course it does) that's not a hard
> > > > mistake to make. I've observed at least one bug that looked suspiciously
> > > > like that, but I don't think I quite pinned it down at the time.
> > > 
> > > This is just being changed - check Christian's VFS tree. There are patches
> > > that make sget() use superblock pointer as a bdev holder so the reuse
> > > you're speaking about isn't a problem anymore.
> > 
> > So then the question is what do you use for identifying the superblock,
> > and you're switching to the dev_t - interesting.
> > 
> > Are we 100% sure that will never break, that a dev_t will always
> > identify a unique block_device? Namespacing has been changing things.
> 
> Yes, dev_t is a unique identifier of the device, we rely on that in
> multiple places, block device open comes to mind as the first. You're
> right namespacing changes things but we implement that as changing what
> gets presented to userspace via some mapping layer while the kernel keeps
> using globally unique identifiers.

Full device namespacing is not on the horizon at all. We've looked into
this years ago and it woud be a giant effort that would effect nearly
everything if the properly. So even if, there would be so many changes
required that reliance on dev_t in the VFS would be the least of our
problems.
