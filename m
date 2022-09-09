Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B8C5B39BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiIINtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiIINsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:48:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5E1440B1;
        Fri,  9 Sep 2022 06:48:41 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-160-102.corp.google.com [104.133.160.102] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 289DmD4S023395
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 09:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662731299; bh=O5sAtHVRdkSq6fYIsc381bORr53qSj8BKwqEoyxQ59Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PmbwItvn9P3WqbgD5xUd+ssUjKyMScw+Pr6EgsRKO9wCSCDDPWa+jc92EnUQTGb5I
         JTs6ZJDJLL1zNDfS/OL+dy9pZ/XjEZoEOOcQETfbLaSdWLs+zlJbJizGH0+89J+bkk
         zvIz7o8V9KeYYD8irYItIozZ/3p3dEXptOMt68Ky3/EGg1rmTSGChq4Kdv1AcozORP
         jCSoZ2JO95UmLiyYwKUz1Iij2oyigPv0/SAdG+4VChwK1yIO2U7PkMv6DYXVeT6/7w
         Sbw2kiE3sE9AT8ZvP5uB96BevaqxBbbKtvmQDTKdzt5qvjfZv/l5C3MDkjy9nthcsA
         7oN/BE/T/tIBg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id DD0598C2B49; Fri,  9 Sep 2022 09:48:12 -0400 (EDT)
Date:   Fri, 9 Sep 2022 09:48:12 -0400
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
Message-ID: <YxtEHIkfX0nQQC0n@mit.edu>
References: <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
 <20220907135153.qvgibskeuz427abw@quack3>
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3>
 <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <YxstWiu34TfJ6muW@mit.edu>
 <6173b33e43ac8b0e4377b5d65fec7231608f71f7.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6173b33e43ac8b0e4377b5d65fec7231608f71f7.camel@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 08:47:17AM -0400, Jeff Layton wrote:
> 
> i_version only changes now if someone has queried it since it was last
> changed. That makes a huge difference in performance. We can try to
> optimize it further, but it probably wouldn't move the needle much under
> real workloads.

Good point.  And to be clear, from NFS's perspective, you only need to
have i_version bumped if there is a user-visible change to the
file. --- with an explicit exception here of the FIEMAP system call,
since in the case of a delayed allocation, FIEMAP might change from
reporting:

 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:          0..         0:      0:             last,unknown_loc,delalloc,eof

to this:

 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:  190087172.. 190087172:      1:             last,eof

after a sync(2) or fsync(2) call, or after time passes.

> Great! That's what I was hoping for with ext4. Would you be willing to
> pick up these two patches for v6.1?
> 
> https://lore.kernel.org/linux-ext4/20220908172448.208585-3-jlayton@kernel.org/T/#u
> https://lore.kernel.org/linux-ext4/20220908172448.208585-4-jlayton@kernel.org/T/#u

I think you mean:

https://lore.kernel.org/linux-ext4/20220908172448.208585-2-jlayton@kernel.org/T/#u
https://lore.kernel.org/linux-ext4/20220908172448.208585-3-jlayton@kernel.org/T/#u

Right?

BTW, sorry for not responding to these patches earlier; between
preparing for the various Linux conferences in Dublin next week, and
being in Zurich and meeting with colleagues at $WORK all of this week,
I'm a bit behind on my patch reviews.

Cheers,

					- Ted
