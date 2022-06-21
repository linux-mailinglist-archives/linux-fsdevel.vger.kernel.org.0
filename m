Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DCF553B9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 22:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353327AbiFUU1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 16:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiFUU1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:27:49 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F079D2EA03;
        Tue, 21 Jun 2022 13:27:47 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 942D241625;
        Tue, 21 Jun 2022 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655843265;
        bh=FHOjmjAGhb/jKh/X38HObStif09xq2VOvZEQFXt3zqo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=REhG/YvE5Y5HZv8PaXPYcPM44vP8IEJ8IMzZFA32j0rDjJBvP54vgsg5TljnEVb2C
         6l9Gw8xSjfI1zJUVeqU706hHjnfTfXBQg2mjFR6AwzXgBae9AkqRIO3MW8Nnl/QIYx
         a1aXnHf31tgETQ71gAcLHrFbepqdBlwyN+w4B9rXjnOL0oVRtEXzi0mdktd1n9nhlu
         c44GHwZtTKZGR9nZxxQNYa84k7b7lT8U8Rrb1bb1ojiaT2SzJ9CuwKDkd0rVfWt/0m
         kvplSORt2LLsRq1jQmvt49GetCZG97LSsyDGbhwWhE+cCGxDZom8/JBlMrQKyYTzOo
         3XS9YZXjztRIg==
Message-ID: <cd2a4ea4-52d2-cf95-7769-859b0a35b564@canonical.com>
Date:   Tue, 21 Jun 2022 13:27:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Linux 5.18-rc4
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        gwml@vger.gnuweeb.org
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org>
 <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
 <266e648a-c537-66bc-455b-37105567c942@canonical.com>
 <Yp5iOlrgELc9SkSI@casper.infradead.org>
 <dd654ee2-ae10-e247-f98b-f5057dbb380b@canonical.com>
 <Yqe+zE4f7uo8YdBE@casper.infradead.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <Yqe+zE4f7uo8YdBE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/13/22 15:48, Matthew Wilcox wrote:
> On Mon, Jun 06, 2022 at 02:00:33PM -0700, John Johansen wrote:
>> On 6/6/22 13:23, Matthew Wilcox wrote:
>>> On Mon, Jun 06, 2022 at 12:19:36PM -0700, John Johansen wrote:
>>>>> I suspect that part is that both Apparmor and IPC use the idr local lock.
>>>>>
>>>> bingo,
>>>>
>>>> apparmor moved its secids allocation from a custom radix tree to idr in
>>>>
>>>>   99cc45e48678 apparmor: Use an IDR to allocate apparmor secids
>>>>
>>>> and ipc is using the idr for its id allocation as well
>>>>
>>>> I can easily lift the secid() allocation out of the ctx->lock but that
>>>> would still leave it happening under the file_lock and not fix the problem.
>>>> I think the quick solution would be for apparmor to stop using idr, reverting
>>>> back at least temporarily to the custom radix tree.
>>>
>>> How about moving forward to the XArray that doesn't use that horrid
>>> prealloc gunk?  Compile tested only.
>>>
>>
>> I'm not very familiar with XArray but it does seem like a good fit. We do try
>> to keep the secid allocation dense, ideally no holes. Wrt the current locking
>> issue I want to hear what Thomas has to say. Regardless I am looking into
>> whether we should just switch to XArrays going forward.
> 
> Nothing from Thomas ... shall we just go with this?  Do you want a
> commit message, etc for the patch?

Hey Matthew,

I have done testing with this and the patch looks good. We will certainly
go this route going forward so a commit message, would be good. As for
fixing the issue in current kernels. I am not opposed to pulling this
back as fixes for

  99cc45e48678 apparmor: Use an IDR to allocate apparmor secids

but I would like some other peoples opinions on doing that, because we
don't understand why we are getting the current lock splat, and without
understanding it is a fix by avoiding the issue rather than being sure
the actual issue is fixed.

