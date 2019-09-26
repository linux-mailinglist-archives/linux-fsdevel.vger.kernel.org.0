Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E765BF350
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfIZMsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 08:48:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37970 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfIZMsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:48:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id l21so1876936edr.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2VnRhKwH3b0fhHEO74HP3xgpX73GansXAOq8z6A9H18=;
        b=fEPLxIgBFxs7CUZNOVvWNDz/tvzzu14guUuPM4VTtRcfOArY0I0sz3Yb5nWsUplYc2
         OnojhKubNYaHltvC0QZ2eBnUZRq8uC1pHsO2ayO+tA2FtTElDJtAmsLP5bBSQXgHiIri
         ZmnSwP30sHkGyPPXtAgC1PRi3fMP9EdQTtGqkQftR0N2LnpL4mOscIuuAKp7uiZxRb9S
         H3MZsXBxVYNJvyUfTQeZBaEmPXIsZ6FvFtWvhh0m+UGgxKEmgXtw47A70flTiCI/MFwa
         Vu4zSfLcBWar+7ybQkiA1iEEiH/QFDQT18M7QnZyNP/nC6CyM1P4P4xGAb/+u6dtSraF
         zwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2VnRhKwH3b0fhHEO74HP3xgpX73GansXAOq8z6A9H18=;
        b=VkoK96vT6w+4aCPdd2DIDXk8+Z+sFuEbmWffeEMwiMbXd8NJmwQAU5mK5q4nAZj6sw
         NF07q2akHYz1KR/MeUTAXiY/UeP0qGh5dgBTO5XpwrumOmqvaRVr4B3whOrNe/5P2Lh3
         H2FMj+R/jJUlr1cSn34mTwpLBSkvyUahoF8GaatStlBYkmhqiFGwB4gMWtHThL0Hb7Je
         dh5+SCwy1UsQvnT3H1NTJhUOiyOigYIaaKqFIAyBfpQeEJ7KFCDwXjeFlfq18/jxmOWa
         +b5q4wbQKdYuJC02qijWYTN/oiZaAymNR/fJei53mRXTN2TdBYfmQvLpz90I8BhY0r2X
         uvCQ==
X-Gm-Message-State: APjAAAUl8JUfA9hNFwBjwS10yPIITO9VK+Sp68U8zMCb0Em0OYu3iIjm
        gSRb3bIgIDVejS5iqv6aOug=
X-Google-Smtp-Source: APXvYqzNbyT4AabjsgXf9dtPGsx1Hdb0UnOddg7oPj20icWFD8ASUmpX4t3cjqQFzuAanLYp3wrvSQ==
X-Received: by 2002:a50:918d:: with SMTP id g13mr3410845eda.64.1569502095856;
        Thu, 26 Sep 2019 05:48:15 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.gmail.com with ESMTPSA id g8sm453971edm.82.2019.09.26.05.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 05:48:15 -0700 (PDT)
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190926020725.19601-1-boazh@netapp.com>
 <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <e66f4a0a-c88f-67a8-a785-d618aa79be44@gmail.com>
Date:   Thu, 26 Sep 2019 15:48:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/09/2019 10:11, Miklos Szeredi wrote:
> On Thu, Sep 26, 2019 at 4:08 AM Boaz Harrosh <boaz@plexistor.com> wrote:
> 
> Just a heads up, that I have achieved similar results with a prototype
> using the unmodified fuse protocol.  This prototype was built with
> ideas taken from zufs (percpu/lockless, mmaped dev, single syscall per
> op).

>  I found a big scheduler scalability bottleneck that is caused by
> update of mm->cpu_bitmap at context switch.   This can be worked
> around by using shared memory instead of shared page tables, which is
> a bit of a pain, but it does prove the point.  Thought about fixing
> the cpu_bitmap cacheline pingpong, but didn't really get anywhere.
> 

I'm not sure what is the scalability bottleneck you are seeing above.
With zufs I have a very good scalability, almost flat up to the
number of CPUs, and/or the limit of the memory bandwith if I'm accessing
pmem.

I do have a bad scalability bottleneck if I use mmap of pages caused
by the call to zap_vma_ptes. Which is why I invented the NIO way.
(Inspired by you)

Once you send me the git URL I will have a look in the code and see if
I can find any differences.

That said I do believe that a new Scheduler object that completely
bypasses the scheduler and just relinquishes its time slice to the
switched to thread, will cut off another 0.5u from the single thread
latency. (5th patch talks about that)

> Are you interested in comparing zufs with the scalable fuse prototype?
>  If so, I'll push the code into a public repo with some instructions,
> 
> Thanks,
> Miklos
> 

Miklos would you please have some bandwith to review my code? it would
make me very happy and calm. Your input is very valuable to me.

Thanks
Boaz
