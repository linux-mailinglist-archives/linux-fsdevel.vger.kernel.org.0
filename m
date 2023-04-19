Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C436E7A57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjDSNK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjDSNK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:10:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DCC13C02
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 06:10:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a69e101070so6257595ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681909855; x=1684501855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbrFtHJg/np4h59JOkTU9Jcy05rerGwnKepqJc+HmLQ=;
        b=k+fuBF+mbFH1Oq6qvSARivYL+AfV/B4rSjzqIGH7Xbv76CDXNsuxJAH6QpntBYDGUF
         gtq0JmMB7eMIOM2BZVNI8CkB9bJLouqCV+ZH1T44rDQo4kp1iSkrRN7hHvkB7Te6CSZv
         JFU69Utt1WDTbcNO3rqpfnvBGFrZqhNpalUKJoF3SbZ/cde3MhKmUfoKzM+3DAzbq8Q9
         WK3S3tiwNe5hwJ0eYCQVOsL3nkaujk+nCvzJMivGGe2YUHIirtcHw9JYvZHojIsvuTfR
         i7MGxJAMlNmvJib2rb2ZYctFOy2O8TYL6ck0NYEdUYE0YAzVrX7wPESFRGKlkVR62dMb
         jlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681909855; x=1684501855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbrFtHJg/np4h59JOkTU9Jcy05rerGwnKepqJc+HmLQ=;
        b=Pt4s3uwB1Dc1At1x78L5WtiXyc6w35mZhiAFIMexxMgkve2yXlPMbHo266ejOCjhAv
         SzPpb8itAh4ORCUId/no1X5w/0FhLNrf+hAPcDaeGkGMrdDvhE1L796bjjABU0ljHrFr
         Z1p6ET4uM4Pw93vAwCKbulCL9akFM/jhWPQ1xoi93uyOScofuJsI+3kdZ7w18qBtm7Gq
         ApPQJvKRVvfkiYJTarP5ZGnG4EHtGuuzyOAiJljJ4wAW3ei7STwDfFf6e4Jl88+Wenfk
         uj6JYFebX3pdIS5S1OXhetmjOPNPNmKJNBx5+9sT0MDfRJOrR/tAyiIrHiYZzadkBY5h
         NnJQ==
X-Gm-Message-State: AAQBX9dvOntcDRtybIDxWemJU9cHvqcXRAADbhzsxmEg7MNNm0q5Rv2H
        79LA+HhcdVig4pxhdawpiX8jWg==
X-Google-Smtp-Source: AKy350Za+Dts70XAby1aukIHI55APncBRabY87KcRrmj7NhuzYlaV7/HtxWCBlFhdrKQm7EXvUFh5g==
X-Received: by 2002:a17:903:2308:b0:19a:a815:2877 with SMTP id d8-20020a170903230800b0019aa8152877mr22055822plh.6.1681909855603;
        Wed, 19 Apr 2023 06:10:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a7c4400b00246b1b4a3ffsm1385931pjl.0.2023.04.19.06.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:10:55 -0700 (PDT)
Message-ID: <b0ffa99e-da46-a373-a011-67f8e739eeca@kernel.dk>
Date:   Wed, 19 Apr 2023 07:10:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] splice: Fix filemap of a blockdev
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Ayush Jain <ayush.jain3@amd.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <168190833944.417103.14222689199936898089.b4-ty@kernel.dk>
 <1770755.1681894451@warthog.procyon.org.uk>
 <1828932.1681909055@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1828932.1681909055@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/23 6:57 AM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> [1/1] splice: Fix filemap of a blockdev
> 
> Actually, would you be able to fix the subject?  I left a word out:
> 
> 	splice: Fix filemap splice of a blockdev
> 
> or maybe:
> 
> 	splice: Fix buffered splice of a blockdev

Fixed it up.

-- 
Jens Axboe


