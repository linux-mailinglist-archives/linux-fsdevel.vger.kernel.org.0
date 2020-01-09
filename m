Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62B1350C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 02:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgAIBCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 20:02:45 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:35043 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIBCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:02:45 -0500
Received: by mail-pg1-f174.google.com with SMTP id l24so2384561pgk.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 17:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ohlEOH5XWZ6A1s4JDpVP+2TOtl9UGDxWVMf8fpmYopY=;
        b=Tn614v3IQX5DPzGvONLnn2DMWx1qlDTwcNP7VpUtT/crVYqRW07tYmWfDEq554ngES
         t+REJ3IqPUkviApcsxFbnFjzY746dDn/epjM7RbAYbeZxFVelCAz6fYskY2AkcdXXivD
         bCjJb4JwtVe9yZghxC/3O6WcrAy+oARFugfxxhdS0UltabUtrfvxhIPMCPiqZ2STnx69
         ULljbUD60XjcYAcvODYbfZaY/HAX8SzfFql48ykJHHmthndK+wGzkuTps6YBhYY2JJDI
         tg0KGqaOa5SE8X2dZeeRLtdluwaGiLgP+VqZYrRiArPnPMqC3i2XAb6BCUqEljGXOlVA
         OHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohlEOH5XWZ6A1s4JDpVP+2TOtl9UGDxWVMf8fpmYopY=;
        b=Tz2sDuJFwNbOF5PV0qoE3tzzqGNW3DvVwTf9cJB3W+ArFrRx8aMSnNdCRN16jE3Wyx
         i3ZeLemf2O8o3qLLbzWsznMC59ta6LLfwnJlMDmknjz0Q+wx/jT5hB7GxCBAK6QCZizt
         092a9YUKL8s3P1o0DPqIJKimrIeYFAS8GhSa9HZ9Z56bCyQ4MEdYOxj6fb/Xdb4euHi+
         lHs0ealTVVVHyvAjC7dTuqs1PradIOuWoqRakOmZERJYN1DSHZjjx++tzaDfWW1ZMi+L
         Vth6pJlkKbuWg+P+FE6s7Q6RG3BnYt4BQjcBNqMQwgaL81csKhRaIbtAMQvN+mc7c9sL
         VM8A==
X-Gm-Message-State: APjAAAXGSqBPU6PLJpGkodjrNOaG5nb+0EINh+ia2bZlY/OxnIqWb8v1
        C9zY3hzrh4WyamTgJBR56yvjDeHNiPk=
X-Google-Smtp-Source: APXvYqy6eI6tbMcDpdYa1V7JRnmd3NXhhV8t8X/dcg/efqJu/i03zdPKcn/Tfg9NI0cNiPEHz4dm7w==
X-Received: by 2002:a63:134e:: with SMTP id 14mr8409191pgt.115.1578531764003;
        Wed, 08 Jan 2020 17:02:44 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a6sm4730969pgg.25.2020.01.08.17.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 17:02:43 -0800 (PST)
Subject: Re: [PATCHSET v2 0/6] io_uring: add support for open/close
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200107170034.16165-1-axboe@kernel.dk>
 <e4fb6287-8216-529e-9666-5ec855db02fb@samba.org>
 <4adb30f4-2ab3-6029-bc94-c72736b9004a@kernel.dk>
 <4dffd58e-5602-62d5-d1af-343c4a091ed9@samba.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eb99e387-f385-c36d-b1d9-f99ec470eba6@kernel.dk>
Date:   Wed, 8 Jan 2020 18:02:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4dffd58e-5602-62d5-d1af-343c4a091ed9@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/8/20 4:05 PM, Stefan Metzmacher wrote:
> Am 08.01.20 um 23:57 schrieb Jens Axboe:
>> On 1/8/20 2:17 PM, Stefan Metzmacher wrote:
>>> Am 07.01.20 um 18:00 schrieb Jens Axboe:
>>>> Sending this out separately, as I rebased it on top of the work.openat2
>>>> branch from Al to resolve some of the conflicts with the differences in
>>>> how open flags are built.
>>>
>>> Now that you rebased on top of openat2, wouldn't it be better to add
>>> openat2 that to io_uring instead of the old openat call?
>>
>> The IORING_OP_OPENAT already exists, so it would probably make more sense
>> to add IORING_OP_OPENAT2 alongside that. Or I could just change it. Don't
>> really feel that strongly about it, I'll probably just add openat2 and
>> leave openat alone, openat will just be a wrapper around openat2 anyway.
> 
> Great, thanks!

Here:

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.6/io_uring-vfs

Not tested yet, will wire this up in liburing and write a test case
as well.

-- 
Jens Axboe

