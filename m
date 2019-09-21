Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34CFB9EDC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407791AbfIUQWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Sep 2019 12:22:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33722 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407788AbfIUQWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Sep 2019 12:22:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so7167014lfc.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2019 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5s1g7LcSvYimkibHuTqMUV6cKa2xNyVCmtcCc2hjLo=;
        b=EtJ1FiBSodX3Rqp4D3s3OshQ/U3UFvcIEAXrNZqjkH1zWhG8r1lgXmYfqflN6l85wd
         BPx5H770aiAcnYJLbwz2JKolkNL3SXxCUueJ8G0XzkbKX0ZvSNuR3IHfgQzVHdm1IQod
         nuY4IGiBG4Uqu3qw7R5SfQVLeqv50wmLLxXMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5s1g7LcSvYimkibHuTqMUV6cKa2xNyVCmtcCc2hjLo=;
        b=O5WOVZn2JVj6w3u3zEluVRIPQzMOwhNzCdQ3DpYVJ3LwFHwWJYiEfyOW0Jk3gGax1D
         pKStVqby0qC/WVqI5lJrLRJOIk2grBoXXM7XgAGP2k1ntZFmnNMT/zVEegWyAwHrOnS4
         0NVlFoG+gqT+yPZipd87olO2NqlNW5vvnx2PqlfKlsN6/wE6XE5p4GKkQ6yQBsp7tCwc
         Bo3ZBjphky2pzxBpZW9Qj6kHq/51NSJg29cs5gRgeOXuW4C33eSHxKBv9noS82TEn6+2
         lWVPjL51GWMira49sQlh9DN01/YMkt1oIBO8isf+Z1NUgr0/nwgN4WCFd5GfZnE9/p7Z
         Zozw==
X-Gm-Message-State: APjAAAX4PLR7nlHEsYicgrH+3EmhPSLmHo06H20pWjALnw3FXBHcPKVG
        1UXgxXGWz3PDm8LiYdObKbSRY9oowWI=
X-Google-Smtp-Source: APXvYqxQEkAMxiTypmgtj/FKEu1zRXAU1hw64dFMhUFaKbKxwKx32Q5A7JjEQJGOsORVjJSuGyAL/A==
X-Received: by 2002:a19:f512:: with SMTP id j18mr12028932lfb.169.1569082925110;
        Sat, 21 Sep 2019 09:22:05 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t16sm1175132ljj.29.2019.09.21.09.22.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2019 09:22:04 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id r2so7116393lfn.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2019 09:22:03 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr11555175lfh.29.1569082923275;
 Sat, 21 Sep 2019 09:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190914161622.GS1131@ZenIV.linux.org.uk> <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk> <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk> <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk> <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk> <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
In-Reply-To: <20190921140731.GQ1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Sep 2019 09:21:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrfvGOdgCQARA5Jwt7TbdM7MG8AUMyz_+GCdBZ7_x21w@mail.gmail.com>
Message-ID: <CAHk-=wgrfvGOdgCQARA5Jwt7TbdM7MG8AUMyz_+GCdBZ7_x21w@mail.gmail.com>
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

On Sat, Sep 21, 2019 at 7:07 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, #next.dcache has the straight conversion to hlist.  It definitely
> wants at least nfsd, er... misconception dealt with, though: list_head
> or hlist, this

Well, yeah. But is there really any downside except for the warning?

Looks like the code should just do

                if (!simple_positive(dentry))
                        continue;

and just ignore non-positive dentries - whether cursors or negative
ones (which may not happen, but still).

> No "take cursors out of the list" parts yet.

Looking at the commits, that "take it off the list" one seems very
nice on its own. It actually seems to simplify the logic regardless of
the whole "don't need to add it to the end"..

Only this:

    if (next)
        list_move_tail(&cursor->d_child, &next->d_child);
    else
        list_del_init(&cursor->d_child);

is a slight complication, and honestly, I think that should just have
its own helper function there ("dcache_update_cursor(cursor, next)" or
something).

That helper function would end up meaning one less change in the hlist
conversion too.

The hlist conversion looks straightforward except for the list_move()
conversions that I didn't then look at more to make sure that they are
identical, but the ones I looked at looked sane.

              Linus
