Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F59D76522A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjG0LWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjG0LWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:22:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F730E4D
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:22:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so11237a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690456926; x=1691061726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQEYdNvZMX6Etgo1t+7RDnKc5/X0V/U1VxFaQxCChgs=;
        b=RuZ+CMuhY2GR/2JwXCGB9HPfr3Gfcaa0YbOYJp+zdkPA13cAwXi10wUP9fct76LtRp
         088LwhB7lIRf3nsqlKP8wNe8EvCWQMn4k3d7pvOWHep9Hvm3Hff5YXTQLWaXdbcb/2Nj
         J8cGgooQQt2Pl5P8UACstz0AiBDAtdwD7C7FqTT/IrIh/Ft+MLgFTq3Cqn6bUPa0uXXu
         HgP/mhQAOCS/e1mFlm1L+qKumDvSbL2WSuruzdbdMlblir5AaPrxH8PmzVx0Q7OTmOhd
         nJQTge6J+xvWdR+XQsWazjtgl81zzoOKdRvvP+qsbTgXI7voyqqrXSNSzM7bCtN4pPro
         RRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456926; x=1691061726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQEYdNvZMX6Etgo1t+7RDnKc5/X0V/U1VxFaQxCChgs=;
        b=N+7LwRik+RCnrPX6LnET2+QOeiCiw0wNaBnscb5KUnS8WFEL7tY3k2RXqUeM2Db7G/
         pHVLwTwrNzcUE7UbG8HD86SnlUz9PcQxsK5XQSs2T0Awxa0lEjV+8ScBCvN8oezCmOU3
         2DW6M6Y4IC4sQWQpudg9VUk0JDo25qR1xhzD1ujrbLtGgyPAgK8RyMzj8JCEV9FCUSWx
         mfTwhnn2iXOQaSTWco15Rq+uyh7TyFsAe+SFdgyJxIBCmMNhZCiaiM1E2rb7dpM+AK3O
         7L6A6oQsQU4xxbYwKV7nPp5vAu0Moi32/XAhctFd5qoMWJVx7K9BBefZJb0gjgt/E8tR
         8c9g==
X-Gm-Message-State: ABy/qLZVqDt2eGez5ciT1w6KNRLHbZV/mhg/AywjIQQHHm4VS4CgOKIq
        44dFyTrdZVz3w2zvCkgfG1WPGCJJadXbbObo3Fs8Cg==
X-Google-Smtp-Source: APBJJlEKCU8y+i7yNjlzwM0W832RMv2M+/GkpbNF5mrtr7hkF1oVjo2BBhHfuYu274luOCGaIK1Syj5qH3V1YiEVi1Q=
X-Received: by 2002:a50:d4c2:0:b0:522:28a1:2095 with SMTP id
 e2-20020a50d4c2000000b0052228a12095mr79473edj.3.1690456926488; Thu, 27 Jul
 2023 04:22:06 -0700 (PDT)
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
 <94c6b665-bbc2-5030-f9b1-d933791008b8@codeweavers.com> <CABb0KFEr_CDZyvZ27q2b7DbXwW3h+hNLjjzBw1GzzkZW=j-Dow@mail.gmail.com>
In-Reply-To: <CABb0KFEr_CDZyvZ27q2b7DbXwW3h+hNLjjzBw1GzzkZW=j-Dow@mail.gmail.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 27 Jul 2023 13:21:54 +0200
Message-ID: <CABb0KFHKiS6VSYj6P9NbiP9h_0P_i+O+c9yweBMmKJRgnAPiRQ@mail.gmail.com>
Subject: Re: [v3] fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
To:     Paul Gofman <pgofman@codeweavers.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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

On Thu, 27 Jul 2023 at 13:18, Micha=C5=82 Miros=C5=82aw <emmir@google.com> =
wrote:
> On Thu, 27 Jul 2023 at 01:06, Paul Gofman <pgofman@codeweavers.com> wrote=
:
> > Hello Micha=C5=82,
> >
> >      I was looking into that from the Wine point of view and did a bit
> > of testing, so will try to answer the question cited below.
>
> Thanks for the extensive explanation!
>
> >      Without Windows large pages I guess the only way to make this work
> > correctly is to disable THP with madvise(MADV_NOHUGEPAGE) on the memory
> > ranges allocated with MEM_WRITE_WATCH, as the memory changes should not
> > only be reported but also tracked with 4k page granularity as Windows
> > applications expect.
> >
> >      Currently we don't implement MEM_LARGE_PAGES flag support in Wine
> > (while of course might want to do that in the future). On Windows using
> > this flag requires special permissions and implies more than just using
> > huge pages under the hood but also, in particular, locking pages in
> > memory. I'd expect that support to be extended in Windows though in the
> > future in some way. WRT write watches, the range is watched with large
> > page granularity. GetWriteWatch lpdwGranularity output parameter return=
s
> > the value of "large page minimum" (returned by GetLargePageMinimum) and
> > the returned addresses correspond to those large pages. I suppose to
> > implement that on top of Linux huge pages we'd need a way to control
> > huge pages allocation at the first place, i. e., a way to enforce the
> > specified size for the huge pages for the memory ranged being mapped.
> > Without that I am afraid the only way to correctly implement that is to
> > still disable THP on the range and only adjust our API output so that
> > matches expected.
[...]

The THP case we can leave it to userspace, as it can madvise() if the
optimization lost due to dirty tracking of THP is more than THP adds.
(BTW, the WP-watch is done via uffd - the default change would need to
happen there).

Best Regards
> Micha=C5=82 Miros=C5=82aw
