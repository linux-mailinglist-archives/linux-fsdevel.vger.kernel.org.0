Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4359E6A4FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 00:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB0XuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 18:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0XuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:50:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50E1CF78;
        Mon, 27 Feb 2023 15:50:16 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhnN-1obPHS29iL-00vhw5; Tue, 28
 Feb 2023 00:50:00 +0100
Message-ID: <3c843d9e-3813-dc02-160c-4a46ad47f941@gmx.com>
Date:   Tue, 28 Feb 2023 07:49:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
 <19732428-010d-582c-0aed-9dd09b11d403@gmx.com>
 <Y/yzS7aQ6PDyFsbm@biznet-home.integral.gnuweeb.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
In-Reply-To: <Y/yzS7aQ6PDyFsbm@biznet-home.integral.gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8U7vfGoppnHui+sb1hPoMVrAT9T7+PhUT+g8R09pRxR5vrU3RuK
 zs37SUa6sEvTLT2hiu+qrQ7GGRW9wWDC/T64jUNB/Z83BsTdfNjEz805ujmxc4kJl5T9Jyl
 fQpx3K5BaANta82BhfoKLBlQVhpqaZgIYKt2Jae7/DHD8kHqcwoXDH5QaPcJ6uFjL2vd/dc
 x3DAdPqP7eZI+m7i8fKEA==
UI-OutboundReport: notjunk:1;M01:P0:m6AqjQi+rdE=;Cd6yJ4f34yvH+hUmF7tn1wCCRvI
 WTqAynjVD06InRrwdBWQ7WBnqUOTWNc/YPAM4+4LR97PVViwcv+MyhsBzwCYUBoVpaWsEibyo
 P6DUMQoK3goleN1WNbmQbS+MEXdq6y7O/Jpi4rUOORKmhaVgXOb7Ka1UIj6wAkVDzmz4AllDs
 LEDKvU2YTGtDd5DswYBQskKhSUYU35P7Dq4IOJkD6SUlMEQYtz8qzM7s/54JSmGOntW57rQHt
 k15ehH6FNNo5Bf5KkZ509xd4bO5wiSbWfapnwddF2t2Iif2mRBTUqD76xk9EhMsoqOFTsJI/U
 JPoztMp2+bE4BLxAxhTEq/ttuXXirxjMy4dvXnNeRoB96k5D/f2vd5Tb0ZEkG07OK6lRH7Xvv
 9CYKFhll6tmCQ3k4U6tIHx+8MHWP/o1B1crMNnAeW+ZJjWR5EMAglljlAYxdfno77V5TMnfaq
 6wTyqfybhD8Pug3U7tW1aQd+m8udRfhn+yvfxrbNDH7NzFBidvK/i6+lSBWxJL70EQzOvzxww
 whxBo7wb9ZAyviZJ2Cz/ctIGxh1k6/0d5u6ewVvEWpzBL13EyWTNmsKCXIXrpf6GhIc5sadDL
 XNFRYW8ejAlhXJ220v19u2/ynutwAJG+WC67GH4LH/xNnSVzmwkqZhG1rBlw50kzynk5DoXnP
 9lXjvG2T23shfNz3O1MJQPOYo0aYKv2Hum9hmAAZq7jzwyEfL9SaVHjKVhV6PfHvv2pgPKddy
 +Z4r5uB6d/ku5rHZN+vqJvN2z5kj2cKMYe5NuMm5hDlJ7ORvPNLe9aw3pwLTEEoaP3vsp3DAH
 tGyyoN65HvVKiHy+8pvhvUXK4G2wq/Fs9WaMSPmSjeM07qsAQiYraLCFCwzW4tMc6mBzpNL8l
 MYH+lxbgQV7+R2TbZmET0zc/y5AAbBci6DJUcHgrkTrAQIVYz/bbYpl3u3cp6s3/tnwxe7e2E
 xo/yR88EDbt0KcK1QiT7C8aunN0=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/27 21:42, Ammar Faizi wrote:
> On Mon, Feb 27, 2023 at 06:18:43PM +0800, Qu Wenruo wrote:
>> I'm not sure if pinning the wq is really the best way to your problem.
>>
>> Yes, I understand you want to limit the CPU usage of btrfs workqueues, but
>> have you tried "thread_pool=" mount option?
>>
>> That mount option should limit the max amount of in-flight work items, thus
>> at least limit the CPU usage.
> 
> I have tried to use the thread_poll=%u mount option previously. But I
> didn't observe the effect intensively. I'll try to play with this option
> more and see if it can yield the desired behavior.

The thread_pool mount option is much harder to observe the behavior change.

As wq pinned to one or two CPUs is easy to observe using htop, while the 
unbounded wq, even with thread_pool, is much harder to observe.

Thus it needs more systematic testing to find the difference.

> 
>> For the wq CPU pinning part, I'm not sure if it's really needed, although
>> it's known CPU pinning can affect some performance characteristics.
> 
> What I like about CPU pinning is that we can dedicate CPUs for specific
> workloads so it won't cause scheduling noise to the app we've dedicated
> other CPUs for.
> 

I'm not 100% sure if we're really any better than the scheduler 
developers, as there are a lot of more things to consider.

E.g. for recent Intel CPUs, they have BIG and little cores, and BIG 
cores even have SMT supports.
For current kernels, scheduler would avoid putting workloads into the 
threads sharing the same physical cores.

Thus it can result seemingly weird priority like BIG core thread1 > 
little core > BIG core thread2.
But that results overall better performance.

So overall, unless necessary I'd avoid manual CPU pinning.

Thanks,
Qu
