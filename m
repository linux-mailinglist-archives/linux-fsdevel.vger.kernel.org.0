Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4D92CA369
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbgLANCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 08:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbgLANCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606827676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxQN4N2AQp3LRLggORzpLN660oZQ5Hx35SxeD4S+HA4=;
        b=LRZpwzKg1IkYn/BdmboSVKFOdDgzNJawCnI4zgOxkQD2g/urX1/PbV5BNek/cp23vKBbCi
        0IwHTle+MBEydonBwPpm3PNnn2AHW8UGxGBUQ7CCIwtOGkcNEuRGzrKUqYWdN6uX/Se8Uz
        g7oXWy/ztre/Fvuz+gqmDMNo5AV/nN8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-3APgMLYIOAefVqVL2yuEbg-1; Tue, 01 Dec 2020 08:01:14 -0500
X-MC-Unique: 3APgMLYIOAefVqVL2yuEbg-1
Received: by mail-qk1-f197.google.com with SMTP id 198so1261800qkj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 05:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lxQN4N2AQp3LRLggORzpLN660oZQ5Hx35SxeD4S+HA4=;
        b=TN7puS+kJrf4yluDn+llw+nirsPGMuHflyS6tklfutJPEEjxHeNgCk2ZkuHhT1NYpB
         1twQqAsxokNeja55A7/5NloEuZ7lF0fPVHCks6a1KE4G+ijejsBKhXxe27XXo0zRmlqN
         QtltMuhKAwFwSWGDE7sr2ILTfcFBYAbPnlxsREppWG+yvF/aLOODyerCYZ6ZtooOt6I5
         aunWVjamegAdGrAYT4i6fp4tqeqFfGQrxK0QdLyhxnJ8tY+Cw8+3bdt1UqSechEc129l
         QA0tqbxWO0BreB7FDG8im4Ou7tQDP3fjr7k4BtOPnXpKJhXnu2kBwrOznmzocGQbymvz
         bt1Q==
X-Gm-Message-State: AOAM533Mo8mDIU0wVJRfRc23SCdWdB+LEdF2S4MKU2XdIl09zHGgtYmI
        IZJYCEVlil83yn5QpGMwOmLM9tUMFFyogRw0Pb18q/RZ+XA/1VntkEMhOO9OZTJvdJTy6QVf9F8
        6azszx2Ir7MLPb1JCSsV9wBQxAw==
X-Received: by 2002:ad4:4661:: with SMTP id z1mr2625158qvv.19.1606827673594;
        Tue, 01 Dec 2020 05:01:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3PJhxWzDz8G3n9BDF43q/8HsRP003nUuqHywCMosTeoUNJ6+L/0zFi99YimDtKsGBrrVz2Q==
X-Received: by 2002:ad4:4661:: with SMTP id z1mr2625134qvv.19.1606827673215;
        Tue, 01 Dec 2020 05:01:13 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id n41sm1933874qtb.18.2020.12.01.05.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:01:12 -0800 (PST)
Message-ID: <0f831ca2a65b028c2682819228eb5560230a0e4d.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] overlay: Document current outstanding
 shortcoming of volatile
From:   Jeff Layton <jlayton@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Tue, 01 Dec 2020 08:01:11 -0500
In-Reply-To: <20201201110928.GA24837@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201127092058.15117-1-sargun@sargun.me>
         <20201127092058.15117-3-sargun@sargun.me>
         <CAOQ4uxgaLuLb+f6WCMvmKHNTELvcvN8C5_u=t5hhoGT8Op7QuQ@mail.gmail.com>
         <20201127221154.GA23383@ircssh-2.c.rugged-nimbus-611.internal>
         <1338a059d03db0e85cf3f3234fd33434a45606c6.camel@redhat.com>
         <20201128044530.GA28230@ircssh-2.c.rugged-nimbus-611.internal>
         <CAOQ4uxjT6FF03Sq3qXuqDcqJQnzQq2dD_XVbuj_Fb9A2Ag585w@mail.gmail.com>
         <20201128085227.GB28230@ircssh-2.c.rugged-nimbus-611.internal>
         <20201201110928.GA24837@ircssh-2.c.rugged-nimbus-611.internal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-12-01 at 11:09 +0000, Sargun Dhillon wrote:
