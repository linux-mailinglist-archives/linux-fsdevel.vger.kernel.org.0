Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC55D77EE81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 03:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347381AbjHQBDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 21:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347383AbjHQBCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:02:41 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400B271E
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 18:02:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 78E8736034F
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 00:23:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 12082360270
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 00:23:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692231834; a=rsa-sha256;
        cv=none;
        b=jzJmzx/whMs2lu603CXBEJjhy5nC02uxAaSBb2gcjeY7+RgLA7/12SAA7NNCEdnlxs3R1H
        Yxzn5h0a0vnxi1zXtXPN3OatxDBfJyOR3o+qNTHKiG8FGoqE+OMashjbxWoMqJznV3FRAr
        6XqNWJfV4/Ft7esf468NOqUI6FkWHysERRdE9JaFZqM7lr3lDNurR+JL6Ba1e4EO+JVV0d
        LgUECj4VkcE/C/W/JDasaw7p381DYM0WH3t3SZppLXANKgN+Rup5PRcoBMgo5DFISGRv0K
        jLty+UF959hAdYgxOngyn8fJbE1+X2cN6LHmJ9kmOmjB068ynG7oeqP59N9VTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692231834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=SVWCyxiDqWAorWGpUue5/fKrH0eyYqsolzYWMu1dr3w=;
        b=eNBsfnBwfi/u52pMzDwkVsOUU0WHuA5XX9l/Ye0RG6RaJBlfFg4n+cpEhBm9DXQE9GKHSz
        g9jvyfC3a+SsIJqCUQpokjaZLqOWw/w2ThY9IWZKApudPqmxlMNoJK/m1II8F8HwvEN7oC
        DVlvX+qDYrVS4Hy3LZDGGYvjyLO1tdUfoBrvUrCnmC6nWWVD5ML2DZau41UBj5XvESdSlM
        FPeINTYeSKQL0F0EYord7yYIG9WKsiTvGE8NAnpcZnlXyIdnlLB4dlRs8zm8zFAcObjV4k
        obLUce55Hwsj44P6k+6CGzWXq3Sk2e6TEii2EBJwugcKsJE7FD9V7B7cJPnibA==
ARC-Authentication-Results: i=1;
        rspamd-749bd77c9c-s6t65;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Wiry: 65bfd90b785e4ea5_1692231834339_3881573770
X-MC-Loop-Signature: 1692231834339:923499776
X-MC-Ingress-Time: 1692231834339
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.240.200 (trex/6.9.1);
        Thu, 17 Aug 2023 00:23:54 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4RR5Ms5jVhz2n
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 17:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1692231833;
        bh=SVWCyxiDqWAorWGpUue5/fKrH0eyYqsolzYWMu1dr3w=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TkVpG4JCBDc/VP07afc74/LPZsCSYy3iOlWBINONtflgZ0OOfnJ31j3DUCl4I6Ttk
         h+1kQqiE4P1Blj86Da866vQCS/R4nxJavRgfutHP+nkgD+fv6CVpRs1g69KDQ/r1oI
         15p7sLCxoPpebrUwAvt0QYpN5QaimUB7MkFPC6hsngxhy7sTiVy7B9ogtUtcFVcQv+
         bosfaJz5Go64GdsnBMx79aQUgXMY0rllmZA6YZ18aZewQDHg3cluHgwedldqTjpnxi
         JqOxSAKVnIZ2p5Eq7zTl5EcvMuGiOoUaSmVW5ISueYyFQDLMTIVdC9F2S3tQdty2ai
         861Ocw+fEhgRA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0058
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 16 Aug 2023 17:23:49 -0700
Date:   Wed, 16 Aug 2023 17:23:49 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 2/2] fuse: ensure that submounts lookup their root
Message-ID: <20230817002349.GA1980@templeofstupid.com>
References: <cover.1689038902.git.kjlx@templeofstupid.com>
 <69bb95c34deb25f56b3b842528edcb40a098d38d.1689038902.git.kjlx@templeofstupid.com>
 <6a73a722-6bb5-6462-e7ff-a55866374758@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a73a722-6bb5-6462-e7ff-a55866374758@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:16:08AM +0200, Bernd Schubert wrote:
