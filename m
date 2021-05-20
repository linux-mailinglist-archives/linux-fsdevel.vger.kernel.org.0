Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E9338B35F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhETPjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhETPjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 11:39:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403DC061574;
        Thu, 20 May 2021 08:37:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p20so20284004ljj.8;
        Thu, 20 May 2021 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrLvoQmySHAA54WaEv7KeSfGGhqZbc7X88UdgVwLyWY=;
        b=IQCietefP2mRjEBV5TXXOTmly6OwuHm/7gX/PTqiLaCumyzK8DZx+tbpsChwzJc/t/
         Xmq5aaHOIIoJCOYdug34Rg+INrVb9sdQVcxDcEhHACOh3pVtuOynPo8GDLLBqPSOsiSa
         vhcTHD++hboiJjndIRfaMLrj1j6zEpqDXMAeRgiYf6HbwuqnD54zosQDW8wCrbB9Vtvj
         cats2WnwImz7n1V32Kdqrp+0ImmkV+X2h1j/V6o+5V+1+l54G4Dc/RZzNUql3Jog/I86
         DXEKg7yx/u31cnRFsnadSwjbHRG6AGkAaukFnwGmQ8q+lSowd83MyPYobGEBjst/7wlE
         fhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrLvoQmySHAA54WaEv7KeSfGGhqZbc7X88UdgVwLyWY=;
        b=QIIFq5xDugGZ9Vnp6WWNMc51WEZvxoX9JaKmFvBOOPoftA1wYYllhJPccLvZbubJqd
         aFkODpU3Z1RMshXKx9VYzTPAf89MtL948mRrOOUV+AFzpZSdN2z/QYMwyjuEPWVd1Pfv
         C413bHRQcyKAYVstvaMF9baS/w3oFBNA++bUjD9C7jsaCVnJIBoM5SBnm7rv4+hw9C5Z
         5J66DS+9lwbSezQGRYnDGhkNCyIC94xcmS7AyXOpXA+ERDYKmHTuR/Ooz+AfMOU46xHr
         /8agkGpByTwTSWzgkUh1mPDkishXtykzTH2ZS9m6YlI3cPobWLXVekEZB/aWcAcOAZl7
         M5Bw==
X-Gm-Message-State: AOAM531iLD0C7q1IcO/eNtVuLb5F02RGWfaE62+9e2hnPOp4H3Yv+4d3
        QdlfIcs8bk2u3fGlDvXUS1/NxWJ4k5nCu317wnM=
X-Google-Smtp-Source: ABdhPJxVyldSai7fxyKNl5ql4IwLUAnlpUulmSDcUOk+AXWgUo4K3ngbYdQOOcv1J/Y1XnVR9rJ1pusR39uMNfIx9So=
X-Received: by 2002:a2e:8086:: with SMTP id i6mr3409523ljg.135.1621525074694;
 Thu, 20 May 2021 08:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210517142542.187574-1-dong.menglong@zte.com.cn>
 <20210517151123.GD25760@quack2.suse.cz> <CADxym3ZwUQe0mQfcNxf2_kM1VXdqmtUDK076GptcsfktLWLeog@mail.gmail.com>
 <20210518085519.GA28667@quack2.suse.cz>
In-Reply-To: <20210518085519.GA28667@quack2.suse.cz>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 20 May 2021 23:37:43 +0800
Message-ID: <CADxym3ZEf7azG+ApRqrg+aUBSm66N5tC0Ybj9FXyHq7BV3ePmg@mail.gmail.com>
Subject: Re: [PATCH] init/initramfs.c: add a new mount as root file system
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, hare@suse.de, tj@kernel.org,
        gregkh@linuxfoundation.org,
        Menglong Dong <dong.menglong@zte.com.cn>, song@kernel.org,
        neilb@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        palmerdabbelt@google.com, mcgrof@kernel.org, arnd@arndb.de,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, vbabka@suse.cz,
        pmladek@suse.com, Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>, ebiederm@xmission.com,
        jojing64@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Tue, May 18, 2021 at 4:55 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 18-05-21 16:30:27, Menglong Dong wrote:
> > Thanks!
> >
> > Should I resend this patch? Seems that it does not appear
> > on patchwork.
>
> I don't think you need to resend the patch. Not sure why it is not in the
> patchwork but relevant maintainers for this area don't use it anyway AFAIK.
>

It has been three days, and no one reviews my patch.
Mmm....I think I'd better resend it with linux-fsdevel CCed.

Thanks!
Menglong Dong
