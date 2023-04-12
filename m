Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF06DF806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjDLOIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjDLOIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:08:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064669756;
        Wed, 12 Apr 2023 07:07:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6343fe709f2so1453581b3a.0;
        Wed, 12 Apr 2023 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681308476; x=1683900476;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L0PYAVtyYM1dQ/ebxfBK5UJmljgy7JeY2CU5mkCsv7k=;
        b=hLAlJZpWrXqh+9UGnJF2plcRfeQgHtJehVG9T+IOrfSuMg+AkANiX8XDi/il8xJELO
         g3djfcfKVoUbZpcFMB+bDxJXtqcT8ktAmeGIfEnGzsVAn+rWAZJY+EvkHZhqZ10nApZN
         6kRHBig3nISmSs9TtX8hMlUgbTuvTXn60me43/zjhj9/2zckwCWgJlFvcZup5vB9YlHu
         P+dyERjyINoRQTECDyLxmgUk2ejIcsRF6sDzSphjaJMZ6w4SfE/ObxpzUkIE1Na2nPb/
         oOInxCzAs14v5QYrF8ajfKWJPmzbP35eA2ZtF+olKYtJXosJYqkOjtN8lR/MG28d9GOR
         TxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308476; x=1683900476;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0PYAVtyYM1dQ/ebxfBK5UJmljgy7JeY2CU5mkCsv7k=;
        b=Vw3JwtNo/EuY+d8HIzHWAmbldreIEBj17lj2r3QV8AqI3c1fkoqySRE5X7Nw1mXI0C
         fXcs+wsrSuN19uT4GxEF4QgqnR4oHkqy4ad11f3BDjSQ+aYNfNrjelCq1drb4RzKuiQA
         jjTYXQUDROe+XXdYPFed6X02PWFMUQ54tvwscyHEBDqwThbvdTsfCGWAulRC4ZSU1/40
         a93walLmr4qKuFxm63+2T5ZR/rB+q2/d4m9ncH+ZZDsDCoo2w8PmdpPg+QcFvIDcQr0g
         NuETrxd77ZKA33wV2wkTJfskzta0Uoy1yLMFcAew9FYQHDC/qxwCes73A9Tbg0Qzy3bv
         iOGw==
X-Gm-Message-State: AAQBX9e773XVUzU8xJpWzLnZ9ICWtGWJaU0LUQRzzWcfLUQX7KyLCncq
        qz2x1bCTF5AFwcnMXNIN3Dk=
X-Google-Smtp-Source: AKy350YOWNO+adfmflZJwFMDke/pfLxcwNtquYXtXxOiUk25zW3TqLFkdaWk3qXe7YxoIzKykwGSbA==
X-Received: by 2002:a62:1841:0:b0:635:dce4:59fb with SMTP id 62-20020a621841000000b00635dce459fbmr13782298pfy.0.1681308476339;
        Wed, 12 Apr 2023 07:07:56 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id e3-20020aa78243000000b0062619a002f6sm11751898pfn.187.2023.04.12.07.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:07:55 -0700 (PDT)
Date:   Wed, 12 Apr 2023 19:37:50 +0530
Message-Id: <87o7ntyz0p.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 8/8] ext2: Add direct-io trace points
In-Reply-To: <ZDaZqL8eAw5qgecQ@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Apr 11, 2023 at 08:41:05PM +0530, Ritesh Harjani wrote:
>> Sure. Let me also add a trace event for iomap DIO as well in the next revision.
>> However I would like to keep ext2 dio trace point as is :)
>
> Am I confused, or does this patch only add new trace points anyway?

I meant to keep ext2 trace point as well. One of the reason for
that would be if someone wants to just enable all ext2 related tracing
logs, it would be easier.

$ trace-cmd -e ext2
$ trace-cmd report

But since iomap dio also doesn't have a tracepoint, I am looking to
add that in the next revision.

-ritesh
