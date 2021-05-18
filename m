Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5843E38741F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347540AbhERIcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 04:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhERIcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 04:32:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67DC06138E;
        Tue, 18 May 2021 01:30:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j10so12849794lfb.12;
        Tue, 18 May 2021 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXP6snOC8xLngv4ZVFntPoWb3yWh74M8TxVauUvuK30=;
        b=C8pfAfF2qn1iaBuQHe31DCJXIEavfT8xUPCxpH+ACgxBm4YRnb04Z3elSomadlK8n6
         SrwZaBlBqqVYkNYgegKqMAQtCueekofwBv04iwsQuRe7ONt839VZeVpG0vbh7wesBz7C
         fq2OZI55E5pgPahw7MdQukxRJc3W2DG1v7+dvJ7HYydlp3O0nzhYFSE7xjiosr27wWtq
         uqqNrlVCAjDMm03ng3/QJFGcTXt3+gbNp4zn6o3uasGS2IOIqRQ+XfTlLKjKoJQPodVO
         MXV3PrKveQNZdV7aZP/Hp+OlS4gExE1p3jiMPS51l0JA9HlunYxsJBhw3J4ViqAb/UYb
         Q4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXP6snOC8xLngv4ZVFntPoWb3yWh74M8TxVauUvuK30=;
        b=QTpB4j3MztqogWRYkbEXDFAKoSLWCI9FmlNJiZGxEsDKd3rrvDtQRsfv6gKm1No8p0
         ZcMyjw5+rqXRF0RmsEb+nxaG4E/AUqBLgd0b4vg0oKca6J8sETOxvO/cAk2icO5veeza
         Ek04wl2N9cxj01TZD4C2ojy/mMBG+2EIUrgvmpp2hQSyrXqY9CwnVqwNu8YUvR18h3Q9
         gN48B2oEH3wZGCJm6fV3w73Dwap7r7LUo8uJsqcytpegA5yw74RZXIQcwH7Tn17xSCAe
         A9aQNqbzlzEujBRxfL3z/gxpYGoynH2OqrC2DlkJxp99jIle7yFkjP9Jej7h1pF6wEUS
         PjvA==
X-Gm-Message-State: AOAM531h3v2TARIHYv8tB9RxdY35NQlXx1d5EHU99d+n+LBOMIksXgyj
        AHseElCAYQaecvP+mhQ6sd374IegpjJPOLkJJhI=
X-Google-Smtp-Source: ABdhPJwblFjFXuz8OCa8jnbVKtPXkSCJFRQwHA/8qZOsRId9PkCXkzJ6d+tH2fuCa+0hZqhc4mUsJAXFdFg5ChePEtw=
X-Received: by 2002:a19:490f:: with SMTP id w15mr3408382lfa.192.1621326640013;
 Tue, 18 May 2021 01:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210517142542.187574-1-dong.menglong@zte.com.cn> <20210517151123.GD25760@quack2.suse.cz>
In-Reply-To: <20210517151123.GD25760@quack2.suse.cz>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 18 May 2021 16:30:27 +0800
Message-ID: <CADxym3ZwUQe0mQfcNxf2_kM1VXdqmtUDK076GptcsfktLWLeog@mail.gmail.com>
Subject: Re: [PATCH] init/initramfs.c: add a new mount as root file system
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, hare@suse.de, tj@kernel.org,
        gregkh@linuxfoundation.org,
        Menglong Dong <dong.menglong@zte.com.cn>, song@kernel.org,
        neilb@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        palmerdabbelt@google.com, mcgrof@kernel.org, arnd@arndb.de,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, Kees Cook <keescook@chromium.org>,
        vbabka@suse.cz, pmladek@suse.com,
        Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>, ebiederm@xmission.com,
        jojing64@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks!

Should I resend this patch? Seems that it does not appear
on patchwork.



On Mon, May 17, 2021 at 11:11 PM Jan Kara <jack@suse.cz> wrote:
>
> Thanks for the patch! Although you've CCed a wide set of people, I don't
> think you've addressed the most relevant ones. For this I'd CC
> linux-fsdevel mailing list and Al Viro as a VFS maintainer - added.
>
>                                                                 Honza
>
