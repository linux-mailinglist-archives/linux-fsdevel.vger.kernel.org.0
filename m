Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8DF2F9710
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbhARBDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 20:03:06 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:39357 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbhARBAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:00:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610931628; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=W0TJ8/n2INVwFiJw8glTp0w73GvcGCa4UXpVcoAlADo=; b=sSsQ+VhyPvaFng4lA/KQQ2/TToiThqXsL6dsyt+v9l8VXw5vY1C5V3ifK5n8ieJ+ivsiGI7K
 hBQxJHEfAYnRN6BumPrXwGQWWa99/HQd7LNZL+pPYzwpNIHjJ8D2BpPtTgo59zt8Zn84AxVT
 46zSacVKDk9WRNm0E7ycCZAZ6V4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6004dd8b859d74370d9e66f0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 00:59:55
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA9E2C43463; Mon, 18 Jan 2021 00:59:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.10] (cpe-75-83-25-192.socal.res.rr.com [75.83.25.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95F0DC433ED;
        Mon, 18 Jan 2021 00:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95F0DC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sidgup@codeaurora.org
Subject: Re: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mcgrof@kernel.org, rafael@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>
References: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
 <X/QJCgoLPhfECEmP@kroah.com>
 <180bdfaf-8c84-6946-b46f-3729d4eb17cc@codeaurora.org>
 <X/WSA7nmsUSrpsfr@kroah.com>
 <62583aaa-d557-8c9a-5959-52c9efad1fe3@codeaurora.org>
 <X/hv634I9JOoHZRk@kroah.com>
 <1adf9aa4-ed7e-8f05-a354-57419d61ec18@codeaurora.org>
 <YAHAzW1cVSaMzBYj@kroah.com>
From:   Siddharth Gupta <sidgup@codeaurora.org>
Message-ID: <be2ae542-b543-173d-d256-b4203aad7756@codeaurora.org>
Date:   Sun, 17 Jan 2021 16:59:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAHAzW1cVSaMzBYj@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/15/2021 8:20 AM, Greg KH wrote:
> On Tue, Jan 12, 2021 at 10:31:26AM -0800, Siddharth Gupta wrote:
>> On 1/8/2021 6:44 AM, Greg KH wrote:
>>> On Thu, Jan 07, 2021 at 02:03:47PM -0800, Siddharth Gupta wrote:
>>>> On 1/6/2021 2:33 AM, Greg KH wrote:
>>>>>>>> Since the binary attributes don't support splice_{read,write} functions the
>>>>>>>> calls to splice_{read,write} used the default kernel_{read,write} functions.
>>>>>>>> With the above change this results in an -EINVAL return from
>>>>>>>> do_splice_from[4].
>>>>>>>>
>>>>>>>> This essentially means that sendfile will not work for any binary attribute
>>>>>>>> in the sysfs.
>>>>>>> Have you tried fixing this with a patch much like what we did for the
>>>>>>> proc files that needed this?  If not, can you?
>>>>>> I am not aware of this fix, could you provide me a link for reference? I
>>>>>> will try it out.
>>>>> Look at the series of commits starting at fe33850ff798 ("proc: wire up
>>>>> generic_file_splice_read for iter ops") for how this was fixed in procfs
>>>>> as an example of what also needs to be done for binary sysfs files.
>>>> I tried to follow these fixes, but I am unfamiliar with fs code. I don't see
>>>> the generic_file_splice_write function anymore on newer kernels, also AFAICT
>>>> kernfs_ops does not define {read,write}_iter operations. If the solution is
>>>> simple and someone could provide the patches I would be happy to test them
>>>> out. If not, some more information about how to proceed would be nice.
>>> Can you try this tiny patch out below?
>> Sorry for the delay, I tried out the patch, but I am still seeing the error.
>> Please take a look at these logs with
>> android running in the userspace[1]:
>>
>> [   62.295056][  T249] remoteproc remoteproc1: powering up
>> xxxxxxxx.remoteproc-cdsp
>> [   62.304138][  T249] remoteproc remoteproc1: Direct firmware load for
>> cdsp.mdt failed with error -2
>> [   62.312976][  T249] remoteproc remoteproc1: Falling back to sysfs
>> fallback for: cdsp.mdt
>> [   62.469748][  T394] ueventd: firmware: loading 'cdsp.mdt' for '/devices/platform/soc/xxxxxxxx.remoteproc-cdsp/remoteproc/remoteproc1/cdsp.mdt'
>> [   62.498700][  T394] ueventd: firmware: sendfile failed { '/sys/devices/platform/soc/xxxxxxxx.remoteproc-cdsp/remoteproc/remoteproc1/cdsp.mdt',
>> 'cdsp.mdt' }: Invalid argument
>>
>> Thanks,
>> Sid
>>
>> [1]: https://android.googlesource.com/platform/system/core/+/refs/heads/master/init/firmware_handler.cpp#57
> Thanks for letting me know.  I'll try to work on this on Monday and add
> splice to the in-kernel firmware testing suite, as it would have caught
> this...
If my understanding is correct these default (or generic if you prefer)
functions require the write_iter[1] and read_iter[2] file ops to be 
defined for
kernfs_file_fops. Are there any similar default {write,read}_iter 
functions that
I can use, or do these need to be thin wrappers for the read function[3] 
for bin
attributes itself?

Thanks,
Sid

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/splice.c#n686
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/splice.c#n311
[3]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/sysfs/file.c#n235
> greg k-h
