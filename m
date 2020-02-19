Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F108164274
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 11:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBSKn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 05:43:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35730 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgBSKn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:43:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so76412wmb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uu178h4Sn9VpLsAwrPceV0KSap9/ps5hFk6MJzLCOtU=;
        b=02bdATzxAmoFVgM99p2MGiOluR4xHHNS4c5NfrSi5BxO4RkYbZ3BBjd1lob/gTFE92
         nWHXI33K66qyD+N6M8F+E3140V4WAGc4yJzS9ZHjUEc6UlCzJbBvcs2R9HgVIFm8qxEc
         WaSoY4g4ZJ6vsivGbNfVQ1tMkz+VkFnfFspX0Z0B4vZvx9IYUJTVztOINVubutus35Qs
         09Ci8IJE0V/r5OFWfFLh9GjgKLL08p6UjQnc0OYtYEK1u8vsICytra8wXW+0FfK/utAh
         /YWf8djFy29yAMuz6eDs3EQfZVIRpoffMgSUzReLi4Qaswtnv6vCecBFIQHyIP3RfTK8
         CqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=uu178h4Sn9VpLsAwrPceV0KSap9/ps5hFk6MJzLCOtU=;
        b=AlDW0nApkZklf/v34bomKbndadf67chvLrDmLjUDJZ52SOP0yLz7gicg5J2MLF9H64
         H+t6J9NO/hLTofFK/Bvgs2EiDJ6kWlUczTQbEj7/5Q7jpwOJ8zys6O5rrHGHZB2HV+l1
         DVMFtHL7ZMns7xMdy25Ifq5RiKDwTVw7xYcBcbfOpH4g8KLrKWQrh2MiJ4aiv8pvuZnb
         JiEP3TXwRi77fRjrjBJXRbMZzRxthk3pBNK8O17zodmrJCxDZEPZfq7SoySb8v/0IKWE
         fm/lpN9Z4pPoEPqa4kL4ZyWy+Ntyx/AJEjCEAzFGlZyKjmQDYua0pcIrCKCs2xq6mk1U
         84SQ==
X-Gm-Message-State: APjAAAWguXizU9JgTDpuFDUdFX67LknoTl7azb/zQICZ4XGfzvQxVop7
        LGvD7JUAZ2kISofwQ0AZO6Xa9A==
X-Google-Smtp-Source: APXvYqyGKqyBbQFNU7n7BCFc+gH0YF3RVTIAFIrc3i0FwABXFz2+PyclndFMVuYMcYfqybMtUM4iXA==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr9217850wml.116.1582109034556;
        Wed, 19 Feb 2020 02:43:54 -0800 (PST)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id h2sm2547507wrt.45.2020.02.19.02.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 02:43:53 -0800 (PST)
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200129172010.162215-1-stefanha@redhat.com>
 <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
 <20200212102912.GA464050@stefanha-x1.localdomain>
 <156cb709-282a-ddb6-6f34-82b4bb211f73@redhat.com>
 <cadb4320-4717-1a41-dfb5-bb782fd0a5da@scylladb.com>
 <20200219103704.GA1076032@stefanha-x1.localdomain>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <c5ea733d-b766-041b-30b9-a9a9b5167462@scylladb.com>
Date:   Wed, 19 Feb 2020 12:43:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219103704.GA1076032@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/02/2020 12.37, Stefan Hajnoczi wrote:
> On Wed, Feb 12, 2020 at 12:54:30PM +0200, Avi Kivity wrote:
>> On 12/02/2020 12.47, Paolo Bonzini wrote:
>>> On 12/02/20 11:29, Stefan Hajnoczi wrote:
>>>> On Wed, Feb 12, 2020 at 09:31:32AM +0100, Paolo Bonzini wrote:
>>>>> On 29/01/20 18:20, Stefan Hajnoczi wrote:
>>>>>> +	/* Semaphore semantics don't make sense when autoreset is enabled */
>>>>>> +	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>> I think they do, you just want to subtract 1 instead of setting the
>>>>> count to 0.  This way, writing 1 would be the post operation on the
>>>>> semaphore, while poll() would be the wait operation.
>>>> True!  Then EFD_AUTORESET is not a fitting name.  EFD_AUTOREAD or
>>>> EFD_POLL_READS?
>>> Avi's suggestion also makes sense.  Switching the event loop from poll()
>>> to IORING_OP_POLL_ADD would be good on its own, and then you could make
>>> it use IORING_OP_READV for eventfds.
>>>
>>> In QEMU parlance, perhaps you need a different abstraction than
>>> EventNotifier (let's call it WakeupNotifier) which would also use
>>> eventfd but it would provide a smaller API.  Thanks to the smaller API,
>>> it would not need EFD_NONBLOCK, unlike the regular EventNotifier, and it
>>> could either set up a poll() handler calling read(), or use
>>> IORING_OP_READV when io_uring is in use.
>>>
>> Just to be clear, for best performance don't use IORING_OP_POLL_ADD, just
>> IORING_OP_READ. That's what you say in the second paragraph but the first
>> can be misleading.


Actually it turns out that current uring OP_READ throws the work into a 
workqueue. Jens is fixing that now.


> Thanks, that's a nice idea!  I already have experimental io_uring fd
> monitoring code written for QEMU and will extend it to use IORING_OP_READ.


Note linux-aio can do IOCB_CMD_POLL, starting with 4.19.


