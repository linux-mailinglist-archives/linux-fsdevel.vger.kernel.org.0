Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE0774AAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjHHUct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjHHUcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:32:22 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156D84445C;
        Tue,  8 Aug 2023 12:56:04 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d4364cf8be3so5031061276.1;
        Tue, 08 Aug 2023 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691524563; x=1692129363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shx8xzzcKiMrKveTUHLTR3Q3hB2SO4sAG3AUT0OsTBQ=;
        b=Tx0pmOfUE84GvT8iHHKudjkY6/uU6+P0q4Vq3Fi92Ai4HjE8vjdNm/CgwD/GBUhAi4
         H+c93rt+kOWcWN9wMelSq5gRU6D9fVm2AqUDDcLd/f+dt1P2PhYh/nN8/nXgLFdgE/fm
         LcBdCB1rYzMM+bXvvExqt10//p1OpzjGy4gNa1eo3p/VkYal498m2r6AdeN98nyK3Kxw
         hQmirUesK5dKLRbM2V2tfuWcSLgFoVbDFR5021fkQR46p5dkVP7IkZQU3rz5bX8GWT7n
         dzxkxagsG9uSb+QKU8SFvyBWRbBjK+cXAAch3R03s80Er3YOi38saKC4ekEgdE5sSKo/
         g2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691524563; x=1692129363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shx8xzzcKiMrKveTUHLTR3Q3hB2SO4sAG3AUT0OsTBQ=;
        b=GCi4CjS56WiCeHlT9fJYMn8iA3eso+bl947qAkRvWvC1qyNh8GC4cHDe7R41pU4Avx
         heHeFZwqoVjAxV7rN5+2pQxRFbXMezi16dxkbzrWh7WAPBbmhvrzBn4V8GQ6BSpSXeo/
         YmL8EY0835PBOlkpS1AH6Ys9EB+CzdBRwrsj0e+3oeEBHgYOl7b3dR8evNkhqSCy8ffB
         iU1PzBlS2u4W8pBhQAyHbaVutvazW1K7Vv0K5aAzS9/DNxj/gIeYLrL2SMzDpgmtOYDC
         BJQogWPcl9P7IgPSsrLta+7IyF8c9hVvRCMlm8pQJRBaUknA71xgVjZ7/MP+OtKLdphY
         GP3g==
X-Gm-Message-State: AOJu0Yybaz52HgZJVaJKA7PsRMRmZMI9/pyshvBZ6tMwJUITfSMDr9Kn
        oqY1ItM+6QU0rWHNnbtVyrmqlCbjyVBjs2jMpZQ=
X-Google-Smtp-Source: AGHT+IFy0BOqHaKaqCVl3Uzsyn4s5OT0PuHJ8AmLJXWxJ5buKDC2Yg9lLoFo7mpr7qLMgMD11tf3/gMK0ON3S2VlRtY=
X-Received: by 2002:a25:5f0d:0:b0:c5d:f2af:5a24 with SMTP id
 t13-20020a255f0d000000b00c5df2af5a24mr595770ybb.14.1691524562978; Tue, 08 Aug
 2023 12:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230808104309.357852-1-usama.anjum@collabora.com>
 <20230808104309.357852-3-usama.anjum@collabora.com> <CANaxB-ww6AcO4QThubYw62Mdeid4e3FOQAXvA_GZ=wu4J60-AQ@mail.gmail.com>
 <624cfa26-5650-ee0d-8e0a-1d844175bcaf@collabora.com>
