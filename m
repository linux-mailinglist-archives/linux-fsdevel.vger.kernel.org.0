Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1E7386FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFUO2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjFUO2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:28:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A671FF6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 07:27:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51bcf75c4acso5470a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687357666; x=1689949666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nx/8tkwi/QCBsZ8gmyeG8Rkuz2KMvUk7ydKIx+Um+wA=;
        b=Zx7ZT6CDGiK06H867vY+sNm4wafZK+Kvmb8BqCHCD+RgK/A8TOsKrYm88ZeQ2SECqv
         S7fVo2jMZAWlKlfibVSF4+NdJIuFTIa0/hV9eZbzpGNs8NdeOq6Gf/hK1j41+VqJkX7f
         0MdtnvEDcTvQ1qlxcyubtHy52SpsQWtzGcgMHO/beMlI2JAgE/lBuWgZO2ZNHA+12UAk
         6xkAO2o6lOr6d4DjCP484PkPelet7gw71VpFO6zM1RaeJUU4GliVx6GQS/0Q1anV9/b0
         1vlDsaqBmqIlvqPZnEthL85A7DkyTOobm6olApyMhJG0hLtOI5m8PH9wari0gbV3oEGX
         O3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687357666; x=1689949666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nx/8tkwi/QCBsZ8gmyeG8Rkuz2KMvUk7ydKIx+Um+wA=;
        b=IFkjT1sK/WVGJ3X3UwUMlYMMo0wJTVdWiCQxZBFuNwxXRxhbvSXixQbPvnAVKw8Yd7
         5FWRL/8i6Ff1t951V4IL71NWETxFa33lSjBnN1nf41NI6DGWHPR5E2DOw+tvsYSCwDtu
         4YCURnkhpt4JF93SAMVNfSwwzhJ+seqK0PA0gKEinmuQ5FWmgWUylr0ydfqHVJWaw52p
         xjhqhwa7VNt+lOPdnrNxE9IqlQWSBZsyiJi4yUxNAtnpFtsdNXXPBRCrZR3b+Fmz4eA8
         4O0w+tJZMaIeC6Aguh0C98kNY75LNHgO4CIbMPL90PJlF9hLCw7sH64vbTPLZYVhduPx
         GqGg==
X-Gm-Message-State: AC+VfDwhoU4hvlw1OULdHMNBHkromxQ68K7xdQXguEsK+2BskLKgkf+G
        NQ8Ig44F7CEAvYaTUHLJHKcPaMkhFEAaeAmZuyGfLw==
X-Google-Smtp-Source: ACHHUZ5b784EIfEpEvB4OmcZ87YYr3Ia27+LLB97tML2JkkHkDJzLWdV+C3hXWpgda3VhYBy/K3VCv+xK2nMSkOkpVY=
X-Received: by 2002:a50:d79a:0:b0:506:b280:4993 with SMTP id
 w26-20020a50d79a000000b00506b2804993mr20647edi.2.1687357665556; Wed, 21 Jun
 2023 07:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230621072404.2918101-1-usama.anjum@collabora.com>
 <20230621072404.2918101-3-usama.anjum@collabora.com> <CABb0KFGhSLAHAsa3nk-pyMe2j9MU4u3xkQR21HOoS65ZB2dKsw@mail.gmail.com>
 <de16602a-7ed9-9c03-30d9-5edccc48d2f0@collabora.com>
In-Reply-To: <de16602a-7ed9-9c03-30d9-5edccc48d2f0@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 21 Jun 2023 16:27:34 +0200
Message-ID: <CABb0KFFsHEX2cKzQj-t9vx=q4FjmObNu930ogQMBn0L6=3ph=w@mail.gmail.com>
Subject: Re: [PATCH v20 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jun 2023 at 16:16, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 6/21/23 6:42=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Wed, 21 Jun 2023 at 09:24, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> > [...]
> >> +static int pagemap_scan_test_walk(unsigned long start, unsigned long =
end,
> >> +                                 struct mm_walk *walk)
> >> +{
> >> +       struct pagemap_scan_private *p =3D walk->private;
> >> +       struct vm_area_struct *vma =3D walk->vma;
> >> +
> >> +       if ((p->flags & PM_SCAN_REQUIRE_UFFD) && (!userfaultfd_wp_asyn=
c(vma) ||
> >> +           !userfaultfd_wp_use_markers(vma)))
> >> +               return -EPERM;
> >> +
> >> +       if (vma->vm_flags & VM_PFNMAP)
> >> +               return 1;
> >> +
> >> +       return 0;
> >> +}
> >
> > This could actually short-circuit all vma flags (e.g. IS_FILE): if
> > (required_mask & IS_FILE && vma is not file-backed) return 0;
> Sorry, unable to understand you. Should we do something here?

It seems I had an earlier version of the patch in my mind, where
PAGE_IS_FILE was based on vma type. Sorry for the noise.

Best Regards
Micha=C5=82 Miros=C5=82aw

>
> >
> > Best Regards
> > Micha=C5=82 Miros=C5=82aw
>
> --
> BR,
> Muhammad Usama Anjum
