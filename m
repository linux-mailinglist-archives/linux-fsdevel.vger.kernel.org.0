Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF51732B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbjFPJYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjFPJYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8437610F6;
        Fri, 16 Jun 2023 02:24:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f764e9295dso566039e87.0;
        Fri, 16 Jun 2023 02:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686907455; x=1689499455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2ZidesCyGed39/0NrAMzVkxRWEoJxRq3gU1nQ6jA3s=;
        b=RjZ5UUhZMILEogZMjTV09imH1SGGw4RV9jRB1l+ct3zE3cIzoDvhQVRpm/T2YW9jJe
         jZGFVUV42Qa2Amaa4+TABp4yCs5wfFFNiMfzGse8cSm4q+x3I3Iek45F52q+27qcF/x5
         czjwFEgOJNcj3Q0vwVsItS8sDPsKdCgr6SdMO7vo9UbUSsjH0nfz9rDR/Q5kZpE/lJYf
         0Z2kHTdvrrnCdoii87zvk62QHAitgaj6Hf0tEswER1/S7YR584Rf8F8ClxkFXWo2Ssbc
         td3KPp5w8It/UNssTY+JiQV4BhMLAwO72xB1fIHhGFAEjZAJVDn3wdKXzTVte/0j+ewc
         vT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686907455; x=1689499455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2ZidesCyGed39/0NrAMzVkxRWEoJxRq3gU1nQ6jA3s=;
        b=dcCpfc8zFwP0AJBo4FC3+ExNV5L4NjfGg5vZZqJyYr85rsirHDeRzQlp8Ti7B5YEbw
         xASdOiBpr4orDpaDHfB8C2ZoQJbfwU628gIqavzPfBPfAYTZzPFlK8SkhWJ+GKdSSWZM
         hbcE8GBOqSCLV1IbqfZ8vr/rauKpDTw/9hTSl5I8gL2Lu2T6lDGg9uHwy6HNBGytR1MY
         A5wQotHZCBd1rTscrvKIvdJnvoT86BdaNlKoVfcVpaR37gyQX8hs45jBxJ13rJXfUvTQ
         qM29EHhmyp4KtFMs5SPwWVom9sah7MYOqDoSS3otEyXh1Ejb33H1V6P6iDFgs4BLDpfj
         UHWg==
X-Gm-Message-State: AC+VfDx9gVsQJEoaDTsM4regnjqgkFwrcj7EDI+fdg1tTfrJeORF4LYJ
        Y5y3bJAJ8EwD/4rkDD7eYy4=
X-Google-Smtp-Source: ACHHUZ7nqduW0IQSoyQgWp7diMEIl/88eRMdAjqvJinlXou4yjnRbQbzf1LITxthVY1yGWFhUUJ4VQ==
X-Received: by 2002:a19:3854:0:b0:4f7:638b:53b with SMTP id d20-20020a193854000000b004f7638b053bmr690526lfj.29.1686907454484;
        Fri, 16 Jun 2023 02:24:14 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d620e000000b0030ae4350212sm23204598wru.66.2023.06.16.02.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 02:24:11 -0700 (PDT)
Message-ID: <9296a67f-8fba-f4c9-c3b6-db9d85db7d11@gmail.com>
Date:   Fri, 16 Jun 2023 11:24:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 1/1] memory: export symbols for process memory related
 functions
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?B?V2VpLWNoaW4gVHNhaSAo6JSh57at5pmJKQ==?= 
        <Wei-chin.Tsai@mediatek.com>,
        "willy@infradead.org" <willy@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWVsIExlZSAo5p2O5aWH6YyaKQ==?= <Mel.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20230609110902.13799-1-Wei-chin.Tsai@mediatek.com>
 <ZIMK9QV5+ce69Shr@shell.armlinux.org.uk>
 <5cc76704214673cf03376d9f10f61325b9ed323f.camel@mediatek.com>
 <ZIPCIpWPQbVqoI4q@casper.infradead.org>
 <c23e1fb3628bf0a32bd0eb491c9370b961e19fd1.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <c23e1fb3628bf0a32bd0eb491c9370b961e19fd1.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/06/2023 16:21, Wei-chin Tsai (蔡維晉) wrote:
> On Sat, 2023-06-10 at 01:21 +0100, Matthew Wilcox wrote:
>>   
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On Fri, Jun 09, 2023 at 04:09:01PM +0000, Wei-chin Tsai (蔡維晉) wrote:
>> > > You haven't included any users of these new exports, so the
>> initial
>> > > reaction is going to be negative - please include the users of
>> these
>> > > new symbols in your patch set.
>> > We use these two export functions from our kernel module to get a
>> > specific user process's memory information and heap usage.
>> Furthermore,
>> > we can use such information to detect the memory leak issues. 
>> > 
>> > The example code is as follows:
>> 
>> No.  You need to be submitting the code that will use the symbol *at
>> the
>> same time* as the patch to export the symbol.  No example code
>> showing
>> how it could be used.  Because if the user isn't compelling, the
>> patch
>> to export the symbol won't be applied either.
> 
> Hi Matthew,
> 
> Got it. The following attached patch file
> "v1-0001-memory-export-symbols-for-process-memory-related-.patch" is
> the patch including the users of these new symbols. Thanks.

Please send both patches as a single series, then we can start review process. I 
had a very quick look on the attached patch and it's missing a good commit 
message describing what the drivers is for and why you need it.

Regards,
Matthias

> 
> Regards,
> 
> Jim
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
