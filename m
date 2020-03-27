Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B97195667
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 12:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0LbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 07:31:20 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:54533 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgC0LbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:31:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id E3AE174B;
        Fri, 27 Mar 2020 07:31:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 27 Mar 2020 07:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        1hM4zaFUD+y1ZvA24pWmEadgMLWG+fEgskEHsYlDjG4=; b=nExtzLP+eBMKhYvD
        3snftiXF2+WMahRNtTlswZM28OcKrUix3DiQNE91fcR5Dc1rxBN97GKZWc5KDeVw
        WZA3MuDOKNgHNgR3NbKuPKPRIjnb1srfHKE9wuLY5UWeueeYCU7iPKO52osa/GJn
        9adalpwkJnFaKtq4d+ECCcfr3IXHQSqyX8nW3nEqlN/MY7/AjAUgSEQ9McwU7azr
        bFQMZgRxE4xGhzHZTjWp404JmwLn56R0rfxRksApo9mQ0KbVyq4lciWlrbfi1RkM
        rU3jKzTWaHPVO1rwoJH2VszYmI9Ynd7SL5TFMHXMnzcJyubKkaO5cTfP8oS04hKV
        PlgWvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=1hM4zaFUD+y1ZvA24pWmEadgMLWG+fEgskEHsYlDj
        G4=; b=LrFD9aRoEVLCdt520lqRCVXJLZtFfvVxOi080/v2fMUTEWG+4KkOtazab
        aeh/TrrGlhJAuCpIEt3QZphmQpLPjSMueHbaHtVgNFh7Msr3zGvQf59iI1FcdwPR
        RA3lQ22im+s8vEP8PtYyTyC+dsriNTGe4kItnUyVWjNFS1g+6SUQbRHZtHTTQN/+
        hkguH00UyWKbd5ZrepcQxTYSzwdlAkMebXXzgJAwNV86mvNWHVDHhF4RHsa7zIPq
        gbcqLcBjKTPpjndtiRIdyMlI5HmjntBf0hA7cYt0du8B2JxbjSjdI5CuMirKHVbn
        sytlSfvXsQIUTPCSHMqCD3mMH5LnA==
X-ME-Sender: <xms:BeR9Xrkt2I6rmJ5_G0Td_hL7_VHqPX100tWOMbNT1i9d4LJQv-xfQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtle
    drudeitddrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:BeR9Xlj-K08RI3Va5smOx1x5nGTE8ExvxRvB2lclpaC_LwnaSHM6_w>
    <xmx:BeR9Xr0pKodIXYtDICBS5IcuAdcPm5FSB7ED6B4FJndVM9AOLOkKdw>
    <xmx:BeR9XkOxtOVNV83X02AXvv1305D4miHR0MBf-6ejOEHDFy5Iu82mUQ>
    <xmx:BuR9Xg2UuYnPduTieok5nCnKmiDNdC428c4Qtv4U3K_88KymSZphtw>
Received: from mickey.themaw.net (unknown [118.209.160.209])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92703306C1C8;
        Fri, 27 Mar 2020 07:31:15 -0400 (EDT)
Message-ID: <68080a34970fe41182494a85bcf6d53e75be6d89.camel@themaw.net>
Subject: Re: [PATCH 3/4] vfs: check for autofs expiring dentry in
 follow_automount()
From:   Ian Kent <raven@themaw.net>
To:     "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 27 Mar 2020 19:31:11 +0800
In-Reply-To: <20200327051855.6o6y6l6b3gamlkji@mayhem.atnf.CSIRO.AU>
References: <158520019862.5325.7856909810909592388.stgit@mickey.themaw.net>
         <158520020932.5325.1998880625163566595.stgit@mickey.themaw.net>
         <20200327051855.6o6y6l6b3gamlkji@mayhem.atnf.CSIRO.AU>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-03-27 at 05:18 +0000, McIntyre, Vincent (CASS, Marsfield)
wrote:
> On Thu, Mar 26, 2020 at 01:23:29PM +0800, Ian Kent wrote:
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
> > index a1c9c32e104f..308cc49aca1d 100644
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
> > +		 * can to wait on the expire outcome and possibly
> 
> 'can to wait' ?
> Do you mean: "can wait", "will wait", "knows to wait",
> or something else?

Oops, yes, "can wait" is what that needs to be.

> 
> > +		 * attempt a re-mount.
> > +		 */
> > +		return 1;
> > 	}
> > 
> > 	/*
> > diff --git a/fs/namei.c b/fs/namei.c
> > index db6565c99825..34a03928d32d 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1227,11 +1227,20 @@ static int follow_automount(struct path
> > *path, struct nameidata *nd,
> > 	 * mounted directory.  Also, autofs may mark negative dentries
> > 	 * as being automount points.  These will need the attentions
> > 	 * of the daemon to instantiate them before they can be used.
> > +	 *
> > +	 * Also if ->d_manage() returns 1 the dentry transit needs
> > +	 * managing, for autofs it tells us the dentry might be
> > expired,
> > +	 * so proceed to ->d_automount().
> 
> I'm wondering if this should be two sentences.
> Does this version reflect reality?
> 
> +	 * Also if ->d_manage() returns 1 the dentry transit needs
> +	 * to be managed. For autofs, a return of 1 tells us the
> +	 * dentry might be expired, so proceed to ->d_automount().

It does, I'll update that comment too.

Even mentioning the dentry needs to be managed is purely because
that's what its been called, aka. ->d_manage().

Just for info. this is meant to fix a case were a stat() family
system call is being done at the same time the dentry is being
expired (although statfs() is a bit different).

This results in a ping/pong of returning the stat() of the
mounted file system and stat of the autofs file system.

What I'm trying to do is ensure a consistent stat() return
based on the state of the mount at the time, at least to the
extent that I can anyway.

There are actually a number of cases and, unavoidably, there
remains inconsistency because stat family system calls are not
meant to trigger mounts to avoid mount storms. So they will still
return the stat of the autofs file system if not mounted at the
time of the call and the stat of the mounted file system if they
do have an mount on them at the time.

Thanks
Ian

> 
> Kind regards
> Vince
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

