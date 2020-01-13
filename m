Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40C413895B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 02:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbgAMBse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 20:48:34 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46639 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbgAMBse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 20:48:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4AC5F5246;
        Sun, 12 Jan 2020 20:48:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 12 Jan 2020 20:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        mRgeGbjro8yt+F2uGPRCq1h4lwtaE5CqMUDjAoyZdPs=; b=A7qB6xkwbuSHEbSQ
        AiyI6gSDmi1s7uDdGE2DuSW9eFQchT19cAy/PDVBvSCfjbodFc/+0hZZG5g+vDCd
        CC/HMUOo+58wmR1ZXg1Pq/7F6zqlB91vjWImFR9Sh2zmQ+rYIJNvxkhc3C6OwD5+
        GxuGZxrgMQbijHFdehiRJZgsLW2p+9aSXPbtUs2zDsghgJ0J7c/xgb2lJ+JJmF+G
        kX1V0p6+6i4ahf6V2oz+KezG/sxGwncEAOdELYUwcTHtaiESzFU0irRTdrGJnQbq
        xwlk+MQPGIoCOyUKw8AFSL4IEp0cQxC9WZKiaWMc5JLmD5Kre157a9YDuTtqCwn0
        jJUwTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=mRgeGbjro8yt+F2uGPRCq1h4lwtaE5CqMUDjAoyZd
        Ps=; b=GGx4KcZKFPFlL48KXC0UzYfXsluBMbWAKjImPoc0hXsn1/j73wB68O6lt
        kQNHUKbBIKlwHBnNggNugaCqyrdOLJ42F449MWfI5qEKPHdwmTY5VC6eNjEyKGKQ
        G1TdaMJiQAi34Qi6Uj1yZh+rZT1e2cCl4BHym0W3K2AnS3Y0YyZMkVsaUvNDQKP4
        xgaj/nh/AHaZhaNkrG6kEph7/TFed+cCmDVMSTZfTotRgKHv+pne1/Oydi35jpcl
        oV4iV6jXVsnKo6O/n2kpN0PKEp1ohCev2i+99+dFMTqa1sXjwSWWpnm97oCYNqLN
        PCi3qT+1XRh4w9hIgrtHG0qjrTpjg==
X-ME-Sender: <xms:b8wbXnt0jqArRN-ogmchUx_--MBCrXFtpvO56temc52LZcPk_3p1oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtle
    drudejhedrvdehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:b8wbXgt1Fjju7rzawIOneLIM1L9KKsEyn1CoI61hOwBG7BJV37efRQ>
    <xmx:b8wbXokaRgaoRBZLvdl781PKvaBPaa1GMnyFg9llXZWcQbwFRlUJ_Q>
    <xmx:b8wbXrKm1UAHI7smUFNU6PWy5cdtJfu5SnP9L8vMzQMBQzw7_Rlteg>
    <xmx:cMwbXlXVHkUhtpIAMTDi053kq77WkvvrCfusfjzmp3r8zbZKvfpcqw>
Received: from mickey.themaw.net (unknown [118.209.175.25])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA6FD8005A;
        Sun, 12 Jan 2020 20:48:26 -0500 (EST)
Message-ID: <aea0bc800b6a1e547ca1944738ff9db4379098ba.camel@themaw.net>
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over
 symlinks
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jan 2020 09:48:23 +0800
In-Reply-To: <20200110231945.GL8904@ZenIV.linux.org.uk>
References: <20191230054413.GX4203@ZenIV.linux.org.uk>
         <20191230054913.c5avdjqbygtur2l7@yavin.dot.cyphar.com>
         <20191230072959.62kcojxpthhdwmfa@yavin.dot.cyphar.com>
         <20200101004324.GA11269@ZenIV.linux.org.uk>
         <20200101005446.GH4203@ZenIV.linux.org.uk>
         <20200101030815.GA17593@ZenIV.linux.org.uk>
         <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com>
         <20200101234009.GB8904@ZenIV.linux.org.uk>
         <20200102035920.dsycgxnb6ba2jhz2@yavin.dot.cyphar.com>
         <20200103014901.GC8904@ZenIV.linux.org.uk>
         <20200110231945.GL8904@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-01-10 at 23:19 +0000, Al Viro wrote:
