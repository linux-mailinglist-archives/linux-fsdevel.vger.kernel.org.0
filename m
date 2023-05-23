Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494E870D068
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 03:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjEWBUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 21:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEWBUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 21:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B2B8E;
        Mon, 22 May 2023 18:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42FF762D5A;
        Tue, 23 May 2023 01:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDFAC433EF;
        Tue, 23 May 2023 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684804829;
        bh=xk20vdIG4/RhyXJBz+4WB3j0q/I0MXGPm+rihI115k0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpFq3fhSUy6W5vhcyI/+gHR3gcwKgHMNhijnY6n9tLN7TVxzXSAvPEV02oearnR4t
         VFvFkF2lID6ZWaYxJzmHyfM/gSEFGZ9P8+o29VagUYR5CIBKwdXxSz87G/XlHEWvRk
         zfyl4dKlEiEfohugwbJPc5IpJxsLQnSbEUVMgipwfAyQ/IArRXM9wUBQLLndyCYaqk
         1Hh/lmTxcriS2oHYFWKmEctU719iUZeujteNSqyEHDZW9eD9fiXtscyMP6NGhExh6b
         J9k+Uua7VS20cpR57+kh6JYS5eigfaeSojlEd5WVay1lgjV5kjnWxeWeNOdU4riOEt
         balbwj7Vzzy0Q==
Date:   Mon, 22 May 2023 18:20:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net, jake@lwn.net,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH v2] Documentation: add initial iomap kdoc
Message-ID: <20230523012028.GE11598@frogsfrogsfrogs>
References: <20230518150105.3160445-1-mcgrof@kernel.org>
 <ZGcDaysYl+w9kV6+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGcDaysYl+w9kV6+@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 10:04:43PM -0700, Christoph Hellwig wrote:
> On Thu, May 18, 2023 at 08:01:05AM -0700, Luis Chamberlain wrote:
> > +        Mapping of heading styles within this document:
> > +        Heading 1 uses "====" above and below
> > +        Heading 2 uses "===="
> > +        Heading 3 uses "----"
> > +        Heading 4 uses "````"
> > +        Heading 5 uses "^^^^"
> > +        Heading 6 uses "~~~~"
> > +        Heading 7 uses "...."
> > +
> > +        Sections are manually numbered because apparently that's what everyone
> 
> Why are you picking different defaults then the rest of the kernel
> documentation?

I bet Luis copied that from the online fsck document.

IIRC the doc generator is smart enough to handle per-file heading usage.
The rst parser sourcecode doesn't seem to have harcoded defaults; every
time it sees an unfamiliar heading style in a .rst file, it adds that as
the next level down in the hierarchy.

Also, where are the "proper" headings documented for Documentation/?

(Skip to the end; it's late and I don't have time right now to read the
content of this patch.)

