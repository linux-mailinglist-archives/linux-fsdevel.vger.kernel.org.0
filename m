Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D134EBDE20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 14:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfIYMev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 08:34:51 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38341 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIYMev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:34:51 -0400
Received: by mail-yw1-f67.google.com with SMTP id s6so1940366ywe.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrDaOsnIr2WTgFcvWtP3ueOOhuV3aDBDyKo7k1Ld0+Y=;
        b=ILpLnBl94KFyFjsuCaVJl6rs5DplLsyA3lQOChFyUhZIgk2E88cPXuR44AbY7QZma9
         5AvyPaG7Ou0GxjnbYQWXGeUQwvjqbWB8/9MCH3iotl/C8S49f7tq2u7/zxaUFGft9YiA
         8fP9UgtWGL+ao8lKPGOX+2HU1oDacaBJ6WQYIksXk+dEi3UHeDRk5IDn9nAAwI48SLkc
         oK9//1FVisF2R+KUsbwBJNT4tqthi0eV/xFnO5DVIMOlJXESabSgbyT5ljGHnDmTIgJD
         SR2SAM7INdm44+ebPpfi4O6AhhWcdDKb5kaDMrP9SXkns/UFrgdImRUNvtjWwrh2GvIM
         DlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrDaOsnIr2WTgFcvWtP3ueOOhuV3aDBDyKo7k1Ld0+Y=;
        b=WIjGpRqNDEjP2aS5APZWKqOdvekqA23hEPFyR59yOk8S9u4xfCx3AmC45s9LmG32Ne
         4YJIxKPqvwkstlVfQgdTTC6V749TGwrCWQrdF5Iu+MbsyDglb+w/6IkPHmggaFcXV4yK
         V/vXFxGsR5pwtV6pIhFXl5Q6V5xJ1sT8X82VwKNkqb4aVG34t/G2iACSaNjGvXpYgvDD
         M2/wNhJmoisnaV9abmTeGGdAqwPNa+ol1A+k9PFEreoDht5pQKuzAYZsmZ3EZWm2blNI
         YDNlmVtfiw7/EPx+9p92IroHtHg1aXxVOGdAGxi38FF4AWooQpr7Vuknrd0X4AKpmWH0
         WETQ==
X-Gm-Message-State: APjAAAWEK20HSI9hJnRXS3VSz5Jee4Y0URcFZHS+MYC8JmqRDwb4YcWP
        ZssiAJ2XFydDrN+Lhf/uM+VCG+RGxyrJWYxdTZw=
X-Google-Smtp-Source: APXvYqxQaDhrcDrqgag2aWccr0ImywM+X9F85z/QuOJyYWsXUEZkaVjFmZwD7KJFcPOasDABoVAG5q7tZMdnHpHaOa8=
X-Received: by 2002:a81:7743:: with SMTP id s64mr5620241ywc.183.1569414890271;
 Wed, 25 Sep 2019 05:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190914170146.GT1131@ZenIV.linux.org.uk> <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk> <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk> <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk> <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk> <CAOQ4uxh-FH7JZP9fVqHXYJkbLA+NK6fX7HQex-XwY0Sha-R_kw@mail.gmail.com>
 <20190925122206.GJ26530@ZenIV.linux.org.uk>
In-Reply-To: <20190925122206.GJ26530@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Sep 2019 15:34:38 +0300
Message-ID: <CAOQ4uxgeDkTjQNtOjSEVknNAG6W6sXXOFqzns90uKmMBGEP2EA@mail.gmail.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 3:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 25, 2019 at 02:59:47PM +0300, Amir Goldstein wrote:
> > On Mon, Sep 23, 2019 at 5:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > FWIW, #next.dcache has the straight conversion to hlist.
> >
> > Note that this:
> > @@ -108,8 +108,8 @@ struct dentry {
> >                 struct list_head d_lru;         /* LRU list */
> >                 wait_queue_head_t *d_wait;      /* in-lookup ones only */
> >         };
> > -       struct list_head d_child;       /* child of parent list */
> > -       struct list_head d_subdirs;     /* our children */
> > +       struct hlist_node d_sibling;    /* child of parent list */
> > +       struct hlist_head d_children;   /* our children */
> >
> > Changes the 'standard' struct dentry size from 192 to 184.
> >
> > Does that matter for cache line alignment?
> >
> > Should struct dentry be ____cacheline_aligned?
>
> *shrug*
>
> DNAME_INLINE_LEN would need to be adjusted;

OK. But increasing DNAME_INLINE_LEN will move d_fsdata
across cache line.
Not sure if that matters, but it seems to be documented as
part of the group of struct members touched by Ref lookup.
It was intentionally moved by commit
44a7d7a878c9 fs: cache optimise dentry and inode for rcu-walk

Anyway, if you end up adding another hlist_head that won't be a
problem.

Thanks,
Amir.
