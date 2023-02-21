Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAC669E097
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 13:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjBUMmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 07:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjBUMmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:42:43 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C826CC6
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 04:42:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f13so16122984edz.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6el+9joKyAhVr+TDn79fkuxzTiKR+SX0MO09engIhY=;
        b=cLZLuL/REYI8EX3PmLJFdaF2YUd4XwINhRSVuCvmFL4aG05j7eoj6hTO6HsBms6J64
         jI1aSNDMwXJlv7vMhzZCU57mo5E8++tN0wcL8Cp41JslegPSild6F+BHDEw87m7rLbEd
         U2e/JwxkCaFBy2Wd5fsup2SUZJLAAQ9sQSgQQlRq2fkj0iZmeJnegXko/ihX0PNFLSWt
         56urgBxOBm/Nqy0l4t3vVRSZ0GnyJ43fsmC2tam2hSOi32ZWoe/HgEX0sPnqpynLUEyv
         fj0sbsXVvjHQ8Vh4esfPA0zpanqX1wvttZbt9RUFwrDvpKYVPp92lo7MQwxzTAdK/3p+
         nTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6el+9joKyAhVr+TDn79fkuxzTiKR+SX0MO09engIhY=;
        b=kww2CuXWjm6GcTZfiwottxCYTpAOR2Jliwi8ailzU+lQlh+CFlTls4WSP3x9CiLupi
         HYVKDFnLKUYUnwb5fwGCe3lTdNGS97POwik8XxPtCarqLvEhnG4FR/o6439mdO2FoS9R
         6GE9zoWFv3lP3ITfaPgJfZRN5puenW6p6Zs1Wc7SocDT6YsvvAlyevHSVmOVbqP+f24o
         orAp76rlMilnxb616zkFAEhu5MRMmsdYFLon0UI8RqAlLHr3lrRkpUju88fxa3NHsgAW
         kc9MjSJlffHX+V1hPj/bl2X+zxvz+KvzEUddGooETcEuxv/3EhEuViAPnxF78O2IvYHC
         av1w==
X-Gm-Message-State: AO0yUKWm4pWiL+rVRsgYkJ+zOrnynRk6gw/imgoTHEaoqhCX2ODBGOuJ
        xlTLUo1AP9FB1l/qhs0r5pUKCXE6rLQNqEIGj6tYRg==
X-Google-Smtp-Source: AK7set98YYMMSbNx2hRGaTKAwlPc630Vw/Ga3pJmq4lzKkS4okWIZvm2EzW2kFQ7OPb7yFK5K2hy0cNe5M/5DCpxx9U=
X-Received: by 2002:a17:906:9499:b0:8b1:79ef:6923 with SMTP id
 t25-20020a170906949900b008b179ef6923mr6794210ejx.15.1676983360819; Tue, 21
 Feb 2023 04:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com>
In-Reply-To: <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 21 Feb 2023 13:42:29 +0100
Message-ID: <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Mike Rapoport <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Danylo Mocherniuk <mdanylo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Feb 2023 at 11:28, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Micha=C5=82,
>
> Thank you so much for comment!
>
> On 2/17/23 8:18=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
[...]
> > For the page-selection mechanism, currently required_mask and
> > excluded_mask have conflicting
> They are opposite of each other:
> All the set bits in required_mask must be set for the page to be selected=
.
> All the set bits in excluded_mask must _not_ be set for the page to be
> selected.
>
> > responsibilities. I suggest to rework that to:
> > 1. negated_flags: page flags which are to be negated before applying
> > the page selection using following masks;
> Sorry I'm unable to understand the negation (which is XOR?). Lets look at
> the truth table:
> Page Flag       negated_flags
> 0               0                       0
> 0               1                       1
> 1               0                       1
> 1               1                       0
>
> If a page flag is 0 and negated_flag is 1, the result would be 1 which ha=
s
> changed the page flag. It isn't making sense to me. Why the page flag bit
> is being fliped?
>
> When Anrdei had proposed these masks, they seemed like a fancy way of
> filtering inside kernel and it was straight forward to understand. These
> masks would help his use cases for CRIU. So I'd included it. Please can y=
ou
> elaborate what is the purpose of negation?

The XOR is a way to invert the tested value of a flag (from positive
to negative and the other way) without having the API with invalid
values (with required_flags and excluded_flags you need to define a
rule about what happens if a flag is present in both of the masks -
either prioritise one mask over the other or reject the call).
(Note: the XOR is applied only to the value of the flags for the
purpose of testing page-selection criteria.)

So:
1. if a flag is not set in negated_flags, but set in required_flags,
then it means "this flag must be one" - equivalent to it being set in
required_flag (in your current version of the API).
2. if a flag is set in negated_flags and also in required_flags, then
it means "this flag must be zero" - equivalent to it being set in
excluded_flags.

The same thing goes for anyof_flags: if a flag is set in anyof_flags,
then for it to be considered matched:
1. it must have a value of 1 if it is not set in negated_flags
2. it must have a value of 0 if it is set in negated_flags

BTW, I think I assumed that both conditions (all flags in
required_flags and at least one in anyof_flags is present) need to be
true for the page to be selected - is this your intention? The example
code has a bug though, in that if anyof_flags is zero it will never
match. Let me fix the selection part:

// calc. a mask of flags that have expected ("active") values
tested_flags =3D page_flags ^ negated_flags;
// are all required flags in "active" state? [=3D=3D all zero when negated]
if (~tested_flags & required_mask)
  skip page;
// is any extra flag "active"?
if (anyof_flags && !(tested_flags & anyof_flags))
  skip page;


Best Regards
Micha=C5=82 Miros=C5=82aw
