Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938FE6ED707
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjDXV4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDXV4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:56:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF75FDF;
        Mon, 24 Apr 2023 14:56:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A13C2CD;
        Mon, 24 Apr 2023 21:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A13C2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682373378; bh=Wq11dfAggNyZlE0KttVODI2vffVs50Rrp2u1sNKbeQo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PoxkL2fSCeVuxY1ApkVQwvJCTNA1ZGYyYlRzxbfglVXirWJTg72Wt0fRSZ5mr8w5T
         ACfvDQL05kIBuf3DLZI2AR0z4L5LnDnmhXbAXcO/cYfIzzHiLsw/o25bH2VTcIPUwe
         IyJ8Kp1tfLyFZAM3+/wc6qyYFgzhfRHWyk/jxgKR1kX+S7CCFvdvoZrAouYXj8WcZZ
         oyaLm0fKxHIWuZYklEUNmaWTkLFCLcDNQVwIyunQWpYcCyhbphCFReuIuJL/0NIdF7
         kuc5OxsXDgrob3GK3C74f4/mAq+A28ShNxWzUeARmZcsFBXl+p3UFCbYq7h3bJU0AZ
         4cprvoIryBm/Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] open: fix O_DIRECTORY | O_CREAT
In-Reply-To: <CAHk-=whykVNoCGj3UC=b0O7V0P-MWDaKz_2r+_yGxyXoEMmL8w@mail.gmail.com>
References: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
 <CAHk-=whykVNoCGj3UC=b0O7V0P-MWDaKz_2r+_yGxyXoEMmL8w@mail.gmail.com>
Date:   Mon, 24 Apr 2023 15:56:17 -0600
Message-ID: <874jp5lzb2.fsf@meer.lwn.net>
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

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I did keep this link:
>
>> This has also been covered in
>>
>>         https://lwn.net/Articles/926782/
>>
>> which should be publicly available by now. It provides an excellent
>> summary of the discussion.
>
> although it's behind a paywall, which isn't optimal.

The paywall goes away on Thursday, so this is a short-lived problem.

Thanks,

jon