> On Sat, Nov 28, 2020 at 08:52:27AM +0000, Sargun Dhillon wrote:
> > On Sat, Nov 28, 2020 at 09:12:03AM +0200, Amir Goldstein wrote:
> > > On Sat, Nov 28, 2020 at 6:45 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > > > 
> > > > On Fri, Nov 27, 2020 at 09:01:07PM -0500, Jeff Layton wrote:
> > > > > On Fri, 2020-11-27 at 22:11 +0000, Sargun Dhillon wrote:
> > > > > > On Fri, Nov 27, 2020 at 02:52:52PM +0200, Amir Goldstein wrote:
> > > > > > > On Fri, Nov 27, 2020 at 11:21 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > > > > > > > 
> > > > > > > > This documents behaviour that was discussed in a thread about the volatile
> > > > > > > > feature. Specifically, how failures can go hidden from asynchronous writes
> > > > > > > > (such as from mmap, or writes that are not immediately flushed to the
> > > > > > > > filesystem). Although we pass through calls like msync, fallocate, and
> > > > > > > > write, and will still return errors on those, it doesn't guarantee all
> > > > > > > > kinds of errors will happen at those times, and thus may hide errors.
> > > > > > > > 
> > > > > > > > In the future, we can add error checking to all interactions with the
> > > > > > > > upperdir, and pass through errseq_t from the upperdir on mappings,
> > > > > > > > and other interactions with the filesystem[1].
> > > > > > > > 
> > > > > > > > [1]: https://lore.kernel.org/linux-unionfs/20201116045758.21774-1-sargun@sargun.me/T/#m7d501f375e031056efad626e471a1392dd3aad33
> > > > > > > > 
> > > > > > > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > > > > > > Cc: linux-fsdevel@vger.kernel.org
> > > > > > > > Cc: linux-unionfs@vger.kernel.org
> > > > > > > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > > > > > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > > > > > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > > > > > > ---
> > > > > > > >  Documentation/filesystems/overlayfs.rst | 6 +++++-
> > > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> > > > > > > > index 580ab9a0fe31..c6e30c1bc2f2 100644
> > > > > > > > --- a/Documentation/filesystems/overlayfs.rst
> > > > > > > > +++ b/Documentation/filesystems/overlayfs.rst
> > > > > > > > @@ -570,7 +570,11 @@ Volatile mount
> > > > > > > >  This is enabled with the "volatile" mount option.  Volatile mounts are not
> > > > > > > >  guaranteed to survive a crash.  It is strongly recommended that volatile
> > > > > > > >  mounts are only used if data written to the overlay can be recreated
> > > > > > > > -without significant effort.
> > > > > > > > +without significant effort.  In addition to this, the sync family of syscalls
> > > > > > > > +are not sufficient to determine whether a write failed as sync calls are
> > > > > > > > +omitted.  For this reason, it is important that the filesystem used by the
> > > > > > > > +upperdir handles failure in a fashion that's suitable for the user.  For
> > > > > > > > +example, upon detecting a fault, ext4 can be configured to panic.
> > > > > > > > 
> > > > > > > 
> > > > > > > Reading this now, I think I may have wrongly analysed the issue.
> > > > > > > Specifically, when I wrote that the very minimum is to document the
> > > > > > > issue, it was under the assumption that a proper fix is hard.
> > > > > > > I think I was wrong and that the very minimum is to check for errseq
> > > > > > > since mount on the fsync and syncfs calls.
> > > > > > > 
> > > > > > > Why? first of all because it is very very simple and goes a long way to
> > > > > > > fix the broken contract with applications, not the contract about durability
> > > > > > > obviously, but the contract about write+fsync+read expects to find the written
> > > > > > > data (during the same mount era).
> > > > > > > 
> > > > > > > Second, because the sentence you added above is hard for users to understand
> > > > > > > and out of context. If we properly handle the writeback error in fsync/syncfs,
> > > > > > > then this sentence becomes irrelevant.
> > > > > > > The fact that ext4 can lose data if application did not fsync after
> > > > > > > write is true
> > > > > > > for volatile as well as non-volatile and it is therefore not relevant
> > > > > > > in the context
> > > > > > > of overlayfs documentation at all.
> > > > > > > 
> > > > > > > Am I wrong saying that it is very very simple to fix?
> > > > > > > Would you mind making that fix at the bottom of the patch series, so it can
> > > > > > > be easily applied to stable kernels?
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Amir.
> > > > > > 
> > > > > > I'm not sure it's so easy. In VFS, there are places where the superblock's
> > > > > > errseq is checked[1]. AFAIK, that's going to check "our" errseq, and not the
> > > > > > errseq of the real corresponding real file's superblock. One solution might be
> > > > > > as part of all these callbacks we set our errseq to the errseq of the filesystem
> > > > > > that the upperdir, and then rely on VFS's checking.
> > > > > > 
> > > > > > I'm having a hard time figuring out how to deal with the per-mapping based
> > > > > > error tracking. It seems like this infrastructure was only partially completed
> > > > > > by Jeff Layton[2]. I don't now how it's actually supposed to work right now,
> > > > > > as not all of his patches landed.
> > > > > > 
> > > > > 
> > > > > The patches in the series were all merged, but we ended up going with a
> > > > > simpler solution [1] than the first series I posted. Instead of plumbing
> > > > > the errseq_t handling down into sync_fs, we did it in the syscall
> > > > > wrapper.
> > > > Jeff,
> > > > 
> > > > Thanks for replying. I'm still a little confused as to what the
> > > > per-address_space wb_err. It seems like we should implement the
> > > > flush method, like so:
> > > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > > index efccb7c1f9bc..32e5bc0aacd6 100644
> > > > --- a/fs/overlayfs/file.c
> > > > +++ b/fs/overlayfs/file.c
> > > > @@ -787,6 +787,16 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
> > > >                             remap_flags, op);
> > > >  }
> > > > 
> > > > +static int ovl_flush(struct file *file, fl_owner_t id)
> > > > +{
> > > > +       struct file *realfile = file->private_data;
> > > > +
> > > > +       if (real_file->f_op->flush)
> > > > +               return real_file->f_op->flush(filp, id);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  const struct file_operations ovl_file_operations = {
> > > >         .open           = ovl_open,
> > > >         .release        = ovl_release,
> > > > @@ -798,6 +808,7 @@ const struct file_operations ovl_file_operations = {
> > > >         .fallocate      = ovl_fallocate,
> > > >         .fadvise        = ovl_fadvise,
> > > >         .unlocked_ioctl = ovl_ioctl,
> > > > +       .flush          = ovl_flush,
> > > >  #ifdef CONFIG_COMPAT
> > > >         .compat_ioctl   = ovl_compat_ioctl,
> > > >  #endif
> > > > 
> > > > 
> > > > > 
> > > > > I think the tricky part here is that there is no struct file plumbed
> > > > > into ->sync_fs, so you don't have an errseq_t cursor to work with by the
> > > > > time that gets called.
> > > > > 
> > > > > What may be easiest is to just propagate the s_wb_err value from the
> > > > > upper_sb to the overlayfs superblock in ovl_sync_fs(). That should get
> > > > > called before the errseq_check_and_advance in the syncfs syscall wrapper
> > > > > and should ensure that syncfs() calls against the overlayfs sb see any
> > > > > errors that occurred on the upper_sb.
> > > > > 
> > > > > Something like this maybe? Totally untested of course. May also need to
> > > > > think about how to ensure ordering between racing syncfs calls too
> > > > > (don't really want the s_wb_err going "backward"):
> > > > > 
> > > > > ----------------------------8<---------------------------------
> > > > > $ git diff
> > > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > > index 290983bcfbb3..d725705abdac 100644
> > > > > --- a/fs/overlayfs/super.c
> > > > > +++ b/fs/overlayfs/super.c
> > > > > @@ -283,6 +283,9 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> > > > >         ret = sync_filesystem(upper_sb);
> > > > >         up_read(&upper_sb->s_umount);
> > > > > 
> > > > > +       /* Propagate s_wb_err from upper_sb to overlayfs sb */
> > > > > +       WRITE_ONCE(sb->s_wb_err, READ_ONCE(upper_sb->s_wb_err));
> > > > > +
> > > > >         return ret;
> > > > >  }
> > > > > ----------------------------8<---------------------------------
> > > > > 
> > > > > [1]: https://www.spinics.net/lists/linux-api/msg41276.html
> > > > 
> > > > So,
> > > > I think this will have bad behaviour because syncfs() twice in a row will
> > > > return the error twice. The reason is that normally in syncfs it calls
> > > > errseq_check_and_advance marking the error on the super block as seen. If we
> > > > copy-up the error value each time, it will break this semantic, as we do not set
> > > > seen on the upperdir.
> > > > 
> > > > Either we need to set the seen flag on the upperdir's errseq_t, or have a sync
> > > > method, like:
> > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > index 290983bcfbb3..4931d1797c03 100644
> > > > --- a/fs/overlayfs/super.c
> > > > +++ b/fs/overlayfs/super.c
> > > > @@ -259,6 +259,7 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> > > >  {
> > > >         struct ovl_fs *ofs = sb->s_fs_info;
> > > >         struct super_block *upper_sb;
> > > > +       errseq_t src;
> > > >         int ret;
> > > > 
> > > >         if (!ovl_upper_mnt(ofs))
> > > > @@ -283,6 +284,11 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> > > >         ret = sync_filesystem(upper_sb);
> > > >         up_read(&upper_sb->s_umount);
> > > > 
> > > > +       /* Propagate the error up from the upper_sb once */
> > > > +       src = READ_ONCE(upper_sb->s_wb_err);
> > > > +       if (errseq_counter(src) != errseq_counter(sb->s_wb_err))
> > > > +               WRITE_ONCE(sb->s_wb_err, src & ~ERRSEQ_SEEN);
> > > > +
> > > >         return ret;
> > > >  }
> > > > 
> > > > @@ -1945,6 +1951,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > 
> > > >                 sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> > > >                 sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > > > +               sb->s_wb_err = READ_ONCE(ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
> > > > 
> > > > diff --git a/lib/errseq.c b/lib/errseq.c
> > > > index 81f9e33aa7e7..53275c168265 100644
> > > > --- a/lib/errseq.c
> > > > +++ b/lib/errseq.c
> > > > @@ -204,3 +204,18 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
> > > >         return err;
> > > >  }
> > > >  EXPORT_SYMBOL(errseq_check_and_advance);
> > > > +
> > > > +/**
> > > > + * errseq_counter() - Get the value of the errseq counter
> > > > + * @eseq: Value being checked
> > > > + *
> > > > + * This returns the errseq_t counter value. Reminder, it can wrap because
> > > > + * there are only a limited number of counter bits.
> > > > + *
> > > > + * Return: The counter portion of the errseq_t.
> > > > + */
> > > > +int errseq_counter(errseq_t eseq)
> > > > +{
> > > > +       return eseq >> (ERRSEQ_SHIFT + 1);
> > > > +}
> > > > 
> > > > This also needs some locking sprinkled on it because racing can occur with
> > > > sync_fs. This would be much easier if the errseq_t was 64-bits, and didn't go
> > > > backwards, because you could just use a simple cmpxchg64. I know that would make
> > > > a bunch of structures larger, and if it's just overlayfs that has to pay the tax
> > > > we can just sprinkle a mutex on it.
> > > > 
> > > > We can always "copy-up" the errseq_t because if the upperdir's errseq_t is read,
> > > > and we haven't done a copy yet, we'll get it. Since this will be strictly
> > > > serialized a simple equivalence check will work versus actually having to deal
> > > > with happens before behaviour. There is still a correctness flaw here though,
> > > > which is exactly enough errors occur to result in it wrapping back to the same
> > > > value, it will break.
> > > > 
> > > > By the way, how do y'all test this error handling behaviour? I didn't
> > > > find any automated testing for what currently exists.
> > > > > 
> > > > > How about I split this into two patchsets? One, where I add the logic to copy
> > > > > the errseq on callbacks to fsync from the upperdir to the ovl fs superblock,
> > > > > and thus allowing VFS to bubble up errors, and the documentation. We can CC
> > > > > stable on those because I think it has an effect that's universal across
> > > > > all filesystems.
> > > > > 
> > > > > P.S.
> > > > > I notice you maintain overlay tests outside of the kernel. Unfortunately, I
> > > > > think for this kind of test, it requires in kernel code to artificially bump the
> > > > > writeback error count on the upperdir, or it requires the failure injection
> > > > > infrastructure.
> > > > > 
> > > > > Simulating this behaviour is non-trivial without in-kernel support:
> > > > > 
> > > > > P1: Open(f) -> p1.fd
> > > > > P2: Open(f) -> p2.fd
> > > > > P1: syncfs(p1.fd) -> errrno
> > > > > P2: syncfs(p1.fd) -> 0 # This should return an error
> > > > > 
> > > > > 
> > > > > [1]: https://elixir.bootlin.com/linux/latest/source/fs/sync.c#L175
> > > > > [2]: https://lwn.net/Articles/722250/
> > > > > 
> > > > > 
> > > 
> > > Sargun (and Jeff),
> > > 
> > > Thank you for this discussion. It would be very nice to work on testing
> > > and fixing errseq propagation is correct on overlayfs.
> > > Alas, this is not what I suggested.
> > > 
> > > What I suggested was a solution only for the volatile overlay issue
> > > where data can vaporise without applications noticing:
> > > "...the very minimum is to check for errseq since mount on the fsync
> > >  and syncfs calls."
> > > 
> > Yeah, I was confusing the checking that VFS does on our behalf and the checking 
> > that we can do ourselves in the sync callback. If we return an error prior to 
> > the vfs checking it short-circuits that entirely.
> > 
> > > Do you get it? there is no pre-file state in the game, not for fsync and not 
> > > for syncfs.
> > > 
> > > Any single error, no matter how temporary it is and what damage it may
> > > or may not have caused to upper layer consistency, permanently
> > > invalidates the reliability of the volatile overlay, resulting in:
> > > Effective immediately: every fsync/syncfs returns EIO.
> > > Going forward: maybe implement overlay shutdown, so every access
> > > returns EIO.
> > > 
> > > So now that I hopefully explained myself better, I'll ask again:
> > > Am I wrong saying that it is very very simple to fix?
> > > Would you mind making that fix at the bottom of the patch series, so it can
> > > be easily applied to stable kernels?
> > > 
> > > Thanks,
> > > Amir.
> > 
> > I think that this should be easy enough if the semantic is such that volatile
> > overlayfs mounts will return EIO on syncfs on every syncfs call if the upperdir's
> > super block has experienced errors since the initial mount. I imagine we do not
> > want to make it such that if the upperdir has ever experienced errors, return
> > EIO on syncfs.
> > 
> > The one caveat that I see is that if the errseq wraps, we can silently begin 
> > swallowing errors again. Thus, on the first failed syncfs we should just
> > store a flag indicating that the volatile fs is bad, and to continue to return
> > EIO rather than go through the process of checking errseq_t, but that's easy
> > enough to write.
> 
> It turns out this is much more complicated than I initially thought. I'm not 
> entirely sure why VFS even defines sync_fs (on the superblock) as returning an 
> int. The way that sync_fs works is:
> 
> sys_syncfs ->
>   sync_filesystem(sb) ->
>     __sync_filesystem(sb, N) ->
>       sb->s_op->sync_fs
>       /* __sync_blockdev has its own writeback error checking */
>       __sync_blockdev
>   errseq_check_and_advance(sb...)
> 
> __sync_filesystem calls the sync_fs callback on the superblock's superblock
> operations:
> 
> static int __sync_filesystem(struct super_block *sb, int wait)
> {
> 	if (wait)
> 		sync_inodes_sb(sb);
> 	else
> 		writeback_inodes_sb(sb, WB_REASON_SYNC);
> 
> 	if (sb->s_op->sync_fs)
> 		sb->s_op->sync_fs(sb, wait);
> 	return __sync_blockdev(sb->s_bdev, wait);
> }
> 
> But it completely discards the result. On the other hand, fsync, and fdatasync
> exhibit different behaviour:
> 
> sys_fdatasync ->
>   do_fsync
>    (see below)
> 
> sys_fsync ->
>   do_fsync ->
>     vfs_fsync ->
>       vfs_fsync_range ->
>         return file->f_op->fsync
> ----
> 

This is mainly a result of the evolution of the code. In the beginning
there was only sync() and it doesn't report errors. Eventually syncfs()
was added, but the only error it reliably reported was EBADF.

I added the machinery to record writeback errors of individual inodes at
the superblock level recently, but the sync_fs op was left alone (mainly
because changing this would be very invasive, and the value of doing so
wasn't completely clear).


> 
> syncfs seems to enforce the semantics laid out by VFS[1]. Specifically the 
> statement:
>   When there is an error during writeback, they expect that error to be reported 
>   when a file sync request is made. After an error has been reported on one 
>   request, subsequent requests on the same file descriptor should return 0, unless 
>   further writeback errors have occurred since the previous file syncronization.
> 
> This is enforced by the errseq_check_and_advance logic. We can hack around this
> logic by resetting the errset (setting the error on it) every time we get the
> sync_fs callback, but that to me seems wrong. FWIW, implementing this behaviour
> for fdatasync, and fsync is easier, because the error is bubbled up from the
> filesystem to the VFS. I don't actually think this is a good idea because
> it seems like this sync_fs behaviour is a bit...not neccessarily what all
> filesystems expect. For example, btrfs_sync_fs returns an error if it
> is unable to finish the current transaction. Nowhere in the btrfs code
> does it set the errseq on the superblock if this fails.
> 
> I think we have a couple paths forward:
> 1. Change the semantic of sync_fs so the error is always bubbled up if
>    it returns a non-zero value. If we do this, we have to decide whether
>    or not we would _also_ call errseq_check_and_advance on the SB,
>    or leave that to a subsequent call.

You would want to call errseq_check_and_advance in that situation.
Otherwise a subsequent syncfs call would return an error even when an
error had not occurred since the last syncfs.

> 2. Have overlayfs forcefully set an error on the superblock on every
>    callback to sync_fs. This seems ugly, but I wrote a little patch,
>    and it seems to solve the problem for all the fsync / fdatasync /
>    sync / syncfs variants without having to do plumbing in VFS.

It is ugly, but that's probably the easiest solution.

> 3. Choose a different set of semantics for how we want to handle
>    errors in volatile mounts.
> 
> [1]: https://www.kernel.org/doc/html/v5.9/filesystems/vfs.html?highlight=handling%20errors%20during%20writeback#handling-errors-during-writeback
> 

-- 
Jeff Layton <jlayton@redhat.com>

