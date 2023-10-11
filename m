Return-Path: <linux-fsdevel+bounces-106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16977C5B00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EA4282444
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB1122314;
	Wed, 11 Oct 2023 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCCBJ7fS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BD22306;
	Wed, 11 Oct 2023 18:14:14 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915AA9D;
	Wed, 11 Oct 2023 11:14:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3296b49c546so104431f8f.3;
        Wed, 11 Oct 2023 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697048052; x=1697652852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7TS+RaEJbB7+7d5gDLjd+koKDndSt/GnmuFIJ1o+Jg=;
        b=aCCBJ7fSghTUKZeXhpjd/B8GbOrj5/5EV+Vlioyyx9rFchV5rZ4Q3LKsw07ZB5c1YT
         gRE4XF0XIUDd+6ZbuaKkVj7UurnvOciPhYBy78LfM8B7qBmY3nyON9u4lhMOEfShIxna
         Mtt0yGHu6UI3C8yyaPrEW2sdCRPlN2v6f5kEO8uwm9I8FdTikPKTmO9sWFAEI00gjK0V
         n1c3j3KaoEDWkaB0QraxqCuX/dQJqJZ90M06aofX9vWZXtx2FDO545Q98Q22/UfawpRd
         1H5Ee+2yXE1k6v4v4edA9bm9UHbQtp05wOauEqczaj38aA/uvUJhIq+hCI7VF4C2I/vf
         kT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048052; x=1697652852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7TS+RaEJbB7+7d5gDLjd+koKDndSt/GnmuFIJ1o+Jg=;
        b=JZfxmxMbv0EyBucUB6eadAbj9PUBLXHRq0wuf42Cg2Ci2X/4R1YPOfVDP/G5llveVG
         ZBusDk3/JOON6IzboG52NSGVyYFVa5K5VL2C8RcgoBwdZGxsyArSTXsVFcHXIGScERfQ
         9U5Sade5A1WA/voKZPuIs339UXiu4N6V3FfqXp0zSNinqDTyT9WYL9k70EM6/IBjaVZP
         rh5UxzlzIJ582uMSC59d/Qqhj68ATvWbczQtnxe5V7vedhZGSQ24u2In7LXLSI0eUnF5
         06Im/janDdDRViGQrp2mGijyXHuN0xO9SEiJ4pyeile+ix5+9rChdj1DfENx5wszW+qA
         ZudA==
X-Gm-Message-State: AOJu0YyEL+utDFNER+qvdd/OUQTuXEexivitoHpRDVheZeea5mvwYiJn
	hA4pUMhQQz93myUF6Vd6kN4=
X-Google-Smtp-Source: AGHT+IFv4S4WUlVw96jvYX9WVjLTJEQQiPuTwG+QUFDRmpY26gHHcgPdhYQ+AOKeY4se6H/9yrLzZw==
X-Received: by 2002:a5d:6c69:0:b0:32c:eeee:d438 with SMTP id r9-20020a5d6c69000000b0032ceeeed438mr5956021wrz.54.1697048051663;
        Wed, 11 Oct 2023 11:14:11 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003feea62440bsm17359617wmi.43.2023.10.11.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:14:10 -0700 (PDT)
Date: Wed, 11 Oct 2023 19:14:10 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: enforce the mapping_map_writable() check
 after call_mmap()
Message-ID: <512d8089-759c-47b7-864d-f4a38a9eacf3@lucifer.local>
References: <cover.1696709413.git.lstoakes@gmail.com>
 <d2748bc4077b53c60bcb06fccaf976cb2afee345.1696709413.git.lstoakes@gmail.com>
 <20231011094627.3xohlpe4gm2idszm@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011094627.3xohlpe4gm2idszm@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 11:46:27AM +0200, Jan Kara wrote:
> On Sat 07-10-23 21:51:01, Lorenzo Stoakes wrote:
> > In order for an F_SEAL_WRITE sealed memfd mapping to have an opportunity to
> > clear VM_MAYWRITE in seal_check_write() we must be able to invoke either
> > the shmem_mmap() or hugetlbfs_file_mmap() f_ops->mmap() handler to do so.
> >
> > We would otherwise fail the mapping_map_writable() check before we had
> > the opportunity to clear VM_MAYWRITE.
> >
> > However, the existing logic in mmap_region() performs this check BEFORE
> > calling call_mmap() (which invokes file->f_ops->mmap()). We must enforce
> > this check AFTER the function call.
> >
> > In order to avoid any risk of breaking call_mmap() handlers which assume
> > this will have been done first, we continue to mark the file writable
> > first, simply deferring enforcement of it failing until afterwards.
> >
> > This enables mmap(..., PROT_READ, MAP_SHARED, fd, 0) mappings for memfd's
> > sealed via F_SEAL_WRITE to succeed, whereas previously they were not
> > permitted.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> ...
>
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 6f6856b3267a..9fbee92aaaee 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2767,17 +2767,25 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	vma->vm_pgoff = pgoff;
> >
> >  	if (file) {
> > -		if (is_shared_maywrite(vm_flags)) {
> > -			error = mapping_map_writable(file->f_mapping);
> > -			if (error)
> > -				goto free_vma;
> > -		}
> > +		int writable_error = 0;
> > +
> > +		if (vma_is_shared_maywrite(vma))
> > +			writable_error = mapping_map_writable(file->f_mapping);
> >
> >  		vma->vm_file = get_file(file);
> >  		error = call_mmap(file, vma);
> >  		if (error)
> >  			goto unmap_and_free_vma;
> >
> > +		/*
> > +		 * call_mmap() may have changed VMA flags, so retry this check
> > +		 * if it failed before.
> > +		 */
> > +		if (writable_error && vma_is_shared_maywrite(vma)) {
> > +			error = writable_error;
> > +			goto close_and_free_vma;
> > +		}
>
> Hum, this doesn't quite give me a peace of mind ;). One bug I can see is
> that if call_mmap() drops the VM_MAYWRITE flag, we seem to forget to drop
> i_mmap_writeable counter here?

This wouldn't be applicable in the F_SEAL_WRITE case, as the
i_mmap_writable counter would already have been decremented, and thus an
error would arise causing no further decrement, and everything would work
fine.

It'd be very odd for something to be writable here but the driver to make
it not writable. But we do need to account for this.

>
> I've checked why your v2 version broke i915 and I think the reason maybe
> has nothing to do with i915. Just in case call_mmap() failed, it ended up
> jumping to unmap_and_free_vma which calls mapping_unmap_writable() but we
> didn't call mapping_map_writable() yet so the counter became imbalanced.

yeah that must be the cause, I thought perhaps somehow
__remove_shared_vm_struct() got invoked by i915_gem_mmap() but I didn't
trace it through to see if it was possible.

Looking at it again, i don't think that is possible, as we hold a mmap/vma
write lock, and the only operations that can cause
__remove_shared_vm_struct() to run are things that would not be able to do
so with this lock held.

>
> So I'd be for returning to v2 version, just fix up the error handling
> paths...

So in conclusion, I agree, this is the better approach. Will respin in v4.

>
> 								Honza
>
>
> > +
> >  		/*
> >  		 * Expansion is handled above, merging is handled below.
> >  		 * Drivers should not alter the address of the VMA.
> > --
> > 2.42.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

