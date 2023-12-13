Return-Path: <linux-fsdevel+bounces-5805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A700E810901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 05:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3401F21B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81554C127;
	Wed, 13 Dec 2023 04:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmgrDoH2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D29BE4A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 04:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B75C433C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 04:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702440865;
	bh=nxC2+m3RyzZ1rBzqIpdL1Cy9nkSM/W+YAdFx1s8C7lk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=HmgrDoH2HrBG19uTbX02u7wEXbAFOKC63CKhQ7++CSfCCkYWlImc/XHKSq3vz9+XW
	 je9V1cq6KPk73cHj9AUX7kYqF/ph4hXeJSnPR5kDtWoiF2wc0F0v5DYxP61t8HzDyW
	 Z/+eAYhHm5U3ndt+YiQSIN2ic9G7A9gPht0m/ENIGSwalE7VyjmMZGM0yDQ5C3jdk0
	 /LtM/ThFVbRLtVkh8ZwbvCUvH7/gfYe+TSIRzRda/rkmZ22tMB6g302z1nbCaE9yAV
	 Ua23/r7bPF/KMMI7DJVyH1y362mGhdtW777LgngA/gO/bT50LAs0qszH8SJqDtnVz0
	 PoNaNkJU6Pr5w==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d855efb920so5185251a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 20:14:25 -0800 (PST)
X-Gm-Message-State: AOJu0YwmAs1nyEldeHT0K8PfAua9tLAEuwrtG3avavvY4QY536B0zsl1
	tlfvzRnY0U18r02KqcYY5e0ZAGFKm/mHMzdgNKw=
X-Google-Smtp-Source: AGHT+IHqHBVN6LrhPJJ0tdt2pztEihKCtZld2AgAF4DwvHcl5F/vgivwTQLVG7Xd6y7PiUtv5FwS5a1VSvf4RX7QOwM=
X-Received: by 2002:a9d:6d16:0:b0:6d9:d747:dcf5 with SMTP id
 o22-20020a9d6d16000000b006d9d747dcf5mr6584835otp.72.1702440864546; Tue, 12
 Dec 2023 20:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5dc6:0:b0:507:5de0:116e with HTTP; Tue, 12 Dec 2023
 20:14:23 -0800 (PST)
In-Reply-To: <PUZPR04MB6316D78A5169E0FC1F046698818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63164691A5119414706F66998182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63167EF34D0B46A4D418A86C8185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd8HieJNdF7poscX0gR0_EBCVW+aACW6bBBCVXKiaORq5w@mail.gmail.com>
 <PUZPR04MB63160A6FD8E7EF04E4342B1B818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB6316D78A5169E0FC1F046698818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 13 Dec 2023 13:14:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8PZBY0=KgE6YvVczPC80aiWh=TjLYeXHPdaR_FVRzCxg@mail.gmail.com>
Message-ID: <CAKYAXd8PZBY0=KgE6YvVczPC80aiWh=TjLYeXHPdaR_FVRzCxg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] exfat: get file size from DataLength
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Andy.Wu@sony.com" <Andy.Wu@sony.com>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>, "cpgs@samsung.com" <cpgs@samsung.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

2023-12-12 19:29 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
>> Have you ever run xfstests against v6 version ?
>
> Yes.
>
>> The page allocation failure problem in my test happen below.
>> What is your test result?
>
> There is no the page allocation failure problem in my test.
> I skipped the 6 test cases, except for these 6 test cases, all other test
> cases passed.
>
> - generic/251
> - generic/455
> - generic/482
> - generic/604
> - generic/633
> - generic/730
>
> What are the chances of this problem happening? every time when running
> generic/476?
Hm.. I have checked It can happen regardless of your patches. It is
difficult to say how often this occurs. Because the generic/476 test
takes very long time. so I'll look into it further.
And I will apply your patches to #dev with Sungjong Reviewed-by tag.

Thanks!
>
>
>

