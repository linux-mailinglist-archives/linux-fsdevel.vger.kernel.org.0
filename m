Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE545B3766
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIIMOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 08:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiIIMOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:14:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA213FA7F;
        Fri,  9 Sep 2022 05:12:11 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-160-102.corp.google.com [104.133.160.102] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 289CB71n002170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 08:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662725472; bh=rkVib4zKXNES9ZZ4tMSEKXn2YQ6HSV5vUTDr92XDkhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GUfSWT2qQ/AJie7hxQCJZt8BAL8wLB2wXXt3lpNzwVcJDfxeA3n4X9UaHMr+LKaji
         zb8pN4awcYOraVhbePEtz4sCuIcEMxDO2V92UeCIRI87pI75/6Euq2NTZWvCPaRsmz
         DlR2DlvtPX7EziCMExCNHJHLF80Kja7xArncG3AABgQbBA7F8u2okXCFadky2FAyPZ
         ZEVZ5zWSVzlIFf8gSeITjbPkBF1rXnXYwy3TAT0rzEQUsrD4xD5MFcwTetP4Z+bsqn
         5hn1WHr+o8drixmoUTatgnnzVOC8xFKnKtCU1Rq9PX4TQiWPhk9jx/EanCDjjweVSe
         56cLzlKnr1a1Q==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id CD6C38C2B49; Fri,  9 Sep 2022 08:11:06 -0400 (EDT)
Date:   Fri, 9 Sep 2022 08:11:06 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <YxstWiu34TfJ6muW@mit.edu>
References: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
 <20220907125211.GB17729@fieldses.org>
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
 <20220907135153.qvgibskeuz427abw@quack3>
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3>
 <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
> 
> Ted, how would we access this? Maybe we could just add a new (generic)
> super_block field for this that ext4 (and other filesystems) could
> populate at mount time?

Yeah, I was thinking about just adding it to struct super, with some
value (perhaps 0 or ~0) meaning that the file system didn't support
it.  If people were concerned about struct super bloat, we could also
add some new function to struct super_ops that would return one or
more values that are used rarely by most of the kernel code, and so
doesn't need to be in the struct super data structure.  I don't have
strong feelings one way or another.

On another note, my personal opinion is that at least as far as ext4
is concerned, i_version on disk's only use is for NFS's convenience,
and so I have absolutely no problem with changing how and when
i_version gets updated modulo concerns about impacting performance.
That's one of the reasons why being able to update i_version only
lazily, so that if we had, say, some workload that was doing O_DIRECT
writes followed by fdatasync(), there wouldn't be any obligation to
flush the inode out to disk just because we had bumped i_version
appeals to me.

But aside from that, I don't consider when i_version gets updated on
disk, especially what the semantics are after a crash, and if we need
to change things so that NFS can be more performant, I'm happy to
accomodate.  One of the reasons why we implemented the ext4 fast
commit feature was to improve performance for NFS workloads.

I know some XFS developers have some concerns here, but I just wanted
to make it be explicit that (a) I'm not aware of any users who are
depending on the i_version on-disk semantics, and (b) if they are
depending on something which as far as I'm concerned in an internal
implementation detail, we've made no promises to them, and they can
get to keep both pieces.  :-)  This is especially since up until now,
there is no supported, portable userspace interface to make i_version
available to userspace.

Cheers,

					- Ted
