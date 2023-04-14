Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE06E2CCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 01:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDNX05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 19:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDNX0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:26:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC6B6A5A
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 16:26:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j193-20020a2523ca000000b00b8f6b82ec94so4067168ybj.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681514802; x=1684106802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+CdS/YAmA5S1F/LB6OGsrwDYAK7DxTDkVw+gfhAepA=;
        b=X6xqig1KGe44JWfGobl88i68LvH8fuxeySMJifqRsYyD6UTHZ7QOjIguBlvCRg96oh
         WXZfrnDdhsEwDT29I8rCw6tpWoA2VDlVT/hcuKKgo7Ei+dZTDumyfXXSJIV4h3HvvTtQ
         M/jF1u45Ld3m/t0bapwufNcZVEpiU7GNEn4IS7RZqLJ4IxYziW/+em7ZbxmEzFPl0h5u
         ngGOBHl0NKqHdVAxdirGtinyrWG0TxNmTOjSO/BOzHuWHKnZ8WRNCgK0XWrX2vqO8QKz
         a23RkYq2JbNyZXdSKRuH9aUC5ut9ZsgPw7GVcbkGfAu+Z6WUUklAn4WnntF4rDnomDVB
         fbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681514802; x=1684106802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+CdS/YAmA5S1F/LB6OGsrwDYAK7DxTDkVw+gfhAepA=;
        b=XzyyTArsr2bfU03Z1HI+qxkDeC1k6kxA6Y246ubOeYmJGrLHvGLM1/rxDyAseaJbg9
         7Z+PekB1x/SiVN0vZ9L1BTwS8Z1+UGZtuld5xsS2RnCRKOvrH+KIezURmXUOU4qXex6V
         zxxNEm2Mh5zTemDeFJ7tRHsCmob6DnFY4Fq0EHozOkY9vRQ4/qShqmBeWfEDomgr03Tz
         eZ4biGX0Tw6e2yJCufUJSOMeVvMpYZJVy+p5x5Yp1rCbmQluZt0j3r8m+gmY6wzjTcrR
         wWsG2W4OiBWFD8ys9pwjp1jBlrsi1G9MtVRv7BAhwPz3INsdouJN+455hpjZwjKYe739
         kPNw==
X-Gm-Message-State: AAQBX9fUhuw+/efWZjr/izQnTqzJd1XE4hBu7W+cS+7O7yVGOqLavQHZ
        ET+tnqcySLE8tZqV9nP5txEYzqs4xGg=
X-Google-Smtp-Source: AKy350bfBVGyb8j5M296HHMJlDF+8v2QV+6OwIFFK8rNd9KmApATUdcntOjhB2WH/vHF6B11161fuLNJq1Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ec47:0:b0:54e:e490:d190 with SMTP id
 r7-20020a0dec47000000b0054ee490d190mr4836875ywn.4.1681514802680; Fri, 14 Apr
 2023 16:26:42 -0700 (PDT)
Date:   Fri, 14 Apr 2023 16:26:41 -0700
In-Reply-To: <diqzbkjqnl6t.fsf@ackerleytng-cloudtop.c.googlers.com>
Mime-Version: 1.0
References: <ZDiCG/7OgDI0SwMR@google.com> <diqzbkjqnl6t.fsf@ackerleytng-cloudtop.c.googlers.com>
Message-ID: <ZDnhMQ2aoVYh6Qr2@google.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     brauner@kernel.org, kirill.shutemov@linux.intel.com,
        chao.p.peng@linux.intel.com, hughd@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        corbet@lwn.net, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, michael.roth@amd.com,
        mhocko@suse.com, songmuchun@bytedance.com, pankaj.gupta@amd.com,
        linux-arch@vger.kernel.org, arnd@arndb.de, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, tabba@google.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Thu, Apr 13, 2023, Christian Brauner wrote:
