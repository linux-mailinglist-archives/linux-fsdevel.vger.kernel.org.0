Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9129E28FD60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 06:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgJPEjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 00:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbgJPEjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:39:23 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9F8C061755;
        Thu, 15 Oct 2020 21:39:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j13so1250815ilc.4;
        Thu, 15 Oct 2020 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fppX8e1RRrnveELQj6Lyrb+agfYyjKup6HAmwYd2q6U=;
        b=NyBPyqw3cbr8C6TzaeGx7BG5wArhebB6CjIWpbyMjg1v5yofjdN7aIxGgs8OEjZhrO
         2RV6SgDLh4XhsIqx/IuxCzxFOU99RvkTlD1xUU2EBoKWiwvl1fdChE793HQP119W6O2x
         jPSSsblFcG+zKvbCxm6NiXdV5FG0QXBowsriSc76KD5H7RDxrwrxgJy39I+8t556aOXW
         w6waw8ad079Gd/M/bR6q3TGtixmu98TXzQHXleCjfuY1pON2ISni3NhUa7kgnlYghMI4
         pWW/MKJTd7sLIjzbod5f+LJc59AP1Hp6eV7pWozr2rE3NzoyaJhtMpBI/Lls8Ty+uZJr
         RjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fppX8e1RRrnveELQj6Lyrb+agfYyjKup6HAmwYd2q6U=;
        b=Ak4Dwdp/dfMtms0K4Xfz1fZji4c4SRaqVF0P+Xf56ZvWQHCgKhSW7zK+pbQJi/YT4x
         ajET/V2+FaIA+YLNDIXBiHiHxXT1bMzZ5uRhRgAsSS1pLOj8pbvowpbOD5oi3KrcHE/W
         aRHgVqwpgqsULOBTBPm0NxkA3hHy8MGgLjp03gHTJCff3Qz2doi7jWg2pM7jlgcUMqpD
         NSHw/uH9V26QZpQoP0NySE/r29GgnckD+C6Av/Uz1rwf24Mflxchx424jorxJFklhdo8
         fOi0l3m6w5J1NzxNw8bgEv6p9LAf4o+sCm9ZtiD7z2S0uJwcS4YPMfYpjGiluYLdJz8r
         +bqg==
X-Gm-Message-State: AOAM530htunl7Xqt9QL3xDCARVe+3GuVxmM9Rtv/9joMcM7Mt4iWzEvS
        sF3r3kcWATYgj6rPuKqJ3O/EqWmsXUVO+GqVEEw=
X-Google-Smtp-Source: ABdhPJyybxhFqL68WSuu8wiIKAB4ir1QNA7DWOX5c5MGpHIpUEXVXa1PVX5CYNgO/XCDu8DYpzf3eKA3ns4M3eSRoqo=
X-Received: by 2002:a92:8b41:: with SMTP id i62mr1450678ild.9.1602823161370;
 Thu, 15 Oct 2020 21:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
 <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com>
 <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net>
 <CAOQ4uxhEA=ggONsJrUzGfHOGHob+81-UHk1Wo9ejj=CziAjtTQ@mail.gmail.com>
 <1752c652963.113ee3fbc44343.6282793280578516240@mykernel.net>
 <CAOQ4uxhujP_pzguq+FJ87Mx4GBNzEWQs-izuXK1qhWu3EmLpJA@mail.gmail.com> <1752f1f2c1a.c646418645575.6542807445910962686@mykernel.net>
In-Reply-To: <1752f1f2c1a.c646418645575.6542807445910962686@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Oct 2020 07:39:10 +0300
Message-ID: <CAOQ4uxgJ=soSgdWo20iNtm30hua8kL8Do3T_FH2uTehQWOGsTg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 4:56 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-10-16 00:02:42 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > >  > >  > When an inode is writably mapped via ovarlayfs, you can flag=
 the
>  > >  > >  > overlay inode with "maybe-writably-mapped" and then remove
>  > >  > >  > it from the maybe dirty list when the underlying inode is no=
t dirty
>  > >  > >  > AND its i_writecount is 0 (checked on write_inode() and rele=
ase()).
>  > >  > >  >
>  > >  > >  > Actually, there is no reason to treat writably mapped inodes=
 and
