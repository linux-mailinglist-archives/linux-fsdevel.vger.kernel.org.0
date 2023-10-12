Return-Path: <linux-fsdevel+bounces-162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344247C69A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5739A1C210A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D159B21347;
	Thu, 12 Oct 2023 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7LusMR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972621119
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 09:28:37 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C3EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 02:28:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4060b623e64so4292385e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697102914; x=1697707714; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAFqt9FNu3rWiu4eCJI2tkvTWCpPiLdB1saDLZ2Qlxg=;
        b=Y7LusMR64LrIGo/4Y2Zvj2uXyFLPBe7pMbUvnKEWOvGgDjInzj4aoMkF39X8UGIH02
         3iAthhtj+f3sHxjcgqNSC2PgsiO+E0txLfjj1KzzCS3zCtYb3/StgnU35cjBR4iL4l1Z
         8SW0+otjHHa/IT4aQhROz8y6Sp0YgA5sfVSIFjei6rzNBBTb6+/joI0c4agiDNkzNObO
         4aQSIQq6AaEQ6bo8iX/AnMMCVhNVEj0kqIM1NPLpIyeLv0DySVaMaUJc6jlawgq6wjSs
         ulLY5FQjZWUCTs4Zf2tbdD4XFBzDfoCKwU4jHi4nW+NOhz7q1DhaMCxvL6kxovHbgRLl
         L0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697102914; x=1697707714;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAFqt9FNu3rWiu4eCJI2tkvTWCpPiLdB1saDLZ2Qlxg=;
        b=bZwmEyzkQqPc3XRMDGMA+BTtedEAwhz//CYVcKvnmdvQMO8ooOlHevBddJGNQS8izE
         vEldHwzM/D0v3fBPG8ZxfDWtui1RTohFvvgeI6dAfY+06mpPOUpZWX0+myoLYSTvxIcp
         s0xryw26kWKrASgYs+0uS/Sssl+y6/CKpegPd6BpuvtyXF60ZuYQLCJmLI2N3rl7RORw
         fdl36xq2wqyXLbvatvNaJK9sB4gPyiXtGKMlTSQIC2NfEiax7pKHiBABp6EiAVlQxQvW
         n6dC2NHib1SuBodOJ0megJHf8vp0gnaq1OSssM3n3EPuQWOmhcjOoBMy+g2Wz3VL9Okc
         8klw==
X-Gm-Message-State: AOJu0YwFbIL2m5HXbzXI3oK9DM366pcivojMOjTDSCZfnG1pD0p1g3gJ
	AqldkuDcsj2EP7ekd8hvNtR+3fCSIU/y3Roz/Bs=
X-Google-Smtp-Source: AGHT+IGPZ3qHmWmechpopc3ymSm+TJx4gL9+X6NKkVG+VD/D/3z56EQv0aMhYlGJ37YIUoHW3Io45Q==
X-Received: by 2002:a7b:c457:0:b0:401:c8b9:4b86 with SMTP id l23-20020a7bc457000000b00401c8b94b86mr18873677wmi.9.1697102914121;
        Thu, 12 Oct 2023 02:28:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b00405442edc69sm21126597wmr.14.2023.10.12.02.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:28:33 -0700 (PDT)
Date: Thu, 12 Oct 2023 12:28:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: lstoakes@gmail.com
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] mm: abstract the vma_merge()/split_vma() pattern for
 mprotect() et al.
Message-ID: <db90c7c9-8d24-49f3-9bac-e3d0a5bc9ad8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Lorenzo Stoakes,

The patch 9c3e157a6d1e: "mm: abstract the vma_merge()/split_vma()
pattern for mprotect() et al." from Oct 9, 2023 (linux-next), leads
to the following Smatch static checker warning:

	fs/userfaultfd.c:940 userfaultfd_release()
	error: 'vma' dereferencing possible ERR_PTR()

fs/userfaultfd.c
    896 static int userfaultfd_release(struct inode *inode, struct file *file)
    897 {
    898         struct userfaultfd_ctx *ctx = file->private_data;
    899         struct mm_struct *mm = ctx->mm;
    900         struct vm_area_struct *vma, *prev;
    901         /* len == 0 means wake all */
    902         struct userfaultfd_wake_range range = { .len = 0, };
    903         unsigned long new_flags;
    904         VMA_ITERATOR(vmi, mm, 0);
    905 
    906         WRITE_ONCE(ctx->released, true);
    907 
    908         if (!mmget_not_zero(mm))
    909                 goto wakeup;
    910 
    911         /*
    912          * Flush page faults out of all CPUs. NOTE: all page faults
    913          * must be retried without returning VM_FAULT_SIGBUS if
    914          * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
    915          * changes while handle_userfault released the mmap_lock. So
    916          * it's critical that released is set to true (above), before
    917          * taking the mmap_lock for writing.
    918          */
    919         mmap_write_lock(mm);
    920         prev = NULL;
    921         for_each_vma(vmi, vma) {
    922                 cond_resched();
    923                 BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
    924                        !!(vma->vm_flags & __VM_UFFD_FLAGS));
    925                 if (vma->vm_userfaultfd_ctx.ctx != ctx) {
    926                         prev = vma;
    927                         continue;
    928                 }
    929                 new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
    930                 prev = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
    931                                              vma->vm_end, new_flags,
    932                                              NULL_VM_UFFD_CTX);

This assignment used to be prev = vma_merge() which returns NULL but now
it's a vma_modify which can return NULL or error pointers.  Presumably
it doesn't actually return error pointers in this case, but I figured it
was worth checking.

    933 
    934                 if (prev) {
    935                         vma = prev;
    936                 } else {
    937                         prev = vma;
    938                 }
    939 
--> 940                 vma_start_write(vma);
                                        ^^^
Here is where an error pointer would crash.

    941                 userfaultfd_set_vm_flags(vma, new_flags);
    942                 vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
    943         }
    944         mmap_write_unlock(mm);
    945         mmput(mm);
    946 wakeup:
    947         /*

regards,
dan carpenter

