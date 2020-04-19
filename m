Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3721AFA79
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 15:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDSNW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSNW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:22:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C97C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 06:22:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so8650161wma.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kVPLEzVj+SyYn7U1KT5IDDYQi+CmyYT6y4S8EZ60q5o=;
        b=FDFQSlsj3m4BZk19CV5wPE56REMYM1NpqmteQGLxWe1lMyglp+lFr1y6hzycmAq9Vc
         oxMO1A+osJ1Rnn6QT5pJ9nKo77+MUXA5lNy5Ch4tSvz4b/648knKSWDJHqV0m0W9a6od
         1W9fb1sgphxoAjPLSVWv7GF9Yeosfqa2uk0dDQ4SCAKdPNkmg+UVHERFK5dg1L+s8rqV
         NuOVInhnEoWsLS0j0OAH91Mu/p3L2K1xIAw4AtuXBG8Yd9umlk9B+YVNeseS5VkTPDsH
         2RPM1HDex6os4cPmjS/L/BvjvqEbe/Ynsr2Wt5AQqoslXYAaDLZxgtM+zy6KBK3t20UZ
         rEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kVPLEzVj+SyYn7U1KT5IDDYQi+CmyYT6y4S8EZ60q5o=;
        b=WYk4BPnIoHYO1ZpuMk4/xHlbhNhz0wcDWHGg7OlJolSZDs3gmRQxydTi2q+xW/qPsg
         ZWZktHiOi4XsTSrfv0yDg480HH6lPGFdSDgXIT0irndOIrr8MJtYz4+CBI4Otfl1TetQ
         Z2bEqiuryzVZT33K8KgQjXofKnaZ8UR2QwrPmVnrBwyFuL7fcwSXCUtHCYFcVUwR12P2
         S8YGhGqCuzUua3UGutJ48oIUJK8UBwx0qhLRCj0Bm8f4vPC06K0iTiYbpVXGn7/PoMGa
         60s5SdOX5rd6KMxkzGswqjWhnlgUCTMOmbsmawwvGnT+fHHs4qqkPEeYdPVUwwM8gfai
         m1Xw==
X-Gm-Message-State: AGi0PubRJFMjjso4c5fJ133nwbfBvziLNn9bQYQBQTT+uxq2XZuUlHRu
        gHw5UnuuOr4mXF+yHBjSH602BDxzpn8=
X-Google-Smtp-Source: APiQypIeCsTpBfB++hIY6OUcHqDcwvmyHl5gCG+X3k0e4PTGrjd1vaCoGCPydQDqXAGL720ywujWGw==
X-Received: by 2002:a1c:e444:: with SMTP id b65mr13296874wmh.6.1587302576122;
        Sun, 19 Apr 2020 06:22:56 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2? ([2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id m14sm38376737wrs.76.2020.04.19.06.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 06:22:55 -0700 (PDT)
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
To:     Gao Xiang <hsiangkao@aol.com>, Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
 <20200419051404.GA30986@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b4ee932c-09a8-f934-6909-ee5eece8bb27@cloud.ionos.com>
Date:   Sun, 19 Apr 2020 15:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200419051404.GA30986@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.04.20 07:14, Gao Xiang wrote:
> On Sat, Apr 18, 2020 at 08:14:43PM -0700, Matthew Wilcox wrote:
>> On Sun, Apr 19, 2020 at 12:51:18AM +0200, Guoqing Jiang wrote:
>>> When reading md code, I find md-bitmap.c copies __clear_page_buffers from
>>> buffer.c, and after more search, seems there are some places in fs could
>>> use this function directly. So this patchset tries to export the function
>>> and use it to cleanup code.
>> OK, I see why you did this, but there are a couple of problems with it.
>>
>> One is just a sequencing problem; between exporting __clear_page_buffers()
>> and removing it from the md code, the md code won't build.
>>
>> More seriously, most of this code has nothing to do with buffers.  It
>> uses page->private for its own purposes.
>>
>> What I would do instead is add:
>>
>> clear_page_private(struct page *page)
>> {
>> 	ClearPagePrivate(page);
>> 	set_page_private(page, 0);
>> 	put_page(page);
>> }
>>
>> to include/linux/mm.h, then convert all callers of __clear_page_buffers()
>> to call that instead.
> Agreed with the new naming (__clear_page_buffers is confusing), that is not
> only for initial use buffer head, but a generic convention for all unlocked
> PagePrivate pages (such migration & reclaim paths indicate that).
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mm.h?h=v5.7-rc1#n990

Thanks for the link, and will rename the function to clear_page_private.

Thanks,
Guoqing


