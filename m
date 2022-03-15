Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57B94DA32D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 20:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351093AbiCOTSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 15:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343728AbiCOTSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:18:12 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A135BC25
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 12:17:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j29so143943ila.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eL4sEejnIjRxB4JWoRE5TkBnrkIdyteUkUcF+BL1sSQ=;
        b=iWusSnyufgd83jlYqM4JHVKtsPOkpeX26OBrpct/3WmiG7LnWH9Sw3iFkRchjrkllG
         fCOnkNOL47gKyFwFk34esKLgS5xwFS43UsOhSq2K5J9AL7OXoQtrYAypDSeWnX9UnANu
         tlzklxEUzzZ7P42WwYpfCZ/HjZjaIM9p422WSLNBo86IEpP09x96xNThPURpZGqnhEIL
         /Q0iYgmlitOsg5E6LDgge/udLSlvl+Yl9xHUrXwYfehcdT60LYL/M4+ft5fpu0fLaTKI
         9Dt8Je9d2Uaat5Lb5PSG5MXaCRvDfO5dGKQMtyywtqZLztL4u388vFvuBJf3r7mrrJ0U
         HXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eL4sEejnIjRxB4JWoRE5TkBnrkIdyteUkUcF+BL1sSQ=;
        b=f31XwuCK9xXrXRcrdAFcAKPVoTZVibA/uZuYwh3hmu3M6j67r4mkhdWLsWAp2kWdSF
         zymnTfsw4MA0yLOcJ4G5D3glu3GKI74kqC+wJFSQPcDjTPUtbBqXpxSuXYIA6GZNefEB
         Gc2P/Rirnc4exEnho6Qsf9gXEte3ANPALZkMJkDyD/3gHPh2aIStC1PRo3zgjyb6OFtT
         HsjrLDLQwhLz7/h3OyAb0p98Aq9rbFydjzPO4DIldaB8r2HhEJSmNhFxDNMgRTKtBwsI
         StjWQoOT0eHiOr2XGztQXQdNWELVisUk2r8ufkuZ/dFaGsI89ck/YAJ7hm1sTaDbQypH
         saXQ==
X-Gm-Message-State: AOAM533v3qCHQtGJmMIebqIUS0TO8u69NMOXr+NqLT3tFABEzUIp+Kry
        LETAqktPcZTDiDg9hLXenzaB1Q==
X-Google-Smtp-Source: ABdhPJwfwkhPbUSNuER4dSGumai8h5J30xjSdLJssPXV9o5H9SJSGbfw+XVUNtU2YWf8x+hLHgfNHQ==
X-Received: by 2002:a05:6e02:2190:b0:2c6:45ba:f3cc with SMTP id j16-20020a056e02219000b002c645baf3ccmr22364960ila.141.1647371819959;
        Tue, 15 Mar 2022 12:16:59 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l6-20020a056e0212e600b002c7a2a977c3sm3831995iln.20.2022.03.15.12.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 12:16:59 -0700 (PDT)
Message-ID: <72af146c-3cbf-73ce-4788-d999518d47a4@kernel.dk>
Date:   Tue, 15 Mar 2022 13:16:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <CO3PR08MB7975BCC4FF096DD6190DEF5DDC109@CO3PR08MB7975.namprd08.prod.outlook.com>
 <73adf81b-0bca-324e-9f4f-478171a1f617@acm.org>
 <PH0PR08MB7889A1EB0A223630E8747A53DB109@PH0PR08MB7889.namprd08.prod.outlook.com>
 <4cfa6143-3082-52ee-6d6d-b127457ac2e4@kernel.dk>
 <PH0PR08MB7889314A7E3C8FEC1E7A491CDB109@PH0PR08MB7889.namprd08.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <PH0PR08MB7889314A7E3C8FEC1E7A491CDB109@PH0PR08MB7889.namprd08.prod.outlook.com>
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

On 3/15/22 1:04 PM, Bean Huo (beanhuo) wrote:
>> -----Original Message-----
>> From: Jens Axboe <axboe@kernel.dk>
>> Sent: Tuesday, March 15, 2022 7:49 PM
>> To: Bean Huo (beanhuo) <beanhuo@micron.com>; Bart Van Assche
>> <bvanassche@acm.org>; Luca Porzio (lporzio) <lporzio@micron.com>; Luis
>> Chamberlain <mcgrof@kernel.org>; linux-block@vger.kernel.org; linux-
>> fsdevel@vger.kernel.org; lsf-pc@lists.linux-foundation.org
>> Cc: Matias Bj?rling <Matias.Bjorling@wdc.com>; Javier Gonz?lez
>> <javier.gonz@samsung.com>; Damien Le Moal <Damien.LeMoal@wdc.com>;
>> Adam Manzanares <a.manzanares@samsung.com>; Keith Busch
>> <Keith.Busch@wdc.com>; Johannes Thumshirn <Johannes.Thumshirn@wdc.com>;
>> Naohiro Aota <Naohiro.Aota@wdc.com>; Pankaj Raghav
>> <pankydev8@gmail.com>; Kanchan Joshi <joshi.k@samsung.com>; Nitesh Shetty
>> <nj.shetty@samsung.com>
>> Subject: Re: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage

All of this is duplicated info too, it just makes your emails have poor
signal to noise ratio...

>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you
>> recognize the sender and were expecting this message.

Same

>>> Micron Confidential
>>
>>>
>>> Micron Confidential
>>
>> Must be very confidential if it needs two?
>>
>> Please get rid of these useless disclaimers in public emails, they make ZERO sense.
>>
> 
> Sorry for that. They are added by outlook automatically, seems I can
> turn it off, let me see if this email has this message.

In general, advise for open source or open list emails:

- Don't include any "Foo company confidential", which by definition is
  nonsensical because the email is sent out publically.

- Wrap lines in emails. Wrapping them at 74 chars or something like that
  makes them a LOT easier to read, and means I don't have to wrap your
  replies when I reply.

- Don't include huge headers of who got the email. That part is in the
  email headers already, and it's just noise in the body of the email.

- Trim replies! Nothing worse than browsing page after page of just
  quoted text to get to the meat of it.

That's just the basics, but it goes a long way towards making email a
more useful medium. And making the sender/company look like they
understand how open source collaborations and communication works.

-- 
Jens Axboe

