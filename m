Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E797841EFBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354523AbhJAOl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 10:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238636AbhJAOl5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:41:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BC8861507;
        Fri,  1 Oct 2021 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633099213;
        bh=ZahyhpPtQqhVvBHMnz421DpVrE2pzsHhdju9V2J7Gfg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Wik6Tep3WZyMeTAg1k3nvnl75EwOHoqRADJahFNGtIEk/MgpBvQ9XuTOawYEzOQuQ
         9nJD2lxyiInmS1O49YzItToLKakabr76QOgbln5LEoGAaeyKZTmZ2mRn5Q7Pm4h5FB
         bNaG+JvddFrNrHL1n1KgLPazLYS2tsIPOR8RH4IM8OaTrDkEpm4q3gsOntt3+buhln
         jb+raArklpFltKNK4glSw/cXP4nfXYp2vGq4K7aiLHtvM2/nVbERjXi+9OLOy/tMPe
         23VCAPzxvmy/g38Oy6i2VYVdoLJ9jfk9hLelMqt/gG/igMt9QEVPVoLPGPvADy969B
         GsLuVfdZIP6QQ==
Received: by mail-ot1-f50.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso11734101otu.9;
        Fri, 01 Oct 2021 07:40:13 -0700 (PDT)
X-Gm-Message-State: AOAM533+Zk0vu8p808MNIslVm1xN02FGH1Wi1/kbw0siyZ7LBP3YNbrH
        nV3by2xnbuyP9dC7ldjK+6aZqoSAyhvUAahIAkg=
X-Google-Smtp-Source: ABdhPJy5/eaiRuG7rldYq3SgOdinICCXjY5DrIyS+YU7L88apLItGe1pLS9Gm2fTrYP5pb2+Y1e0rrcQF7pXPa2o8Uc=
X-Received: by 2002:a9d:4705:: with SMTP id a5mr10542184otf.237.1633099212608;
 Fri, 01 Oct 2021 07:40:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1342:0:0:0:0:0 with HTTP; Fri, 1 Oct 2021 07:40:12 -0700 (PDT)
In-Reply-To: <997a01d7b6c6$ea0c3f50$be24bdf0$@samsung.com>
References: <20210909065543.164329-1-cccheng@synology.com> <CGME20210910010035epcas1p496dd515369b9f2481ccd1c0de5904bbd@epcas1p4.samsung.com>
 <CAKYAXd_1ys-xQ9HusgqSr5GHaP6R2pK4JswfZzoqZ=wTnwSiOw@mail.gmail.com> <997a01d7b6c6$ea0c3f50$be24bdf0$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 1 Oct 2021 23:40:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9COEWU_QF3p0mnEnH4nHMrHQ5ujwBZ6rt4ZBjEFBnB=w@mail.gmail.com>
Message-ID: <CAKYAXd9COEWU_QF3p0mnEnH4nHMrHQ5ujwBZ6rt4ZBjEFBnB=w@mail.gmail.com>
Subject: Re: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID isn't set
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shepjeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-10-01 22:19 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
> Hello, Namjae,
Hi Sungjong,
>
> I found an important difference between the code we first wrote and the code
> that has changed since our initial patch review. This difference seems to
> cause compatibility issues when reading saved timestamps without timezone.
> (In our initial patch review, there were concerns about possible
> compatibility issues.)
> I think the code that reads timestamps without timezone should go back to
> the concept we wrote in the first place like reported patch.
Are you talking about using sys_tz?

> It could be an answer of another timestamp issue.
What is another timestamp issue ?

>
> Could you please let me know what you think?
>
> Thanks.
>> -----Original Message-----
>> From: Namjae Jeon [mailto:linkinjeon@kernel.org]
>> Sent: Friday, September 10, 2021 10:01 AM
>> To: Chung-Chiang Cheng <cccheng@synology.com>
>> Cc: sj1557.seo@samsung.com; linux-fsdevel@vger.kernel.org; linux-
>> kernel@vger.kernel.org; shepjeng@gmail.com
>> Subject: Re: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID
>> isn't
>> set
>>
>> 2021-09-09 15:55 GMT+09:00, Chung-Chiang Cheng <cccheng@synology.com>:
>> > EXFAT_TZ_VALID is corresponding to OffsetValid field in exfat
>> > specification [1]. If this bit isn't set, timestamps should be treated
>> > as having the same UTC offset as the current local time.
>> >
>> > This patch uses the existing mount option 'time_offset' as fat does.
>> > If time_offset isn't set, local UTC offset in sys_tz will be used as
>> > the default value.
>> >
>> > Link: [1]
>> > https://protect2.fireeye.com/v1/url?k=cba4edf5-943fd4c8-cba566ba-0cc47
>> > a31309a-e70aa065be678729&q=1&e=225feff2-841f-404c-9a2e-c12064b232d0&u=
>> > https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows%2Fwin32%2Ffileio%2F
>> > exfat-specification%2374102-offsetvalid-field
>> > Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
>> Please read this discussion:
>>  https://patchwork.kernel.org/project/linux-
>> fsdevel/patch/20200115082447.19520-10-namjae.jeon@samsung.com/
>>
>> Thanks!
>
>
