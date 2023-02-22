Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3569F39E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 12:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjBVLsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 06:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjBVLsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:48:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D3432CEA
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 03:48:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i34so3921796eda.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 03:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0SkOKRxQb31uA959ab+LjFmT74FnfTe8YzbdQveaiY=;
        b=UqDS+6tqNYyjqohkN0RYnKWLUOdzlgyc8hyv0ooxuSLy2PIILQb1K4desrZLIb09DP
         MZVlPweGs4gOkRLk8WL/QYenJ4HLb3H7CtMPHKaTcuBXkzLmXH1Qa+wDP0wsqhAcRzco
         r1K2i0iPhcZbgToPRI4vyBH6sO8JggrUXhuS5ISy03nEazNH9t/MQRFYmU7lkHV2E0rL
         KoOgG2YEoYcAptDBxjJCyy1TDAo8OXHo/Q/mPZ7YncRmGQL/quWx3FlKCvlr8IZ/2oCX
         OjsCCtkkOKtFrAR6GvA//DLeDNTUotumhmaBWsa2KXYn9wcuEvePHKi20W1yQXRLwOiv
         tGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0SkOKRxQb31uA959ab+LjFmT74FnfTe8YzbdQveaiY=;
        b=snuTpHjG9V39T1WUkj6ccLaOINe418e2xrViSXZW8QqJvcmj06uN5pmiPfzT4NrtBJ
         JJdoxrsQWOj1EulxyVVe6oCKW+r3dLXKylXQUD0UYpk7vVuO21+f8NnfMouNNg5wBAfT
         BQ7+jLJoqU4AAMhFiVZRh6v85/FF+32NHEF5cMMB/W/RKG8elD3gG/2Ei7kmi9b5hf1U
         6xEMB0CniTog/NQq8TYrHvSARiCpTaRxPY1SceDektbAuxZIJ/rTwpIM6O3H6UdgXMnR
         h5Q/zlWbaaBI+zNy2wOKPUdFWNNNlYvM3sBo+H6kHI8SHW9grtWsCm1llBLjuRGz4P1n
         zD7w==
X-Gm-Message-State: AO0yUKXv3hMXA26zPRKMH/nP0G0yvXM+n8OES6gU97pSxzFRGlhBOHh/
        DDqpwlRc9ODYXAQc5kQw9BgtfRlHOYo1Z3fgcM0s8w==
X-Google-Smtp-Source: AK7set+7jDBY525NdRoBeszWKhBVRicR26iUfAdJlIK3aE5RKh3n+8X38UCVRCGGxqOdSWAvqZonp5dnF09jL/p8IDM=
X-Received: by 2002:a17:906:eb4d:b0:87b:dce7:c245 with SMTP id
 mc13-20020a170906eb4d00b0087bdce7c245mr7249278ejb.3.1677066505580; Wed, 22
 Feb 2023 03:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com> <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
 <6d2b40c6-bed9-69a6-e198-537b50953acd@collabora.com> <CABb0KFF+AEKijaXMjDpQLKyAdueJ93kf9QLfOouKHaPPwvfw_w@mail.gmail.com>
 <a212c91e-b22a-c080-40ac-d2e909bb51c2@collabora.com>
In-Reply-To: <a212c91e-b22a-c080-40ac-d2e909bb51c2@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 22 Feb 2023 12:48:13 +0100
Message-ID: <CABb0KFEBpJTNF7V0XfuvbtaHUiN0Zpx6FqD+BRyXf2gjxiVgTA@mail.gmail.com>
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

