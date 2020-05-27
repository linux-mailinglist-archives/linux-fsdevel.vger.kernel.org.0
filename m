Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BDE1E400C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgE0L25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 07:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgE0L25 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 07:28:57 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A27208C3;
        Wed, 27 May 2020 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590578936;
        bh=9f/lRzafJFrJXPhrHpqb1P487oTDycX7ANTY/3w2low=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZaN7XVSQ4RPZG0KbPIpeSN7Voo/9jycJMTHX6d9WR/iviuDdPQPGH1OyWXYQT792d
         7aVYgRM7VtT6CDfUnIiCQDp2pYBrui++m6tCg3gkhfCv5Kv9ddxwYhzxptoWre91tt
         nAp/cmgfRdHu5B8Azsxql6o3LKJjdnzWKVPT4xqY=
Received: by mail-oo1-f42.google.com with SMTP id a83so4907403oob.9;
        Wed, 27 May 2020 04:28:56 -0700 (PDT)
X-Gm-Message-State: AOAM530dvrMVbD3PViuQ5YOy+8Bb4zvabJV8/NElnX15K7Gfn7bJgP9F
        g4L5296ySwQER8bb6sGK2mDvb+xIdWfDB2xXibU=
X-Google-Smtp-Source: ABdhPJxL4QyLSRiXgww4FQ3grAmkFtEQXMWXQUZG/8ZuPKRGO2M5716GycRTSDB51t/qlLqcd0i19z0MUC2gLIEpwQM=
X-Received: by 2002:a05:6820:28a:: with SMTP id q10mr2723842ood.79.1590578935739;
 Wed, 27 May 2020 04:28:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1d8:0:0:0:0:0 with HTTP; Wed, 27 May 2020 04:28:54 -0700 (PDT)
In-Reply-To: <d0d2e4b3-436e-3bad-770c-21c9cbddf80e@gmail.com>
References: <20200525115052.19243-1-kohada.t2@gmail.com> <CGME20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8@epcas1p2.samsung.com>
 <20200525115052.19243-4-kohada.t2@gmail.com> <00d301d6332f$d4a52300$7def6900$@samsung.com>
 <d0d2e4b3-436e-3bad-770c-21c9cbddf80e@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 27 May 2020 20:28:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9GzYTxjtFuUJe+WjEOHSJnVbOfwn_4ZXZgmiVtjV4z6A@mail.gmail.com>
Message-ID: <CAKYAXd9GzYTxjtFuUJe+WjEOHSJnVbOfwn_4ZXZgmiVtjV4z6A@mail.gmail.com>
Subject: Re: [PATCH 4/4] exfat: standardize checksum calculation
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-05-27 16:39 GMT+09:00, Tetsuhiro Kohada <kohada.t2@gmail.com>:
> Thank you for your comment.
>
>> I can not apply this patch to exfat dev tree. Could you please check it ?
>> patching file fs/exfat/dir.c
>> Hunk #1 succeeded at 491 (offset -5 lines).
>> Hunk #2 succeeded at 500 (offset -5 lines).
>> Hunk #3 succeeded at 508 (offset -5 lines).
>> Hunk #4 FAILED at 600.
>> Hunk #5 succeeded at 1000 (offset -47 lines).
>> 1 out of 5 hunks FAILED -- saving rejects to file fs/exfat/dir.c.rej
>> patching file fs/exfat/exfat_fs.h
>> Hunk #1 succeeded at 137 (offset -2 lines).
>> Hunk #2 succeeded at 512 (offset -3 lines).
>> patching file fs/exfat/misc.c
>> patching file fs/exfat/nls.c
>
> II tried applying patch to dev-tree (4c4dbb6ad8e8).
> -The .patch file I sent
> -mbox file downloaded from archive
> But I can't reproduce the error. (Both succeed)
> How do you reproduce the error?
I tried to appy your patches in the following order.
1. [PATCH] exfat: optimize dir-cache
2. [PATCH 1/4] exfat: redefine PBR as boot_sector
3. [PATCH 2/4] exfat: separate the boot sector analysis
4. [PATCH 3/4] exfat: add boot region verification
5. [PATCH 4/4] exfat: standardize checksum calculation

Thanks!
>
> BR
>
