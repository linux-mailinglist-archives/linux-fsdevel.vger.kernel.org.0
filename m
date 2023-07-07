Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6074B785
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjGGT4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGGT4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:56:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C319A5
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 12:56:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991da766865so279842466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688759802; x=1691351802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxB32od6PqZJdUe5KvFRjX12BUZtWHFhrjYTDAzxhJY=;
        b=F3bN+Y2C3obAkkXGRADKQLZ0LgNR3Npz0zPdisMg+57COAbWl3CQyMSuDgDchVJdzZ
         WN2z1oeVhHRrKxCBeO9xm509lTqy5PjfMukjvh86Zzpgg7oqHp4oNhj2x3knnZ2WSLZb
         QA48WYc4+R1bLExL+Zd/+sp939tEtUCOW2XjUJJFwBwz1X38NOFNJisP4pOWrdkXuscM
         BO44X1ZPaItl/nKfbQzu9ytwMaEUEHdTXLfDMbZIbRs0fIQ59jpUVqEkvTlf0aKGFU/y
         ykQQu72VxK/NchIJYzfbiZwX1G/m6/ZTrDdGXSLTvLF+KVytWN3t1M10MxPCHfA2Y35r
         /CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688759802; x=1691351802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxB32od6PqZJdUe5KvFRjX12BUZtWHFhrjYTDAzxhJY=;
        b=Kvxvvjx6xrp5UPYDPh88enMzg488XpaIf91fMylZsg8tnmHOnvaccbQfox3jxWZgIK
         N6shw9AJI3D4rSMDrfd4RHqTUEv0PTBh9wmHyP38pnvx2pXqv6dRt457RjZeCi1gFQSY
         TNeD+zmAYESMkppfn65jAoIxTpZscBVfET81JE3WJ4nBSH4V68V/G0WorZPr/uWKy0UH
         ETjuRZ4FvuMnYBxmF21w+3NxXaONT9Vzoo106q1AZlSoQAztPgbGBL1GwWsLamskY249
         ss2jSJ7MO2wfITvfp4rOGghWZKXwXPNhxIUrAWQzp3yt3fxzRfyKje9MwLGyrf76L5YH
         RddQ==
X-Gm-Message-State: ABy/qLY3RQO/9OsJxZXfqK9QCSSLjM4OUYoVdoL/L5DYYbhbEKnhu7hz
        R3FjIKEZyUV7kTvBUBctgukzQ67ZAcM5CUbTrbJDZQ==
X-Google-Smtp-Source: APBJJlHAdK3upZeZZKgETPEKw5XJW8Xc+xy8QqYEJ3Ro+g0wfEDdzwJYTkqe5TzjQiBSgZWZtUSvFo1dCKCPY1EUESQ=
X-Received: by 2002:a17:906:ca17:b0:96f:d780:5734 with SMTP id
 jt23-20020a170906ca1700b0096fd7805734mr4451808ejb.65.1688759801563; Fri, 07
 Jul 2023 12:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-5-axelrasmussen@google.com> <ZKgVISe0vkRKVZuG@x1n>
In-Reply-To: <ZKgVISe0vkRKVZuG@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 7 Jul 2023 12:56:04 -0700
Message-ID: <CAJHvVci8ZEdH2Nqft3bp6_PpFgqL2rqJDyPh_pVPx8oZAWfyqA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mm: userfaultfd: add new UFFDIO_POISON ioctl
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 7, 2023 at 6:37=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jul 06, 2023 at 03:50:32PM -0700, Axel Rasmussen wrote:
> > The basic idea here is to "simulate" memory poisoning for VMs. A VM
> > running on some host might encounter a memory error, after which some
> > page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> > once poisoned, pages can never become "un-poisoned". So, when we live
> > migrate the VM, we need to preserve the poisoned status of these pages.
> >
> > When live migrating, we try to get the guest running on its new host as
> > quickly as possible. So, we start it running before all memory has been
> > copied, and before we're certain which pages should be poisoned or not.
> >
> > So the basic way to use this new feature is:
> >
> > - On the new host, the guest's memory is registered with userfaultfd, i=
n
> >   either MISSING or MINOR mode (doesn't really matter for this purpose)=
.
> > - On any first access, we get a userfaultfd event. At this point we can
> >   communicate with the old host to find out if the page was poisoned.
> > - If so, we can respond with a UFFDIO_POISON - this places a swap marke=
r
> >   so any future accesses will SIGBUS. Because the pte is now "present",
> >   future accesses won't generate more userfaultfd events, they'll just
> >   SIGBUS directly.
> >
> > UFFDIO_POISON does not handle unmapping previously-present PTEs. This
> > isn't needed, because during live migration we want to intercept
> > all accesses with userfaultfd (not just writes, so WP mode isn't useful
> > for this). So whether minor or missing mode is being used (or both), th=
e
> > PTE won't be present in any case, so handling that case isn't needed.
> >
> > Similarly, UFFDIO_POISON won't replace existing PTE markers. This might
> > be okay to do, but it seems to be safer to just refuse to overwrite any
> > existing entry (like a UFFD_WP PTE marker).
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> I agree the current behavior is not as clear, especially after hwpoison
> introduced.
>
> uffdio-copy is special right now that it can overwrite a marker, so a bug=
gy
> userapp can also overwrite a poisoned entry, but it also means the userap=
p
> is broken already, so may not really matter much.
>
> While zeropage wasn't doing that. I think that was just overlooked - i
> assume it has the same reasoning as uffdio-copy otherwise.. and no one ju=
st
> used zeropage over a wp marker yet, or just got it work-arounded by
> unprotect+zeropage.
>
> Not yet sure whether it'll make sense to unify this a bit, but making the
> new poison api to be strict look fine.  If you have any thoughts after
> reading feel free to keep the discussion going, I can ack this one I thin=
k
> (besides my rename request in 1st patch):

Agreed, it would be nice to unify things. In my v2 I had anon/shmem
and hugetlbfs behaving differently in this respect, for the same
reason - it was just overlooked / cargo culted from existing code. If
nothing else I think a single ioctl should be consistent across memory
types! Heh.

But I also think you're right and it's not exactly intentional that
copy / zeropage / etc are different in this respect. Some unification
would be nice, although I'm not 100% sure what that looks like
concretely.

My rule of thumb is, in cases where we can't imagine a real use case,
it's better to be too strict rather than too loose. And in the future,
it's less disruptive to loosen restrictions rather than tighten them
(potentially breaking something which used to work).

I'll leave untangling this to some future series, though.

>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> --
> Peter Xu
>
