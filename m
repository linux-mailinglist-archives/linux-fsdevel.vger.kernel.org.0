Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614373BAEDB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGDUbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 16:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhGDUbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:31:23 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF9C061574;
        Sun,  4 Jul 2021 13:28:47 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so16206048ota.4;
        Sun, 04 Jul 2021 13:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4EDmUrri+2NsQ7mgU5C2uQstgGcmQxd++Qh1sKnG8xc=;
        b=eAeIYgXm0sJ3MY9nq+CaZITqVkx/220XvA9vX0TMJqK5D41xwq+lPmgO3MkEzbw93x
         RxjiZjDJox0OAGJvVLfphrpZQCptGeCRiqcpuHzSgO5sQPr7HarqxpMAlaNNwAI5J+qE
         6Gfsygpts8Q6NPO7oZK0IGVPgohjdE48jOnvaaSocSv7abALT+c0a0CqlqUWYeA00Pf7
         u8L+nfS6aLgh2wXSta5AUcNba95nn6yFJypB1/4fIkkSaXSWl91KoygshnCdZpgH1soW
         FH+sUiqk1UtZ9KvOR9QoIT8qWN0zscOBAq9UhY8JbdeCF3B1s8h0vosCm+5NnSyTBIj0
         8NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4EDmUrri+2NsQ7mgU5C2uQstgGcmQxd++Qh1sKnG8xc=;
        b=X03kRFwx7S7PRCMwcCUXBsbfa5kh8vY/mYxo2qv3rm1xN99Wh7dIyjbL2L3Rug90jO
         o+spo2++gabFM1m5EIojod6VlkciMJJiJWy+VDcm5rK4gePD+yA0KOb+eKVKBGTDh/oj
         AURkK9oIS2z/GQsXC9/CeDHw8J1a/inHAoX72tF6Xf2Ip1LHNYLWcRvJAEDDcs6QK4CN
         pTtR6lx1tWrGbRT+VcgPcT47ggpKRBBkgscpCb414ZB3VM5RTgxIKOC+B74A5mROQnxV
         0i7d5BgOonTdpkC7AxxBPmeScdXx0YihwF2Tz0ds9yOQ1QpTbNtfmfI4wKmLprkgRoPt
         BWZw==
X-Gm-Message-State: AOAM5327HieBgl68uaums7v11gA8G9C1/q5kMgeIjziR7yDsIM+OXEUA
        bHn2xce++5Ohfv+WNc5DBYw=
X-Google-Smtp-Source: ABdhPJzG7fKfiRbowz3hufeiUKO41rwZSu2BDHITDxeBDuJVkeVmBH9O0wjymEiQ0N066EVzGxPrcQ==
X-Received: by 2002:a9d:17d0:: with SMTP id j74mr8136389otj.92.1625430526890;
        Sun, 04 Jul 2021 13:28:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m16sm1898011oom.44.2021.07.04.13.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 13:28:46 -0700 (PDT)
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
Message-ID: <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net>
Date:   Sun, 4 Jul 2021 13:28:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/21 12:04 PM, Linus Torvalds wrote:
> On Sun, Jul 4, 2021 at 11:54 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> No, I still see the same warning, with the same traceback. I did make sure
>> that the code is executed by adding a printk in front of it.
> 
> And that printk() hits before the WARN_ON_ONCE() hits?
> 

Yes:

[    8.604785] Run /init as init process
[    8.604933] ##################### calling force_uaccess_begin()
[    8.609691] ------------[ cut here ]------------
[    8.609795] WARNING: CPU: 0 PID: 1 at lib/iov_iter.c:468 iov_iter_init+0x35/0x58
[    8.609979] CPU: 0 PID: 1 Comm: init Not tainted 5.13.0-09608-g678b12cd4025-dirty #1

Either case, the code doesn't do anything, because force_uaccess_begin() is
already called. With more added debugging:

##################### calling force_uaccess_begin()
############## force_uaccess_begin(), called from run_init_process+0x80/0x8c
############## force_uaccess_begin(), called from load_flat_binary+0x10e/0x92a

> Funky. That sounds to me like something is then doing
> set_fs(KERNEL_DS) again later, but it's also possible that I've been
> dropped on my head a few too many times as a young child, and am
> missing something completely obvious.
> 
> Can somebody put me out of my misery and say "Oh, Linus, please take
> your meds - you're missing xyz..."
> 

Turns out that, at least on m68k/nommu, USER_DS and KERNEL_DS are the same.

#define USER_DS         MAKE_MM_SEG(TASK_SIZE)
#define KERNEL_DS       MAKE_MM_SEG(0xFFFFFFFF)

and:

#define TASK_SIZE       (0xFFFFFFFFUL)

I didn't check mps2, but I strongly suspect the same is true there.

Guenter