>  > >  > >  > other dirty inodes differently - insert to suspect list on o=
pen for
>  > >  > >  > write, remove from suspect list on last release() or write_i=
node()
>  > >  > >  > when inode is no longer dirty and writable.
>  > >
>  > > I have to say inserting to suspect list cannot prevent dropping,
>  > > thinking of the problem of previous approach that we write dirty upp=
er
>  > > inode with current->flags & PF_MEMALLOC while evicting clean overlay=
 inode.
>  > >
>  >
>  > Sorry, I don't understand what that means.
>
> This is the main problem of my previous patch set V10, evicting clean ino=
de
> expects no write behavior but in the case of dirty upper inode we have to
> write out dirty data in this timing otherwise we will lose the connection=
 with upper inode.
>

My thinking was that the suspect list holds a reference to the overlay inod=
e.
The question is can we always safely get rid of that reference and remove
from the suspect list when the inode is no longer "writable". Let's see...

>
>  >
>  > >
>  > >  > >  >
>  > >  > >  > Did I miss anything?
>  > >  > >  >
>  > >  > >
>  > >  > > If we dirty overlay inode that means we have launched writeback=
 mechanism,
>  > >  > > so in this case, re-dirty overlay inode in time becomes importa=
nt.
>  > >  > >
>  > >  >
>  > >  > My idea was to use the first call to ovl_sync_fs() with 'wait' fa=
lse
>  > >  > to iterate the
>  > >  > maybe-dirty list and re-dirty overlay inodes whose upper is dirty=
.
>  > >  >
>  > >
>  > > I'm curious how we prevent dropping of clean overlay inode with dirt=
y upper?
>  > > Hold another reference during iput_final operation? in the drop_inod=
e() or something
>  > > else?
>  >
>  > No, just return 0 from ovl_drop_inode() and iput_final() will not evic=
t().
>
> It's not good,  it  only temporarily  skips eviction, the inode in lru li=
st
> will be evicted in some cases like drop cache or memory reclaim. etc.
>
> A solution for this is getting another reference in ->drop_inode so that
> the inode can escape from adding to lru list but this looks awkward and t=
ricky.
>

Right, that was nonsense. We need to rely on the reference held by the
suspect list.

