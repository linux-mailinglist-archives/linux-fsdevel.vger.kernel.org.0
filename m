Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07076130D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjGYLHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjGYLHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2602737;
        Tue, 25 Jul 2023 04:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D8B6166F;
        Tue, 25 Jul 2023 11:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A34EC433CA;
        Tue, 25 Jul 2023 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690283155;
        bh=pOXvioLmt4HpMqW57Xv4XXd6GlnOcDy+UqsXfhkHrFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbsxLGNFdM6qSh1jsLLP+MSRG3Nkflp9aMdnQyXq9KRnC7jcnHrYscu5AiJyW/CjG
         6vidsGf1xTa3w/b9fcx6JxLPhCpsmeaqJ+tu976ejqJN7wAnGdbGlU6QuWVEG17TOW
         rsAyVWCFCZxfnHGF9MOOEVjBTGhN1QP4VWQjCIpV24KKAqKhH3hrLvErt0bITTzA4b
         uQMoXtGGG92ctUBFbJvXZzxBOHsP01uMxujb2oj61jq3+VhVIPsXeIC4CFrq+i23Af
         amrQLDym688RQVV6YIHxxMOi5kxCv3SxAF6cWfPNZ/OE5H7fNQnSQkRJa31J+pQBLa
         k4YHM0VOJB5JQ==
Date:   Tue, 25 Jul 2023 13:05:40 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        glebfm@altlinux.org, gor@linux.ibm.com, hare@suse.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jhogan@kernel.org,
        kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, paul.burton@mips.com, paulus@samba.org,
        peterz@infradead.org, ralf@linux-mips.org, rth@twiddle.net,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH v3 0/5] Add a new fchmodat4() syscall
Message-ID: <ZL+shMg5LJgYlsDd@example.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <87lefmbppo.fsf@oldenburg.str.redhat.com>
 <20230711-quintessenz-auswechseln-92a4640c073d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711-quintessenz-auswechseln-92a4640c073d@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:14:24PM +0200, Christian Brauner wrote:
