Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E777BC360
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 02:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjJGAlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 20:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJGAlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:41:23 -0400
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B46BD
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 17:41:17 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 975287A1501
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Oct 2023 00:41:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2915E7A057C
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Oct 2023 00:41:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696639277; a=rsa-sha256;
        cv=none;
        b=QFu9+C7YMP+mDHfJKd7T7zSR9E9xhi4U8+y22GoyGEOom6Nbin+P+R/7iTNx7mMWx/4Lme
        6Lztx8b4WIf0nquWu2UIZW8b78u46uu1cYj6U2vWPnXO+mS0i72/BvEUsflaHahhOHV7pE
        DGx6N+Zw3C4Jj81n3arg33Nc1/tWFikWJCF0Lwd4o5BOTwHKLE/4Hn8F8VSL5GJLGMuVQR
        1AYWPI2IK3K8wGQGygvdBOlGWDCniTjHSkka6wjUCCpL2jY0M8MEKn+EnYxJdnwNYpkLpc
        Xm4XLy+xwGyn4CZuctLr/FfBNPSQ+GG/HOTqrgoEuOiDS2pdx/CP0CbDb0VFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696639277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Rbh0OSGYEgujE+6OSCU+K35bSIRfKFKRGVhPA2zHgwk=;
        b=EFRBFeljO2tj7Of4bHAkWEQEwCMZnTH3BbjrF6x70BZoYJ5AiB1CAJUzR3RqxA5J/f8f6z
        OIZGoUWgbnkDzaPt/6pK/2MYFDugtNRV9nGPFDoo4rcJi4/Mf50gjkT5HWb62+5ZOW2qb2
        DFQC0iEKwQC6wbUzMONuw+xAM0kFJ9LALBr0gmjFCMieAg/3VB5cmbuR9eScMA8vSUWyg7
        9i7JP9N3ljaMNuP2ddzJWzd/UuUTrG53sudUQic3vY1iTV2OUV2jHvcdKEJArIYk0j+zmk
        jvekA73DcOlWDXz4lPLg73rlF3Rwdnhi47Sbknmk0/tIvnNBkytiKpwxcEJDHg==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-hgpf8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Little-Desert: 0f0c3d894f89c38a_1696639277408_1907729113
