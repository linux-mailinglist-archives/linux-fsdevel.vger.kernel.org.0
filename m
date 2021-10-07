Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD4425ABE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbhJGSao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhJGSao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:30:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A538C061570;
        Thu,  7 Oct 2021 11:28:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so26534512edt.7;
        Thu, 07 Oct 2021 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3qN3MfhA2hn5WSk7ueIGscDIBqNVWdM54go8zsGIic=;
        b=Auj2KFW+kPtGThvhI+koW38dm6Ae65UgyBYLsvi9U0XXo9T/IielNC2jqDw9Hk4S7K
         fYVtZFT911RTIffZu7LmOnPmTF1KKDtK2U75lQ65ejFcBSpAN+P2HIh0FY/12zbaRHtf
         Wi1TsUfYqzj+7qGJ/+L+Kd+gCQ3jJk/55WFjJNZqrDjwcDQvgVle/2a4FR1TUgh6zDZ7
         Go2uA6U4+bRUdLEs2EPp7ekzffIVKNFEx/jvizl77Fb3J2m5JS4RSQ2Q5cYnnv3fAL9q
         k1566krTjZnKWC7ueFrkBtcormsgRnk95T32xWXXKca8XQCDePLfHw8N7KNxm/Q7DGby
         WNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3qN3MfhA2hn5WSk7ueIGscDIBqNVWdM54go8zsGIic=;
        b=4oGo3fwtmAIX3hJV0QRY5UUI77wLxdwBq7FCuMYCes2cUWw0IYgVCkrw2Y4LvNGtur
         XIBf4W8w1JUlU+ah1CYPP3bNBitZmqqQlxABlxFg8HvHZCBil0ED4/L5xd+z7DjrNYX9
         Dcer/gcmD3rbNxR0JEwqKOBasCNXt2hkTEG4f+GVkcqsEIc5AZcDtrIBazCA7Yl044xZ
         YyV++9jNFeAagmBH/lRRAjeDUNMGUCxS4H2/VRXG8vgr4rxyIA05fnw/RmsWgPB3cdXZ
         LVyxOfNh3P00HV7OgCpJgojEFuP9f/mnpEZ2eAvJEQjlNRmgL3TWl9ZGe8zxvvIyqYvO
         /pxg==
X-Gm-Message-State: AOAM532jiTcb620vm1wrt3MM9OfANdEexMspV2oUx7jsuG3nbXF5E5dF
        tI8jpafDHXyZqlaAYm9cWebEm0DyrZmgSx7/M+M=
X-Google-Smtp-Source: ABdhPJxgA18qK6hmXeIHMAGh+5TJ2JdQ0I/UDZzyKNqTvy46A6PUHs1z0LiF4dRutRMHydJpjbA4mGjN7IDVUb7O4C8=
X-Received: by 2002:a50:8d85:: with SMTP id r5mr8303074edh.312.1633631328877;
 Thu, 07 Oct 2021 11:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name> <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name> <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
 <YV3+6K3uupLit3aH@t490s> <CAHbLzkpWSM_HvCmgaLd748BLcmZ3cnDRQ577o_U+qDi1iSK3Og@mail.gmail.com>
 <YV8c1ZoMveUUlG+v@t490s>
In-Reply-To: <YV8c1ZoMveUUlG+v@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Oct 2021 11:28:36 -0700
Message-ID: <CAHbLzkrzYfQHh=u5574++s4U6hPK2Cax00W2w3nYDGmmL4=M+g@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 7, 2021 at 9:14 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Oct 06, 2021 at 04:41:35PM -0700, Yang Shi wrote:
> > > Or maybe we just don't touch it until there's need for a functional change?  I
> > > feel it a pity to lose the git blame info for reindent-only patches, but no
> > > strong opinion, because I know many people don't think the same and I'm fine
> > > with either ways.
> >
> > TBH I really don't think keeping old "git blame" info should be an
> > excuse to avoid any coding style cleanup.
>
> Sure.
>
> >
> > >
> > > Another side note: perhaps a comment above pageflags enum on PG_has_hwpoisoned
> > > would be nice?  I saw that we've got a bunch of those already.
> >
> > I was thinking about that, but it seems PG_double_map doesn't have
> > comment there either so I didn't add.
>
> IMHO that means we may just need even more documentations? :)
>
> I won't ask for documenting doublemap bit in this series, but I just don't
> think it's a good excuse to not provide documentations if we still can.
> Especially to me PageHasHwpoisoned looks really so like PageHwpoisoned, so
> it'll be still very nice to have some good document along with the patch it's
> introduced.

OK, I could add more comments for this flag in the enum. It should be
just a duplicate of the comment right before the PAGEFLAG definition.

>
> Thanks,
>
> --
> Peter Xu
>
