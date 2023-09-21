Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292027A9D8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjIUTkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjIUTkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:40:04 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3ECB15CB;
        Thu, 21 Sep 2023 12:39:03 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso11185885ad.1;
        Thu, 21 Sep 2023 12:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695325143; x=1695929943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcCQ3vH6N1f8T1a0qZrsTcM92wz//w1cX3ijbt7R918=;
        b=Y52Vxjl1C8sxyu2rLbVawIvEUmGhFgIusNus8pTvhI2oYrGijda/wrkKwwwXJ7NFh+
         ogPkH+5qn+uU/bpboPIldrwLxdaZ6MtZ5qznbj0pEUlwUNIaqvd7eADurk9gMv0m6Hv+
         aCEYd7FOTNxjEY1Lij23E/MCB35zVF8WQEw2WHRYLygSRLjRis6SizCiaGNJgIGOy3o4
         UACuO0dp5EC1aa9EyzCBLoeWIrq9I3DZLhH3csOL1wZsG2DVKrPgX64RZ8SN7A8lKfzi
         bGEW6EWPoXNir0g911rLk9KIXU8qFSGOmGmQkhY9B+3hD0ymaaERQW5xtWQBI4zDpBt2
         BFbQ==
X-Gm-Message-State: AOJu0YwSAmWgi+ckyBUM5UQavRuxF20PXPMjZhbDdH4XchhgH7hMrapu
        GDdLwZGpB3Pk5jpTLkGmwYAjBDEMrIY=
X-Google-Smtp-Source: AGHT+IHKh2qF1vM5b1BhoS5Pcq7w5pOE8RZALp9IVGvCcrcfbKScKtyPplWTv7tWoSMZz/e4YVvk+g==
X-Received: by 2002:a17:902:b782:b0:1c4:a650:21df with SMTP id e2-20020a170902b78200b001c4a65021dfmr5773376pls.50.1695325142606;
        Thu, 21 Sep 2023 12:39:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6903:9a1f:51f3:593e? ([2620:15c:211:201:6903:9a1f:51f3:593e])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001b9dab0397bsm1909089plg.29.2023.09.21.12.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 12:39:01 -0700 (PDT)
Message-ID: <4cacae64-6a11-41ab-9bec-f8915da00106@acm.org>
Date:   Thu, 21 Sep 2023 12:39:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
 <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org> <ZQv07Mg7qIXayHlf@x1-carbon>
 <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
 <ZQyZEqXJymyFWlKV@casper.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZQyZEqXJymyFWlKV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/23 12:27, Matthew Wilcox wrote:
> On Thu, Sep 21, 2023 at 07:27:08AM -0700, Bart Van Assche wrote:
>> On 9/21/23 00:46, Niklas Cassel wrote:
>>> Should NVMe streams be brought back? Yes? No?
>>
>> From commit 561593a048d7 ("Merge tag 'for-5.18/write-streams-2022-03-18'
>> of git://git.kernel.dk/linux-block"): "This removes the write streams
>> support in NVMe. No vendor ever really shipped working support for this,
>> and they are not interested in supporting it."
> 
> It sounds like UFS is at the same stage that NVMe got to -- standard
> exists, no vendor has committed to actually shipping it.  Isn't bringing
> it back a little premature?

Hi Matthew,

That's a misunderstanding. UFS vendors support interpreting the SCSI 
GROUP NUMBER as a data temperature since many years, probably since more 
than ten years. Additionally, for multiple UFS vendors having the data 
temperature available is important for achieving good performance. This 
message shows how UFS vendors were using that information before write 
hint support was removed: 
https://lore.kernel.org/linux-block/PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com/

This patch series implements support for passing data temperature 
information from F2FS to UFS devices in a standards-compliant way.

Thanks,

Bart.
