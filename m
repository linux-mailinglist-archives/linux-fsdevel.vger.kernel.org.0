Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9F4D8D91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244764AbiCNT7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 15:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbiCNT7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:59:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA501FD36
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 12:58:27 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b9so10436153ila.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FoDbpPad98yBr/P4hDC6OztGJxe6FslUMUsgktjpSRY=;
        b=zcpz3auL0eUDeysh83YHCGAkEjQZy7D9iVBctpG8u/FzLqgyOwweObH4vp5ZaQjUMW
         /qQW5WHzJj2+UOjV0gs3rG3zsk8mROLXe7vH13Cdf2XRSuELdjUoSBvm471d0VXZK6TE
         /pzfZTqeQHLuIOyUnyBeNGsiXy4o2oE+QBsKnzyQHIvbcrX3kDu3cxkHvCYXtsWQFPih
         kqhjcULvDmaadjyL/ooTABD6ZafAhMatgovxozx1U139QWvL55UaRDTYjzcefXpU0t5q
         wnJNl/0bMPSod8ZBPXnG5iQSm6WdRRlQsG6KfI66KlY86aHo320lXCjEfEldEHT/hCUk
         jS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FoDbpPad98yBr/P4hDC6OztGJxe6FslUMUsgktjpSRY=;
        b=g+FhvOPYkbIKUpU+xnUCIKOGTNwytvytVurn3qxa8pznlMXzarzRlI47GjRewLCTIB
         ma1GVxGC4IUHIfNwWjMzzsY/c8V67LgnXq0zNRSmfarFHcVvboL1LSpi8Vj7dRqI/pPO
         S5RIyMVlUrxqRDPL8kJFNLXrJzlruuDt5pSEiEPMSe8+4iZPvrPBjP90f+yAa+u0ZEAA
         IfCENG0df8848GZsUlnBVaeBaflepW7HWFcX1fCjHGIpfrW73kF8xvKjIvronr09baOn
         rBU+Q7Ur2pRIegcZpuVjfehOYRcHUwo/FGpdegVjQCwwaCnKnbgc2Ho6hcGzLgeKA7VU
         MJWw==
X-Gm-Message-State: AOAM530kKWL7/2Ic4paqHR0grOtdMdbClC1Ei/4N++/luuklEn9mEyq6
        eHH1BL8RDSOffFbIfceU9Xvv5Q==
X-Google-Smtp-Source: ABdhPJxgchNSFavsqZ8EK1LwbgCOqE0/yyzu+VyrAE0z8wJ1JCkVNMruqyrYC8XnodmPzLeC58gvPw==
X-Received: by 2002:a92:cb04:0:b0:2c6:101d:6f9f with SMTP id s4-20020a92cb04000000b002c6101d6f9fmr19087412ilo.117.1647287907077;
        Mon, 14 Mar 2022 12:58:27 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e021a4f00b002c665afb993sm9993826ilv.11.2022.03.14.12.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 12:58:26 -0700 (PDT)
Message-ID: <0c40073d-3920-8835-fc50-b17d4da099f0@kernel.dk>
Date:   Mon, 14 Mar 2022 13:58:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To:     Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Cc:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
 <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
 <bf221ef4-f4d0-4431-02f3-ef3bea0e8cb2@acm.org>
 <800fa121-5da2-e4c0-d756-991f007f0ad4@kernel.dk>
 <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/14/22 1:40 AM, Avi Shchislowski wrote:
>>>
>>> Hi Jens,
>>>
>>> The "upstream first" policy applies to the Android kernel (see also
>>> https://arstechnica.com/gadgets/2021/09/android-to-take-an-upstream-
>> first-development-model-for-the-linux-kernel/).
>>> If anyone requests inclusion in the Android kernel tree of a patch
>>> that is not upstream, that request is rejected unless a very strong
>>> reason can be provided why it should be included in the Android kernel
>>> only instead of being sent upstream. It is not clear to me why the
>>> patch Bean mentioned is not upstream nor in the upstream Android
>>> kernel tree.
>>>
>>> From a UFS vendor I received the feedback that the F2FS write hint
>>> information helps to reduce write amplification significantly. If the
>>> write hint information is retained in the upstream kernel I can help
>>> with making sure that the UFS patch mentioned above is integrated in
>>> the upstream Linux kernel.
>>
>> I'm really not that interested at this point, and I don't want to gate removal or
>> inclusion of code on some potential future event that may never happen.
>>
>> That doesn't mean that the work and process can't continue on the Android
>> front, the only difference is what the baseline kernel looks like for the
>> submitted patchset.
>>
>> Hence I do think we should go ahead as planned, and then we'll just revisit
>> the topic if/when some actual code comes up.
>>
> We also supports Samsung & Micron approach and sorry to see that this
> functionality has been removed.

This isn't some setup to solicit votes on who supports what. If the code
isn't upstream, it by definition doesn't exist to the kernel. No amount
of "we're also interested in this" changes that.

What I wrote earlier still applies - whoever is interested in supporting
lifetime hints should submit that code upstream. The existing patchset
to clean this up doesn't change that process AT ALL. As mentioned, the
only difference is what the baseline looks like in terms of what the
patchset is based on.

-- 
Jens Axboe

