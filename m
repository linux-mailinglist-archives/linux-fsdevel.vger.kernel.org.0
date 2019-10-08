Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C70CFA6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 14:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfJHMwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 08:52:25 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37001 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730583AbfJHMwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:52:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A43D43B4;
        Tue,  8 Oct 2019 08:52:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 08 Oct 2019 08:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        sWWB+HqwelmmUXgwL4LO71TxCNnxxsCS/bL5g1opRWE=; b=2p4MN8dDvrfUztgV
        DfV2WcZ8zVDNVa0s9yOJ0/CQo71lqP5KrT1dgoE/7R1z3t8y9dl/kx1BvtTxkwIv
        HinqLkNdOiZOs5AX3Vt6mzzsscmxuu/Kn8p+fpaQV7TvcJlIc1Tn+cx0Px/e8Fpt
        5gg2o9cLWeZsLtw9CLqoRegOnUSs1dOrQf7OP7bFzEsdqNMOp81pHq6JPHiUBiwX
        96zA98jpOuLoPIaCbUbfHn1YjpTSUAGT6AqIx5uz+rx2ousUFmWZ9UGP1zEmY1v3
        DNhCA6rx5XjnHMbSa1Qe4wR34465cKQXgb/vLNHSwJ7LxUA3MzJGy1kQPB4X4YIs
        JCXvbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=sWWB+HqwelmmUXgwL4LO71TxCNnxxsCS/bL5g1opR
        WE=; b=vM2Sjb3kQxi55nwVr2+7Abpr+cw/VVD7p2WXqc/rmDXHXqmSE5+USW0g/
        e/KmU68JL5Gogm6CrZKbHq/XyLspwEWrSAvELOf48UzcpHdEyrM5NbUx5wpeKqlD
        e3+NgMqvrD/Cj2X1PRWQgO1G7/boVqoJNRMQGVLZ3dOtN+WSx1ov90X+ZTQdaqVo
        Tg1VpjoW22zz4vTlWAXpeGk13yR4uWam/xs8EfGFlIJcb/0ub885QvJOxFdLqfhq
        F+rnRx8sqeas3DVjPlwDXen/IdDVJ9PL+sD9Xdy58NPzVNkVauWKJhGWr1NojPLb
        0OsYewGtK7y2HFHjykXr04y+tYxeg==
X-ME-Sender: <xms:hoacXTbfU2Lde6S02zq6s29icpKQIQsnLpvtkahoH7tC8xjmoc7Twg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuffhomhgrihhnpehrvgguhh
    grthdrtghomhenucfkphepuddukedrvddtledrudekfedrjedunecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:hoacXW0y_hkalNA-Y_qlTszBhSOPCWOo7sJN-XbPq8oYnirx5MQf3A>
    <xmx:hoacXSue5zpuFel55H_g66vTALyO9e3bhrxu0R1hcq0tHAtzb0Q4iw>
    <xmx:hoacXbnNINYc6C6TsqADof4PKJbnU7RbugSTfZUsgKfwmkFw6si79Q>
    <xmx:h4acXRmhEFllnJPfQhuCxQ_4jxWBkp4cyEGShMVB8WIO_83zrCrTOA>
