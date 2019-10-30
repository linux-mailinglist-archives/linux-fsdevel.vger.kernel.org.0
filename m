Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6BE96F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 08:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJ3HCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 03:02:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40612 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfJ3HCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:02:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id u22so1376400lji.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 00:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkPxjSTbXJRVlSsGsdM45+hTs410YbmCCQkse72XJ4Y=;
        b=EJUY1JQv+QdQjb/gEObNMcJ78C0IhEJfrdoWxqU34kB9i8Bg/sWh/y3mgavhGW/PEq
         vhD7pUJS4U+vzBOM2zuUAC9zkjBi+8tmMTFlpxoi0FPmyW1RXKur3WY5NqokJ0g4R2wy
         7TiXXVvHYhvBEsiZolrKl8XydGUo3K1rzh3Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkPxjSTbXJRVlSsGsdM45+hTs410YbmCCQkse72XJ4Y=;
        b=eLYjd87rc3qDcz9HyKzKKxyGwYeDhi7JoWorjT+zKVkDVld2RKUwWejvV90z59Cn0f
         UAimFK+6l0ikdG/99F0eD8gb6Vh6eAdQ1e9H6FyhDfahNYkObMtDjcBp0l1moVOvo1uP
         xLRXb2GXNQktM6aNSGt36scejwdlMisacF/rl8hBDu63Q0ZqjtMibs9+oKmoltNF1WTF
         oS7o2LardzkFoQooVDf7Zaz6c9i8eGvX9EfouaunkXj8UnccuZnXJlwZkO53LzBSJq/h
         pPeexkUriHoakIOmpOWUd8bu+XF0JEMEwWnTXBpow1WyIfBkq4Ank7+TTjz3EqWsXgtN
         EPlw==
X-Gm-Message-State: APjAAAWwNAh/ai2g9UpzkDyMegPWuEoM+W3ObbqU7htURVi3JD6ZWCX0
        35j3DTtZaocI0MUKezz1sQYePNzAtKFIvA==
X-Google-Smtp-Source: APXvYqzbMk0m/U4liVhbWDf4mYQgZCCvtfrJLMK/rcYJ5FrOnFMnwBvcqgAaDqlDbwNictR1hvtGHg==
X-Received: by 2002:a2e:98c7:: with SMTP id s7mr5481029ljj.9.1572418953809;
        Wed, 30 Oct 2019 00:02:33 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id n8sm599940lfk.21.2019.10.30.00.02.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 00:02:31 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id v8so666783lfa.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 00:02:31 -0700 (PDT)
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr5108158lfn.134.1572418950853;
 Wed, 30 Oct 2019 00:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com> <20191030065037.o3q6usc5vo3woif6@box>
In-Reply-To: <20191030065037.o3q6usc5vo3woif6@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Oct 2019 08:02:14 +0100
X-Gmail-Original-Message-ID: <CAHk-=wimHFUTrEiP-m8hKi78NRoaGtwG06=Pqe3TghmsUQL9Xg@mail.gmail.com>
Message-ID: <CAHk-=wimHFUTrEiP-m8hKi78NRoaGtwG06=Pqe3TghmsUQL9Xg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 7:50 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I don't know much about filesystems, but can't size of file change after
> the open() under network filesystem? Revlidation on read looks like an
> requirement anyway, no?

Requirement? No. But QoS issue, yes.

But note that NFS already does that. Look at nfs_file_read(), and
notice how it's not using generic_file_buffered_read() directly, it's
doing its own thing first with checking for direct-IO, but then doing
that nfs_revalidate_mapping() that checks whether caches should be
re-validated.

It's not just size of the file, the actual cached contents may need
invalidating too etc.

And note how the generic page cache reader doesn't need to care. If
what the generic code does isn't enough, or is the wrong thing, the
filesystem simply shouldn't use it, or, like NFS, do its own thing
first/last.

So I think the "some filesystems may have other rules" is irrelevant.
If they do have other rules, it's _their_ issue, not the issue of the
generic page cache read logic.

             Linus
