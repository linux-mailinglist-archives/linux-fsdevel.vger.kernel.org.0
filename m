Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0727F2AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 21:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgI3Tit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 15:38:49 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:35408 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgI3Tit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:38:49 -0400
X-Greylist: delayed 1335 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 15:38:49 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id E7E171F5E278
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 14:16:25 -0500 (CDT)
Received: from gator3309.hostgator.com ([192.254.250.173])
        by cmsmtp with SMTP
        id NhaTk10vZLFNkNhaTk88sA; Wed, 30 Sep 2020 14:16:25 -0500
X-Authority-Reason: nr=8
Received: from [96.232.34.132] (port=57125 helo=[192.168.1.133])
        by gator3309.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <trapexit@spawn.link>)
        id 1kNhaR-0037nu-VB; Wed, 30 Sep 2020 14:16:24 -0500
Subject: Re: [PATCH V9 2/4] fuse: Trace daemon creds
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200924131318.2654747-1-balsini@android.com>
 <20200924131318.2654747-3-balsini@android.com>
 <CAJfpegvvf4MfO4Jw5A=TJJfrxN_1xFTmwBJ2bb9UfzYBgkhzzQ@mail.gmail.com>
From:   Antonio SJ Musumeci <trapexit@spawn.link>
Message-ID: <a5d94f04-a980-ee3f-bd8d-42df3a859777@spawn.link>
Date:   Wed, 30 Sep 2020 15:16:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvvf4MfO4Jw5A=TJJfrxN_1xFTmwBJ2bb9UfzYBgkhzzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3309.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spawn.link
X-BWhitelist: no
X-Source-IP: 96.232.34.132
X-Source-L: No
X-Exim-ID: 1kNhaR-0037nu-VB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.133]) [96.232.34.132]:57125
X-Source-Auth: trapexit@spawn.link
X-Email-Count: 16
X-Source-Cap: YmlsZTtiaWxlO2dhdG9yMzMwOS5ob3N0Z2F0b3IuY29t
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/30/2020 2:45 PM, Miklos Szeredi wrote:
> On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
>> Add a reference to the FUSE daemon credentials, so that they can be used to
>> temporarily raise the user credentials when accessing lower file system
>> files in passthrough.
> Hmm, I think it would be better to store the creds of the ioctl()
> caller together with the open file.   The mounter may deliberately
> have different privileges from the process doing the actual I/O.
>
> Thanks,
> Miklos


In my usecase I'm changing euid/egid of the thread to whichever the 
uid/gid was passed to the server which is otherwise running as root.

