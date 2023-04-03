Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E0C6D4E9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjDCRDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjDCRDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:03:03 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795081BC2
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 10:03:02 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q6so13147445iot.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680541382; x=1683133382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pv2e1nejGflis5z/amTqMpYRfwfde4hXbn2jhvpNvpk=;
        b=DEfPkQLni17F23KdO/tpnzhwFJreKydeZK3/f2qvqYOft7PZ47OpIQdDMOQtXnX0XQ
         f6/5CPN4MeAqXgTQmF/NLeGg42++Nru8OS9ZgyRsEumvdVNQs8NsjZOoM1luZjiXCNL2
         qU54OQ6iBtB420Hn87pKQ4vQx827K6nzzZboA2HRn2PIxw4AHPgtVH8AO2+sILClDc3j
         dkDZN+dFxrpCBPP6425eojkaiKF/SBUzQTkFQ9aYx7muoxv3wcHGb6efB/gAnWWXZib3
         /e01RqODf6sZ4uClPrT4H+XiQz+tfrSlsLSTYcTCHdDuGvyOPx7FAjNRb+/kRjYCUgjZ
         czVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541382; x=1683133382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pv2e1nejGflis5z/amTqMpYRfwfde4hXbn2jhvpNvpk=;
        b=RcXX+ef6ZKdEENgK1BiZNADm/LpnjX/cTZlBkcXapeN9JEUD2ZdnmfDZb1PeyL/795
         kuRWIBrxJuXX0N+tkbPQwtomD5C6Lv8OZhT7gh5NSm7lolV48LxMQbp7GgfPHtkdZRA2
         P2j78nVUE65yD+97gm0NNdRKFbd8e7PurroLp8RWgdW++R7hQU1iVoqUo3yDnwKgpfdq
         efWH2NAcVIM7yPR41UiJJDoMTm2unXNXGJMeMHp17US8WguU9BQ170NudJYP12btqAms
         lzgitRabb2lqtTP3SuXvyKzz4xQ10QFVAFHH5KjNR0WWlsDdM+Jh8BFJp62b2QNcGSU3
         SwWA==
X-Gm-Message-State: AAQBX9ciZMlHPT1GuVwB7Wi51Emy6jE+rSQjXpnLdIi//V71jznctG27
        SrI9BcaiBB2uCDiJtfOwvXPjGSJ1/bPN1VPbQF68sg==
X-Google-Smtp-Source: AKy350YpvW4Q8l8cPh6azEgpcbv4aCC/iPL6RRFhCtBgwuNcrS4+Yijcv0O8vGuXe8PYdXQqELkPNQ==
X-Received: by 2002:a05:6602:1209:b0:758:6517:c621 with SMTP id y9-20020a056602120900b007586517c621mr97641iot.2.1680541381704;
        Mon, 03 Apr 2023 10:03:01 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m24-20020a056602019800b007596e6ea7d5sm2898395ioo.52.2023.04.03.10.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 10:03:01 -0700 (PDT)
Message-ID: <cd875f29-7dd8-58bd-1c81-af82a6f1cb88@kernel.dk>
Date:   Mon, 3 Apr 2023 11:03:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] splice: report related fsnotify events
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230322062519.409752-1-cccheng@synology.com>
 <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
 <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/3/23 11:00?AM, Amir Goldstein wrote:
> On Wed, Mar 22, 2023 at 9:08?AM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Wed, Mar 22, 2023 at 8:51?AM Chung-Chiang Cheng <cccheng@synology.com> wrote:
>>>
>>> The fsnotify ACCESS and MODIFY event are missing when manipulating a file
>>> with splice(2).
>>>
> 
> Jens, Jan,
> 
> FYI, I've audited aio routines and found that
> fsnotify_access()/modify() are also missing in aio_complete_rw()
> and in io_complete_rw_iopoll() (io_req_io_end() should be called?).
> 
> I am not using/testing aio/io_uring usually, so I wasn't planning on sending
> a patch any time soon. I'll get to it someday.
> Just wanted to bring this to public attention in case someone is
> interested in testing/fixing.

aio has never done fsnotify, but I think that's probably an oversight.
io_uring does do it for non-polled IO, I don't think there's much point
in adding it to IOPOLL however. Not really seeing any use cases where
that would make sense.

-- 
Jens Axboe

