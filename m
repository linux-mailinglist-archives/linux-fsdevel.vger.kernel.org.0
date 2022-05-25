Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCC534554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbiEYUvt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiEYUvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 16:51:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186390CC8;
        Wed, 25 May 2022 13:51:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653511903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZDl80JBPxS+b93PiaRkd25Ow2PNjtzjUYJRAybObzk=;
        b=BzoGER2of+N4xtQYPriqeW8SV1MPtswLranOSADCpWbhYI1J/1CG3k2nfX/FmrR7elc3Ne
        8L7X4xJ2brkeEpD6XGeGKYM4aM/nVfxoWxA+2ayKTIr1Zb/h7/r2u7RIC5c8CFkrwB6y/e
        Wkr2nIvuP9zg87/51fxlH8t3bXWzj+tctOM2kK1rpVBoZqeMoeX+LBPk+TAM8IjcX8paIf
        0mBhurZQFAnJ8g1+UsM1OKAQgn8GAYi6ETiVZoSUMkKvtp/XaovaTpiSj7bXo7/htx8PsW
        qJgC3uvmzwYvT0B4DLrcWS3qSLgARx6ohJZmGCQzxG5KOXI+9zU/BFCXdDDjfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653511903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZDl80JBPxS+b93PiaRkd25Ow2PNjtzjUYJRAybObzk=;
        b=TPSBS0MBJUFg5dH1oSqss/pt8r3y81Z0jbqklBFKISMUg2FHDCSf7Sul+A7m+O3zLV9/Ym
        STpGccm/zC/57CBg==
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Richard Fontana <fontana@sharpeleven.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        keescook@chromium.org, rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        copyleft-next@lists.fedorahosted.org,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
In-Reply-To: <Yo5f9nctTwHZqPbl@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org> <87ee0k0wrn.ffs@tglx>
 <Yo5f9nctTwHZqPbl@bombadil.infradead.org>
Date:   Wed, 25 May 2022 22:51:43 +0200
Message-ID: <874k1dz674.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25 2022 at 09:57, Luis Chamberlain wrote:
> On Mon, May 23, 2022 at 11:22:36PM +0200, Thomas Gleixner wrote:
>> This paragraph is not really understandable for Joe Developer.
>> 
>>   copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
>>   can therefore be used for kernel code. Though the best and recommended
>>   practice is to express this in the SPDX license identifier by
>>   licensing the code under both licenses expressed by the OR operator.
>> 
>> Hmm?
>
> Let me try clarifying this further, how about:
>
>    copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
>    can therefore be used for kernel code. Despite this, if you use
>    copyleft-next-0.3.1 on Linux, the recommended practice is to express
>    dual licensing with GPL using in the SPDX license identifiers by
>    using by the OR operator.

  'using in the ..' ?

and

  'by using by' is off by one 'by' :)

I'm not seeing how that clarifies stuff further. I might be biased, but
the version I suggested is crystal clear.

>> > +  To use the copyleft-next-0.3.1 license put the following SPDX tag/value
>> > +  pair into a comment according to the placement guidelines in the
>> > +  licensing rules documentation:
>> > +    SPDX-License-Identifier: GPL-2.0 OR copyleft-next-0.3.1
>> > +    SPDX-License-Identifier: GPL-2.0-only OR copyleft-next 0.3.1
>> > +    SPDX-License-Identifier: GPL-2.0+ OR copyleft-next-0.3.1
>> > +    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
>> 
>> Please don't propagate the GPL-2.0 and GPL-2.0+ tags. They are
>> outdated (still valid) in the SPDX spec, which reminds me that I should
>> update the relevant documentation...
>
> OK thanks for the recommendation, I'll leave it at:
>
> +    SPDX-License-Identifier: GPL-2.0 OR copyleft-next-0.3.1

	SPDX-License-Identifier: GPL-2.0-only OR copyleft-next-0.3.1

please. See my previous reply quoted above.

> +    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1

Thanks,

        tglx
