Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A834DA39F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 20:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbiCOUAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345625AbiCOUAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:00:45 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011D5676F;
        Tue, 15 Mar 2022 12:59:32 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso3225698pjb.1;
        Tue, 15 Mar 2022 12:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sN8Wq+TlVRbPzS3ENj1k0RogB7Bccu2FirfIIGv2fs4=;
        b=pIzt0urCwdA9c6z4pZgDMa6OrELD8+J3wuvKdfrwg9TL/ryQlnYc0Mnis6gLglC/Rn
         etcbB9mSycGy+B/k7urTczIGzwUSXBwqQYNWS2lxT8AZzLjMWDlKIPdQT2+lV7VsBRp+
         LZzH9KgLe66DSfnFlJPIPWzU1SLI8myFvELT8/6bVfcA8AF1dpbHr8bjbrLo3cSLpMmu
         6cF+g/nqAIOQ0XJ3XqRsQDqR8veuT9f7paZeVmEvbf3+gXexnfAPMaA5pbM9xbr7PdYu
         hFo7lEVfVR0PmzIoY0urRNwUgscl4yiIhudnvXYMIAjWQ0qWUCrMa2bn8DZbBqQAXf4u
         Qtbw==
X-Gm-Message-State: AOAM531Ty7jMuLnykg9Lw970ogF58KGXq6F2x74txV8CB3KMoSTKzrmi
        ItP0rO+8/Tz0GSo5JcvlgIs=
X-Google-Smtp-Source: ABdhPJzrrCD9tjzgq3sTC1/qWFoolG2R4cEOg+M+oRc1A//BpRZzqSmQLAr6pVuCMQEzeijr1SrROA==
X-Received: by 2002:a17:902:cec4:b0:151:a696:149b with SMTP id d4-20020a170902cec400b00151a696149bmr29705461plg.145.1647374372290;
        Tue, 15 Mar 2022 12:59:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:d4f3:cc71:95cf:ad29? ([2620:15c:211:201:d4f3:cc71:95cf:ad29])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a000cc900b004f7a986fc78sm14642316pfv.11.2022.03.15.12.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 12:59:31 -0700 (PDT)
Message-ID: <e2934e77-38f1-c17c-1f3f-b3c8a902e73d@acm.org>
Date:   Tue, 15 Mar 2022 12:59:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Jens Axboe <axboe@kernel.dk>,
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <PH0PR08MB7889314A7E3C8FEC1E7A491CDB109@PH0PR08MB7889.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/15/22 12:04, Bean Huo (beanhuo) wrote:
> Sorry for that. They are added by outlook automatically, seems I can
> turn it off, let me see if this email has this message.
When I was working for WDC I used the Evolution mail client to connect 
to their Office365 email infrastructure. Evolution is much better suited 
to reply to open source emails than Outlook.

Bart.
