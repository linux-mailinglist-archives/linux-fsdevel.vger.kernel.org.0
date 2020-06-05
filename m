Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8A1F0322
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 00:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgFEW4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 18:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgFEW4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:56:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B91C08C5C4
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 15:56:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 185so5822217pgb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w94Y30Zj7mgg0jm3gA8QPbDqP4Kye5MwiIglsO9uWtI=;
        b=SoCIgu/Xz1pn45ICdQTezePAt9VI+dO5XYvTbmNXVHOiE53+A6rPMVa213jkfsJ39a
         LyAXUdrHq6iqzCkT0bk0V2J/7eqrlk4LIyLaFMAMPDCqFtbFlBA4wAbmnsWF03+49az8
         O9yFCNlzsb14ItloIGFVUj6RvfIJ7elammovrwF54k25auCB8yOEaC9KbD/o00k0+/Fr
         tmG00Y/BDUgsGMOIfM+V6qI2tBNv4b23G693sbHw+5o7VjwFm6MM1Vq2e2haMuTlYvV/
         3bXNwBgK/K5qMfdhIK13E6QarityB6y61tyDmarToflyM+MxcMXqfqbtMiD01DL6MG7z
         88pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w94Y30Zj7mgg0jm3gA8QPbDqP4Kye5MwiIglsO9uWtI=;
        b=NAZ4JtKYXyqmaq8OVEh2gNQ3Dj6alkxg9qS14j7wC0eqngCWXyfcXBhUG0wjtudIRx
         vZg+RxluaDE/E/+XUCsjuPJJgptPAhjlyaEjhsgo53LS5ILoHhPf83cB6zQYa2ZqaQOQ
         G1NHZLGnPMJzGO4GTPz3kH83JHVXD44l3dwG6qC5sFIDyWQIgziTUOimUPPVi7zDls+/
         wOt+1NiiW8mPcmV2Ox2X9nZKKuXCyj3MMUJsMWX0+2ioZnHbuy4tAxDWqTHITL56XKK2
         vnCN35WD9NHR8xBLJCzj7ynYx75FEh319lAigYpQiQDoVBxaV+WdNkts5yMYvXHDuf9N
         YBZQ==
X-Gm-Message-State: AOAM533x/fVvwQvWvgPBeHoDXEF/QgvqZQZ9lYdwIEiYnT3ciJtfXjkk
        oQHPmYAWfE4ssAyZirn4OMKRDPjm01LE2w==
X-Google-Smtp-Source: ABdhPJyXn5aY8Y2tU9anpymJoYRaxBGnHkDmaAx5qvJihVgks3VcY0U1PnX9FQlhvvu5VSdM/4sagQ==
X-Received: by 2002:a62:4e8a:: with SMTP id c132mr11145162pfb.22.1591397806892;
        Fri, 05 Jun 2020 15:56:46 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q65sm581373pfc.155.2020.06.05.15.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:56:46 -0700 (PDT)
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
To:     Andres Freund <andres@anarazel.de>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <e3072371-1d6b-8ae5-d946-d83e60427cb0@kernel.dk>
 <6eeff14f-befc-a5cc-08da-cb77f811fbdf@kernel.dk>
 <20200605202028.d57nklzpeolukni7@alap3.anarazel.de>
 <20200605203613.ogfilu2edcsfpme4@alap3.anarazel.de>
 <75bfe993-008d-71ce-7637-369f130bd984@kernel.dk>
 <3539a454-5321-0bdc-b59c-06f60cc64b56@kernel.dk>
 <34aadc75-5b8a-331e-e149-45e1547b543e@kernel.dk>
 <20200605223044.tnh7qsox7zg5uk53@alap3.anarazel.de>
 <20200605223635.6xesl7u4lxszvico@alap3.anarazel.de>
 <0e5b7a2d-eb0e-16e6-cc9f-c2ca5fe8cb92@kernel.dk>
 <20200605225429.s424lrrqhaseoa2h@alap3.anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0179d0bf-0b01-3f05-9221-654a00f0452d@kernel.dk>
Date:   Fri, 5 Jun 2020 16:56:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605225429.s424lrrqhaseoa2h@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/5/20 4:54 PM, Andres Freund wrote:
> Hi,
> 
> On 2020-06-05 16:49:24 -0600, Jens Axboe wrote:
>> Yes that's expected, if we have to fallback to ->readpage(), then it'll
>> go to a worker. read-ahead is what drives the async nature of it, as we
>> issue the range (plus more, depending on RA window) as read-ahead for
>> the normal read, then wait for it.
> 
> But I assume async would still work for files with POSIX_FADV_RANDOM
> set, or not? Assuming the system wide setting isn't zero, of course.

Yes it'll work if FADV_RANDOM is set. But just not if read-ahead is
totally disabled. I guess we could make that work too, though not sure
that it's super important.

-- 
Jens Axboe

