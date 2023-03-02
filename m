Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1C6A7F75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 11:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCBKBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 05:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCBKBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:01:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D92129C;
        Thu,  2 Mar 2023 02:00:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9538C21C12;
        Thu,  2 Mar 2023 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677751171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlfULTbozK3N2YwtvF5Jbr5jei4HWI6vCBEqUrHsVjg=;
        b=x/6E9zyJ4GBI+m1skdPfql6YmK1W5WeRf5ZI9Xf1eP4t+lcg4UbJPeFGCWkjvmBuNxUHSZ
        /6hoas0DIwe2cLsu9LGAA6c5Zd64T+eYNv82aFLA8wDGkZokLPVmr5PBjvKTzFtyze0GKq
        WKPFNrZomAnF4q2ZlzX+3SM2xnfLjZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677751171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlfULTbozK3N2YwtvF5Jbr5jei4HWI6vCBEqUrHsVjg=;
        b=SyKGlIE1mZjAGjaj0Z0gPLIhI8DYm3kbjuF4l3ZJK+tGQMcuRA4QU0WkEchAwQr/8ayNTY
        hDlJV1SwkmbwBkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8795713349;
        Thu,  2 Mar 2023 09:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h6kRIYNzAGRMSwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 02 Mar 2023 09:59:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 18986A06E5; Thu,  2 Mar 2023 10:59:31 +0100 (CET)
Date:   Thu, 2 Mar 2023 10:59:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jan Kara <jack@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <20230302095931.jwyrlgtxcke7iwuu@quack3>
References: <Y/gugbqq858QXJBY@ZenIV>
 <13214812.uLZWGnKmhe@suse>
 <20230301130018.yqds5yvqj7q26f7e@quack3>
 <Y/9duET0Mt5hPu2L@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/9duET0Mt5hPu2L@ZenIV>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-03-23 14:14:16, Al Viro wrote:
> On Wed, Mar 01, 2023 at 02:00:18PM +0100, Jan Kara wrote:
> > On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > > On venerdì 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > > 	Fabio's "switch to kmap_local_page()" patchset (originally after the
> > > > ext2 counterpart, with a lot of cleaning up done to it; as the matter of
> > > > fact, ext2 side is in need of similar cleanups - calling conventions there
> > > > are bloody awful).
> > > 
> > > If nobody else is already working on these cleanups in ext2 following your 
> > > suggestion, I'd be happy to work on this by the end of this week. I only need 
> > > a confirmation because I'd hate to duplicate someone else work.
> > > 
> > > > Plus the equivalents of minix stuff...
> > > 
> > > I don't know this other filesystem but I could take a look and see whether it 
> > > resembles somehow sysv and ext2 (if so, this work would be pretty simple too, 
> > > thanks to your kind suggestions when I worked on sysv and ufs).
> > > 
> > > I'm adding Jan to the Cc list to hear whether he is aware of anybody else 
> > > working on this changes for ext2. I'm waiting for a reply from you (@Al) or 
> > > Jan to avoid duplication (as said above).
> > 
> > I'm not sure what exactly Al doesn't like about how ext2 handles pages and
> > mapping but if you have some cleanups in mind, sure go ahead. I don't have
> > any plans on working on that code in the near term.
> 
> I think I've pushed a demo patchset to vfs.git at some point back in January...
> Yep - see #work.ext2 in there; completely untested, though.

OK, I think your changes to ext2_rename() in PATCH 1 leak a reference and
mapping of old_page but otherwise I like the patches. So Fabio, if you can
pick them up and push this to completion, it would be nice. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
