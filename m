Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B276521A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjG0LSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjG0LSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:18:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1792E4D
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:18:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so76105e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690456712; x=1691061512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH5Ey1yx/8W+gaQNuiqylV1qlICOL1HJ7A2uan0PMYc=;
        b=i9T+QFawmfH9eqYrh3XFg91TUVPFLGrGsr7hAIR7iYpnWl5/P7iYfGWOSE6FDiDvrn
         2ONOFL80+FD4M2wIcn38qAGOkyhpHs4YvoSa/xob+21UCVsGXcpMiWoEkG0vCZmrk/mm
         XlrbWFtNK9hydzzJvPHP2FPZKWkab9U2bw922rPeO4hG0XEkEpnEWyO4t+S8Qw7jrJ83
         KvCn1fk30ZUxBKX3s1chc06AvfOfvn5UA9USV8LlryblfuGEk28s7MxN1KYXXRejP/ZN
         q5aAUfGxfN0f/JfluZdJItXXtttE8Jct1vH86IHmCHzETa4PfIxLL+EvMR2zl8xuP5DJ
         kTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456712; x=1691061512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH5Ey1yx/8W+gaQNuiqylV1qlICOL1HJ7A2uan0PMYc=;
        b=ZOQ2ucYr5tmtAaXSTJUs52EFrqGyYJh5aysfGhmwKJLSTTmyQil3Xt0JHXy6ZboRid
         89szwR1qnoT0Piy3BZAJG8FuR6FgCwkHTYw9nmb+lEhGPhK6GJANUveAONUdp6NLpOvl
         yprP7k1uj+C4ZydtrHdAmwrEi9N0qWblJ8KkXPH88c3LOsq3yAMmNqTTUWkGBZZU3yfP
         wPdDrdv7OB/SaexKQ4/CGTGJtd1BnWRansK+3/DQUG+q+UK2K1iEl/noDo58oiCEDzWE
         /AhBKy5xKHKGmCD+wRdzIqIVjTAT2bMaQxW7dEpf4BI2SQHC8qnYdCBPPxReQqIXFToz
         6EdA==
X-Gm-Message-State: ABy/qLbHvLU1AMv6/d3fFJE/reXIbh0bAwayo3fpLnX161Vt/WmLwkCA
        aqn0TPqG/1cu89yz04arGRGmda/x8KlwDNUGrcUJ6g==
X-Google-Smtp-Source: APBJJlHmL9B+daS/oUn5P/jKQ75gM91um/p4wa9J286I+SzOpZEOHJOvM6BkXAJPDWTlWjVg5AyhtTvTpp5bjJzJf4s=
X-Received: by 2002:a05:600c:1c06:b0:3f1:73b8:b5fe with SMTP id
 j6-20020a05600c1c0600b003f173b8b5femr23389wms.3.1690456712044; Thu, 27 Jul
 2023 04:18:32 -0700 (PDT)
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
 <94c6b665-bbc2-5030-f9b1-d933791008b8@codeweavers.com>
In-Reply-To: <94c6b665-bbc2-5030-f9b1-d933791008b8@codeweavers.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 27 Jul 2023 13:18:19 +0200
Message-ID: <CABb0KFEr_CDZyvZ27q2b7DbXwW3h+hNLjjzBw1GzzkZW=j-Dow@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 at 01:06, Paul Gofman <pgofman@codeweavers.com> wrote:
>
> Hello Micha=C5=82,
>
>      I was looking into that from the Wine point of view and did a bit
> of testing, so will try to answer the question cited below.

Thanks for the extensive explanation!

>      Without Windows large pages I guess the only way to make this work
> correctly is to disable THP with madvise(MADV_NOHUGEPAGE) on the memory
> ranges allocated with MEM_WRITE_WATCH, as the memory changes should not
> only be reported but also tracked with 4k page granularity as Windows
> applications expect.
>
>      Currently we don't implement MEM_LARGE_PAGES flag support in Wine
> (while of course might want to do that in the future). On Windows using
> this flag requires special permissions and implies more than just using
> huge pages under the hood but also, in particular, locking pages in
> memory. I'd expect that support to be extended in Windows though in the
> future in some way. WRT write watches, the range is watched with large
> page granularity. GetWriteWatch lpdwGranularity output parameter returns
> the value of "large page minimum" (returned by GetLargePageMinimum) and
> the returned addresses correspond to those large pages. I suppose to
> implement that on top of Linux huge pages we'd need a way to control
> huge pages allocation at the first place, i. e., a way to enforce the
> specified size for the huge pages for the memory ranged being mapped.
> Without that I am afraid the only way to correctly implement that is to
> still disable THP on the range and only adjust our API output so that
> matches expected.
>
>      Not related to the question, but without any relation to Wine and
> Windows API current way of dealing with THP in the API design looks a
> bit not straightforward to me. In a sense that transparent huge pages
> will appear not so transparent when it comes to dirty pages tracking. If
> I understand correctly, the application which allocated a reasonably big
> memory area and didn't use madvise(MADV_NOHUGEPAGE) might end up with a
> whole range being a single page and getting dirtified as a whole, which
> may likely void app's optimization based on changed memory tracking. Not
> that I know an ideal way out of this, maybe it is a matter of having THP
> disabled by default on watched ranges or clearly warning about this
> caveat in documentation?

So, this means that the max_pages limit should count HugeTLB pages as
1 not HPAGE_SIZE/PAGE_SIZE pages.
Also, to get this right, we might need another PAGE_IS_HUGETLB
category, so that userspace can differentiate the ranges if needed.

Is it possible (on Windows) to have MEM_LARGE_PAGES allocation near a
normal one and run GetWriteWatch() on both in one call? If so, how
does it behave / what is expected?

Best Regards
Micha=C5=82 Miros=C5=82aw
