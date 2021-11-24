Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC345D0AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346246AbhKXXDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343912AbhKXXDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:03:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E72C06173E
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 15:00:20 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x15so17178682edv.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 15:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3I9PlA7fC8HgB2vr5zydxZ4zg5kA0COA3RvDIbE8i6k=;
        b=akPSCYrD6EASyAHbxHctwYr0LW3XzQryE1WnwGL61n9RnWw1NkFmVSX0i9BtWuGZYh
         3HsX+j15WJiusBmje+0ffkwgWfbwZl3OZuwQ+FeVw4qqieUoMRy3mrm7/NfOdIx1DyJ8
         WJvl/rGNRCqOZGiGzEuCEgFc6r1TDjmx7J7Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3I9PlA7fC8HgB2vr5zydxZ4zg5kA0COA3RvDIbE8i6k=;
        b=8CO2hNCz3UNzgHvSOuMTRBnSTWDKWqwMDzzuZlkRtXQB0e2cQWjkwfyQ+jdMBHoJYT
         5fA8V3g8saF+KVBrPEIrKiAUbIR01K3LK46XJSYv4xlL7zLYySde5kX6EXSfcavAJ2ao
         aqA5Eqv4GIGugbGYioe0axaOqiml7w5m2HzLyuBXuw262dcUdCOHxoAjd9x0OETjPn21
         0mDVubA0mU/UfG+HXBq395AkXOzqPwslHD4+CUvE5jzvJCdd791piE/dAb1PZYrC7Z8o
         E2X6ZNJvf4Kz1UHhoNangbBTYmg+QPsRSyVyvjPQmYS0nXILNnKySPk0pHUH0Ji1wJNd
         mZgA==
X-Gm-Message-State: AOAM533AANC0CWX+KQrH6uuN9JPcBowLSls2ZmT7ZR7koorRz8rBSfbN
        9XzGGiJtQh4VaxveVIPRcKKxbP9xuVaFhElh
X-Google-Smtp-Source: ABdhPJzC6EsLUHzUThuTEooHZQzAwba8CEbIwNf2yL4FXdUeNzps8E6gLnm0rkFTYuDd/W4H9wJaYw==
X-Received: by 2002:a05:6402:4302:: with SMTP id m2mr32918756edc.349.1637794818298;
        Wed, 24 Nov 2021 15:00:18 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id n16sm741570edt.67.2021.11.24.15.00.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 15:00:16 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id i12so3885780wmq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 15:00:16 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr1159359wmq.8.1637794816000;
 Wed, 24 Nov 2021 15:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
In-Reply-To: <YZ6arlsi2L3LVbFO@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Nov 2021 15:00:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com>
Message-ID: <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Catalin talked about the other change, but this part:

On Wed, Nov 24, 2021 at 12:04 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> (where __copy_to_user_nofault() is a new function that does exactly what
> copy_to_user_nofault() does, but returns the number of bytes copied)

If we want the "how many bytes" part, then we should just make
copy_to_user_nofault() have the same semantics as a plain
copy_to_user().

IOW, change it to return "number of bytes not copied".

Lookin gat the current uses, such a change would be trivial. The only
case that wants a 0/-EFAULT error is the bpf_probe_write_user(),
everybody else already just wants "zero for success", so changing
copy_to_user_nofault() would be trivial.

And it really is odd and very non-intuitive that
copy_to_user_nofault() has a completely different return value from
copy_to_user().

So if _anybody_ wants a byte-count, that should just be fixed.

                    Linus
