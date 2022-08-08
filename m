Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9926958CB5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243053AbiHHPhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiHHPhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:37:33 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263815F52;
        Mon,  8 Aug 2022 08:37:33 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id o3so8892810ple.5;
        Mon, 08 Aug 2022 08:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=IazCDg0vXeqc0o+7IS8h8dgj5zECaKG2You3RdOsLmY=;
        b=FWVmNko+8++lwEZRQKTTsmdw8GS0k2Nky+s2xRAbRFJ7jefEeAaiy+7Hp76WGlZf/u
         CjVNAEZ+8iUgtXvvWe1bbhLit3P4Q8VB5P6WHdhwtJLordPDeDthElXwad3MXTtvakNj
         0Z1rFFIRUN+uti+3BjSnVrrk0fSaRNTc+OEbNOndCkr6YK1/YiuU+JRTkyrue9q8o5Zl
         vqI1PBHjrccfhUuMP0HBr9lWynMwpZARbNbIqYHQDL8M1jMZjrwSxSXCmT6rHcb+tzv3
         KO2EkFJKGlQ2oMz6PgyXZlNyV1L3dL+TxzPhpH8ShERjlqxqg24Q8WNMwALHkYLk6N2y
         xyLg==
X-Gm-Message-State: ACgBeo0qBlmNs9l0e3zrpg0KsaEmPHKOfdMJYZnaYPrRh0Zvbx/G0m6y
        hnUUEfMHu7sWJnYLVT5xW4msvPeCUz0=
X-Google-Smtp-Source: AA6agR7Ymai6S9rZbXU68CURfa/YMzVXq3wuviar3z4RVHhRD2ZGYax6kRJ2CGdbIqhnn3XFVbZgUg==
X-Received: by 2002:a17:902:8486:b0:16d:d4b1:ceb6 with SMTP id c6-20020a170902848600b0016dd4b1ceb6mr19318892plo.33.1659973050923;
        Mon, 08 Aug 2022 08:37:30 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:61c5:e573:80cc:1a30? ([2620:15c:211:201:61c5:e573:80cc:1a30])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090aaa1000b001f4e0c71af4sm8282022pjq.28.2022.08.08.08.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 08:37:30 -0700 (PDT)
Message-ID: <b3a6b038-ba0c-2242-3a29-5bcadcaa9d71@acm.org>
Date:   Mon, 8 Aug 2022 08:37:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted
 blk_opf_t
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <202208061533.YBqXyzHm-lkp@intel.com>
 <affa6eee-3b7c-105a-8f4a-35f1ed81f0cd@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <affa6eee-3b7c-105a-8f4a-35f1ed81f0cd@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/22 07:48, Damien Le Moal wrote:
> Are you going to send a patch to fix this or do you want me to do it ?

Hi Damien,

Thanks for having taken a look. Please help with verifying whether the 
following patch is sufficient to fix the reported warning: "[PATCH] 
tracing: Suppress sparse warnings triggered by is_signed_type()" 
(https://lore.kernel.org/all/20220717151047.19220-1-bvanassche@acm.org/).

Bart.