Received: from mickey.themaw.net (unknown [118.209.183.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id B3CD780063;
        Tue,  8 Oct 2019 08:52:19 -0400 (EDT)
Message-ID: <924bb2b7ad64a91f4cf3356cd386729760fbdc96.camel@themaw.net>
Subject: Re: mount on tmpfs failing to parse context option
From:   Ian Kent <raven@themaw.net>
To:     Hugh Dickins <hughd@google.com>, Laura Abbott <labbott@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 08 Oct 2019 20:52:15 +0800
In-Reply-To: <59784f8ac4d458a09d40706b554432b283083938.camel@themaw.net>
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
         <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
         <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
         <59784f8ac4d458a09d40706b554432b283083938.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-10-08 at 20:38 +0800, Ian Kent wrote:
> On Mon, 2019-10-07 at 17:50 -0700, Hugh Dickins wrote:
> > On Mon, 7 Oct 2019, Laura Abbott wrote:
> > > On 9/30/19 12:07 PM, Laura Abbott wrote:
> > > > Hi,
> > > > 
> > > > Fedora got a bug report 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1757104
> > > > of a failure to parse options with the context mount option.
> > > > From
> > the
> > > > reporter:
> > > > 
> > > > 
> > > > $ unshare -rm mount -t tmpfs tmpfs /tmp -o
> > > > 'context="system_u:object_r:container_file_t:s0:c475,c690"'
> > > > mount: /tmp: wrong fs type, bad option, bad superblock on
> > > > tmpfs,
> > missing
> > > > codepage or helper program, or other error.
> > > > 
> > > > 
> > > > Sep 30 16:50:42 kernel: tmpfs: Unknown parameter 'c690"'
> > > > 
> > > > I haven't asked the reporter to bisect yet but I'm suspecting
> > > > one
> > of the
> > > > conversion to the new mount API:
> > > > 
> > > > $ git log --oneline v5.3..origin/master mm/shmem.c
> > > > edf445ad7c8d Merge branch 'hugepage-fallbacks' (hugepatch
> > > > patches
> > from
> > > > David Rientjes)
> > > > 19deb7695e07 Revert "Revert "Revert "mm, thp: consolidate THP
> > > > gfp
> > handling
> > > > into alloc_hugepage_direct_gfpmask""
> > > > 28eb3c808719 shmem: fix obsolete comment in shmem_getpage_gfp()
> > > > 4101196b19d7 mm: page cache: store only head pages in i_pages
> > > > d8c6546b1aea mm: introduce compound_nr()
> > > > f32356261d44 vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs
> > to use the
> > > > new mount API
> > > > 626c3920aeb4 shmem_parse_one(): switch to use of fs_parse()
> > > > e04dc423ae2c shmem_parse_options(): take handling a single
> > > > option
> > into a
> > > > helper
> > > > f6490b7fbb82 shmem_parse_options(): don't bother with mpol in
> > separate
> > > > variable
> > > > 0b5071dd323d shmem_parse_options(): use a separate structure to
> > keep the
> > > > results
> > > > 7e30d2a5eb0b make shmem_fill_super() static
> > > > 
> > > > 
> > > > I didn't find another report or a fix yet. Is it worth asking
> > > > the
> > reporter
> > > > to bisect?
> > > > 
> > > > Thanks,
> > > > Laura
> > > 
> > > Ping again, I never heard anything back and I didn't see anything
> > come in
> > > with -rc2
> > 
> > Sorry for not responding sooner, Laura, I was travelling: and
> > dearly
> > hoping that David or Al would take it.  I'm afraid this is rather
> > beyond
> > my capability (can I admit that it's the first time I even heard of
> > the
> > "context" mount option? and grepping for "context" has not yet
> > shown
> > me
> > at what level it is handled; and I've no idea of what a valid
> > "context"
> > is for my own tmpfs mounts, to start playing around with its
> > parsing).
> > 
> > Yes, I think we can assume that this bug comes from f32356261d44
> > ("vfs:
> > Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount
> > API")
> > or one of shmem_parse ones associated with it; but I'm pretty sure
> > that
> > it's not worth troubling the reporter to bisect.  I expect David
> > and
> > Al
> > are familiar with "context", and can go straight to where it's
> > handled,
> > and see what's up.
> > 
> > (tmpfs, very tiresomely, supports a NUMA "mpol" mount option which
> > can
> > have commas in it e.g "mpol=bind:0,2": which makes all its comma
> > parsing
> > awkward.  I assume that where the new mount API commits bend over
> > to
> > accommodate that peculiarity, they end up mishandling the comma in
> > the context string above.)
> > 
> > And since we're on the subject of new mount API breakage in tmpfs,
> > I'll
> > take the liberty of repeating this different case, reported earlier
> > and
> > still broken in rc2: again something that I'd be hard-pressed to
> > fix
> > myself, without endangering some other filesystem's mount parsing:-
> > 
> > My /etc/fstab has a line in for one of my test mounts:
> > tmpfs                /tlo                 tmpfs     
> > size=4G               0 0
> > and that "size=4G" is what causes the problem: because each time
> > shmem_parse_options(fc, data) is called for a remount, data (that
> > is,
> > options) points to a string starting with "size=4G,", followed by
> > what's actually been asked for in the remount options.
> > 
> > So if I try
> > mount -o remount,size=0 /tlo
> > that succeeds, setting the filesystem size to 0 meaning unlimited.
> > So if then as a test I try
> > mount -o remount,size=1M /tlo
> > that correctly fails with "Cannot retroactively limit size".
> > But then when I try
> > mount -o remount,nr_inodes=0 /tlo
> > I again get "Cannot retroactively limit size",
> > when it should have succeeded (again, 0 here meaning unlimited).
> > 
> > That's because the options in shmem_parse_options() are
> > "size=4G,nr_inodes=0", which indeed looks like an attempt to
> > retroactively limit size; but the user never asked "size=4G" there.
> 
> I believe that's mount(8) doing that.
> I don't think it's specific to the new mount api.
> 
> AFAIK it's not new but it does mean the that things that come
> through that have been found in mtab by mount(8) need to be
> checked against the current value before failing or ignored if
> changing them is not allowed.
> 
> I wonder if the problem has been present for quite a while but
> gone unnoticed perhaps.
> 
> IIUC the order should always be command line options last and it
> must be that way to honour the last specified option takes
> precedence convention.
> 
> I thought this was well known, but maybe I'm wrong ... and TBH
> I wasn't aware of it until recently myself.

And it occurs to be that using the same working storage (eg.
ctx->blocks) for more than one option is a problem too.

Even if those options are mutually exclusive the options of
the current mount feed in by mount(8) shouldn't cause the
mount to fail.

Also, and the bit that is mount api specific, the parameter
parsing is done before calling reconfigure so it can't check
if the option is current at that time.

Ian

