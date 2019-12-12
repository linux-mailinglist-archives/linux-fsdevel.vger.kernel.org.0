Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3411C2B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfLLBuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:50:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36851 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfLLBuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:50:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so374816ljg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PC+SlnRf7svTDlkNpHBVMSNitoLO6r2vdwDHMDAkNI8=;
        b=fNkGcKXQB3xCtLQKXADqQ3G/djHPEEOB2trqYHHu5gTxMrHq7l42M/wCwdjLYpZmt5
         d7A+P6Xe/uSH2xY8H4UU5n/Z0u0+D6EAJztG7SF9hKLTZUlA4KZhCzbYrxxykxZ762O1
         5fT3K/zxq8wXmuG9+5Iondt19rtNqXTpw1zSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PC+SlnRf7svTDlkNpHBVMSNitoLO6r2vdwDHMDAkNI8=;
        b=m0EVfsVC4Jj5yw9ZQyTN7dlYD0cOW3VEiDrLTbkI23fFmzKmThKjture00mj6ioWsr
         +dEywCsKy4F6zj4f25CkXR24Ha66lmGmQsVaqruscpy47Y3HwJV1IibI4+q6uPoCON8w
         +dVc04BwNXRsDPy7lSF7Qxljxhh5F/mOCo9FPamprt5qnBxYxKVv1ieC1I4b2pCyaMOZ
         B5+8Cjp8XpX9t3WWt5CDVPQq6wHUwJAHrVkO4EGWVPWuuNnXu5yL0SZeEJjhyy7gklko
         kxwK7JYqgJECWEY4nUohSbTWcmUffYjtrxFf15wFzh7ENaae2rAGXqE154/D/G7ZvOQ2
         cDKg==
X-Gm-Message-State: APjAAAWzupuFAuCqzrmSDT0yY38ZkBmzVJArMHt70jEk/SRg3jQnLTBm
        woWXcaFslPv61LXRNg7782YS1johurc=
X-Google-Smtp-Source: APXvYqzWewWSxd+yk2RI4alibIC89tM8SMoDYT3i0zmwsTw+kx9LZ0UfHeU/ZL1TC2NsEH7ETw7rMQ==
X-Received: by 2002:a2e:7f08:: with SMTP id a8mr4058070ljd.164.1576115414913;
        Wed, 11 Dec 2019 17:50:14 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z26sm2010088lfq.69.2019.12.11.17.50.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:50:13 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id k8so366030ljh.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:50:13 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4244948ljj.148.1576115413333;
 Wed, 11 Dec 2019 17:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk> <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk> <6e2ca035-0e06-1def-5ea9-90a7466b2d49@kernel.dk>
In-Reply-To: <6e2ca035-0e06-1def-5ea9-90a7466b2d49@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:49:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkpRnqDfcR1h2NyCN7Ka9T0DcHgBL=e9pVvYG2u0APdQ@mail.gmail.com>
Message-ID: <CAHk-=wjkpRnqDfcR1h2NyCN7Ka9T0DcHgBL=e9pVvYG2u0APdQ@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 5:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> So now I'm even more puzzled why your (desktop?) doesn't show it, it
> must be more potent than my x1 laptop. But for me, the laptop and 2
> socket test box show EXACTLY the same behavior, laptop is just too slow
> to make it really pathological.

I see the exact same thing.

And now, go do "perf record -a sleep 100" while this is going on, to
see the big picture.

Suddenly that number is a lot smaller. Because the kswapd cost is less
than 10% of one cpu, and the xas_create is 30% of that. IOW, it's not
all that dominant until you zoom in on it. Considering the amount of
IO going on, it's kind of understandable.

But as mentioned, it does look like something that should be fixed.
Maybe it's even something where it's a bad XArray case? Willy?

              Linus
