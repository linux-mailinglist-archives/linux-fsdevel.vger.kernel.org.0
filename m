Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF23BAF3E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 23:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhGDVuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 17:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhGDVuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 17:50:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04ECC061574;
        Sun,  4 Jul 2021 14:47:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r4-20020a0568301204b029047d1030ef5cso9404382otp.12;
        Sun, 04 Jul 2021 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cZ8xsA8QLQaj2J0PzOeIfsQXZnj289BEugFh9tQm05Q=;
        b=mCxzUkE+dpQsbbTB9r6h1BGQPre+3X7CZqnQZeO4j63ygoGs1Cuqr/ygxCrQ9F7BLP
         kirHK3nOoy8qhAFlSLE//jGXXV/FRZwIJcbQsmhfYWNB1QRwXzVT4mUSsBg3KUaKN30h
         yE1+JRcOGwW7s37tkd/0leobJz3HV2pYq6M8Awwvfxof3ZXe+KR6xi8AJAT394TQdX+u
         CDtb5uryTa7ggN1g9KG2M4UT668XkM2HqwuF44Lmu/HZHFIlFotZdLdUqF+ui33KIK0k
         +WJzJpA9St87I01H2mVmSxbs5okSm7cz9RG36ChJPrZgSZwA1cqJ2WUxDrHQU5dQC1Od
         j0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cZ8xsA8QLQaj2J0PzOeIfsQXZnj289BEugFh9tQm05Q=;
        b=pBlwaZspNNwM38HO5bN7ejiPhM6O5X8qw7vTRGjZGFjZ28N96tJOedEiTPYXs71MNA
         aPKlvy1Zwi7N81bbrizLbmQd6anL1meDk4GxCWRHLqOP3qu1dCrnaGiqQ80eSL3znJmB
         ZrsswTZeRGwIaARkABeHOgFISuuLxfRrTP6249ZAmbvWg2+1/dadK7RTcYhO8MbZBjL2
         T7uIkSj/blITQbLJUDSU46AaIuRXnNf+CsD5OTKr2LSWayMP5I+Ri0z+xNmV4MZD8akV
         lzyTAmOOkVy6IFZd1bkaGpeBUuJ1F81rJyNKmNrVP6VUcWAGPCNBeabukuV/BVXW1ci0
         3DUA==
X-Gm-Message-State: AOAM533iI9tf89/ygVsBSdaedrNmpq1QMt0kc6uIy2cPvU9TBI7+whyN
        VDt5/PuYCDK8sHjbs3/hwT8=
X-Google-Smtp-Source: ABdhPJz6kvhbOmwT7Cq/qPQ+XD3Ngw3asxOORd3jzWMH9Zs/Zb3P+gKsbN2dFVal89ev5RtQqvHq5A==
X-Received: by 2002:a05:6830:824:: with SMTP id t4mr8539346ots.250.1625435247134;
        Sun, 04 Jul 2021 14:47:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m66sm2277732oia.28.2021.07.04.14.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 14:47:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20210704172948.GA1730187@roeck-us.net>
 <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net>
 <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
 <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net>
 <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
Message-ID: <03a15dbd-bdb9-1c72-a5cd-2e6a6d49af2b@roeck-us.net>
Date:   Sun, 4 Jul 2021 14:47:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/21 1:41 PM, Linus Torvalds wrote:
> On Sun, Jul 4, 2021 at 1:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Turns out that, at least on m68k/nommu, USER_DS and KERNEL_DS are the same.
>>
>> #define USER_DS         MAKE_MM_SEG(TASK_SIZE)
>> #define KERNEL_DS       MAKE_MM_SEG(0xFFFFFFFF)
> 
> Ahh. So the code is fine, it's just that "uaccess_kernel()" isn't
> something that can be reliably even tested for, and it will always
> return true on those nommu platforms.
> 
> And we don't have a "uaccess_user()" macro that would test if it
> matches USER_DS (and that also would always return true on those
> configurations), so we can't just change the
> 
>          WARN_ON_ONCE(uaccess_kernel());
> 
> into a
> 
>          WARN_ON_ONCE(!uaccess_user());
> 
> instead.
> 
> Very annoying. Basically, every single use of "uaccess_kernel()" is unreliable.
> 
> There aren't all that many of them, and most of them are irrelevant
> for no-mmu anyway (like the bpf tracing ones, or mm/memory.c). So this
> iov_iter.c case is likely the only one that would be an issue.
> 
> That warning is something that should go away eventually anyway, but I
> _like_ that warning for now, just to get coverage. But apparently it's
> just not going to be the case for these situations.
> 
> My inclination is to keep it around for a while - to see if it catches
> anything else - but remove it for the final 5.14 release because of
> these nommu issues.
> 
> Of course, I will almost certainly not remember to do that unless
> somebody reminds me...
> 
> The other alternative would be to just make nommu platforms that have
> KERNEL_DS==USER_DS simply do
> 
>      #define uaccess_kernel() (false)
> 
> and avoid it that way, since that's closer to what the modern
> non-CONFIG_SET_FS world view is, and is what include/linux/uaccess.h
> does for that case..
> 

Theoretically, but arm defines it as true with !CONFIG_MMU and then
uses it in user_addr_max():

#define user_addr_max() \
         (uaccess_kernel() ? ~0UL : get_fs())

with !CONFIG_MMU:

#define KERNEL_DS	0x00000000
#define get_fs()	(KERNEL_DS)

How about the following ?

	WARN_ON_ONCE(IS_ENABLED(CONFIG_MMU) && uaccess_kernel());

Guenter