In-Reply-To: <624cfa26-5650-ee0d-8e0a-1d844175bcaf@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 8 Aug 2023 12:55:51 -0700
Message-ID: <CANaxB-yhCcvc9W6POFR8SNjECeD_WNGidnuxXrHKT2if=CgyrA@mail.gmail.com>
Subject: Re: [PATCH v27 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 8, 2023 at 12:35=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 8/9/23 12:21=E2=80=AFAM, Andrei Vagin wrote:
> > On Tue, Aug 8, 2023 at 3:43=E2=80=AFAM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >
> > ....
> >
> >> +static int pagemap_scan_output(unsigned long categories,
> >> +                              struct pagemap_scan_private *p,
> >> +                              unsigned long addr, unsigned long *end)
> >> +{
> >> +       unsigned long n_pages, total_pages;
> >> +       int ret =3D 0;
> >> +
> >> +       if (!p->vec_buf)
> >> +               return 0;
> >> +
> >> +       categories &=3D p->arg.return_mask;
> >> +
> >> +       n_pages =3D (*end - addr) / PAGE_SIZE;
> >> +       if (check_add_overflow(p->found_pages, n_pages, &total_pages) =
|| //TODO
> >
> > Need to fix this TODO.
> Sorry, I forgot to remove the "//TODO". As far as I've understood, the la=
st
> discussion ended in keeping the check_add_overflow(). [1] I'll just remov=
e
> the TODO.
>
> https://lore.kernel.org/all/CABb0KFEfmRz+Z_-7GygTL12E5Y254dvoUfWe4uSv9-wO=
x+Cs8w@mail.gmail.com
>
>
> >
> >> +           total_pages > p->arg.max_pages) {
> >> +               size_t n_too_much =3D total_pages - p->arg.max_pages;
> >> +               *end -=3D n_too_much * PAGE_SIZE;
> >> +               n_pages -=3D n_too_much;
> >> +               ret =3D -ENOSPC;
> >> +       }
> >> +
> >> +       if (!pagemap_scan_push_range(categories, p, addr, *end)) {
> >> +               *end =3D addr;
> >> +               n_pages =3D 0;
> >> +               ret =3D -ENOSPC;
> >> +       }
> >> +
> >> +       p->found_pages +=3D n_pages;
> >> +       if (ret)
> >> +               p->walk_end_addr =3D *end;
> >> +
> >> +       return ret;
> >> +}
> >> +
> >
> > ...
> >
> >> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
> >> +{
> >> +       struct mmu_notifier_range range;
> >> +       struct pagemap_scan_private p;
> >> +       unsigned long walk_start;
> >> +       size_t n_ranges_out =3D 0;
> >> +       int ret;
> >> +
> >> +       memset(&p, 0, sizeof(p));
> >> +       ret =3D pagemap_scan_get_args(&p.arg, uarg);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       p.masks_of_interest =3D MASKS_OF_INTEREST(p.arg);
> >> +       ret =3D pagemap_scan_init_bounce_buffer(&p);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Protection change for the range is going to happen. */
> >> +       if (p.arg.flags & PM_SCAN_WP_MATCHING) {
> >> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_=
VMA, 0,
> >> +                                       mm, p.arg.start, p.arg.end);
> >> +               mmu_notifier_invalidate_range_start(&range);
> >> +       }
> >> +
> >> +       walk_start =3D p.arg.start;
> >> +       for (; walk_start < p.arg.end; walk_start =3D p.arg.walk_end) =
{
> >> +               int n_out;
> >> +
> >> +               if (fatal_signal_pending(current)) {
> >> +                       ret =3D -EINTR;
> >> +                       break;
> >> +               }
> >> +
> >> +               ret =3D mmap_read_lock_killable(mm);
> >> +               if (ret)
> >> +                       break;
> >> +               ret =3D walk_page_range(mm, walk_start, p.arg.end,
> >> +                                     &pagemap_scan_ops, &p);
> >> +               mmap_read_unlock(mm);
> >> +
> >> +               n_out =3D pagemap_scan_flush_buffer(&p);
> >> +               if (n_out < 0)
> >> +                       ret =3D n_out;
> >> +               else
> >> +                       n_ranges_out +=3D n_out;
> >> +
> >> +               if (ret !=3D -ENOSPC || p.arg.vec_len - 1 =3D=3D 0 ||
> >> +                   p.found_pages =3D=3D p.arg.max_pages) {
> >> +                       p.walk_end_addr =3D p.arg.end;
> >
> > You should not change p.walk_end_addr If ret is ENOSPC. Pls add a test
> > case to check this.
> Yeah, I'm not setting walk_end_addr if ret is ENOSPC.
>
> I'm setting walk_end_addr only when ret =3D 0. I'd added this as a result=
 of
> a test case in my local test application. I can look at adding some tests
> in pagemap_ioctl.c kselftest as well.

I am not sure that I understand what you mean here. ENOSPC can be returned
when the vec array is full and in this case, walk_end_addr should be
the address when it stops scanning.

>
> >
> >> +                       break;
> >> +               }
> >> +       }
> >> +
> >> +       if (p.cur_buf.start !=3D p.cur_buf.end) {
> >> +               if (copy_to_user(p.vec_out, &p.cur_buf, sizeof(p.cur_b=
uf)))
> >> +                       ret =3D -EFAULT;
> >> +               else
> >> +                       ++n_ranges_out;
> >> +       }
> >> +
> >> +       /* ENOSPC signifies early stop (buffer full) from the walk. */
> >> +       if (!ret || ret =3D=3D -ENOSPC)
> >> +               ret =3D n_ranges_out;
> >> +
> >> +       p.arg.walk_end =3D p.walk_end_addr ? p.walk_end_addr : walk_st=
art;
> >> +       if (pagemap_scan_writeback_args(&p.arg, uarg))
> >> +               ret =3D -EFAULT;
> >> +
> >> +       if (p.arg.flags & PM_SCAN_WP_MATCHING)
> >> +               mmu_notifier_invalidate_range_end(&range);
> >> +
> >> +       kfree(p.vec_buf);
> >> +       return ret;
> >> +}
> >
> > Thanks,
> > Andrei
>
> --
> BR,
> Muhammad Usama Anjum
