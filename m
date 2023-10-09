Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68D7BE77C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 19:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377401AbjJIRPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbjJIRPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:15:38 -0400
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A5DA
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 10:15:32 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C4D47800F27
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 17:15:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6394E800C66
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 17:15:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696871731; a=rsa-sha256;
        cv=none;
        b=BqtUzaxU5d/fijOFMRPMowWP4E/7imrdPb4nQkC6FFZvCCimRI7gNj4XZYCDqIgsVS9699
        WFRbHzguCo9qMhcH1wp30kM1rYY7YifY2qdW/FfLbc80VXrRqGbe30Loz7SiRJe8MBq6MG
        EJcje1FnRY7tLcKUsYDXdmGUna2bDssRhq5FY9prse6kNUgBvxStbD/4YJ/9gbuhfZyhQh
        sUDMhZkI50hYcBaa+lgjVtIzXkUMXhg9+8Vr4+hSgY/jRa24LcTRJoPf2uZgrewIRQHPio
        9kr8uhWI+2p7sZjHQyKCuGFc6IB1PjWtmHkEo5RLYZIH1FsuEesOuC9d/EUPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696871731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=QlFuBSlg0E1TP6LN5LFGf7CzS2eE6s5UiNS1GrMFKuU=;
        b=QPGqCN7UWpyUf4gKf2wlOHxTjSqfgFtVHt5c5+cyVTcTKe+Clz1VC6Jr/zaIj5v95yUO9H
        wsI532PuHdvmk91YwiMwh8RTp4/QwV/mNOCKUWleQH9qUVrmKczS+R92WOTDJ2GTBAQj/S
        opiqO5MMMq7Q89CgUXcuPnsxmc1Q9UcpzCd5//IXV40p/rqi2yhLroKAGFXEgRnC5OZRTs
        VJ/57EGgYHI//eeuEi5T1RQmh7faussW/N6dAAXPjOLONfqqzRDTozP7Fpe8CCLBQkc6Tp
        SYOB2gtKu1eCRXIxHos33uNrEuPN85s2BJYvl5Gdjt3cj5ObkBJwxr+FZsRqig==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-ssrn6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Invention-Desert: 38eb30c366bc16a9_1696871731643_2369998135
X-MC-Loop-Signature: 1696871731643:2392304576
X-MC-Ingress-Time: 1696871731643
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.113.180.165 (trex/6.9.1);
        Mon, 09 Oct 2023 17:15:31 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S45Jf3TlPzY0
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696871730;
        bh=QlFuBSlg0E1TP6LN5LFGf7CzS2eE6s5UiNS1GrMFKuU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=d23ui0iZazRAAWOdP9h8o/a6mucm8xaDew7vyb31mqBMFfdgeDdRpuhCMPSxdZsbS
         FbuAI8dyiujlkFxFOjc65mrhMKIYuLcrzibc3O9DGC8K+gh35uog4fKsV3/9LX9D8L
         GnvmYl5hEuqsk0QMWnIaomiHbPpWWLf/c57dgFLu0QHobQIHUT9P5EbS1XHGzyz1Br
         9it4BjVRDvDJBWP7kILW5xciW7rhHzXp0jD2JKpsB6unPlJLmVVea+6sAx98TQxO3m
         PE6FjXxMey6FwIQd4dVZBQVeaN0xqyDkoXRXe3Oyc2JKY8oFxfii35i+5ZGRkkxI1y
         EJ4FeUOC3HvsA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0098
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 09 Oct 2023 10:15:25 -0700
Date:   Mon, 9 Oct 2023 10:15:25 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Message-ID: <20231009171525.GA1973@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <3187f942-dcf0-4b2f-a106-0eb5d5a33949@fastmail.fm>
 <20231007004107.GA1967@templeofstupid.com>
 <968148ad-787e-4ccb-9d84-f32b5da88517@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968148ad-787e-4ccb-9d84-f32b5da88517@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:52:42PM +0200, Bernd Schubert wrote:
