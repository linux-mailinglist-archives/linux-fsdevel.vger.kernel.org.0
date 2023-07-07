Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFB74B18B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGGNNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGGNNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:13:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D4C1FF0;
        Fri,  7 Jul 2023 06:13:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 879C51FDB4;
        Fri,  7 Jul 2023 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688735587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UobiIK3q2vMGQKwcTXx1XKYb4NcuR8QXMg/mvRkRX3c=;
        b=THkKxvvoPilHwhcm5SMUq87l4542ld7wHMlU0mmVX5ikmZf5AHOacfPNDCaO/UoxLmi41h
        cTGxaI1u/JUiOq58VWCP+EOFe5Qei2iRUX9LnwqMkosaZ8XS+oH5C/cZ7TB17aGfgdH+F4
        3AlIohytQ6fBpZGTv1hCqVjmCyj5nRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688735587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UobiIK3q2vMGQKwcTXx1XKYb4NcuR8QXMg/mvRkRX3c=;
        b=wavFwp2g5JelLLtGhdgW6aKQtITsRQEvgYhJyoA9C+y8j8OrXpazqqPL0Jz+KJIXTuyNsN
        UFe00CisOpZr+zDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 681B41346D;
        Fri,  7 Jul 2023 13:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GNtfGWMPqGSfUAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 07 Jul 2023 13:13:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E7F93A0717; Fri,  7 Jul 2023 15:13:06 +0200 (CEST)
Date:   Fri, 7 Jul 2023 15:13:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230707131306.2wdgtuafc3unjetu@quack3>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230706224314.u5zbeld23uqur2ct@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706224314.u5zbeld23uqur2ct@moria.home.lan>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-07-23 18:43:14, Kent Overstreet wrote:
> On Thu, Jul 06, 2023 at 02:19:14PM -0700, Darrick J. Wong wrote:
> > /me shrugs, been on vacation and in hospitals for the last month or so.
> > 
> > >      bcachefs doesn't use sget() for mutual exclusion because a) sget()
> > >      is insane, what we really want is the _block device_ to be opened
> > >      exclusively (which we do), and we have our own block device opening
> > >      path - which we need to, as we're a multi device filesystem.
> > 
> > ...and isn't jan kara already messing with this anyway?
> 
> The blkdev_get_handle() patchset? I like that, but I don't think that's
> related - if there's something more related to sget() I haven't seen it
> yet

There's a series on top of that that also modifies how sget() works [1].
Christian wants that bit to be merged separately from the bdev handle stuff
and Christoph chimed in with some other related cleanups so he'll now take
care of that change.

Anyhow we should have sget() that does not exclusively claim the bdev
unless it needs to create a new superblock soon.

								Honza

[1] https://lore.kernel.org/all/20230704125702.23180-6-jack@suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
