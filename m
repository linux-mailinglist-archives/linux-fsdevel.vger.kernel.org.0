Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D095A6DEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 21:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiH3T5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiH3T5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583A74CE9;
        Tue, 30 Aug 2022 12:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F77AB81DB8;
        Tue, 30 Aug 2022 19:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D09CC433C1;
        Tue, 30 Aug 2022 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661889432;
        bh=qEnq+y8w0F8FFlQgxGff3kVvDpHtDMSD1v4MBtNAnRk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sqBHvgShoQ3iiYXRnJuoee5zj4qiLJcUsK7p4f2bTv0NPYm17U5TWeS9MKuVZe6OA
         O/GYVj9I2uXgoDpLlXwAZC86/6v8nIBqMtbRH1CYIK16rLQUA3gbQVPqpWowJM9jdB
         sgy7uuEKQHOQ62Nt+eXFT0xcFgbyJWhQib7EKcimClgUcJDTTPkOb/fdB4oPqi99Kq
         uFmqpF8YQtu/ZfCZP9i1hwHxEbB180LLnwEv+dCI2OQn7Ka0Q27HQSYFNHnhNT0gGk
         iuW6kxl+IJ4Qj27b9sdiipIvKz16BpqntouI+k1BRf72cJ4h3uRnl6FMcg+YWgNYPZ
         VWyBcCbicamVQ==
Message-ID: <5a3c7887aee7aa360743a71af85b94678feb4fe9.camel@kernel.org>
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
Date:   Tue, 30 Aug 2022 15:57:09 -0400
In-Reply-To: <20220830194647.GI26330@fieldses.org>
References: <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
         <20220830132443.GA26330@fieldses.org>
         <a07686e7e1d1ef15720194be2abe5681f6a6c78e.camel@kernel.org>
         <20220830144430.GD26330@fieldses.org>
         <e4815337177c74a9928098940dfdcb371017a40c.camel@hammerspace.com>
         <20220830151715.GE26330@fieldses.org>
         <3e8c7af5d39870c5b0dc61736a79bd134be5a9b3.camel@hammerspace.com>
         <4adb2abd1890b147dbc61a06413f35d2f147c43a.camel@kernel.org>
         <20220830183244.GG26330@fieldses.org>
         <b3c0e3ae74a6f30547bd5c49c32c17f1e7a13b0c.camel@kernel.org>
         <20220830194647.GI26330@fieldses.org>
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

On Tue, 2022-08-30 at 15:46 -0400, J. Bruce Fields wrote:
> On Tue, Aug 30, 2022 at 03:30:13PM -0400, Jeff Layton wrote:
> > On Tue, 2022-08-30 at 14:32 -0400, J. Bruce Fields wrote:
> > > On Tue, Aug 30, 2022 at 01:02:50PM -0400, Jeff Layton wrote:
> > > > The fact that NFS kept this more loosely-defined is what allowed us=
 to
> > > > elide some of the i_version bumps and regain a fair bit of performa=
nce
> > > > for local filesystems [1]. If the change attribute had been more
> > > > strictly defined like you mention, then that particular optimizatio=
n
> > > > would not have been possible.
> > > >=20
> > > > This sort of thing is why I'm a fan of not defining this any more
> > > > strictly than we require. Later on, maybe we'll come up with a way =
for
> > > > filesystems to advertise that they can offer stronger guarantees.
> > >=20
> > > Yeah, the afs change-attribute-as-counter thing seems ambitious--I
> > > wouldn't even know how to define what exactly you're counting.
> > >=20
> > > My one question is whether it'd be worth just defining the thing as
> > > *increasing*.  That's a lower bar.
> > >=20
> >=20
> > That's a very good question.
> >=20
> > One could argue that NFSv4 sort of requires that for write delegations
> > anyway. All of the existing implementations that I know of do this, so
> > that wouldn't rule any of them out.
> >=20
> > I'm not opposed to adding that constraint. Let me think on it a bit
> > more.
> >=20
> > > (Though admittedly we don't quite manage it now--see again 1631087ba8=
72
> > > "Revert "nfsd4: support change_attr_type attribute"".)
> > >=20
> >=20
> > Factoring the ctime into the change attr seems wrong, since a clock jum=
p
> > could make it go backward. Do you remember what drove that change (see
> > 630458e730b8) ?
> >=20
> > It seems like if the i_version=A0were to go backward, then the ctime
> > probably would too, and you'd still see a duplicate change attr.
>=20
> See the comment--I was worried about crashes: the change attribute isn't
> on disk at the time the client requests it, so after a crash the client
> may see it go backward.  (And then could see it repeat a value, possibly
> with different file contents.)
>=20
> Combining it with the ctime means we get something that behaves
> correctly even in that case--unless the clock goes backwards.
>=20

Yeah ok, I vaguely remember discussing this.

That seems like it has its own problem though. If you mix in the ctime
and the clock jumps backward, then you could end up with the same issue
(a stale changeid, different contents). No crash required.
--=20
Jeff Layton <jlayton@kernel.org>