> On Tue, Jul 11, 2023 at 02:24:51PM +0200, Florian Weimer wrote:
> > * Alexey Gladkov:
> > 
> > > This patch set adds fchmodat4(), a new syscall. The actual
> > > implementation is super simple: essentially it's just the same as
> > > fchmodat(), but LOOKUP_FOLLOW is conditionally set based on the flags.
> > > I've attempted to make this match "man 2 fchmodat" as closely as
> > > possible, which says EINVAL is returned for invalid flags (as opposed to
> > > ENOTSUPP, which is currently returned by glibc for AT_SYMLINK_NOFOLLOW).
> > > I have a sketch of a glibc patch that I haven't even compiled yet, but
> > > seems fairly straight-forward:
> > >
> > >     diff --git a/sysdeps/unix/sysv/linux/fchmodat.c b/sysdeps/unix/sysv/linux/fchmodat.c
> > >     index 6d9cbc1ce9e0..b1beab76d56c 100644
> > >     --- a/sysdeps/unix/sysv/linux/fchmodat.c
> > >     +++ b/sysdeps/unix/sysv/linux/fchmodat.c
> > >     @@ -29,12 +29,36 @@
> > >      int
> > >      fchmodat (int fd, const char *file, mode_t mode, int flag)
> > >      {
> > >     -  if (flag & ~AT_SYMLINK_NOFOLLOW)
> > >     -    return INLINE_SYSCALL_ERROR_RETURN_VALUE (EINVAL);
> > >     -#ifndef __NR_lchmod		/* Linux so far has no lchmod syscall.  */
> > >     +  /* There are four paths through this code:
> > >     +      - The flags are zero.  In this case it's fine to call fchmodat.
> > >     +      - The flags are non-zero and glibc doesn't have access to
> > >     +	__NR_fchmodat4.  In this case all we can do is emulate the error codes
> > >     +	defined by the glibc interface from userspace.
> > >     +      - The flags are non-zero, glibc has __NR_fchmodat4, and the kernel has
> > >     +	fchmodat4.  This is the simplest case, as the fchmodat4 syscall exactly
> > >     +	matches glibc's library interface so it can be called directly.
> > >     +      - The flags are non-zero, glibc has __NR_fchmodat4, but the kernel does
> > 
> > If you define __NR_fchmodat4 on all architectures, we can use these
> > constants directly in glibc.  We no longer depend on the UAPI
> > definitions of those constants, to cut down the number of code variants,
> > and to make glibc's system call profile independent of the kernel header
> > version at build time.
> > 
> > Your version is based on 2.31, more recent versions have some reasonable
> > emulation for fchmodat based on /proc/self/fd.  I even wrote a comment
> > describing the same buggy behavior that you witnessed:
> > 
> > +      /* Some Linux versions with some file systems can actually
> > +        change symbolic link permissions via /proc, but this is not
> > +        intentional, and it gives inconsistent results (e.g., error
> > +        return despite mode change).  The expected behavior is that
> > +        symbolic link modes cannot be changed at all, and this check
> > +        enforces that.  */
> > +      if (S_ISLNK (st.st_mode))
> > +       {
> > +         __close_nocancel (pathfd);
> > +         __set_errno (EOPNOTSUPP);
> > +         return -1;
> > +       }
> > 
> > I think there was some kernel discussion about that behavior before, but
> > apparently, it hasn't led to fixes.
> 
> I think I've explained this somewhere else a couple of months ago but
> just in case you weren't on that thread or don't remember and apologies
> if you should already know.
> 
> A lot of filesystem will happily update the mode of a symlink. The VFS
> doesn't do anything to prevent this from happening. This is filesystem
> specific.
> 
> The EOPNOTSUPP you're seeing very likely comes from POSIX ACLs.
> Specifically it comes from filesystems that call posix_acl_chmod(),
> e.g., btrfs via
> 
>         if (!err && attr->ia_valid & ATTR_MODE)
>                 err = posix_acl_chmod(idmap, dentry, inode->i_mode);
> 
> Most filesystems don't implement i_op->set_acl() for POSIX ACLs.
> So posix_acl_chmod() will report EOPNOTSUPP. By the time
> posix_acl_chmod() is called, most filesystems will have finished
> updating the inode. POSIX ACLs also often aren't integrated into
> transactions so a rollback wouldn't even be possible on some
> filesystems.
> 
> Any filesystem that doesn't implement POSIX ACLs at all will obviously
> never fail unless it blocks mode changes on symlinks. Or filesystems
> that do have a way to rollback failures from posix_acl_chmod(), or
> filesystems that do return an error on chmod() on symlinks such as 9p,
> ntfs, ocfs2.
> 
> > 
> > I wonder if it makes sense to add a similar error return to the system
> > call implementation?
> 
> Hm, blocking symlink mode changes is pretty regression prone. And just
> blocking it through one interface seems weird and makes things even more
> inconsistent.
> 
> So two options I see:
> (1) minimally invasive:
>     Filesystems that do call posix_acl_chmod() on symlinks need to be
>     changed to stop doing that.
> (2) might hit us on the head invasive:
>     Try and block symlink mode changes in chmod_common().
> 
> Thoughts?
> 

We have third option. We can choose not to call chmod_common and return an
error right away:

diff --git a/fs/open.c b/fs/open.c
index 39a7939f0d00..86a427a2a083 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -679,7 +679,9 @@ static int do_fchmodat(int dfd, const char __user *filename, umode_t mode, int l
 retry:
        error = user_path_at(dfd, filename, lookup_flags, &path);
        if (!error) {
-               error = chmod_common(&path, mode);
+               error = -EOPNOTSUPP;
+               if (!(flags & AT_SYMLINK_NOFOLLOW) || !S_ISLNK(path.dentry->d_inode->i_mode))
+                       error = chmod_common(&path, mode);
                path_put(&path);
                if (retry_estale(error, lookup_flags)) {
                        lookup_flags |= LOOKUP_REVAL;

It doesn't seem to be invasive.

-- 
Rgrds, legion

