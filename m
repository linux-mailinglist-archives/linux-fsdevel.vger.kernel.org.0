Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81C9A594
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 04:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391153AbfHWCf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 22:35:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40596 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390907AbfHWCf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:35:29 -0400
Received: by mail-io1-f68.google.com with SMTP id t6so16617558ios.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 19:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Ob+A4xxX2bRSxLGz92/UzTEvC1yWM8JcjhiXKDPfB8=;
        b=flcLM5FZxA1UdTl+5MfostzBYwQfyv1yb87DaSzrnDrUwd/ZNj4K4T/rHszC/sFQMH
         ADUFV/N/N6vulg+PsFB9LiJOba7WYzMsXqe7TkwmxiwQw++HUI5Q9lwxgsadqj5kp36o
         7ir9Ftxz3Frpzbh7dbD9IWl/fAPy+uyEwFD9Qu0xwImVT/66UuNo3m+3vDu9rqcZdHGP
         dJuOAFAhp3e0iD0AWnqz3VAQtqcjnUDCLFkZZiPVDrJq83kU9d3bg+KlteAnZK+XFKE6
         M2BK3WAwQy2tydaBr0xJ2dcLV8QJVxM3CxkgnlBsNXoibdFYaWIIutqUzeXdd2gExoTy
         FEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ob+A4xxX2bRSxLGz92/UzTEvC1yWM8JcjhiXKDPfB8=;
        b=W1bU/BQoa4lWzNJsCzvGn3l91ALjz7zyfe6kkNdR6xfNQRhkuXoIKi0lc29MKpY5oE
         jOb4P8Xxpz08DiyHoXu/FqadeRIctWWpCrPAZAZEgrOKLUv8Zd4vwC8VBwi3OIdJXqDH
         Gbec4m7sQh0ue1lt6r5zMA3Bq5cO6CclfdDmU7afN54DYucVZ8b2IAdpqwSdb+MoP22c
         plRV9R4Gjn6XlLGxB5UKvbXInA6Z1Mk48eiguGkeNxHA7e7WFP7krv1A6P0LUnoMQ60m
         Wus3Wu/k5QV/9dJR3lF9YgPSkwxgU8Eia2KU930/an60bn/12BohDroXTi4ixigSI60X
         qNzA==
X-Gm-Message-State: APjAAAXXl8l489OxQwa6fse364154n65vS+on0FHOJELOEpdUqVEyHEp
        Wa0sbcAmqzj/PJdihV8AyOm3XsAj0qaa7y4ViJIeBA==
X-Google-Smtp-Source: APXvYqxk0KBtXTDXCH7sq1BDWGn2tzcj3BOrK9VJXXJYjin28Niwi8IhH6bIWJT+jY7Hn20R6XsnRrLk/vFE/AUzyqo=
X-Received: by 2002:a6b:c581:: with SMTP id v123mr3719443iof.158.1566527727590;
 Thu, 22 Aug 2019 19:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190821064226epcas2p2835b8a9084988b79107e54abfc5e7dab@epcas2p2.samsung.com>
 <004101d557eb$98b00060$ca100120$@samsung.com> <6ea5e5db-4dd4-719f-3b3e-b89099636ea6@kernel.dk>
In-Reply-To: <6ea5e5db-4dd4-719f-3b3e-b89099636ea6@kernel.dk>
From:   Satya Tangirala <satyat@google.com>
Date:   Thu, 22 Aug 2019 19:35:16 -0700
Message-ID: <CAA+FYZc6G0xk7Dhx0b9xNRoK+b+DpfuS+OK4wn4bpKpFPiiGUQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] block: support diskcipher
To:     Jens Axboe <axboe@kernel.dk>, boojin.kim@samsung.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 5:10 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/21/19 12:42 AM, boojin.kim wrote:
> > This patch supports crypto information to be maintained via BIO
> > and passed to the storage driver.
> >
> > To do this, 'bi_aux_private', 'REQ_CYPTE' and 'bi_dun' are added
> > to the block layer.
> >
> > 'bi_aux_private' is added for loading additional private information into
> > BIO.
> > 'REQ_CRYPT' is added to distinguish that bi_aux_private is being used
> > for diskcipher.
> > F2FS among encryption users uses DUN(device unit number) as
> > the IV(initial vector) for cryptographic operations.
> > DUN is stored in 'bi_dun' of bi_iter as a specific value for each BIO.
> >
> > Before attempting to merge the two BIOs, the operation is also added to
> > verify that the crypto information contained in two BIOs is consistent.
>
> This isn't going to happen. With this, and the inline encryption
> proposed by Google, we'll bloat the bio even more. At least the Google
> approach didn't include bio iter changes as well.
>
> Please work it out between yourselves so we can have a single, clean
> abstraction that works for both.
>
> --
> Jens Axboe
>

Hi Boojin,

We're very keen to make sure that our approach to inline encryption can
work with diverse hardware, including Samsung's FMP hardware; if you
can see any issues with using our approach with your hardware please
let us know.

We understand that a possible concern for getting FMP working with our
patch series for Inline Encryption Support at

https://lore.kernel.org/linux-block/20190821075714.65140-1-satyat@google.com/

is that unlike some inline encryption hardware (and also unlike the JEDEC
UFS v2.1 spec), FMP doesn't have the concept of a limited number of
keyslots - to address that difference we have a "passthrough keyslot
manager", which we put up on top of our patch series for inline encryption
support at

https://android-review.googlesource.com/c/kernel/common/+/980137/2

Setting up a passthrough keyslot manager in the request queue of a
device allows the device to receive a bio's encryption context as-is with
the bio, which is what FMP would prefer. Are there any issues with
using the passthrough keyslot manager for FMP?

Thanks!
Satya
