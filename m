Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC36931D543
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 07:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBQGGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 01:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhBQGGQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:06:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CF6C061574;
        Tue, 16 Feb 2021 22:05:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gx20so1004120pjb.1;
        Tue, 16 Feb 2021 22:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=msCJLfOBWEqsg5Bk7DN5BzC2QhC/Dc4/3cKmnY0kU5s=;
        b=CPTD3MSFzFoLBqLGX7Zam6ZX+nwJdUt7xtVuunA7iS9LA2Z23x9grWtEBcr8MKa0rJ
         c5doWq6oBDvTSuI4E5DZZb8BIwLX8qpvbnG/LhQTbOowjTs4+Cp6COE1gR0BGNEUvUtu
         8wy27D888+wnVOsP/B+egFB6dUTziNAh0JqTwfAmJBRyV4+DY+xsXBkr4cptO/fby14B
         lir11Hkr344jYQ5gKP+yzUPmUbYk4UYhHDkww7pIrTHof/+UiAvIepj0fRPXfhqUxPsR
         1HY6OURVUNSRS3WTPqFly2mOTRDjoj921qHM6nr7Yf4W9tjFSiWAQqJPxlCn6k8T2NnF
         vckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=msCJLfOBWEqsg5Bk7DN5BzC2QhC/Dc4/3cKmnY0kU5s=;
        b=j54tYwdjDYW/UswEoi63PhcrhmJXP3JZaoF9BA/xDptu9JCgTfB2x+T8VSxBgDNhlU
         PYwUR1JXgYkw3+hmSgUqmv0hhOxD48y7aZUhUz4Eo0gjV8EiHrM2dKDl3Rn5BkjXW0/s
         3ziib1z+Eu/UVuDTHgDDyE9ckpQuSqSnKdUz+eHdH15VFt7+BtS5uzh9LlgQwgPvVmYP
         GgcvpMA4dViKmQJ4NnM9dGH7kcxV0nzpYoLL0dLd58gyfuxvvKkupoSgxOWIfVbY9hjY
         2MxMduMsKwYAOzyLPJOnnl1PiOxb7tZ8QnscQhnvb132M8GUhVgTdGalsq5WTIq4PQud
         NMmQ==
X-Gm-Message-State: AOAM533zcRjrOJuAS9EGJthQqRhsmMUiTyXkBJlWiGMkHK8eupG1DA5n
        g1K5ZPkcbIxgE4hyi408rF8HhXiTIkzm0A==
X-Google-Smtp-Source: ABdhPJxz2wG9r1He/uWjMfC585znSF6cQLKkumSTG6cBJ7d2PqFmb+pg1JBWIxqGl8QXGYpLSTuOew==
X-Received: by 2002:a17:90a:fd17:: with SMTP id cv23mr980322pjb.37.1613541919643;
        Tue, 16 Feb 2021 22:05:19 -0800 (PST)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id s19sm943462pfc.79.2021.02.16.22.05.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 22:05:19 -0800 (PST)
Subject: Re: [PATCH v2 1/2] exfat: add initial ioctl function
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
 <20210216223306.47693-2-hyeongseok@gmail.com>
 <BYAPR04MB4965E7E1A47A3EF603A3E34C86879@BYAPR04MB4965.namprd04.prod.outlook.com>
 <c186df93-a6b8-2cd5-8710-077382574b83@gmail.com>
 <BYAPR04MB4965E80E52DA1E8D90F4736886869@BYAPR04MB4965.namprd04.prod.outlook.com>
 <78a7f3ec-f5c2-071a-506c-b19b21b9b04c@gmail.com>
 <CAKYAXd9=NwCpFJ7NczFBF1diFV3mLpL2Sz7UQP-Pg78zaFtBnA@mail.gmail.com>
From:   Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <cd35111b-82dc-e919-7860-bfa2f94cd7c4@gmail.com>
Date:   Wed, 17 Feb 2021 15:05:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKYAXd9=NwCpFJ7NczFBF1diFV3mLpL2Sz7UQP-Pg78zaFtBnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/21 2:39 PM, Namjae Jeon wrote:
> Hi Hyeongseok,
>> Do you have any other opinion about this?
> I also think this patch should be combined with the 2/2 patch.
>> If you agree, I'll merge these as one.
> Yep, Agreed. Please do that:)
> Thanks!
Thank you for the opinion.
I sent out v3.


