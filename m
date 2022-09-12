Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1370B5B5DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiILPtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiILPtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:49:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FCB6419;
        Mon, 12 Sep 2022 08:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01429B80DB9;
        Mon, 12 Sep 2022 15:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D37C433C1;
        Mon, 12 Sep 2022 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662997776;
        bh=Y9o8zlfMXVNo23NhygxCl5rFupwZ9JDKU3q8+i8soGs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VgtwOgaOC5ZZZKkHfIbpB574JJEJoW23SXv6vimyQ2E1GZB5xR05EY54KK2XjKTQL
         RuWGai+VBLlIHFi7nY6rbzs9+SbPCKNiChnIdOWdNfZ/GHCGtjH0ZzOdaYHWLEKBBQ
         rcAw9ghpBEVXcE8bjP4GrwYj1Ahu4PzyQ3EEfVbx+NaXmVeffa939fEiix8ie8z9TR
         i8iTLXaYSq9HD9AFPkI/HN5maYCq4lDKoCuMvS/tqG7CFhcIT0iQ4ePyQY0SsUI0HT
         vMiIPRHoFzoXgYtCZ8+s4l/lefw4tdfUv3svux60hS94qA8CxQc+bobZwTg5Cq9PpS
         LREs3tt82vYCw==
Message-ID: <f50919004f95782f0e8f26d9ac0513ee0c7ee432.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date:   Mon, 12 Sep 2022 11:49:33 -0400
In-Reply-To: <44884eeb662c2e304ba644d585b14c65b7dc1a0a.camel@hammerspace.com>
References: <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <20220909154506.GB5674@fieldses.org>
         <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
         <20220910145600.GA347@fieldses.org>
         <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
         <87a67423la.fsf@oldenburg.str.redhat.com>
         <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
         <20220912135131.GC9304@fieldses.org>
         <aeb314e7104647ccfd83a82bd3092005c337d953.camel@hammerspace.com>
         <20220912145057.GE9304@fieldses.org>
         <626f7e46aa25d967b3b92be61cf7059067d1a9c3.camel@hammerspace.com>
         <44884eeb662c2e304ba644d585b14c65b7dc1a0a.camel@hammerspace.com>
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

On Mon, 2022-09-12 at 15:32 +0000, Trond Myklebust wrote:
> On Mon, 2022-09-12 at 14:56 +0000, Trond Myklebust wrote:
> > On Mon, 2022-09-12 at 10:50 -0400, J. Bruce Fields wrote:
> > > On Mon, Sep 12, 2022 at 02:15:16PM +0000, Trond Myklebust wrote:
> > > > On Mon, 2022-09-12 at 09:51 -0400, J. Bruce Fields wrote:
> > > > > On Mon, Sep 12, 2022 at 08:55:04AM -0400, Jeff Layton wrote:
> > > > > > Because of the "seen" flag, we have a 63 bit counter to play
> > > > > > with.
> > > > > > Could
> > > > > > we use a similar scheme to the one we use to handle when
> > > > > > "jiffies"
> > > > > > wraps?=A0Assume that we'd never compare two values that were
> > > > > > more
> > > > > > than
> > > > > > 2^62 apart? We could add i_version_before/i_version_after
> > > > > > macros to
> > > > > > make
> > > > > > it simple to handle this.
> > > > >=20
> > > > > As far as I recall the protocol just assumes it can never
> > > > > wrap.=A0
> > > > > I
> > > > > guess
> > > > > you could add a new change_attr_type that works the way you
> > > > > describe.
> > > > > But without some new protocol clients aren't going to know what
> > > > > to do
> > > > > with a change attribute that wraps.
> > > > >=20
> > > > > I think this just needs to be designed so that wrapping is
> > > > > impossible
> > > > > in
> > > > > any realistic scenario.=A0 I feel like that's doable?
> > > > >=20
> > > > > If we feel we have to catch that case, the only 100% correct
> > > > > behavior
> > > > > would probably be to make the filesystem readonly.
> > > > >=20
> > > >=20
> > > > Which protocol? If you're talking about basic NFSv4, it doesn't
> > > > assume
> > > > anything about the change attribute and wrapping.
> > > >=20
> > > > The NFSv4.2 protocol did introduce the optional attribute
> > > > 'change_attr_type' that tries to describe the change attribute
> > > > behaviour to the client. It tells you if the behaviour is
> > > > monotonically
> > > > increasing, but doesn't say anything about the behaviour when the
> > > > attribute value overflows.
> > > >=20
> > > > That said, the Linux NFSv4.2 client, which uses that
> > > > change_attr_type
> > > > attribute does deal with overflow by assuming standard uint64_t
> > > > wrap
> > > > around rules. i.e. it assumes bit values > 63 are truncated,
> > > > meaning
> > > > that the value obtained by incrementing (2^64-1) is 0.
> > >=20
> > > Yeah, it was the MONOTONIC_INCRE case I was thinking of.=A0 That's
> > > interesting, I didn't know the client did that.
> > >=20
> >=20
> > If you look at where we compare version numbers, it is always some
> > variant of the following:
> >=20
> > static int nfs_inode_attrs_cmp_monotonic(const struct nfs_fattr
> > *fattr,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct inode *ino=
de)
> > {
> > =A0=A0=A0=A0=A0=A0=A0 s64 diff =3D fattr->change_attr -
> > inode_peek_iversion_raw(inode);
> > =A0=A0=A0=A0=A0=A0=A0 if (diff > 0)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 1;
> > =A0=A0=A0=A0=A0=A0=A0 return diff =3D=3D 0 ? 0 : -1;
> > }
> >=20
> > i.e. we do an unsigned 64-bit subtraction, and then cast it to the
> > signed 64-bit equivalent in order to figure out which is the more
> > recent value.
> >=20

Good! This seems like the reasonable thing to do, given that the spec
doesn't really say that the change attribute has to start at low values.

>=20
> ...and by the way, yes this does mean that if you suddenly add a value
> of 2^63 to the change attribute, then you are likely to cause the
> client to think that you just handed it an old value.
>=20
> i.e. you're better off having the crash counter increment the change
> attribute by a relatively small value. One that is guaranteed to be
> larger than the values that may have been lost, but that is not
> excessively large.
>=20

Yeah.

Like with jiffies, you need to make sure the samples you're comparing
aren't _too_ far off. That should be doable here -- 62 bits is plenty of
room to store a lot of change values.

My benchmark (maybe wrong, but maybe good enough) is to figure on an
increment per nanosecond for a worst-case scenario. With that, 2^40
nanoseconds is >12 days. Maybe that's overkill.

2^32 ns is about an hour and 20 mins. That's probably a reasonable value
to use. If we can't get a a new value onto disk in that time then
something is probably very wrong.
--=20
Jeff Layton <jlayton@kernel.org>
