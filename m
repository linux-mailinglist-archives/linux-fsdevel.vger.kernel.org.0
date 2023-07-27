Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6E76523D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjG0L0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjG0L0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:26:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701530DF
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:26:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so11297a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690457182; x=1691061982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciA0d0f17XmFG0XwIFCtvuCfkBXh3LlkTiYPN1dYe+Y=;
        b=tJlzpoXYcQoY9q62eGnq5YPAAwvPwnh8kmDb+8GMOL71T2p30m+4EJ9WaU/qDbDF/5
         sXI93AZ4Al84/MWSGv6HKfhQKshHJOIBukPUWYTTpjz3TjOI3TxvfWhW6JOmLIp0wro3
         x86BFhwkDQmJP4X/gFd9VfuM3/J2u0xELsuzbtDo7FSTIas6gGEk6UKI0kxCdqomvzGJ
         aHoY4dr0LR1xJ8T5sQRRheWk6M4pmLkKmaHlZIgunfkL7kkIXY4MnwJ3pfzHma0zwrek
         udVIrB7yvGwKOB5oIYJLqM/jIfe5PQVFjYlXh3ZeQr2LXKzxlDL7o7TP+89IkfgRdSXH
         Xl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690457182; x=1691061982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciA0d0f17XmFG0XwIFCtvuCfkBXh3LlkTiYPN1dYe+Y=;
        b=hD0DdwlG4PB4f/RROGOjn4vyQZjtIQQXHvupo9/6FkIQvxjW1cBPY+LEO/FH1f0HxY
         YZAUENymu++qItPeBq7YVHyIgGcYX5R2RSDvv+F4QwEjbRGHbr0job0tQsZbTRGEfcKj
         8tRW9tAUOPkRCaKHLe/4ghMbLBPiXqHeZIUSI1YzrcO9oI4+2Baq5sWeE2//KJUqIJI4
         6BEbdDFTl0nEVMDY91HBG/ejdoaSLsT72MIpfDfC4fbyC5c3vrDEzlMLhSEePoA/EIL4
         4eAyg2bNkC/41MfyXJ2T0ThbyeaRZW/qXJgbyPDPKktZay/P/WYUH3xYKyVgwSnWhtxC
         n1PQ==
X-Gm-Message-State: ABy/qLbF+WzNM0W2YK+oEn+kKvcBXh7JVWGajIpLu8kTmTQP9bjSOoyu
        SIQvG6dy4eiVJMzOOeL+y+8LQwWCkUWiMgJWeCeRmA==
X-Google-Smtp-Source: APBJJlFswdAxEynor9flG/zwO9VwsfMLSmQuNHR6pqQhqCCyuy9JPMlHSoZGyB/3PISkp/LNC/xvk4mrDwNS/cShlew=
X-Received: by 2002:a50:d0cc:0:b0:521:f642:7183 with SMTP id
 g12-20020a50d0cc000000b00521f6427183mr78381edf.1.1690457182010; Thu, 27 Jul
 2023 04:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com> <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com> <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com> <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
 <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com> <CABb0KFHJVeEkh4f6WWK6FThCbA+NE8iYUZE68nV1YAxaHwiwog@mail.gmail.com>
 <e1ead2e8-046a-31d9-8df9-27cdd7b7ff83@collabora.com> <1afedab8-5929-61e5-b0da-9c70dc01c254@collabora.com>
 <eac29a4d-aa3f-4df5-97e6-4aa3a358f2b1@collabora.com> <CABb0KFHuNpG+NJQ4sQdp1n_Kf4sO8aC5DBEppFc1zz=zAeDfQw@mail.gmail.com>
 <f949f74f-bb65-e3f2-e70d-7198446a9981@collabora.com> <CABb0KFGQ_HbD+MNwKCcE+6D50XhJxpx0M0dRiC-EVwEXPv+4XA@mail.gmail.com>
 <89c09085-19ab-462b-e3be-b4e492a85899@collabora.com>
In-Reply-To: <89c09085-19ab-462b-e3be-b4e492a85899@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 27 Jul 2023 13:26:10 +0200
Message-ID: <CABb0KFFnWVy5k+8DhoS6jJzqeDDMkt3u=Rj6KS2HQSz1BY1+bw@mail.gmail.com>
Subject: Re: [v3] fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 at 10:03, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 7/27/23 2:10=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Wed, 26 Jul 2023 at 10:34, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 7/25/23 11:05=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Tue, 25 Jul 2023 at 11:11, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
[...]
> >>> 2. For the address tagging part I'd prefer someone who knows how this
> >>> is used take a look. We're ignoring the tag (but clear it on return i=
n
> >>> ->start) - so it doesn't matter for the ioctl() itself.
> >> I've added Kirill if he can give his thoughts about tagged memory.
> >>
> >> Right now we are removing the tags from all 3 pointers (start, end, ve=
c)
> >> before using the pointers on kernel side. But we are overwriting and
> >> writing the walk ending address in start which user can read/use.
> >>
> >> I think we shouldn't over-write the start (and its tag) and instead re=
turn
> >> the ending walk address in new variable, walk_end.
> >
> > The overwrite of `start` is making the ioctl restart (continuation)
> > easier to handle. I prefer the current way, but it's not a strong
> > opinion.
> We shouldn't overwrite the start if we aren't gonna put the correct tag. =
So
> I've resorted to adding another variable `walk_end` to return the walk
> ending address.

Yes. We have two options:

1. add new field and have the userspace check it and update start
itself to continue the scan,
 or:
2. reconstruct the tag from either orignal `start` or `end` and have
the userspace re-set `start` if it wants to restart the scan instead
of continuing.

(the second one, using `end`'s tag, might be the easiest for
userspace, as it can check `start` =3D=3D `end` when deciding to continue
or restart).

Best Regards
Micha=C5=82 Miros=C5=82aw
