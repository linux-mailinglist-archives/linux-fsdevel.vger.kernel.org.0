Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F867B2551
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjI1Scu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 14:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjI1Scs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:32:48 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6219E
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 11:32:46 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59e88a28b98so186909117b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695925966; x=1696530766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxxk4KCIHoo6Dl11XcD1x5o63Vws+jZntrILzyholQE=;
        b=UkY4vzdXozB9ZJFGSbjgebOwQ1LygJA0jGrBxYJxpsbLawnG9ne71gNbNlc0kAYE0N
         skHunvvJ1PUXj0tWU4gZGh7OcQeaCHf65o+WsJ/FMd3QL8bEEskMTAYflPqIsQ7l1wH9
         96qL5qyltLTNKKZjyU9B+Q/Y1m13xBXzG/Z006Ms2PBCNC5OijELFGZdAXnR+EbALott
         gvZBoWbSIwJnIctUav9/U4++Jp4a4KElBSu0jZdoCOxXr1a7aiwtx+f+aaOZSANJG18g
         oiNQTYx+8q4y+OpYbF4C6y5YIvgwUa4rEU3LjqdgEKpMR8wvkStaEU9lJ0YaQb6hpA6z
         coJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695925966; x=1696530766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxxk4KCIHoo6Dl11XcD1x5o63Vws+jZntrILzyholQE=;
        b=nGYpJK3tYZ8P+i6EYgkRE5FU353PT99s3LQztfK8c8w7pSI1HsJb7pygP6yBNX4Fkg
         iwngvI/U4U9izG+eDcU3aAVNw3J4AVJEoQQaq80DyNdY8Yd/CqiSksyboJpt21zNGYkC
         9TrS0FQbq9MHtInOGLkCwYiW3gSRIjtvNe4FAxT8Wt4NZy9xP9NODL8ZIbZFqzso69Aa
         CisVMGSYNunyhppEW3GdRSzPYk37sptsr8TBwqybIPLNHIwxqsOMZjjsU25VDh0tGlXb
         jNgT3a/IUwJUXeo/e8VvX/ofwEfxyBqvr8F/m6j30NOiay07/1x6s94KCdDJnjlurehk
         4QqA==
X-Gm-Message-State: AOJu0YzPl5vumuNOMXHGWZ2Gn6uXNSLUO4LLRRFdxJ9/HzTy7p1+uVEj
        E7aCjxHRg/nJ1xP9jWIGTSvwYebEXp7fi9tcrgUQWg==
X-Google-Smtp-Source: AGHT+IFfM9d+nT1mmRvr6ki53RDJdZHiPMVC0Gaj5ZkuC3q5HagWNj/atr1+n5ELXtzcXCs1Xh1khy8oHmcY41lS/ks=
X-Received: by 2002:a0d:d84c:0:b0:56c:e480:2b2b with SMTP id
 a73-20020a0dd84c000000b0056ce4802b2bmr1604583ywe.12.1695925965774; Thu, 28
 Sep 2023 11:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
 <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com>
In-Reply-To: <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Sep 2023 11:32:34 -0700
Message-ID: <CAJuCfpFUVO_8OkEAiiqAD5J_MbNXnSEX2TKv+nz8SYCFMa6j-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:15=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 27.09.23 20:25, Suren Baghdasaryan wrote:
> >>
> >> I have some cleanups pending for page_move_anon_rmap(), that moves the
> >> SetPageAnonExclusive hunk out. Here we should be using
> >> page_move_anon_rmap() [or rather, folio_move_anon_rmap() after my clea=
nups]
> >>
> >> I'll send them out soonish.
> >
> > Should I keep this as is in my next version until you post the
> > cleanups? I can add a TODO comment to convert it to
> > folio_move_anon_rmap() once it's ready.
>
> You should just be able to use page_move_anon_rmap() and whatever gets
> in first cleans it up :)

Ack.

>
> >
> >>
> >>>> +       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
> >>>> +                                                     dst_addr)); >>=
 +
> >>>> +       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte=
);
> >>>> +       orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_page_p=
rot);
> >>>> +       orig_dst_pte =3D maybe_mkwrite(pte_mkdirty(orig_dst_pte),
> >>>> +                                    dst_vma);
> >>>
> >>> I think there's still a theoretical issue here that you could fix by
> >>> checking for the AnonExclusive flag, similar to the huge page case.
> >>>
> >>> Consider the following scenario:
> >>>
> >>> 1. process P1 does a write fault in a private anonymous VMA, creating
> >>> and mapping a new anonymous page A1
> >>> 2. process P1 forks and creates two children P2 and P3. afterwards, A=
1
> >>> is mapped in P1, P2 and P3 as a COW page, with mapcount 3.
> >>> 3. process P1 removes its mapping of A1, dropping its mapcount to 2.
> >>> 4. process P2 uses vmsplice() to grab a reference to A1 with get_user=
_pages()
> >>> 5. process P2 removes its mapping of A1, dropping its mapcount to 1.
> >>>
> >>> If at this point P3 does a write fault on its mapping of A1, it will
> >>> still trigger copy-on-write thanks to the AnonExclusive mechanism; an=
d
> >>> this is necessary to avoid P3 mapping A1 as writable and writing data
> >>> into it that will become visible to P2, if P2 and P3 are in different
> >>> security contexts.
> >>>
> >>> But if P3 instead moves its mapping of A1 to another address with
> >>> remap_anon_pte() which only does a page mapcount check, the
> >>> maybe_mkwrite() will directly make the mapping writable, circumventin=
g
> >>> the AnonExclusive mechanism.
> >>>
> >>
> >> Yes, can_change_pte_writable() contains the exact logic when we can tu=
rn
> >> something easily writable even if it wasn't writable before. which
> >> includes that PageAnonExclusive is set. (but with uffd-wp or softdirty
> >> tracking, there is more to consider)
> >
> > For uffd_remap can_change_pte_writable() would fail it VM_WRITE is not
> > set, but we want remapping to work for RO memory as well. Are you
>
> In a VMA without VM_WRITE you certainly wouldn't want to make PTEs
> writable :) That's why that function just does a sanity check that it is
> not called in strange context. So one would only call it if VM_WRITE is s=
et.
>
> > saying that a PageAnonExclusive() check alone would not be enough
> > here?
>
> There are some interesting questions to ask here:
>
> 1) What happens if the old VMA has VM_SOFTDIRTY set but the new one not?
> You most probably have to mark the PTE softdirty and not make it writable=
.
>
> 2) VM_UFFD_WP requires similar care I assume? Peter might know.

Let me look closer into these cases.
I'll also double-check if we need to support uffd_remap for R/O vmas.
I assumed we do but I actually never checked.
Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>
