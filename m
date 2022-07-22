Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCCB57E257
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiGVNco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 09:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiGVNcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:32:42 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24FE82FAA
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 06:32:40 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e5so3490736qts.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fgV0OyZQnEkaUoJHBRpOfKLsz4CrPGRVpIp6sQ3jsLI=;
        b=Lvg74dlhSvtItYMOwA2DzO3H8Ory07l09lJ/KO6+jm5zMPLycmJxkrAzn8UT48/pzo
         OHnjF/Rm2usgT6qQlSEpERRB+yL0P/Mbx/JDBuGWW+Iy/tcDt75GQtY4GPcJx5Z3F2Nn
         LQvv83REEhXubRIaRuEYIghvQDIyFJPcMYFENRypFUUGYV/kxzEESiUqsgU6Eyi73cko
         4fBo6ZrA717N/22b82RqrbnAfqERFWRlErYzyR0aPv3zXQhksHeW2uceA7Zunhnd72Jg
         CGb/iAEoGezC3iK2GHNJbzrZQ2JEeUGrOHhBsUB723fiAoL2V07SBsBDPfqR+JuwFpf1
         +vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fgV0OyZQnEkaUoJHBRpOfKLsz4CrPGRVpIp6sQ3jsLI=;
        b=gLMjmc3PH7evMFzqRGr7TyvD4dsNe9PF1yrG2u/G3xM+pkRqV1/04N9e2shnm0OVzM
         B6NDZWr4zCFEAmnm7VeS1+JeKWXmZQgAqG/3/fI/5DvWribEiK5tpgQU/uqTIH8kHYWE
         6qLQoRHBiW6D54bMygv+JNYubg8ORl53VA/7LObudC62gJ42YeBy2PPYXO64+UZK/sPJ
         Fd+8jwzorCU5DuBzd/Rm9dFG0xRzlkaZNX13zcT9Y9rz3mN7vcrhVYFFE2wSNHUSPCTr
         QYfE4TA3bHETKYdzUFIgABdx5xIAG11AN1LRhP+UJbSQzAAtyn598X7clnvyu3KN1uXz
         7deg==
X-Gm-Message-State: AJIora/jvruZLgUdWdnP6D2RjwTFe4kf9BXLAZBtirSaZ31mVZ1yt6Wj
        McmTZFhG1vkkLRr5sXSA1N9+4A==
X-Google-Smtp-Source: AGRyM1uuJ5BVkwfTIBdbr88xwUvqGS7xjwJg8xL3RosH0UoIIvd8ZltKBiln3gBOgFeeZh7Q4iI1og==
X-Received: by 2002:a05:622a:1811:b0:31e:f69e:a3d5 with SMTP id t17-20020a05622a181100b0031ef69ea3d5mr20358qtc.379.1658496759497;
        Fri, 22 Jul 2022 06:32:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h24-20020ac846d8000000b0031e9ff0c44fsm2889177qto.20.2022.07.22.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:32:39 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:32:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <Ytqm9azcQfrC4vpG@localhost.localdomain>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <Ytm7e2QHomJICHsO@localhost.localdomain>
 <CAFX2JfkLW1RC9T45dN5pzfENQ+LXqF=cxDS7hxGUzaheuH07kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2JfkLW1RC9T45dN5pzfENQ+LXqF=cxDS7hxGUzaheuH07kQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:45:13AM -0400, Anna Schumaker wrote:
