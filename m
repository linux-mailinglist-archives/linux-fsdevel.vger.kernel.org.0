Return-Path: <linux-fsdevel+bounces-962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5937D3FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72758B20E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7436A219EE;
	Mon, 23 Oct 2023 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wk56tLmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01714AA9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:57:08 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C54D7A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:57:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so2826398276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698087424; x=1698692224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yqqvVSxSrZk5/pIhCtZC81tg5RVxwkjwG9586NW/1Y=;
        b=Wk56tLmfhHoxYX77HGCVbTeFROiZFFkVFLPcQwJQqM7BSRIW5v2qGxIfsFGfv+S5Dl
         I6UG48TfQ2ovJu1bMLmhY6Vz+0bCVJZLIgOnDbqP9k6zR/m4irt4Xspx34KpmENbUwu4
         3Iqo6d9SQi5BwpCxcuwIs6Dv2KT2qvRSjXLSQrEx73ALQskoJb+MTSnGVSDQCkOucYnH
         HElD7bALWRZusECe9Xqm7C1LHY6frbnASp7V9UvKr9VjrEtQyBkbpqSsh/iQRhKj3XHI
         CsmLjh53BW9oEqb4p+5mDigjDFG3gl1LVJS36sNkRjt8nHAp+L3WcQFpW9PcisW37yth
         wHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087424; x=1698692224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yqqvVSxSrZk5/pIhCtZC81tg5RVxwkjwG9586NW/1Y=;
        b=FqqJ3Otw6mvfbwH49T5nW3SIzoqPposlU8zl0kAQjckd92jKEOU2H/jxZg6cdRjOV3
         1E5Uzr0cwg+kCWrqwvZ+7MdF/yxsd0Nlj3zaXh8n9WwUW1lXWKgkRn78o21z85VtqFgT
         gKI8WvlTm1M08RS/+iievTCe7Z36PHQWD5slMgZeASMozYWjNQ8R5NymWwdVNe9sguy3
         uPyOWGR70z/V8vb74Q5ta/3bWDmKwlWswe0xvv1LuBDvtBExSIRv0FjBfwWJbYwLK3wF
         O+lHFnuRnqYoO2FkA3ffVVzL6F2HN+5nEE6RP4poR1JLCMtDBwuJ5lXPk/o8C/Ru4Gir
         D5SQ==
X-Gm-Message-State: AOJu0YzBFWMklnbmB5oUwUHI6Mr/Yw63c9CvpIU0DgDj1bYY03npnHH0
	qzMpCQ886/qN8ATfdolU7IP24fKxizQjpdoxtAzqcA==
X-Google-Smtp-Source: AGHT+IHNQUEfjaARExOLomnsfHsumATRv6sH0Qq1Lhf5GhWbo8qoEifZvXPrlpQp8hcXTGjjpDeRLsUE+mhmHgPPud4=
X-Received: by 2002:a25:410e:0:b0:d9c:a3b8:f39d with SMTP id
 o14-20020a25410e000000b00d9ca3b8f39dmr8025930yba.65.1698087424379; Mon, 23
 Oct 2023 11:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com>
In-Reply-To: <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Oct 2023 11:56:50 -0700
Message-ID: <CAJuCfpErrAqZuiiU5uthVU87Sa=yztRRqnTszezFCMQgBEawCg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	peterx@redhat.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 5:29=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Focusing on validate_remap_areas():
>
> > +
> > +static int validate_remap_areas(struct vm_area_struct *src_vma,
> > +                             struct vm_area_struct *dst_vma)
> > +{
> > +     /* Only allow remapping if both have the same access and protecti=
on */
> > +     if ((src_vma->vm_flags & VM_ACCESS_FLAGS) !=3D (dst_vma->vm_flags=
 & VM_ACCESS_FLAGS) ||
> > +         pgprot_val(src_vma->vm_page_prot) !=3D pgprot_val(dst_vma->vm=
_page_prot))
> > +             return -EINVAL;
>
> Makes sense. I do wonder about pkey and friends and if we even have to
> so anything special.

I don't see anything special done for mremap. Do you have something in mind=
?

>
> > +
> > +     /* Only allow remapping if both are mlocked or both aren't */
> > +     if ((src_vma->vm_flags & VM_LOCKED) !=3D (dst_vma->vm_flags & VM_=
LOCKED))
> > +             return -EINVAL;
> > +
> > +     if (!(src_vma->vm_flags & VM_WRITE) || !(dst_vma->vm_flags & VM_W=
RITE))
> > +             return -EINVAL;
>
> Why does one of both need VM_WRITE? If one really needs it, then the
> destination (where we're moving stuff to).

As you noticed later, both should have VM_WRITE.

>
> > +
> > +     /*
> > +      * Be strict and only allow remap_pages if either the src or
> > +      * dst range is registered in the userfaultfd to prevent
> > +      * userland errors going unnoticed. As far as the VM
> > +      * consistency is concerned, it would be perfectly safe to
> > +      * remove this check, but there's no useful usage for
> > +      * remap_pages ouside of userfaultfd registered ranges. This
> > +      * is after all why it is an ioctl belonging to the
> > +      * userfaultfd and not a syscall.
>
> I think the last sentence is the important bit and the comment can
> likely be reduced.

Ok, I'll look into shortening it.

>
> > +      *
> > +      * Allow both vmas to be registered in the userfaultfd, just
> > +      * in case somebody finds a way to make such a case useful.
> > +      * Normally only one of the two vmas would be registered in
> > +      * the userfaultfd.
>
> Should we just check the destination? That makes most sense to me,
> because with uffd we are resolving uffd-events. And just like
> copy/zeropage we want to resolve a page fault ("userfault") of a
> non-present page on the destination.

I think that makes sense. Not sure why the original implementation
needed the check for source too. Seems unnecessary.

>
>
> > +      */
> > +     if (!dst_vma->vm_userfaultfd_ctx.ctx &&
> > +         !src_vma->vm_userfaultfd_ctx.ctx)
> > +             return -EINVAL;
>
>
>
> > +
> > +     /*
> > +      * FIXME: only allow remapping across anonymous vmas,
> > +      * tmpfs should be added.
> > +      */
> > +     if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> > +             return -EINVAL;
>
> Why a FIXME here? Just drop the comment completely or replace it with
> "We only allow to remap anonymous folios accross anonymous VMAs".

Will do. I guess Andrea had plans to cover tmpfs as well.

>
> > +
> > +     /*
> > +      * Ensure the dst_vma has a anon_vma or this page
> > +      * would get a NULL anon_vma when moved in the
> > +      * dst_vma.
> > +      */
> > +     if (unlikely(anon_vma_prepare(dst_vma)))
> > +             return -ENOMEM;
>
> Makes sense.
>
> > +
> > +     return 0;
> > +}
>
>

Thanks,
Suren.


> --
> Cheers,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

