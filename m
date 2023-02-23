Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A816A0525
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 10:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjBWJm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 04:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjBWJmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:42:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F0515C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 01:42:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ec43so39415817edb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ecq76MOyjJbouEEYrBGWIv8bJtN500LoCU0lJZ9XGak=;
        b=eXToJJmIw51YrtYOygLqqPIeSzpSM2S5WHaK56xWG2I5QDaQToqq4NX0NdYMb7Mi4t
         OTuIpaLudTWPja/vdYRVEQ/DHBiZXUYRn4TyHtBYnKTAu3jCl+HXCEzaSdhGaLMxrqXN
         JxA1Kbg5ci1GgbgwOg4TdrG9eIG8QWEEJJToBCxOERyrzw/8A9UPr+1uU+dSQoFPNwUG
         qiPMUZ6YNEXHglgKz9Y/A3lHwr/ctbmo5BvuxwnpWPf4Bsbg+e9qO98dFXYhJeC6Dt0P
         joA2xZpxkvrrfbJvFygOKt7iF6gvn8k2BNfONQxjHmYS8nrlgzY6NjMMFuPvBezUYfGQ
         jigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ecq76MOyjJbouEEYrBGWIv8bJtN500LoCU0lJZ9XGak=;
        b=OTeiEHi1sGDyPFyi0ucSxK9nBhiJ5b6Lj3k1L0X6hWIRYb5E6M1PQiajeGKGarNPRm
         /jBJ00gQk5tTi05WltupgcmQZa07/qfMRffhRoIeWRH8WywfvjPtmqJeIJl5SVeuTiR8
         BZQFzSJkOlqa7dQWL4EhNIJo+uGad6tCE67d+Qylo5gSj+XfMhsJUXIGZ+rHhICfgNAL
         8mzO4bA/U5i6gLfmXvyYEM+f0V66V/LhEUMxTsDZMk9JsHn1jqyAW/B4y7rphUoFLqqe
         9/05G+HQtW14aMgvUg6FGxnPwB0DW/C3BgnnBv0dR3zJI6EclQmW529/4sxZ8dNmx+20
         VuHg==
X-Gm-Message-State: AO0yUKUwuPMAJXdZ0RRKA83EpADYZoRl3g1hup3ds1jBvp1bM3KqCM9R
        FIjdCeSt7B/UJWrXY1M9XVMtt9Jvi7m6A7KtNZXIsw==
X-Google-Smtp-Source: AK7set8g3+NL8qMaNsG/P3D3VCYixxEJX8SEXwcgNz0g/mt9FnFBM8cKN/Y+zJ2o4H4P8mxzDQH5vHGQgfvmedL5IRA=
X-Received: by 2002:a50:d086:0:b0:4ad:72b2:cf57 with SMTP id
 v6-20020a50d086000000b004ad72b2cf57mr4996730edd.0.1677145340537; Thu, 23 Feb
 2023 01:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com> <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
 <6d2b40c6-bed9-69a6-e198-537b50953acd@collabora.com> <CABb0KFF+AEKijaXMjDpQLKyAdueJ93kf9QLfOouKHaPPwvfw_w@mail.gmail.com>
 <a212c91e-b22a-c080-40ac-d2e909bb51c2@collabora.com> <CABb0KFEBpJTNF7V0XfuvbtaHUiN0Zpx6FqD+BRyXf2gjxiVgTA@mail.gmail.com>
 <473b32fd-24f9-88fd-602f-3ba11d725472@collabora.com> <CABb0KFFSUeu76O9K_Q7PTQVEXJaauyOc0yF-T1uubWsYAq8cOg@mail.gmail.com>
 <324564ba-2cdc-258e-1f57-d0a1d27e9da5@collabora.com>
