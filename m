Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFCF31D348
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBQAO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhBQAOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A22DC06178A;
        Tue, 16 Feb 2021 16:13:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q20so7239280pfu.8;
        Tue, 16 Feb 2021 16:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DPaUZyetgxRAtD9/eHbrMFC15XoJhDJsXe/7hyurfTk=;
        b=NDdU7rxynA/2g0JPPrf5ZxqBQq8FElcmT8phVHZzz2po/R1qn+d16wV+UJaV/LWmNB
         W/tbPfblosC2Ht7fsvM+oZHQVn3u1J18a+EOTUKegHGxjlrpZHaOh7Z80rxXpfN9LyKk
         JfADRTEoZ2zkcDHe0Q7SMiLQdBhPGnu+SbxTlvYzAfg8zBrDJu6VxaZo2Ex9QV/2O+Y8
         BfJFkHqkK2SC5tw2sKlqdO+ugTfP4DQceg5oBACyveSl22eQ+fmON8Y3WTXRUnrhq8/P
         cua/GKCYyj67NDIeu7O0VXapsbzdFmXFmP8rY94rEauIVsbjHH/WJQErPtMTIj2EA/d5
         FdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DPaUZyetgxRAtD9/eHbrMFC15XoJhDJsXe/7hyurfTk=;
        b=Ez+BD+qMm803tB3UlaVbLNA/qGxli9iPcp+QGjRVplkiGdlr7iKSF3y+Oui0ef/yiu
         6At4FwiRz6+d4ICa51jU7FBlvqa+XcLCtLfoCWn67YlQ6Fkemrei2RtKVY6Uxg2gxZbM
         xqaBP6CsOPvHawP7KDq9JzqVSmoItXL8gG4I29zJzrsdQN5VmJTgpfCqL/NqaHTlREKt
         WASOmI/sIa9Z2A22ESBLyH5IlSQlKW7BICfU48x1QXAKqzVQQMwolGV1GJ+F/z41Enjw
         M4bSsRwZgoYenv+YlD9+Mez+7eT0Vyl0ZlrwvMcoEvL3sPB/mOxy6p3W7pip6JvQ8JYV
         X2Nw==
X-Gm-Message-State: AOAM533E+s/RrtM4MmPD+T5rOB4JQh6juGmlCTkmaYFbEg/eSz4/9M6w
        Fw+oCKzB5wQuuQH9xgiqZ2Y8qGwEVQdxSA==
X-Google-Smtp-Source: ABdhPJxar+4g1j/CHlNzTLyx+W3o8YU7y2zecRPAzoHPgMRaX6uC24T/ftsIoYWgg2xYFWKshoYwnw==
X-Received: by 2002:a63:1d1c:: with SMTP id d28mr20601247pgd.216.1613520819713;
        Tue, 16 Feb 2021 16:13:39 -0800 (PST)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id 9sm258190pgw.61.2021.02.16.16.13.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 16:13:39 -0800 (PST)
Subject: Re: [PATCH v2 1/2] exfat: add initial ioctl function
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
 <20210216223306.47693-2-hyeongseok@gmail.com>
 <BYAPR04MB4965E7E1A47A3EF603A3E34C86879@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <c186df93-a6b8-2cd5-8710-077382574b83@gmail.com>
Date:   Wed, 17 Feb 2021 09:13:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E7E1A47A3EF603A3E34C86879@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/21 8:51 AM, Chaitanya Kulkarni wrote:
> On 2/16/21 14:36, Hyeongseok Kim wrote:
>> Initialize empty ioctl function
>>
>> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> This patch doesn't do much, but this commit log could be better.
Sorry, I don't understand exactly.
You're saying that these 2 patch should be merged to a single patch?
Would it be better?
>
> Also from my experience there is not point in introducing an empty
> function.
>
