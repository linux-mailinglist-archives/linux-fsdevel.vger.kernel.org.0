Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC56A288D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 10:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjBYJjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Feb 2023 04:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBYJjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:39:10 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F41206F
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 01:39:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ee7so6784036edb.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEX7kiTnmPMmcWsePbfgzYz4jb8Fx2x4hoDMfgu0V80=;
        b=smswoQUuwUF4XY9LDbRmqUcx0OKWdA9ePrsQVB6KU0TUncGg/HFOeZDRQErPWVcnwC
         h33FfHaRo1bvBUNLyOaHEkiISPvZCFGdE+YPAFJKlf9gpOcF3c3xY7sQ4Y4sLC7qYcul
         xYWi9SgSdtEmaRxZXpCf10qZwUqKvIaZ6QPuRLGvl44yTkjVD0pIvtQuD0pCueE4I4QI
         qwlJ/gFdDY1bzMXein1Qp5Q6d9mwOSHYczuRNGGRAAvKfSZNppbnsOVDu8wyra4Lw5Td
         4pldOG3htUTw94jldyivuKgDTeyITzvKNRnYLEYI2YZsa18GqUafsAT9O5zpo6ZzD7Vf
         B14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEX7kiTnmPMmcWsePbfgzYz4jb8Fx2x4hoDMfgu0V80=;
        b=ftltHX3iEJ5wlHP/IAPuvjx1FQTKik00mxIqfIugeib7uLMX020jVqqH2o9SFJo49u
         fQN8kepqn7Z2kbcMLOJxWhnKaHHyrR1U2ApfG521MrzrtU1daBe6CRgOcKvclRvODxZi
         +JiAhnFYIa21tpjXjqW9ElMjQp1qYV+p9KrWVWfM5jfOQme130sCrHKyilCg7lJCufg4
         t2GCo1nFfDKT8R5C0QhjB/gd7FKE+BvBw+Gv29UDpwtwGHYvOssmJ7j0eqCdOWCJq9If
         BcXixtMZaEjPUm8Jic/p6svfA98gSkaSEzTxSlX6Eta6cv1m8tVF8pBh9BzwmOpwhjKB
         ejxg==
X-Gm-Message-State: AO0yUKXDX65QgrgjISx6qqplF537Abtha4Uiopf/cbaRpLeaQSJVKJWQ
        Qt2qjYpoOl3RQXpCqXL6TC8+83CGmW0qJLAjQVL4mA==
X-Google-Smtp-Source: AK7set++MnoeXQd72vVgpXhRE0kCu5mb/bg06wZYyCPMNKgIUS3bvXglSOQnhR3IZsU/EjQNxWWXsYJhvb6B+BVpJHI=
X-Received: by 2002:a17:907:2ce6:b0:8df:dc64:30d2 with SMTP id
 hz6-20020a1709072ce600b008dfdc6430d2mr1821694ejc.1.1677317946487; Sat, 25 Feb
 2023 01:39:06 -0800 (PST)
MIME-Version: 1.0
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com> <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
 <CANaxB-x2OrTPziL_hgwgQ1xe-ypVrvEJZK5i4ZvmUwsLqfTcvA@mail.gmail.com>
In-Reply-To: <CANaxB-x2OrTPziL_hgwgQ1xe-ypVrvEJZK5i4ZvmUwsLqfTcvA@mail.gmail.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Sat, 25 Feb 2023 10:38:54 +0100
Message-ID: <CABb0KFHYr-_o9bQAwqaXkKC9Bipo18b95FawhkUG-vOQwGNpxQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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

On Fri, 24 Feb 2023 at 03:20, Andrei Vagin <avagin@gmail.com> wrote:
>
> On Tue, Feb 21, 2023 at 4:42=E2=80=AFAM Micha=C5=82 Miros=C5=82aw <emmir@=
google.com> wrote:
> >
> > On Tue, 21 Feb 2023 at 11:28, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> > >
> > > Hi Micha=C5=82,
> > >
> > > Thank you so much for comment!
> > >
> > > On 2/17/23 8:18=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > [...]
> > > > For the page-selection mechanism, currently required_mask and
> > > > excluded_mask have conflicting
> > > They are opposite of each other:
> > > All the set bits in required_mask must be set for the page to be sele=
cted.
> > > All the set bits in excluded_mask must _not_ be set for the page to b=
e
> > > selected.
> > >
> > > > responsibilities. I suggest to rework that to:
> > > > 1. negated_flags: page flags which are to be negated before applyin=
g
> > > > the page selection using following masks;
> > > Sorry I'm unable to understand the negation (which is XOR?). Lets loo=
k at
> > > the truth table:
> > > Page Flag       negated_flags
> > > 0               0                       0
> > > 0               1                       1
> > > 1               0                       1
> > > 1               1                       0
> > >
> > > If a page flag is 0 and negated_flag is 1, the result would be 1 whic=
h has
> > > changed the page flag. It isn't making sense to me. Why the page flag=
 bit
> > > is being fliped?
> > >
> > > When Anrdei had proposed these masks, they seemed like a fancy way of
> > > filtering inside kernel and it was straight forward to understand. Th=
ese
> > > masks would help his use cases for CRIU. So I'd included it. Please c=
an you
> > > elaborate what is the purpose of negation?
> >
> > The XOR is a way to invert the tested value of a flag (from positive
> > to negative and the other way) without having the API with invalid
> > values (with required_flags and excluded_flags you need to define a
> > rule about what happens if a flag is present in both of the masks -
> > either prioritise one mask over the other or reject the call).
> > (Note: the XOR is applied only to the value of the flags for the
> > purpose of testing page-selection criteria.)
>
> Micha=C5=82,
>
> Your API isn't much different from the current one, but it requires
> a bit more brain activity for understanding.
>
> The current set of masks can be easy translated to the new one:
> negated_flags =3D excluded_flags
> required_flags_new =3D excluded_flags | required_flags
>
> As for invalid values, I think it is an advantage of the current API.
> I mean we can easily detect invalid values and return EINVAL. With your
> API, such mistakes will be undetectable.
>
> As for priorities, I don't see this problem here If I don't miss somethin=
g.
>
> We can rewrite the code this way:
> ```
> if (required_mask && ((page_flags & required_mask) !=3D required_mask)
>   skip page;
> if (anyof_mask && !(page_flags & anyof_mask))
>   skip page;
> if (page_flags & excluded_mask)
>   skip page;
> ```
>
> I think the result is always the same no matter in what order each
> mask is applied.

Hi,

I would not want the discussion to wander into easier/harder territory
as that highty depends on experience one has. What I'm arguing about
is the consistency of the API. Let me expand a bit on that.

We have two ways to look at the page_flags:
 A. the field represents a *set of elements* (tags, attributes)
present on the page;
 B. the field represents a bitfield (structure; a fixed set of boolean
fields having a value of 0 or 1)

From A follows the include/exclude way of API design for matching the
flags, and from B the matched mask (which flags to check) + value set
(what values to require).

My argument is that B is consistent with how the flags are used in the
kernel: we don't have operations that add or remove flags, but we have
operations that set or change their value.

Best Regards
Micha=C5=82 Miros=C5=82aw
