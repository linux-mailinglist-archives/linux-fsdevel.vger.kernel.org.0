Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F06AD3A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCGBBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCGBBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:01:11 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66B52FCDC
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 17:01:08 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 943A95C0163;
        Mon,  6 Mar 2023 20:01:06 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 06 Mar 2023 20:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678150866; x=1678237266; bh=6t
        tRYZyzv2O8slmNiZeyxP2X530IBAGLvqBhwFjnptY=; b=jVQTCHOUWvsGhUTWVm
        RL3pJtRFZdVLSn3/OhZ1n+j0rLLtzPxkI+xJtrIcnuOjm4pFSXZSw7Xo2Juoebr4
        5P2igdyBWC3sU3nCXnjuAm+iINaIhRFdiTGsjQ3W3wlGnzCKl4+rO7cqaqXfjD61
        Zh9QP83OtZgvERUhYDqlswcOMEenSmhA5OvRkYM650wb17ec8HGqFaXAlpoG3IOT
        NqZm42m11gFhOvE4gxX8Z8soUtiaORIELqvclWNoSFJQT6xjUe3lWWs9qWnIU6Js
        qg812RWORdJuiLgCLyMJikXxI+oO/gL93MoaBvmZkD3w48tEQAnzMHNILom+M39X
        J+KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678150866; x=1678237266; bh=6ttRYZyzv2O8s
        lmNiZeyxP2X530IBAGLvqBhwFjnptY=; b=hhUpmQWA++S8ArIULWtXEw+wnNy+a
        u5yXo2jEUPcai/Iaghhn6VvVlJwmgTayp2hdF3o3AyP1HKZ5gA+vjKui1j4yaFoJ
        Xftu5BHE/WH+bmtCWFAeHtHRbxgJlsuGrbUbdyJUPYGA6JVtG1GnNY1T68lGN7Xy
        0wCQRYNYLHG++rNDS+tCM61H1FwNTysZYWU/8d/LrrmSlek17QA6iLqwJw3PDsKT
        KDoajnrUqicPz1VfRT7viq6Tbn43r0HfERiPpTDVAkvuS1WiVNUpRLClY4wTGinU
        eDIwQgIvk75Ie0u0a1z16y/ahbNuYpkEIf+SUeYI6iVSaYOQSFiHmsphg==
X-ME-Sender: <xms:0YwGZKexIhLJAhAjB9TkEduXl4Ys5zFudDmnFdnCsJFQ0zrDUVYmfQ>
    <xme:0YwGZEPKS8QMrtBDIdaagRvOe-7FcLrB17d9up1WdaDGZ2FRzAhb0S3h4MawfqMbU
    2ZI3VQy_Fk2nZsG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtledgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeefffdthfeuuefhudetieelheevtdeikeffiefgkefguefffeek
    jedtfeefhfduhfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgsohhumhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghl
    thgvrhhssehvvghrsghumhdrohhrgh
X-ME-Proxy: <xmx:0YwGZLioITPHsoH1OVrR96hbJTYt_-LYqoZFPBhWxk04CqRtBfF2_g>
    <xmx:0YwGZH-SbWGnTZK1QAIrRUO3HLJ0OCWu2_kM532SWb54hetyaGNAyQ>
    <xmx:0YwGZGs-nVi9y0qr_r1WQ2xmkMvRRlCfe17_AfsOIbCKvjm686vNbA>
    <xmx:0owGZEAv7Ok1bmN7fFd2At9KfPaLwxypgWGa0s3RysoWSKL4oqbJVg>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AA97E2A20080; Mon,  6 Mar 2023 20:01:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <6bea16fa-737f-4aad-a2cd-0a12029e614d@app.fastmail.com>
In-Reply-To: <0a571702-a907-c2b1-bb38-96aa7b268a1b@linux.alibaba.com>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
 <13e7205f-113b-ad47-417f-53b63743c64c@linux.alibaba.com>
 <4782a0db-5780-4309-badf-67f69507cc81@app.fastmail.com>
 <0a571702-a907-c2b1-bb38-96aa7b268a1b@linux.alibaba.com>
Date:   Mon, 06 Mar 2023 20:00:45 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Gao Xiang" <hsiangkao@linux.alibaba.com>,
        "Alexander Larsson" <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Amir Goldstein" <amir73il@gmail.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Jingbo Xu" <jefflexu@linux.alibaba.com>,
        "Giuseppe Scrivano" <gscrivan@redhat.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Vivek Goyal" <vgoyal@redhat.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sat, Mar 4, 2023, at 10:29 AM, Gao Xiang wrote:
> Hi Colin,
>
> On 2023/3/4 22:59, Colin Walters wrote:
>> 
>> 
>> On Fri, Mar 3, 2023, at 12:37 PM, Gao Xiang wrote:
>>>
>>> Actually since you're container guys, I would like to mention
>>> a way to directly reuse OCI tar data and not sure if you
>>> have some interest as well, that is just to generate EROFS
>>> metadata which could point to the tar blobs so that data itself
>>> is still the original tar, but we could add fsverity + IMMUTABLE
>>> to these blobs rather than the individual untared files.
>> 
>>>    - OCI layer diff IDs in the OCI spec [1] are guaranteed;
>> 
>> The https://github.com/vbatts/tar-split approach addresses this problem domain adequately I think.
>
> Thanks for the interest and comment.
>
> I'm not aware of this project, and I'm not sure if tar-split
> helps mount tar stuffs, maybe I'm missing something?

Not directly; it's widely used in the container ecosystem (podman/docker etc.) to split off the original bit-for-bit tar stream metadata content from the actually large data (particularly regular files) so that one can write the files to a regular underlying fs (xfs/ext4/etc.) and use overlayfs on top.   Then it helps reverse the process and reconstruct the original tar stream for pushes, for exactly the reason you mention.

Slightly OT but a whole reason we're having this conversation now is definitely rooted in the original Docker inventor having the idea of *deriving* or layering on top of previous images, which is not part of dpkg/rpm or squashfs or raw disk images etc.  Inherent in this is the idea that we're not talking about *a* filesystem - we're talking about filesystem*s* plural and how they're wired together and stacked.

It's really only very simplistic use cases for which a single read-only filesystem suffices.  They exist - e.g. people booting things like Tails OS https://tails.boum.org/ on one of those USB sticks with a physical write protection switch, etc. 

But that approach makes every OS update very expensive - most use cases really want fast and efficient incremental in-place OS updates and a clear distinct split between OS filesystem and app filesystems.   But without also forcing separate size management onto both.

> Not bacause EROFS cannot do on-disk dedupe, just because in this
> way EROFS can only use the original tar blobs, and EROFS is not
> the guy to resolve the on-disk sharing stuff.  

Right, agree; this ties into my larger point above that no one technology/filesystem is the sole solution in the general case.

> As a kernel filesystem, if two files are equal, we could treat them
> in the same inode address space, even they are actually with slightly
> different inode metadata (uid, gid, mode, nlink, etc).  That is
> entirely possible as an in-kernel filesystem even currently linux
> kernel doesn't implement finer page cache sharing, so EROFS can
> support page-cache sharing of files in all tar streams if needed.

Hmmm.  I should clarify here I have zero kernel patches, I'm a userspace developer (on container and OS updates, for which I'd like a unified stack).  But it seems to me that while you're right that it would be technically possible for a single filesystem to do this, in practice it would require some sort of virtual sub-filesystem internally.  And at that point, it does seem more elegant to me to make that stacking explicit, more like how composefs is doing it.  

That said I think there's a lot of legitimate debate here, and I hope we can continue doing so productively!