>  >
>  > >
>  > >
>  > >  > Then in the second call to __sync_filesystem, sync_inodes_sb() wi=
ll take
>  > >  > care of calling ovl_write_inode() for all the re-dirty inodes.
>  > >  >
>  > >  > In current code we sync ALL dirty upper fs inodes and we do not o=
verlay
>  > >  > inodes with no reference in cache.
>  > >  >
>  > >  > The best code would sync only upper fs inodes dirtied by this ove=
rlay
>  > >  > and will be able to evict overlay inodes whose upper inodes are c=
lean.
>  > >  >
>  > >  > The compromise code would sync only upper fs inodes dirtied by th=
is overlay,
>  > >  > and would not evict overlay inodes as long as upper inodes are "o=
pen for write".
>  > >  > I think its a fine compromise considering the alternatives.
>  > >  >
>  > >  > Is this workable?
>  > >  >
>  > >
>  > > In your approach, the key point is how to prevent dropping overlay i=
node that has
>  > > dirty upper and no reference but I don't understand well how to achi=
eve it from
>  > > your descriptions.
>  > >
>  > >
>  >
>  > Very well, I will try to explain with code:
>  >
>  > int ovl_inode_is_open_for_write(struct inode *inode)
>  > {
>  >        struct inode *upper_inode =3D ovl_inode_upper(inode);
>  >
>  >        return upper_inode && inode_is_open_for_write(upper_inode);
>  > }
>  >
>  > void ovl_maybe_mark_inode_dirty(struct inode *inode)
>  > {
>  >        struct inode *upper_inode =3D ovl_inode_upper(inode);
>  >
>  >        if (upper_inode && upper_inode->i_state & I_DIRTY_ALL)
>  >                 mark_inode_dirty(inode);
>  > }
>  >
>  > int ovl_open(struct inode *inode, struct file *file)
>  > {
>  > ...
>  >        if (ovl_inode_is_open_for_write(file_inode(file)))
>  >                ovl_add_inode_to_suspect_list(inode);
>  >
>  >         file->private_data =3D realfile;
>  >
>  >         return 0;
>  > }
>  >
>  > int ovl_release(struct inode *inode, struct file *file)
>  > {
>  >        struct inode *inode =3D file_inode(file);
>  >
>  >        if (ovl_inode_is_open_for_write(inode)) {
>  >                ovl_maybe_mark_inode_dirty(inode);
>  >                ovl_remove_inode_from_suspect_list(inode);
>
> I think in some cases removing from suspect_list will cause losing
> the connection with upper inode that has writable mmap.
>

First of all I had a bug here.
Need to check for !ovl_inode_is_open_for_write(inode) after fput().

If the upper inode has a writable mmap, the upper inode would still
be "writable" (i_writecount held by the map realfile reference).

So when closing the last overlay file reference while upper inode
writable maps still exist, the remaining issue is when to remove
the overlay inode from the suspect list and allow its eviction and
I did not mention that.

I *think* that this condition should be safe in the regard that
after the condition is met, there is no way to dirty the upper inode
via overlayfs without going through ovl_open().
Obviously, the test should be done with some list lock held.

bool ovl_may_remove_from_suspect_list(struct inode *inode)
{
        struct inode *upper_inode =3D ovl_inode_upper(inode);

        if (upper_inode && upper_inode->i_state & I_DIRTY_ALL)
                return false;

        return !inode_is_open_for_write(upper_inode);
}

Now remains the question of WHEN to check for removal
from the suspect list.

The first place is in ovl_sync_fs() when iterating the suspect list,
inodes that meet the above criteria are "indefinitely clean" and
may be removed from the list at that timing.

For eviction during memory pressure, overlay can register a
shrinker to do this garbage collection. Is shrinker being called
on drop_caches? I'm not sure. But we can also do periodic garbage
collection.

In the end, it is not the common case and we just need the garbage
collection to mitigate DoS (or existing workload) that does many:
- open
- mmap(...PROT_WRITE, MAP_SHARED...)
- close
- munmap


>
>  >        }
>  >
>  >         fput(file->private_data);
>  >
>  >         return 0;
>  > }
>  >
>  > int ovl_drop_inode(struct inode *inode)
>  > {
>  >        struct inode *upper_inode =3D ovl_inode_upper(inode);
>  >
>  >        if (!upper_inode)
>  >                return 1;
>  >        if (upper_inode->i_state & I_DIRTY_ALL)
>  >                return 0;
>  >
>  >        return !inode_is_open_for_write(upper_inode);
>
> Is this condition just for writable mmap?
>

No, it's for all inodes that may be written from overlayfs (or
from maps created by overalyfs), but as you wrote, this
test is not needed in drop_inode().

>
>  > }
>  >
>  > static int ovl_sync_fs(struct super_block *sb, int wait)
>  > {
>  >         struct ovl_fs *ofs =3D sb->s_fs_info;
>  >         struct super_block *upper_sb;
>  >         int ret;
>  >
>  >         if (!ovl_upper_mnt(ofs))
>  >                 return 0;
>  >
>  >         /*
>  >          * Not called for sync(2) call or an emergency sync (SB_I_SKIP=
_SYNC).
>  >          * All the super blocks will be iterated, including upper_sb.
>  >          *
>  >          * If this is a syncfs(2) call, then we do need to call
>  >          * sync_filesystem() on upper_sb, but enough if we do it when =
being
>  >          * called with wait =3D=3D 1.
>  >          */
>  >         if (!wait) {
>  >                 /* mark inodes on the suspect list dirty if thier
>  > upper inode is dirty */
>  >                 ovl_mark_suspect_list_inodes_dirty();
>  >                 return 0;
>  >         }
>  > ...
>  >
>
> Why 2 rounds?  it seems the simplest way is only syncing dirty upper inod=
e
> on wait=3D=3D1 just like my previous patch.
>

We don't have to do it in 2 rounds, but as long as we have a suspect list,
we can use it to start writeback on wait=3D=3D0 on all dirty upper inodes f=
rom
our list just like the caller intended.

Do we need overlay sbi and mark_inode_dirty() and ovl_write_inode() at all?
I'm not sure. It feels like a good idea to use generic infrastructure as mu=
ch as
possible. You should know better than me to answer this question.

Thanks,
Amir.
