Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0930217E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 06:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgGHEaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 00:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgGHEaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:30:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CCBC08C5E3
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 21:30:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so1486139wmf.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 21:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9z8AqNAtfLqJboxfTSuy4+9Gg/kN9QYsVqfQLWbeo4w=;
        b=gwkq4+Hlakm3izkfm3Vx8ZZCM5LOzO3cymjOSh4+vM8T7cBwdjsaTUVd9kq/x6E+Nh
         LNC4usHx3RpnjI9YfPVuOYlIHMxSq1nB5UkuqJzdB3PaMh+PFXIlNStED6a1DCPIfivL
         ZGphzvNanNKVijraSFJb+UugoBCX9/HxIAv7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9z8AqNAtfLqJboxfTSuy4+9Gg/kN9QYsVqfQLWbeo4w=;
        b=eqHh/8Aq0fKydRDgqfhyqOCCRHwrjAtfzCYG4CGveVH435zVsQ6RPISoLu/iyEjGJF
         m/iuPdY86DzIc1u093hKHj0wKM318yH+AycqLAcLuysgBwp/uZJzNdeX/RZzvQPiKUKx
         o+Pzzur9aFP6Lfq+cm5kSgDe3cv/u3GP3ZlrL46xSJ5qAIUvPllyz9p7A+YZLDHRyFVb
         NS3B91oELM6VmkCgi3OB7ZPyynm6hWYNVlfVTxk/MmnC/hN0VXI9Bmw2E4GtYA0g+Mtu
         cODffMR7MwuyhllZirlX/Fvt3thyRl7dCzzturHU8gsnehv7skwKuK7wPayR3pe9unmJ
         3mYQ==
X-Gm-Message-State: AOAM531MsNHvQdhdOhC+Gr3AlGzPniRkvLoEMP2W9np4J4qAeG1RhdRq
        3soMFQNNLs6NOzzPpAEtjr0UaQ==
X-Google-Smtp-Source: ABdhPJxz1HCKFHKGJAHeBxv2ayO0myaozG6pLXUA04b6prEWm0Cz5Rezi42VTrPu7hajJjMaPp0QIA==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr7627559wmj.160.1594182637061;
        Tue, 07 Jul 2020 21:30:37 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q1sm3577207wro.82.2020.07.07.21.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:30:36 -0700 (PDT)
Subject: Re: [PATCH v10 7/9] misc: bcm-vk: add Broadcom VK driver
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-8-scott.branden@broadcom.com>
 <202007071700.C567BA7B@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <400ebe0d-6b04-a211-7d80-cc8b0bf4d7df@broadcom.com>
Date:   Tue, 7 Jul 2020 21:30:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071700.C567BA7B@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-07-07 5:03 p.m., Kees Cook wrote:
> On Mon, Jul 06, 2020 at 04:23:07PM -0700, Scott Branden wrote:
>> Add Broadcom VK driver offload engine.
>> This driver interfaces to the VK PCIe offload engine to perform
>> should offload functions as video transcoding on multiple streams
>> in parallel.  VK device is booted from files loaded using
>> request_firmware_into_buf mechanism.  After booted card status is updated
>> and messages can then be sent to the card.
>> Such messages contain scatter gather list of addresses
>> to pull data from the host to perform operations on.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> nit: your S-o-b chain doesn't make sense (I would expect you at the end
> since you're sending it and showing as the Author). Is it Co-developed-by?
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
Yes, Co-developed-by.  Will adjust.
>
>> [...]
>> +
>> +		max_buf = SZ_4M;
>> +		bufp = dma_alloc_coherent(dev,
>> +					  max_buf,
>> +					  &boot_dma_addr, GFP_KERNEL);
>> +		if (!bufp) {
>> +			dev_err(dev, "Error allocating 0x%zx\n", max_buf);
>> +			ret = -ENOMEM;
>> +			goto err_buf_out;
>> +		}
>> +
>> +		bcm_vk_buf_notify(vk, bufp, boot_dma_addr, max_buf);
>> +	} else {
>> +		dev_err(dev, "Error invalid image type 0x%x\n", load_type);
>> +		ret = -EINVAL;
>> +		goto err_buf_out;
>> +	}
>> +
>> +	ret = request_partial_firmware_into_buf(&fw, filename, dev,
>> +						bufp, max_buf, 0);
> Unless I don't understand what's happening here, this needs to be
> reordered if you're going to keep Mimi happy and disallow the device
> being able to see the firmware before it has been verified. (i.e. please
> load the firmware before mapping DMA across the buffer.)
I don't understand your concern here.  We request partial firmware into 
a buffer that we allocated.
After loading it we signal the card the firmware has been loaded into 
that memory region.
The card then pulls the data into its internal memory.  And, 
authenticates it.

Even if the card randomly read and writes to that buffer it shouldn't 
matter to the linux kernel security subsystem.
It passed the security check already when placed in the buffer.
If there is a concern could we add an "nosecurity" 
request_partial_firmware_into_buf instead as there is no need for any 
security on this particular request?

