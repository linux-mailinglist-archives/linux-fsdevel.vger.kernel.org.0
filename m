Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9144049199C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 03:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiARCzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 21:55:17 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51353 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345807AbiARCcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:32:04 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D682C3200946;
        Mon, 17 Jan 2022 21:32:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Jan 2022 21:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        3mRA+fAp1gnVKZsZvkvI9SKUFhnHcen/USfAGlZMD/8=; b=J1u9Ac5VDXG/UgfA
        F8k48UeRsyAyOn/Y50lgKLzHMDZI+ShW7HwAVKNSeugYAhLsjh0BPxpo4JwDF2pg
        WsMLL8f78+K643A5XY4XJ08C0Qf+w6HqXYlEXsxdiGkwScq5s/aYjuvmvzuropJt
        fMkQeb1ceDG4lpxiTrkJFfYaQE6M6JekrwgAdCEutgAhGu8h2W613VZYncd7FGpp
        oKf7kXK0nHAYljf/n7RFFS/DPUiev4r8WaLzCN6suPwbInNAZ8iyYqu8IB+qIRxz
        dqUpXsr8BQfBjRaFPixaCT3VqjLWiKQCwMd0vLQwG0gw8iRMHrBkZKAfb8nwEJd3
        d17PVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=3mRA+fAp1gnVKZsZvkvI9SKUFhnHcen/USfAGlZMD
        /8=; b=ITwNEwhut6PP8iq1nNC8XPTdHIXmjj5o8W3zahgmGmZWysKwg2DduJy/V
        GwT5UF0fD2l2i6k0WrygOK4G2VwKEN49L1J5WauKkKDJQtliqirfUVbRMn56wxFi
        Ho1OiO0SCM49WtBBCm3toZQk98Z3Iscp4XSICloQ2qKxvjkFa8YPgh6m+jWe/nQh
        /uuPg3WeGDBUG/hDmA3cXs9FYBrHF0P//ah2NeVN8qoSx9ZCLkZ5pQacVcb51IP8
        wvCcPgbhvS12RFAZQ6HFhQUAsNAVxEAuwX3rWBgL29DIKA0ezSmy3XDxAVrrYGzB
        sRjXjFUa9XoU72Iy4uwDsFwjov4Gw==
X-ME-Sender: <xms:oSbmYbj_qZA5piY38Id3KBaazhhP5VptdlLDwYRIuX5hZSh9DhFeaQ>
    <xme:oSbmYYBNt-nwe24mh5If3Q6mBAsczYBwW_Q7CEUzauxuONvxr4xduNE6OHO8UJc95
    xjVJtaeX0oz>
X-ME-Received: <xmr:oSbmYbFXDZytBiBBL_Cw7tSauEo0Uznr7bA0zBNINPlfPqZfXiOnF7an2HhUTMZ0P-Kj5RAMzKFpApBrh2PTE_tRBpPnoqryV35TUk-y1Dc9Vtrl9HC1Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtredunecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepff
    elvddtleehveduvefhkeejfedvkeetffeujedtudevfedtveehueeviefhleffnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:oSbmYYTIhggIrp71O7yWw-TQ6b5xK0kAeKGYw1rH_MMcrJ4YapDk8A>
    <xmx:oSbmYYy8fUfoQGXXEPpCZW9FRH8vuaDoUkxCw2MSqJ0k6pxPgkLPOA>
    <xmx:oSbmYe6r5SE_V0WaSMcXu2xkqbgDd2LYHt-RSAy4vi8gjFYNRnND4w>
    <xmx:oibmYbw3j9aiq0OZdyFolqdDMoGwTI4RfeniaHfHt_GCmyBQdzqCOA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 21:31:58 -0500 (EST)
Message-ID: <0f6c2348dae2c47ea46a986884a75fc7d44bb6fb.camel@themaw.net>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Jan 2022 10:31:53 +0800
In-Reply-To: <YeYYp89adipRN64k@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
         <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
         <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
         <YeV+zseKGNqnSuKR@bfoster> <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
         <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
         <YeXIIf6/jChv7JN6@zeniv-ca.linux.org.uk>
         <YeYYp89adipRN64k@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-01-18 at 01:32 +0000, Al Viro wrote:
> On Mon, Jan 17, 2022 at 07:48:49PM +0000, Al Viro wrote:
> > > But that critically depends upon the contents not getting
> > > mangled.  If it
> > > *can* be screwed by such unlink, we risk successful lookup
> > > leading to the
> > > wrong place, with nothing to tell us that it's happening.  We
> > > could handle
> > > that by adding a check to fs/namei.c:put_link(), and propagating
> > > the error
> > > to callers.  It's not impossible, but it won't be pretty.
> > > 
> > > And that assumes we avoid oopsen on string changing under us in
> > > the first
> > > place.  Which might or might not be true - I hadn't finished the
> > > audit yet.
> > > Note that it's *NOT* just fs/namei.c + fs/dcache.c + some fs
> > > methods -
> > > we need to make sure that e.g. everything called by ->d_hash()
> > > instances
> > > is OK with strings changing right under them.  Including
> > > utf8_to_utf32(),
> > > crc32_le(), utf8_casefold_hash(), etc.
> > 
> > And AFAICS, ext4, xfs and possibly ubifs (I'm unfamiliar with that
> > one and
> > the call chains there are deep enough for me to miss something)
> > have the
> > "bugger the contents of string returned by RCU ->get_link() if
> > unlink()
> > happens" problem.
> > 
> > I would very much prefer to have them deal with that crap,
> > especially
> > since I don't see why does ext4_evict_inode() need to do that
> > memset() -
> > can't we simply check ->i_op in ext4_can_truncate() and be done
> > with
> > that?
> 
> This reuse-without-delay has another fun side, AFAICS.  Suppose the
> new use
> for inode comes with the same ->i_op (i.e. it's a symlink again) and
> it
> happens right after ->get_link() has returned the pointer to body.
> 
> We are already past whatever checks we might add in pick_link().  And
> the
> pointer is still valid.  So we end up quietly traversing the body of
> completely unrelated symlink that never had been anywhere near any
> directory
> we might be looking at.  With no indication of anything going wrong -
> just
> a successful resolution with bogus result.

Wouldn't that case be caught by the unlazy call since ->get_link()
needs to return -ECHILD for the rcu case now (in xfs anyway)?

> 
> Could XFS folks explain what exactly goes wrong if we make actual
> marking
> inode as ready for reuse RCU-delayed, by shifting just that into
> ->free_inode()?  Why would we need any extra synchronize_rcu()
> anywhere?


