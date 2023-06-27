Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2ED73F119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 05:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjF0DA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 23:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjF0DAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:00:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6119A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 19:59:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3ecb17721so7624615ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 19:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687834786; x=1690426786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeTs2x7FuNxv9o3OBIy1/YYpxTDNDnMo15MSc7SpQnw=;
        b=AnpQ1fZw9c1pRqwYx1AVGzSUxagUrOUA6Xqbrwaw71ngDcJL2I07B6LjUuf3vb4oFi
         9bszs4UpLXHLpjM10Vy67mJf0XaoD0wrff/DWf8dJJTrj6W67Qgj8XriWleKnjPb50ZX
         BJqrp2PTIu/k6Ug6Sl6NOYFUN+JKp+y7/x8FINP2OcFNpui/YOMmI/L8iq2U4fOJl4XS
         r7/3zKZOTnbFbuzhMJ1PTlqO6O+5dtjiiL+7m8CH5AGIepoejxOL38mMsn1sX7vWQCo7
         +jI2ldRsrL78rxw++OO6euxUnZjZxFxLCXOogFUKAz5NI2zjeEZs6wa1gEIyvdMO32G+
         utQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834786; x=1690426786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeTs2x7FuNxv9o3OBIy1/YYpxTDNDnMo15MSc7SpQnw=;
        b=GfO7xfjVIhkYBgOF9mdc+tOULOMxBLS1EQfu0xljnMzYOV4Y14Kkk4pMN68+LQt53p
         rtPyPHLkYiiwIs9T4vywkjFkAsKka4PQUIAqmfL2U4ZTqqI9U3yvBV3e+OJSOLwag/W5
         voHsx6aj9qOzoeJFzW4SGdD6+HvT8Fyyx65h4tj4qBR9kGvUgk1L5ge1nHAZ/3ALAtEg
         zj8oY9/rOwAw7+xJK1DmXTY+ki9Z1dRqxvQvwZsUMPSxtBDvN8jbx+1Iak4YZYaK0mmn
         RBBrhKVlAuhONaxoqEUuTO8yMwXBBMk2w/lnIfvgdV5K9TC9Lzdv+NCWPU4r0xKcAD+D
         v6gA==
X-Gm-Message-State: AC+VfDxxAwYBOHaYMCk57hr1i90DLf3ouCKBpLDHYjZJ7oCTojHNR9MU
        x0weNyAl4Ajyp0QyHm65FnbCQQ==
X-Google-Smtp-Source: ACHHUZ4d7XvDYPH3zVtn9vzYg6hQnpjpNIaPRZYnulEQKGPmJjOA+f4681uFVeHVXNE/cpSL3lFNsQ==
X-Received: by 2002:a17:903:1105:b0:1b3:ebda:654e with SMTP id n5-20020a170903110500b001b3ebda654emr36428950plh.5.1687834786221;
        Mon, 26 Jun 2023 19:59:46 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b001b7fad412f9sm3126839plb.226.2023.06.26.19.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 19:59:45 -0700 (PDT)
Message-ID: <784c3e6a-75bd-e6ca-535a-43b3e1daf643@kernel.dk>
Date:   Mon, 26 Jun 2023 20:59:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627023337.dordpfdxaad56hdn@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230627023337.dordpfdxaad56hdn@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/26/23 8:33?PM, Kent Overstreet wrote:
> On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
>> fs/bcachefs/alloc_background.c: In function ?bch2_check_alloc_info?:
>> fs/bcachefs/alloc_background.c:1526:1: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>  1526 | }
>>       | ^
>> fs/bcachefs/reflink.c: In function ?bch2_remap_range?:
>> fs/bcachefs/reflink.c:388:1: warning: the frame size of 2352 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>   388 | }
>>       | ^
> 
> What version of gcc are you using? I'm not seeing either of those
> warnings - I'm wondering if gcc recently got better about stack usage
> when inlining.

Using:

gcc (Debian 13.1.0-6) 13.1.0

and it's on arm64, fwiw.

-- 
Jens Axboe

