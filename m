Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB874DBEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGJRJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 13:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGJRJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:09:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F36C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 10:09:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98de21518fbso624629066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689008940; x=1691600940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUzXCzHDtsBOWe+bKKtFjsi637OpN1F95ddxn0q8hxY=;
        b=PZWAQvpHgPUSANsJa/B9f1rPlQFnV0lh6zBRJrDKvXAaRtN8UcvT77e7VwVxB8azXj
         vDvRukLJK+z8JLzRjyWyQwDKx65b1IgIvSgluiZN4A8POF7IxxDqw+1u22PtdDUku9yN
         z/woIJ7FIQKPCG69WzPC7n74uXh0F946sDTkFhrXCXKEUpWXwklt7jyXIFzNlare6RI5
         Sge3/7A4SQyi1NQS0dnC/BnMMnw9V1Jz8rt7j2rA0KA0gjm0FVeYuN+l3H0wWCsvJtKv
         vbGg3qDhRcmp5+4JZ3VsXON1sj4ZLdbKSGUoJkrMHC9WAymYQL1jEAu9Wmukq20Mx74A
         p0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689008940; x=1691600940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUzXCzHDtsBOWe+bKKtFjsi637OpN1F95ddxn0q8hxY=;
        b=eLvt9/cRr2KChkT2y2u9HMdkvFe0OGb8SfjUhXzON70FQqKmskBG4BP7qwXsIJII1F
         hJ9/UgjMaw7ODeFjo1UQmqwpm6qD/I2BwPkachHs/hNstL/g0U0NYQrEO2jsUi0tUqWe
         qEpZOSFoAnhvXog9E4U8yljg9yLh35EuJ2QU0sPP9el/c8wa2s13dq1Ao3hHRiubNUvx
         ulqOW2SpGuimP5Ce4F00Q6t6139Nku684DFEQOFuxWp+OTEUL2NIAsr+D4S9ikumqiIa
         EidvJO4jKcxRolcQnafnePZZBLNy5hSTiWRK1T+nA8eWAYwqEKbosodtZ0DwQMWWJ8Uy
         0JsA==
X-Gm-Message-State: ABy/qLarKTb+cwXKAx3C3gmsduxLf3GTBtN/uQ5mI46zzkx8/3xx0pvh
        Wq3mUAQOpgBxlZhmc6ih3dzOXIdVe3beVdf6e+l6cQ==
X-Google-Smtp-Source: APBJJlGFB6b2OLnR3LAAjVZGXplbgux6d184o3SoKq+5qcCfCog9p7d/Ua6PLTtc9pZOhfiKD7DuelWLIJitDb5PJ4s=
X-Received: by 2002:a17:907:7f89:b0:98d:cacb:888f with SMTP id
 qk9-20020a1709077f8900b0098dcacb888fmr18460583ejc.49.1689008940175; Mon, 10
 Jul 2023 10:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230707215540.2324998-1-axelrasmussen@google.com>
 <20230707215540.2324998-8-axelrasmussen@google.com> <ZKl6ie4s/94TPCgm@xz-m1.local>
In-Reply-To: <ZKl6ie4s/94TPCgm@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 10 Jul 2023 10:08:24 -0700
Message-ID: <CAJHvVch+1TUqtW=EvA92u21axcEr9uhcuXhyLmCoh=38TB=GSg@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 8, 2023 at 8:02=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jul 07, 2023 at 02:55:39PM -0700, Axel Rasmussen wrote:
> > Previously, we had "one fault handler to rule them all", which used
> > several branches to deal with all of the scenarios required by all of
> > the various tests.
> >
> > In upcoming patches, I plan to add a new test, which has its own
> > slightly different fault handling logic. Instead of continuing to add
> > cruft to the existing fault handler, let's allow tests to define custom
> > ones, separate from other tests.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> PS: please remember to update manpage after it lands.  I still have a pla=
n
> to update but not yet happening; if you happen to update before mine plea=
se
> feel free to update for whatever is missing.

Will do!

>
> Thanks!
>
> --
> Peter Xu
>
