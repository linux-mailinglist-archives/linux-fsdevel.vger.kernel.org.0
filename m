Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA305B6AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 11:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiIMJjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 05:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIMJje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:39:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2A10E9;
        Tue, 13 Sep 2022 02:39:31 -0700 (PDT)
Received: from letrec.thunk.org ([185.122.133.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28D9cu5U003944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1663061946; bh=G7mfMTxIhO2dJDEzf6XiznIO1C37bfNYVMZnFYYDpfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Y6+LcTEHkFj2wDbDzypsKBa9asmbb+u9juMHKg/la5ygB9di9baoPrd7VsSQ4J4rq
         O3CPHqjPzIpUq7+6bePkemcvx00k04ANvoHk06kgSuxF+xjvcdL4SmzfwkprV00hzf
         oBlG0nNC/6UE+zcALHHnyykTa5afqLKozgNsm5vNYO2JeaWb3TFqmh+NHFYyQxG4QB
         z9tvj/8dF9pGJk4lewP2AZElY4oQUwLqXJZCyzRnO34YGbGES+UlFPNBEpcgh30Gjo
         qgK6OTNSq/Yi1PCL811322LaNiQN473z3jZTj0GjzbUY4XCEGPD1uEPr8uk5AL+wIX
         kOBun6/6OYd3g==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 6C7A48C3288; Tue, 13 Sep 2022 05:38:56 -0400 (EDT)
Date:   Tue, 13 Sep 2022 05:38:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>, Jan Kara <jack@suse.cz>,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <YyBPsDZoEL5yDc3G@mit.edu>
References: <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <20220909154506.GB5674@fieldses.org>
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
 <20220910145600.GA347@fieldses.org>
 <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
 <20220913004146.GD3600936@dread.disaster.area>
 <166303374350.30452.17386582960615006566@noble.neil.brown.name>
 <20220913024109.GF3600936@dread.disaster.area>
 <166303985824.30452.7333958999671590160@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166303985824.30452.7333958999671590160@noble.neil.brown.name>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 01:30:58PM +1000, NeilBrown wrote:
> On Tue, 13 Sep 2022, Dave Chinner wrote:
> > 
> > Indeed, we know there are many systems out there that mount a
> > filesystem, preallocate and map the blocks that are allocated to a
> > large file, unmount the filesysetm, mmap the ranges of the block
> > device and pass them to RDMA hardware, then have sensor arrays rdma
> > data directly into the block device.....
> 
> And this tool doesn't update the i_version?  Sounds like a bug.

Tools that do this include "grub" and "lilo".  Fortunately, most
people aren't trying to export their /boot directory over NFS.  :-P

That being said, all we can strive for is "good enough" and not
"perfection".  So if I were to add a "crash counter" to the ext4
superblock, I can make sure it gets incremented (a) whenever the
journal is replayed (assuming that we decide to use lazytime-style
update for i_version for performance reasons), or (b) when fsck needs
to fix some file system inconsistency, or (c) when some external tool
like debugfs or fuse2fs is modifying the file system.

Will this get *everything*?  No.  For example, in addition Linux boot
loaders, there might be userspace which uses FIEMAP to get the
physical blocks #'s for a file, and then reads and writes to those
blocks using a kernel-bypass interface for high-speed SSDs, for
example.  I happen to know of thousands of machines that are doing
this with ext4 in production today, so this isn't hypothetical
example; fortuntely, they aren't exporting their file system over NFS,
nor are they likely to do so.  :-)

		    	    	      		   - Ted
