Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241F57D509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 22:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiGUUr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGUUr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:47:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08608F53A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 13:47:57 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b25so2254816qka.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eJzfJJUbBt7HFtRFrUthszMXR55SFv/KXcRLdAJs0uA=;
        b=NT0OaIfxExmedjYrNABjjMoO2PrKfLsUcFdkprFHB2xpLZxXK2qgNb7UfPJV5nNptA
         UBt4JX/f/gzjXbQ4cWXQX+bsjPhZdHiwhoPeJg6/UISHUl3cuulmAsXjetthAKwh9CO1
         S5Q3jcwJnii0nDwL8JbC97rYAlcg5ydVBAWekLJLvo9I3OxZgI3+Okp4bgHNR2uookUa
         GcUG0LUSizEEFSHIJ65FtSj0Z3su4E6sjW18mm6teNO0XbLkpKP7xfhiwDztlTKcjwXh
         d3h/F/LfIbHWY9QkOYsUlpvneNETr1RkBTgRjU2Zeaop4yakGfMIweihTtfjttYyak7c
         +hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eJzfJJUbBt7HFtRFrUthszMXR55SFv/KXcRLdAJs0uA=;
        b=kIPDroloVxqRefg3H0o+MrfCrMCdqSzTQfaGnm2qbHhwfsBtf2UZI3IZd91GympPHZ
         MryxLenYvw0mAztLG0mM6J6tJq2lYMxHu7AmwjfCvh/wjHUQdLb6QQ9A0o09t/WS4S6z
         YzvdEvZS3qpMUfhfHG4ZZfrXGzGsbxk6V1BKgtbOcIUKFFaRcZbIRXnNSi2YVovWyrgA
         oNhpkrwg6kcpe8wItsGe2u+88ZUhwcDcQybOkymJjdM4rYzwcqWxRz7a9p7MxNeZzeiT
         l8uBFEinQghPzaBSO7wDOYVVQ40x1yAhzBsXK97je1zH3KB3nPy2o/XxsusXq60guJEy
         mzEA==
X-Gm-Message-State: AJIora82Te8ggRLLkmbUQ8ZS5sQmpOfV1YnKwK9z7p/hS8/9L4DeUVSn
        MSEjorQSFtRNW4NML64ljquRzA+tOSfDNw==
X-Google-Smtp-Source: AGRyM1thLmEubhIxsNFfcLOy4GgVfLpHFEfO8hYPko8siKgCMvbNAV5O10zQ1LsIeKURiPDVMDGmDQ==
X-Received: by 2002:ae9:c314:0:b0:6b2:4306:ca78 with SMTP id n20-20020ae9c314000000b006b24306ca78mr260044qkg.230.1658436476844;
        Thu, 21 Jul 2022 13:47:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id cm20-20020a05622a251400b00304fc3d144esm1897595qtb.1.2022.07.21.13.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 13:47:56 -0700 (PDT)
Date:   Thu, 21 Jul 2022 16:47:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <Ytm7e2QHomJICHsO@localhost.localdomain>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:46:50PM -0400, Anna Schumaker wrote:
> On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> > > > On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> > > >
> > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > >
> > > > Rather than relying on the underlying filesystem to tell us where hole
> > > > and data segments are through vfs_llseek(), let's instead do the hole
> > > > compression ourselves. This has a few advantages over the old
> > > > implementation:
> > > >
> > > > 1) A single call to the underlying filesystem through nfsd_readv() means
> > > >   the file can't change from underneath us in the middle of encoding.
> >
> > Hi Anna,
> >
> > I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
> > of nfsd4_encode_read_plus_data() that is used to trim the data that
> > has already been read out of the file?
> 
> There is also the vfs_llseek(SEEK_DATA) call at the start of
> nfsd4_encode_read_plus_hole(). They are used to determine the length
> of the current hole or data segment.
> 
> >
> > What's the problem with racing with a hole punch here? All it does
> > is shorten the read data returned to match the new hole, so all it's
> > doing is making the returned data "more correct".
> 
> The problem is we call vfs_llseek() potentially many times when
> encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
> loop where we alternate between hole and data segments until we've
> encoded the requested number of bytes. My attempts at locking the file
> have resulted in a deadlock since vfs_llseek() also locks the file, so
> the file could change from underneath us during each iteration of the
> loop.
> 
> >
> > OTOH, if something allocates over a hole that the read filled with
> > zeros, what's the problem with occasionally returning zeros as data?
> > Regardless, if this has raced with a write to the file that filled
> > that hole, we're already returning stale data/hole information to
> > the client regardless of whether we trim it or not....
> >
> > i.e. I can't see a correctness or data integrity problem here that
> > doesn't already exist, and I have my doubts that hole
> > punching/filling racing with reads happens often enough to create a
> > performance or bandwidth problem OTW. Hence I've really got no idea
> > what the problem that needs to be solved here is.
> >
> > Can you explain what the symptoms of the problem a user would see
> > that this change solves?
> 
> This fixes xfstests generic/091 and generic/263, along with this
> reported bug: https://bugzilla.kernel.org/show_bug.cgi?id=215673
> >
> > > > 2) A single call to the underlying filestem also means that the
> > > >   underlying filesystem only needs to synchronize cached and on-disk
> > > >   data one time instead of potentially many speeding up the reply.
> >
> > SEEK_HOLE/DATA doesn't require cached data to be sync'd to disk to
> > be coherent - that's only a problem FIEMAP has (and syncing cached
> > data doesn't fix the TOCTOU coherency issue!).  i.e. SEEK_HOLE/DATA
> > will check the page cache for data if appropriate (e.g. unwritten
> > disk extents may have data in memory over the top of them) instead
> > of syncing data to disk.
> 
> For some reason, btrfs on virtual hardware has terrible performance
> numbers when using vfs_llseek() with files that are already in the
> server's cache. I think it had something to do with how they lock
> extents, and some extra work that needs to be done if the file already
> exists in the server's memory but it's been  a few years since I've
> gone into their code to figure out where the slowdown is coming from.
> See this section of my performance results wiki page:
> https://wiki.linux-nfs.org/wiki/index.php/Read_Plus_May_2022#BTRFS_3
>

I just did this locally, once in my test vm's and once on my continuous
performance testing hardware and I'm not able to reproduce the numbers, so I
think I'm doing something wrong.

My test is stupid, I just dd a 5gib file, come behind it and punch holes every
other 4k.  Then I umount and remount, SEEK_DATA+SEEK_HOLE through the whole
file, and then do it again so I have uncached and cached.  The numbers I'm
seeing are equivalent to ext4/xfs.  Granted on my VM I had to redo the test
because I had lockdep and other debugging on which makes us look stupid because
of the extent locking stuff, but with it off everything appears normal.

Does this more or less mirror your testing?  Looking at our code we're not doing
anything inherently stupid, so I'm not entirely sure what could be the problem.
Thanks,

Josef 
