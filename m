Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05F87B5824
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbjJBQpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbjJBQp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:45:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD49B8
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 09:45:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0957C1F37C;
        Mon,  2 Oct 2023 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696265125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyIXVndR2XydeBnMmQFEJcureGSH+1eX0HoskQG9iFs=;
        b=zgb9gpsnODW2Nx4TzTgi/yPvfCodbRDT8IWhDk9M1NnFYhvpJCjqV4t1PN5rzC6H6g6nDV
        wNH5gp7CR/Db58OkxkPMB8lmaTHk4Vp/CdcJ2iVihB/ZLBU+n8ZhYUvTSej+JN5Ar8zzJf
        897dV9n38h4S67eC4hfYoQrbNro+2e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696265125;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyIXVndR2XydeBnMmQFEJcureGSH+1eX0HoskQG9iFs=;
        b=7l78nyUVsoZxblaxZ1j1Eg9PG8+LwfYh1J7Yu7PXWw7f+Mek7aAm9Fy3j+6aZGDcF2ijbD
        SpUVIk4O3qYHYeBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCA2813434;
        Mon,  2 Oct 2023 16:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BVzXNaTzGmXzKgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 16:45:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6D6B2A07C9; Mon,  2 Oct 2023 18:45:24 +0200 (CEST)
Date:   Mon, 2 Oct 2023 18:45:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] porting: document block device freeze and thaw
 changes
Message-ID: <20231002164524.lh6ljbdxdqln33jk@quack3>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-7-ecc36d9ab4d9@kernel.org>
 <20230927151911.GG11414@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927151911.GG11414@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-09-23 08:19:11, Darrick J. Wong wrote:
> On Wed, Sep 27, 2023 at 03:21:20PM +0200, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  Documentation/filesystems/porting.rst | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> > index 4d05b9862451..fef97a2e6729 100644
> > --- a/Documentation/filesystems/porting.rst
> > +++ b/Documentation/filesystems/porting.rst
> > @@ -1045,3 +1045,28 @@ filesystem type is now moved to a later point when the devices are closed:
> >  As this is a VFS level change it has no practical consequences for filesystems
> >  other than that all of them must use one of the provided kill_litter_super(),
> >  kill_anon_super(), or kill_block_super() helpers.
> > +
> > +---
> > +
> > +**mandatory**
> > +
> > +Block device freezing and thawing have been moved to holder operations. As we
> > +can now go straight from block devcie to superblock the get_active_super()
> 
> s/devcie/device/
> 
> > +and bd_fsfreeze_sb members in struct block_device are gone.
> > +
> > +The bd_fsfreeze_mutex is gone as well since we can rely on the bd_holder_lock
> > +to protect against concurrent freeze and thaw.
> > +
> > +Before this change, get_active_super() would only be able to find the
> > +superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
> > +device freezing now works for any block device owned by a given superblock, not
> > +just the main block device.
> 
> You might want to document this new fs_holder_ops scheme:
> 
> "Filesystems opening a block device must pass the super_block object
> and fs_holder_ops as the @holder and @hops parameters."
> 
> Though TBH I see a surprising amount of fs code that doesn't do this, so
> perhaps it's not so mandatory?

This is actually a good point. For the main device, fs/super.c takes care
of this (perhaps except for btrfs). So this patch set should not regress
anything. But for other devices such as the journal device or similar,
passing proper holder and holder_ops from the filesystem is necessary.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
