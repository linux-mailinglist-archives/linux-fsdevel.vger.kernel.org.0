Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945846F848C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 16:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjEEOME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjEEOMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 10:12:01 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C576CAD34
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 07:11:55 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a202d44e6so2122217b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683295915; x=1685887915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYPB3stPQmWSExnYMshDYbYhsfa2W+OlQjJxEpndWnM=;
        b=qq9k4CHhMcGwgjJP+XM1athe5OHlLq0D26Ch4Y7iLMqhrY6QdPYKg1AtxVumk1ffcg
         RpfIYS8xAG6L5x7Tb30DAUHqZ9JIwJtrklJT5Xx8ObnVzeY9gSzPiW/toPtuXaGux6eQ
         /ZT2nMq+AtMMIpZmEcvQLLIsHsiY7R8AjFY8UNrKUp7ru2uqEl4XNnPRIw/lYncqAdXh
         86+ECEijeVraFzpt3bV587DuKIeREe4VKB6ECv4H52ADB5Q6EAVlhlJ7+Yx1b7HcS+9y
         6+4ve2FZ3mHqxFYatqkm+vN4DsB5xLgcdPhoqy7i9rNsyYc997kMMoXNsZl/kNyeyH5F
         mtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295915; x=1685887915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYPB3stPQmWSExnYMshDYbYhsfa2W+OlQjJxEpndWnM=;
        b=b2sVjYP/lH92Vle2Yt8Q/x/QzF7DsTWY4B0joDDJ02tvj7tWlMSTbjcuNPE32HCZHX
         qB/vfb6Qz+oNa+KKAAjJn7Dc6seGEHkOcLCT8kzIvSvWcN4tz7FRJiMWgDEtZSN9hrR4
         jQvl2YZpAVFgVbRGDb93G9UJ1ju+jCYt840QZw03aLp9m8baFJxjdXAZc9RC+irBophB
         1Jqxn8ZniX2GjVLUmt/j30DxCFJeTl2zkPZCXB3nP/ULdeu44qOcu9+Wy564CQu2h5kj
         L8w/scm/fYCtoQRwJ/b9wv5wszZB/0dvi5NL0oFlXwymXBm8bzId0It6cZGPA35+1+Xq
         jXgg==
X-Gm-Message-State: AC+VfDzu1MvmQa9MEe4iRTmqTGCmSV92uFl/dGf2lSTrXez1IV4uy4fi
        3cyZAT6qavoqcU4dp5gs46gT1g==
X-Google-Smtp-Source: ACHHUZ6qoOI/+PGpkkPitfDFrwnR+RSgPJAmgOvbSJFeS3wnUhPPJunQJdt8ejTtUoT1u+x3g04+yQ==
X-Received: by 2002:a81:5d6:0:b0:55a:9e2f:933d with SMTP id 205-20020a8105d6000000b0055a9e2f933dmr1748012ywf.1.1683295914848;
        Fri, 05 May 2023 07:11:54 -0700 (PDT)
Received: from [172.20.2.186] ([12.153.103.3])
        by smtp.gmail.com with ESMTPSA id x8-20020a814a08000000b0054f56baf3f2sm264788ywa.122.2023.05.05.07.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 07:11:53 -0700 (PDT)
Message-ID: <e56b4f96-a379-f97b-168f-d03f170744b2@kernel.dk>
Date:   Fri, 5 May 2023 08:11:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 00/20] bio: check return values of bio_add_page
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "agruenba@redhat.com" <agruenba@redhat.com>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>, "hch@lst.de" <hch@lst.de>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "rpeterso@redhat.com" <rpeterso@redhat.com>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
 <1ac1fc5e-3c32-9d62-65bf-5ccbb82c37cc@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1ac1fc5e-3c32-9d62-65bf-5ccbb82c37cc@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/23 2:09?AM, Johannes Thumshirn wrote:
> On 02.05.23 12:20, Johannes Thumshirn wrote:
>> We have two functions for adding a page to a bio, __bio_add_page() which is
>> used to add a single page to a freshly created bio and bio_add_page() which is
>> used to add a page to an existing bio.
>>
>> While __bio_add_page() is expected to succeed, bio_add_page() can fail.
>>
>> This series converts the callers of bio_add_page() which can easily use
>> __bio_add_page() to using it and checks the return of bio_add_page() for
>> callers that don't work on a freshly created bio.
>>
>> Lastly it marks bio_add_page() as __must_check so we don't have to go again
>> and audit all callers.
>>
>> Changes to v4:
>> - Rebased onto latest Linus' master
>> - Dropped already merged patches
>> - Added Sergey's Reviewed-by
>>
>> Changes to v3:
>> - Added __bio_add_folio and use it in iomap (Willy)
>> - Mark bio_add_folio must check (Willy)
>> - s/GFS/GFS2/ (Andreas)
>>
>> Changes to v2:
>> - Removed 'wont fail' comments pointed out by Song
>>
>> Changes to v1:
>> - Removed pointless comment pointed out by Willy
>> - Changed commit messages pointed out by Damien
>> - Colledted Damien's Reviews and Acks
> 
> Jens any comments on this?

I'll take a look post -rc1.

-- 
Jens Axboe

