Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6E6A14DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 03:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBXCUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 21:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXCUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:20:48 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95305E870;
        Thu, 23 Feb 2023 18:20:46 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id s1so2799113vsk.5;
        Thu, 23 Feb 2023 18:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f01DwiBCCoSA8b356xeySu4YsZ3rzS92CP2vOVZhAWg=;
        b=ql4RUo5LeGLa0GhN/7edy7N8eSQlsbke1N6qiltaZfQBUJuX/AwYqZ/Vm5kTVz39Xi
         ovseMGfGAqmFEuv1nHiRRbrhmddHrgZtohSszSQ+R8Z5KG/UR9Fjlqr9bDqiPB4V51Sq
         XcaVkvqD6lv8VpLPsDCfqIkUq6ZmB80JlW4ADCWbvnUxADl/iVBuDDmb/3hO7sUbQMeW
         z86bCviapNBo0b6mQpGtxmnJLqh0SbtiKuGganjZ5oW91qSLHPmweTnvFoitm7ucJqqF
         Vzw7iNvEi+jeCTRrNH+9CSh62O+2m7oaxGJ8zXm/TzAc8SZqEWL7owEjqkPh70bx2cX7
         9kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f01DwiBCCoSA8b356xeySu4YsZ3rzS92CP2vOVZhAWg=;
        b=zXMBgr5oRPyQ2XkZVxClhur2/bYeLQfyi3SEsEG+4HHt4m/Cgfq7G3o6bW8ASNeyrF
         oCsbQZ0p6UxAv/LircXLByjLJ+KDnhwaY3QwTcyvN0iC+T3PiVTXJs+kadMpp1uWXiQH
         fz964ml+xsqlw5nG2BQwFbOZw1LDWxc+dGmMerHfbKWp1Je+vmoFEq4DkP6ExlQIcM6C
         Ly497YozpfWIKbGlBoRI6tgz1rReIKnm5Ucr8Z4Sa48nld3PRPZi+hskbnSSYYTWSfs5
         1CxGnTS0+IRC0lm5EigVvum/eVCRGDcyTjVKMrQfZ8x9zBPF85h34Dj1Hw6Bf7B1sKwA
         NHiQ==
X-Gm-Message-State: AO0yUKVlWPh3+LjwD3WrQihzQOvFN/+f0odcgqQYy8db63oXXhbYbYul
        ktSfScD2rseC/+AF6EcdQrI09QjOeYqOie9O2aw=
X-Google-Smtp-Source: AK7set8GaFZs9grTBPV2TtGqHKOwcBoSfP0H2qOWvJ/sb72x2A3bDmtOsjArb1eEis7Bc9lNaMYPNjkC9qJrqfiPLyc=
X-Received: by 2002:ab0:551a:0:b0:68e:2ed3:92eb with SMTP id
 t26-20020ab0551a000000b0068e2ed392ebmr3300972uaa.1.1677205245675; Thu, 23 Feb
 2023 18:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com> <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
In-Reply-To: <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 23 Feb 2023 18:20:29 -0800
Message-ID: <CANaxB-x2OrTPziL_hgwgQ1xe-ypVrvEJZK5i4ZvmUwsLqfTcvA@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 21, 2023 at 4:42=E2=80=AFAM Micha=C5=82 Miros=C5=82aw <emmir@go=
ogle.com> wrote:
>
> On Tue, 21 Feb 2023 at 11:28, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> >
> > Hi Micha=C5=82,
> >
> > Thank you so much for comment!
> >
> > On 2/17/23 8:18=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> [...]
> > > For the page-selection mechanism, currently required_mask and
> > > excluded_mask have conflicting
> > They are opposite of each other:
> > All the set bits in required_mask must be set for the page to be select=
ed.
> > All the set bits in excluded_mask must _not_ be set for the page to be
> > selected.
> >
> > > responsibilities. I suggest to rework that to:
> > > 1. negated_flags: page flags which are to be negated before applying
> > > the page selection using following masks;
> > Sorry I'm unable to understand the negation (which is XOR?). Lets look =
at
> > the truth table:
> > Page Flag       negated_flags
> > 0               0                       0
> > 0               1                       1
> > 1               0                       1
> > 1               1                       0
> >
> > If a page flag is 0 and negated_flag is 1, the result would be 1 which =
has
> > changed the page flag. It isn't making sense to me. Why the page flag b=
it
> > is being fliped?
> >
> > When Anrdei had proposed these masks, they seemed like a fancy way of
> > filtering inside kernel and it was straight forward to understand. Thes=
e
> > masks would help his use cases for CRIU. So I'd included it. Please can=
 you
> > elaborate what is the purpose of negation?
>
> The XOR is a way to invert the tested value of a flag (from positive
> to negative and the other way) without having the API with invalid
> values (with required_flags and excluded_flags you need to define a
> rule about what happens if a flag is present in both of the masks -
> either prioritise one mask over the other or reject the call).
> (Note: the XOR is applied only to the value of the flags for the
> purpose of testing page-selection criteria.)

Micha=C5=82,

Your API isn't much different from the current one, but it requires
a bit more brain activity for understanding.

The current set of masks can be easy translated to the new one:
negated_flags =3D excluded_flags
required_flags_new =3D excluded_flags | required_flags

As for invalid values, I think it is an advantage of the current API.
I mean we can easily detect invalid values and return EINVAL. With your
API, such mistakes will be undetectable.

As for priorities, I don't see this problem here If I don't miss something.

We can rewrite the code this way:
```
if (required_mask && ((page_flags & required_mask) !=3D required_mask)
  skip page;
if (anyof_mask && !(page_flags & anyof_mask))
  skip page;
if (page_flags & excluded_mask)
  skip page;
```

I think the result is always the same no matter in what order each
mask is applied.

Thanks,
Andrei
