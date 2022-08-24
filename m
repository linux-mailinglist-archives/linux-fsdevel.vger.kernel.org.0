Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C017C5A04D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiHXXnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 19:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiHXXnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:43:16 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9053875389;
        Wed, 24 Aug 2022 16:43:14 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so3190434pjj.4;
        Wed, 24 Aug 2022 16:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EPlW+LT0JWjQkhBvgWfOXTs2CfL6vJ2ig51kjDOzuvE=;
        b=1xMVEC/M5SMnScySwHqHAb+7Po1HAE1vfG7aZlZscWaTJytMyKp1v+3DGnEmXwSxl4
         tnY+NdKBXLNqSmIHE+4FY/oh+VKdAE9fob902S9L6jIZO/TNM1zB2r4gdhoM7sHJRKWo
         NESNhuRDGAIU8kfcC+wzcakufwrwSswBu2ydvC6NaUNlrwI9rxD61NWpOB6svcezROtM
         c8NMS2UjYyX4cDX4PkgebJttG3mFoqsBtfCx+OaBxfz5pEVsIcg3hdXXCRPIqSe7zJ1n
         CVQRwauVCBBjmvttxlrNVTIsVEvPO9XE/qwAqOsJI4kW2nT0pcYK7yGh8R3k8j6UW9+t
         rqGg==
X-Gm-Message-State: ACgBeo1Fqd3nWRxYnP6uoyZwcwSAzdXsoje9fVjtHN66EXJ+iJf9lf+x
        HTVUypcSKXafzHkL0yOVuqE=
X-Google-Smtp-Source: AA6agR7Mb+gBrHZFZa0PQclCVYsledOVzIfWAydKgjAvBC0iL0nu5UUGGqPzSq+P7kwYhTCFCJNDMA==
X-Received: by 2002:a17:902:e742:b0:172:fdcc:a52f with SMTP id p2-20020a170902e74200b00172fdcca52fmr1150155plf.40.1661384593748;
        Wed, 24 Aug 2022 16:43:13 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:222f:dc9c:99a3:dfb8? ([2620:15c:211:201:222f:dc9c:99a3:dfb8])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b0016c0c82e85csm13195300plg.75.2022.08.24.16.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 16:43:12 -0700 (PDT)
Message-ID: <89b2bb4b-1848-22cc-9814-6cb6726afc18@acm.org>
Date:   Wed, 24 Aug 2022 16:43:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [ANNOUNCE] CFP: Zoned Storage Microconference - Linux Plumbers
 Conference 2022
Content-Language: en-US
To:     Adam Manzanares <a.manzanares@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mb@lightnvm.io" <mb@lightnvm.io>, "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
References: <CGME20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2@uscas1p1.samsung.com>
 <20220522220128.GA347919@bgt-140510-bm01>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220522220128.GA347919@bgt-140510-bm01>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/22 15:01, Adam Manzanares wrote:
> Zoned Storage Devices (SMR HDDs and ZNS SSDs) have demonstrated that they can
> improve storage capacity, throughput, and latency over conventional storage
> devices for many workloads. Zoned storage technology is deployed at scale in
> some of the largest data centers in the world. There's already a
> well-established set of storage vendors with increasing device availability and
> a mature software foundation for interacting with zoned storage devices is
> available. Zoned storage software support is evolving and their is room for
> increased file-system support and additional userspace applications.
> 
> The Zoned Storage microconference focuses on evolving the Linux zoned
> storage ecosystem by improving kernel support, file systems, and applications.
> In addition, the forum allows us to open the discussion to incorporate and grow
> the zoned storage community making sure to meet everyone's needs and
> expectations. Finally, it is an excellent opportunity for anyone interested in
> zoned storage devices to meet and discuss how we can move the ecosystem forward
> together.

Hi Adam,

On https://lpc.events/event/16/contributions/1147/ I see four speakers 
but no agenda? Will an agenda be added before the microconference starts?

Thanks,

Bart.
