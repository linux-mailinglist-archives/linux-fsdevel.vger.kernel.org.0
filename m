Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C315721DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 19:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiGLRk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGLRk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:40:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349CBC25AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 10:40:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 70so8093424pfx.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp14BDiJ3o3yBys1mNzUPG3x8p1qawMTa3Q7bZ9V7ZQ=;
        b=JY1A1qPuUfcobXSu0qwLPgQ3ReI/jpVuV88VYHV8/If49pMd0RDr4gujE+Epi0V+pt
         MR1Md8Mt4od2yWXymnRQIs2rnbJCKyK8h2ZBriJa/VlBXDJskI7u6X5UZPA9jrykbCAc
         S0fdmGAzVueQoSYSAFvtwMEc7tq9oRFG7kS+9LFRFipZO2kcbd/AYV7P0YezpS0uLFUr
         VMV68lkSOkDnLV/SF7xX3hNXmfuO+65NJTWUvybohd95W6/Z0wBiFIDZyA6dj+R3hlL5
         7vLbMup2inmleDBdFQt/jvIcXjpUtwFUUcWiKeLXMAbA/oa+MFaRtuZJydb7wkkap/w+
         5D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp14BDiJ3o3yBys1mNzUPG3x8p1qawMTa3Q7bZ9V7ZQ=;
        b=OW4D+IGfgFApGAp12Y7khKtQuloylA44YmVAZoxtrnKAsQrqbfsVY++QD8XJCIBhHU
         /AfMdz6yxEdSLCvPQUdN2q19Oj3VYzlXM3urrVjgWE7WV3KrZOKKm9tgdUUyY8GFSnZ9
         6udH0aPa2PRboumg54b27bWMCVkgho45TxtfWTxGbSjzE7MyLAoWBwK1mS3rVw5yCi8S
         ykvL9W+d8sFDzji7DzyP3IU0c/wh/M9JOR7qDLJCU5kiNNQEh+sN8bwtfvFApVb1gk1C
         StiuBUKsHZ7D+Blg5zkm2iUg9QUSpKVGmJb9ikQTgn17BbEeOr4SVdLPvBO86js0eKIQ
         IQqQ==
X-Gm-Message-State: AJIora9wsbTk8yp4dLs4TG9zbEoSzYUGVhPTsJJuna8dZHfNkV73xXAu
        JY6nA1T7nIey40vLh9/RlYingO/QKowFja+EAEs=
X-Google-Smtp-Source: AGRyM1t5I4ckAblDJVCQOsZeDEea9rEVIbFiFh5Nju1djPkIcFOozw7FE7mOLqeUdQulEtdeUh/OnxcxdoBGurVJuqY=
X-Received: by 2002:a63:3cd:0:b0:415:f76d:fb4 with SMTP id 196-20020a6303cd000000b00415f76d0fb4mr10978219pgd.587.1657647623722;
 Tue, 12 Jul 2022 10:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220707165650.248088-1-rppt@kernel.org> <CAHbLzkqLPi9i3BspCLUe=eZ4huTY2ZnbfD19K_ShsaOC47En_w@mail.gmail.com>
 <YsdITMg5xZiu8Yoh@magnolia> <CAHbLzkpnkcFg5hOf49V=gFSvTWsWUe_M8-69knDpvSSdua+x4w@mail.gmail.com>
 <Ysfqxg9Ury1NX27N@kernel.org>
