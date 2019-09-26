Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D92BF1E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfIZLla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 07:41:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41571 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfIZLl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:41:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so2070838wrw.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aH00KjkFtisP2+KHORZWfwfMApazoNp+1TkXkeu+hi0=;
        b=vGEkSnzXCyU/D87koYKKrS3HnZIWqOggNMHLWp1w4tq/9QLhiDcyMsHKOFWD9K95UM
         ZZXVJ3e0QiFTpC3c9B+JtHFlhT9eT0ukMDbCEZsS7Eakpg3mQgY+Mkjb8ERmy4JlJZc9
         CFyjuwRI2zbemFjWoYCv6ZQsuMoZQ0WPa6CUQUFwR1tTiAy9uO3V63Yfox8XGR7SV3Fv
         yUdon+s4NQteM1qMtxGMv/L5nOqALf7nPZM8ho/x/KF/qyRGsHoDCpmX0TPZ8L8zyXx1
         s9jJ7ZAjrY2RQGQa5O2UC2Y80REjxL9tpZ5VPIErKF9tiPVJvzxOLqHC48id4jmGP3XP
         ufig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aH00KjkFtisP2+KHORZWfwfMApazoNp+1TkXkeu+hi0=;
        b=hI2K7trFiqlnQHrkC03nC0nkUvCOMCIIRBCfLFfHS2RQm0QmYT3vL0vk9d9ruQGyER
         1hk9ZkU0yTSDvQ1ROc3OQD8rj4Z9hiUN4AZmQ5KL21HfLyrNterZf3+uZWNkTmapcwy3
         vDzOg0b49B4xI/Rvwfj0ggUtOEZYiEemHSkizPMQUsCnOfHGbxTz0uJrVxyVy6YjwaDq
         rq15tulXNyPIVlMCjzvp6UMaBEkUCIcC6XVfLdGajc5t4bjF1HBEHYJZYwbxZnLM7x0T
         aNsIdmNIrchkVZcRbDuAfxwWNO9pLFLAIUrsd2ysspoHYuUpmJmaZnXt81vF6mZzoWW8
         5mwg==
X-Gm-Message-State: APjAAAXG+NbLzsVSBZVOxbi0pQ6CI2YxLBoASBBoLsHFem3W6LW6cVyE
        pM5HP1SglTk1uxTcixWkprA+CQ==
X-Google-Smtp-Source: APXvYqz6n8KwfpMMrvWKcsyIo7AUy/VslRwhZ/Ar4jO7dYJZFLC3uidU/IzD2gFeFhSRpufia65QFA==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr2716499wrr.134.1569498087677;
        Thu, 26 Sep 2019 04:41:27 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id j26sm5804168wrd.2.2019.09.26.04.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:41:27 -0700 (PDT)
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
From:   Boaz Harrosh <boaz@plexistor.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190926020725.19601-1-boazh@netapp.com>
Message-ID: <aca0d951-1540-9fda-5a66-a59df9140997@plexistor.com>
Date:   Thu, 26 Sep 2019 14:41:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/09/2019 05:40, Matt Benjamin wrote:
> per discussion 2 weeks ago--is there a git repo or something that I can clone?
> 
> Matt
> 

Please look in the cover letter there is a git tree address to clone
here:

[v02]
   The patches submitted are at:
	git https://github.com/NetApp/zufs-zuf upstream-v02

Also the same for zus Server in user-mode + infra:
	git https://github.com/NetApp/zufs-zus upstream


Please look in the 3rd patch:
	[PATCH 03/16] zuf: Preliminary Documentation

There are instructions what to clone how to compile and install
and how to use the scripts in do-zu to run a system.
I would love a good review for this documentation as well 
I'm sure its wrong and missing. I use it for so long I'm already
blind to it.

Please bug me day and night with any question

Thanks
Boaz

