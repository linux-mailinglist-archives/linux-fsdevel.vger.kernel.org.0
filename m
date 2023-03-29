Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABFF6CF3CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC2T4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjC2T4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:56:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3BFCA
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:56:14 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n28so2924331ioz.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680119773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pXp3m3d9IDqixUl8JRvLmjh2RWPB2gpeXs5rdNpUYk=;
        b=5gnOYqTrly8M8PxrrcrWxJVVcQ8Xqr2Ed6B60jSZr7epSZ5MVTgVHv2afTK1Fd8POl
         YHDsFyO5SqN0gAxc29NF0/kFqeuvkEd3v+87BE1H012Wlvm/0ARnXKQCuhrxUvygffdd
         UalPtMVTncsNSqTTt31GwMus53/7NmJ9zo8h4MAAVbpkibAmjZjag42aOIHwFyI4nn0Y
         DpjCGwqO/yCT651fqcL2uhxjjzMOfyiSkQVUe3fvyGwmQHQL8ZWSeObXZNIMJYA+gJMq
         BpeWwRPRwl0DgXHognjDwuLZT6NVX5MXzg7bEFCX+D86eFn5wJ3kGtoccCyb8dQRsxeq
         5tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pXp3m3d9IDqixUl8JRvLmjh2RWPB2gpeXs5rdNpUYk=;
        b=i/8St0bsu14Wzs4NeClt41ca1YnIbV2jAQKc84ttrr9K9SZ1vu/okn6MdvU6OuisxL
         RetPTmc/RUeskGxzSHOuyDXuBiDv0Dy9XGTVK23FCl2gNrSddDM5iG03S49CqGqT/+Rq
         y1eFotSf0SzL0ITbDfuJVNfq94m7ZWGNsR83wvNbAQsdWopCsUusR+FbccbnFgnI7FEm
         OlBMZnzT/guyVRRluQHFS0E6MNDjQf9a8y4brJhVjTZdnZQFfF0OcbDNMDXnfdk8qGuC
         IGA5BoojllhaXkRdvymfoybtQS0rKF6ejZurBmgFwo1yFIjqDrt4zxClprS3se3g2IfM
         QzjA==
X-Gm-Message-State: AO0yUKXwjr3IaXAPPMBzqabMZ5F3IQG9LMxBASNLDCyCypbag4nE0AjW
        kh4VaJqVtN54AtvMR5EDPBYPuA==
X-Google-Smtp-Source: AK7set/eLKmhbiH4LKCGcDLOq1DWmaCU71y+dUHaG+LcDbex+Zkqg2PNFSHqyj6j79fHhjTeq+Pe5w==
X-Received: by 2002:a05:6602:1301:b0:758:6ae8:8e92 with SMTP id h1-20020a056602130100b007586ae88e92mr11312073iov.1.1680119773477;
        Wed, 29 Mar 2023 12:56:13 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m15-20020a02a14f000000b003e4a3c070adsm10298440jah.133.2023.03.29.12.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:56:12 -0700 (PDT)
Message-ID: <3274c95f-b102-139d-0688-be688d799c20@kernel.dk>
Date:   Wed, 29 Mar 2023 13:56:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/11] iov_iter: overlay struct iovec and ubuf/len
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230329184055.1307648-1-axboe@kernel.dk>
 <20230329184055.1307648-7-axboe@kernel.dk>
 <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
 <554cd099-aa7f-361a-2397-515f7a9f7191@kernel.dk>
 <a0911019-9eb9-bf2a-783d-fe5b5d8a9ec0@kernel.dk>
 <f12452c7-0bab-3b5d-024c-6ab76672068f@kernel.dk>
 <CAHk-=wg4J1+Ses2rY0xBhWxyfTDNW+H_ujpcwngKG5tp0y_Fxw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wg4J1+Ses2rY0xBhWxyfTDNW+H_ujpcwngKG5tp0y_Fxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/29/23 1:52 PM, Linus Torvalds wrote:
> On Wed, Mar 29, 2023 at 12:49 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> We can get rid of these if we convert the iov_iter initializers to
>> just assign the members rather than the copy+zero fill. The automatic
>> zero fill is nice though, in terms of sanity.
> 
> The automatic zero fill is good, but I think it should be fixed by
> just not making that
> 
>         const struct iovec __ubuf_iovec;
> 
> member be the first member of a union.
> 
> The way union initializers work is that if they aren't named, they are
> for the first member.
> 
> So I *think* the reason you get that warning is literally just because
> the __ubuf_iovec member is first in that union, and moving it down to
> below the other struct will just fix things.

Nope, still fails with it moved below.

-- 
Jens Axboe


