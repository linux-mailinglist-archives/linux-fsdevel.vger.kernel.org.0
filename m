Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEB18B965
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgCSObI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 10:31:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34363 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgCSObH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:31:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id 10so1952749qtp.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRSQwj1UAGfFwFNmHluoDtjjlKsZS6P7Rnz6LpsU95A=;
        b=SGIMX3xHO84a004q/8VkTuoMsggJuvBD/A86+Wrv4Mx0tgVtSuPjzWiXEaN6Bn5A/T
         mhqZuHlelAFqHD344f+dp3W3OXBw2enGfraRIOrLUnRmUFyD9YRuwYnPentZsckbWEVY
         UjCXcbuYWNoDspHpGdf1ofausJcngrFvLZUJdgLmo7FRgn0+IuMgVLmxYJ8qBMtBAXTW
         FsXX/qtGVT5W8Be8ffdP1UA6HwSt107yzqEtexbmcBWZ+cNGz0k00eHhBE8+gPhFAjBJ
         gJ4IfjvDLPIaxehBiYmAPQWvpFS19gwvEkh1vEZTmyG+K/20jNuENlLbOnF2+cSF+JHW
         gNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRSQwj1UAGfFwFNmHluoDtjjlKsZS6P7Rnz6LpsU95A=;
        b=XG9ytRsXLX60NiyTQ4fnmnDuzWYDAxsjUQmAsVslG4MRXqvE0AEK29v/KhYAaxpxgr
         UHjz5JnROTK+wQWZ6gsT4ne3rlrfqCi1B5zSvLyXj6+YvE87ZULG3oMowzdaKpeu+9Da
         1TD2ubw8XCohxwoeuMXQUQLyl0bDTHqY4h0zo+lDhay6EuRc6Jx9iskpH0BK/9M6u7iC
         ovKDHp86zK81FmiuFCilBsFmX+mJijeojtjIYels3OxWTGYqBjyJcJAtxfMiG6l97tfp
         stKNss9u0nssdl5AxIF9YXMtFIfQcZoUY9vQwwfKmKSb3IYhzu4tuth9eERj+4iILAaC
         iYKw==
X-Gm-Message-State: ANhLgQ0AKXEhZIH499hGEfV9OdhTIJW80YmWmFZ1XsVgjGBD5qAkTiti
        6qcJp6CxFRmyRaq96omIk/7DIC9g
X-Google-Smtp-Source: ADFU+vuz+JajNyDzvlFJSq2zZNG5rNyxGSMccLcMGESj4RT4NteSECL7k1rp9JDXOopOGtlPP713Mw==
X-Received: by 2002:ac8:4cdc:: with SMTP id l28mr3212774qtv.248.1584628266764;
        Thu, 19 Mar 2020 07:31:06 -0700 (PDT)
Received: from localhost.localdomain ([198.52.167.216])
        by smtp.gmail.com with ESMTPSA id l22sm1670368qkj.120.2020.03.19.07.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:31:06 -0700 (PDT)
Subject: Re: [PATCH] staging: exfat: Fix checkpatch.pl camelcase issues
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     valdis.kletnieks@vt.edu, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org
References: <20200319140647.3926-1-aravind.pub@gmail.com>
 <20200319141243.GA30888@kroah.com>
From:   Aravind Ceyardass <aravind.pub@gmail.com>
Message-ID: <1fed9204-59fb-8a1e-5adf-28183b3651e4@gmail.com>
Date:   Thu, 19 Mar 2020 10:31:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200319141243.GA30888@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/19/20 10:12 AM, Greg KH wrote:
> On Thu, Mar 19, 2020 at 10:06:47AM -0400, Aravind Ceyardass wrote:
>> Fix ffsCamelCase function names and mixed case enums
>>
>> Signed-off-by: Aravind Ceyardass <aravind.pub@gmail.com>
>> ---
>>  drivers/staging/exfat/TODO          |   1 -
>>  drivers/staging/exfat/exfat.h       |  12 +-
>>  drivers/staging/exfat/exfat_super.c | 222 ++++++++++++++--------------
>>  3 files changed, 117 insertions(+), 118 deletions(-)
> 
> These files are not in linux-next, or in my tree, anymore.
> 
> Please always work against the latest development tree so you do not
> waste duplicated effort.
> 
> thanks,
> 
> greg k-h
> 

As a very beginner, I used the staging(git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git) tree based on what I read on kernelnewbies.org

What tree or branch should I use instead?

Thanks

Aravind
