Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8A439BBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhJYQkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 12:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhJYQkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:40:52 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B11C061767
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 09:38:26 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o204so16318809oih.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ssa/1a3nDcMzPBFPMixJLpMQg9KO0kDblWHGeFJ6U4M=;
        b=nMlEOcqnMj+se7452CepIrfcrj6t/QNsqTiQswf2I/ev4Ku8Zkwub8LtKBSK2sTiXe
         qfWzfzodaeL3teXOFiWoXHU930UmRpZNsmlczMQQZd6WxO05QVRYCXTt118bB6MB/1Yu
         EISQwPFb6/VCpGCXANeVANvn7EL+1sL3fPUpmHbzKrH5jNI5q7vXxPZD6cQiym1jzuOd
         S6e5oU3j5mh39jQwqAJ9CI47/n2cSCVuPU+0tAPz5qW+4V45QwC9/nTMcTWN1pvo6YOh
         Lz5Qg8K9oJkV0pndAjS7FqABQVeaFsw3xlJ+hrCMdGdEe4EMomB/a/0G4LnEOec/pei+
         vsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ssa/1a3nDcMzPBFPMixJLpMQg9KO0kDblWHGeFJ6U4M=;
        b=pj4uIJrRXufhNCzpj+odI7mqvQlkqWsVFJkFeXCQZ+IbaErseRl3JRHHFYYhPg3tv3
         8qIOCsBMRIbUjO+roIiAz6CVxDLh8QnFMtrT34fy3vyFvQWBLz5iPa40eWFs0FbWleAg
         tqfKaO4Daxuhjfvt0Jmfex3G82P27qOZ/YI1PS+YlWBnSC7OApYkHQWbxFxe+orQxfNZ
         i7dpmuu2oz9+K9p/t/uOAe5LuzrnOXu2NmA1EHJYlfKaMdEen1S7sb3jRXYA4AkYl4rK
         Rv+xbRloHFbR6dAF4L5KAs3MOR6swsalTGFWplOEa513ms5qckTzy0nK8Lrb2qcWmhfK
         z3OQ==
X-Gm-Message-State: AOAM530J0Lg3RhMsaQed28GgIOLbc+8rbhZYMujoiHI6zlGBX703Y2x0
        krz+KV97HGQdaBFKFFPT5jIuj2kxVhzghQ==
X-Google-Smtp-Source: ABdhPJxb/QqfVg/E6P08QvApIoJ2pk/RFe/qBic0wrxoVfk1pn8Kbr+8mF6Hxy2DcW2ukH4bLcP5AA==
X-Received: by 2002:a54:4118:: with SMTP id l24mr13421374oic.63.1635179905496;
        Mon, 25 Oct 2021 09:38:25 -0700 (PDT)
Received: from ?IPv6:2600:380:602d:d087:5bee:e9ee:c67d:4ccf? ([2600:380:602d:d087:5bee:e9ee:c67d:4ccf])
        by smtp.gmail.com with ESMTPSA id e1sm3967197oiw.16.2021.10.25.09.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:38:25 -0700 (PDT)
Subject: Re: [PTACH] fs: get rid of the res2 iocb->ki_complete argument
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-aio@kvack.org, Jeff Moyer <jmoyer@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <4e54bfd2-3097-ab52-381b-4f2bf3a1d782@kernel.dk>
 <20211025161629.GA2237511@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <887851ee-e144-1186-76d6-b110c445c540@kernel.dk>
Date:   Mon, 25 Oct 2021 10:38:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211025161629.GA2237511@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/25/21 10:16 AM, Darrick J. Wong wrote:
> On Mon, Oct 25, 2021 at 09:33:02AM -0600, Jens Axboe wrote:
>> The second argument was only used by the USB gadget code, yet everyone
>> pays the overhead of passing a zero to be passed into aio, where it
>> ends up being part of the aio res2 value.
>>
>> Now that everybody is passing in zero, kill off the extra argument.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> The fs/ parts look reasonable to me.
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks!

> So, uh, do you get even more iops by avoiding the extra register? :)

Heh, well if you're register starved, it'll likely make a bigger
difference, but even on my CPU it is actually noticeable. Obviously not
a 10% gain, and the change is more about cleaning up the API a bit.

-- 
Jens Axboe

