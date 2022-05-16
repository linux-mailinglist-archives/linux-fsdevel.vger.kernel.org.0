Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8031529563
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 01:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350373AbiEPXjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 19:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350362AbiEPXjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 19:39:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C12B42EFD
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:39:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c14so15434700pfn.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XF8HrHuc0vvXL5ulzkwN++ArfuC+zDk8XGj6ZMrmANc=;
        b=KJxxLsXKOBiUNDDUoqoBtb/p7IY4oc5GmozcBWlwK3CxavqBBEvI+qYl4nEpc/DnO2
         2232X2VR7ycRkCKanRTt15BjZWm8Kv8znTSOGp7bkc15a3Zv3qcU5Qcr5jAhSYPORoKa
         ELPVVOUHcs4rdTu7GPzn63D3acWzGQqI31ZpL48zW8j7y4hukxEFgQKHfPNH2BgwqEpd
         7KzPNueWd1q8rzOV7lH1lkgr0egMWUkkKgdjA/ubPMa9OZDygh5++6iDOS2hMIu/GqkC
         Hs41CyjbtlLJs6d7mX1Q2plFTEgFnEuQbzGgj7mu59jYk4OquC/A9TLy/APJEM1KgX9V
         lK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XF8HrHuc0vvXL5ulzkwN++ArfuC+zDk8XGj6ZMrmANc=;
        b=DVjn2rOngmTta5VOIsU5BuS6f7VZJ1nS93v4n7X926ErTzmVkBLtRs8Lx++t6vptNw
         8/pJv8TKtOSrI7Un7HfoSLPYx9ZKjajLoBXJ00i0Pqgmz4LR8kCU0IzUM34N3Ve6IIYJ
         ZbaH0znu0VzYgjrq96DcPDNUx2FYuh+7+z8kF/FcU9g/UDaa9Y2g+rDLKMUTvPj+YsDK
         2YPJ67bvVJgBZk0ttaw69N09YWKGWv6uC3lKa55gfZmtCaBMWB5qqt5kV5+ERezqio5a
         S4VRk7QMhZiUT6U7mpiYIyyhwHevDUqFkLLCftxX08LIWQzn0y1OvmDx1W7mqisHsvxH
         Dlwg==
X-Gm-Message-State: AOAM531ph3BKk7aI0T22YjGU+uYH8HaHOHShPiDtjuLXe1s/Kzyh4QjL
        lfdt/1t+MUv5s+re43LNHXZtog==
X-Google-Smtp-Source: ABdhPJyUbvL08b6tPGpHcEYNkEOOS+p4DFKOwH/m8NNZ0N15foYjCdJvoFgACWLol/4k1m3GyTTKWw==
X-Received: by 2002:a05:6a00:1acf:b0:50e:1872:c6b1 with SMTP id f15-20020a056a001acf00b0050e1872c6b1mr19365180pfv.76.1652744340860;
        Mon, 16 May 2022 16:39:00 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id w71-20020a62824a000000b0050dc7628146sm7335987pfd.32.2022.05.16.16.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 16:39:00 -0700 (PDT)
Message-ID: <fe20ae9b-041d-a5eb-d32b-7c79a87e8cf0@linaro.org>
Date:   Mon, 16 May 2022 16:38:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] exfat: check if cluster num is valid
Content-Language: en-US
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a4087e40b9c13aad7892@syzkaller.appspotmail.com
References: <20220511185909.175110-1-tadeusz.struk@linaro.org>
 <CGME20220511185940epcas1p1e51c30e41ff82ae642f8f949ffa4b189@epcas1p1.samsung.com>
 <20220511185909.175110-2-tadeusz.struk@linaro.org>
 <000101d8686b$56d88750$048995f0$@samsung.com>
 <c9ab0896-b19b-b8b8-cf63-ad437a123270@linaro.org>
 <CAKYAXd_kcZF0tHMX_CsR83qmX25PhdGQPJibMh1-30=5przrjQ@mail.gmail.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <CAKYAXd_kcZF0tHMX_CsR83qmX25PhdGQPJibMh1-30=5przrjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/16/22 16:31, Namjae Jeon wrote:
>>> Looks good.
>>> And it seems that WARN_ON() is no longer needed.
>> Right. Do you want me to send a follow up patch that drops the WARN_ONs?
> You don't need to do it. I have applied this patch to #exfat dev
> branch after removing it.
> Note that I have combined 1/2 into 2/2 patch.
> Thanks!

That's fine with me. Thanks for taking it.

-- 
Thanks,
Tadeusz
