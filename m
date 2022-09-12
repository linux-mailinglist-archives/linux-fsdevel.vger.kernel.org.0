Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B085B58A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 12:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiILKnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiILKnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E672BF66;
        Mon, 12 Sep 2022 03:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129DA61185;
        Mon, 12 Sep 2022 10:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44202C433D6;
        Mon, 12 Sep 2022 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662979399;
        bh=HFbxptHJbeklKZuBBOedjhhiYS8C1dAxfzpGwX+ybSk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GX5cscunz3ZzTiwTAjcScG3yJHb8NYzqhsjWgk94imXnA38dLl47l9mHxlNRWXMYO
         wqV9nY9DGHy3fvOW+cqtR+ml5LLq1/z8Hs6Jzodkk74AN1MIo0kcrCOl/+ODfv7Ib+
         9EiubChBy/rQKqgkFgyvPp+2q9tXTQTXhHaFZJ0efGIErTvlqx5g4xjorZ1Ue/YyF2
         grGGctcTD7co/myRa0zlHcDjfM+yEH0jgju9G+zJhl9fDQ7eCC4krnLzd3BN9G7ZRE
         AaX7p3FIESdIztsC7rzgoirgNMbZ7RlI91qch7rHRHv9t4wc0Vywim5iBnhICbSBRO
         b7RLygT77iPFw==
Message-ID: <c1c9f537e67f2d46404a4a3983e9542de49e28bc.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 06:43:15 -0400
In-Reply-To: <166284799157.30452.4308111193560234334@noble.neil.brown.name>
References: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
        , <20220907125211.GB17729@fieldses.org>
        , <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
        , <20220907135153.qvgibskeuz427abw@quack3>
        , <166259786233.30452.5417306132987966849@noble.neil.brown.name>
        , <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>
        , <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
        , <20220908155605.GD8951@fieldses.org>
        , <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
        , <20220908182252.GA18939@fieldses.org>
        , <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <166284799157.30452.4308111193560234334@noble.neil.brown.name>
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

On Sun, 2022-09-11 at 08:13 +1000, NeilBrown wrote:
> On Fri, 09 Sep 2022, Jeff Layton wrote:
> >=20
> > The machine crashes and comes back up, and we get a query for i_version
> > and it comes back as X. Fine, it's an old version. Now there is a write=
.
> > What do we do to ensure that the new value doesn't collide with X+1?=
=20
>=20
> (I missed this bit in my earlier reply..)
>=20
> How is it "Fine" to see an old version?
> The file could have changed without the version changing.
> And I thought one of the goals of the crash-count was to be able to
> provide a monotonic change id.
>=20

"Fine" in the sense that we expect that to happen in this situation.
It's not fine for the clients obviously, which is why we're discussing
mitigation techniques.
--=20
Jeff Layton <jlayton@kernel.org>
