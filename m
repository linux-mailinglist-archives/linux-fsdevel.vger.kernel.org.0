Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9537A9F87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjIUUXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjIUUWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:22:43 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29674B70A;
        Thu, 21 Sep 2023 10:24:52 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3aa14ed0e7eso652882b6e.1;
        Thu, 21 Sep 2023 10:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317091; x=1695921891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rshe0jW7UhxhoxHzQRdwHHly+hnX6L1+KyeP6WuSdms=;
        b=Z+IW+nx4wDQcTjHdy9q4ktNMuEQQ7Qr2EFvRMUsGU7VGjjsjwTACQB+QNOLqITHa5w
         hqspMx5KpRPSDGcgsJ13heS/ch/kJItAJVOfy5HrDzNwyQMmIgSpP/MJpUd+FHEsa1Ut
         9BFsxjsgk45bIWWeQhP27RNsZbQt7yRVK8nUxi5AMEA+KkrH+65umSKgWpimdRuj+UB+
         VHA0SsFtQxsOzkaszJVEir8rSGUgqLweuHsc/6rCn28F3gapaOrhxvQLfOK0RzmuS44H
         8yDb0nkYUToJaLoI2ofxe8Zn0OE2gyduehAlnIoMHKvV9qCUCTGTHp4OlmCXrvJbkxiz
         4wSg==
X-Gm-Message-State: AOJu0YzOFewXulSn5NUOBRJGvHPPbhKVEHoSMbSIsrBjExl5cVZzWcZ5
        bQzDQ4V63QhThDTI120N35YOWDY9Mc8=
X-Google-Smtp-Source: AGHT+IEckYqWZk5F9LFw20ucVdeJ8Lr3aC+IsVyPzXDqHASE0LSTBOEzKe0qNxhV6kLLw7xkoMLFug==
X-Received: by 2002:a05:6a20:3c8a:b0:158:143d:e215 with SMTP id b10-20020a056a203c8a00b00158143de215mr12630984pzj.1.1695306430192;
        Thu, 21 Sep 2023 07:27:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6903:9a1f:51f3:593e? ([2620:15c:211:201:6903:9a1f:51f3:593e])
        by smtp.gmail.com with ESMTPSA id y7-20020a637d07000000b0054fa8539681sm1362140pgc.34.2023.09.21.07.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:27:09 -0700 (PDT)
Message-ID: <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
Date:   Thu, 21 Sep 2023 07:27:08 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZQv07Mg7qIXayHlf@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/23 00:46, Niklas Cassel wrote:
> Considering that this API (F_GET_FILE_RW_HINT / F_SET_FILE_RW_HINT) 
> was previously only used by NVMe (NVMe streams).

That doesn't sound correct to me. I think support for this API was added
in F2FS in November 2017 (commit 4f0a03d34dd4 ("f2fs: apply write hints
to select the type of segments for buffered write")). That was a few
months after NVMe stream support was added (June 2017) by commit
f5d118406247 ("nvme: add support for streams and directives").

> Should NVMe streams be brought back? Yes? No?

 From commit 561593a048d7 ("Merge tag 'for-5.18/write-streams-2022-03-18'
of git://git.kernel.dk/linux-block"): "This removes the write streams
support in NVMe. No vendor ever really shipped working support for this,
and they are not interested in supporting it."

I do not want to reopen the discussion about NVMe streams.

Thanks,

Bart.
