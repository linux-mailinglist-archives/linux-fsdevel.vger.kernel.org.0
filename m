Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B785B5AC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiILM7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiILM7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:59:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B6C7F;
        Mon, 12 Sep 2022 05:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80C6DB80B21;
        Mon, 12 Sep 2022 12:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174FEC433D6;
        Mon, 12 Sep 2022 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662987569;
        bh=pHJ7AkTbTBW4OmGY68+VWU0dmsFeRL0c8rCpvJCVi+U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=awlRC/ah/zOC3/n+4eKeP0zjpI/WLVz/QauQ7KH+wgSAZU11j8fFn0sJybstsAvVl
         L2TnyK8D1aWG0V1G44z4i34wM7a/3QMmrzwbsGYRdDkYpyrJy4jUM3yg7HFR14syod
         Hnv3cHu8vB6P46n0MU/Mnw8BfBnME+kD/IC5b05z9OQy0c8oDjbprW+rd4u2QLGIn3
         Ixy8kWYpLTa8B9xvh9LtEzS+u8PJHo7m9N39pEcxtStd5lorIsi3HX5ALJOh1eCvwk
         Lz+MtgwtaJcGb4CyO9t2EctV9/mK93ip0f+QLCx7mI6q1txn8BXJyCnEb6ZJHuPXbN
         GxX6wdqFh/Fpw==
Message-ID: <9d6052680b2a86bee7f016401e1a06a63ec35cc1.camel@kernel.org>
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
Date:   Mon, 12 Sep 2022 08:59:25 -0400
In-Reply-To: <20220912125425.GA9304@fieldses.org>
References: <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <20220909154506.GB5674@fieldses.org>
         <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
         <20220910145600.GA347@fieldses.org>
         <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
         <20220912125425.GA9304@fieldses.org>
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

On Mon, 2022-09-12 at 08:54 -0400, J. Bruce Fields wrote:
> On Mon, Sep 12, 2022 at 07:42:16AM -0400, Jeff Layton wrote:
> > A scheme like that could work. It might be hard to do it without a
> > spinlock or something, but maybe that's ok. Thinking more about how we'=
d
> > implement this in the underlying filesystems:
> >=20
> > To do this we'd need 2 64-bit fields in the on-disk and in-memory=20
> > superblocks for ext4, xfs and btrfs. On the first mount after a crash,
> > the filesystem would need to bump s_version_max by the significant
> > increment (2^40 bits or whatever). On a "clean" mount, it wouldn't need
> > to do that.
> >=20
> > Would there be a way to ensure that the new s_version_max value has mad=
e
> > it to disk? Bumping it by a large value and hoping for the best might b=
e
> > ok for most cases, but there are always outliers, so it might be
> > worthwhile to make an i_version increment wait on that if necessary.=
=20
>=20
> I was imagining that when you recognize you're getting close, you kick
> off something which writes s_version_max+2^40 to disk, and then updates
> s_version_max to that new value on success of the write.
>=20

Ok, that makes sense.

> The code that increments i_version checks to make sure it wouldn't
> exceed s_version_max.  If it would, something has gone wrong--a write
> has failed or taken a long time--so it waits or errors out or something,
> depending on desired filesystem behavior in that case.
>=20

Maybe could just throw a big scary pr_warn too? I'd have to think about
how we'd want to handle this case.

> No locking required in the normal case?

Yeah, maybe not.
--=20
Jeff Layton <jlayton@kernel.org>