In-Reply-To: <324564ba-2cdc-258e-1f57-d0a1d27e9da5@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 23 Feb 2023 10:42:08 +0100
Message-ID: <CABb0KFEcTpdUW9q8AVyyTu0erPdd8w4T+P8zV+T=wDk1x7fGqw@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Feb 2023 at 10:23, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 2/23/23 1:41=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 23 Feb 2023 at 07:44, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> On 2/22/23 4:48=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Wed, 22 Feb 2023 at 12:06, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> > [...]
> >>>>>>> BTW, I think I assumed that both conditions (all flags in
> >>>>>>> required_flags and at least one in anyof_flags is present) need t=
o be
> >>>>>>> true for the page to be selected - is this your intention?
> >>>>>> All the masks are optional. If all or any of the 3 masks are speci=
fied, the
> >>>>>> page flags must pass these masks to get selected.
> >>>>>
> >>>>> This explanation contradicts in part the introductory paragraph, bu=
t
> >>>>> this version seems more useful as you can pass all masks zero to ha=
ve
> >>>>> all pages selected.
> >>>> Sorry, I wrote it wrongly. (All the masks are not optional.) Let me
> >>>> rephrase. All or at least any 1 of the 3 masks (required, any, exclu=
de)
> >>>> must be specified. The return_mask must always be specified. Error i=
s
> >>>> returned if all 3 masks (required, anyof, exclude) are zero or retur=
n_mask
> >>>> is zero.
> >>>
> >>> Why do you need those restrictions? I'd guess it is valid to request =
a
> >>> list of all pages with zero return_mask - this will return a compact
> >>> list of used ranges of the virtual address space.
> >> At the time, we are supporting 4 flags (PAGE_IS_WRITTEN, PAGE_IS_FILE,
> >> PAGE_IS_PRESENT and PAGE_IS_SWAPPED). The idea is that user mention hi=
s
> >> flags of interest in the return_mask. If he wants only 1 flag, he'll
> >> specify it. Definitely if user wants only 1 flag, initially it doesn't=
 make
> >> any sense to mention in the return mask. But we want uniformity. If us=
er
> >> want, 2 or more flags in returned, return_mask becomes compulsory. So =
to
> >> keep things simple and generic for any number of flags of interest
> >> returned, the return_mask must be specified even if the flag of intere=
st is
> >> only 1.
> >
> > I'm not sure why do we want uniformity in the case of 1 flag? If a
> > user specifies a single required flag, I'd expect he doesn't need to
> > look at the flags returned as those will duplicate the information
> > from mere presence of a page. A user might also require a single flag,
> > but want all of them returned. Both requests - return 1 flag and
> > return 0 flags would give meaningful output, so why force one way or
> > the other? Allowing two will also enable users to express the intent:
> > they need either just a list of pages, or they need a list with
> > per-page flags - the need would follow from the code structure or
> > other factors.
> We can add as much flexibility as much people ask by keeping code simple.
> But it is going to be dirty to add error check which detects if return_ma=
sk
> =3D 0 and if there is only 1 flag of interest mentioned by the user. The
> following mentioned error check is essential to return deterministic
> output. Do you think this case is worth it to support and we don't want t=
o
> go with the generality for both 1 or more flag cases?
>
> if (return_mask =3D=3D 0 && hweight_long(required_mask | any_mask) !=3D 1=
)
>         return error;

Why would you want to add this error check? If a user requires
multiple flags but cares only about a list of matching pages, then it
would be natural to express this intent as return_mask =3D 0.

> >>>>>> After taking a while to understand this and compare with already p=
resent
> >>>>>> flag system, `negated flags` is comparatively difficult to underst=
and while
> >>>>>> already present flags seem easier.
> >>>>>
> >>>>> Maybe replacing negated_flags in the API with matched_values =3D
> >>>>> ~negated_flags would make this better?
> >>>>>
> >>>>> We compare having to understand XOR vs having to understand orderin=
g
> >>>>> of required_flags and excluded_flags.
> >>>> There is no ordering in current masks scheme. No mask is preferable.=
 For a
