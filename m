Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEFB6DAB30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 12:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbjDGKET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 06:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGKER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:04:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859A459C1
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 03:04:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9341434fe3cso190752566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680861855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPQGp8DUY8W9IGUTHTlsTXZsaE+QtLNfRWEOu4cQss8=;
        b=VWJjsNJosuq2jvCi47QZbfxKB/4eNXh3nr0Y6k4rsHO9NBcxy+RZaO3tpu1IPvC9R1
         r4AyoWtsTC6mZOIFGNcugTFYaMOchIV6Xbh3rJtnw3TSFW3jH1dxAjTv5rIj4uQ+9cVe
         6ReCOw8pNkNXZS62YMs4h0zXIeR8H0U0Fex+fln5fUvo1GfYD6EyCdCdYeQ5/674V1uY
         Fv+nzRUdJq+IibYOLQyvan2jw4MdwXDFZgjBcDZdrCALqelePxYd5BtNox7YpB5AFNG8
         pwSUXFXY11LmyfLHhQ2MzIEwizQ0xVEILd3tpmxkWYcD5he/q9xGbxzcDh2OR3Joug5U
         iBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680861855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPQGp8DUY8W9IGUTHTlsTXZsaE+QtLNfRWEOu4cQss8=;
        b=jKrB85Y28ZwMiIDyTRCnYxdKoy6X2Zk27CgCBOm7QmVJJeTuroWdTy7jFKSwHDw6Z7
         Hz7MlBcC820z8NwnuVz+fs8pu1fYfqyGSffEmHycjPa/2RdP94saYaJCv6hIdaZeN00o
         OrtA546tUfZeDxTO8D7wkrdOd8jcmPV+6uuJtQxhwiMtOayi0QeIoE03cLkgCih5YRQo
         zHsqA1R6deTf8twa/Bjwsq6aBw8Vp6ZBSESL5UDu4RqUCoiP/IVMvkDTw/2WIwbD8fYr
         oXBRbFv3hQGATgbM6DpJ6JPxGyoAytMNHagW3w/ErmGmUoMpPUp89di/L0o14WfcNDm7
         4EOQ==
X-Gm-Message-State: AAQBX9fTbyd/a5Dh+QDZ2GvTB1mx7CN4TSCH7xp79yvCLVXSGYiwmUpz
        wc0Ce9Mb7AB2tgAkZKjlUcl/881Py3gg5Y40UksthQ==
X-Google-Smtp-Source: AKy350bmDKnskEhSU/k39PBr/b5AfSt9nDX3ik+DWAn0sMFTB4UltL1+/LRu/rfJnj85LVDre3Mnnq/y6fQ4tMnM3bY=
X-Received: by 2002:a50:d55a:0:b0:504:7857:d739 with SMTP id
 f26-20020a50d55a000000b005047857d739mr1000696edj.7.1680861854780; Fri, 07 Apr
 2023 03:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com> <CABb0KFFTb3LCbyPWLSodtntw=tizYki-pc4nSHBmQOFhKoNYfA@mail.gmail.com>
 <b737dceb-a228-7ffe-0758-421505f1a61d@collabora.com> <CABb0KFF+sKSv7jdxBbXpt5A2WO83tKb9viq-kKurXN_e1VcFhQ@mail.gmail.com>
 <c535ce4a-d7da-1ce2-9883-7cefb6dd88a2@collabora.com>
In-Reply-To: <c535ce4a-d7da-1ce2-9883-7cefb6dd88a2@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 7 Apr 2023 12:04:03 +0200
Message-ID: <CABb0KFE8pn+VORr8c=HWzKzJ5L5ZBRZMg2Q1dEZGU9gLqGZNLQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
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
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Apr 2023 at 11:35, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 4/7/23 12:23=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 6 Apr 2023 at 23:12, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 4/7/23 1:12=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>> [...]
> >>>> --- a/fs/proc/task_mmu.c
> >>>> +++ b/fs/proc/task_mmu.c
> >>> [...]
> >>>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> >>>> +                                 unsigned long end, struct mm_walk =
*walk)
> >>>> +{
> > [...]
> >>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> >>>> +       if (ptl) {
> >>> [...]
> >>>> +               return ret;
> >>>> +       }
> >>>> +process_smaller_pages:
> >>>> +       if (pmd_trans_unstable(pmd))
> >>>> +               return 0;
> >>>
> >>> Why pmd_trans_unstable() is needed here and not only after split_huge=
_pmd()?
> >> I'm not entirely sure. But the idea is if THP is unstable, we should
> >> return. As it doesn't seem like after splitting THP can be unstable, w=
e
> >> should not check it. Do you agree with the following?
> >
> > The description of pmd_trans_unstable() [1] seems to indicate that it
> > is needed only after split_huge_pmd().
> >
> > [1] https://elixir.bootlin.com/linux/v6.3-rc5/source/include/linux/pgta=
ble.h#L1394
> Sorry, yeah pmd_trans_unstable() is need after split. But it is also need=
ed
> in normal case when ptl is NULL to rule out the case if pmd is unstable
> before performing operation on normal pages:
>
> ptl =3D pmd_trans_huge_lock(pmd, vma);
> if (ptl) {
> ...
> }
> if (pmd_trans_unstable(pmd))
>         return 0;
>
> This file has usage examples of pmd_trans_unstable():
>
> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L634
> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1195
> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1543
> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1887
>
> So we are good with what we have in this patch.

Shouldn't we signal ACTION_AGAIN then in order to call .pte_hole?

Best Regards
Micha=C5=82 Miros=C5=82aw
