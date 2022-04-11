Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40904FB194
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 04:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbiDKCFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 22:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiDKCFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C31326F4
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 19:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9F7461017
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 02:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389A9C385AA
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 02:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649642588;
        bh=XiPC9bR9HXhmtj9VWr6b/CAnD+mOFkUe+j75TkGPCO8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=gZwUxIonWoYy/pIqnakX/OjbVYWtm77P10u/BUmzWcO4Oy8UxSNdadKY+bN5qCjgH
         jMWgTKCJ62pUlSijlluWjTJbL270dOcdTRclZRt5hULCw5ENV4F+j2Ot4QOybIVudd
         qzNDyV7mzD2vDk4JB8CjfFSoxDq8px+rQTypalWN4KoD31R4dfYh+UGrqUQYritI1w
         48pmTIM9clDAbfIpP6tDsCZoXzNTJSAb9aYJ9ZdkJBQgBJod63DsWxMRcIq4v6rru6
         BEaB179ltUVqQuwvIQgAe8UCa12HlGzfFPMsFkPCnrTSzqCVev6RhI3fyOtyqaGEIH
         2KOeHMrMq/SfQ==
Received: by mail-wr1-f51.google.com with SMTP id s28so4967286wrb.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 19:03:08 -0700 (PDT)
X-Gm-Message-State: AOAM531mB9kwbM++fiInHjqJoqGQZ81TlKxtn8YUUix4siMm0h4Mym/d
        WSOIgVLSBSsCKJXbs9Eh4GAVYmme4VuWzFb1Ej8=
X-Google-Smtp-Source: ABdhPJwoVkRQyz6kM7MdPWDMad1jyQpONlogpbaB+Ztk/f/LcUhx/grikXfQtvvm3MG3xIPpiNaZgfYa3tt2rUMynwg=
X-Received: by 2002:a05:6000:1541:b0:207:8ee6:1417 with SMTP id
 1-20020a056000154100b002078ee61417mr12728330wry.504.1649642586475; Sun, 10
 Apr 2022 19:03:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Sun, 10 Apr 2022 19:03:05
 -0700 (PDT)
In-Reply-To: <190001d84a22$001aced0$00506c70$@samsung.com>
References: <CGME20220406095559epcas1p19621ef9dedda9cd51edbb40d12a40936@epcas1p1.samsung.com>
 <20220406095552.111869-1-cccheng@synology.com> <190001d84a22$001aced0$00506c70$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 11 Apr 2022 11:03:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9HMJpebbaNmnkfVm+Sya20S-R_sbPFm459EVF5xBC=Ng@mail.gmail.com>
Message-ID: <CAKYAXd9HMJpebbaNmnkfVm+Sya20S-R_sbPFm459EVF5xBC=Ng@mail.gmail.com>
Subject: Re: [PATCH] exfat: introduce mount option 'sys_tz'
To:     Sungjong Seo <sj1557.seo@samsung.com>,
        Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-04-07 10:51 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> EXFAT_TZ_VALID bit in {create,modify,access}_tz is corresponding to
>> OffsetValid field in exfat specification [1]. When this bit isn't set,
>> timestamps should be treated as having the same UTC offset as the current
>> local time.
>>
>> Currently, there is an option 'time_offset' for users to specify the UTC
>> offset for this issue. This patch introduces a new mount option 'sys_tz'
>> to use system timezone as time offset.
>>
>> Link: [1] https://protect2.fireeye.com/v1/url?k=6c606ee0-0d1d8463-
>> 6c61e5af-74fe48600158-7870d6304b957d98&q=1&e=3704e121-39fa-4c75-a3c8-
>> a4e968c00dbf&u=https%3A%2F%2Fdocs.microsoft.com%2Fen-
>> us%2Fwindows%2Fwin32%2Ffileio%2Fexfat-specification%2374102-offsetvalid-
>> field
>>
>> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
>
> Looks good!
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied, Thanks!
