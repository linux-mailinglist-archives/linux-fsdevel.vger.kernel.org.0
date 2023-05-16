Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C070565A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 20:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjEPSup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 14:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjEPSun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 14:50:43 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1643583D3;
        Tue, 16 May 2023 11:50:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7F19B993;
        Tue, 16 May 2023 18:50:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7F19B993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684263019; bh=ibkUbwXECOWHvgYrHiViIEJkr8d0p+v+RXwTy/K0kv4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qABC7JX+cRblLRFIknPK+kmPtplswE3kcNgZg+GdRAKJ4YBpWKbsFhwgoirAPh4oH
         KVGyOoi0Cp2sTe/jymlWhG2fPXNMs60M+HuMKxYRaWG1TSsVBgQpajP5sCqpDIn8Ez
         1Erf9E6GqzuUllJdW0JGv3Ys+/CZK4+i4eVpTpBA9dhgr83ERCtlAVfD4ugzYIK4n/
         FiqWWEaCKVA44ryesHEXVVeQ5Aw9CLeAnppU55zecBUn1TR583i1GLUlHWrl2Vm+U2
         biqwks9vcrtiMkW/9dyBzJ/NQe4elNsaI5IkVC4bE+rc4obY46fCdN6jpnCiwnGz1D
         Es4k9DLrM8HaQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
        Peng Tao <bergwolf@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation/filesystems: sharedsubtree: add section
 headings
In-Reply-To: <20230508055938.6550-1-rdunlap@infradead.org>
References: <20230508055938.6550-1-rdunlap@infradead.org>
Date:   Tue, 16 May 2023 12:50:18 -0600
Message-ID: <87mt24az6d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Several of the sections are missing underlines. This makes the
> generated contents have missing entries, so add the underlines.
>
> Fixes: 16c01b20ae05 ("doc/filesystems: more mount cleanups")
> Fixes: 9cfcceea8f7e ("[PATCH] Complete description of shared subtrees.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Ram Pai <linuxram@us.ibm.com>
> Cc: Peng Tao <bergwolf@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Documentation/filesystems/sharedsubtree.rst |    4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

jon
