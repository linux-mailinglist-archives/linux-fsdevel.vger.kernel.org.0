Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9108A23C2CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 03:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgHEA7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 20:59:47 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:42591 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726584AbgHEA7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:59:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id BAFECD72;
        Tue,  4 Aug 2020 20:59:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Aug 2020 20:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        UbMq8vhUFQ5WNbhixsusY27gtC0XOuRLZBvROi8eeUA=; b=sORHxIGzLipepjw5
        AzKlZt7mBM44z5Hm+vh1XXNUOFfcGHs9ZxDBK5kHBjEh3Wh56nzViRKHUXSqfoX3
        cUXreERGWIgZp8pKfObf3WxNuPaWiv9oavpfoJVQwUpBdy7ni+f8b2zjVTm4pyB5
        IbtZpL/uT4TbmStgVqjR6hpNnRFFC42hf4JGJ0Xl6i24pGH+P80yoLTZ+EufaDUG
        aR8lhmukVqZ92DjPFQyGBl7ZGO711hGsEmTUPoUmDuOkjHj9LsTonFLMuYmEqrY7
        vNR9hbAP2DEROpYyvOLKW5H2CbetumRUCGWq+kt5K0E43bVCWkjC9DCPVatmP9A1
        j7XK5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=UbMq8vhUFQ5WNbhixsusY27gtC0XOuRLZBvROi8ee
        UA=; b=VBkJmeYwtIp9OHqhwRl2Ftl9NkbyGtx0c1bQJ7u1QF5d+ROn/o+3JHPrL
        6H+q2D13LdVHLYDadT9wA5jMTdvgVlxHv0Ll06yfjNo7HYHlWJUW9bTf26xvST0b
        Hj7ZBaijyEwd9QVQ0KhWa6I37Owau1JJFKkhLSe945+Bfhihld+wuRY7RLGL+8hz
        FN1N9mdbOeTJiejuaXxb9to9KLceZ1Nbr69chQHEwtyV3y1KtvrFcOXa7CD8XS5H
        3mvEGjqm6Y4DdLZ/KUPAeeUsVJqt1GI6lxkHN2j2oMJ/BuDFtXxzZutgCkAWBGU9
        np+wfLoCwuZjJJGuRVHQBYiox4/vA==
X-ME-Sender: <xms:fwQqX-YL-jeE8MWGhjQzKayDUKpSyVntwXV-ztZ9gkodQWHnoI--Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeejgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehhedrvddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:fwQqXxbRJTCx4PdbWuzpYfogTZCiZ83ahMC0mMhfUE5emi1g_bF24Q>
    <xmx:fwQqX48inEUx0R3fvUlkmWfDKkHLzbWc-iLN28OZZY_MTKz1CAOIFw>
    <xmx:fwQqXwqdPg014DvVnGdiCMOKWomogNfEpw16E5ZxcHfvlO2KfV8LrA>
    <xmx:gAQqX00Uvd97n4wSmAEc_3xmOA_O6gI2xuL6oeJOkiG25xVMAOQQThsU0yg>
