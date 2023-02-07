Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B168DF36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 18:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjBGRrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 12:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjBGRrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:47:03 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47D55BE
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 09:46:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DBF15C01DA;
        Tue,  7 Feb 2023 12:46:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 Feb 2023 12:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675792009; x=1675878409; bh=NJnm3pGiSA
        1Oouve6EGv630skZ5T3gQkzfZXp699Q/Y=; b=jNuD/X1qmBSDWzBJGF6v4GrCs/
        sBUq2abR//D6dbcnZYyS7FyrVVCMC0uGI2wYrCBBDKlmqDgM3ToT7ubf5Uc5pvmL
        fKHobrXb4vBLAZta85NGz8+bkqLjtHP8DaARiHBnLZ5kpFPnYpuss0QdjcYMOqlD
        sKvnkD/ddGvwWF1IQALQ30endHnzVUDNBbT3eqNCcVWS2XejjAZVGsNku+MPPr2s
        fA9rLMzGNrgNQR6eusL1mBgQ3guhvpHMbQZEwQcVeWT87P/L6RfrHkr2vU0Rk9V3
        kdFl15aQL10p5tF7bOINxupBbDjVJFYMVq0lZvo+43ioCaWQwDEkbyc1BejQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675792009; x=1675878409; bh=NJnm3pGiSA1Oouve6EGv630skZ5T
        3gQkzfZXp699Q/Y=; b=hdqxZq7vkk+gI35mN1cdGTzjDuc6T3smj+6Kjg0AXqW1
        vkvyI/vulSBSIgnRNpbzjj9Dvv2gMLc5KmQBx0ujkFxt2lem1ol/LIG2dd9rGP8T
        +qIztAnaqYo7uOutDKPEFRa3uY+EDIKrmpsTL3l3nUCt1a/QOp6kcpvHnRw0W+/L
        TEY9zVPrQybATFu6PCvirm9gW02T2iPMmxsOC35tEH0+7etyOG4CMmEXH+dtDQP9
        sW5khaWzVUpJaBBmvFZHWOyZebX3qoNgbicRrqZy8gdr4+yhCcr29K/HIMYFUpOm
        i6+cU+tvPVieE14G18c0n3AMlt/BZaWYkCBSTUR6fQ==
X-ME-Sender: <xms:iI7iYz15_g2tIrhR3W8fjUVoBJBphVf542M-0VH-mQNqICnU_D-VUw>
    <xme:iI7iYyGJeIgUCsnhI5o9iFxg05Lp1gcPqS7V-rqAQYZ3yuUCZrSCumaJB6-kmRRbY
    ShYJOVP_sP6Q2cj_t8>
X-ME-Received: <xmr:iI7iYz5hUmZ2gIBSLA78kH5C0ZFmTZVNLqzThasogtZddJOuNyG6D1jY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epleffgeevgeetueegledtueeluddtudekhefhudeuheegfeevieehteevieejueetnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:iI7iY42HfEIwZnsXcSNizi1ATszFC2KkbEylYnwYSA1cSu1BFKbRKQ>
    <xmx:iI7iY2EpDqkkrrPOz-KtRHKitJfG6FduufzwqOpsbKRIIVF2XYMnnw>
    <xmx:iI7iY59gh3i8sN84cbQz8yFVyt1Oqyu-Et1h88n5cyQDUj25wTFTYg>
    <xmx:iY7iYzIjMrND-DK5poTSEcfAOLMvoKICIYFfguLEtQRM07QAtU5mXw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 12:46:47 -0500 (EST)
Date:   Tue, 7 Feb 2023 09:46:46 -0800
From:   Boris Burkov <boris@bur.io>
To:     Hans Holmberg <hans@owltronix.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Message-ID: <Y+KOhvnMCyi2NRRZ@zen>
References: <20230206134148.GD6704@gsv>
 <22843ea8-1668-85db-3ba3-f5b4386bba38@wdc.com>
 <CANr-nt2q-1GjE6wx4W+6cSV9RULd8PKmS2-qyE2NvhRgMNawXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANr-nt2q-1GjE6wx4W+6cSV9RULd8PKmS2-qyE2NvhRgMNawXQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:31:44PM +0100, Hans Holmberg wrote:
> On Mon, Feb 6, 2023 at 3:24 PM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
> >
> > On 06.02.23 14:41, Hans Holmberg wrote:
> > > Out of the upstream file systems, btrfs and f2fs supports
> > > the zoned block device model. F2fs supports active data placement
> > > by separating cold from hot data which helps in reducing gc,
> > > but there is room for improvement.
> >
> > FYI, there's a patchset [1] from Boris for btrfs which uses different
> > size classes to further parallelize placement. As of now it leaves out
> > ZNS drives, as this can clash with the MOZ/MAZ limits but once active
> > zone tracking is fully bug free^TM we should look into using these
> > allocator hints for ZNS as well.
> >
> 
> That looks like a great start!
> 
> Via that patch series I also found Josef's fsperf repo [1], which is
> exactly what I have
> been looking for: a set of common tests for file system performance. I hope that
> it can be extended with longer-running tests doing several disk overwrites with
> application-like workloads.

It should be relatively straightforward to add more tests to fsperf and
we are happy to take new workloads! Also, feel free to shoot me any
questions you run into while working on it and I'm happy to help.

> 
> > The hot/cold data can be a 2nd placement hint, of cause, not just the
> > different size classes of an extent.
> 
> Yes. I'll dig into the patches and see if I can figure out how that
> could be done.

FWIW, I was working on reducing fragmentation/streamlining reclaim for
non zoned btrfs. I have another patch set that I am still working on
which attempts to use a working set concept to make placement
lifetime/lifecycle a bigger part of the btrfs allocator.

That patch set tries to make btrfs write faster in parallel, which may
be against what you are going for, that I'm not sure of. Also, I didn't
take advantage of the lifetime hints because I wanted it to help for the
general case, but that could be an interesting direction too!

If you're curious about that work, the current state of the patches is
in this branch:
https://github.com/kdave/btrfs-devel/compare/misc-next...boryas:linux:bg-ws
(Johannes, those are the patches I worked on after you noticed the
allocator being slow with many disks.)

Boris

> 
> Cheers,
> Hans
> 
> [1] https://github.com/josefbacik/fsperf
