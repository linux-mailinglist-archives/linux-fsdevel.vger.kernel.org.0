Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEA26320F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgIIQei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 12:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgIIQcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:32:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27654C06135F
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 07:05:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so3213848iod.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1GNvQaJVVbJaa5hqastQ4V9UWSsrJ3TzEQOTc6YZGA0=;
        b=Wz131WDagK/Rxky/VsKTxm9iJtyF3lZsrhvUt6kH/ULppLy487y62HkZGYeM1pXKOZ
         DeQ8y3Q16GCVRKCyngWbLjZIjWc72QhidG0e5bcZSKpjLE09P3yHLmATe3Z+FpCFgcTQ
         W2/C/2AzVGHUu6cHHEPWt6mkn5ZNMcG4xCvMcuGt+NA0M9fQHvWeaRORq0/VJy00UBFW
         SVuEXZBNl1PaMP21xD5W8PtNgRJ4ghTKDdVbnJzTuhHM+YiLMWOFq46dlbALB9SQ435V
         /wamSrkHIbLha24honWVVkDwyaCkp0a1caYMHllncnc93uHxavoJRQhw5/gkMF+A5Q2G
         wUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GNvQaJVVbJaa5hqastQ4V9UWSsrJ3TzEQOTc6YZGA0=;
        b=lxXbkGV6unPz0bP8RzYPjQxi0jj2g0I6FzTPlTibDPDdTAk6TkmE7e6piN64sbuqz6
         FPi/GpeqZvjA8/UOs6EjLzc5cLSagu4oTt3vRPrUsz4dSal4LI9PFCf/Nb9JwDsk2mgP
         kzhhkr3CY8amP1AYkAaHXZl+Nuz2juaO76P/whX4IiIEYrAlBeY9rieM9YUQ1jhwOLVU
         PQLW+DnBg6ffd4Ny43Zh0m2QGEcaIij0wJC0a4qvLGrc+DrQyCSGaw/bOVWSoUlqFRVp
         kmJGVnMqpJOG6/ACKAjyxVg7Smkd0zi/jqcdL8jXalvIMCdSsMhLbMyQFgiz81Kni6GY
         D2wQ==
X-Gm-Message-State: AOAM533jWECZOXzzIHhTxNmcjoivvNtpMb/2DX+MnHLVbh1I9t2KHVLp
        iDdQ5OFmAeJgK7D5cf8b98JrUw==
X-Google-Smtp-Source: ABdhPJxR0dWjX+LAG42vqffCSj6/FEsKntR0oewD/D0VWfxuQhn1DExXR02/p7rg4pZ6AeBZyQoUdQ==
X-Received: by 2002:a02:cb99:: with SMTP id u25mr3965325jap.99.1599660335262;
        Wed, 09 Sep 2020 07:05:35 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m15sm1464546ild.8.2020.09.09.07.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:05:34 -0700 (PDT)
Subject: Re: INFO: task hung in io_sq_thread_stop
To:     Hillf Danton <hdanton@sina.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     syzbot <syzbot+3c23789ea938faaef049@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000030a45905aedd879d@google.com>
 <20200909134317.19732-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d55d988-d45e-ba36-fed7-342e0a6ab16e@kernel.dk>
Date:   Wed, 9 Sep 2020 08:05:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909134317.19732-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/20 7:43 AM, Hillf Danton wrote:
> 
> On Wed, 9 Sep 2020 12:03:55 +0200 Stefano Garzarella wrote:
>> On Wed, Sep 09, 2020 at 01:49:22AM -0700, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    dff9f829 Add linux-next specific files for 20200908
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=112f880d900000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3c23789ea938faaef049
>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c082a5900000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1474f5f9900000
>>>
>>> Bisection is inconclusive: the first bad commit could be any of:
>>>
>>> d730b1a2 io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
>>> 7ec3d1dd io_uring: allow disabling rings during the creation
>>
>> I'm not sure it is related, but while rebasing I forgot to update the
>> right label in the error path.
>>
>> Since the check of ring state is after the increase of ctx refcount, we
>> need to decrease it jumping to 'out' label instead of 'out_fput':
> 
> I think we need to fix 6a7bb9ff5744 ("io_uring: remove need for
> sqd->ctx_lock in io_sq_thread()") because the syzbot report
> indicates the io_sq_thread has to wake up the kworker before
> scheduling, and in turn the kworker has the chance to unpark it.
> 
> Below is the minimum walkaround I can have because it can't
> ensure the parker will be waken in every case.
> 
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -6834,6 +6834,10 @@ static int io_sq_thread(void *data)
>  			io_sq_thread_drop_mm();
>  		}
>  
> +		if (kthread_should_park()) {
> +			/* wake up parker before scheduling */
> +			continue;
> +		}
>  		if (ret & SQT_SPIN) {
>  			io_run_task_work();
>  			cond_resched();
> 

I think this should go in the slow path:


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 652cc53432d4..1c4fa2a0fd82 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6839,6 +6839,8 @@ static int io_sq_thread(void *data)
 		} else if (ret == SQT_IDLE) {
 			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
 				io_ring_set_wakeup_flag(ctx);
+			if (kthread_should_park())
+				continue;
 			schedule();
 			start_jiffies = jiffies;
 		}

-- 
Jens Axboe