> On Fri, Jan 03, 2020 at 01:49:01AM +0000, Al Viro wrote:
> > On Thu, Jan 02, 2020 at 02:59:20PM +1100, Aleksa Sarai wrote:
> > > On 2020-01-01, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > On Thu, Jan 02, 2020 at 01:44:07AM +1100, Aleksa Sarai wrote:
> > > > 
> > > > > Thanks, this fixes the issue for me (and also fixes another
> > > > > reproducer I
> > > > > found -- mounting a symlink on top of itself then trying to
> > > > > umount it).
> > > > > 
> > > > > Reported-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > > Tested-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > 
> > > > Pushed into #fixes.
> > > 
> > > Thanks. One other thing I noticed is that umount applies to the
> > > underlying symlink rather than the mountpoint on top. So, for
> > > example
> > > (using the same scripts I posted in the thread):
> > > 
> > >   # ln -s /tmp/foo link
> > >   # ./mount_to_symlink /etc/passwd link
> > >   # umount -l link # will attempt to unmount "/tmp/foo"
> > > 
> > > Is that intentional?
> > 
> > It's a mess, again in mountpoint_last().  FWIW, at some point I
> > proposed
> > to have nd_jump_link() to fail with -ELOOP if the target was a
> > symlink;
> > Linus asked for reasons deeper than my dislike of the semantics, I
> > looked
> > around and hadn't spotted anything.  And there hadn't been at the
> > time,
> > but when four months later umount_lookup_last() went in I failed to
> > look
> > for that source of potential problems in it ;-/
> 
> FWIW, since Ian appears to agree that we want ->d_manage() on the
> mount
> crossing at the end of umount(2) lookup, here's a much simpler
> solution -
> kill mountpoint_last() and switch to using lookup_last().  As a side
> benefit, LOOKUP_NO_REVAL also goes away.  It's possible to trim the
> things even more (path_mountpoint() is very similar to
> path_lookupat()
> at that point, and it's not hard to make the differences conditional
> on
> something like LOOKUP_UMOUNT); I would rather do that part in the
> cleanups series - the one below is easier to backport.
> 
> Aleksa, Ian - could you see if the patch below works for you?

I did try this patch and I was trying to work out why it didn't
work. But thought I'd let you know what I saw.

Applying it to current Linus tree systemd stops at switch root.

Not sure what causes that, I couldn't see any reason for it.

I see you have a development branch in your repo. I'll have a look
at that rather than continue with this.

