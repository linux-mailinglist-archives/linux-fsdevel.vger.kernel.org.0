Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AEB43542A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhJTT4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhJTT4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:56:52 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D1C061749
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 12:54:38 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id x1so23399207ilv.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SXEBqjlrNeQLC3cCdFvWFBZcm6c8pSFlJ+Ev3n10SV4=;
        b=gYBXhN15vb3aLXFPFXG/+r2AqV8CelHvxQ+j5SKHUXkDb7ASKNRZIEhjYM00SccleP
         WJ56IlGahOFFftScI3zF51a3Nq4gPglpsBwUj5IY5K6gq1b5SRH7vKzRS7p00ys9l/nQ
         KPKKC4SjKpmq7a/e7LtO0cYt+pJAFj7WQG4mC023Eeeqp/dzBbDkMrjfrNeIvh8IIGwQ
         geT8kLM+HwFwmb2j6tHsrQI5I5uFmqGxNqVAvbhFRP3d9Q3JB3zp15cQ8Lpf04Asd87q
         cBHITdnN1ebz704g2JunpK/A+9bMza0I8TihJC/st7GP4ALkjaTQUcdE276pR1W+qEZf
         JQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXEBqjlrNeQLC3cCdFvWFBZcm6c8pSFlJ+Ev3n10SV4=;
        b=W5h+zjUlK1D1yYM/wIaM+UP373ZfhZXcrrLN9BBaPptRTs42fY2JynI/JqbL74oQU5
         5iMRpbQH8O92Mv/PsZMv9CNieTylGLGqkG1QKvP4IlPgXF4T8GQVUqg0lRiOr5sEs9r8
         0JUvueuLQIjMkzV/SJ9t70hpbGdvKiy7Kd8wHy+wATJuen+RfvpyhAmo1zpI3beQLzxG
         4/A2VGEMm3G2x1xbzYUsfNl9C6pMaehiQn8nwNolyIvnvAzquhgz0QSwVNXjMHP8VU8e
         Hh3/grZX+CnHC1LRm/CltEpuzVYJnhKSoR3GAd4Psoo9xBiCF8sV9i2mXxKz9OjnqVpb
         bBlw==
X-Gm-Message-State: AOAM53148dlZcQmKB9R6DRHn6JepjFWTFBFUNs/KHk4fXgdE1EdRzUXV
        N/3boGE6SFhr/YFxbkLvUZ5MrQ==
X-Google-Smtp-Source: ABdhPJxi6lks0gYpKKh4LuvzEtLvK0kK+rMhTvV/K5AYOqtlLtAM3sJp8SxGwa5Ie/acDWj4d7nv+A==
X-Received: by 2002:a92:d801:: with SMTP id y1mr669770ilm.159.1634759677565;
        Wed, 20 Oct 2021 12:54:37 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id e14sm1600878ioe.37.2021.10.20.12.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 12:54:37 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
 <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk>
 <x494k9bo84w.fsf@segfault.boston.devel.redhat.com>
 <80244d5b-692c-35ac-e468-2581ff869395@kernel.dk>
 <8f5fdbbf-dc66-fabe-db3b-01b2085083b0@kernel.dk>
 <x49zgr3mrzs.fsf@segfault.boston.devel.redhat.com>
 <a60158d1-6ee0-6229-dc62-19ec40674585@kernel.dk>
 <x49v91rmqao.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea4bd905-4fc5-510f-fe8f-dfc4033d6500@kernel.dk>
Date:   Wed, 20 Oct 2021 13:54:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <x49v91rmqao.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/20/21 1:47 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/20/21 1:11 PM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 10/20/21 12:41 PM, Jens Axboe wrote:
>>>>> Working on just changing it to a 64-bit type instead, then we can pass
>>>>> in both at once with res2 being the upper 32 bits. That'll keep the same
>>>>> API on the aio side.
>>>>
>>>> Here's that as an incremental. Since we can only be passing in 32-bits
>>>> anyway across 32/64-bit, we can just make it an explicit 64-bit instead.
>>>> This generates the same code on 64-bit for calling ->ki_complete, and we
>>>> can trivially ignore the usb gadget issue as we now can pass in both
>>>> values (and fill them in on the aio side).
>>>
>>> Yeah, I think that should work.
>>
>> Passed test and allmodconfig sanity check, sent out as v2 :)
> 
> It passed the libaio tests on x64.  I'll do some more testing and review
> the v2 posting.

Thanks Jeff!

-- 
Jens Axboe

