Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A913F5A734C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 03:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiHaBWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 21:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiHaBWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:22:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4BB0888;
        Tue, 30 Aug 2022 18:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=vkC7YbGzcZlYm9RaWlAt34O4KbVTqpqAYy7ynMzo02g=; b=mfp/bZ3g9+9Ju4lllH4EyuLxsq
        XiHrpf3oC7uydhxIXrb1d20M9XXEMoN7cxOttnon7E9HOdiMUEXRbZFVls0AtN3n6IZQjPJDWWKaw
        HCwC1U8YtykW1o8aBsw22nbmSdFnLKWg/L4gRxTmR/KljgI5EA39pDSQcs2BCg/x8r2FJPoFF37zm
        kFAMakiv6ePHxSPVIQo/RJmggB2oXMMO1398z+2VMW3eJSf4/k3l/cEaFpCVO5l2OoUJ1HtXbUU23
        x79TJGuNsC6UhlGGREjxC9RxquEzfjNqlRcMvhZE2nhk+1n7dwr+9wsADFtBi/G70U0U1dq8vJjHq
        8XBjFtow==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTCQy-002ydd-FD; Wed, 31 Aug 2022 01:22:24 +0000
Message-ID: <ab1a33e5-01b9-79d4-662e-44c6e0e74113@infradead.org>
Date:   Tue, 30 Aug 2022 18:22:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] Documentation: filesystems: correct possessive "its"
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>
References: <20220829235429.17902-1-rdunlap@infradead.org>
 <Yw56rVwBRg0LbC41@ZenIV> <Yw6Hp8l/7p3wbiGq@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yw6Hp8l/7p3wbiGq@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/30/22 14:56, Theodore Ts'o wrote:
> On Tue, Aug 30, 2022 at 10:01:33PM +0100, Al Viro wrote:
>> On Mon, Aug 29, 2022 at 04:54:29PM -0700, Randy Dunlap wrote:
>>>  compress_log_size=%u	 Support configuring compress cluster size, the size will
>>> -			 be 4KB * (1 << %u), 16KB is minimum size, also it's
>>> +			 be 4KB * (1 << %u), 16KB is minimum size, also its
>>>  			 default size.
>>
>> That one doesn't look like possesive to me - more like "default size is 16KB and
>> values below that are not allowed"...

I have to disagree about the possessive part...

> That being said, it could also be rewritten to be easier to
> understand.  e.g., "The default and minimum size is 16kb."

but sure, it can be rewritten.

thanks.
-- 
~Randy