> On 7/11/23 03:37, Krister Johansen wrote:
> > Prior to this commit, the submount code assumed that the inode for the
> > root filesystem could not be evicted.  When eviction occurs the server
> > may forget the inode.  This author has observed a submount get an EBADF
> > from a virtiofsd server that resulted from the sole dentry / inode
> > pair getting evicted from a mount namespace and superblock where they
> > were originally referenced.  The dentry shrinker triggered a forget
> > after killing the dentry with the last reference.
> > 
> > As a result, a container that was also using this submount failed to
> > access its filesystem because it had borrowed the reference instead of
> > taking its own when setting up its superblock for the submount.
> > 
> > Fix by ensuring that submount superblock configuration looks up the
> > nodeid for the submount as well.
> > 
> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > ---
> >   fs/fuse/dir.c    | 10 +++++-----
> >   fs/fuse/fuse_i.h |  6 ++++++
> >   fs/fuse/inode.c  | 32 ++++++++++++++++++++++++++++----
> >   3 files changed, 39 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index bdf5526a0733..fe6b3fd4a49c 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -193,11 +193,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
> >   	args->out_args[0].value = outarg;
> >   }
> > -static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
> > -					 struct dentry *entry,
> > -					 struct inode *inode,
> > -					 struct fuse_entry_out *outarg,
> > -					 bool *lookedup)
> > +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
> > +				  struct dentry *entry,
> > +				  struct inode *inode,
> > +				  struct fuse_entry_out *outarg,
> > +				  bool *lookedup)
> >   {
> >   	struct dentry *parent;
> >   	struct fuse_forget_link *forget;
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 9b7fc7d3c7f1..77b123eddb6d 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1309,6 +1309,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
> >   bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
> >   void fuse_dax_cancel_work(struct fuse_conn *fc);
> > +/* dir.c */
> > +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm, struct dentry *entry,
> > +				  struct inode *inode,
> > +				  struct fuse_entry_out *outarg,
> > +				  bool *lookedup);
> > +
> >   /* ioctl.c */
> >   long fuse_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> >   long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index f19d748890f0..1032e4b05d9c 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1441,6 +1441,10 @@ static int fuse_fill_super_submount(struct super_block *sb,
> >   	struct super_block *parent_sb = parent_fi->inode.i_sb;
> >   	struct fuse_attr root_attr;
> >   	struct inode *root;
> > +	struct inode *parent;
> > +	struct dentry *pdent;
> > +	bool lookedup = false;
> > +	int ret;
> >   	fuse_sb_defaults(sb);
> >   	fm->sb = sb;
> > @@ -1456,14 +1460,34 @@ static int fuse_fill_super_submount(struct super_block *sb,
> >   	if (parent_sb->s_subtype && !sb->s_subtype)
> >   		return -ENOMEM;
> > +	/*
> > +	 * It is necessary to lookup the parent_if->nodeid in case the dentry
> > +	 * that triggered the automount of the submount is later evicted.
> > +	 * If this dentry is evicted without the lookup count getting increased
> > +	 * on the submount root, then the server can subsequently forget this
> > +	 * nodeid which leads to errors when trying to access the root of the
> > +	 * submount.
> > +	 */
> > +	parent = &parent_fi->inode;
> > +	pdent = d_find_alias(parent);
> > +	if (pdent) {
> > +		struct fuse_entry_out outarg;
> > +
> > +		ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
> > +						    &lookedup);
> > +		dput(pdent);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> >   	fuse_fill_attr_from_inode(&root_attr, parent_fi);
> >   	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
> >   	/*
> > -	 * This inode is just a duplicate, so it is not looked up and
> > -	 * its nlookup should not be incremented.  fuse_iget() does
> > -	 * that, though, so undo it here.
> > +	 * fuse_iget() sets nlookup to 1 at creation time.  If this nodeid was
> > +	 * not successfully looked up then decrement the count.
> >   	 */
> > -	get_fuse_inode(root)->nlookup--;
> > +	if (!lookedup)
> > +		get_fuse_inode(root)->nlookup--;
> 
> How does a submount work with a parent mismatch? I wonder if this function
> should return an error if lookup of the parent failed.

Thanks for the feedback.  This was definitely one of the things that I
didn't like about this patch.  The original code doesn't care if the
parent nodeid is valid, which is why I kept the old behavior as a
fallback if lookup failed.  I managed to console myself that it wasn't
any worse, but would love to remove that if it's okay to fail the mount
at this point.

The other thing that was annoying me was my refactoring of the
fuse_dentry_revalidate() function.  I'm annoyed by having the lookedup
boolean pointer as an argument to fuse_dentry_revalidate_lookup, but
couldn't quite work out how to handle the weird nlookup manipulations in
fuse_dentry_revalidate and fuse_fill_super_submount without it.

-K
