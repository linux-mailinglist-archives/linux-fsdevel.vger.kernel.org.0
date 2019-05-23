Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B903A283FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfEWQlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:41:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47059 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfEWQlx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:41:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id r18so2962886pls.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QxLlMcpZF4s6oYuMc8pgq9hIU3JxTkHMlIXFqr7xT6c=;
        b=FVFxuVHQtP/UwFTrvUUdg8Mu0s5/ZUDGf2daY9CljgY4Zl/eofCrRMJ/MAnm6ezoIT
         rplSNc3PXLwYrNvnWuPWkQZ5arZ0V7jHonRDY6SAjRiwCNQvdK66+Qx80NtPSj+hwrxd
         +XksfxQqaFKOl0koZkqKitzGyEXCiDMNCw6xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QxLlMcpZF4s6oYuMc8pgq9hIU3JxTkHMlIXFqr7xT6c=;
        b=CoP7TOpqE0P4QQybHAL6anGk7WdzBUKZe04c1zWe1GdwcmHMAW+kqlxjKV5Q9ir8aG
         MM1gf6d7w4Pzq9W9gQb6wAAc5EvIZaiXw6ROqZ4Hxm0jSEOZ8mo21I3o5Z3+ouPSIZmb
         sZ5s3CH/dyNaysHWpx8WqxJHWYx9nnsqrtIelTfOyawS6VWR7LNigR+x4jYP7I0Yu24z
         wP08DF6gWvOnOo6nAYIXWvk537KNoOMPes2QHZLVOpuK2w9dx9bg3TsJn6Ul0dinSOYK
         xD8Atl54dBWRSJLXxiP7TSnp7piKLne7067ftHi3VSDNZaCNYWVatKo4MFtigjVR5rly
         HGfA==
X-Gm-Message-State: APjAAAWOCCBYrry5+ssbMslte+ad6bS49BbwT6ngJRbx0tb358c5VyQr
        AiTPFZvhHls+RjduP7UbOvkVqA==
X-Google-Smtp-Source: APXvYqz2ENEwFpcm+GtlaHW4ZEFkpatXoMtMl+mKUtN4o5Gt+iMf9QqM+Xlm6MebmUhMNU4q6gQbGA==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr98713790plr.245.1558629712674;
        Thu, 23 May 2019 09:41:52 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g9sm27282487pgs.78.2019.05.23.09.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 09:41:51 -0700 (PDT)
Subject: Re: [PATCH 3/3] soc: qcom: mdt_loader: add offset to
 request_firmware_into_buf
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-4-scott.branden@broadcom.com>
 <20190523055212.GA22946@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <c12872f5-4dc3-9bc4-f89b-27037dc0b6ff@broadcom.com>
Date:   Thu, 23 May 2019 09:41:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523055212.GA22946@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
> On Wed, May 22, 2019 at 07:51:13PM -0700, Scott Branden wrote:
>> Adjust request_firmware_into_buf API to allow for portions
>> of firmware file to be read into a buffer.  mdt_loader still
>> retricts request fo whole file read into buffer.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/soc/qcom/mdt_loader.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
>> index 1c488024c698..ad20d159699c 100644
>> --- a/drivers/soc/qcom/mdt_loader.c
>> +++ b/drivers/soc/qcom/mdt_loader.c
>> @@ -172,8 +172,11 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>   
>>   		if (phdr->p_filesz) {
>>   			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
>> -			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
>> -							ptr, phdr->p_filesz);
>> +			ret = request_firmware_into_buf
>> +						(&seg_fw, fw_name, dev,
>> +						 ptr, phdr->p_filesz,
>> +						 0,
>> +						 KERNEL_PREAD_FLAG_WHOLE);
> So, all that work in the first 2 patches for no real change at all?  Why
> are these changes even needed?

The first two patches allow partial read of files into memory.

Existing kernel drivers haven't need such functionality so, yes, there 
should be no real change

with first two patches other than adding such partial file read support.

We have a new driver in development which needs partial read of files 
supported in the kernel.

>
> And didn't you break this driver in patch 2/3?  You can't fix it up
> later here, you need to also resolve that in the 2nd patch.

I thought the driver changes needs to be in a different patch. If 
required I can squash this

driver change in with the request_firmware_into_buf change.

But the 2nd patch won't work without the 1st patch either.

So that would mean you now want all 3 patches for different subsystems 
squashed together?

Please let me know how you would like the patch series submitted.

>
> thanks,
>
> greg k-h

Regards,

  Scott

