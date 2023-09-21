Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80407A97A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjIUR0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjIUR0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:39 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADCA2D69;
        Thu, 21 Sep 2023 10:02:42 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a9b41ffe12so721443b6e.3;
        Thu, 21 Sep 2023 10:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315643; x=1695920443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+myxey5KkFamPLG+BXl8bpHSYiVN4ySSOSWXnhTIWBM=;
        b=lPAsCm5pDGAjc0MKLMT5rXPtBCpaj3iWxUsuja3hf7WnyaqDXsIBdIZtS6p4lJcP34
         v17x/G+qwSgzK/9jlpvhoPpc9hXtuFlbMEBmK6RQ6Y1vlVNWo9B5MtEu09fGUJjV2nMt
         lB5ngN7QkK1EbNfFs+Nm6Hw4AiMQPIMur4GGxB7FOKQCiQ7H6JO0evgKH3nWbWwMgeUm
         dKuiCuYlLjImTAxqOrNy+g3zQXfNH0eXO5kxD9odGC+dssWQVm9QDu6kvklZzHphtt08
         Cy2gJpUzlMKmdbP2mVx0x8A0hUjOiNKgg7CA0AF2Et0hWFRXgiCAQZS5fH1rEf71U4Iq
         Uhzg==
X-Gm-Message-State: AOJu0YyAgtlPdUvPFOA94XrwGeneefDyYDWZn+Xw1ucBy2VPM8RJ9LTW
        MMMFkWOd1P0WWitzGXMersU=
X-Google-Smtp-Source: AGHT+IHkCW88em4+s4HanHcm2/nYfuEsdBtW/TqjDkgg3Ju0IBXefT2+akGRuQadD4OJtCmXfBOe8w==
X-Received: by 2002:a05:6808:191c:b0:3a4:f9b:b42e with SMTP id bf28-20020a056808191c00b003a40f9bb42emr7058259oib.26.1695315642918;
        Thu, 21 Sep 2023 10:00:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6903:9a1f:51f3:593e? ([2620:15c:211:201:6903:9a1f:51f3:593e])
        by smtp.gmail.com with ESMTPSA id i10-20020a63bf4a000000b005646e6634dcsm1389910pgo.83.2023.09.21.10.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 10:00:41 -0700 (PDT)
Message-ID: <9975f36c-cacd-4922-9d27-a7ff726793a3@acm.org>
Date:   Thu, 21 Sep 2023 10:00:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
 <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org> <ZQv07Mg7qIXayHlf@x1-carbon>
 <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org> <ZQxiklow/4m4kvYu@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZQxiklow/4m4kvYu@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/23 08:34, Niklas Cassel wrote:
> Right now your cover letter is 4 lines :)
> I don't recall when I last saw such a small cover letter for a feature
> impacting so many different parts of the kernel.

I will expand the cover letter if I have to repost this patch series.

Thanks,

Bart.
