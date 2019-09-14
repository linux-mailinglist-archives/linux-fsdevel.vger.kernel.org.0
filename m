Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE380B2C47
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfINQtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 12:49:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36489 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfINQtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 12:49:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so2311180ljj.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2019 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WyQciLB9X1pp0U/5BdJbJHwfqT/eBV/wnFJqHb8MbG4=;
        b=QzwIxM7S8v3x+6uUvJU7G0idzMnl7fTJhiG+3SW9fhVzPiiUu0KZ5Fwa6WNiIZVBot
         XzTsVJX9jf967PsgxhUA9C5WKzQjPmMT4z5+D/ovDgIwveD6cpdeKoBI8T4cE22jGYLD
         IYaCF6ND+tezHqbB+aXJPs9D3IW8OodzqizXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyQciLB9X1pp0U/5BdJbJHwfqT/eBV/wnFJqHb8MbG4=;
        b=ZRw+3il4HCfAlBJVds2smNDrEubX0Jl2X0KaO1gpFfVsHT/jkhxnjuyDid5paPaoth
         PiLko9HH/X55Vu/DfAzw75gxnRWF8N7V3P8r0V0kmEYiUaRypqYgQDb/XdM68xOaeDLO
         fSp9vIkB9hrCJziFLIzabk3nWsvXsaIh1OWRED8csS7NN2wTf3VL7CIrPFTIFENdJ5D8
         LYQ/ffVpv7nnkAsYvxlwm5262NJLnhwNFTlt2spDZ8uZJyQHMkJUIXoU8MVh7CmxPqD8
         vSQvZ+OP+zNgoknVbc855bjkMKXBPHXITOdZmkadDl9IRE5/XRlZfrC25XjEsk1dMWBe
         KnXQ==
X-Gm-Message-State: APjAAAXF+bn6WEWnp81lkmAQwUatqOgKAp8sPGfZau1u5Ia5+7v/MsPW
        P4Yb5cYf/fnTBuwnQf2CMx7V0uyCjHA=
X-Google-Smtp-Source: APXvYqwHCILCSdskOUEq0t8I2DM1mgKi1g0brhFzlYd+o/kxRRTOjjik7tycvhPrBNOpmQee6zhWAQ==
X-Received: by 2002:a2e:8789:: with SMTP id n9mr395032lji.52.1568479778914;
        Sat, 14 Sep 2019 09:49:38 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m9sm7116959lji.66.2019.09.14.09.49.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 09:49:37 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u3so9228363lfl.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2019 09:49:37 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr34749484lfp.61.1568479777071;
 Sat, 14 Sep 2019 09:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk> <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com> <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk> <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com> <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk>
In-Reply-To: <20190914161622.GS1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 09:49:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
Message-ID: <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 9:16 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         OK, folks, could you try the following?  It survives the local beating
> so far.

This looks like the right solution to me. Keep the locking simple,
take the dentry refcount as long as we keep a ref to it in "*res".

However, the one thing that strikes me is that it looks to me like
this means that the "cursor" and the dentry in "*res" are basically
synonymous. Could we drop the cursor entirely, and just keep the ref
to the last dentry we showd _as_ the cursor?

Yes, this would mean that we'd keep a ref to the dentry across
readdir() calls, and maybe that's a horrible idea. But is that all
that different from keeping the ref to the dentry that is the
directory itself?

              Linus
