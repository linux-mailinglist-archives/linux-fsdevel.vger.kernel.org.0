Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72E7706EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 19:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjHDRRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjHDRRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:17:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF93C25
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 10:17:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so873a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691169456; x=1691774256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T7SZZ0QByC9mXWRPlKUQtKM6dHFG9MmvGQY+HbLzlI=;
        b=hmS6ejEYooO73Y1iHy9ByBdsVNCWHhIXOmkn86Mpa2uIhVYifsMqtqRwFHXLw/ex06
         7oFeaY4aQ/qnfIVyspO+UKW5YG709KzIf154oIbVuXABHG+pSDHlG1gVvIR1Hfl7hJug
         //45rV4vbvwomgdKJjj/XPpv2ceSPFrIHzDSgLK3+R1Wt5fVPcBFmcjs3uis7aTQzkgt
         kGRHQs/CsbSOOMee/gSnPungVo+QlAaPXW9rJ1nV4aQrdcfEnPjEO5I5KaisoGeymxqL
         rbe5rObHIcOApfBUD1UkUBHby2p3hJw4TPnXVRiQolYKTVfcOnGO8E+giH8NQKotR+v0
         EbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691169456; x=1691774256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T7SZZ0QByC9mXWRPlKUQtKM6dHFG9MmvGQY+HbLzlI=;
        b=BiF5WlalGWz+mufr/pQYDJ4HG0t07nnkUd+lPl0AC/0XYgE+r3JvxNjNCGJGkeNXKN
         d0p57iPFsiLHGB9f03B6i0MpXmyHfMKjcOo0J43Pq3JVqU/VNOmzoX/TBUfhNDgSEtTv
         Te+XU2RfqhM9yLGvsWdYKo0bzV+7FFoYkv24clS/8WdMc/LDzurDh4V0cdqhHuGtQtkB
         tekRzIY39QMqdoe82VrMHcYfxE1Ai/76mlEHe0sEt9seqrNelLesXZcd9hL+w0Onnlgu
         +rC0SNLAn4ku52NnM/hrUe/I+aWhkEFJ/dPPZpAUK3R8SO/BqY/nooY4qI7lCO3Hnc02
         ckQw==
X-Gm-Message-State: AOJu0YySV7QgP2OheijXVnTdqPS/dQ7QoECD5olN7OZ0wtEIwY5GePm+
        MelIq0rbNwg1PFuwpv/tKY3rQ6ceLEF59pJZlbfzjQ==
X-Google-Smtp-Source: AGHT+IFIK7TPHCce2Qe4wF8yiMXNXYDY1TdJ/LxM9hHDEm980z2PUH32FJWyzAfwa5rUA9j0fY/RVeEM/1u2sys5awU=
X-Received: by 2002:a50:a6cf:0:b0:523:13df:297b with SMTP id
 f15-20020a50a6cf000000b0052313df297bmr5477edc.1.1691169456301; Fri, 04 Aug
 2023 10:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com> <ZMvDCeUN8qrUmnJV@gmail.com>
 <CABb0KFF7K2SHvSwXMheVAgd3VcJf_twuRsc=P-uTJW9HGQcqfA@mail.gmail.com> <CANaxB-ytK5QNP4K4L3T=-F6sLc5kD6HjHc_C3U2sdTtBDgbmCg@mail.gmail.com>
In-Reply-To: <CANaxB-ytK5QNP4K4L3T=-F6sLc5kD6HjHc_C3U2sdTtBDgbmCg@mail.gmail.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 4 Aug 2023 19:17:24 +0200
Message-ID: <CABb0KFEfmRz+Z_-7GygTL12E5Y254dvoUfWe4uSv9-wOx+Cs8w@mail.gmail.com>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Andrei Vagin <avagin@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Aug 2023 at 17:59, Andrei Vagin <avagin@gmail.com> wrote:
>
> On Thu, Aug 3, 2023 at 8:25=E2=80=AFAM Micha=C5=82 Miros=C5=82aw <emmir@g=
oogle.com> wrote:
> >
> > On Thu, 3 Aug 2023 at 17:09, Andrei Vagin <avagin@gmail.com> wrote:
> > > On Thu, Jul 27, 2023 at 02:36:34PM +0500, Muhammad Usama Anjum wrote:
> > [...]
> > > > +     n_pages =3D (*end - addr) / PAGE_SIZE;
> > > > +     if (check_add_overflow(p->found_pages, n_pages, &total_pages)=
 ||
> > > > +         total_pages > p->arg.max_pages) {
> > >
> > > why do we need to use check_add_overflow here?
> > >
> > > > +             size_t n_too_much =3D total_pages - p->arg.max_pages;
> > >
> > > it is unsafe to use total_pages if check_add_overflow returns non-zer=
o.
> >
> > Since we're adding unsigned integers, this is well defined even after o=
verflow.
>
> The description of check_add_overflow declares that is unsafe:
> https://elixir.bootlin.com/linux/latest/source/include/linux/overflow.h#L=
62
>
> It actually doesn't matter, because it should be impossible to
> overflow total_pages
> and we can consider not to use check_add_overflow here.

It seems the doc warning is quite new (d219d2a9a92e / Mon Aug 29
13:37:17 2022 -0700). The underlying __builtin_add_overflow() is
well-defined for any integer type, though. Even staying with C99,
arithmetic on unsigned integers is always defined as being done modulo
2^n.

Best Regards
Micha=C5=82 Miros=C5=82aw
