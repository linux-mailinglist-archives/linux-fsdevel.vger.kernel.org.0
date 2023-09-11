Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53779B82F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbjIKUzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbjIKNfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:35:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CCE125
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 06:35:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C06521846;
        Mon, 11 Sep 2023 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694439317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2y+hyYEH//8rRki7GZja5XdADYE6IfWjNw6k7r7UcwY=;
        b=kb1i8lEoj/nI+2c9PIs9HQqWhRUI59dvUe047Eey+EdNhIYCCZEDRy3R9KSX4l+MVrpa+M
        cxd7uv+v+ERNnQ8TFd5NlTMIabuP5Sybbun3woh3V3lfWxtW/zsE53ErZWTGTuqGoxWMb7
        FjxW9nAhNfXNVCqzTUL+HL4DVbWbOq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694439317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2y+hyYEH//8rRki7GZja5XdADYE6IfWjNw6k7r7UcwY=;
        b=iVZPYNlD6tZNIHdj5xnnsd+uqD6tlVmxp2OMGvu8jotE+9wSXz0j8UlyNiY/cuv21zKHiU
        TmYSM4MkIK1maBAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 386C313780;
        Mon, 11 Sep 2023 13:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9GtUDJUX/2Q+MAAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 11 Sep 2023 13:35:17 +0000
Date:   Mon, 11 Sep 2023 15:35:15 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>,
        Octavian Purdila <tavi.purdila@gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
Message-ID: <20230911153515.2a256856@echidna.fritz.box>
In-Reply-To: <ZP52S8jPsNt0IvQE@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
        <ZPe0bSW10Gj7rvAW@dread.disaster.area>
        <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
        <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
        <20230909224230.3hm4rqln33qspmma@moria.home.lan>
        <ZP5nxdbazqirMKAA@dread.disaster.area>
        <20230911012914.xoeowcbruxxonw7u@moria.home.lan>
        <ZP52S8jPsNt0IvQE@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Mon, 11 Sep 2023 12:07:07 +1000, Dave Chinner wrote:

> On Sun, Sep 10, 2023 at 09:29:14PM -0400, Kent Overstreet wrote:
> > On Mon, Sep 11, 2023 at 11:05:09AM +1000, Dave Chinner wrote:  
> > > On Sat, Sep 09, 2023 at 06:42:30PM -0400, Kent Overstreet wrote:  
> > > > On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:  
> > > > > So why can't we figure out that easier way? What's wrong with trying to
> > > > > figure out if we can do some sort of helper or library set that assists
> > > > > supporting and porting older filesystems. If we can do that it will not
> > > > > only make the job of an old fs maintainer a lot easier, but it might
> > > > > just provide the stepping stones we need to encourage more people climb
> > > > > up into the modern VFS world.  
> > > > 
> > > > What if we could run our existing filesystem code in userspace?  
> > > 
> > > You mean like lklfuse already enables?  
> > 
> > I'm not seeing that it does?
> > 
> > I just had a look at the code, and I don't see anything there related to
> > the VFS - AFAIK, a VFS -> fuse layer doesn't exist yet.  
> 
> Just to repeat what I said on #xfs here...
> 
> It doesn't try to cut in half way through the VFS -> filesystem
> path. It just redirects the fuse operations to "lkl syscalls" and so
> runs the entire kernel VFS->filesystem path.
> 
> https://github.com/lkl/linux/blob/master/tools/lkl/lklfuse.c
> 
> > And that looks a lot heavier than what we'd ideally want, i.e. a _lot_
> > more kernel code would be getting pulled in. The entire block layer,
> > probably the scheduler as well.  

The LKL block layer may also become useful for legacy storage support in
future, e.g. SCSI protocol obsolescence.

> Yes, but arguing that "performance sucks" misses the entire point of
> this discussion: that for the untrusted user mounts of untrusted
> filesystem images we already have a viable method for moving the
> dangerous processing out into userspace that requires almost *zero
> additional work* from anyone.

Indeed. Hajime and Octavian (cc'ed) have also made serious efforts to
get the LKL codebase in shape for mainline:
https://lore.kernel.org/linux-um/cover.1611103406.git.thehajime@gmail.com/

> As long as the performance of the lklfuse implementation doesn't
> totally suck, nobody will really care that much that isn't quite as
> fast as a native implementation. PLuggable drives (e.g. via USB) are
> already going to be much slower than a host installed drive, so I
> don't think performance is even really a consideration for these
> sorts of use cases....
> 
> > What I've got in bcachefs-tools is a much thinner mapping from e.g.
> > kthreads -> pthreads, block layer -> aio, etc.  
> 
> Right, and we've got that in userspace for XFS, too. If we really
> cared that much about XFS-FUSE, I'd be converting userspace to use
> ublk w/ io_uring on top of a port of the kernel XFS buffer cache as
> the basis for a performant fuse implementation. However, there's a
> massive amount of userspace work needed to get a native XFS FUSE
> implementation up and running (even ignoring performance), so it's
> just not a viable short-term - or even medium-term - solution to the
> current problems.
> 
> Indeed, if you do a fuse->fs ops wrapper, I'd argue that lklfuse is
> the place to do it so that there is a single code base that supports
> all kernel filesystems without requiring anyone to support a
> separate userspace code base. Requiring every filesystem to do their
> own FUSE ports and then support them doesn't reduce the overall
> maintenance overhead burden on filesystem developers....

LKL is still implemented as a non-mmu architecture. The only fs specific
downstream change that lklfuse depends on is non-mmu xfs_buf support:
https://lore.kernel.org/linux-xfs/1447800381-20167-1-git-send-email-octavian.purdila@intel.com/

Does your lklfuse enthusiasm here imply that you'd be willing to
reconsider Octavian's earlier proposal for XFS non-mmu support?

Cheers, David
