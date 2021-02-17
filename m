Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7FE31D51E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 06:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhBQFkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 00:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhBQFj7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 00:39:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B710264DEC;
        Wed, 17 Feb 2021 05:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613540358;
        bh=NbAmmaGQmfZWMm1BXQVzI0umy9Eh1JXd1YaKOjPeNhw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GCxQmX2RiMPgd1bkNN4owBaeyRM8OYxDSUvIVLmDWut06EtLz3Tax0o+epduqmLwl
         BhPjd4I08C8usQuaBrmlUNRajWg2o7qTViC65mQ+AErin5T1L3g+Zuq3lTR53U7zbO
         RflmF9l99/h/lGYsrpsTdndX5aRFHPJY3iQCRM1uTiy5BDnomV2ZSTlEms31yB+3X3
         BU2rqDvtDz8/5n9LLS00gQHhzQQ+UTjDb1uXuvO4UDlsZUxOZ+PT47O/4BRKCZ+slw
         OngllKYCi2jRz9Ij6DO9Nlpl0FNGzSco0fjN7aVmKo1OYTTqAfoBqkqZVk8k5OU3ob
         UiBST3BO7+t5w==
Received: by mail-ot1-f52.google.com with SMTP id c16so11120625otp.0;
        Tue, 16 Feb 2021 21:39:18 -0800 (PST)
X-Gm-Message-State: AOAM530mN2htvZttjGLEU1yS1uhVU4sU8a4tF73NSe4wfyXZ35K+ILJ4
        FeWyl+kbNydS1p/GPlJdmF9IGvnj82x5kRUYiRM=
X-Google-Smtp-Source: ABdhPJwDq71zLUcnG1gLUuvuBxrgIhyJajYbuwWxi3suqIL2IrLuCHbyuuIb8Ergaz3UxGo+TUbG/gYQ08y47/4TTtE=
X-Received: by 2002:a05:6830:1146:: with SMTP id x6mr12150898otq.120.1613540358062;
 Tue, 16 Feb 2021 21:39:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:13e5:0:0:0:0:0 with HTTP; Tue, 16 Feb 2021 21:39:17
 -0800 (PST)
In-Reply-To: <78a7f3ec-f5c2-071a-506c-b19b21b9b04c@gmail.com>
References: <20210216223306.47693-1-hyeongseok@gmail.com> <20210216223306.47693-2-hyeongseok@gmail.com>
 <BYAPR04MB4965E7E1A47A3EF603A3E34C86879@BYAPR04MB4965.namprd04.prod.outlook.com>
 <c186df93-a6b8-2cd5-8710-077382574b83@gmail.com> <BYAPR04MB4965E80E52DA1E8D90F4736886869@BYAPR04MB4965.namprd04.prod.outlook.com>
 <78a7f3ec-f5c2-071a-506c-b19b21b9b04c@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 17 Feb 2021 14:39:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9=NwCpFJ7NczFBF1diFV3mLpL2Sz7UQP-Pg78zaFtBnA@mail.gmail.com>
Message-ID: <CAKYAXd9=NwCpFJ7NczFBF1diFV3mLpL2Sz7UQP-Pg78zaFtBnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] exfat: add initial ioctl function
To:     Hyeongseok Kim <hyeongseok@gmail.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-02-17 9:33 GMT+09:00, Hyeongseok Kim <hyeongseok@gmail.com>:
> On 2/17/21 9:17 AM, Chaitanya Kulkarni wrote:
>> On 2/16/21 16:13, Hyeongseok Kim wrote:
>>> Sorry, I don't understand exactly.
>>> You're saying that these 2 patch should be merged to a single patch?
>>> Would it be better?
>> I think so unless there is a specific reason for this to keep it
>> isolated.
>>
> The reason was just that I think it seems better to seperate ioctl
> initializing and adding specific ioctl functionality.
> Anyway, I got it.
>
> Namjae,
Hi Hyeongseok,
> Do you have any other opinion about this?
I also think this patch should be combined with the 2/2 patch.
> If you agree, I'll merge these as one.
Yep, Agreed. Please do that:)
Thanks!
>
>
