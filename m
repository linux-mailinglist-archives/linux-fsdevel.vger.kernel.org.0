Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1DC5B5CAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiILOvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILOu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:50:59 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47A33A13;
        Mon, 12 Sep 2022 07:50:58 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BA232607F; Mon, 12 Sep 2022 10:50:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BA232607F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662994257;
        bh=VDdSkcB3ak4apclVt/05byVDTIM05k6XxyMCdrwmp68=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ZxaPJSMlBqmONwwNp0emyvFwmdCV+rXkOxnX0QmNvsUqYJ7+nv0vtXBhzTfFolKHm
         8Z4pmf/VYv2EQvLqi0tre+x4AC6HjpEkOV3yYDAwkEgUFVH4VeM3qN5geCJuc/Oyte
         4hAXnRcuTFvpSfnwUcfrGO2AyAk6TWRvxbXytk8k=
Date:   Mon, 12 Sep 2022 10:50:57 -0400
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
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220912145057.GE9304@fieldses.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeb314e7104647ccfd83a82bd3092005c337d953.camel@hammerspace.com>
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

On Mon, Sep 12, 2022 at 02:15:16PM +0000, Trond Myklebust wrote:
> On Mon, 2022-09-12 at 09:51 -0400, J. Bruce Fields wrote:
> > On Mon, Sep 12, 2022 at 08:55:04AM -0400, Jeff Layton wrote:
> > > Because of the "seen" flag, we have a 63 bit counter to play with.
> > > Could
> > > we use a similar scheme to the one we use to handle when "jiffies"
> > > wraps? Assume that we'd never compare two values that were more
> > > than
> > > 2^62 apart? We could add i_version_before/i_version_after macros to
> > > make
> > > it simple to handle this.
> > 
> > As far as I recall the protocol just assumes it can never wrap.  I
> > guess
> > you could add a new change_attr_type that works the way you describe.
> > But without some new protocol clients aren't going to know what to do
> > with a change attribute that wraps.
> > 
> > I think this just needs to be designed so that wrapping is impossible
> > in
> > any realistic scenario.  I feel like that's doable?
> > 
> > If we feel we have to catch that case, the only 100% correct behavior
> > would probably be to make the filesystem readonly.
> > 
> 
> Which protocol? If you're talking about basic NFSv4, it doesn't assume
> anything about the change attribute and wrapping.
> 
> The NFSv4.2 protocol did introduce the optional attribute
> 'change_attr_type' that tries to describe the change attribute
> behaviour to the client. It tells you if the behaviour is monotonically
> increasing, but doesn't say anything about the behaviour when the
> attribute value overflows.
> 
> That said, the Linux NFSv4.2 client, which uses that change_attr_type
> attribute does deal with overflow by assuming standard uint64_t wrap
> around rules. i.e. it assumes bit values > 63 are truncated, meaning
> that the value obtained by incrementing (2^64-1) is 0.

Yeah, it was the MONOTONIC_INCRE case I was thinking of.  That's
interesting, I didn't know the client did that.

--b.