Received: from mickey.themaw.net (58-7-255-220.dyn.iinet.net.au [58.7.255.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id 16D4530600A3;
        Tue,  4 Aug 2020 20:59:38 -0400 (EDT)
Message-ID: <730ad205e3aafd5b983b331077bbcc581aa4df78.camel@themaw.net>
Subject: Re: [PATCH 15/18] fsinfo: Add an attribute that lists all the
 visible mounts in a namespace [ver #21]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 08:59:34 +0800
In-Reply-To: <20200804140558.GF32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
         <159646191446.1784947.11228235431863356055.stgit@warthog.procyon.org.uk>
         <20200804140558.GF32719@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-04 at 16:05 +0200, Miklos Szeredi wrote:
> On Mon, Aug 03, 2020 at 02:38:34PM +0100, David Howells wrote:
> > Add a filesystem attribute that exports a list of all the visible
> > mounts in
> > a namespace, given the caller's chroot setting.  The returned list
> > is an
> > array of:
> > 
> > 	struct fsinfo_mount_child {
> > 		__u64	mnt_unique_id;
> > 		__u32	mnt_id;
> > 		__u32	parent_id;
> > 		__u32	mnt_notify_sum;
> > 		__u32	sb_notify_sum;
> > 	};
> > 
> > where each element contains a once-in-a-system-lifetime unique ID,
> > the
> > mount ID (which may get reused), the parent mount ID and sums of
> > the
> > notification/change counters for the mount and its superblock.
> 
> The change counters are currently conditional on
> CONFIG_MOUNT_NOTIFICATIONS.
> Is this is intentional?
> 
> > This works with a read lock on the namespace_sem, but ideally would
> > do it
> > under the RCU read lock only.
> > 
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > ---
> > 
> >  fs/fsinfo.c                 |    1 +
> >  fs/internal.h               |    1 +
> >  fs/namespace.c              |   37
> > +++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fsinfo.h |    4 ++++
> >  samples/vfs/test-fsinfo.c   |   22 ++++++++++++++++++++++
> >  5 files changed, 65 insertions(+)
> > 
> > diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> > index 0540cce89555..f230124ffdf5 100644
> > --- a/fs/fsinfo.c
> > +++ b/fs/fsinfo.c
> > @@ -296,6 +296,7 @@ static const struct fsinfo_attribute
> > fsinfo_common_attributes[] = {
> >  	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_gene
> > ric_mount_point),
> >  	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT_FULL,	fsinfo_gene
> > ric_mount_point_full),
> >  	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_moun
> > t_children),
> > +	FSINFO_LIST	(FSINFO_ATTR_MOUNT_ALL,		fsinfo_generic_moun
> > t_all),
> >  	{}
> >  };
> >  
> > diff --git a/fs/internal.h b/fs/internal.h
> > index cb5edcc7125a..267b4aaf0271 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -102,6 +102,7 @@ extern int fsinfo_generic_mount_topology(struct
> > path *, struct fsinfo_context *)
> >  extern int fsinfo_generic_mount_point(struct path *, struct
> > fsinfo_context *);
> >  extern int fsinfo_generic_mount_point_full(struct path *, struct
> > fsinfo_context *);
> >  extern int fsinfo_generic_mount_children(struct path *, struct
> > fsinfo_context *);
> > +extern int fsinfo_generic_mount_all(struct path *, struct
> > fsinfo_context *);
> >  
> >  /*
> >   * fs_struct.c
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 122c12f9512b..1f2e06507244 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -4494,4 +4494,41 @@ int fsinfo_generic_mount_children(struct
> > path *path, struct fsinfo_context *ctx)
> >  	return ctx->usage;
> >  }
> >  
> > +/*
> > + * Return information about all the mounts in the namespace
> > referenced by the
> > + * path.
> > + */
> > +int fsinfo_generic_mount_all(struct path *path, struct
> > fsinfo_context *ctx)
> > +{
> > +	struct mnt_namespace *ns;
> > +	struct mount *m, *p;
> > +	struct path chroot;
> > +	bool allow;
> > +
> > +	m = real_mount(path->mnt);
> > +	ns = m->mnt_ns;
> > +
> > +	get_fs_root(current->fs, &chroot);
> > +	rcu_read_lock();
> > +	allow = are_paths_connected(&chroot, path) ||
> > capable(CAP_SYS_ADMIN);
> > +	rcu_read_unlock();
> > +	path_put(&chroot);
> > +	if (!allow)
> > +		return -EPERM;
> > +
> > +	down_read(&namespace_sem);
> > +
> > +	list_for_each_entry(p, &ns->list, mnt_list) {
> 
> This is missing locking and check added by commit 9f6c61f96f2d
> ("proc/mounts:
> add cursor").

That's a good catch Miklos.

Yes, the extra lock and the cursor check that's now needed.

> 
> > +		struct path mnt_root;
> > +
> > +		mnt_root.mnt	= &p->mnt;
> > +		mnt_root.dentry	= p->mnt.mnt_root;
> > +		if (are_paths_connected(path, &mnt_root))
> > +			fsinfo_store_mount(ctx, p, p == m);
> > +	}
> > +
> > +	up_read(&namespace_sem);
> > +	return ctx->usage;
> > +}
> > +
> >  #endif /* CONFIG_FSINFO */
> > diff --git a/include/uapi/linux/fsinfo.h
> > b/include/uapi/linux/fsinfo.h
> > index 81329de6905e..e40192d98648 100644
> > --- a/include/uapi/linux/fsinfo.h
> > +++ b/include/uapi/linux/fsinfo.h
> > @@ -37,6 +37,7 @@
> >  #define FSINFO_ATTR_MOUNT_POINT_FULL	0x203	/* Absolute
> > path of mount (string) */
> >  #define FSINFO_ATTR_MOUNT_TOPOLOGY	0x204	/* Mount object
> > topology */
> >  #define FSINFO_ATTR_MOUNT_CHILDREN	0x205	/* Children of this
> > mount (list) */
> > +#define FSINFO_ATTR_MOUNT_ALL		0x206	/* List all
> > mounts in a namespace (list) */
> >  
> >  #define FSINFO_ATTR_AFS_CELL_NAME	0x300	/* AFS cell name
> > (string) */
> >  #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of
> > the Nth server (string) */
> > @@ -128,6 +129,8 @@ struct fsinfo_mount_topology {
> >  /*
> >   * Information struct element for
> > fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
> >   * - An extra element is placed on the end representing the parent
> > mount.
> > + *
> > + * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_ALL).
> >   */
> >  struct fsinfo_mount_child {
> >  	__u64	mnt_unique_id;		/* Kernel-lifetime unique
> > mount ID */
> > @@ -139,6 +142,7 @@ struct fsinfo_mount_child {
> >  };
> >  
> >  #define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct
> > fsinfo_mount_child
> > +#define FSINFO_ATTR_MOUNT_ALL__STRUCT struct fsinfo_mount_child
> >  
> >  /*
> >   * Information struct for fsinfo(FSINFO_ATTR_STATFS).
> > diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> > index 374825ab85b0..596fa5e71762 100644
> > --- a/samples/vfs/test-fsinfo.c
> > +++ b/samples/vfs/test-fsinfo.c
> > @@ -365,6 +365,27 @@ static void
> > dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
> >  	       (unsigned long long)r->mnt_notify_sum, mp);
> >  }
> >  
> > +static void dump_fsinfo_generic_mount_all(void *reply, unsigned
> > int size)
> > +{
> > +	struct fsinfo_mount_child *r = reply;
> > +	ssize_t mplen;
> > +	char path[32], *mp;
> > +
> > +	struct fsinfo_params params = {
> > +		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
> > +		.request	= FSINFO_ATTR_MOUNT_POINT_FULL,
> > +	};
> > +
> > +	sprintf(path, "%u", r->mnt_id);
> > +	mplen = get_fsinfo(path, "FSINFO_ATTR_MOUNT_POINT_FULL",
> > &params, (void **)&mp);
> > +	if (mplen < 0)
> > +		mp = "-";
> > +
> > +	printf("%5x %5x %12llx %10llu %s\n",
> > +	       r->mnt_id, r->parent_id, (unsigned long long)r-
> > >mnt_unique_id,
> > +	       r->mnt_notify_sum, mp);
> > +}
> > +
> >  static void dump_afs_fsinfo_server_address(void *reply, unsigned
> > int size)
> >  {
> >  	struct fsinfo_afs_server_address *f = reply;
> > @@ -492,6 +513,7 @@ static const struct fsinfo_attribute
> > fsinfo_attributes[] = {
> >  	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
> >  	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
> >  	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_moun
> > t_children),
> > +	FSINFO_LIST	(FSINFO_ATTR_MOUNT_ALL,		fsinfo_generic_moun
> > t_all),
> >  
> >  	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
> >  	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
> > 
> > 