> > +
> > +A modern block abstraction
> > +==========================
> > +
> > +**iomap** allows filesystems to query storage media for data using *byte
> > +ranges*. Since block mapping are provided for a *byte ranges* for cache data in
> > +memory, in the page cache, naturally this implies operations on block ranges
> > +will also deal with *multipage* operations in the page cache. **Folios** are
> > +used to help provide *multipage* operations in memory for the *byte ranges*
> > +being worked on.
> 
> As mentioned you list time this information was circulated this is not
> true.  iomap itself has nothing to with blocks, and even less so with
> the page cache per se.  It just iterates over ranges of file data and
> applies work to it.
> 
> > +iomap IO interfaces
> > +===================
> > +
> > +You call **iomap** depending on the type of filesystem operation you are working
> > +on. We detail some of these interactions below.
> 
> Who is you?
> 
> > +
> > +iomap for bufferred IO writes
> > +-----------------------------
> > +
> > +You call **iomap** for buffered IO with:
> > +
> > + * ``iomap_file_buffered_write()`` - for buffered writes
> > + * ``iomap_page_mkwrite()`` - when dealing callbacks for
> > +    ``struct vm_operations_struct``
> > +
> > +  * ``struct vm_operations_struct.page_mkwrite()``
> > +  * ``struct vm_operations_struct.fault()``
> > +  * ``struct vm_operations_struct.huge_fault()``
> > +  * ``struct vm_operations_struct`.pfn_mkwrite()``
> > +
> > +You *may* use buffered writes to also deal with ``fallocate()``:
> > +
> > + * ``iomap_zero_range()`` on fallocate for zeroing
> > + * ``iomap_truncate_page()`` on fallocate for truncation
> > +
> > +Typically you'd also happen to use these on paths when updating an inode's size.
> 
> I'm not really sure what this is trying to explain.  It basically looks
> like filler text generated by machine learning algorithms..
> 
> The same is true for a large part of this document.
> 
> > +A filesystem also needs to call **iomap** when assisting the VFS manipulating a
> > +file into the page cache.
> 
> A file systsem doesn't _need_ to do anything.  It may chose to do
> things, and the iomap based helpers might be useful for that.  But
> again, I'm still not getting what this document is even trying to
> explain, as "to implement the method foo, use the iomap_foo" isn't
> really helping anyone.
> 
> > +Converting filesystems from buffer-head to iomap guide
> > +======================================================
> 
> If you want such a guide, please keep it in a separate file from the
> iomap API documentation.  I'd also suggest that you actually try such
> a conversion first, as that might help shaping the documentation :)
> 
> > +Testing Direct IO
> > +=================
> > +
> > +Other than fstests you can use LTP's dio, however this tests is limited as it
> > +does not test stale data.
> > +
> > +{{{
> > +./runltp -f dio -d /mnt1/scratch/tmp/
> > +}}}
> 
> How does this belong into an iomap documentation?  If LTPs dio is really
> all that useful we should import it into xfstests, btw.  I'm not sure it
> is, though.
> 
> > +We try to document known issues that folks should be aware of with **iomap** here.
> 
> Who is "we"?
> 
> > + * DOC: Introduction
> > + *
> > + * iomap allows filesystems to sequentially iterate over byte addressable block
> > + * ranges on an inode and apply operations to it.
> > + *
> > + * iomap grew out of the need to provide a modern block mapping abstraction for
> > + * filesystems with the different IO access methods they support and assisting
> > + * the VFS with manipulating files into the page cache. iomap helpers are
> > + * provided for each of these mechanisms. However, block mapping is just one of
> > + * the features of iomap, given iomap supports DAX IO for filesystems and also
> > + * supports such the ``lseek``/``llseek`` ``SEEK_DATA``/``SEEK_HOLE``
> > + * interfaces.
> > + *
> > + * Block mapping provides a mapping between data cached in memory and the
> > + * location on persistent storage where that data lives. `LWN has an great
> > + * review of the old buffer-heads block-mapping and why they are inefficient
> > + * <https://lwn.net/Articles/930173/>`, since the inception of Linux.  Since
> > + * **buffer-heads** work on a 512-byte block based paradigm, it creates an
> > + * overhead for modern storage media which no longer necessarily works only on
> > + * 512-blocks. iomap is flexible providing block ranges in *bytes*. iomap, with
> > + * the support of folios, provides a modern replacement for **buffer-heads**.
> > + */
> 
> I really don't want random blurbs and links like this in the main
> header.  If you want to ramble in a little howto that's fine, but the
> main header is not the place for it.
> 
> Also please keep improvements to the header in a separate patch from
> adding Documentation/ documents.

Frankly I don't really like the iomap.h changes -- that's going to blow
up the git blame on that file, just to produce a stilted-language
manpage.

Someone who wants to port a filesystem to iomap (or write a new fs) will
need a coherent narrative (you know, with paragraphs and sentences)
about how to build this piece and that.  The rst file under Documentation/
is the place for that, not trying to mash it into a C header.

--D
