Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FAF4FCBCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 03:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiDLBTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 21:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiDLBRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:17:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F82387B2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 18:12:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so1142360pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 18:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q/Xg6ga80J/OVjhLPewSy7w7ND5AlRAN7OUXJQ4TYtA=;
        b=HHldRoUblJBfsJVN4QNVPrznetchzYAfkycaQUL6nBM2bArvEdxJ+6F2fsFwaNTOtf
         uJA3H15AnKBtrC4G9I4eTGnyaQzjIphF+l+sPnRzVHuCAfR6JJq+qfvHFRkk3jgBthAk
         0RmkjJxXiSUCNu99kAogukrPk9HpGgAMxKaAO3Ejud8u1R1UILDnYgitsyUmD2LW8aeM
         aAKX9wOBI4ZeX+KYelGD0OyymiVtFt4ZiD8WgZ37N6QYa+2aFVrj7opXubFBcEtoDC65
         sHeGpNOJnkoKhzhRhOZxt1S/OmpkXdeiN4vnJ2GxBCtEbllFbHIyi6+siodBhIxVHquW
         A4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q/Xg6ga80J/OVjhLPewSy7w7ND5AlRAN7OUXJQ4TYtA=;
        b=xZ6CgIpIKHaLxEyEsb+/NwN9TGQSEDuIhr+gWDRXM40ph27W0dYqkp80LyYFIPzPSP
         lVeOAXOVabETjq8o0s/2/ojhC18WHjbLn3w2hvwpR9rB2ULEoOC/JhScuDxFndV9qYh0
         IBLQPoYtiGDTfLxiv7XK5Vj5rys2LuF7LTiGwOM+FfIIu8WufEiqZdjG2X3+xNhGpZFi
         a/oJtqHX7BLxtw7/6mhAfaCejM/0DfG09WdrUbn+kM45ErJtNg7ou+r1BwTdsIdrTTTA
         lMCukxAUbDO7GbKdlRViQfjwvI3EQ/w+B4SEX0RCY32nxHb/iCK4QPknuT9KJ0Z2xFOF
         IeTg==
X-Gm-Message-State: AOAM530mjFC3aqVErSvV8q9/l1ulztimH7paqffNT9FxNmQQ3BQZkGJQ
        aTDHQSihAPCdqWR5F6/oiZ430g==
X-Google-Smtp-Source: ABdhPJx3HLMcm4CPuIJjAy9/1D40rZdTsVlxqtwNr6sg0Yv4f5XEyOq5sCWeeFg4nczVPVotgUqQlg==
X-Received: by 2002:a17:90b:2248:b0:1cb:be19:822e with SMTP id hk8-20020a17090b224800b001cbbe19822emr2148730pjb.22.1649725950479;
        Mon, 11 Apr 2022 18:12:30 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u206-20020a6279d7000000b00505fdc42bf9sm217263pfc.101.2022.04.11.18.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 18:12:30 -0700 (PDT)
Message-ID: <01626f93-e982-8631-4196-112a8bb4a01a@kernel.dk>
Date:   Mon, 11 Apr 2022 19:12:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] block: add sync_blockdev_range()
Content-Language: en-US
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
References: <HK2PR04MB3891FCECADD7AECEEF5DD63081E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Yk/DpSwR8kGKWJYl@infradead.org>
 <CAKYAXd9NAUjdxT2GOWGoPvH5nOXSFtD7u0t_9rCiZx7hSGC0PA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAKYAXd9NAUjdxT2GOWGoPvH5nOXSFtD7u0t_9rCiZx7hSGC0PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/10/22 8:08 PM, Namjae Jeon wrote:
> 2022-04-08 14:09 GMT+09:00, Christoph Hellwig <hch@infradead.org>:
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Thanks for your review!
> 
> Hi Jens,
> 
> Can I apply this patch with your Ack to exfat #dev ?

Yes go ahead:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