> >>>> page to get selected, all the definitions of the masks must be fulfi=
lled.
> >>>> You have come up with good example that what if required_mask =3D
> >>>> exclude_mask. In this case, no page will fulfill the criterion and h=
ence no
> >>>> page would be selected. It is user's fault that he isn't understandi=
ng the
> >>>> definitions of these masks correctly.
> >>>>
> >>>> Now thinking about it, I can add a error check which would return er=
ror if
> >>>> a bit in required and excluded masks matches. Would you like it? Let=
s put
> >>>> this check in place.
> >>>> (Previously I'd left it for user's wisdom not to do this. If he'll s=
pecify
> >>>> same masks in them, he'll get no addresses out of the syscall.)
> >>>
> >>> This error case is (one of) the problems I propose avoiding. You also
> >>> need much more text to describe the requred/excluded flags
> >>> interactions and edge cases than saying that a flag must have a value
> >>> equal to corresponding bit in ~negated_flags to be matched by
> >>> requried/anyof masks.
> >> I've found excluded_mask very intuitive as compared to negated_mask wh=
ich
> >> is so difficult to understand that I don't know how to use it correctl=
y.
> >> Lets take an example, I want pages which are PAGE_IS_WRITTEN and are n=
ot
> >> PAGE_IS_FILE. In addition, the pages must be PAGE_IS_PRESENT or
> >> PAGE_IS_SWAPPED. This can be specified as:
> >>
> >> required_mask =3D PAGE_IS_WRITTEN
> >> excluded_mask =3D PAGE_IS_FILE
> >> anyof_mask =3D PAGE_IS_PRESETNT | PAGE_IS_SWAP
> >>
> >> (a) assume page_flags =3D 0b1111
> >> skip page as 0b1111 & 0b0010 =3D true
> >>
> >> (b) assume page_flags =3D 0b1001
> >> select page as 0b1001 & 0b0010 =3D false
> >>
> >> It seemed intuitive. Right? How would you achieve same thing with nega=
ted_mask?
> >>
> >> required_mask =3D PAGE_IS_WRITTEN
> >> negated_mask =3D PAGE_IS_FILE
> >> anyof_mask =3D PAGE_IS_PRESETNT | PAGE_IS_SWAP
> >>
> >> (1) assume page_flags =3D 0b1111
> >> tested_flags =3D 0b1111 ^ 0b0010 =3D 0b1101
> >>
> >> (2) assume page_flags =3D 0b1001
> >> tested_flags =3D 0b1001 ^ 0b0010 =3D 0b1011
> >>
> >> In (1), we wanted to skip pages which have PAGE_IS_FILE set. But
> >> negated_mask has just masked it and page is still getting tested if it
> >> should be selected and it would get selected. It is wrong.
> >>
> >> In (2), the PAGE_IS_FILE bit of page_flags was 0 and got updated to 1 =
or
> >> PAGE_IS_FILE in tested_flags.
> >
> > I require flags PAGE_IS_WRITTEN=3D1, PAGE_IS_FILE=3D0, so:
> >
> > required_mask =3D PAGE_IS_WRITTEN | PAGE_IS_FILE;
> > negated_flags =3D PAGE_IS_FILE; // flags I want zero
> You want PAGE_IS_FILE to be zero and at the same time you are requiring t=
he
> PAGE_IS_FILE. It is confusing.

Ok, I believe the misunderstanding comes from the naming. I "require"
the flag to be a particular value - hence include it in
"required_flags" and specify the required value in ~negated_flags. You
"require" the flag to be set (equal 1) and so include it in
"required_flags" and you "require" the flag to be clear (equal to 0)
so include it in "excluded_flags". Both approaches are correct, but I
would not consider one "easier" than the other. The former is more
general, though - makes any_of also able to match on flags cleared and
removes the possibility of a conflicting case of a flag present in
both sets.

Maybe considered_flags or matched_flags then would make the field
better understandable?

Best Regards
Micha=C5=82 Miros=C5=82aw
