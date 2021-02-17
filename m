Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00431D36F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhBQAeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBQAeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:34:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41452C061574;
        Tue, 16 Feb 2021 16:33:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cl8so404860pjb.0;
        Tue, 16 Feb 2021 16:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H/D6N1nsMpwnWXlz/g+jFpO+WGiWhH8xWdg4uDGL3J4=;
        b=iFU43WxXdp7pG2yC4zcfnocfL+goUTpvv2YtexPfNcb+gZytlzm6EkibsY691Xdi9V
         JmS7ATHi85ptCtSLxH9WYvWTASB93f05JnIuYLPRTFYoFgaQXiqnD1Af0pHenOP1e39y
         5Z+rFqKB12sJn8avivpS/jnY8FaXGGDZ4M6JHt14srg6mY0KCowMRYrq3m/LLD5GzKgA
         LuFURVRyZ9mgXqK9DCUNsGE53+yCNNP5IkCnRnTGfRtgwgjq+HdQ8eVNs/sSrxzfS+o3
         bMTmBM6T/VDJx99h4CZN++iG0zSQHeYGPVGeG8bDe6WxCOxQwsAMOBks6GVsrBZ4lWap
         qovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H/D6N1nsMpwnWXlz/g+jFpO+WGiWhH8xWdg4uDGL3J4=;
        b=BBWni9mfRJFugYjJY3CcgAr9k+ezqSZ+Vts2xkAMnDswrpvsYuIQKtQ6hafe+tUvCa
         Xxbamr+6swKmfyaLNhQsksT79rsMaq3rYddwFFcpMDdMeoLNzB0nurkoCz3aQYLRSdE+
         AmsZP8CroFa47WpF1uQ46RWJcMzHr92vAW5EYUEpCRcHWL2dgZwLFftNdokfUqQgJJTu
         tqBEiosBPItnpY+WUyjBgCmIWK+AWBdPJgWKVtIjKwyg3cK779vXn9IKRf0nmv8LMhPL
         eKK+PzLi/W68PMj05KT8EI0WNJUhSHMjShQExR6NhhYoqvIRArts+N6EDVlOWz6agRf4
         +MGA==
X-Gm-Message-State: AOAM533OLRqMDHGJoW4nMIYqPRSHuFdthi/BRoDV6qsZNSCOnFMu8nK4
        uKxrq19aA8pTJ9qAXmqwA7BIHPoo+rgJ/w==
X-Google-Smtp-Source: ABdhPJwSchbI2sygfYGXZkrgjyWuZxvHo3pyMN8Ptz5OpVp5SXD3Fqqt9selSuaKGUtE2gpZJdp3bw==
X-Received: by 2002:a17:902:a581:b029:e3:480a:9779 with SMTP id az1-20020a170902a581b02900e3480a9779mr15461910plb.74.1613522002573;
        Tue, 16 Feb 2021 16:33:22 -0800 (PST)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id c26sm120477pfj.183.2021.02.16.16.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 16:33:22 -0800 (PST)
Subject: Re: [PATCH v2 1/2] exfat: add initial ioctl function
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
 <20210216223306.47693-2-hyeongseok@gmail.com>
 <BYAPR04MB4965E7E1A47A3EF603A3E34C86879@BYAPR04MB4965.namprd04.prod.outlook.com>
 <c186df93-a6b8-2cd5-8710-077382574b83@gmail.com>
 <BYAPR04MB4965E80E52DA1E8D90F4736886869@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <78a7f3ec-f5c2-071a-506c-b19b21b9b04c@gmail.com>
Date:   Wed, 17 Feb 2021 09:33:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E80E52DA1E8D90F4736886869@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/21 9:17 AM, Chaitanya Kulkarni wrote:
> On 2/16/21 16:13, Hyeongseok Kim wrote:
>> Sorry, I don't understand exactly.
>> You're saying that these 2 patch should be merged to a single patch?
>> Would it be better?
> I think so unless there is a specific reason for this to keep it isolated.
>
The reason was just that I think it seems better to seperate ioctl 
initializing and adding specific ioctl functionality.
Anyway, I got it.

Namjae,
Do you have any other opinion about this?
If you agree, I'll merge these as one.

