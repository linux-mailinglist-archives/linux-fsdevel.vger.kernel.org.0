Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C96A6E17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 15:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCAOO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 09:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCAOO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:14:26 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4DD302AA;
        Wed,  1 Mar 2023 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=JiQ1Ck76H2r6PkON3wfkPjMpQPycc0Z6iizbQ4DPdOQ=; b=P2wo25f7aJbDFzYfInQSjauSqE
        GrVYbsu/qvRXZ4qO8EujsdGYv3FYCsFHxQUvUNiXYq9nPVEOZZ5Zc2ck946xvUbo28xzoXud8J4ez
        UDx/3CW+uughWdgvDZSjy6SrAF6PNvvgW4gU2Pd2J8c969lJlBIX22gqznwCvnjf+xSqN764itzZz
        eKWIdAF0c+ozM0d8LaJaNpkQPH9DMZsWtn3h+UMOlp5x1t4W5qOfGJKY8q7NY9gsEODbJzHqqbXil
        nF6vktH0ltQFXPBW6ScwgPMzB3iu4QEo12WG8+nlN53SvD90U2L7Flvnr6ih0VufvIirLiysSiYCE
        Vr2PA34w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXNDk-00D4Vx-2Q;
        Wed, 01 Mar 2023 14:14:16 +0000
Date:   Wed, 1 Mar 2023 14:14:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jan Kara <jack@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <Y/9duET0Mt5hPu2L@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV>
 <13214812.uLZWGnKmhe@suse>
 <20230301130018.yqds5yvqj7q26f7e@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301130018.yqds5yvqj7q26f7e@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 02:00:18PM +0100, Jan Kara wrote:
> On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > On venerdì 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > 	Fabio's "switch to kmap_local_page()" patchset (originally after the
> > > ext2 counterpart, with a lot of cleaning up done to it; as the matter of
> > > fact, ext2 side is in need of similar cleanups - calling conventions there
> > > are bloody awful).
> > 
> > If nobody else is already working on these cleanups in ext2 following your 
> > suggestion, I'd be happy to work on this by the end of this week. I only need 
> > a confirmation because I'd hate to duplicate someone else work.
> > 
> > > Plus the equivalents of minix stuff...
> > 
> > I don't know this other filesystem but I could take a look and see whether it 
> > resembles somehow sysv and ext2 (if so, this work would be pretty simple too, 
> > thanks to your kind suggestions when I worked on sysv and ufs).
> > 
> > I'm adding Jan to the Cc list to hear whether he is aware of anybody else 
> > working on this changes for ext2. I'm waiting for a reply from you (@Al) or 
> > Jan to avoid duplication (as said above).
> 
> I'm not sure what exactly Al doesn't like about how ext2 handles pages and
> mapping but if you have some cleanups in mind, sure go ahead. I don't have
> any plans on working on that code in the near term.

I think I've pushed a demo patchset to vfs.git at some point back in January...
Yep - see #work.ext2 in there; completely untested, though.
