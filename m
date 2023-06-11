Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183FD72B3DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjFKTuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFKTuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:50:44 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E6126;
        Sun, 11 Jun 2023 12:50:42 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EDA0B30D;
        Sun, 11 Jun 2023 19:50:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EDA0B30D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686513040; bh=hDSRJMoOpntKJzGtxrfQOjDqP5x14HFCfFEJj5J/KXw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BBGvgRZe3XcLhP1o64wx4ykNZv9fr+YvHc1SW/EUzvc4uNisFibK6aPfY9sUaNnpW
         K3fNSz51FkT1qQriITla4KHDPSXOuGmbf7fwDAH3eUGhkgRQMFEzeQmFSZWECjnHJv
         EVjwha5JYfIimVt6ueGzDk/IoCA9MW1kYK0V17/uc4lSyFEQSpuGFtt8+TY/LZhbEk
         DHvYrpl9UyK1+IBDRj8TBoeLPaJB2REjnxBdNWn5sR3eamUisfmwcotqwLejk+HafI
         Y2f3t4z4fZnpPMYeJQM7QsXaJSDGE08etkdtNuESZHubE9iP/OClpP25vheHt2fvKV
         etGjtLdO8LSRQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>
Subject: Re: [PATCH] fs: Fix comment typo
In-Reply-To: <ZIXEHHvkJVlmE_c4@debian.me>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
 <ZIXEHHvkJVlmE_c4@debian.me>
Date:   Sun, 11 Jun 2023 13:50:34 -0600
Message-ID: <87edmhok1h.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Sun, Jun 11, 2023 at 08:33:14AM -0400, Shaomin Deng wrote:
>> From: Mao Zhu <zhumao001@208suo.com>
>> 
>> Delete duplicated word in comment.
>
> On what function?

Bagas, do I *really* have to ask you, yet again, to stop nitpicking our
contributors into the ground?  It appears I do.  So:

Bagas, *stop* this.  It's a typo patch removing an extraneous word.  The
changelog is fine.  We absolutely do not need you playing changelog cop
and harassing contributors over this kind of thing.

>> Signed-off-by: Mao Zhu <zhumao001@208suo.com>
>
> You're carrying someone else's patch, so besides SoB from original
> author, you need to also have your own SoB.

This, instead, is a valid problem that needs to be fixed.

Thanks,

jon
