Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88AB1F5F23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 02:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgFKAWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgFKAWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:22:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD585C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 17:22:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so2525175pju.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GLzltuaR1D0ifMP6N8wN30kYI1o2aLC0iGE8a2i6DJU=;
        b=PNNEErQAw7Nr0fD3qyo72E6/pzEwQfkVNKrz2rxLkqkU55frfbl8ZqsnUxMDsfdAnx
         fg3Bu6jAl3jFMFUZolaNKnI4kclffSZAqciifDx34ZnffqeJt/EolpYfi8TzADrDjtVn
         W60MJLzPNh5edCSCwVejLTHIqlTnIVn6s26/silLOSCX/altYAmKc3GMYPY7fxJ1wZoL
         KQaijPAShvEH9PiDpo/qZ1HnjHYqeeqf2pchW/MILXM6b3eLz2e6MKZU50czt7AhxQA7
         i7PqtPPkudZjFzrO0wFxiFM6SS46KgvPHpzm0gbw+U4mnPZuCIeJ6r8M7Qp8d76Pn56L
         ILNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GLzltuaR1D0ifMP6N8wN30kYI1o2aLC0iGE8a2i6DJU=;
        b=MuG0eJAp/uBD9LzBLWPjD8M3KPErYAw7fBSQK9y8CN5sKwdg8gxyB2Aq8f3Kw2TKUO
         FYUq6i0/96A66wvhqx2VlFsr9gujAdedgjh1RXMAbuyFmudypzIoNH5+Z/7oW8chQAcZ
         jkEKzDJrw24HbAIMmP7DziDdu2ipfhVdQHwe1S2fPPCFe4tbQFiuyp3zduH8Qxr0Qqhf
         ugAVoagTuW7QYdLTQUX23+hYbLuzK5LVn5y/SgUd7Nwp3u/m8QdeWSJ9FtR3Iul47LFb
         7pzhY6W0F0DDP+5gZbH9J/J/8pnQIQ/m/iynOqyqe6yPxBL5E0maFTmPXA0NwummkMVP
         ZOxA==
X-Gm-Message-State: AOAM532i5iNhhjIPf0PUSqgkfWHCoG2Sb69aR5ySAcwsguBg/9Oo/pCW
        NKH28OTy0Sj6IdKmLD2kBEw=
X-Google-Smtp-Source: ABdhPJxS6Yv2oqBGiCNfjb8r8HOM6GAqDrALX7kquCpTMUuyYRIIGTgFhZnIOpmG5v4GDqAGo5O47g==
X-Received: by 2002:a17:90a:ac03:: with SMTP id o3mr5481450pjq.214.1591834972904;
        Wed, 10 Jun 2020 17:22:52 -0700 (PDT)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id z186sm838573pgb.93.2020.06.10.17.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 17:22:52 -0700 (PDT)
Subject: Re: [PATCH v2] exfat: Set the unused characters of FileName field to
 the value 0000h
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org,
        'Sungjong Seo' <sj1557.seo@samsung.com>
References: <CGME20200609053051epcas1p2dcc80d99a10bcc83e11fda481239e64a@epcas1p2.samsung.com>
 <1591680644-8378-1-git-send-email-Hyeongseok@gmail.com>
 <03cc01d63e32$1dec4a40$59c4dec0$@samsung.com>
 <002a01d63ed3$2ed5e680$8c81b380$@samsung.com>
From:   hyeongseok <hyeongseok@gmail.com>
Message-ID: <92b6fd37-4377-3672-fd9a-654d2059dc94@gmail.com>
Date:   Thu, 11 Jun 2020 09:22:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <002a01d63ed3$2ed5e680$8c81b380$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/20 11:59 AM, Namjae Jeon wrote:
>>> Some fsck tool complain that padding part of the FileName field is not
>>> set to the value 0000h. So let's maintain filesystem cleaner, as exfat's spec.
>>> recommendation.
>>>
>>> Signe-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
> Fixed a typo: Signe -> Signed.
Oops.
Maybe I touched Signed-off-by tag while editing commit message, and 
forgot to do checkpatch on 2nd version.
I'm sorry for bothering you and Thanks for fixing it.
>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>>
>> Looks good to me. Thanks.
> Applied. Thanks!
>
>

