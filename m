Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D24772AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhLPNG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 08:06:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33166 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhLPNG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:06:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 908D261DD9;
        Thu, 16 Dec 2021 13:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04476C36AE4;
        Thu, 16 Dec 2021 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639659987;
        bh=Dk3cIUFGKT5Iy0oSxTMRuFaBsxedAAUL87EX758eInA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ku9b4jmNmGvt56Csc51/q6aSUPA+j4G5EKRWjFatWRq+4N7wCSDjDIn1Kxfy2Sy5t
         Xz9EKF63j0rtt8j07i6MS5rcKv9M+872ozC13DMMHUqiQy1lOiottT+vTm2g7k7rAj
         4th7kCh7UjO/TJ8Nai3bD+CBOylO5n/bcSBHVqJswvqJeKuBdnxc4MZMdn9WznRPJ5
         TnZBbPeo0hAlwu7uBtWgJINnZ4/ZBC7birJz+ztCREW095rAYnv4X7D7XPa2q8jNUA
         oaaklRZd0ndX8ylrxqVxl1W14yBEfugoeoh/zMSBH6pPmBktbAILZOUWBOKi6/R7DY
         9qSZf0+pVc7nw==
Received: by mail-ot1-f43.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so28873756otg.4;
        Thu, 16 Dec 2021 05:06:26 -0800 (PST)
X-Gm-Message-State: AOAM5311s0m3Zz8m80u3q5+iLqgbwlwn2kqsR/Gk3LULsFSRu1U1x3oz
        e1rhxU6vIaa0+/dl3pQsdR7Hl23mF/xOv8JE0Jw=
X-Google-Smtp-Source: ABdhPJzVpCFPIskaH7m3fX6XtMkYH8eezWseVuqAasNRMtwHcsRegChxt44lHuNpLsnXg7R8FgbON3T1IQ8utZIUa4o=
X-Received: by 2002:a9d:6653:: with SMTP id q19mr12829832otm.116.1639659986202;
 Thu, 16 Dec 2021 05:06:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:428a:0:0:0:0:0 with HTTP; Thu, 16 Dec 2021 05:06:25
 -0800 (PST)
In-Reply-To: <054301d7f1b6$e3d380f0$ab7a82d0$@samsung.com>
References: <CGME20211215051307epcas1p30f013371a7f2e346ce5851b0157abedc@epcas1p3.samsung.com>
 <HK2PR04MB38919EB7F957C4BBB0B94C3781769@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <054301d7f1b6$e3d380f0$ab7a82d0$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 16 Dec 2021 22:06:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-XEx7iG8nhw8e3sMB65ABM5G_+n8BM3ObR7YHiBvhK0w@mail.gmail.com>
Message-ID: <CAKYAXd-XEx7iG8nhw8e3sMB65ABM5G_+n8BM3ObR7YHiBvhK0w@mail.gmail.com>
Subject: Re: [PATCH] exfat: remove argument 'sector' from exfat_get_dentry()
To:     "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-12-15 22:23 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> No any function uses argument 'sector', remove it.
>>
>> Signed-off-by: Yuezhang.Mo <Yuezhang.Mo@sony.com>
>> Reviewed-by: Andy.Wu <Andy.Wu@sony.com>
>> Reviewed-by: Aoyama, Wataru <wataru.aoyama@sony.com>
>
> Looks good!
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied, Thanks for your patch!
