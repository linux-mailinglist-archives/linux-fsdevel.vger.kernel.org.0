Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28405B381D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIIMrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIIMra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:47:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788BA11B74E;
        Fri,  9 Sep 2022 05:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00256CE227E;
        Fri,  9 Sep 2022 12:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8FFC433D7;
        Fri,  9 Sep 2022 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662727640;
        bh=Cnva1y3A2cFoN7nzWVOTcIQDrf4GVJQh0JlB2O4x0L4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vazc2NJvHKWpQlw/xzaTE9ki7SJKkAQpE7aw4OKk+JypV+srf+XROfTDsFvGj4CZB
         0dnv6h6KYQpC/D5aA2R8dpNkvIPO1koTLhqN4h8tcrncHJYtYY/z+r2ox7Mq4gMyYo
         tXSUOYe0CKXrfH83VEjqZpduf/iztjfVyVTSFEG2brJNBIBBQxMPAbiGdBLdUSoDtE
         UXj/LIWCIwviFS09QPrL0NhmKZBC1qWoN+ApYdGzCkN4QE15IjHaOyzlensQHyudU9
         i95Tam2CbDi5LLkj5gwiKCbjul2KYg3ZNA+pmE557xnEfohpWhKevSgqfqfmTvbeV/
         Qakwp0ErRnzxw==
Message-ID: <6173b33e43ac8b0e4377b5d65fec7231608f71f7.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
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
Date:   Fri, 09 Sep 2022 08:47:17 -0400
In-Reply-To: <YxstWiu34TfJ6muW@mit.edu>
References: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
         <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <20220907135153.qvgibskeuz427abw@quack3>
         <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <YxstWiu34TfJ6muW@mit.edu>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-09-09 at 08:11 -0400, Theodore Ts'o wrote:
> On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
> >=20
> > Ted, how would we access this? Maybe we could just add a new (generic)
> > super_block field for this that ext4 (and other filesystems) could
> > populate at mount time?
>=20
> Yeah, I was thinking about just adding it to struct super, with some
> value (perhaps 0 or ~0) meaning that the file system didn't support
> it.  If people were concerned about struct super bloat, we could also
> add some new function to struct super_ops that would return one or
> more values that are used rarely by most of the kernel code, and so
> doesn't need to be in the struct super data structure.  I don't have
> strong feelings one way or another.
>=20

Either would be fine, I think.

> On another note, my personal opinion is that at least as far as ext4
> is concerned, i_version on disk's only use is for NFS's convenience,

Technically, IMA uses it too, but it needs the same behavior as NFSv4.

> and so I have absolutely no problem with changing how and when
> i_version gets updated modulo concerns about impacting performance.
> That's one of the reasons why being able to update i_version only
> lazily, so that if we had, say, some workload that was doing O_DIRECT
> writes followed by fdatasync(), there wouldn't be any obligation to
> flush the inode out to disk just because we had bumped i_version
> appeals to me.
>=20

i_version only changes now if someone has queried it since it was last
changed. That makes a huge difference in performance. We can try to
optimize it further, but it probably wouldn't move the needle much under
real workloads.

> But aside from that, I don't consider when i_version gets updated on
> disk, especially what the semantics are after a crash, and if we need
> to change things so that NFS can be more performant, I'm happy to
> accomodate.  One of the reasons why we implemented the ext4 fast
> commit feature was to improve performance for NFS workloads.
>=20
> I know some XFS developers have some concerns here, but I just wanted
> to make it be explicit that (a) I'm not aware of any users who are
> depending on the i_version on-disk semantics, and (b) if they are
> depending on something which as far as I'm concerned in an internal
> implementation detail, we've made no promises to them, and they can
> get to keep both pieces.  :-)  This is especially since up until now,
> there is no supported, portable userspace interface to make i_version
> available to userspace.
>=20

Great! That's what I was hoping for with ext4. Would you be willing to
pick up these two patches for v6.1?

https://lore.kernel.org/linux-ext4/20220908172448.208585-3-jlayton@kernel.o=
rg/T/#u
https://lore.kernel.org/linux-ext4/20220908172448.208585-4-jlayton@kernel.o=
rg/T/#u

They should be able to go in independently of the rest of the series and
I don't forsee any big changes to them.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
