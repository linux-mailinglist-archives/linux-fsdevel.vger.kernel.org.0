Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742334D9EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiCOPqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiCOPqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:46:08 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449612A88
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 08:44:56 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o12so13578214ilg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kU+GLJEFYIiN6NGm+q/bq337K/F3drtFqv3LO1H4fKE=;
        b=gT6Y1bbmKjfoWVGM6TuXc6Ew3txTgEY9NUokJyBPFxsps4dxNt108edzQMlliVyula
         oSIaGoB2zOd7tJBXXETitXby9wwwghsCALOxo9SclxNe/c2zLW2xT7DuzfGcx2oj1B+d
         xUaer0hBghpARihJCQG30tsZLNXZpVr0PU0tzOsBSY4KT6vt2STQAbQ4ZmCFXva3rwtk
         8q7qLksIoMvpIw/WA2Kbc2QvQ2NIV4aADl5cST4HOY2frRlQWn1fH23PbDGkRljqI9NN
         isLqrW4T0Ot7sJZElLaOFWkBsmvrMFUQ21PRhs8farpcJiB9D4vvpUd0tvp1DFjMtJWo
         41wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kU+GLJEFYIiN6NGm+q/bq337K/F3drtFqv3LO1H4fKE=;
        b=bfeDP4bFbLX6lt+1PTFLAH4OXzT1KNV+uTYfWGrBlU2dAwsZmr6HOytUX1RCCxKqK6
         NQJfj5unJsDBgNQG3o0KWy03hi4kPzU8floHcXc46wImMP7H/JZAjkiE+dq078rM0ssB
         7S4ic98RDe95wS8l5m94WNl78bWR4aYBztgZmd6E5p1P9dNokB6lclRbc42R/E8shjfi
         hl7AdewW7Zt0E60ufzlDYTjvdTj3KaRg+KB4+VPKKsbwYw8IsY6KBIRIj7sPW7LV19LQ
         X1X6Sy8tjl3fCMW6eRzTt3YiMhbHCrqoQZknXaSN0Xh27eOUIftVBNfM5o/unlN9gnBe
         onDw==
X-Gm-Message-State: AOAM533CszirZqQe2IC3dG2nkYEFq0b1r4Pw/4K3U/Itq+RHvAEhwRXd
        gGkbIMj7pmIz5ANZtWEfU7bnHA==
X-Google-Smtp-Source: ABdhPJyych0DqX/cH/hqdWSDTCrkBK3odSgH+RTperxlzi4UKTip9ytPQ9AbkvcaBJmp6mZx9NU3nA==
X-Received: by 2002:a92:ca45:0:b0:2c7:c473:6785 with SMTP id q5-20020a92ca45000000b002c7c4736785mr800177ilo.40.1647359095651;
        Tue, 15 Mar 2022 08:44:55 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s10-20020a6b740a000000b006413d13477dsm10427409iog.33.2022.03.15.08.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 08:44:55 -0700 (PDT)
Message-ID: <95588225-b2af-72b6-2feb-811a3b346f9f@kernel.dk>
Date:   Tue, 15 Mar 2022 09:44:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To:     "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
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
 <0c40073d-3920-8835-fc50-b17d4da099f0@kernel.dk>
 <CO3PR08MB7975EF4B014E211ACFAB7AF4DC109@CO3PR08MB7975.namprd08.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CO3PR08MB7975EF4B014E211ACFAB7AF4DC109@CO3PR08MB7975.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/22 9:36 AM, Luca Porzio (lporzio) wrote:
>>
>> This isn't some setup to solicit votes on who supports what. If the code isn't
>> upstream, it by definition doesn't exist to the kernel. No amount of "we're
>> also interested in this" changes that.
>>
>> What I wrote earlier still applies - whoever is interested in supporting lifetime
>> hints should submit that code upstream. The existing patchset to clean this
>> up doesn't change that process AT ALL. As mentioned, the only difference is
>> what the baseline looks like in terms of what the patchset is based on.
>>
> 
> Jens, 
> 
> Actually we might work to issue a patch and revert the patch plus add
> the code that Bean and Bart mentioned which is currently Android only.
> The reason it has not been done before is because for now it's not
> production yet but it may soon be that case.
> 
> Would this patch revert be an option and accepted as a closure for
> this discussion?

What patch revert? It's not clear to me which patch you're talking about
here. If you're talking about the "remove the per-bio/request write
hint" patch, then no, that's certainly not being reverted. See previous
replies I made and also below for why, and let's please stop beating
this dead horse.

> Another option (which I actually prefer), if I ask for a MM & Storage
> BoF discussion on storage hints where I can show you the status of
> temperature management and my studies on how this is beneficial for
> storage devices. 

As long as it's accompanied by code that implements it, then that would
be fine.

> Would this be more beneficial and maybe get some wider consensus on
> the write hints?
> 
> After that consensus reverting (or agreeing on a new approach) will be
> easier.

As I've said multiple times, whenever code is available, it'll be
reviewed and discussed. I don't like to discuss hypotheticals as too
many times in the past there's a promise made and expectations built
only for nothing to materialize. As it stands, the only in-kernel user
of the hints is gone, and that means that the support code is being
removed. We NEVER keep code in the kernel that doesn't have a user, as
it can't get tested.

Submit your patches when they are ready, it really has no bearing on the
currently queued up changes to write hints.

-- 
Jens Axboe

