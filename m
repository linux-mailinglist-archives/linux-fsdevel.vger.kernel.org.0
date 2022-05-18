Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD252C67E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 00:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiERWpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 18:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiERWpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 18:45:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FED20F4E7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 15:45:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ev18so3450798pjb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n3iurgYZFISFcgs5X6Ldo3ldCenlvZbMBwRmkDfrSRQ=;
        b=5rG+sdyHVtjwPwhb1iNcxH+nhvlYTDGmCKevlJ5V2Hqe8fzZSMRLDSC4t6Yjnbc2gV
         c60YVPIbyfdWFhUCtEuKUCnHK8CPW2drGqeayOHEGueeUKnWTMsI1tEdSOwhgeAygOJJ
         ASSed+aKowoMDjmUDKFRLkO4lpKQ3upYsOTAUVd/NL7ZnmXV5Oef+MzvSN/Huc1UUpfx
         1BbbqmQyj5iP55U84fbu5A8yTh2asAyal+teKaUSUFezFX906W3TWIiDQGjutmjMLoJj
         wLoFu9xrR5qntkZmbBEHa0iBPoIPo9zyCjLxBpTpkXtbgxHtMqZpVva9FcKkrJCxcT/i
         abqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3iurgYZFISFcgs5X6Ldo3ldCenlvZbMBwRmkDfrSRQ=;
        b=RWX5OJnfrnBhDaf2bJFuyvBox5/lfjSiOQj1JK2DcxmIaNtVXchfLC+e7AIwXpaRmK
         Hakx5T0foTijm0qdHoPajBucVC3uGWlk/vbnQc86ioFwCA14kcUPvw5XCXLsxhxAAJ/P
         3l2OD6ufFooGaMPe2X5jjfQf6loRV4esxBfLu1t0JEpnvM7uh9IJhVl7nxeOWfmDUpVq
         wMKD3L1V4sBp6M0l3XscPR8AZwUBT9hj4nseDaBykKPqebTKVP05j+KHMrRm+9GECeu2
         x73ZX78CRmcm+rcjRWm/DMuXRGrwDfC/qO7aJaQiyGng5eXj7iBfO04wKCWzNSeRRi6i
         Wlsw==
X-Gm-Message-State: AOAM53323OI4gbFZP/1XdOdW5nW6QxbHRTVh0z3oWXqWSolVIp6UBOGH
        l6Eh2KMJ4uG5jWSC+0qPdGIF3A==
X-Google-Smtp-Source: ABdhPJy3YhvhjlQnttfqmRtz2KT4IM2BrtBedUcYiqsNfPkqD69wW5klYhC5CpiiFiI1W0I9GAAsJw==
X-Received: by 2002:a17:902:d48d:b0:15e:c236:4fd3 with SMTP id c13-20020a170902d48d00b0015ec2364fd3mr1784979plg.113.1652913917682;
        Wed, 18 May 2022 15:45:17 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x21-20020a1709027c1500b001613dfe1678sm2185354pll.273.2022.05.18.15.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:45:16 -0700 (PDT)
Message-ID: <dc8e7b85-fba1-b45e-231e-9c8054aea505@kernel.dk>
Date:   Wed, 18 May 2022 16:45:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, Keith Busch <kbusch@kernel.org>
References: <20220518171131.3525293-1-kbusch@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220518171131.3525293-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/22 11:11 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Including the fs list this time.
> 
> I am still working on a better interface to report the dio alignment to
> an application. The most recent suggestion of using statx is proving to
> be less straight forward than I thought, but I don't want to hold this
> series up for that.

This looks good to me. Anyone object to queueing this one up?

-- 
Jens Axboe

