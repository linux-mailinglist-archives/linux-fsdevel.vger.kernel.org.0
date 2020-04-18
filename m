Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41F51AF2DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgDRR0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgDRR0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:26:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780FC061A0F
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 10:26:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b8so2739847pfp.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OMU4gc4xJrsz9oC2mAccr/thZgznAgM1yG5wcPECHkg=;
        b=hGVK77kM162LwI61a0prF7TRDY3sTb+b5wvtpmeTOvBZSjhXTZ4KtYe+4KIMRdV7i7
         sATr30xlpwsSy5LoneFDQ5Lm4qNwy1XZPOpsYs7AdIdCkSILl9o/eKhblnMatJ/DQ099
         6O0bWbR+0j5NV+t/XiLqUMrAO+Rybib+2O03c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OMU4gc4xJrsz9oC2mAccr/thZgznAgM1yG5wcPECHkg=;
        b=Ol4mTKbj8F/ytqe9s6chEpkTQO3O2gyQlvnpQI4APKCTW5Q0XfMTwnfkBMjFZk4D1k
         dePt+7+jJGSyr5Z0lhHLXGWGj6YK4lr10aJ7c9VTkMGTnsPTqIw3YZ49p5SFD8xdpoQ4
         nEgYXteIyrBTeqVmsrYjY3lV/Nr3ybmRbyoLA8q/Y+q8PdVQePUF936RCuc08XBX+Zna
         tctpJvOTeC8JhhKcVQ11BdUBlE8fi9D5akyt9pqwyeWH8/DssUJVBlAHTrOoS0r5cwha
         aHzLvFr/D2K4MVP8Gfn0LUlq0iVdfHC+WJxA9IPPQcugDWsoRvBXSsYeadQQYURiOqXP
         s53w==
X-Gm-Message-State: AGi0PuaxnhthSBjgh2E5+j0RyA8foyNM7fCzA5N5ooc+Zq1tiDEJQevx
        OKetPALirK/j7s5QtXtERiWcfQ==
X-Google-Smtp-Source: APiQypI6VuVoh62mvFQq+xqE0yByeQ09p8pjSnT53bNRHnXhxn5ZoHPk2hUCiKeRmM+zA4cvz4Ls8Q==
X-Received: by 2002:a62:d086:: with SMTP id p128mr9463319pfg.241.1587230762967;
        Sat, 18 Apr 2020 10:26:02 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u13sm9211650pjb.45.2020.04.18.10.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 10:26:02 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Dan Carpenter <dan.carpenter@oracle.com>
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
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <20200220104321.GX7838@kadam>
 <63c9dcda-7a31-78a7-1d11-9d9af38add46@broadcom.com>
 <20200418114516.GE12862@kadam> <20200418114725.GF12862@kadam>
Message-ID: <c781505e-5bbd-a259-4c2d-4481db3fabde@broadcom.com>
Date:   Sat, 18 Apr 2020 10:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418114725.GF12862@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Dan, I'll send out new version as soon as my other patch (you had 
requested for test_fx mutex cleanups)
https://lore.kernel.org/linux-arm-msm/20200415002517.4328-1-scott.branden@broadcom.com/

hits the linux-next tree so this patch series will apply cleanly to 
linux-next.




On 2020-04-18 4:47 a.m., Dan Carpenter wrote:
> On Sat, Apr 18, 2020 at 02:45:16PM +0300, Dan Carpenter wrote:
>> On Fri, Apr 17, 2020 at 02:49:11PM -0700, Scott Branden wrote:
>>>>> +static int bcm_vk_dma_alloc(struct device *dev,
>>>>> +			    struct bcm_vk_dma *dma,
>>>>> +			    int direction,
>>>>> +			    struct _vk_data *vkdata)
>>>>> +{
>>>>> +	dma_addr_t addr, sg_addr;
>>>>> +	int err;
>>>>> +	int i;
>>>>> +	int offset;
>>>>> +	uint32_t size;
>>>>> +	uint32_t remaining_size;
>>>>> +	uint32_t transfer_size;
>>>>> +	uint64_t data;
>>>>> +	unsigned long first, last;
>>>>> +	struct _vk_data *sgdata;
>>>>> +
>>>>> +	/* Get 64-bit user address */
>>>>> +	data = get_unaligned(&(vkdata->address));
>>>> Extra parens.
>>> removed
>>>>> +
>>>>> +	/* offset into first page */
>>>>> +	offset = offset_in_page(data);
>>>>> +
>>>>> +	/* Calculate number of pages */
>>>>> +	first = (data & PAGE_MASK) >> PAGE_SHIFT;
>>>>> +	last  = ((data + vkdata->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
>>>>> +	dma->nr_pages = last - first + 1;
>>>>> +
>>>>> +	/* Allocate DMA pages */
>>>>> +	dma->pages = kmalloc_array(dma->nr_pages,
>>>>> +				   sizeof(struct page *),
>>>>> +				   GFP_KERNEL);
>>>>> +	if (dma->pages == NULL)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	dev_dbg(dev, "Alloc DMA Pages [0x%llx+0x%x => %d pages]\n",
>>>>> +		data, vkdata->size, dma->nr_pages);
>>>>> +
>>>>> +	dma->direction = direction;
>>>>> +
>>>>> +	/* Get user pages into memory */
>>>>> +	err = get_user_pages_fast(data & PAGE_MASK,
>>>>> +				  dma->nr_pages,
>>>>> +				  direction == DMA_FROM_DEVICE,
>>>>> +				  dma->pages);
>>>>> +	if (err != dma->nr_pages) {
>>>>> +		dma->nr_pages = (err >= 0) ? err : 0;
>>>>> +		dev_err(dev, "get_user_pages_fast, err=%d [%d]\n",
>>>>> +			err, dma->nr_pages);
>>>>> +		return err < 0 ? err : -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	/* Max size of sg list is 1 per mapped page + fields at start */
>>>>> +	dma->sglen = (dma->nr_pages * sizeof(*sgdata)) +
>>>>> +		     (sizeof(uint32_t) * SGLIST_VKDATA_START);
>>>>> +
>>>>> +	/* Allocate sglist */
>>>>> +	dma->sglist = dma_alloc_coherent(dev,
>>>>> +					 dma->sglen,
>>>>> +					 &dma->handle,
>>>>> +					 GFP_KERNEL);
>>>> 	dma->sglist = dma_alloc_coherent(dev, dma->sglen, &dma->handle,
>>>> 					 GFP_KERNEL);
>>> done
>>>>
>>>>> +	if (!dma->sglist)
>>>>> +		return -ENOMEM;
>>>> No cleanup?
>>> what needs to be cleaned up?
>> dma->pages should be freed probably?  And a put_user_pages_fast()?
> Sorry put_user_pages_fast() isn't a function.  My bad.
>
> regards,
> dan carpenter

