Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD97CFA0E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 14:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfJHMi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 08:38:29 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:56855 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730947AbfJHMi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:38:29 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8FA44343;
        Tue,  8 Oct 2019 08:38:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 08 Oct 2019 08:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        hfkaSFdywXZXNThnIFaLIYh1wgQ+IY77hVCc8U/2iko=; b=dcSLJv/3VA6J/t3j
        dRE7PZn+5QosM9qn3vbwavbEltn+Pxktj0JOJbA1q1ijfpuuYp7F9A+RXFpoKGTh
        dG4XIr0EoplMJBJBc4xcBCsHks83b/8hEGWU5YWGKpWBJzgFc+1yG+VF5HUCs4ze
        kXML6z8Mvr0WtPA0ie4ZjyH5ow8cQuU9kfAV098DDNVfU9qCpTKFY6DMSIjnAiPd
        oWL2paDj+qafHWk/YjZPbuQS5v8xl0wL5zZaBFjr/edHfv4HokrHrPp8IMUo3FCk
        5k1NK9et6g7z9Lf3LZVnmv1vhylaRBmMMMZp1iiNXBiiPCDU7pmdLdwsO5NoPfma
        2Ks7bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=hfkaSFdywXZXNThnIFaLIYh1wgQ+IY77hVCc8U/2i
        ko=; b=cpDUhMAWc3do9ChTbAlDknIbRy5y0G2uUJe1BhPrwHJzep/0gavECKrJH
        Ye7JS2u8CGgWRqSyJFlj0KNQgvGV0I7xhNIYGra7RwTq0KlNUStm0rgYzpNlP6/S
        Ii5pUttlQGttaAiTQuiPJ+8TSoGk9o+rOUXsr86Q+51Uz2miAi6UyIoiDjVik5zx
        BmH1XdZkPoYYOEoxQCr+zHbPYU2ORXCs0fQy1ecZVB224aY/1xIMtvjj8s3/eY/Q
        IqRaGLPxcQflTdBZDVIrdN9qDJuvzY/Y4kt6/G/Ni+hhJEbu66SAXV18cFK/jUHP
        SsX3ekL6Zc6YVg7kOS6MlIRhviDUQ==
X-ME-Sender: <xms:QoOcXUHz6Dj4cnNEWWaDbIEXTspbkvdH2e_JzMbS3RG7aoVUhUahxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuffhomhgrihhnpehrvgguhh
    grthdrtghomhenucfkphepuddukedrvddtledrudekfedrjedunecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:QoOcXfndEyiSHABZe1XlgUkGpSqbRL5scHNGOlblHuwwhepIIsssLg>
    <xmx:QoOcXbyX02io9azoPvjY9oVaybi4PiAH-afaN_nLH3rWGcvbBZM80A>
    <xmx:QoOcXS_xckfx6vNmrJwPdx25C4p0_m1gqoEHScb5sUnOLmvHMM3O3w>
    <xmx:Q4OcXQA3L3fgEmqQv4TII_nFtyztkhFfDoqmze-OOx90PpPu3tZUhQ>
