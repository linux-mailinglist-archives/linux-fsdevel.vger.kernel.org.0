Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76F6D873E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjDETsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjDETsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:48:06 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A47ABF;
        Wed,  5 Apr 2023 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1680724076;
        bh=uvCYyEGQDMEh3nNClT8Hga8mQeF+OmdlmraiBFgDXwU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EmPRZD7lTmI0KRdhMqEtqIpAmXjGbqLOJFGG2oLcil2BfClRiBCtZ2/OqEJ4GAKRJ
         K2Ju1v4v09wV88dKOPkjk2yjVkzxKX1FZnXunh9y/Kx7KAI8I0YtzSB0dJKtUyv0kp
         NiVAAKe2I/z6oKsjKTQW5xds/s9iIRkmFKTQFygQ=
Received: from [192.168.31.3] ([106.92.97.36])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id A0F89268; Thu, 06 Apr 2023 03:40:15 +0800
X-QQ-mid: xmsmtpt1680723615tojklei61
Message-ID: <tencent_1A9532B54AD0FB644D7A28B39C5FF9B34506@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJYgHb/+yPhJvUZ7Fjni4pQEIxnLJDYjMNtYPrLQrnLv1BmcljkG
         XLqhGOisDeEGCV/yhIPD0LdG36pBtKzmVeOr80JpLyCwGj+g7ZUMSrdIa1VOMPKLj4d05wTyA+sl
         hSCUWhO6i6tRKXw+217cnoMWH4cd9SBy+0S7DMETA0zJZZKtBAf7Lwvz+hILnxfFba/ImUCIS8Nv
         +A224EeGxIE/AETMDRUVKEnhRhddoifnJteCOSNTjxyarveHqmafRbJpTwNb8A2eOxlu3BK02OIU
         0ZOiTJ8w86SqRO1jWhO+cr7MRH4uSSYHyttYguP8eBX1hV5wTaXWLomcwj49Q06XgU4yzZdYAXat
         BogicRHWjJqeb4xh8gKFwcu2E9QLCfXJGNH48ky9P/YWricjyHyPqTInSuYX3DNmp/RbTLdQHvcz
         NBb+tQSrSardXjJDHmtOKR9hzWtoH32VX6C8acmpT9I3NhsHaakuQOOz5LkKmcCW5DVHKkAVyYYd
         ZGqpckCMsZXXSrsvwE0J4QdpGCrZw8BG12mKGwaXrffw8nsaInvjW7xd0IhzO3JE1Xs0/HbG/Ds0
         8rIn7tG/bPsg65HrBCk/gLRtnCpbzYs9K4rsmkGOS7ZPV/lau4+AgybUUf599sWBkjwSDl9ghy0q
         5IhcF0hHtwJFxwLlRevJyAto02QwEM5bmKo0Tp8mgzLSvdW3lC6MNnnisibWU37bAB2KJt457s1M
         8cx/yx8QZ5wBjp+aW0IteFuuplcmzEpzwsa3VGaCxM0ch2PAl4GGzksIku3JeTtEIGxM4cmzlw5h
         FqqmQGTGTVA/sbEQWYGl6bxtj2rH+gbUDAqvryzD3G9fkhTx3n5lr1Ib++H3npOnb4S0l22cZIiN
         ZsMFLd8h9ZucP+uVZQtDsYbq2U81M1MsgMoJFwi61NLjFJgmQDWdYKMR5VRDoN5XI/oADsftLabQ
         e2tS7kh0qYH0ftt8nUldUPzUk0iYyhg2y+WWS9775BSbHQp+6Q19vp3AFcsrFJ6SgeVj1WYgJvJz
         4JEOJHGq0XHVmQDify
X-OQ-MSGID: <5944fa67-335c-9ee0-6227-ccf521be0d31@foxmail.com>
Date:   Thu, 6 Apr 2023 03:40:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [RESEND PATCH v2] eventfd: use
 wait_event_interruptible_locked_irq() helper
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@google.com>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_16F9553E8354D950D704214D6EA407315F0A@qq.com>
 <43fd324c-585c-d85b-230c-5b086e1aaa2c@kernel.dk>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <43fd324c-585c-d85b-230c-5b086e1aaa2c@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2023/4/6 03:26, Jens Axboe 写道:
> On 4/5/23 1:20 PM, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> wait_event_interruptible_locked_irq was introduced by commit 22c43c81a51e
>> ("wait_event_interruptible_locked() interface"), but older code such as
>> eventfd_{write,read} still uses the open code implementation.
>> Inspired by commit 8120a8aadb20
>> ("fs/timerfd.c: make use of wait_event_interruptible_locked_irq()"), this
>> patch replaces the open code implementation with a single macro call.
>>
>> No functional change intended.
> Looks pretty reasonable to me. How did you test it?
>
Thanks.

We have verified it in some local testing environments, and the 
intel-lab-lkp has also tested it more than a month, as follows:

https://github.com/intel-lab-lkp/linux/tree/wenyang-linux-foxmail-com/eventfd-use-wait_event_interruptible_locked_irq-helper/20230217-023039

--

Best wishes,

Wen


