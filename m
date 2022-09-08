Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5D5B2672
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiIHTIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIHTIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:08:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42085C0BD8;
        Thu,  8 Sep 2022 12:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF8AE61DF3;
        Thu,  8 Sep 2022 19:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EDEC433D6;
        Thu,  8 Sep 2022 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662664082;
        bh=21IEzqn0tspcrehkVG8v49sph6nh4+Q9lVwsF/n31JI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W44j+0rNX9Wr4l5p+JvMqUR/9vLJfFf1gWDVodt/LgY4a9cyx4OnEXO1P7z7GiVeY
         4oJMzDqeoxUnTAUgQWXa5LZ06iJnpwnGGU3Ml6nj579m5Y0sxA0L7baIzvltKEau4n
         3jXg8seWlg8JT7wmJYIbaZfgfNzVncTbiX9cRtN/AlgMQ4uJgTrshTm3F+INgI5YbK
         wySi0oviWAKyzjUJyus5X4ohmQvX2C6/f5rB6cxjNxAP3mwAOJ2cTpOqH4ieVqtqjD
         FANAIYQ3EaJlPOzzmNgamBhMOtcEj0sfDwP2OQo/Si+5JugYc+G5vfO/BI+Rc8gD2A
         1hs0/Kv+aZ1hQ==
Message-ID: <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 15:07:58 -0400
In-Reply-To: <20220908182252.GA18939@fieldses.org>
References: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
         <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <20220907135153.qvgibskeuz427abw@quack3>
         <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
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

On Thu, 2022-09-08 at 14:22 -0400, J. Bruce Fields wrote:
> On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
> > Yeah, ok. That does make some sense. So we would mix this into the
> > i_version instead of the ctime when it was available. Preferably, we'd
> > mix that in when we store the i_version rather than adding it afterward=
.
> >=20
> > Ted, how would we access this? Maybe we could just add a new (generic)
> > super_block field for this that ext4 (and other filesystems) could
> > populate at mount time?
>=20
> Couldn't the filesystem just return an ino_version that already includes
> it?
>=20

Yes. That's simple if we want to just fold it in during getattr. If we
want to fold that into the values stored on disk, then I'm a little less
clear on how that will work.

Maybe I need a concrete example of how that will work:

Suppose we have an i_version value X with the previous crash counter
already factored in that makes it to disk. We hand out a newer version
X+1 to a client, but that value never makes it to disk.

The machine crashes and comes back up, and we get a query for i_version
and it comes back as X. Fine, it's an old version. Now there is a write.
What do we do to ensure that the new value doesn't collide with X+1?=20
--=20
Jeff Layton <jlayton@kernel.org>