> 
> commit e56b43b971a7c08762fceab330a52b7245041dbc
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Fri Jan 10 17:17:19 2020 -0500
> 
>     reimplement path_mountpoint() with less magic
>     
>     ... and get rid of a bunch of bugs in it.  Background:
>     the reason for path_mountpoint() is that umount() really doesn't
>     want attempts to revalidate the root of what it's trying to
> umount.
>     The thing we want to avoid actually happen from complete_walk();
>     solution was to do something parallel to normal path_lookupat()
>     and it both went overboard and got the boilerplate subtly
>     (and not so subtly) wrong.
>     
>     A better solution is to do pretty much what the normal
> path_lookupat()
>     does, but instead of complete_walk() do unlazy_walk().  All it
> takes
>     to avoid that ->d_weak_revalidate() call...  mountpoint_last()
> goes
>     away, along with everything it got wrong, and so does the magic
> around
>     LOOKUP_NO_REVAL.
>     
>     Another source of bugs is that when we traverse mounts at the
> final
>     location (and we need to do that - umount . expects to get
> whatever's
>     overmounting ., if any, out of the lookup) we really ought to
> take
>     care of ->d_manage() - as it is, manual umount of autofs
> automount
>     in progress can lead to unpleasant surprises for the
> daemon.  Easily
>     solved by using handle_lookup_down() instead of follow_mount().
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index d6c91d1e88cb..1793661c3342 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1649,17 +1649,15 @@ static struct dentry *__lookup_slow(const
> struct qstr *name,
>  	if (IS_ERR(dentry))
>  		return dentry;
>  	if (unlikely(!d_in_lookup(dentry))) {
> -		if (!(flags & LOOKUP_NO_REVAL)) {
> -			int error = d_revalidate(dentry, flags);
> -			if (unlikely(error <= 0)) {
> -				if (!error) {
> -					d_invalidate(dentry);
> -					dput(dentry);
> -					goto again;
> -				}
> +		int error = d_revalidate(dentry, flags);
> +		if (unlikely(error <= 0)) {
> +			if (!error) {
> +				d_invalidate(dentry);
>  				dput(dentry);
> -				dentry = ERR_PTR(error);
> +				goto again;
>  			}
> +			dput(dentry);
> +			dentry = ERR_PTR(error);
>  		}
>  	} else {
>  		old = inode->i_op->lookup(inode, dentry, flags);
> @@ -2618,72 +2616,6 @@ int user_path_at_empty(int dfd, const char
> __user *name, unsigned flags,
>  EXPORT_SYMBOL(user_path_at_empty);
>  
>  /**
> - * mountpoint_last - look up last component for umount
> - * @nd:   pathwalk nameidata - currently pointing at parent
> directory of "last"
> - *
> - * This is a special lookup_last function just for umount. In this
> case, we
> - * need to resolve the path without doing any revalidation.
> - *
> - * The nameidata should be the result of doing a LOOKUP_PARENT
> pathwalk. Since
> - * mountpoints are always pinned in the dcache, their ancestors are
> too. Thus,
> - * in almost all cases, this lookup will be served out of the
> dcache. The only
> - * cases where it won't are if nd->last refers to a symlink or the
> path is
> - * bogus and it doesn't exist.
> - *
> - * Returns:
> - * -error: if there was an error during lookup. This includes
> -ENOENT if the
> - *         lookup found a negative dentry.
> - *
> - * 0:      if we successfully resolved nd->last and found it to not
> to be a
> - *         symlink that needs to be followed.
> - *
> - * 1:      if we successfully resolved nd->last and found it to be a
> symlink
> - *         that needs to be followed.
> - */
> -static int
> -mountpoint_last(struct nameidata *nd)
> -{
> -	int error = 0;
> -	struct dentry *dir = nd->path.dentry;
> -	struct path path;
> -
> -	/* If we're in rcuwalk, drop out of it to handle last component
> */
> -	if (nd->flags & LOOKUP_RCU) {
> -		if (unlazy_walk(nd))
> -			return -ECHILD;
> -	}
> -
> -	nd->flags &= ~LOOKUP_PARENT;
> -
> -	if (unlikely(nd->last_type != LAST_NORM)) {
> -		error = handle_dots(nd, nd->last_type);
> -		if (error)
> -			return error;
> -		path.dentry = dget(nd->path.dentry);
> -	} else {
> -		path.dentry = d_lookup(dir, &nd->last);
> -		if (!path.dentry) {
> -			/*
> -			 * No cached dentry. Mounted dentries are
> pinned in the
> -			 * cache, so that means that this dentry is
> probably
> -			 * a symlink or the path doesn't actually point
> -			 * to a mounted dentry.
> -			 */
> -			path.dentry = lookup_slow(&nd->last, dir,
> -					     nd->flags |
> LOOKUP_NO_REVAL);
> -			if (IS_ERR(path.dentry))
> -				return PTR_ERR(path.dentry);
> -		}
> -	}
> -	if (d_flags_negative(smp_load_acquire(&path.dentry->d_flags)))
> {
> -		dput(path.dentry);
> -		return -ENOENT;
> -	}
> -	path.mnt = nd->path.mnt;
> -	return step_into(nd, &path, 0, d_backing_inode(path.dentry),
> 0);
> -}
> -
> -/**
>   * path_mountpoint - look up a path to be umounted
>   * @nd:		lookup context
>   * @flags:	lookup flags
> @@ -2699,14 +2631,17 @@ path_mountpoint(struct nameidata *nd,
> unsigned flags, struct path *path)
>  	int err;
>  
>  	while (!(err = link_path_walk(s, nd)) &&
> -		(err = mountpoint_last(nd)) > 0) {
> +		(err = lookup_last(nd)) > 0) {
>  		s = trailing_symlink(nd);
>  	}
> +	if (!err)
> +		err = unlazy_walk(nd);
> +	if (!err)
> +		err = handle_lookup_down(nd);
>  	if (!err) {
>  		*path = nd->path;
>  		nd->path.mnt = NULL;
>  		nd->path.dentry = NULL;
> -		follow_mount(path);
>  	}
>  	terminate_walk(nd);
>  	return err;
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index f64a33d2a1d1..2a82dcce5fc1 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -206,7 +206,6 @@ TRACE_DEFINE_ENUM(LOOKUP_AUTOMOUNT);
>  TRACE_DEFINE_ENUM(LOOKUP_PARENT);
>  TRACE_DEFINE_ENUM(LOOKUP_REVAL);
>  TRACE_DEFINE_ENUM(LOOKUP_RCU);
> -TRACE_DEFINE_ENUM(LOOKUP_NO_REVAL);
>  TRACE_DEFINE_ENUM(LOOKUP_OPEN);
>  TRACE_DEFINE_ENUM(LOOKUP_CREATE);
>  TRACE_DEFINE_ENUM(LOOKUP_EXCL);
> @@ -224,7 +223,6 @@ TRACE_DEFINE_ENUM(LOOKUP_DOWN);
>  			{ LOOKUP_PARENT, "PARENT" }, \
>  			{ LOOKUP_REVAL, "REVAL" }, \
>  			{ LOOKUP_RCU, "RCU" }, \
> -			{ LOOKUP_NO_REVAL, "NO_REVAL" }, \
>  			{ LOOKUP_OPEN, "OPEN" }, \
>  			{ LOOKUP_CREATE, "CREATE" }, \
>  			{ LOOKUP_EXCL, "EXCL" }, \
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 7fe7b87a3ded..07bfb0874033 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -34,7 +34,6 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT,
> LAST_BIND};
>  
>  /* internal use only */
>  #define LOOKUP_PARENT		0x0010
> -#define LOOKUP_NO_REVAL		0x0080
>  #define LOOKUP_JUMPED		0x1000
>  #define LOOKUP_ROOT		0x2000
>  #define LOOKUP_ROOT_GRABBED	0x0008

