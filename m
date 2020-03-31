Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE0E1988D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 02:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgCaAW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 20:22:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53331 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729019AbgCaAW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:22:26 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A14415C021F;
        Mon, 30 Mar 2020 20:22:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 30 Mar 2020 20:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        fG/iCWf7UOZXnfH+ATlLs3rRuyP99c7ldOnVHq3HQvQ=; b=Gbl5FLoB0ersamj6
        fTWJ7s9t7yQC5c1vvNjDiIy1Rh7nO8/6axGqJqMVCIcQIQqBJTYdtS1r8hXs70Em
        aMCyv/N2OGY1Z/JusrXwcuBuPmNZvq68RcHMORIUBDLTtqMK6DaMazXauziQuexb
        RSxTPqQzezDUcSlt4OeBSa+XwM+oqLYtLL8rsskbEB30tTAzgT/PLDFwpskxORTa
        TPkdL+O1FRXnLFU8hkTHzhMjjTys4eznggOqTCbA85lvgeSXclFAjv1VPlqm05P2
        ca9J8+j7nUx07RcUh8jlihGWfhRkaOX1NfFyGbz+azj2N/Ml8zy+VaxtCKL8x930
        exro3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=fG/iCWf7UOZXnfH+ATlLs3rRuyP99c7ldOnVHq3HQ
        vQ=; b=EaAKaR6r50iNcZLC3ZEQ265a4xQfByjdSv8ReRzb2yykuXxDhdFBzl+Vl
        eGhEhTic9dHaB+j7PVNUxMKHT+flWvkL5Xtxgd5iADwRwNoKILjXnLrXTbKtjbAm
        40g3NbDTXVOU/Ltf3vr6PeEU025bv0ToIXPMqYhK0aiSMGEMN3tqySTfqc1qTs7r
        xuY63tgUYoVOCk5ToG8lVUl45LFa6zJCOjVvYPwgp8G3PS8W3mXZlG5vcVnpVfDN
        dDtut9dDU2gB4k31nLbrtwqot4Hr2lbBFH1ip1v62NwvHlkalnI6urFOYlmh6XFA
        KMmhLSzb2lVwKwb3Hp5jBLTUbdWlA==
X-ME-Sender: <xms:QY2CXrV4Gs3wkmjFbC3E_zal9NJJ20ReO6wYS6TUYpQd5QKgZiEzlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeiiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtle
    drudeiiedrvdefvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:QY2CXt21U2Z3VhyhAnlOI5oQZQittKa9j8Q7Q9SPtuS8zT3iw4N5Ew>
    <xmx:QY2CXs2Y7bHVkIJISgSBqxNEv9LDi-Uv3n-GUaoFreerddcOz9dDHQ>
    <xmx:QY2CXslcDSe2NL0_auwBIrJtSOZc3Blvr8BiBaYen2EmQGeSgTYnRQ>
    <xmx:QY2CXkCNYZttNKPVSd9_zia5Sbp9DhapUljw6EFzYTT48SgdGS3_zA>
Received: from mickey.themaw.net (unknown [118.209.166.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id C26EC3280064;
        Mon, 30 Mar 2020 20:22:22 -0400 (EDT)
Message-ID: <546b7365be9c6315d93464af10fc97d453f39784.camel@themaw.net>
Subject: Re: [PATCH 3/4] vfs: check for autofs expiring dentry in
 follow_automount()
From:   Ian Kent <raven@themaw.net>
To:     "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Mar 2020 08:22:19 +0800
In-Reply-To: <20200330232032.vmlt3glzqdkgijhy@mayhem.atnf.CSIRO.AU>
References: <158560961146.14841.14430383874338917674.stgit@mickey.themaw.net>
         <158560962258.14841.1166162348928695084.stgit@mickey.themaw.net>
         <20200330232032.vmlt3glzqdkgijhy@mayhem.atnf.CSIRO.AU>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-03-30 at 23:20 +0000, McIntyre, Vincent (CASS, Marsfield)
wrote:
> On Tue, Mar 31, 2020 at 07:07:02AM +0800, Ian Kent wrote:
> > follow_automount() checks if a stat family system call path walk is
> > being done on a positive dentry and and returns -EISDIR to indicate
> > the dentry should be used as is without attempting an automount.
> > 
> > But if autofs is expiring the dentry at the time it should be
> > remounted following the expire.
> > 
> > There are two cases, in the case of a "nobrowse" indirect autofs
> > mount it would have been mounted on lookup anyway. In the case of
> > a "browse" indirect or direct autofs mount re-mounting it will
> > maintain the mount which is what user space would be expected.
> > 
> > This will defer expiration of the mount which might lead to mounts
> > unexpectedly remaining mounted under heavy stat activity but
> > there's
> > no other choice in order to maintain consistency for user space.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> > fs/autofs/root.c |   10 +++++++++-
> > fs/namei.c       |   13 +++++++++++--
> > 2 files changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> > index a1c9c32e104f..b3f748e4df08 100644
> > --- a/fs/autofs/root.c
> > +++ b/fs/autofs/root.c
> > @@ -406,9 +406,17 @@ static int autofs_d_manage(const struct path
> > *path, bool rcu_walk)
> > 
> > 	/* Check for (possible) pending expire */
> > 	if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
> > +		/* dentry possibly going to be picked for expire,
> > +		 * proceed to ref-walk mode.
> > +		 */
> > 		if (rcu_walk)
> > 			return -ECHILD;
> > -		return 0;
> > +
> > +		/* ref-walk mode, return 1 so follow_automount()
> > +		 * can wait on the expire outcome and possibly
> > +		 * attempt a re-mount.
> > +		 */
> > +		return 1;
> > 	}
> > 
> > 	/*
> > diff --git a/fs/namei.c b/fs/namei.c
> > index db6565c99825..869e0d4bb4d9 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1227,11 +1227,20 @@ static int follow_automount(struct path
> > *path, struct nameidata *nd,
> > 	 * mounted directory.  Also, autofs may mark negative dentries
> > 	 * as being automount points.  These will need the attentions
> > 	 * of the daemon to instantiate them before they can be used.
> > +	 *
> > +	 * Also if ->d_manage() returns 1 the dentry transit needs
> > +	 * to be managing. For autofs, a return of 1 it tells us the
> 
> Unclear. Do you mean "to be managed." ? Or "managing." ?

Right, and I didn't label these v2 either, bit stressed at the
moment I guess.

Ian
> 
> Cheers
> Vince
> 
> > +	 * dentry might be expired, so proceed to ->d_automount().
> > 	 */
> > 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
> > 			   LOOKUP_OPEN | LOOKUP_CREATE |
> > LOOKUP_AUTOMOUNT)) &&
> > -	    path->dentry->d_inode)
> > -		return -EISDIR;
> > +	    path->dentry->d_inode) {
> > +		if (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) {
> > +			if (!path->dentry->d_op->d_manage(path, false))
> > +				return -EISDIR;
> > +		} else
> > +			return -EISDIR;
> > +	}
> > 
> > 	nd->total_link_count++;
> > 	if (nd->total_link_count >= 40)
> > 
> 
> -- 

