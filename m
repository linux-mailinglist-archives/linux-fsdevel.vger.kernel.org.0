Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC1753509
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjGNIbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjGNIbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:31:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5111FDB;
        Fri, 14 Jul 2023 01:31:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9DB6A1FD60;
        Fri, 14 Jul 2023 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689323492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QhgMcxLrCOJceW2qDrEP0VVk9ydlAYkW2ZZG9lWHYU=;
        b=FvvQ9YCvAdL4LvIgbXynv6ZhxMygRtwtwXrRd9977cNjSeMIoy1SrQCXnizsGWes5Xd0DJ
        E5hKiEQ0gZkLux3MPF8vXU6Uh19yoBlbHHD9mDEZR9fSdWrhwmMXolBQCgDCLR8qGVySub
        4c0wDldvEsZ94n0PtefUxR39MFGHI0I=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 721212C142;
        Fri, 14 Jul 2023 08:31:32 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:31:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     huzhi001@208suo.com
Cc:     tglx@linutronix.de, senozhatsky@chromium.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Fix four errors in kmsg.c
Message-ID: <ZLEH5AQKsfLfSxV7@alley>
References: <tencent_053A1A860EFB7AAD92B2409B9D5AE06AB507@qq.com>
 <2f88487fa9f29eeb5a5bd4b6946a7e4c@208suo.com>
 <ZLEF16qgcTOaLMIk@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLEF16qgcTOaLMIk@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 2023-07-14 10:22:48, Petr Mladek wrote:
> On Fri 2023-07-14 14:57:59, huzhi001@208suo.com wrote:
> > The following checkpatch errors are removed:
> > ERROR: "foo * bar" should be "foo *bar"
> > ERROR: "foo * bar" should be "foo *bar"
> > ERROR: "foo * bar" should be "foo *bar"
> > ERROR: "foo * bar" should be "foo *bar"
> 
> Please, do not do fix these cosmetic issues reported by checkpatch.pl.
> It is not worth the effort. In fact, it is contra productive.
> It complicates the git history, backports.

BTW, Did anyone suggest you to fix errors/warnings reported by
checkpatch.pl?

You seem to be 2nd person who sent similar patch from @suo.com
within the last week. The first patch was rejected as well,
see
https://lore.kernel.org/all/f2d8eb955890bc1db1b307db713d4a4a@208suo.com/

You might want to tell this person that there are better ways
how to get involved into the kernel development.

Best Regards,
Petr
