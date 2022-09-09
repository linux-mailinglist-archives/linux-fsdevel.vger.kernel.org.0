Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A1A5B3B52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiIIO6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 10:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiIIO6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:58:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5277138646;
        Fri,  9 Sep 2022 07:58:27 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-160-102.corp.google.com [104.133.160.102] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 289Ew10l001494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 10:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662735488; bh=vltgW/497ssICvI79c1LZB9Nq2N7w8/7ZtnVK7GOrnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PBG3ECnnbpz5+0FPCf1CST7S2mVOTUFasSMo2qCEMH6AjNmVT/HXG6grbqsIUHl3G
         YFKHEdghRHcjIvEkkAlUGYa9cLBlLOgJxYhj+H+cGwimW6d8pzzjMtRhi3PwAMfZiU
         0pw0rsHe4w7aRhL65LKCVzDJNqOQI2IV0FPN8xtJrtEwtyRt9zA16CET3GiI4dQPMs
         jyWnNImoG/W/Advyk1y/QSJcyfrwvyCThvaS75Mfb0VDQUlDPcP8k2N/ivM0LRT/GV
         gUJ60dijj5TAUfNZZvG23IFwn3xb8ptevIy5SiWd/bsTBFSlkOYmFP9v+6tYrWdCot
         nWzEbsJsOmujA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id B63508C2B49; Fri,  9 Sep 2022 10:58:00 -0400 (EDT)
Date:   Fri, 9 Sep 2022 10:58:00 -0400
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
Message-ID: <YxtUeE4OouV7jUF9@mit.edu>
References: <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3>
 <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <YxstWiu34TfJ6muW@mit.edu>
 <6173b33e43ac8b0e4377b5d65fec7231608f71f7.camel@kernel.org>
 <YxtEHIkfX0nQQC0n@mit.edu>
 <8b556c2dadb717a25ab47f02f70cfaaa6c6074c7.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b556c2dadb717a25ab47f02f70cfaaa6c6074c7.camel@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 10:43:30AM -0400, Jeff Layton wrote:

> In general, we want to bump i_version if the ctime changes. I'm guessing
> that we don't change ctime on a delalloc? If it's not visible to NFS,
> then NFS won't care about it.  We can't project FIEMAP info across the
> wire at this time, so we'd probably like to avoid seeing an i_version
> bump in due to delalloc.

Right, currently nothing user-visible changes when delayed allocation
is resolved; ctime isn't bumped, and i_version shouldn't be bumped
either.

If we crash before delayed allocation is resolved, there might be
cases (mounting with data=writeback is the one which I'm most worried
about, but I haven't experimented to be sure) where the inode might
become a zero-length file after the reboot without i_version or ctime
changing, but given that NFS forces a fsync(2) before it acknowledges
a client request, that shouldn't be an issue for NFS.

This is where as far I'm concerned, for ext4, i_version has only one
customer to keep happy, and it's NFS.  :-)    Now, if we expose i_version
via statx(2), we might need to be a tad bit more careful about what
semantics we guarantee to userspace, especially with respect to what
might be returned before and after a crash recovery.  If we can leave
things such that there is maximal freedom for file system
implementations, that would be my preference.

						- Ted
