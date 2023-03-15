Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C96BBB0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjCORkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCORkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:40:05 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9F4DE12
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:40:03 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i19so10743531ila.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678902003; x=1681494003;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5df0VVcQalC1bXRcr/ZzFE9DW4g6pmup34uWUxk2BE=;
        b=zwxQprHXlzq84Q96JdMBQaXVvSCHCBcJxqwLAdS2/M6P2PZf8X+QBMdh444n639VR4
         9WawyHfreN9zeFpPIMhQsN7v7r0TWD5dW79rcxlqjdiRYD9CKeuHkVzP5OWvsI8S+cvb
         GDC4tEZKH/QFkrr8nDLOkHeZriSUz/RbHofPkaXRLz6fCHLG90K7wPEWbwpuibh0EhcR
         33COVEz8u5PDhku1P4VHqFjFgejAw7CwBqNz45vHuiNQSzxFc3uFKrVQz8nlcFD8nJwq
         dMtxuCBUyahbswuu6YxFGozBwSWkHygIp6T2Q+IOaD+QgWYfWWa0Sr2JJEOOVVm6dXWr
         6wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902003; x=1681494003;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5df0VVcQalC1bXRcr/ZzFE9DW4g6pmup34uWUxk2BE=;
        b=J4PdDk/DSnP+oE/LzZRH4saIRERkzptMF/HMxFisrIhPcnwb86DgoLhEfhFvmMTQ7v
         eDj/oqTOAR4T+gjh4waaG65Ruz79TeZJbX6oaDP4Sh9Xy7PYWMxqRL1Fa9l5mx1Vz43G
         MC4ydJPDHq4INOFGw/hHWVJ7B0AckZTImrIQjRrZ/plwnApIauvd2v09PyjXiG2GpKpm
         PThHig6YYjczh5UUZFSrlxOE9Ka9W57jh3EfjZEU8YI0b/JiKiKPlTPU5jBMSo4rY82l
         mc+B2LSwfebiQPIgyf8zqm9qLZh1AaX9CQogTWieL6TP+InuiLD3IwvSlJMwFhOMcjNx
         NGQA==
X-Gm-Message-State: AO0yUKUbNf0r9zWCPJHqerriAFPYoFK3VSa5mMEfK1HcpNP8JG6YIhfE
        xOdfRpBFWUjXbhHmEU2bgsA0TrdYm2kU5aCaukccHg==
X-Google-Smtp-Source: AK7set8OzK+A6f5D0yNLMn24/3DUQDhPAXFB5nnrO48ARbTVMVcy3wWxXjFNd9A785kMM5Plifl11g==
X-Received: by 2002:a05:6e02:dd3:b0:317:2f8d:528f with SMTP id l19-20020a056e020dd300b003172f8d528fmr62272ilj.2.1678902003223;
        Wed, 15 Mar 2023 10:40:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y17-20020a056e02119100b0031798b87a14sm1786576ili.19.2023.03.15.10.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 10:40:02 -0700 (PDT)
Message-ID: <b11d27d5-8e83-7144-cdc8-3966abf42db5@kernel.dk>
Date:   Wed, 15 Mar 2023 11:40:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHSET for-next 0/2] Flag file systems as supporting parallel
 dio writes
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20230307172015.54911-1-axboe@kernel.dk>
In-Reply-To: <20230307172015.54911-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/7/23 10:20 AM, Jens Axboe wrote:
> Hi,
> 
> This has been on my TODO list for a while, and now that ext4 supports
> parallel dio writes as well, time to dust it off and send it out... This
> adds an FMODE flag to inform users that a given file supports parallel
> dio writes. io_uring can use this to avoid serializing dio writes
> upfront, in case it isn't needed. A few details in patch #2, patch 1 does
> nothing by itself.

I'm assuming silence is consent here and folks are fine with this
change?

-- 
Jens Axboe


