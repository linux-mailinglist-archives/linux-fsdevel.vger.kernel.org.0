Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED16755B33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 08:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGQGJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 02:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjGQGIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:08:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2187010E9;
        Sun, 16 Jul 2023 23:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h5vdt92bSyg0EvA2PkQICdCJejhDYO1TdTN8tcGwlR4=; b=RJDLAwykm/r7eS/4pmQ1NgICEy
        VcZNBvftSfVhYPsJFMTYuxVkUitF6isZsQuRrv6Wlh/k8u2DlhatHZHdUYQwsDP97PI8Gk9t2HM2C
        KDvfwRPtGeG7kLgmfFaeBNq5arhW9uefih7uKAbGBQCTyEXQPaeZ2wCZLsTi8E4YFxNIGiXLFzC38
        u2DcVWK9eBAVOuGSdWoN+FiyQ/bJPgAzmFUVO6puvIldgClw0eOVKXHIVXPhdL3v6ADn1vV24PsGL
        yHjvxu5Wv3WfWZA3ha/itphMe0sCpqQzDS4cSeNtYr7Pm6tcJK/j7Ivw7Lm8lrmU2S2sX5aVif8Nq
        47qWKC7A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLHPM-002wMg-1z;
        Mon, 17 Jul 2023 06:08:32 +0000
Message-ID: <658bfc14-3819-8cf2-6e08-a9794c72f4c8@infradead.org>
Date:   Sun, 16 Jul 2023 23:08:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] proc: Fix four errors in kmsg.c
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>, huzhi001@208suo.com,
        Petr Mladek <pmladek@suse.com>
Cc:     tglx@linutronix.de, adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <tencent_053A1A860EFB7AAD92B2409B9D5AE06AB507@qq.com>
 <2f88487fa9f29eeb5a5bd4b6946a7e4c@208suo.com> <ZLEF16qgcTOaLMIk@alley>
 <20230717060500.GB57770@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230717060500.GB57770@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/16/23 23:05, Sergey Senozhatsky wrote:
> On (23/07/14 10:22), Petr Mladek wrote:
>> On Fri 2023-07-14 14:57:59, huzhi001@208suo.com wrote:
>>> The following checkpatch errors are removed:
>>> ERROR: "foo * bar" should be "foo *bar"
>>> ERROR: "foo * bar" should be "foo *bar"
>>> ERROR: "foo * bar" should be "foo *bar"
>>> ERROR: "foo * bar" should be "foo *bar"
>>
>> Please, do not do fix these cosmetic issues reported by checkpatch.pl.
>> It is not worth the effort. In fact, it is contra productive.
>> It complicates the git history, backports.
> 
> Absolutely agree with Petr.
> 
> As a side note, I wonder if checkpatch can deprecate that -f option?

Either that or document in very strong language that it should only be used
in very special circumstances, usually by the file owner or maintainer.

-- 
~Randy
