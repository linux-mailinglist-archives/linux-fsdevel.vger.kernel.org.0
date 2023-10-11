Return-Path: <linux-fsdevel+bounces-38-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC267C4AF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574561C20EC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56E171D6;
	Wed, 11 Oct 2023 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTIY1QcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92885171A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:48:50 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE33E9B;
	Tue, 10 Oct 2023 23:48:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so63672445e9.3;
        Tue, 10 Oct 2023 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697006927; x=1697611727; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqFmO2+2FrIdfi4i9ENoBkFxqNjBz5nx6bXommNjl7M=;
        b=WTIY1QcAru8MNHbnGWU0hxC8cp3yPJuL8Ofb4qg5g42ot6nvQYpumJFII/yNxNHmYS
         G/RNLIyGd/8yTTP0gJOMWOZer8IQAwFiAWzB8QXm/hZE7bYGOs5r2XZYLDvtXEKCUQ+u
         20m0xZIiXNB/LxwMIoxOVU9sJ4aalzq+2adXXVDLUXL1mM2gA3erZPAguOfrC/bAnD6d
         akLzlkK/mj/ETt/RZCYnKnhsZihELxz09WH+f2y3aKx7DyaFb6MdpLJEezmR8drCgw/R
         BvLy8TNz3NEQq299wX3gdtMiQIbeh3xaLxQpL/L4I/jb7hNSMj7t764WrH5M2Se+7N/l
         6Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006927; x=1697611727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqFmO2+2FrIdfi4i9ENoBkFxqNjBz5nx6bXommNjl7M=;
        b=IhC3cRkVYtHK6vbHrtNb5TGldQeupB2QmpFOw1QhFaXWYfLBWIGRqta000zj/JuZdJ
         IS6lNBwZd0T3acndJ95MND/7qVdihWinrWHPuob0EUbdXiKS3eMeSswU5OpOiW7Lm/hB
         wCqmQQlGs+xnBSQ0fprCYqjliClEGKgHAx4kFvuexkWN9OxO/7iSGx3OEVm/3qECL7hD
         Zmg/0fJg6TWmTLD2QToIOou9KP0Bw6I86LJHpTeixA0kCvsMtsmgRfxNfPN8szvZeARD
         NB2ekRq411GS09xHHj3q4OVbGjgsNGCOqDaFjn6DGXm1LJJPn5Dsj6BO0KNx/WxQJLvW
         0ssw==
X-Gm-Message-State: AOJu0Ywfjncrb06+g+FdiPHB2AdrPM6BqH3skrOnD19eW3m2/DCZ9iqH
	3jQjpCNQgvaGem2m3TSQSdU=
X-Google-Smtp-Source: AGHT+IEG2ekD3+biT2AFwRrgndK5hGQ4Qsm39lkF0PjkgCFwVoSTvwH+6Oky4EqVlW4W9Ij9Zdc8YQ==
X-Received: by 2002:a05:600c:2189:b0:405:7400:1e4c with SMTP id e9-20020a05600c218900b0040574001e4cmr17992312wme.35.1697006926909;
        Tue, 10 Oct 2023 23:48:46 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcd0c000000b003fefb94ccc9sm15755217wmj.11.2023.10.10.23.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:48:45 -0700 (PDT)
Date: Wed, 11 Oct 2023 07:48:44 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: abstract merge for new VMAs into
 vma_merge_new_vma()
Message-ID: <211daa6d-220a-4477-a357-bfe9e0678fc8@lucifer.local>
References: <cover.1696884493.git.lstoakes@gmail.com>
 <8525290591267805ffabf8a31b53f0290a6a4276.1696884493.git.lstoakes@gmail.com>
 <20231011015140.arngzv47bdyyzfie@revolver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011015140.arngzv47bdyyzfie@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:51:40PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [231009 16:53]:
> > Only in mmap_region() and copy_vma() do we attempt to merge VMAs which
> > occupy entirely new regions of virtual memory.
> >
> > We can abstract this logic and make the intent of this invocations of it
> > completely explicit, rather than invoking vma_merge() with an inscrutable
> > wall of parameters.
> >
> > This also paves the way for a simplification of the core vma_merge()
> > implementation, as we seek to make it entirely an implementation detail.
> >
> > Note that on mmap_region(), VMA fields are initialised to zero, so we can
> > simply reference these rather than explicitly specifying NULL.
>
> I don't think that's accurate.. mmap_region() sets the start, end,
> offset, flags.  It also passes this vma into a driver, so I'm not sure
> we can rely on them being anything after that?  The whole reason
> vma_merge() is attempted in this case is because the driver may have
> changed vma->vm_flags on us.  Your way may actually be better since the
> driver may set something we assume is NULL today.

Yeah I think I wasn't clear here - I meant to say that we memset -> 0 so
all fields that are not specified (e.g. not start, end, offset, flags).

However you make a very good point re: the driver, which I hadn't thought
of, also it's worth saying here that we specifically only do this for a
file-backed mapping just for complete clarity.

I will add a note to this part of the v3 series asking Andrew to update the
comment.

>
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  mm/mmap.c | 27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 17c0dcfb1527..33aafd23823b 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2482,6 +2482,22 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> >  	return NULL;
> >  }
> >
> > +/*
> > + * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> > + * must ensure that [start, end) does not overlap any existing VMA.
> > + */
> > +static struct vm_area_struct *vma_merge_new_vma(struct vma_iterator *vmi,
> > +						struct vm_area_struct *prev,
> > +						struct vm_area_struct *vma,
> > +						unsigned long start,
> > +						unsigned long end,
> > +						pgoff_t pgoff)
>
> It's not a coding style, but if you used two tabs here, it may make this
> more condensed.

Checkpatch shouts at me about aligning to the paren, I obviously could just
put "static struct vm_area_struct *" on the line before to make this a bit
better though. If we go to a v4 will fix, otherwise I think probably ok to
leave even if a bit squished for now?

>
> > +{
> > +	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
> > +			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> > +			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +}
> > +
> >  /*
> >   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> >   * @vmi: The vma iterator
> > @@ -2837,10 +2853,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		 * vma again as we may succeed this time.
> >  		 */
> >  		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> > -			merge = vma_merge(&vmi, mm, prev, vma->vm_start,
> > -				    vma->vm_end, vma->vm_flags, NULL,
> > -				    vma->vm_file, vma->vm_pgoff, NULL,
> > -				    NULL_VM_UFFD_CTX, NULL);
> > +			merge = vma_merge_new_vma(&vmi, prev, vma,
> > +						  vma->vm_start, vma->vm_end,
> > +						  pgoff);
>                                                    └ vma->vm_pgoff
> >  			if (merge) {
> >  				/*
> >  				 * ->mmap() can change vma->vm_file and fput
> > @@ -3382,9 +3397,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >  	if (new_vma && new_vma->vm_start < addr + len)
> >  		return NULL;	/* should never get here */
> >
> > -	new_vma = vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
> > -			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> > -			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > +	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
> >  	if (new_vma) {
> >  		/*
> >  		 * Source vma may have been merged into new_vma
> > --
> > 2.42.0
> >

