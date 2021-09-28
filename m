Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF3841B27A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhI1PBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbhI1PBi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:01:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F7C06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 07:59:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m3so93869225lfu.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fInY95no8O0JEStBsdbpcymzt287B66Fcqaxhkug+c=;
        b=FfNByYfUegGHsII+I3f5TVFbSZkKQ34sMp4OH9feQ01FDoaO1JVJtg1jZ8hbAyyE3h
         +o/QtI4Gycrr4pn0Wb6Q9HuBgnVKu37zPHCYNw6PKfpAmVP4trKhCICqVexk61OjymcM
         ajE+rrWyYiEaYRePBmCieqMzw5ekh1Vxny2gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fInY95no8O0JEStBsdbpcymzt287B66Fcqaxhkug+c=;
        b=mqXsggjPF6n/X/p22nzK9PAVieoY/ONXDYifRO1U2DtUSdXW0TV7Ag0baEoQeZFbcn
         R4cj5RN/qty0Cnea0ER7gIT26Ihb4TRLU60uFhuyx8uK1q66G/uMOopkhP+seL1bHxzW
         4L/ovboC3hdlLM3m5njf+g9un5VFmCGH56hcWh8OaKaHgiuCtx1vF5OYn8uQyPweQs8L
         53GFv6TOZALq/x/eDzRqzzpensLBcYF9zDef2mPUTMHB6y8dCHVWRKG760MGhBKllOal
         CrwgdxX/1+Pm8vfPMtrOdNVZGyVx/hDYhcancqbO9RJZqxbSfovM71bIX94Q9gIOwaCR
         KBUQ==
X-Gm-Message-State: AOAM533SuuEg8hBC+cLwXuTExu8dvaM8KHlK1VIbzJTfIeJBNK5KPOId
        ruRFm7RfN6szwlmHaIloApI+XZ+xNsXfzYYA
X-Google-Smtp-Source: ABdhPJxmd7jsILlKKr++CAO3Ic2wVFXufhGzA8B/LRjNF/EZhAKEMsIwirhTzyuwZzMi6i9Ous9EgQ==
X-Received: by 2002:a05:6512:acb:: with SMTP id n11mr5739144lfu.523.1632841190104;
        Tue, 28 Sep 2021 07:59:50 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y9sm2139561lfl.240.2021.09.28.07.59.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 07:59:49 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y26so54582845lfa.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 07:59:49 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr387530ljc.249.1632841188299;
 Tue, 28 Sep 2021 07:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <YVK0jzJ/lt97xowQ@sol.localdomain>
In-Reply-To: <YVK0jzJ/lt97xowQ@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Sep 2021 07:59:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibMN-Bixbu8zttUoV1ixoVRNk+jyAPEmsVdBe1GFoB5Q@mail.gmail.com>
Message-ID: <CAHk-=wibMN-Bixbu8zttUoV1ixoVRNk+jyAPEmsVdBe1GFoB5Q@mail.gmail.com>
Subject: Re: [GIT PULL] fsverity fix for 5.15-rc4
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:22 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Fix an integer overflow when computing the Merkle tree layout of
> extremely large files, exposed by btrfs adding support for fs-verity.

I wonder if 'i_size' should be u64. I'm not convinced people think
about 'loff_t' being signed - but while that's required for negative
lseek() offsets, I'm not sure it makes tons of sense for an inode
size.

Same goes for f_pos, for that matter.

But who knows what games people have played with magic numbers (ie
"-1") internally, or where they _want_ signed compares. So it's
certainly not some obvious trivial fix.

Pulled.

            Linus
