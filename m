Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA52740426
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjF0Tyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0Tyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:54:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1452117
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 12:54:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bcf75c4acso2304a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895677; x=1690487677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyMtR3cHIPCcrX9Qmw6TUS4exz//e0byqhk5V1sO8fk=;
        b=2GlDcJSRb8Sf7QlZ29iJIG113UXKJ0k1Wa9naaey4i1af+jilqW5+4dt7o2PUwztP8
         qSwhqP/3oTAgRj0AcQRNlWBPWJ/huQLNNufJFTIVfvw/jV8xfn/zaSooX2E8S9liVWrD
         /Km2uLvQvF7E79fOyLLEs8VnIJayGbSyUZEXnMTNp3qB5UVTWVLOzDATNPiM2cwsGr98
         oNYmb/B4B4hF556uRQ5jbj3dR3wtEHyyqVJ3tMNLCNxGc/qRbLE4qlrv/z5nLj04TwRm
         DyH9PJxxM0BA/Iz2E2HgJuGE5E7bvTC1ptTtc5lwuC7OHDm7ZeK51zGvoD4Hvwe0iaSd
         KljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895677; x=1690487677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyMtR3cHIPCcrX9Qmw6TUS4exz//e0byqhk5V1sO8fk=;
        b=aZbWUI3JaRYjKf6nx02fVT/p9BKqIfZHL0lB2vKw20tYS1mJfuKrKyNFD397WypbSY
         S4L53dL997LeyBMQAAzSSSUnzRsMSFtK3h6M5yDEZX0OXUYrJzpq27N0EnfV4VD8bUhW
         n7Ygsv2Rh2NWESGXJK2cOQ9zNZEGkD82kfVH3LagBKvR/Id+h+0uNKreJ7NpSOhT+XCj
         M4UaFWXjbg2uJobwOjYwT/9E8lysLWV7IEZgZbwxhUpqWXMIXRbXGfRDEdPB8Avuv4v3
         lOFfw/dmp7h4Z7IyqnK+FhAxkLNgh4awi2HSGUyPMnEFT9AoSGQAFKx9uQ+5GWFDBIiw
         l18Q==
X-Gm-Message-State: AC+VfDz1RUhxNXIvN+eIVFuVID5878rTwS1mcpsKjsNSNd67P22ytlAH
        gd4NyB6VWstzBoorUCBHD3zrhzsidEf9phhKO3dazg==
X-Google-Smtp-Source: ACHHUZ7raH1oUkiTxXalrd3pGeyqiAo4JUItij8HXQEL4Vw/n53rYAlsyi7qb4LsO/833WErhLsHUeBIQPoP/qWP1aU=
X-Received: by 2002:a50:99d0:0:b0:519:7d2:e256 with SMTP id
 n16-20020a5099d0000000b0051907d2e256mr14597edb.0.1687895677218; Tue, 27 Jun
 2023 12:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230626113156.1274521-1-usama.anjum@collabora.com>
 <20230626113156.1274521-3-usama.anjum@collabora.com> <ZJo/gOnTmwEQPLF8@gmail.com>
 <13ea54c0-25a3-285c-f47e-d6da11c91795@collabora.com> <CABb0KFGn=3oAYa+wsf=iWr1Ss=en9+m11JOijEibXJLFDAkvjQ@mail.gmail.com>
 <6ac9c60e-0a6b-110a-cace-97afbd9708a0@collabora.com>
In-Reply-To: <6ac9c60e-0a6b-110a-cace-97afbd9708a0@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 27 Jun 2023 21:54:25 +0200
Message-ID: <CABb0KFH60U5RE9dLfCOEGp5=wLwwxpKaMdzQL8drYEmL3T_itw@mail.gmail.com>
Subject: Re: [PATCH v21 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Peter Xu <peterx@redhat.com>,
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

On Tue, 27 Jun 2023 at 21:20, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> Thanks Micha=C5=82 for replying.
>
> On 6/27/23 11:52=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Tue, 27 Jun 2023 at 11:00, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> Hi Andrei and Michal,
> >>
> >> Lets resolve last two points. Please reply below.
> >>
> >> On 6/27/23 6:46=E2=80=AFAM, Andrei Vagin wrote:
> > [...]
> >>> And we need to report an address where it stopped scanning.
> >>> We can do that by adding zero length vector.
> >> I don't want to do multiplexing the ending address in vec. Can we add
> >> end_addr variable in struct pm_scan_arg to always return the ending ad=
dress?
> >>
> >> struct pm_scan_arg {
> >>         ...
> >>         _u64 end_addr;
> >> };
> >
> > The idea to emit a zero-length entry for the end looks nice. This has
> > the disadvantage that we'd need to either reserve one entry for the
> > ending marker or stop the walk after the last entry is no longer
> > matching.
> This is ambiguous.

Can you explain? Both solutions would allow to return the restart
point back to the caller (the second one would need to stop the walk
as soon as the matching page range finishes -- that creates
discontinuity).

> > Another solution would be to rewrite 'start' and 'len'. The caller
> > would be forced to use non-const `pm_scan_arg`, but I expect the `vec`
> > pointer would normally be written anyway (unless using only a
> > statically-allocated buffer).
> > Also, if the 'len' is replaced with 'end' that would make the ioctl
> > easily restartable (just call again if start !=3D end).
> Nice idea. But returning ending address in len seems a bit strange.

I mean that it would update `start` =3D start value for next call' and
`len` =3D `len` - (new `start` - original `start`).

By replacing `len` I meant to remove the field and add `end` instead
to make the requested range use begin .. end (iterator range) style
instead of start + len (buffer and length). In this version you only
need to update `start` (or `begin` if you prefer).

Best Regards
Micha=C5=82 Miros=C5=82aw
