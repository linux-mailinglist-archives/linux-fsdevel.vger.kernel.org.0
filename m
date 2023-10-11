Return-Path: <linux-fsdevel+bounces-36-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA57C4AB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC87C1C20F10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 06:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C2A179BF;
	Wed, 11 Oct 2023 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3Jo4LEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D917738
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:34:53 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A8198;
	Tue, 10 Oct 2023 23:34:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d834ec222so483859f8f.0;
        Tue, 10 Oct 2023 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697006090; x=1697610890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEaM7V4d54AdkDOOySpRi+Dcj4bMPN5Z5/1QUsaZsRY=;
        b=H3Jo4LEMNSH1fGPa07lgApMEzhxDSe92tyJ1hRtTFvzMV9XqhKLdsbgAfRl47n+Myq
         MAwUF109eIz+2A8q/WDqX7cWqZoZEemGT7n6vRBmbhR9Le8uWXXRW6qwfbE89YDgohPh
         GtBf7iTtPNTAIqjueZB6+hkov9f8QFjZ09ikdsgN8NIe3VmLNwk5hDrKspYgV0uhkm/P
         I0wK9vfyztvOf+KK1H8qRWo+5G7T5+ZoQGx5X5DlEI+W9aDqhiAgO+UfcFe0h3xLnv1D
         f0dJH+Gudpk/tTDetR0fAqkahSytdzy4t/Gt31krYk9yNy+RYUVSo3gbvryYpYJKI6zl
         plWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006090; x=1697610890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEaM7V4d54AdkDOOySpRi+Dcj4bMPN5Z5/1QUsaZsRY=;
        b=JcF+558IkgsCHzu6wYYbqKiKRa0zbm3zEIuzU2Vy5ArA6rQsPKOZmNw7nSa9GwXoVz
         kDVmIb2bAf+p1bgxwiizf9/mTE+lPzLC4O34ZRNTahTKLkbLAI05cPZwPeEl8+099T73
         8+r2QIJAghfJggALZZumOIYKZ4IW+rv6bMBJEFoXnsRiJ2otoUGJXwO6XexildSkcAfP
         9yW9GcR2zqaQqQiWD+CIyZgFGSS/FNzpiQYxw9GCLmQ2ONXAd9n/Z6SDPE56Qcdpk+NZ
         jgCMDTLJ6g6JK2UnIyG/BWt8Tf/Zl58yZ+fTS/AVTPNxviUPYsJ+5vFf6AtqwBe5uPJd
         IXoQ==
X-Gm-Message-State: AOJu0YzApON+LxWdg2Z5xEBgkuNxFbG4NuUWsfRhqIRATxUMDO/vXzmZ
	uPcamjjl+M8FR7FLGBE99Qk=
X-Google-Smtp-Source: AGHT+IEad+JjLcsG7Ju6pbvc8u/EAVo74u0T4ed/MRRah8dUsAVFhxtVbRLp40+jHJwwVqQ9f361Jg==
X-Received: by 2002:a5d:5b1b:0:b0:329:6e92:8d73 with SMTP id bx27-20020a5d5b1b000000b003296e928d73mr13728679wrb.67.1697006089625;
        Tue, 10 Oct 2023 23:34:49 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id a12-20020adff7cc000000b0031423a8f4f7sm14494828wrq.56.2023.10.10.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:34:48 -0700 (PDT)
Date: Wed, 11 Oct 2023 07:34:47 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm: abstract the vma_merge()/split_vma() pattern
 for mprotect() et al.
Message-ID: <02957e4c-6752-4039-bcc5-c00b971ad0aa@lucifer.local>
References: <cover.1696884493.git.lstoakes@gmail.com>
 <ade506aa09184dc06d57785fe90a6076682556ca.1696884493.git.lstoakes@gmail.com>
 <20231011021452.57vhftchkfxebppe@revolver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011021452.57vhftchkfxebppe@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:14:52PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [231009 16:53]:
> > mprotect() and other functions which change VMA parameters over a range
> > each employ a pattern of:-
> >
> > 1. Attempt to merge the range with adjacent VMAs.
> > 2. If this fails, and the range spans a subset of the VMA, split it
> >    accordingly.
> >
> > This is open-coded and duplicated in each case. Also in each case most of
> > the parameters passed to vma_merge() remain the same.
> >
> > Create a new function, vma_modify(), which abstracts this operation,
> > accepting only those parameters which can be changed.
> >
> > To avoid the mess of invoking each function call with unnecessary
> > parameters, create inline wrapper functions for each of the modify
> > operations, parameterised only by what is required to perform the action.
> >
> > Note that the userfaultfd_release() case works even though it does not
> > split VMAs - since start is set to vma->vm_start and end is set to
> > vma->vm_end, the split logic does not trigger.
> >
> > In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
> > - vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
> > instance, this invocation will remain unchanged.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  fs/userfaultfd.c   | 69 +++++++++++++++-------------------------------
> >  include/linux/mm.h | 60 ++++++++++++++++++++++++++++++++++++++++
> >  mm/madvise.c       | 32 ++++++---------------
> >  mm/mempolicy.c     | 22 +++------------
> >  mm/mlock.c         | 27 +++++-------------
> >  mm/mmap.c          | 45 ++++++++++++++++++++++++++++++
> >  mm/mprotect.c      | 35 +++++++----------------
> >  7 files changed, 157 insertions(+), 133 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index a7c6ef764e63..ba44a67a0a34 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -927,11 +927,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
> >  			continue;
> >  		}
> >  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > -		prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
> > -				 new_flags, vma->anon_vma,
> > -				 vma->vm_file, vma->vm_pgoff,
> > -				 vma_policy(vma),
> > -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> > +		prev = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
> > +					     vma->vm_end, new_flags,
> > +					     NULL_VM_UFFD_CTX);
> > +
> >  		if (prev) {
> >  			vma = prev;
> >  		} else {
> > @@ -1331,7 +1330,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	unsigned long start, end, vma_end;
> >  	struct vma_iterator vmi;
> >  	bool wp_async = userfaultfd_wp_async_ctx(ctx);
> > -	pgoff_t pgoff;
> >
> >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> >
> > @@ -1484,28 +1482,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  		vma_end = min(end, vma->vm_end);
> >
> >  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > -		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > -				 vma->anon_vma, vma->vm_file, pgoff,
> > -				 vma_policy(vma),
> > -				 ((struct vm_userfaultfd_ctx){ ctx }),
> > -				 anon_vma_name(vma));
> > -		if (prev) {
> > -			/* vma_merge() invalidated the mas */
> > -			vma = prev;
> > -			goto next;
> > -		}
> > -		if (vma->vm_start < start) {
> > -			ret = split_vma(&vmi, vma, start, 1);
> > -			if (ret)
> > -				break;
> > -		}
> > -		if (vma->vm_end > end) {
> > -			ret = split_vma(&vmi, vma, end, 0);
> > -			if (ret)
> > -				break;
> > +		prev = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> > +					     new_flags,
> > +					     (struct vm_userfaultfd_ctx){ctx});
> > +		if (IS_ERR(prev)) {
> > +			ret = PTR_ERR(prev);
> > +			break;
> >  		}
> > -	next:
> > +
> > +		if (prev)
> > +			vma = prev; /* vma_merge() invalidated the mas */
>
> This is a stale comment.  The maple state is in the vma iterator, which
> is passed through.  I missed this on the vma iterator conversion.

Ack, this was coincidentally removed in v3 so this is already resolved.

