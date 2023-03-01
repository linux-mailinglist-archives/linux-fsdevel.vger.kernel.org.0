Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7D6A6CB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 14:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCANBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 08:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCANAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D803E620;
        Wed,  1 Mar 2023 05:00:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3141121A6D;
        Wed,  1 Mar 2023 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677675619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+Z5EjqlTkGGepPXzUUurDzA8EtTEMkE0hocixFnr84=;
        b=RT3+8Mh6WjeRz9KhCN5uYsdc2iLtrMZsHf/qUA4eJGbrmFYHcVXL6xzy1LH0/yDyke8Ohs
        C2qHTXuCVp0EJhMD5OL3ko+wrt+1ctOUAb/3BwzUW3/wmd5lYfRi4vgJTqblIQCg6mhlAL
        6FWLg5YqDA4S/1bBVqwAhu9sr7gecJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677675619;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+Z5EjqlTkGGepPXzUUurDzA8EtTEMkE0hocixFnr84=;
        b=8LKdc5BCDjr9Y/Ufm4aDxfMJ4oraQAWHN2yM8gM4ZIuXOLP/qNRPqTzUkoYOVHOVExzklC
        Ucw4+XdrpkWqgrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 229ED13A63;
        Wed,  1 Mar 2023 13:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eDxoCGNM/2OnBAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 13:00:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 64AEBA06E5; Wed,  1 Mar 2023 14:00:18 +0100 (CET)
Date:   Wed, 1 Mar 2023 14:00:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <20230301130018.yqds5yvqj7q26f7e@quack3>
References: <Y/gugbqq858QXJBY@ZenIV>
 <13214812.uLZWGnKmhe@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13214812.uLZWGnKmhe@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> On venerdì 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > 	Fabio's "switch to kmap_local_page()" patchset (originally after the
> > ext2 counterpart, with a lot of cleaning up done to it; as the matter of
> > fact, ext2 side is in need of similar cleanups - calling conventions there
> > are bloody awful).
> 
> If nobody else is already working on these cleanups in ext2 following your 
> suggestion, I'd be happy to work on this by the end of this week. I only need 
> a confirmation because I'd hate to duplicate someone else work.
> 
> > Plus the equivalents of minix stuff...
> 
> I don't know this other filesystem but I could take a look and see whether it 
> resembles somehow sysv and ext2 (if so, this work would be pretty simple too, 
> thanks to your kind suggestions when I worked on sysv and ufs).
> 
> I'm adding Jan to the Cc list to hear whether he is aware of anybody else 
> working on this changes for ext2. I'm waiting for a reply from you (@Al) or 
> Jan to avoid duplication (as said above).

I'm not sure what exactly Al doesn't like about how ext2 handles pages and
mapping but if you have some cleanups in mind, sure go ahead. I don't have
any plans on working on that code in the near term.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
