Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36044CB82F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 08:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiCCHz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 02:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiCCHz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:55:28 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55D16FDE0;
        Wed,  2 Mar 2022 23:54:43 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b11so6945092lfb.12;
        Wed, 02 Mar 2022 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sJcJ2tPfuoTnVjGIh4PB1r1QQf3pEDkYuAb0fPURAbc=;
        b=Vc4iPmbPVEDBtxd3OG7NCebjtdAKbiy6CKpFxBIB1ew7Mlwg262GmDFvp5McKnofmd
         ej2WwXHeLciUm+4Zqoi67TkPgcLcmdnnc775j37JDraV+bmomYh3mq274UR5c6BG/ZSv
         Zc+Q5PXDEdXsRHgs9Lh85tpIaBSgyb75QV3GGRno9U3q5GI9+KByhnuOle+Z6PNCf6Vq
         f5MtSBCTkeBWvd5l0zmNX9wn2DyCuF238Wg3Xf8kAPjSYPw5smtD7D2WA+GtMykR/9kD
         xEmB+9I+tbT6GoFtNXSHjbVc8BzpVLQ+V0XXXKw25Mm21Jov9h50AoADeZti1tvFaR2l
         cKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sJcJ2tPfuoTnVjGIh4PB1r1QQf3pEDkYuAb0fPURAbc=;
        b=pDd/jpC00yCIMsSt2Oc6HtjNc+RAMeSleEvZCyVnKDyRxfxAIxzCsm4oft3rc/0He6
         zjhO2hAZ/R9CJ21ezuQAKm3duxP6MnI8qqe2vKKo0xtraus3lVZOiNI1RKHw8luBTuTv
         hw8I0l8NjZtYlmROX7Ow1L/qaHLYvsmcCa8nBLs1sh/LKow/ipIe9rrvXYgHpmUZsP0E
         STTWQ97HnQ9txIIWrFNi06MDEnJXMyFnk/0IQpm2hdNzoJ9zfx9IGUJB3R1+GeUvBA31
         CpQ4j5TFjo+sHQH6zbeRSkzJunzAIMFl4+i6S1b1zTVk5FnKBXiRqqiFuNcAwKp8y1T3
         Llzg==
X-Gm-Message-State: AOAM5334YM6WTkO19oN00d/wUH3+jnZ2w6NPNIw/BriCzD+zFFuEJ+b4
        BF6N+yNaY8ESYOvpkQs5rlA=
X-Google-Smtp-Source: ABdhPJzzQmjU9+fV6wRvONbx7uOu822PW/5BTF8bp74D0T9xef8moRVDIYOmN40Xz5mPqc0UjElJxQ==
X-Received: by 2002:ac2:50ca:0:b0:43e:550a:4457 with SMTP id h10-20020ac250ca000000b0043e550a4457mr21143568lfm.614.1646294081525;
        Wed, 02 Mar 2022 23:54:41 -0800 (PST)
Received: from localhost (87-49-146-27-mobile.dk.customer.tdc.net. [87.49.146.27])
        by smtp.gmail.com with ESMTPSA id y16-20020ac24470000000b00445a97a7928sm278389lfl.290.2022.03.02.23.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 23:54:41 -0800 (PST)
Date:   Thu, 3 Mar 2022 08:54:40 +0100
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <20220303075440.zj5yzmrpp6jkpmsw@quentin>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
 <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Luis and Javier for the proposal.
On Thu, Mar 03, 2022 at 07:29:50AM +0100, Javier González wrote:
> On 03.03.2022 06:32, Javier González wrote:
> Let me expand a bit on this. There is one topic that I would like to
> cover in this session:
> 
>   - PO2 zone sizes
As I am working on this topic, I would like to join as well.

It could be tricky for me to be present there physically due to some
constraints so will there be a possibility to also join also virtually?

--
Pankaj