Received: from mickey.themaw.net (unknown [118.209.183.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFBCF80063;
        Tue,  8 Oct 2019 08:38:23 -0400 (EDT)
Message-ID: <59784f8ac4d458a09d40706b554432b283083938.camel@themaw.net>
Subject: Re: mount on tmpfs failing to parse context option
From:   Ian Kent <raven@themaw.net>
To:     Hugh Dickins <hughd@google.com>, Laura Abbott <labbott@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 08 Oct 2019 20:38:18 +0800
In-Reply-To: <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
         <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
         <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-10-07 at 17:50 -0700, Hugh Dickins wrote:
> On Mon, 7 Oct 2019, Laura Abbott wrote:
> > On 9/30/19 12:07 PM, Laura Abbott wrote:
> > > Hi,
> > > 
> > > Fedora got a bug report 
> https://bugzilla.redhat.com/show_bug.cgi?id=1757104
> > > of a failure to parse options with the context mount option. From
> the
> > > reporter:
> > > 
> > > 
> > > $ unshare -rm mount -t tmpfs tmpfs /tmp -o
> > > 'context="system_u:object_r:container_file_t:s0:c475,c690"'
> > > mount: /tmp: wrong fs type, bad option, bad superblock on tmpfs,
> missing
> > > codepage or helper program, or other error.
> > > 
> > > 
> > > Sep 30 16:50:42 kernel: tmpfs: Unknown parameter 'c690"'
> > > 
> > > I haven't asked the reporter to bisect yet but I'm suspecting one
> of the
> > > conversion to the new mount API:
> > > 
> > > $ git log --oneline v5.3..origin/master mm/shmem.c
> > > edf445ad7c8d Merge branch 'hugepage-fallbacks' (hugepatch patches
> from
> > > David Rientjes)
> > > 19deb7695e07 Revert "Revert "Revert "mm, thp: consolidate THP gfp
> handling
> > > into alloc_hugepage_direct_gfpmask""
> > > 28eb3c808719 shmem: fix obsolete comment in shmem_getpage_gfp()
> > > 4101196b19d7 mm: page cache: store only head pages in i_pages
> > > d8c6546b1aea mm: introduce compound_nr()
> > > f32356261d44 vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs
> to use the
> > > new mount API
> > > 626c3920aeb4 shmem_parse_one(): switch to use of fs_parse()
> > > e04dc423ae2c shmem_parse_options(): take handling a single option
> into a
> > > helper
> > > f6490b7fbb82 shmem_parse_options(): don't bother with mpol in
> separate
> > > variable
> > > 0b5071dd323d shmem_parse_options(): use a separate structure to
> keep the
> > > results
> > > 7e30d2a5eb0b make shmem_fill_super() static
> > > 
> > > 
> > > I didn't find another report or a fix yet. Is it worth asking the
> reporter
> > > to bisect?
> > > 
> > > Thanks,
> > > Laura
> > 
> > Ping again, I never heard anything back and I didn't see anything
> come in
> > with -rc2
> 
> Sorry for not responding sooner, Laura, I was travelling: and dearly
> hoping that David or Al would take it.  I'm afraid this is rather
> beyond
> my capability (can I admit that it's the first time I even heard of
> the
> "context" mount option? and grepping for "context" has not yet shown
> me
> at what level it is handled; and I've no idea of what a valid
> "context"
> is for my own tmpfs mounts, to start playing around with its
> parsing).
> 
> Yes, I think we can assume that this bug comes from f32356261d44
> ("vfs:
> Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount
> API")
> or one of shmem_parse ones associated with it; but I'm pretty sure
> that
> it's not worth troubling the reporter to bisect.  I expect David and
> Al
> are familiar with "context", and can go straight to where it's
> handled,
> and see what's up.
> 
> (tmpfs, very tiresomely, supports a NUMA "mpol" mount option which
> can
> have commas in it e.g "mpol=bind:0,2": which makes all its comma
> parsing
> awkward.  I assume that where the new mount API commits bend over to
> accommodate that peculiarity, they end up mishandling the comma in
> the context string above.)
> 
> And since we're on the subject of new mount API breakage in tmpfs,
> I'll
> take the liberty of repeating this different case, reported earlier
> and
> still broken in rc2: again something that I'd be hard-pressed to fix
> myself, without endangering some other filesystem's mount parsing:-
> 
> My /etc/fstab has a line in for one of my test mounts:
> tmpfs                /tlo                 tmpfs     
> size=4G               0 0
> and that "size=4G" is what causes the problem: because each time
> shmem_parse_options(fc, data) is called for a remount, data (that is,
> options) points to a string starting with "size=4G,", followed by
> what's actually been asked for in the remount options.
> 
> So if I try
> mount -o remount,size=0 /tlo
> that succeeds, setting the filesystem size to 0 meaning unlimited.
> So if then as a test I try
> mount -o remount,size=1M /tlo
> that correctly fails with "Cannot retroactively limit size".
> But then when I try
> mount -o remount,nr_inodes=0 /tlo
> I again get "Cannot retroactively limit size",
> when it should have succeeded (again, 0 here meaning unlimited).
> 
> That's because the options in shmem_parse_options() are
> "size=4G,nr_inodes=0", which indeed looks like an attempt to
> retroactively limit size; but the user never asked "size=4G" there.

I believe that's mount(8) doing that.
I don't think it's specific to the new mount api.

AFAIK it's not new but it does mean the that things that come
through that have been found in mtab by mount(8) need to be
checked against the current value before failing or ignored if
changing them is not allowed.

I wonder if the problem has been present for quite a while but
gone unnoticed perhaps.

IIUC the order should always be command line options last and it
must be that way to honour the last specified option takes
precedence convention.

I thought this was well known, but maybe I'm wrong ... and TBH
I wasn't aware of it until recently myself.

> 
> Hugh

