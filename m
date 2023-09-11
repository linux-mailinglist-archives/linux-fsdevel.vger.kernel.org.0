Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F27279BF7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjIKU4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243799AbjIKRpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:45:41 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE948CC
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 10:45:34 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c06f6f98c0so39518185ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 10:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694454334; x=1695059134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmhLML4KpR4efDlZrStXoV2DBR7UACdYfD3+iLTBzB0=;
        b=E9i89Sul7NmLBJtYU3SqetRKpsbTuoP6KlI1V3Kj5ZdqiXetiXF9LDZaAIY7xlsDaV
         zTQjkOggt9d5CkR6hnnef3J6LYPgbXg8c78Q97qW+8Kgb7WVwLpYXVUyXs6T1wJtiyc/
         aM1dYKGVIzgjbTqlgP+lA/0sPTWGF/3nEvFIjGvFjpEwBMlCO46wWdgfFdBf2yDqrgkz
         k7rRSbgYQvn1P0Kzwi5igvEOVhhkJ0jzT/fZQKgY3NLCiMGoROWkCf+6jj4rAZ8qVRiB
         G35oQ5ilN3KC+URCwX2mLC//746eKqpkNKgjXQZVQ+39Z0YiVNAuUbiXt8pewQmK1u4B
         H8+g==
X-Gm-Message-State: AOJu0YxMpR0K6nuiuN3NczkzKkW+nQYqq22XKZ+zMI09+s2I3LvYVXqJ
        xopSWp+gUhhAYgivKcJEEso=
X-Google-Smtp-Source: AGHT+IGAK1vwR2Dtvo6dIMcAFPA8RxqV5y2QVj7GHOxfrQJ5uzFSxcAdrqQPGc2hdLaQLMx2eo6DMw==
X-Received: by 2002:a17:902:9046:b0:1c3:c5b5:8a83 with SMTP id w6-20020a170902904600b001c3c5b58a83mr1333592plz.4.1694454333824;
        Mon, 11 Sep 2023 10:45:33 -0700 (PDT)
Received: from ?IPV6:2601:647:5f00:5f5:4a46:e57b:bee0:6bc6? ([2601:647:5f00:5f5:4a46:e57b:bee0:6bc6])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902694400b001b531e8a000sm6712119plt.157.2023.09.11.10.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 10:45:33 -0700 (PDT)
Message-ID: <3c66d844-67e5-82d2-6d14-9f6c6b6fcc36@acm.org>
Date:   Mon, 11 Sep 2023 10:45:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     David Disseldorp <ddiss@suse.de>,
        Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>,
        Octavian Purdila <tavi.purdila@gmail.com>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <20230909224230.3hm4rqln33qspmma@moria.home.lan>
 <ZP5nxdbazqirMKAA@dread.disaster.area>
 <20230911012914.xoeowcbruxxonw7u@moria.home.lan>
 <ZP52S8jPsNt0IvQE@dread.disaster.area>
 <20230911153515.2a256856@echidna.fritz.box>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230911153515.2a256856@echidna.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/23 06:35, David Disseldorp wrote:
> The LKL block layer may also become useful for legacy storage support in
> future, e.g. SCSI protocol obsolescence.

There are probably more Linux devices using SCSI than NVMe. There are 
several billion Android phones in use. Modern Android phones use UFS 
storage. UFS is based on SCSI. There are already UFS devices available 
that support more than 300K IOPS and there are plans for improving 
performance further. Moving the SCSI stack to user space would have a
very significant negative performance impact on Android devices.

Bart.

