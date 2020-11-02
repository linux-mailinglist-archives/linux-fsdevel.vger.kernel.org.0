Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2502A2DFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 16:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgKBPTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 10:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKBPTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:19:33 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8E2C061A47
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 07:19:32 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id j12so650012iow.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=49FGBKLX9bjRkUIwwFYH04GGaHdzd9ual/GUV3gPQsU=;
        b=Z9YjdCoMGxgXi8OKp7mMzKofIUTxG3aaghQ4KuqjZoIQ60iQ+0AYAk4pbEYrkhQcas
         bXSwZ/8q078axG1lyreFsisJspjsS8TaRGqNXNQzwEyl2zQ0hcXbeC4QQnY2CU4Jn4SF
         MGC76YUNUkvOpZG75zKiBAZK+WsXAlkA8TBxVoDjDHVqpX2iqoZX7JcTODvb0zWJcOfP
         0LIWCB0MuKEE/QXc9CEMOFBc/cHAywmV5m5N3iYb0UR2TyM5uCt12h13ufNOHTaJ3IAw
         iGYTFgGQBsQDt08aCfCpvOjMZ2QdexJOMXveQliBvzaI7dQKYNGn7CM663YM2Py0oVRc
         IZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=49FGBKLX9bjRkUIwwFYH04GGaHdzd9ual/GUV3gPQsU=;
        b=djS5OgS90AZJrxUi3oz2pjmoyf2xgArOzILgqYoQ8aW7M9KNYV3sEvpbWyA5EJWQBa
         BGhaxSJ8hYa8O3EzBjwdEb0n2a2A+xZuM/JU1X2ZhSonpTaEUEf68tkGab1edjBiT+Fj
         aalwd5HLGxFbWFRh/3z8j8GJ9+1w6vPVjqwMxmaVspY+4bJ9Q2n6z7wgGRGvc74I2qMo
         4l2Zac0XB9VDDYf5hjs/turouLCZmrqUbwuIL8Wu+a53zo2rRzjcGYVFYuiCi60OBTPI
         zunWahf+xiTWBjzbKUnUq0uUHnwjxFYRKkbXGz2ovGRWwL0G8ynhMYx/FjoIkO+BOOra
         lt3w==
X-Gm-Message-State: AOAM532wZmW2Jlfph4ySEegTL/L1n0MUWVm4fCHqi8YvfOoFqh/z2Kx/
        ze/vc7z5QpPZyvKiWZPF45+y6Q==
X-Google-Smtp-Source: ABdhPJxpku+l31t6D5PSG3BnC/0CVXqaptAeWUb/56zYbW0Bbd3pGxC590t1qtuOaZ58Q1B35gotfw==
X-Received: by 2002:a6b:6806:: with SMTP id d6mr10963958ioc.54.1604330371135;
        Mon, 02 Nov 2020 07:19:31 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t16sm10775048ilh.76.2020.11.02.07.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 07:19:30 -0800 (PST)
Subject: Re: KASAN: null-ptr-deref Write in kthread_use_mm
To:     syzbot <syzbot+b57abf7ee60829090495@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
References: <00000000000008604f05b31e6867@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <298f1180-ab14-d08e-dcd2-3e4bbbc1e90a@kernel.dk>
Date:   Mon, 2 Nov 2020 08:19:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000008604f05b31e6867@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/20 4:54 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4e78c578 Add linux-next specific files for 20201030
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=148969d4500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
> dashboard link: https://syzkaller.appspot.com/bug?extid=b57abf7ee60829090495
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e1346c500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1388fbca500000
> 
> The issue was bisected to:
> 
> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Oct 2 09:04:21 2020 +0000
> 
>     lockdep: Fix lockdep recursion

That bisection definitely isn't correct. But I'll take a look at the issue.

-- 
Jens Axboe

