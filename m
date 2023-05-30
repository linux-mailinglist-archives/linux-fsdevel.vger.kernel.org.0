Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FED715447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 05:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjE3Dw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 23:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE3Dw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 23:52:58 -0400
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D600194;
        Mon, 29 May 2023 20:52:54 -0700 (PDT)
X-QQ-mid: bizesmtp81t1685418745t0j79p3h
Received: from [10.7.13.54] ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 11:52:23 +0800 (CST)
X-QQ-SSF: 00400000000000C0G000000A0000000
X-QQ-FEAT: uGhnJwy6xZKQgr+3IOv7zgYG+jIoGN5fXqB764XoEXsyXZrrCNhMRTH6TcKsh
        +FeQkoHqcSWC1IVb/Vp4JxZfyHdUji3Enx+pSjzMy0V7uqX25byOcTwhWRlOAgi43hXFZzu
        byEAdG9QUVDJH6WHlQLg38R0lem4xiG5Oe03CLQbIKpKxEZby7TscL1UzsGjf5ArMvVnpX/
        Pk0g8CAMTHU1wT0tSwCTrmQCPMny/yLJqRd3gIoZKQ8SqMt9kYJfOxT0l8+dg5bo+qSvOR/
        KTtBLDtJ8aDGcC/qNzDHNgutJf1YYM6Am0949nFHVK98FIRdgjhb8Ak/l1c78ccnlJlbW8c
        85UZn/+ISmrGHZntYPK1A/V+Tassx+32MtxjFLOITUfMjSib3X/mxWWWMNj0Mu4IB+/0+qJ
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 870657424802009201
Message-ID: <5831484AA6DAA62C+3ead8eff-7b84-f42e-7103-8b9894c67037@uniontech.com>
Date:   Tue, 30 May 2023 11:52:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/buffer: using __bio_add_page in submit_bh_wbc()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530033239.17534-1-gouhao@uniontech.com>
 <ZHVv+rPl7iL3dMqi@casper.infradead.org>
Reply-To: ZHVv+rPl7iL3dMqi@casper.infradead.org
From:   Gou Hao <gouhao@uniontech.com>
In-Reply-To: <ZHVv+rPl7iL3dMqi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/5/30 11:39, Matthew Wilcox 写道:
> On Tue, May 30, 2023 at 11:32:39AM +0800, gouhao@uniontech.com wrote:
>> From: Gou Hao <gouhao@uniontech.com>
>>
>> In submit_bh_wbc(), bio is newly allocated, so it
>> does not need any merging logic.
>>
>> And using bio_add_page here will execute 'bio_flagged(
>> bio, BIO_CLONED)' and 'bio_full' twice, which is unnecessary.
> https://lore.kernel.org/linux-fsdevel/20230502101934.24901-5-johannes.thumshirn@wdc.com/
>
> You could send some Reviewed-by: tags to that patch series.
>
Ok, I didn't notice this patchset, thank you for your review.

-- 
thanks,
Gou Hao

