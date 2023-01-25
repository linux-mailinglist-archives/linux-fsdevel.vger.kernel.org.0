Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7FE67B480
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 15:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjAYOcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 09:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAYOcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:32:14 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EABED504
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 06:32:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z13so18031308plg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSv8WpaqrU88nGheGtiai7Y/5wRVY8MkM9KRN4G+ukg=;
        b=6TUazUJSiXGMCc9BZgnJ+ncR58zGFe+HwYOk/rr3xHuxMwoEBSZXgJ8YDUrwx+QrDs
         0yoqVhDUylo/qQV9t9vD7a48v/MA1BWUmvM1KIIeVhk9zteWjxsufEqEqKwKSefrLD53
         rSSTFz/23fiMM4UZHT7qYjhZz0GkfpM88GDQ7GMPWjY7hn8sbVgZTMjZHU1pL4UXDB98
         mK4uNvSGO4tCZYMv3DSy8Y3aHSj87MDVVD6wat1ztVKQ+06I9/6tzukHWdAci17SsAz8
         ApNiiBU/qtAwtuPS0o1YadtuehG3+LqSVZvQM9bAhT/U2JtZKE9mLtINVYY4tX9+UwFG
         PNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSv8WpaqrU88nGheGtiai7Y/5wRVY8MkM9KRN4G+ukg=;
        b=N0pYKAMPP/vYGLPuanrv4Wv6FOsiabvao8yavhBAn1Z0TTibsCntdVIRyWIchVW6dm
         s+81V0eBjkhYu4a6nvs+enUBtf5ax1wg64birUIWafWnkEf+1lTYOtODHGov/wB7i5c6
         uWLUixnrPWUUwSVWjvMF3jhg2YIvYaSC425DLLI5ftxtL3NpmSb9+cvKR6NVTlbntpR5
         Wgf0DPbDDUWfLDJHukWUAM0D6jp9DuXvtGjQuZ3i1FTUzpAMf9yyzvZVTrCokWgAtUeE
         27C7GLLiXlStMHY7GzXB6AajGUDgn6uinuux67bVz/F0ucWh1daiQhk1xPkHid5QrCTx
         MOmg==
X-Gm-Message-State: AFqh2kqgeVgd8ClQrXp4NawaseydpdC1hAjPwXQQYj+f/tMTMQUtemur
        HeK37CbcxEJdIFOJBkcoWzS0+Q==
X-Google-Smtp-Source: AMrXdXtSjhgXq/ti77BjIjNmng+Rkvj5Dbfyvd4sgmo3FggcVSTo6y9uVmruhdChTgf8/MyBasa0Dw==
X-Received: by 2002:a17:902:b591:b0:18f:a0de:6ac8 with SMTP id a17-20020a170902b59100b0018fa0de6ac8mr7903292pls.2.1674657128759;
        Wed, 25 Jan 2023 06:32:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bb2-20020a170902bc8200b0018bc4493005sm3664530plb.269.2023.01.25.06.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 06:32:08 -0800 (PST)
Message-ID: <aa5ca868-d8ca-8278-509a-dd511ffdb4a8@kernel.dk>
Date:   Wed, 25 Jan 2023 07:32:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: remove ->rw_page
To:     Christoph Hellwig <hch@lst.de>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20230125133436.447864-1-hch@lst.de>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230125133436.447864-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/23 6:34 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the ->rw_page block_device_operation, which is an old
> and clumsy attempt at a simple read/write fast path for the block layer.
> It isn't actually used by the fastest block layer operations that we
> support (polled I/O through io_uring), but only used by the mpage buffered
> I/O helpers which are some of the slowest I/O we have and do not make any
> difference there at all, and zram which is a block device abused to
> duplicate the zram functionality.  Given that zram is heavily used we
> need to make sure there is a good replacement for synchronous I/O, so
> this series adds a new flag for drivers that complete I/O synchronously
> and uses that flag to use on-stack bios and synchronous submission for
> them in the swap code.

This is great, thanks for doing it. There's no reason for this weird
rw_page interface to exist.

-- 
Jens Axboe


