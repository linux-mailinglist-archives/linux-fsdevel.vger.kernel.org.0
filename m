Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4418E891E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfHKNnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 09:43:06 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34485 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKNnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 09:43:06 -0400
Received: by mail-wm1-f42.google.com with SMTP id e8so8942618wme.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2019 06:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sThP27C+JLJpIzlpTKvRGiH66PCeBABm6QQBTJ2oWtc=;
        b=TNtIOfU5rtrQECkUpzmLvrzHNTKuFr0SZI9fD9lTI/5gKH0yQRLYlVJV43FdF0Xspg
         FAOf6A8KBOosMQFryECfyEasXYKRswCliWLyvM/COU7oW6s4KeIb+a3sZfyW7oqE1cOQ
         4nwdxIdUKDrtLOE6SZupw0pcSejQ9ueG56s/ACraFZnRAuq3pDxIDTcDlYeecVo4XOfH
         Yibn93W4M4l2v1whWZzlv0tBm1+vsWfieAL0HJnF4jlHpcWeggDdqD8MTijrnt7P74vR
         LoOs6hYL8aYyWkFxL/PNVx3StvQkwqSWBFu9yasOmQO0yjXC12o0NN4zIsu/kEzgUwaY
         jF2w==
X-Gm-Message-State: APjAAAUZne7QbezIIz2jx5LnMHNxV3nwG6zV1w9Zi0FLhrRVLDcHMI8y
        ggVOMNMt4AR0YPZXZ4xJX3wDd36nXY8=
X-Google-Smtp-Source: APXvYqzdsOr9ZEpIYC2tyXgZGSQQAn2Dm3JLSfA17toTi9JYysADDkyPMsxGXOHnNPIZdyQcbKVJbQ==
X-Received: by 2002:a7b:c415:: with SMTP id k21mr9374266wmi.135.1565530983957;
        Sun, 11 Aug 2019 06:43:03 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id e11sm7515860wrc.4.2019.08.11.06.43.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:43:03 -0700 (PDT)
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com> <20190811074348.GA13485@infradead.org>
 <20190811075042.GA6308@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <56acdce2-b9b2-b078-b1cd-3f025e63a435@redhat.com>
Date:   Sun, 11 Aug 2019 15:43:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811075042.GA6308@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 8/11/19 9:50 AM, Greg Kroah-Hartman wrote:
> On Sun, Aug 11, 2019 at 12:43:48AM -0700, Christoph Hellwig wrote:
>> On Sun, Aug 11, 2019 at 09:40:05AM +0200, Greg Kroah-Hartman wrote:
>>>> Since I do not see the lack of reviewing capacity problem get solved
>>>> anytime soon, I was wondering if you are ok with putting the code
>>>> in drivers/staging/vboxsf for now, until someone can review it and ack it
>>>> for moving over to sf/vboxsf ?
>>>
>>> I have no objection to that if the vfs developers do not mind.
>>
>> We had really bad experiences with fs code in staging.  I think it is
>> a bad idea that should not be repeated.
> 
> Lustre was a mistake.  erofs is better in that there are active
> developers working to get it out of staging.  We would also need that
> here for this to be successful.
> 
> Hans, is it just review that is keeping this from being merged or is
> there "real work" that has to be done?

AFAIK it is just the reveiw which is keeping this from being merged.

During the first few revision Al Viro made some very good suggestions
which have all been addressed, v10 was reviewed by David Howell, and the
main thing to fix for that was switching over to the new mountfd APIs,
v11 was also revieded by David and had some minor issues with the use
of the new mountfd APIs. Those were all addressed for v12. So currently
the TODO list for this fs code is empty.

Regards,

Hans
