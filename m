Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22148662C38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbjAIRHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbjAIRGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:06:23 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13184102D;
        Mon,  9 Jan 2023 09:05:31 -0800 (PST)
Received: by mail-pg1-f174.google.com with SMTP id q9so6313472pgq.5;
        Mon, 09 Jan 2023 09:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+Jk43bfwlT9wi1gXomrMQ7R6y2uWjif0guEJB9OZDk=;
        b=AgRpPFcCcEUfpvrnpf7tuWoBrY6hLMd2AMP3pyacjXORPUOFwBbSDJs1T8eYv3/If6
         +GQ+kH7U/VH6cG4WOz7apqq9UyYjb8FfixYIDG+QOd4HW5NM5xyi12byIiHihJMtsIzw
         uuvUwYlbzP63xVTffOxoJBOznvDIo0XQQLCmw5vafBbglrwqZxX9t0f7NH7R8nbVuhqK
         /rLb9aKwhNe4VtSH8Uh42lFWJTQ3ZjT/QpZ/VpmH5JlTFyXNYu9xzLgyZYJh6icRMH5M
         KyVtSkXcMApgUSi517Dak25tC4y+nwVvLKTP98lRGPGLvN7rW6SUlpzp1RX3wd4pbVL2
         R/4Q==
X-Gm-Message-State: AFqh2kqJsNZWtC0+NTRBgXXTBhhbruh2h0WK3L59kedC7oeA6KInTft4
        T9mfttnwujlcwNO+S8DFguI=
X-Google-Smtp-Source: AMrXdXt0A8n0S+XnWdQfOF5gLmeJIIc52A1L37LfeDPhxxtdIXnVFVgm2rLmk9/LhLAJaqj32xc5sw==
X-Received: by 2002:a62:6145:0:b0:581:7cb0:1eb8 with SMTP id v66-20020a626145000000b005817cb01eb8mr44017246pfb.17.1673283931028;
        Mon, 09 Jan 2023 09:05:31 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:9f06:14dd:484f:e55c? ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id 69-20020a621748000000b005810a54fdefsm6311863pfx.114.2023.01.09.09.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 09:05:30 -0800 (PST)
Message-ID: <6079a21f-e8da-05bb-b6a5-be4cd350ac66@acm.org>
Date:   Mon, 9 Jan 2023 09:05:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Content-Language: en-US
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/9/23 07:33, Javier González wrote:
> On 06.01.2023 17:56, Viacheslav A.Dubeyko wrote:
[ ... ]
> As a general comment, do we want to talk about ZNS alone, or zoned
> storage in general? We have of course SMR, but also zoned UFS with
> actual use-cases.

I propose to broaden the conversation from ZNS to ZNS (NVMe) + ZBC (SCSI).

>> I think we can consider such discussions:
>> (1) I assume that we still need to discuss PO2 zone sizes?
> 
> For this discussion to move forward, we need users rather than vendors
> talking about the need. If someone is willing to drive this discussion,
> then it makes sense. I do not believe we will make progress otherwise.

In JEDEC meetings I hear that UFS vendors strongly request support for 
zone sizes that are not a power of two. The JEDEC UFS committee is 
currently busy with requesting an MoU from T10 for permission to base 
JEDEC standards on ZBC. We plan to finalize the ZUFS (zoned UFS) 
specification once that MoU has been established (probably later this 
spring).

An additional topic I want to talk about is support for queue depths > 1 
for sequential write required zone type. I plan to post patches soon 
(later this week).

Thanks,

Bart.

