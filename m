Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4598D4CB45A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 02:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiCCBeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 20:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiCCBeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:34:06 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76010BBDD;
        Wed,  2 Mar 2022 17:33:21 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id 9so3159129pll.6;
        Wed, 02 Mar 2022 17:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BiZJTNZEsMklspJa+9DnmRI3gUhB91fsCcqQjaHBUqU=;
        b=oINLnJeXz63oxo0yOgVyJUhVYUG7NZfEonISN8BTtJ+W6Dc9CXWxbswKRKoc2EjXgF
         o8i0E34iboblKRUNJqIPUZMOC8WxcePxjUnLrURnxh/oSsxzUPN2dkWsaD6n0an+X7tn
         wcUqH+IUFztFdCH/nPb48bDdaSe5jAwzFS9qYwJb+M4d9M9wY8zdmg9oX9rwe0b0H5R8
         pH7HcKXn3hlm9jo/qQ2iFe9cNWtsXzrbirKwWJjHbtaqPAn6xwlVMnUmtA73TSTd1WXs
         Jvlvv8zOlcyk/RHhiI1jIE6br8dYtQEyBoJIj8N0JMRoMq/WsT+TA6WC+Qgh7cCqK6kl
         k09A==
X-Gm-Message-State: AOAM531qwk4W72N9Zt8vYy9n3TpL1PRaeASY4ecYUBYz3YegfEoHbH6X
        pVl8rzpR60RGmCrwmaPvL3E=
X-Google-Smtp-Source: ABdhPJzYj+eHJE9/i13BDviH4uxYQG5wmLdgUQS7pue0aUcr2r9RiI03XSjJ3zZoSf55TMAquNncAg==
X-Received: by 2002:a17:903:11c6:b0:151:a247:31eb with SMTP id q6-20020a17090311c600b00151a24731ebmr3415425plh.91.1646271200872;
        Wed, 02 Mar 2022 17:33:20 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id cv15-20020a17090afd0f00b001bedcbca1a9sm6066368pjb.57.2022.03.02.17.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 17:33:20 -0800 (PST)
Message-ID: <a1efd5b0-f64a-9170-61e3-e723d44aa04f@acm.org>
Date:   Wed, 2 Mar 2022 17:33:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
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

On 3/2/22 16:56, Luis Chamberlain wrote:
> Thinking proactively about LSFMM, regarding just Zone storage..
> 
> I'd like to propose a BoF for Zoned Storage. The point of it is
> to address the existing point points we have and take advantage of
> having folks in the room we can likely settle on things faster which
> otherwise would take years.
> 
> I'll throw at least one topic out:
> 
>    * Raw access for zone append for microbenchmarks:
>    	- are we really happy with the status quo?
> 	- if not what outlets do we have?
> 
> I think the nvme passthrogh stuff deserves it's own shared
> discussion though and should not make it part of the BoF.

Since I'm working on zoned storage I'd like to participate.

Thanks,

Bart.
