Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD1D1FFC33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 22:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgFRUEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 16:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgFRUEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:04:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3127C0613EE
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 13:04:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so7388800wrr.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I1X5PgsyDNPZk5OWUMSkw5d9tqtI+lNZgxN4Rtom3J4=;
        b=2Gdw9yRpfZxYdJPIxo9vBo6m73ZCsO3/13tXY2w0ZeHHFdt4gSwy/htURFqSmKf4WG
         Vcu9QN/YTZ8yD20PpRBi2W1z9zQBycqw9+em7uYgosUj77O6ve0zOSJs284LnMXdtYhn
         raSPvaaJmx6EOie8eiwOIaUwDTyRibfq+uyl0nMTuqAj04owC7YOwYJQGxu9i0SnmkzT
         2VCWv0KyTnidlmyeG4wxlx3uYNHsIuFDXcCpRD0+tr2hg6Yjg8u33PjfrIqzNiZyCkoI
         oX5Mi2IywJXrc9KfaI9U+c895gh2SuZBZcFsJfzIBvxwGQrR4BHtcFQVeNUFXa81ZQ34
         hG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I1X5PgsyDNPZk5OWUMSkw5d9tqtI+lNZgxN4Rtom3J4=;
        b=kpt9E7AYDt8r5ZsYsf4J4uwMVI/q559Y5IXQds3IJUlWVq1l1gOmrMM/sMftR33tQP
         27fNhyZMQc5TI3nIkNYvQC6jANFI3FUZ26A0G5WhvRtmcgpkocfBLVNtrX+kIaxPDQed
         l/E1kxm3sE2BuF4wpnhyEXulpcK+IWnzyUG+7aJYRB1eoUARL0H+mapNKmFei0C/yYvr
         jCILaSV2mSGFPiYzoXcebYweJ2rleFeppCHbvSQRQMq0YJS3R6JeTgb9uuP4J+Lf+H3i
         S7FvcrGE69eATp71N7abGos3bToIAWQ1GOqTmjxyAWCE3S/MEHsF/ugKJLzssLubLca9
         /71g==
X-Gm-Message-State: AOAM533B2ial+RaNjS2wt4I8PYcnaETDHgEFjIowrMdhAhNcSc3I13lG
        4SQCkN4e0WjYz+60mx/ypFMSmg==
X-Google-Smtp-Source: ABdhPJxevHzd88MB3BtvBcSHFDfduqy63NdjLXzwRNfLfbeBHu+X/bIxcZVe6+j+aB1WA/b3mWH6NQ==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr206028wrr.96.1592510670761;
        Thu, 18 Jun 2020 13:04:30 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id e2sm2750197wrt.76.2020.06.18.13.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 13:04:30 -0700 (PDT)
Subject: Re: [PATCH 0/3] zone-append support in aio and io-uring
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, javier.gonz@samsung.com,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <keith.busch@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <CGME20200617172653epcas5p488de50090415eb802e62acc0e23d8812@epcas5p4.samsung.com>
 <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <f503c488-fa00-4fe2-1ceb-7093ea429e45@lightnvm.io>
 <20200618192153.GA4141485@test-zns>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <12a630ce-599b-3877-8079-10b319b55d45@lightnvm.io>
Date:   Thu, 18 Jun 2020 22:04:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618192153.GA4141485@test-zns>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/06/2020 21.21, Kanchan Joshi wrote:
> On Thu, Jun 18, 2020 at 10:04:32AM +0200, Matias Bjørling wrote:
>> On 17/06/2020 19.23, Kanchan Joshi wrote:
>>> This patchset enables issuing zone-append using aio and io-uring 
>>> direct-io interface.
>>>
>>> For aio, this introduces opcode IOCB_CMD_ZONE_APPEND. Application 
>>> uses start LBA
>>> of the zone to issue append. On completion 'res2' field is used to 
>>> return
>>> zone-relative offset.
>>>
>>> For io-uring, this introduces three opcodes: 
>>> IORING_OP_ZONE_APPEND/APPENDV/APPENDV_FIXED.
>>> Since io_uring does not have aio-like res2, cqe->flags are 
>>> repurposed to return zone-relative offset
>>
>> Please provide a pointers to applications that are updated and ready 
>> to take advantage of zone append.
>>
>> I do not believe it's beneficial at this point to change the libaio 
>> API, applications that would want to use this API, should anyway 
>> switch to use io_uring.
>>
>> Please also note that applications and libraries that want to take 
>> advantage of zone append, can already use the zonefs file-system, as 
>> it will use the zone append command when applicable.
>
> AFAIK, zonefs uses append while serving synchronous I/O. And append bio
> is waited upon synchronously. That maybe serving some purpose I do
> not know currently. But it seems applications using zonefs file
> abstraction will get benefitted if they could use the append 
> themselves to
> carry the I/O, asynchronously.
Yep, please see Christoph's comment regarding adding the support to zonefs.


