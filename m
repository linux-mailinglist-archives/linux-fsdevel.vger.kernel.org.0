Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45091AAE42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416003AbgDOQ2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415992AbgDOQ23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:28:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB9C061A0F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 09:28:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so541294wrm.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=76FV3ox/3TPbATAAAJw9w7kb0H0TlBYb5fVvS13JcLY=;
        b=G/nt7PIUIjDbbyNK0gIoeOLcY8ZJ6ogrh7xIpJK5ptEMrpyqCvnEq1Gpc5ntN7Nohb
         FbLVbkv/SqyxTIKPSI8ArbB3aQC2cnsW7CNY285Nq6a2PjxHNIr/8pFYAG+7EVv0mbSo
         E9pam/kjTQC+Xto1u4FPAB7uQLe+D9C1L1s3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=76FV3ox/3TPbATAAAJw9w7kb0H0TlBYb5fVvS13JcLY=;
        b=AzdJIs2NJv0zn11H2V5OQs5Ent+wljHp/MozhzZUiM+qY0XrHq+M6/ac3AxjCc9G5H
         WcUlXLV4QVWYaD9bqrfXftcxhjr6UjZV9rrkO5rXMtpcYB78o5xgXCzo/bx1VLEAIiEl
         jDsGUga09ewpmvt2hdL0X0zfcf7Dz28zwgRNFU6I8Zh5Js++vVc2vbE/YFv6IPox/mrG
         j4GV7sY4VfXtRxtySdBq1OKu7ymwrCS5mGk06myocDOG98hEdd3pUNRJCSpRTk/zJhij
         MiQ8LKMdCv9PjoJBuO/tYCTZnbU27cPFb29GSs2ASGBtCIZS9OW6DJjnWwCgn2bzaG0h
         t6rA==
X-Gm-Message-State: AGi0Publa/Oi9dSYX2cWqmpP30h2bTjYudP+JSN7LyTbOtqkJztQcylg
        +KtvI9RIy12GlRsKaZ9TBcIEzg==
X-Google-Smtp-Source: APiQypKNypW8de1wzfd0hzKcNgFo6MjAP9f8TaX90Pu8qjLQ0NPRPLlzR/MtI88oH6r++vBFgaj4EQ==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr29365255wrw.414.1586968107226;
        Wed, 15 Apr 2020 09:28:27 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h2sm5682392wro.9.2020.04.15.09.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 09:28:26 -0700 (PDT)
Subject: Re: [PATCH] test_firmware: remove unnecessary test_fw_mutex in
 test_dev_config_show_xxx
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20200415002517.4328-1-scott.branden@broadcom.com>
 <202004142010.C0847F5@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <e2b95fde-0ab7-c0d1-2c64-cceffc458673@broadcom.com>
Date:   Wed, 15 Apr 2020 09:28:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202004142010.C0847F5@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

On 2020-04-14 8:10 p.m., Kees Cook wrote:
> On Tue, Apr 14, 2020 at 05:25:17PM -0700, Scott Branden wrote:
>> Remove unnecessary use of test_fw_mutex in test_dev_config_show_xxx
>> functions that show simple bool, int, and u8.
> I would expect at least a READ_ONCE(), yes?
I don't understand why you need a READ_ONCE when removing a mutex around 
an assignment
of a parameter passed into a function being assigned to a local variable.

Could you please explain your expectations.
>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   lib/test_firmware.c | 26 +++-----------------------
>>   1 file changed, 3 insertions(+), 23 deletions(-)
>>
>> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
>> index 0c7fbcf07ac5..9fee2b93a8d1 100644
>> --- a/lib/test_firmware.c
>> +++ b/lib/test_firmware.c
>> @@ -310,27 +310,13 @@ static int test_dev_config_update_bool(const char *buf, size_t size,
>>   	return ret;
>>   }
>>   
>> -static ssize_t
>> -test_dev_config_show_bool(char *buf,
>> -			  bool config)
>> +static ssize_t test_dev_config_show_bool(char *buf, bool val)
>>   {
>> -	bool val;
>> -
>> -	mutex_lock(&test_fw_mutex);
>> -	val = config;
>> -	mutex_unlock(&test_fw_mutex);
>> -
>>   	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>>   }
>>   
>> -static ssize_t test_dev_config_show_int(char *buf, int cfg)
>> +static ssize_t test_dev_config_show_int(char *buf, int val)
>>   {
>> -	int val;
>> -
>> -	mutex_lock(&test_fw_mutex);
>> -	val = cfg;
>> -	mutex_unlock(&test_fw_mutex);
>> -
>>   	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>>   }
>>   
>> @@ -354,14 +340,8 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
>>   	return size;
>>   }
>>   
>> -static ssize_t test_dev_config_show_u8(char *buf, u8 cfg)
>> +static ssize_t test_dev_config_show_u8(char *buf, u8 val)
>>   {
>> -	u8 val;
>> -
>> -	mutex_lock(&test_fw_mutex);
>> -	val = cfg;
>> -	mutex_unlock(&test_fw_mutex);
>> -
>>   	return snprintf(buf, PAGE_SIZE, "%u\n", val);
>>   }
>>   
>> -- 
>> 2.17.1
>>

