Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B25A671E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 17:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiH3PRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 11:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiH3PRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:17:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5855FFB2A2;
        Tue, 30 Aug 2022 08:17:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CCB8C87D; Tue, 30 Aug 2022 11:17:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CCB8C87D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1661872635;
        bh=q6SdusgVP46YjJG0KIbUJGeX+adV7Y2Js9pdVBjqjac=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=hCdSwf0UX09/gBg8h2EV/xd0Onq+x8lxk/1uqnLrU7swQzOoLBAqj30o+dwBY4ANk
         xcmsQnZPRlgGe6l/i/qkL1XZ7pKuon1XRFjPvgc9Fzp+Po+HnO2eFLRgDMQuK6A8H5
         uHhRgDUL6Bh3MJXwqMD15Cq3Yb/jHnO0ShtysX+I=
Date:   Tue, 30 Aug 2022 11:17:15 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
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
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Message-ID: <20220830151715.GE26330@fieldses.org>
References: <20220826214703.134870-1-jlayton@kernel.org>
 <20220826214703.134870-2-jlayton@kernel.org>
 <20220829075651.GS3600936@dread.disaster.area>
 <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
 <166181389550.27490.8200873228292034867@noble.neil.brown.name>
 <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
 <20220830132443.GA26330@fieldses.org>
 <a07686e7e1d1ef15720194be2abe5681f6a6c78e.camel@kernel.org>
 <20220830144430.GD26330@fieldses.org>
 <e4815337177c74a9928098940dfdcb371017a40c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4815337177c74a9928098940dfdcb371017a40c.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:58:27PM +0000, Trond Myklebust wrote:
> On Tue, 2022-08-30 at 10:44 -0400, J. Bruce Fields wrote:
> > On Tue, Aug 30, 2022 at 09:50:02AM -0400, Jeff Layton wrote:
> > > On Tue, 2022-08-30 at 09:24 -0400, J. Bruce Fields wrote:
> > > > On Tue, Aug 30, 2022 at 07:40:02AM -0400, Jeff Layton wrote:
> > > > > Yes, saying only that it must be different is intentional. What
> > > > > we
> > > > > really want is for consumers to treat this as an opaque value
> > > > > for the
> > > > > most part [1]. Therefore an implementation based on hashing
> > > > > would
> > > > > conform to the spec, I'd think, as long as all of the relevant
> > > > > info is
> > > > > part of the hash.
> > > > 
> > > > It'd conform, but it might not be as useful as an increasing
> > > > value.
> > > > 
> > > > E.g. a client can use that to work out which of a series of
> > > > reordered
> > > > write replies is the most recent, and I seem to recall that can
> > > > prevent
> > > > unnecessary invalidations in some cases.
> > > > 
> > > 
> > > That's a good point; the linux client does this. That said, NFSv4
> > > has a
> > > way for the server to advertise its change attribute behavior [1]
> > > (though nfsd hasn't implemented this yet).
> > 
> > It was implemented and reverted.  The issue was that I thought nfsd
> > should mix in the ctime to prevent the change attribute going
> > backwards
> > on reboot (see fs/nfsd/nfsfh.h:nfsd4_change_attribute()), but Trond
> > was
> > concerned about the possibility of time going backwards.  See
> > 1631087ba872 "Revert "nfsd4: support change_attr_type attribute"".
> > There's some mailing list discussion to that I'm not turning up right
> > now.

https://lore.kernel.org/linux-nfs/a6294c25cb5eb98193f609a52aa8f4b5d4e81279.camel@hammerspace.com/
is what I was thinking of but it isn't actually that interesting.

> My main concern was that some filesystems (e.g. ext3) were failing to
> provide sufficient timestamp resolution to actually label the resulting
> 'change attribute' as being updated monotonically. If the time stamp
> doesn't change when the file data or metadata are changed, then the
> client has to perform extra checks to try to figure out whether or not
> its caches are up to date.

That's a different issue from the one you were raising in that
discussion.

> > Did NFSv4 add change_attr_type because some implementations needed
> > the
> > unordered case, or because they realized ordering was useful but
> > wanted
> > to keep backwards compatibility?  I don't know which it was.
> 
> We implemented it because, as implied above, knowledge of whether or
> not the change attribute behaves monotonically, or strictly
> monotonically, enables a number of optimisations.

Of course, but my question was about the value of the old behavior, not
about the value of the monotonic behavior.

Put differently, if we could redesign the protocol from scratch would we
actually have included the option of non-monotonic behavior?

--b.
