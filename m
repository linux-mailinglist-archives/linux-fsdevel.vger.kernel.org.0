Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCA5960D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiHPRHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiHPRHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:07:08 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D547697E
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 10:07:07 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i77so5204761ioa.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jqExu6027VbmSB6Tje9Bb3jxUPW6GzjubzQREhz5GdU=;
        b=ORra4fGbxNVlvbe/S3XOa+onSoL/hZJ6BVWKCwAGONJBVZZxwOJG5GQHNG4uZV5wjf
         L8X2KmYiHn9e0WpFdRRxhl/jmdV5N3xQLLPGZ1BxmL4qAssb+83Wx8I/uNu1abR0zxft
         k0EyiWNoOD2NcB2P4RZCwvkqVfxJ5rYo1wBdRElPmxPonXrY9k6XTy0ETXniofWMBWo+
         mXkVWJIOfGVCMjUV9OuM2r1k3389bvYg6IicTjDywZzFbmkXSNw/ge1mhHqPZDRXvF40
         i5L7CQytOhNeh0qoRi0KPLoCwKODQsiHq/6QyRVOsetuPKAO6pXmSgmPrsnXiw8L59nT
         xIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jqExu6027VbmSB6Tje9Bb3jxUPW6GzjubzQREhz5GdU=;
        b=eMu/HBkJcaAhamV9YoWV75c0sIQalt2f4KZz8xpdHz8Akv/scnsB07x+I7Yj9wpAwF
         S1IQhU4ywZfLJWEYkCwv2RaXQu4g6vYimaFWooe1b+ujCngvHORFhr+pQx5FOLvr5a5T
         rdQSa/o8wk+Tl74If02vGFkDpz8DVyVlk2xLTwMmb7OgEnO6knfJCdBACiqaMZPiXxnI
         Nl7NbjDZn/5fIAPqV+HjKzaz0+nLiuqv27JTZuQxK6LOWeyEDHQjMOovWMwR+VAZdwpV
         U0Ug02vGgrkWP8JlO/WIDTz3srPXx3CpK3Gx8Eehxgn+KMVnGoY6yW8ReAHYex/AsVnk
         c2BQ==
X-Gm-Message-State: ACgBeo3smXiYiTyATFXBh+1k06GBezv1IanXUzW7IiebekaL6VfOqC+Q
        um3lUgFTQz+pfhn9PWGft4y0bw==
X-Google-Smtp-Source: AA6agR76E2ivXrhi58XyJGk+JqgDElgBBRja27GzQPGgABQYYJRFs/P3IRtbDMe8Uuvu8yOijAtLNg==
X-Received: by 2002:a05:6602:14cc:b0:67c:33f:c8bd with SMTP id b12-20020a05660214cc00b0067c033fc8bdmr9406201iow.70.1660669626983;
        Tue, 16 Aug 2022 10:07:06 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c20-20020a023314000000b003431865d3c6sm4671175jae.7.2022.08.16.10.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 10:07:06 -0700 (PDT)
Message-ID: <753d37cd-6b63-4fb5-eeb9-dd9f620ad8ad@kernel.dk>
Date:   Tue, 16 Aug 2022 11:07:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH v1] fs: __file_remove_privs(): restore call to
 inode_has_no_xattr()
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>, Stefan Roesch <shr@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com, jack@suse.cz,
        hch@lst.de, djwong@kernel.org
References: <20220816153158.1925040-1-shr@fb.com>
 <20220816170128.inzqyuj4snywiwqx@wittgenstein>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220816170128.inzqyuj4snywiwqx@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/22 11:01 AM, Christian Brauner wrote:
> On Tue, Aug 16, 2022 at 08:31:58AM -0700, Stefan Roesch wrote:
>> This restores the call to inode_has_no_xattr() in the function
>> __file_remove_privs(). In case the dentry_meeds_remove_privs() returned
>> 0, the function inode_has_no_xattr() was not called.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
> 
> Looks good to me. As Jens said, this should get a fixes tag and should
> probably also have a link to the perf regression I debugged this on so
> that we can see whether this was actually the cause,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Yes good point, this is a case where the Link actually makes a lot of
sense.

-- 
Jens Axboe
