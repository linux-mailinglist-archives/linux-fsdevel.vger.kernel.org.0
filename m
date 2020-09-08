Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234AC26084F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 04:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgIHCNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 22:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgIHCMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 22:12:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00169C0617B1
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2020 19:12:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gf14so7211185pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2020 19:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VT+c1JX9b+efMdSYA4R6Y766uhFYT3cDPfGCzggz0J8=;
        b=g6YsK0WuK+oZ171JtlQZqlwFQAhZoJC0HW48UE510AZdST5F4peoTOGXed0o+Burl3
         9STQLZVO3BedcZJUzISApfSSEVyBP/0eQIW5wP/ij9T/3bVl3LbucjP2XUoWVCGq35YY
         80iPsyEuKLycdv9lWudeizI+mMAATqdTXnkSKH3SICwcCKr7tAdKRohJrGwzAVCbClP6
         BiC7ysJ1qJn02fTYqy9A/QTt7RdcwrOyzba3Kc6rNLr5YcWoBY7AEzUucecKmv+c767n
         2Vx6K3LK9eWnblqe+6zHLR6jeCSMDw0Z4rIZgLPLvwtJWrRn3X4tICcmVky/yImpWIeZ
         kKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VT+c1JX9b+efMdSYA4R6Y766uhFYT3cDPfGCzggz0J8=;
        b=SQeLWbDLZnLB5rQeMlpJkuHmW7qq0zNwYF96hugklq1c8DbDP60gWqT/llXXEQGvWN
         gnHvnEOvixrhuXGCFL9omeLxICNfhYRJ2qqLTdDRjXSTO17u1Et2wRrpJegWZvm44rBW
         P5bK/whBDeCqc85gXhu0cGgwCKjWjHP2Ls+GwkH6T3nLx8OsN28vAKmuKbG/YQf8CXAO
         1bQKUuR8pfD2ab4pfb7guLEz++r0nLBzIiG8KIT6SA6LtVREzHTyMAjf5WvzZCMvuevJ
         6RB6sw+nPRm+SUTYOqn7v5rlYhtNTjSPv63/otlgJ+/ItDqy8aS+X3T4kLS9qlpKcFfw
         99wg==
X-Gm-Message-State: AOAM533hxU5fOcDd0fY3Cmf1WQ4Ch1WcmWtJ2WazjskHz3uhowE/fOp7
        Qf6kNybawOpzyZB4T9WpoiQTkg==
X-Google-Smtp-Source: ABdhPJxftDEYLTH/L4dCqlWpSz4vVGfCxRtfkMsrTeiQkJC5wwxXMBVd1dpWj7/e6UWZZG+13+k8Yg==
X-Received: by 2002:a17:90a:19dc:: with SMTP id 28mr1806828pjj.103.1599531129539;
        Mon, 07 Sep 2020 19:12:09 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y16sm13527221pjr.40.2020.09.07.19.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 19:12:08 -0700 (PDT)
Subject: Re: [PATCH] fs: align IOCB_* flags with RWF_* flags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>
References: <95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk>
 <20200907201516.GC27537@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33762071-da92-9e63-639d-8afc0e65dcc7@kernel.dk>
Date:   Mon, 7 Sep 2020 20:12:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907201516.GC27537@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/7/20 2:15 PM, Matthew Wilcox wrote:
> On Mon, Aug 31, 2020 at 12:08:10PM -0600, Jens Axboe wrote:
>> We have a set of flags that are shared between the two and inherired
>> in kiocb_set_rw_flags(), but we check and set these individually.
>> Reorder the IOCB flags so that the bottom part of the space is synced
>> with the RWF flag space, and then we can do them all in one mask and
>> set operation.
>>
>> The only exception is RWF_SYNC, which needs to mark IOCB_SYNC and
>> IOCB_DSYNC. Do that one separately.
>>
>> This shaves 15 bytes of text from kiocb_set_rw_flags() for me.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Added

-- 
Jens Axboe