On Wed, 22 Feb 2023 at 12:06, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 2/22/23 3:44=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Wed, 22 Feb 2023 at 11:11, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 2/21/23 5:42=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Tue, 21 Feb 2023 at 11:28, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>>
> >>>> Hi Micha=C5=82,
> >>>>
> >>>> Thank you so much for comment!
> >>>>
> >>>> On 2/17/23 8:18=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> [...]
> >>>>> For the page-selection mechanism, currently required_mask and
> >>>>> excluded_mask have conflicting
> >>>> They are opposite of each other:
> >>>> All the set bits in required_mask must be set for the page to be sel=
ected.
> >>>> All the set bits in excluded_mask must _not_ be set for the page to =
be
> >>>> selected.
> >>>>
> >>>>> responsibilities. I suggest to rework that to:
> >>>>> 1. negated_flags: page flags which are to be negated before applyin=
g
> >>>>> the page selection using following masks;
> >>>> Sorry I'm unable to understand the negation (which is XOR?). Lets lo=
ok at
> >>>> the truth table:
> >>>> Page Flag       negated_flags
> >>>> 0               0                       0
> >>>> 0               1                       1
> >>>> 1               0                       1
> >>>> 1               1                       0
> >>>>
> >>>> If a page flag is 0 and negated_flag is 1, the result would be 1 whi=
ch has
> >>>> changed the page flag. It isn't making sense to me. Why the page fla=
g bit
> >>>> is being fliped?
> >>>>
> >>>> When Anrdei had proposed these masks, they seemed like a fancy way o=
f
> >>>> filtering inside kernel and it was straight forward to understand. T=
hese
> >>>> masks would help his use cases for CRIU. So I'd included it. Please =
can you
> >>>> elaborate what is the purpose of negation?
> >>>
> >>> The XOR is a way to invert the tested value of a flag (from positive
> >>> to negative and the other way) without having the API with invalid
> >>> values (with required_flags and excluded_flags you need to define a
> >>> rule about what happens if a flag is present in both of the masks -
> >>> either prioritise one mask over the other or reject the call).
> >> At minimum, one mask (required, any or excluded) must be specified. Fo=
r a
> >> page to get selected, the page flags must fulfill the criterion of all=
 the
> >> specified masks.
> >
> > [Please see the comment below.]
> >
> > [...]
> >> Lets translate words into table:
> > [Yes, those tables captured the intent correctly.]
> >
> >>> BTW, I think I assumed that both conditions (all flags in
> >>> required_flags and at least one in anyof_flags is present) need to be
> >>> true for the page to be selected - is this your intention?
> >> All the masks are optional. If all or any of the 3 masks are specified=
, the
> >> page flags must pass these masks to get selected.
> >
> > This explanation contradicts in part the introductory paragraph, but
> > this version seems more useful as you can pass all masks zero to have
> > all pages selected.
> Sorry, I wrote it wrongly. (All the masks are not optional.) Let me
> rephrase. All or at least any 1 of the 3 masks (required, any, exclude)
> must be specified. The return_mask must always be specified. Error is
> returned if all 3 masks (required, anyof, exclude) are zero or return_mas=
k
> is zero.

Why do you need those restrictions? I'd guess it is valid to request a
list of all pages with zero return_mask - this will return a compact
list of used ranges of the virtual address space.

> >> After taking a while to understand this and compare with already prese=
nt
> >> flag system, `negated flags` is comparatively difficult to understand =
while
> >> already present flags seem easier.
> >
> > Maybe replacing negated_flags in the API with matched_values =3D
> > ~negated_flags would make this better?
> >
> > We compare having to understand XOR vs having to understand ordering
> > of required_flags and excluded_flags.
> There is no ordering in current masks scheme. No mask is preferable. For =
a
> page to get selected, all the definitions of the masks must be fulfilled.
> You have come up with good example that what if required_mask =3D
> exclude_mask. In this case, no page will fulfill the criterion and hence =
no
> page would be selected. It is user's fault that he isn't understanding th=
e
> definitions of these masks correctly.
>
> Now thinking about it, I can add a error check which would return error i=
f
> a bit in required and excluded masks matches. Would you like it? Lets put
> this check in place.
> (Previously I'd left it for user's wisdom not to do this. If he'll specif=
y
> same masks in them, he'll get no addresses out of the syscall.)

This error case is (one of) the problems I propose avoiding. You also
need much more text to describe the requred/excluded flags
interactions and edge cases than saying that a flag must have a value
equal to corresponding bit in ~negated_flags to be matched by
requried/anyof masks.

> > IOW my proposal is to replace branches in the masks interpretation (if
> > in one set then matches but if in another set then doesn't; if flags
> > match ... ) with plain calculation (flag is matching when equals
> > ~negated_flags; if flags match the masks ...).

Best Regards
Micha=C5=82 Miros=C5=82aw