> > > * by a mount option to tmpfs that makes it act
> > >    in this restricted manner then you don't need an ioctl() and can get
> > >    away with regular open calls. Such a tmpfs instance would only create
> > >    regular, restricted memfds.
> 
> > I'd prefer to not go this route, becuase IIUC, it would require relatively
> > invasive changes to shmem code, and IIUC would require similar changes to
> > other support backings in the future, e.g. hugetlbfs?  And as above, I
> > don't think any of the potential use cases need restrictedmem to be a
> > uniquely identifiable mount.
> 
> FWIW, I'm starting to look at extending restrictedmem to hugetlbfs and
> the separation that the current implementation has is very helpful. Also
> helps that hugetlbfs and tmpfs are structured similarly, I guess.
> 
> > One of the goals (hopefully not a pipe dream) is to design restrictmem in
> > such a way that extending it to support other backing types isn't terribly
> > difficult.  In case it's not obvious, most of us working on this stuff
> > aren't filesystems experts, and many of us aren't mm experts either.  The
> > more we (KVM folks for the most part) can leverage existing code to do the
> > heavy lifting, the better.
> 
> > After giving myself a bit of a crash course in file systems, would
> > something like the below have any chance of (a) working, (b) getting
> > merged, and (c) being maintainable?
> 
> > The idea is similar to a stacking filesystem, but instead of stacking,
> > restrictedmem hijacks a f_ops and a_ops to create a lightweight shim around
> > tmpfs.  There are undoubtedly issues and edge cases, I'm just looking for a
> > quick "yes, this might be doable" or a "no, that's absolutely bonkers,
> > don't try it".
> 
> Not an FS expert by any means, but I did think of approaching it this
> way as well!
> 
> "Hijacking" perhaps gives this approach a bit of a negative connotation.

Heh, commandeer then.

> I thought this is pretty close to subclassing (as in Object
> Oriented Programming). When some methods (e.g. fallocate) are called,
> restrictedmem does some work, and calls the same method in the
> superclass.
> 
> The existing restrictedmem code is a more like instantiating an shmem
> object and keeping that object as a field within the restrictedmem
> object.
> 
> Some (maybe small) issues I can think of now:
> 
> (1)
> 
> One difficulty with this approach is that other functions may make
> assumptions about private_data being of a certain type, or functions may
> use private_data.
> 
> I checked and IIUC neither shmem nor hugetlbfs use the private_data
> field in the inode's i_mapping (also file's f_mapping).
> 
> But there's fs/buffer.c which uses private_data, although those
> functions seem to be used by FSes like ext4 and fat, not memory-backed
> FSes.
> 
> We can probably fix this if any backing filesystems of restrictedmem,
> like tmpfs and future ones use private_data.

Ya, if we go the route of poking into f_ops and stuff, I would want to add
WARN_ON_ONCE() hardening of everything that restrictemem wants to "commandeer" ;-)

> > static int restrictedmem_file_create(struct file *file)
> > {
> > 	struct address_space *mapping = file->f_mapping;
> > 	struct restrictedmem *rm;
> 
> > 	rm = kzalloc(sizeof(*rm), GFP_KERNEL);
> > 	if (!rm)
> > 		return -ENOMEM;
> 
> > 	rm->backing_f_ops = file->f_op;
> > 	rm->backing_a_ops = mapping->a_ops;
> > 	rm->file = file;
> 
> We don't really need to do this, since rm->file is already the same as
> file, we could just pass the file itself when it's needed

Aha!  I was working on getting rid of it, but forgot to go back and do another
pass.

> > 	init_rwsem(&rm->lock);
> > 	xa_init(&rm->bindings);
> 
> > 	file->f_flags |= O_LARGEFILE;
> 
> > 	file->f_op = &restrictedmem_fops;
> > 	mapping->a_ops = &restrictedmem_aops;
> 
> I think we probably have to override inode_operations as well, because
> otherwise other methods would become available to a restrictedmem file
> (like link, unlink, mkdir, tmpfile). Or maybe that's a feature instead
> of a bug.

I think we want those?  What we want to restrict are operations that require
read/write/execute access to the file, everything else should be ok. fallocate()
is a special case because restrictmem needs to tell KVM to unmap the memory when
a hole is punched.  I assume ->setattr() needs similar treatment to handle
ftruncate()?

I'd love to hear Christian's input on this aspect of things.

> > 	if (WARN_ON_ONCE(file->private_data)) {
> > 		err = -EEXIST;
> > 		goto err_fd;
> > 	}
> 
> Did you intend this as a check that the backing filesystem isn't using
> the private_data field in the mapping?
>
> I think you meant file->f_mapping->private_data.

Ya, sounds right.  I should have added disclaimers that (a) I wrote this quite
quickly and (b) it's compile tested only at this point.

> On this note, we will probably have to fix things whenever any backing
> filesystems need the private_data field.

Yep.

> > 	f = fdget_raw(mount_fd);
> > 	if (!f.file)
> > 		return -EBADF;

...

> > 	/*
> > 	 * The filesystem must be mounted no-execute, executing from guest
> > 	 * private memory in the host is nonsensical and unsafe.
> > 	 */
> > 	if (!(mnt->mnt_sb->s_iflags & SB_I_NOEXEC))
> > 		goto out;

Looking at this more closely, I don't think we need to require NOEXEC, things like
like execve() should get squashed by virtue of not providing any read/write
implementations.  And dropping my misguided NOEXEC requirement means there's no
reason to disallow using the kernel internal mount.
