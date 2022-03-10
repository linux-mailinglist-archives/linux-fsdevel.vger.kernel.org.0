Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6EF4D547B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 23:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbiCJWTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 17:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiCJWTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:19:23 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0AF4EF60;
        Thu, 10 Mar 2022 14:18:22 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id n15so6135156plh.2;
        Thu, 10 Mar 2022 14:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5X5xVWc1nkDEIZdla3XpRNW/bQySQD0uGStRSZKwtGE=;
        b=IBZfoKfGrgIwVgfLYskv27A7+PQBvlBev/0B6zmUjP5ASHmO8YgY0jpYnLplphXFlT
         DSywr/P8HZxzbRJFbdpgGyQ3EyJggTdXOnpkGkWpo5SoUeVG0xnlwXYJuUBC7YTtzGyx
         iAd/TVoA1JBI3tyHH8cfnJiQp25UyZAEr0o633/ZwILdCYqPKN66sI2fckkvHoQpQ/b6
         G9TQJaJ0UzzYY4S/rY/+mU2i0tytn2bO0rGv1zjo+MhShTk8hGaaIqVg5I6VLksN6hMT
         s5oBC/gIEc9oAl8YDWzedqRzBOCMibXEQaHNbmKXIXjeBsr2h1fLPS+zFXVWA7ieW3vY
         fILA==
X-Gm-Message-State: AOAM5332tZtBUKhhJ2jOsR+EuHPrz4jjdng5RxSGS+utseCHcELVy+nZ
        MphcXp1ugIaVZuy6IR0sNk77WNhKt8A=
X-Google-Smtp-Source: ABdhPJy62zhEbGvei3QmnuKG1X3fqXb+LD/edNZIPKgqnhwAVLyBG86WPVpfaMOVxXBkkDzB2GptKQ==
X-Received: by 2002:a17:902:f646:b0:151:d5b1:cbb4 with SMTP id m6-20020a170902f64600b00151d5b1cbb4mr7207735plg.150.1646950701430;
        Thu, 10 Mar 2022 14:18:21 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:8b4d:7ed7:9546:30d2? ([2620:15c:211:201:8b4d:7ed7:9546:30d2])
        by smtp.gmail.com with ESMTPSA id o5-20020a056a0015c500b004f76735be68sm5366491pfu.216.2022.03.10.14.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 14:18:21 -0800 (PST)
Message-ID: <9d645cf0-1685-437a-23e4-b2a01553bba5@acm.org>
Date:   Thu, 10 Mar 2022 14:18:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Jens Axboe <axboe@kernel.dk>,
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/22 13:52, Bean Huo (beanhuo) wrote:
> Yes, in upstream linux and upstream android, there is no such code. But as we know,
> mobile customers have used bio->bi_write_hint in their products for years. And the
> group ID is set according to bio->bi_write_hint before passing the CDB to UFS.
> 
> 
> 	lrbp = &hba->lrb[tag];
>   
>                WARN_ON(lrbp->cmd);
>               + if(cmd->cmnd[0] == WRITE_10)
>                +{
>                  +             cmd->cmnd[6] = (0x1f& cmd->request->bio->bi_write_hint);
>                +}
>                lrbp->cmd = cmd;
>                lrbp->sense_bufflen = UFS_SENSE_SIZE;
>                lrbp->sense_buffer = cmd->sense_buffer;
> 
> I don't know why they don't push these changes to the community, maybe
> it's because changes across the file system and block layers are unacceptable to the
> block layer and FS. but for sure we should now warn them to push to the
> community as soon as possible.

Thanks Bean for having shared this information. I think the above code sets the GROUP
NUMBER information in the WRITE(10) command and also that the following text from the
UFS specification applies to that information:
<quote>
GROUP NUMBER: Notifies the Target device that the data linked to a ContextID:
  -----------------------------------------------------------------------------------------
     GROUP NUMBER Value     |  Function
  -----------------------------------------------------------------------------------------
  00000b                    | Default, no Context ID is associated with the read operation.
  00001b to 01111b (0XXXXb) | Context ID. (XXXX I from 0001b to 1111b ‐ Context ID value)
  10000b                    | Data has System Data characteristics
  10001b to 11111b          | Reserved
  -----------------------------------------------------------------------------------------

In case the GROUP NUMBER is set to a reserved value, the operation shall fail and a status
response of CHECK CONDITION will be returned along with the sense key set to ILLEGAL REQUEST.
</quote>

Since there is a desire to remove the write hint information from struct bio, is there
any other information the "system data characteristics" information can be derived from?
How about e.g. deriving that information from request flags like REQ_SYNC, REQ_META and/or
REQ_IDLE?

Thanks,

Bart.
