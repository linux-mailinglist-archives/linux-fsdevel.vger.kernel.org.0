Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D401E5395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 04:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgE1CBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 22:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1CBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 22:01:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E4C05BD1E;
        Wed, 27 May 2020 19:01:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cx22so2390498pjb.1;
        Wed, 27 May 2020 19:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73Q957jCvMVx76gQuPesrGR2ZeyRsCod6wvYAZR40Qo=;
        b=jeFFIPRWt+lSTBpw9GK1as7Uq+CxQmcZOQSyOWtffiplj1oAt6m5guAdb6n6mVXoSP
         qQWx9Wg51iu93EsoMhZFtJZnu+nGLmk3ItKOcXwbGx9kmvfVnhKH1khd83YroLH0URcm
         vF6fl9jVBMlIHGvj65jdTEYS7ZRwar5bXhBi/vJHW7uIcc1+m3cLPQ98RPgSzVT2YJSz
         85pb3Hqc7w9jssF0GNmjlWzcVRiI44nk5fqdVXe8efJfeCeWfojHAosmPG3KRzVqxf4a
         d/i7faMtUQHSlPRVoXc0C5CUS1yCXaNsjMadtKy/RdBsvi4Iy+/5gvcPGJNb9TA3uRlQ
         mXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73Q957jCvMVx76gQuPesrGR2ZeyRsCod6wvYAZR40Qo=;
        b=lpWAwyL63oNYnVRGMybY92+58IRsvhihNuBO5TjzWR3vRZuYQDc7coOtI+7t/LAPiI
         zqGK6TXs44bacPYRXIUX3Z9B3jbyyneF4+LYzXhvMM0gCRiJoN6hOIId/SvvKS7AU9sX
         M0OGfUPEn5Phk+cq809WbWr51L8ncTEmeaNyAktSvL6HG3JbeMbWJOnN2qQXzQZgmmGD
         cEOgCeJt7dFAlDV3QNekDCuCIcdnp5sNTiMM2hqVTd8o2DGTXiryuIVQDXrg7hh2nQHO
         eyH3cv0VPPDUYJUtko3iRNVi/0wzasgbKrzCdjza2yZcfQ0UmBX3VEdKsrOKLiOddgBM
         57Xw==
X-Gm-Message-State: AOAM531n865j4GLR4VIMWYsKg01TEGZgjv9HRHVfzti2OaBnf16wYWzZ
        gQM3VXX5PfJXidLttAHCUPqDjDI82Oc=
X-Google-Smtp-Source: ABdhPJxOeEIXemCTlflvLjBv9MZ/YVKIBdd6fGBSwjLPFozl1vdAkanJYJ38DsJtJ6LlNtBgdyXHHQ==
X-Received: by 2002:a17:902:834b:: with SMTP id z11mr1230315pln.87.1590631261375;
        Wed, 27 May 2020 19:01:01 -0700 (PDT)
Received: from ?IPv6:::1? ([2404:7a87:83e0:f800:295a:ef64:e071:39ab])
        by smtp.gmail.com with ESMTPSA id i197sm3128390pfe.30.2020.05.27.19.00.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 19:01:00 -0700 (PDT)
Subject: Re: [PATCH 4/4] exfat: standardize checksum calculation
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200525115052.19243-1-kohada.t2@gmail.com>
 <CGME20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8@epcas1p2.samsung.com>
 <20200525115052.19243-4-kohada.t2@gmail.com>
 <00d301d6332f$d4a52300$7def6900$@samsung.com>
 <d0d2e4b3-436e-3bad-770c-21c9cbddf80e@gmail.com>
 <CAKYAXd9GzYTxjtFuUJe+WjEOHSJnVbOfwn_4ZXZgmiVtjV4z6A@mail.gmail.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <ccb66f50-b275-4717-f165-98390520077b@gmail.com>
Date:   Thu, 28 May 2020 11:00:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAKYAXd9GzYTxjtFuUJe+WjEOHSJnVbOfwn_4ZXZgmiVtjV4z6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 200527-0, 2020/05/27), Outbound message
X-Antivirus-Status: Clean
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> II tried applying patch to dev-tree (4c4dbb6ad8e8).
>> -The .patch file I sent
>> -mbox file downloaded from archive
>> But I can't reproduce the error. (Both succeed)
>> How do you reproduce the error?
> I tried to appy your patches in the following order.
> 1. [PATCH] exfat: optimize dir-cache
> 2. [PATCH 1/4] exfat: redefine PBR as boot_sector
> 3. [PATCH 2/4] exfat: separate the boot sector analysis
> 4. [PATCH 3/4] exfat: add boot region verification
> 5. [PATCH 4/4] exfat: standardize checksum calculation

I was able to reproduce it.

The dir-cache patch was created based on the HEAD of dev-tree.
The 4 patches for boot_sector were also created based on the HEAD of dev-tree.
(at physically separated place)

I'm sorry I didn't check any conflicts with these patches.

I'll repost the patch, based on the dir-cache patched dev-tree.
If dir-cache patch will merge into dev-tree, should I wait until then?

BR
