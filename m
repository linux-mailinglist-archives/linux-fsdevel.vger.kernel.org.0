Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25050372241
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 23:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhECVMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhECVMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 17:12:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6BBC061573;
        Mon,  3 May 2021 14:11:37 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m12so4679917pgr.9;
        Mon, 03 May 2021 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sCTuw1WJrpauWziD6ZslHIdSxjRJlSBBPPLfH0jwHc=;
        b=EJNT4wWAS1o0RTNJUihlBxiQYab+1+x6eFuguITIBRA5tV7wOFxRZx6MFkBNOygv6Y
         HeBloYc101DbnTVLAbKQha6x/Mi21kpZ36iZjMSU23fC2IjwTFCxuk6D34jtpc5eQdOB
         ZwXBITXR2ZFdvUPZxjod3jPPTK0/do3Ld39kCAV5NIUanog4n88ZE7mpUFMaQuQiloM+
         QHahXcUy6c1rPKVlEgN0Dju8gMYHhLxI6gOaTJhCojy7nutHjik0yEYRnPaMmhKRtU+f
         zX9RauassvFix5LQKBdTTXGsss9EkLSWWDWW2sOYKB1ZpH1txKpo/Z5hPJOQYdd5HJhf
         mPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sCTuw1WJrpauWziD6ZslHIdSxjRJlSBBPPLfH0jwHc=;
        b=Vu/no8cwJhSjGdWneInJwqv+7xsflhz3cNsE7rPW6maiaJdA125zEkiv0i84bG98RV
         04y8IK2qGp6paOAYWEAsHfSO/ulNsdyGdbvPLDWQhK/yuB9C0T0ZJ0UWWbH1Nmw1PfgY
         s/1HrawLa0wvaC8v/MXeNMaE2YQXjrr7lipLh8QpEyMext1TJMJgBaPCMuVF9et1MKVK
         mJTDbgfipNV6iscF2Jr+52XdTaSg7uFsPfUbzHY3DdqEisDKqqelkSaiZwyjkMcSxFvZ
         1HY6+bCsdaKDKkcBkcdEPPlnKKbuSSfq5IT4A3BrP+fboPdAhf59PMh0UmncarWPVX/R
         lCdw==
X-Gm-Message-State: AOAM5322I0PPThR1W42wOHpfdY+6+iiosYyFgnryFqleuX+w+H0sQGiO
        fHiYl2fAhjuAhjQ5oqISNrT4llvKQuGfLeP9fjs=
X-Google-Smtp-Source: ABdhPJx2PWvd4x5NK+230XkDTUAXfFQro14L/4UwnjBFL5Ujsho/s/fX0r7d7uXi245hYj6aV9xtxabJDS6uzyV0/5s=
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr21248877pff.40.1620076296553; Mon, 03
 May 2021 14:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
 <20210503204907.34013-11-andriy.shevchenko@linux.intel.com>
 <YJBi5NU2WmZPYbBG@zeniv-ca.linux.org.uk> <CAHp75VfZKX_oYzoAA9Mbya1_+hP6+1mDKqyfy9d=hsokEAGQsQ@mail.gmail.com>
 <YJBmkNky4QfFhPD1@zeniv-ca.linux.org.uk>
In-Reply-To: <YJBmkNky4QfFhPD1@zeniv-ca.linux.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 00:11:20 +0300
Message-ID: <CAHp75Vet8CN3Cx2Loi_7PiXyf_XX1FWF3uPB-jUS51UC5B8U_w@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] nfsd: Avoid non-flexible API in seq_quote_mem()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 4, 2021 at 12:09 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, May 03, 2021 at 11:56:41PM +0300, Andy Shevchenko wrote:
> > On Mon, May 3, 2021 at 11:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Mon, May 03, 2021 at 11:49:05PM +0300, Andy Shevchenko wrote:
> > > > string_escape_mem_ascii() followed by seq_escape_mem_ascii() is completely
> > > > non-flexible and shouldn't be exist from day 1.
> > > >
> > > > Replace it with properly called string_escape_mem().
> > >
> > > NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
> > >
> > > Reason: use of seq_get_buf().  Which should have been static inline in
> > > fs/seq_file.c, to start with.
> >
> > I see.
> >
> > > Again, any new uses of seq_get_buf()/seq_commit() are grounds for automatic
> > > NAK.  These interfaces *will* be withdrawn.
> >
> > You meant that this is no way to get rid of this guy?
> > Any suggestions how to replace that API with a newer one?
>
> seq_escape_mem(), perhaps?

I think I have a better idea. What about adding seq_escape_with_flags()
and seq_escape() --> seq_escape_with_flags(..., ESCAPE_OCTAL, ...) ?

Would it work for you?

-- 
With Best Regards,
Andy Shevchenko
