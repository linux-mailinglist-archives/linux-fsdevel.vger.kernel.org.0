Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4275226EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 00:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiEJWf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiEJWf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 18:35:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4454180;
        Tue, 10 May 2022 15:35:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so3169470pjv.4;
        Tue, 10 May 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYf8+0BM+nZESEiOImBjsOdYHgGG/iLfKQrj/8qf7rA=;
        b=YZmXj+oWML4GDMo1EQd1cGPNRTin0KiSIBmHWoG6suNlLeXmjJBdewWHfJF+Uj4I1D
         qtjuJ3SAtF1QaXb8vt91KjCEmmqXNS6Mmg01VlrXCiyVSjrUKUERm9REZM/Tpa8DYo8p
         Go4BiOwi6wywh776otZ6RoL6/luSTUr2+Wnavg9Z7oidP5XdOfrT6UJOpUR4bUCYj/EZ
         O2pnPWBs5CRROSfloEEZ4IX47360DB6msOuNtM5gvEdsa+ZisKbf5Kio6nenwWKkNOJg
         1ui0oMKH2nf24n48kgEdtOoyYX6VhGLnKtbF8CP1/hQh9ZM4/SfglrZdXHDYkZJ54up2
         l3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYf8+0BM+nZESEiOImBjsOdYHgGG/iLfKQrj/8qf7rA=;
        b=EDpJIaEMzMW9grmnUG6LrU6wMbmpZWkLsYqJVFN4Gc7HbT+pY4RoIy2CTXwqjDO/dP
         jvkQ7tK6NspAmGEoAMY1IjmbifzqkLBW0XYRdh6/IcqflPOVBUNA54cMprtAbUbZXGbg
         B/MvJxanzvAuWyS/hXcialdAyhgtIgKu7FVoj30XBuZYPoVeoG5iOaNMsiWV8Aku/O4s
         fEPYzEMOf7fXdNiPw1aeYMApiQzc1C9a5ev9dR7JEX6S3dytvsU2Hzp+wFqu4SO0LGtN
         wmk1/hQhsAQYZX6ZQVO+IUfyCvWgV9N5E3aRehMkPJf9h2Z1AN5iVk0QsjV9FI24ilwo
         /HiA==
X-Gm-Message-State: AOAM532mRX0sXp/TevF51UP08T0sVjCVrLiQFDXar1P3pcqstvSXL2ld
        KSBQPM/FtrjeI+g/MfFsoxW+A08dbDenjIrplHw=
X-Google-Smtp-Source: ABdhPJyh5t+bk2Eu+iP0jde1ku+eqTCWsVCDbFvUnejEWS8YDaqj7z3ufCWJqg274m8z7C1bobG9DHlAoCZJaUofVK8=
X-Received: by 2002:a17:90b:1b52:b0:1dc:54ea:ac00 with SMTP id
 nv18-20020a17090b1b5200b001dc54eaac00mr2061327pjb.99.1652222125619; Tue, 10
 May 2022 15:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220510203222.24246-1-shy828301@gmail.com> <20220510203222.24246-7-shy828301@gmail.com>
 <20220510140545.5dd9d3145b53cb7e226c236a@linux-foundation.org>
In-Reply-To: <20220510140545.5dd9d3145b53cb7e226c236a@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 10 May 2022 15:35:13 -0700
Message-ID: <CAHbLzkrxzLs4Ye9oPLJU_xNYBC7SGs_r0q9mznXFmKuaFPmHGw@mail.gmail.com>
Subject: Re: [v4 PATCH 6/8] mm: khugepaged: make hugepage_vma_check() non-static
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, May 10, 2022 at 2:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 10 May 2022 13:32:20 -0700 Yang Shi <shy828301@gmail.com> wrote:
>
> > The hugepage_vma_check() could be reused by khugepaged_enter() and
> > khugepaged_enter_vma_merge(), but it is static in khugepaged.c.
> > Make it non-static and declare it in khugepaged.h.
> >
> > ..
> >
> > @@ -508,20 +508,13 @@ void __khugepaged_enter(struct mm_struct *mm)
> >  void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
> >                              unsigned long vm_flags)
> >  {
> > -     unsigned long hstart, hend;
> > -
> > -     /*
> > -      * khugepaged only supports read-only files for non-shmem files.
> > -      * khugepaged does not yet work on special mappings. And
> > -      * file-private shmem THP is not supported.
> > -      */
> > -     if (!hugepage_vma_check(vma, vm_flags))
> > -             return;
> > -
> > -     hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > -     hend = vma->vm_end & HPAGE_PMD_MASK;
> > -     if (hstart < hend)
> > -             khugepaged_enter(vma, vm_flags);
> > +     if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > +         khugepaged_enabled() &&
> > +         (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
> > +          (vma->vm_end & HPAGE_PMD_MASK))) {
>
> Reviewing these bounds-checking tests is so hard :(  Can we simplify?

Yeah, I think they can be moved into a helper with a more descriptive name.

>
> > +             if (hugepage_vma_check(vma, vm_flags))
> > +                     __khugepaged_enter(vma->vm_mm);
> > +     }
> >  }
>
> void khugepaged_enter_vma(struct vm_area_struct *vma,
>                           unsigned long vm_flags)
> {
>         if (test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
>                 return;
>         if (!khugepaged_enabled())
>                 return;
>         if (round_up(vma->vm_start, HPAGE_PMD_SIZE) >=
>                         (vma->vm_end & HPAGE_PMD_MASK))
>                 return;         /* vma is too small */
>         if (!hugepage_vma_check(vma, vm_flags))
>                 return;
>         __khugepaged_enter(vma->vm_mm);
> }
>
>
> Also, it might be slightly faster to have checked MMF_VM_HUGEPAGE
> before khugepaged_enabled(), but it looks odd.  And it might be slower,
> too - more pointer chasing.

I think most configurations have always or madvise mode set
(khugepaged_enabled() return true), so having checked MMF_VM_HUGEPAGE
before khugepaged_enabled() seems slightly better, but anyway it
should not have measurable effect IMHO.

>
> I wish someone would document hugepage_vma_check().

I will clean up all the stuff further in a new patchset, for example,
trying to consolidate all the different
hugepage_suitable/enabled/active checks.