X-MC-Loop-Signature: 1696639277408:2393010906
X-MC-Ingress-Time: 1696639277408
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.108.167 (trex/6.9.1);
        Sat, 07 Oct 2023 00:41:17 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S2RLN5bzSzNV
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 17:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696639276;
        bh=Rbh0OSGYEgujE+6OSCU+K35bSIRfKFKRGVhPA2zHgwk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=WxDz0Ud/So2jBqCalRu3pHPwElFoqUrsa2sl1V4cPIyX0fITseuVkh6k8aJv26dtg
         WlnXYuVTFcxTLnROQf0nSUl4XBzRBp25BTA7vik+oFO+XnnlG82TE+fQMPubRCIn1Q
         HK9bfNfnJTpWcIfGRyXeqo2yJtgiuSMzuvTuGqcXs6caUyFqiw1BKUbeENAi5S6hQX
         qMV+QO5QHOjEcYK2rxE6txoRxz5VLEQLGiXf2flOV9xvosJVxlSvQRsJmZmUDB9CEo
         p+OU6mFmrwKWIERfQ+OFzQ++N0tEHBmEw2mEQ9KkNHwPj/xbIlDH8AW12mArB1Ld0d
         YKmnaPSfKQqdQ==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e01ea
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 06 Oct 2023 17:41:07 -0700
Date:   Fri, 6 Oct 2023 17:41:07 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Message-ID: <20231007004107.GA1967@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <3187f942-dcf0-4b2f-a106-0eb5d5a33949@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3187f942-dcf0-4b2f-a106-0eb5d5a33949@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 07:13:06PM +0200, Bernd Schubert wrote:
> 
> 
> On 10/2/23 17:24, Krister Johansen wrote:
> > The submount code uses the parent nodeid passed into the function in
> > order to create the root dentry for the new submount.  This nodeid does
> > not get its remote reference count incremented by a lookup option.
> > 
> > If the parent inode is evicted from its superblock, due to memory
> > pressure for example, it can result in a forget opertation being sent to
> > the server.  Should this nodeid be forgotten while it is still in use in
> > a submount, users of the submount get an error from the server on any
> > subsequent access.  In the author's case, this was an EBADF on all
> > subsequent operations that needed to reference the root.
> > 
> > Debugging the problem revealed that the dentry shrinker triggered a forget
> > after killing the dentry with the last reference, despite the root
> > dentry in another superblock still using the nodeid.
> > 
> > As a result, a container that was also using this submount failed to
> > access its filesystem because it had borrowed the reference instead of
> > taking its own when setting up its superblock for the submount.
> > 
> > This commit fixes the problem by having the new submount trigger a
> > lookup for the parent as part of creating a new root dentry for the
> > virtiofsd submount superblock.  This allows each superblock to have its
> > inodes removed by the shrinker when unreferenced, while keeping the
> > nodeid reference count accurate and active with the server.
> > 
> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > ---
> >   fs/fuse/dir.c    | 10 +++++-----
> >   fs/fuse/fuse_i.h |  6 ++++++
> >   fs/fuse/inode.c  | 43 +++++++++++++++++++++++++++++++++++++------
> >   3 files changed, 48 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 5e01946d7531..333730c74619 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -183,11 +183,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
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
> > index 405252bb51f2..a66fcf50a4cc 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1325,6 +1325,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
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
> > index 444418e240c8..79a31cb55512 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1464,7 +1464,13 @@ static int fuse_fill_super_submount(struct super_block *sb,
> >   	struct fuse_mount *fm = get_fuse_mount_super(sb);
> >   	struct super_block *parent_sb = parent_fi->inode.i_sb;
> >   	struct fuse_attr root_attr;
> > +	struct fuse_inode *fi;
> >   	struct inode *root;
> > +	struct inode *parent;
> > +	struct dentry *pdent;
> > +	struct fuse_entry_out outarg;
> > +	bool lookedup = false;
> > +	int ret;
> >   	fuse_sb_defaults(sb);
> >   	fm->sb = sb;
> > @@ -1480,14 +1486,39 @@ static int fuse_fill_super_submount(struct super_block *sb,
> >   	if (parent_sb->s_subtype && !sb->s_subtype)
> >   		return -ENOMEM;
> > -	fuse_fill_attr_from_inode(&root_attr, parent_fi);
> > -	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
> >   	/*
> > -	 * This inode is just a duplicate, so it is not looked up and
> > -	 * its nlookup should not be incremented.  fuse_iget() does
> > -	 * that, though, so undo it here.
> > +	 * It is necessary to lookup the parent_if->nodeid in case the dentry
> > +	 * that triggered the automount of the submount is later evicted.
> > +	 * If this dentry is evicted without the lookup count getting increased
> > +	 * on the submount root, then the server can subsequently forget this
> > +	 * nodeid which leads to errors when trying to access the root of the
> > +	 * submount.
> >   	 */
> > -	get_fuse_inode(root)->nlookup--;
> > +	parent = &parent_fi->inode;
> > +	pdent = d_find_alias(parent);
> > +	if (!pdent)
> > +		return -EINVAL;
> > +
> > +	ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
> > +	    &lookedup);
> > +	dput(pdent);
> > +	/*
> > +	 * The new root owns this nlookup on success, and it is incremented by
> > +	 * fuse_iget().  In the case the lookup succeeded but revalidate fails,
> > +	 * ensure that the lookup count is tracked by the parent.
> > +	 */
> > +	if (ret <= 0) {
> > +		if (lookedup) {
> > +			fi = get_fuse_inode(parent);
> > +			spin_lock(&fi->lock);
> > +			fi->nlookup++;
> > +			spin_unlock(&fi->lock);
> > +		}
> 
> I might be wrong, but doesn't that mean that
> "get_fuse_inode(root)->nlookup--" needs to be called?

In the case where ret > 0, the nlookup on get_fuse_inode(root) is set to
1 by fuse_iget().  That ensures that the root is forgotten when later
unmounted.  The code that handles the forget uses the count of nlookup
to tell the server-side how many references to forget.  (That's in
fuse_evict_inode()). 

However, if the fuse_dentry_revalidate_lookup() call performs a valid
lookup but returns an error, this function will return before it fills
out s_root in the superblock or calls fuse_iget().  If the superblock
doesn't have a s_root set, then the code in generic_kill_super() won't
dput() the root dentry and trigger the forget.

The intention of this code was to handle the case where the lookup had
succeeded, but the code determined it was still necessary to return an
error.  In that situation, the reference taken by the lookup has to be
accounted somewhere, and the parent seemed like a plausible candidate.

However, after writing up this response, I can see that there's still a
problem here if d_make_root(root) returns NULL, because we'll also lose
track of the nlookup in that case.

If you agree that charging this to the parent on error makes sense, I'll
re-work the error handling here so that the right thing happens when
either fuse_dentry_revalidate_lookup() or d_make_root() encounter an
error.

Thanks for the feedback.

-K
