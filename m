Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB55A6D63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiH3TaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiH3TaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EBB1FCC0;
        Tue, 30 Aug 2022 12:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16D4961772;
        Tue, 30 Aug 2022 19:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6D9C433D6;
        Tue, 30 Aug 2022 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661887817;
        bh=nBVnvrKt98aOcRMDXo5kWCSaoHa1L3WfB0MImmB7bsA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LAGBjRI0iICkSCcey3Hj90hGM0SqheIVF3UoW82NBZzIz/pwdUg/h+ZPa9irfUgQB
         1s2LRyXlDCP9C4zI3ji74eomVC+5lmIjm9aAB+/Hcttw0Y+R4eiEnQX2gIwcyylcGZ
         m0HT0zoISUjbBp0qlYJXXVP8gT75R6Rg9V6R2tmBTQbZLwC5VMRi2/IuSdDU2wnnoQ
         s8vbTr0QPN2e82jnZJX+Heu5jjIstCTuxNZNjDoGaO1O9jXsqCQ5asBV74B1QbtBAd
         mUKvBBbd6N/l/Ri+dhT47y56cLzRqElhTacOHddkmxB7PKH22K4iwFitXwtuU0g0vP
         s/YieDF4URcow==
Message-ID: <b3c0e3ae74a6f30547bd5c49c32c17f1e7a13b0c.camel@kernel.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-ceph@vger.kernel.org" <linux-ceph@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "walters@verbum.org" <walters@verbum.org>
Date:   Tue, 30 Aug 2022 15:30:13 -0400
In-Reply-To: <20220830183244.GG26330@fieldses.org>
References: <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
         <166181389550.27490.8200873228292034867@noble.neil.brown.name>
         <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
         <20220830132443.GA26330@fieldses.org>
         <a07686e7e1d1ef15720194be2abe5681f6a6c78e.camel@kernel.org>
         <20220830144430.GD26330@fieldses.org>
         <e4815337177c74a9928098940dfdcb371017a40c.camel@hammerspace.com>
         <20220830151715.GE26330@fieldses.org>
         <3e8c7af5d39870c5b0dc61736a79bd134be5a9b3.camel@hammerspace.com>
         <4adb2abd1890b147dbc61a06413f35d2f147c43a.camel@kernel.org>
         <20220830183244.GG26330@fieldses.org>
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

On Tue, 2022-08-30 at 14:32 -0400, J. Bruce Fields wrote:
> On Tue, Aug 30, 2022 at 01:02:50PM -0400, Jeff Layton wrote:
> > The fact that NFS kept this more loosely-defined is what allowed us to
> > elide some of the i_version bumps and regain a fair bit of performance
> > for local filesystems [1]. If the change attribute had been more
> > strictly defined like you mention, then that particular optimization
> > would not have been possible.
> >=20
> > This sort of thing is why I'm a fan of not defining this any more
> > strictly than we require. Later on, maybe we'll come up with a way for
> > filesystems to advertise that they can offer stronger guarantees.
>=20
> Yeah, the afs change-attribute-as-counter thing seems ambitious--I
> wouldn't even know how to define what exactly you're counting.
>=20
> My one question is whether it'd be worth just defining the thing as
> *increasing*.  That's a lower bar.
>=20

That's a very good question.

One could argue that NFSv4 sort of requires that for write delegations
anyway. All of the existing implementations that I know of do this, so
that wouldn't rule any of them out.

I'm not opposed to adding that constraint. Let me think on it a bit
more.

> (Though admittedly we don't quite manage it now--see again 1631087ba872
> "Revert "nfsd4: support change_attr_type attribute"".)
>=20

Factoring the ctime into the change attr seems wrong, since a clock jump
could make it go backward. Do you remember what drove that change (see
630458e730b8) ?

It seems like if the i_version=A0were to go backward, then the ctime
probably would too, and you'd still see a duplicate change attr.
--=20
Jeff Layton <jlayton@kernel.org>
