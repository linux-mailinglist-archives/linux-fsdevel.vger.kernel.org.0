Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB925A6DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 21:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiH3Tq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiH3Tqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:46:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06957C309;
        Tue, 30 Aug 2022 12:46:48 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1B6466C85; Tue, 30 Aug 2022 15:46:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1B6466C85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1661888807;
        bh=NtFDftk9McE5vs4ymCO8/T9I3brwYysFh/JkAd8+nrw=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=HNbDQDcAwMSxD3ibVhoYgeFnueypK5U3vblbjyWw5aX2gB8Sp05+6xW3EC67qZXYr
         4lXVctpJ696xjyGWQxgMaPM4n6vFrcszkbKfrmPqQeGie849OcmN4O2GAkrFAU3Ega
         +3bfBRhS7KDKThaouQhgVMqZY1k9uXvqBWe9Y5z4=
Date:   Tue, 30 Aug 2022 15:46:47 -0400
To:     Jeff Layton <jlayton@kernel.org>
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
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Message-ID: <20220830194647.GI26330@fieldses.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3c0e3ae74a6f30547bd5c49c32c17f1e7a13b0c.camel@kernel.org>
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

On Tue, Aug 30, 2022 at 03:30:13PM -0400, Jeff Layton wrote:
> On Tue, 2022-08-30 at 14:32 -0400, J. Bruce Fields wrote:
> > On Tue, Aug 30, 2022 at 01:02:50PM -0400, Jeff Layton wrote:
> > > The fact that NFS kept this more loosely-defined is what allowed us to
> > > elide some of the i_version bumps and regain a fair bit of performance
> > > for local filesystems [1]. If the change attribute had been more
> > > strictly defined like you mention, then that particular optimization
> > > would not have been possible.
> > > 
> > > This sort of thing is why I'm a fan of not defining this any more
> > > strictly than we require. Later on, maybe we'll come up with a way for
> > > filesystems to advertise that they can offer stronger guarantees.
> > 
> > Yeah, the afs change-attribute-as-counter thing seems ambitious--I
> > wouldn't even know how to define what exactly you're counting.
> > 
> > My one question is whether it'd be worth just defining the thing as
> > *increasing*.  That's a lower bar.
> > 
> 
> That's a very good question.
> 
> One could argue that NFSv4 sort of requires that for write delegations
> anyway. All of the existing implementations that I know of do this, so
> that wouldn't rule any of them out.
> 
> I'm not opposed to adding that constraint. Let me think on it a bit
> more.
> 
> > (Though admittedly we don't quite manage it now--see again 1631087ba872
> > "Revert "nfsd4: support change_attr_type attribute"".)
> > 
> 
> Factoring the ctime into the change attr seems wrong, since a clock jump
> could make it go backward. Do you remember what drove that change (see
> 630458e730b8) ?
> 
> It seems like if the i_version were to go backward, then the ctime
> probably would too, and you'd still see a duplicate change attr.

See the comment--I was worried about crashes: the change attribute isn't
on disk at the time the client requests it, so after a crash the client
may see it go backward.  (And then could see it repeat a value, possibly
with different file contents.)

Combining it with the ctime means we get something that behaves
correctly even in that case--unless the clock goes backwards.

--b.