> 
> 
> On 10/7/23 02:41, Krister Johansen wrote:
> > On Fri, Oct 06, 2023 at 07:13:06PM +0200, Bernd Schubert wrote:
> > > 
> > > 
> > > On 10/2/23 17:24, Krister Johansen wrote:
> > > > The submount code uses the parent nodeid passed into the function in
> > > > order to create the root dentry for the new submount.  This nodeid does
> > > > not get its remote reference count incremented by a lookup option.
> > > > 
> > > > If the parent inode is evicted from its superblock, due to memory
> > > > pressure for example, it can result in a forget opertation being sent to
> > > > the server.  Should this nodeid be forgotten while it is still in use in
> > > > a submount, users of the submount get an error from the server on any
> > > > subsequent access.  In the author's case, this was an EBADF on all
> > > > subsequent operations that needed to reference the root.
> > > > 
> > > > Debugging the problem revealed that the dentry shrinker triggered a forget
> > > > after killing the dentry with the last reference, despite the root
> > > > dentry in another superblock still using the nodeid.
> > > > 
> > > > As a result, a container that was also using this submount failed to
> > > > access its filesystem because it had borrowed the reference instead of
> > > > taking its own when setting up its superblock for the submount.
> > > > 
> > > > This commit fixes the problem by having the new submount trigger a
> > > > lookup for the parent as part of creating a new root dentry for the
> > > > virtiofsd submount superblock.  This allows each superblock to have its
> > > > inodes removed by the shrinker when unreferenced, while keeping the
> > > > nodeid reference count accurate and active with the server.
> > > > 
> > > > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > > > ---
> > > >    fs/fuse/dir.c    | 10 +++++-----
> > > >    fs/fuse/fuse_i.h |  6 ++++++
> > > >    fs/fuse/inode.c  | 43 +++++++++++++++++++++++++++++++++++++------
> > > >    3 files changed, 48 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > > index 5e01946d7531..333730c74619 100644
> > > > --- a/fs/fuse/dir.c
> > > > +++ b/fs/fuse/dir.c
> > > > @@ -183,11 +183,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
> > > >    	args->out_args[0].value = outarg;
> > > >    }
> > > > -static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
> > > > -					 struct dentry *entry,
> > > > -					 struct inode *inode,
> > > > -					 struct fuse_entry_out *outarg,
> > > > -					 bool *lookedup)
> > > > +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
> > > > +				  struct dentry *entry,
> > > > +				  struct inode *inode,
> > > > +				  struct fuse_entry_out *outarg,
> > > > +				  bool *lookedup)
> > > >    {
> > > >    	struct dentry *parent;
> > > >    	struct fuse_forget_link *forget;
> > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > index 405252bb51f2..a66fcf50a4cc 100644
> > > > --- a/fs/fuse/fuse_i.h
> > > > +++ b/fs/fuse/fuse_i.h
> > > > @@ -1325,6 +1325,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
> > > >    bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
> > > >    void fuse_dax_cancel_work(struct fuse_conn *fc);
> > > > +/* dir.c */
> > > > +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm, struct dentry *entry,
> > > > +				  struct inode *inode,
> > > > +				  struct fuse_entry_out *outarg,
> > > > +				  bool *lookedup);
> > > > +
> > > >    /* ioctl.c */
> > > >    long fuse_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> > > >    long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index 444418e240c8..79a31cb55512 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -1464,7 +1464,13 @@ static int fuse_fill_super_submount(struct super_block *sb,
> > > >    	struct fuse_mount *fm = get_fuse_mount_super(sb);
> > > >    	struct super_block *parent_sb = parent_fi->inode.i_sb;
> > > >    	struct fuse_attr root_attr;
> > > > +	struct fuse_inode *fi;
> > > >    	struct inode *root;
> > > > +	struct inode *parent;
> > > > +	struct dentry *pdent;
> > > > +	struct fuse_entry_out outarg;
> > > > +	bool lookedup = false;
> > > > +	int ret;
> > > >    	fuse_sb_defaults(sb);
> > > >    	fm->sb = sb;
> > > > @@ -1480,14 +1486,39 @@ static int fuse_fill_super_submount(struct super_block *sb,
> > > >    	if (parent_sb->s_subtype && !sb->s_subtype)
> > > >    		return -ENOMEM;
> > > > -	fuse_fill_attr_from_inode(&root_attr, parent_fi);
> > > > -	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
> > > >    	/*
> > > > -	 * This inode is just a duplicate, so it is not looked up and
> > > > -	 * its nlookup should not be incremented.  fuse_iget() does
> > > > -	 * that, though, so undo it here.
> > > > +	 * It is necessary to lookup the parent_if->nodeid in case the dentry
> > > > +	 * that triggered the automount of the submount is later evicted.
> > > > +	 * If this dentry is evicted without the lookup count getting increased
> > > > +	 * on the submount root, then the server can subsequently forget this
> > > > +	 * nodeid which leads to errors when trying to access the root of the
> > > > +	 * submount.
> > > >    	 */
> > > > -	get_fuse_inode(root)->nlookup--;
> > > > +	parent = &parent_fi->inode;
> > > > +	pdent = d_find_alias(parent);
> > > > +	if (!pdent)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
> > > > +	    &lookedup);
> > > > +	dput(pdent);
> > > > +	/*
> > > > +	 * The new root owns this nlookup on success, and it is incremented by
> > > > +	 * fuse_iget().  In the case the lookup succeeded but revalidate fails,
> > > > +	 * ensure that the lookup count is tracked by the parent.
> > > > +	 */
> > > > +	if (ret <= 0) {
> > > > +		if (lookedup) {
> > > > +			fi = get_fuse_inode(parent);
> > > > +			spin_lock(&fi->lock);
> > > > +			fi->nlookup++;
> > > > +			spin_unlock(&fi->lock);
> > > > +		}
> > > 
> > > I might be wrong, but doesn't that mean that
> > > "get_fuse_inode(root)->nlookup--" needs to be called?
> > 
> > In the case where ret > 0, the nlookup on get_fuse_inode(root) is set to
> > 1 by fuse_iget().  That ensures that the root is forgotten when later
> > unmounted.  The code that handles the forget uses the count of nlookup
> > to tell the server-side how many references to forget.  (That's in
> > fuse_evict_inode()).
> > 
> > However, if the fuse_dentry_revalidate_lookup() call performs a valid
> > lookup but returns an error, this function will return before it fills
> > out s_root in the superblock or calls fuse_iget().  If the superblock
> > doesn't have a s_root set, then the code in generic_kill_super() won't
> > dput() the root dentry and trigger the forget.
> > 
> > The intention of this code was to handle the case where the lookup had
> > succeeded, but the code determined it was still necessary to return an
> > error.  In that situation, the reference taken by the lookup has to be
> > accounted somewhere, and the parent seemed like a plausible candidate.
> 
> Yeah sorry, I had just missed that fuse_iget() also moved and then thought
> it would have increased fi->nlookup already.

No worries; I'd much rather get feedback if something doesn't look
right, even if it turns out okay in the end.

> > However, after writing up this response, I can see that there's still a
> > problem here if d_make_root(root) returns NULL, because we'll also lose
> > track of the nlookup in that case.
> > 
> > If you agree that charging this to the parent on error makes sense, I'll
> > re-work the error handling here so that the right thing happens when
> > either fuse_dentry_revalidate_lookup() or d_make_root() encounter an
> > error.
> 
> Oh yeah, I also missed that. Although, iput() calls iput_final, which then
> calls evict and sends the fuse forget - isn't that the right action already?

Thanks, I had forgotten that d_make_root() would call iput() for me if
d_alloc_anon() fails.  Let me restate this to suggest that I account the
nlookup to the parent if fuse_dentry_revalidate_lookup() or fuse_iget()
fail instead.  Does that sound right?

> > Thanks for the feedback.
> 
> Well, false alarm from my side, sorry again!

No apology necessary; I appreciate you spending the time to look and ask
questions.

-K