In-Reply-To: <Ysfqxg9Ury1NX27N@kernel.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Jul 2022 10:40:11 -0700
Message-ID: <CAHbLzkpB59wX-U4Y4Bs4hxAZKy9JG29UtRPks1458VredwRxTg@mail.gmail.com>
Subject: Re: [PATCH v2] secretmem: fix unhandled fault in truncate
To:     Mike Rapoport <rppt@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 8, 2022 at 1:29 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Thu, Jul 07, 2022 at 03:09:32PM -0700, Yang Shi wrote:
> > On Thu, Jul 7, 2022 at 1:55 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Thu, Jul 07, 2022 at 10:48:00AM -0700, Yang Shi wrote:
> > > > On Thu, Jul 7, 2022 at 9:57 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > >
> > > > > Eric Biggers suggested that this happens when
> > > > > secretmem_setattr()->simple_setattr() races with secretmem_fault() so
> > > > > that a page that is faulted in by secretmem_fault() (and thus removed
> > > > > from the direct map) is zeroed by inode truncation right afterwards.
> > > > >
> > > > > Since do_truncate() takes inode_lock(), adding inode_lock_shared() to
> > > > > secretmem_fault() prevents the race.
> > > >
> > > > Should invalidate_lock be used to serialize between page fault and truncate?
> > >
> > > I would have thought so, given Documentation/filesystems/locking.rst:
> > >
> > > "->fault() is called when a previously not present pte is about to be
> > > faulted in. The filesystem must find and return the page associated with
> > > the passed in "pgoff" in the vm_fault structure. If it is possible that
> > > the page may be truncated and/or invalidated, then the filesystem must
> > > lock invalidate_lock, then ensure the page is not already truncated
> > > (invalidate_lock will block subsequent truncate), and then return with
> > > VM_FAULT_LOCKED, and the page locked. The VM will unlock the page."
> > >
> > > IIRC page faults aren't supposed to take i_rwsem because the fault could
> > > be in response to someone mmaping a file into memory and then write()ing
> > > to the same file using the mmapped region.  The write() takes
> > > inode_lock and faults on the buffer, so the fault cannot take inode_lock
> > > again.
> >
> > Do you mean writing from one part of the file to the other part of the
> > file so the "from" buffer used by copy_from_user() is part of the
> > mmaped region?
> >
> > Another possible deadlock issue by using inode_lock in page faults is
> > mmap_lock is acquired before inode_lock, but write may acquire
> > inode_lock before mmap_lock, it is a AB-BA lock pattern, but it should
> > not cause real deadlock since mmap_lock is not exclusive for page
> > faults. But such pattern should be avoided IMHO.
> >
> > > That said... I don't think memfd_secret files /can/ be written to?
>
> memfd_secret files cannot be written to, they can only be mmap()ed.
> Synchronization is only required between
> do_truncate()->...->simple_setatt() and secretmem->fault() and I don't see
> how that can deadlock.

Sure, there is no deadlock.

>
> I'm not an fs expert though, so if you think that invalidate_lock() is
> safer, I don't mind s/inode_lock/invalidate_lock/ in the patch.

IIUC invalidate_lock should be preferred per the filesystem's locking
document. And I found Jan Kara's email of the invalidate_lock
patchset, please refer to
https://lore.kernel.org/linux-mm/20210715133202.5975-1-jack@suse.cz/.

>
> > > Hard to say, since I can't find a manpage describing what that syscall
> > > does.
>
> Right, I don't see it's published :-/
>
> There is a groff version:
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/memfd_secret.2
>
> > > --D
> > >
> > > >
> > > > >
> > > > > Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
> > > > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > > ---
> > > > >
> > > > > v2: use inode_lock_shared() rather than add a new rw_sem to secretmem
> > > > >
> > > > > Axel, I didn't add your Reviewed-by because v2 is quite different.
> > > > >
> > > > >  mm/secretmem.c | 21 ++++++++++++++++-----
> > > > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > > > > index 206ed6b40c1d..a4fabf705e4f 100644
> > > > > --- a/mm/secretmem.c
> > > > > +++ b/mm/secretmem.c
> > > > > @@ -55,22 +55,28 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > > > >         gfp_t gfp = vmf->gfp_mask;
> > > > >         unsigned long addr;
> > > > >         struct page *page;
> > > > > +       vm_fault_t ret;
> > > > >         int err;
> > > > >
> > > > >         if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > > > >                 return vmf_error(-EINVAL);
> > > > >
> > > > > +       inode_lock_shared(inode);
> > > > > +
> > > > >  retry:
> > > > >         page = find_lock_page(mapping, offset);
> > > > >         if (!page) {
> > > > >                 page = alloc_page(gfp | __GFP_ZERO);
> > > > > -               if (!page)
> > > > > -                       return VM_FAULT_OOM;
> > > > > +               if (!page) {
> > > > > +                       ret = VM_FAULT_OOM;
> > > > > +                       goto out;
> > > > > +               }
> > > > >
> > > > >                 err = set_direct_map_invalid_noflush(page);
> > > > >                 if (err) {
> > > > >                         put_page(page);
> > > > > -                       return vmf_error(err);
> > > > > +                       ret = vmf_error(err);
> > > > > +                       goto out;
> > > > >                 }
> > > > >
> > > > >                 __SetPageUptodate(page);
> > > > > @@ -86,7 +92,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > > > >                         if (err == -EEXIST)
> > > > >                                 goto retry;
> > > > >
> > > > > -                       return vmf_error(err);
> > > > > +                       ret = vmf_error(err);
> > > > > +                       goto out;
> > > > >                 }
> > > > >
> > > > >                 addr = (unsigned long)page_address(page);
> > > > > @@ -94,7 +101,11 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > > > >         }
> > > > >
> > > > >         vmf->page = page;
> > > > > -       return VM_FAULT_LOCKED;
> > > > > +       ret = VM_FAULT_LOCKED;
> > > > > +
> > > > > +out:
> > > > > +       inode_unlock_shared(inode);
> > > > > +       return ret;
> > > > >  }
> > > > >
> > > > >  static const struct vm_operations_struct secretmem_vm_ops = {
> > > > >
> > > > > base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
>
> --
> Sincerely yours,
> Mike.
