Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796BE770569
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjHDP7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHDP7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:59:43 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CF8170F;
        Fri,  4 Aug 2023 08:59:42 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48719fc6b18so402213e0c.1;
        Fri, 04 Aug 2023 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691164781; x=1691769581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw3xh+PMtP2yuJR1nFYspmq9wxfYxKQfnC9fvCILIlQ=;
        b=afQhVBJw3yxE80g2NnA1he1WE3lgXw4xUGeu427SsD/JdIrD6Ztqt1XuaqU1vb8r5F
         OOHFPU0caPI55jFspqHSKKfXF+x2zKeMHwhuZoPbFoSlJ4obYxgGEcbaHE6uARNqz/NL
         gd3HB1UO663b8Ve3zANadUhqL9NYm+Ejo9MajFDH1adXo/+jixja1ozwqBtcJUG4TxH1
         p+a8jxakaT2anrAUrDVXkSyIPa9oYe733iLJFKxXCsG1Z4vfomt7bolARAZNK05k4yqH
         ijh19kh4fLeWW0IVt2IJanjVay6uxEjmpOO3BE8LQ/VOKfI3nVuV98DakZuwWPcfU+UQ
         vgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164781; x=1691769581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw3xh+PMtP2yuJR1nFYspmq9wxfYxKQfnC9fvCILIlQ=;
        b=c4QroOZEGViD88WTe3+ng4NZGok4pDbtjB+3mG5MGXwhIJwGF7NcfdC3+G/GLY8d7A
         JFg4+pvjjGhJgV7mAMK7X7IJ0UIZvnSEbga6I4xS3kC7byxAoMybA4A1vuHjLkDz4sD3
         j3m+kkSq2ZEiVmFnKpcVhwxioawwoeA7KBjjNNiUm6C0oYwWqR9t5jtFD8dViS9a1JT6
         nnaaYzxqGTP8LBzxW6kssAWrTMZU56RlGIBQlhMz8BDW8R69QaivOm3+b+yE3DvsErlM
         SimuA2xThidptavxOPNo1dm63j6lQ1Gec5egenOTBW99DYH705Mvis6zdzEIBjEF1E4T
         W86A==
X-Gm-Message-State: AOJu0Ywl+GdJPJ39gMLOWkGmKGIJg/8dOdbpZrBMI4zk6/zl7rRTDBlK
        STyEryeeFl2JheK7d9dE75TFpgbF1h6NNKkRoxk=
X-Google-Smtp-Source: AGHT+IHVJyr2VPvbwXl96CS2++6bMajvUEaWTD3SfCdliP+x9YtE5vm6tsqwDHhgIrl14+DbEiE7B8he2KP0NFLq1KA=
X-Received: by 2002:a1f:bd4b:0:b0:487:1bc8:4638 with SMTP id
 n72-20020a1fbd4b000000b004871bc84638mr1442446vkf.0.1691164781532; Fri, 04 Aug
 2023 08:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com> <ZMvDCeUN8qrUmnJV@gmail.com>
 <CABb0KFF7K2SHvSwXMheVAgd3VcJf_twuRsc=P-uTJW9HGQcqfA@mail.gmail.com>
In-Reply-To: <CABb0KFF7K2SHvSwXMheVAgd3VcJf_twuRsc=P-uTJW9HGQcqfA@mail.gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 4 Aug 2023 08:59:30 -0700
Message-ID: <CANaxB-ytK5QNP4K4L3T=-F6sLc5kD6HjHc_C3U2sdTtBDgbmCg@mail.gmail.com>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 3, 2023 at 8:25=E2=80=AFAM Micha=C5=82 Miros=C5=82aw <emmir@goo=
gle.com> wrote:
>
> On Thu, 3 Aug 2023 at 17:09, Andrei Vagin <avagin@gmail.com> wrote:
> > On Thu, Jul 27, 2023 at 02:36:34PM +0500, Muhammad Usama Anjum wrote:
> [...]
> > > +     n_pages =3D (*end - addr) / PAGE_SIZE;
> > > +     if (check_add_overflow(p->found_pages, n_pages, &total_pages) |=
|
> > > +         total_pages > p->arg.max_pages) {
> >
> > why do we need to use check_add_overflow here?
> >
> > > +             size_t n_too_much =3D total_pages - p->arg.max_pages;
> >
> > it is unsafe to use total_pages if check_add_overflow returns non-zero.
>
> Since we're adding unsigned integers, this is well defined even after ove=
rflow.

The description of check_add_overflow declares that is unsafe:
https://elixir.bootlin.com/linux/latest/source/include/linux/overflow.h#L62

It actually doesn't matter, because it should be impossible to
overflow total_pages
and we can consider not to use check_add_overflow here.

>
> Best Regards
> Micha=C5=82 Miros=C5=82aw