> On Thu, Jul 21, 2022 at 4:48 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Jul 19, 2022 at 04:46:50PM -0400, Anna Schumaker wrote:
> > > On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> > > > > > On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> > > > > >
> > > > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > > >
> > > > > > Rather than relying on the underlying filesystem to tell us where hole
> > > > > > and data segments are through vfs_llseek(), let's instead do the hole
> > > > > > compression ourselves. This has a few advantages over the old
> > > > > > implementation:
> > > > > >
> > > > > > 1) A single call to the underlying filesystem through nfsd_readv() means
> > > > > >   the file can't change from underneath us in the middle of encoding.
> > > >
> > > > Hi Anna,
> > > >
> > > > I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
> > > > of nfsd4_encode_read_plus_data() that is used to trim the data that
> > > > has already been read out of the file?
> > >
> > > There is also the vfs_llseek(SEEK_DATA) call at the start of
> > > nfsd4_encode_read_plus_hole(). They are used to determine the length
> > > of the current hole or data segment.
> > >
> > > >
> > > > What's the problem with racing with a hole punch here? All it does
> > > > is shorten the read data returned to match the new hole, so all it's
> > > > doing is making the returned data "more correct".
> > >
> > > The problem is we call vfs_llseek() potentially many times when
> > > encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
> > > loop where we alternate between hole and data segments until we've
> > > encoded the requested number of bytes. My attempts at locking the file
> > > have resulted in a deadlock since vfs_llseek() also locks the file, so
> > > the file could change from underneath us during each iteration of the
> > > loop.
> > >
> > > >
> > > > OTOH, if something allocates over a hole that the read filled with
> > > > zeros, what's the problem with occasionally returning zeros as data?
> > > > Regardless, if this has raced with a write to the file that filled
> > > > that hole, we're already returning stale data/hole information to
> > > > the client regardless of whether we trim it or not....
> > > >
> > > > i.e. I can't see a correctness or data integrity problem here that
> > > > doesn't already exist, and I have my doubts that hole
> > > > punching/filling racing with reads happens often enough to create a
> > > > performance or bandwidth problem OTW. Hence I've really got no idea
> > > > what the problem that needs to be solved here is.
> > > >
> > > > Can you explain what the symptoms of the problem a user would see
> > > > that this change solves?
> > >
> > > This fixes xfstests generic/091 and generic/263, along with this
> > > reported bug: https://bugzilla.kernel.org/show_bug.cgi?id=215673
> > > >
> > > > > > 2) A single call to the underlying filestem also means that the
> > > > > >   underlying filesystem only needs to synchronize cached and on-disk
> > > > > >   data one time instead of potentially many speeding up the reply.
> > > >
> > > > SEEK_HOLE/DATA doesn't require cached data to be sync'd to disk to
> > > > be coherent - that's only a problem FIEMAP has (and syncing cached
> > > > data doesn't fix the TOCTOU coherency issue!).  i.e. SEEK_HOLE/DATA
> > > > will check the page cache for data if appropriate (e.g. unwritten
> > > > disk extents may have data in memory over the top of them) instead
> > > > of syncing data to disk.
> > >
> > > For some reason, btrfs on virtual hardware has terrible performance
> > > numbers when using vfs_llseek() with files that are already in the
> > > server's cache. I think it had something to do with how they lock
> > > extents, and some extra work that needs to be done if the file already
> > > exists in the server's memory but it's been  a few years since I've
> > > gone into their code to figure out where the slowdown is coming from.
> > > See this section of my performance results wiki page:
> > > https://wiki.linux-nfs.org/wiki/index.php/Read_Plus_May_2022#BTRFS_3
> > >
> >
> > I just did this locally, once in my test vm's and once on my continuous
> > performance testing hardware and I'm not able to reproduce the numbers, so I
> > think I'm doing something wrong.
> >
> > My test is stupid, I just dd a 5gib file, come behind it and punch holes every
> > other 4k.  Then I umount and remount, SEEK_DATA+SEEK_HOLE through the whole
> > file, and then do it again so I have uncached and cached.  The numbers I'm
> > seeing are equivalent to ext4/xfs.  Granted on my VM I had to redo the test
> > because I had lockdep and other debugging on which makes us look stupid because
> > of the extent locking stuff, but with it off everything appears normal.
> >
> > Does this more or less mirror your testing?  Looking at our code we're not doing
> > anything inherently stupid, so I'm not entirely sure what could be the problem.
> > Thanks,
> 
> I think that's pretty close to what the server is doing with the
> current code, except the NFS server would also do a read for every
> data segment it found. I've been using `vmtouch` to make sure the file
> doesn't get evicted from the server's page cache for my cached data.
>

I messed with it some more and I can't get it to be slow.  If you trip over
something like this again just give a shout and I'd be happy to dig in.  Thanks,

Josef 
