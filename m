Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0656B9F26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 19:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjCNSx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjCNSx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:53:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B89EF47;
        Tue, 14 Mar 2023 11:53:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ED85A7F9;
        Tue, 14 Mar 2023 18:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ED85A7F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678820001; bh=+lUML7AGokBrjmE+zN0xiWF+xgkeixecRJJs+Y23my8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PdGRKgtGSTk4kdt1PvCQDHySTlY6Extsy2W6BsJ8f74JoESYktyqLfu8j8OkVJBx5
         jdmFLXQ6sduK8orAeUBFjdxwgDiG/CeG5O7AHZAjHqrMAhWmqGtiuHPZU9VIAaG1Yv
         PWg7CGn8yIdF3S6NTagxSnujaY/pDSiLSbZMdjjVkP8OqOo3X3tnQrB1/MrWGbluX7
         NnLM3I7wzPb+r/yMR/fjoFaXYxTScF5cvWaOU3ResG0K94Swz5rmsR9rNlQ7rJ0sor
         OE5J4Co3tEPN61WL+cTGI6LSzLNkeaNod4jiNcwzDLBcC5eOvjEfwuj7K2OeuLBQMI
         FdEXyAES9dIxg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Anders Larsen <al@alarsen.net>, linux-doc@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 0/2] Minor documentation clean-up in fs
In-Reply-To: <20230220170210.15677-1-lukas.bulwahn@gmail.com>
References: <20230220170210.15677-1-lukas.bulwahn@gmail.com>
Date:   Tue, 14 Mar 2023 12:53:20 -0600
Message-ID: <87sfe7qi5b.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Dear Jonathan,
>
> please pick this minor documentation clean-up in fs. It is not in the
> Documentation directory, but I would consider these README files also
> some unsorted largely distributed kernel documentation.
>
> Here is some trivial and probably little-to-debate clean up.
>  
> Lukas Bulwahn (2):
>   qnx6: credit contributor and mark filesystem orphan
>   qnx4: credit contributors in CREDITS
>
>  CREDITS        | 16 ++++++++++++++++
>  MAINTAINERS    |  6 ++++++
>  fs/qnx4/README |  9 ---------
>  fs/qnx6/README |  8 --------
>  4 files changed, 22 insertions(+), 17 deletions(-)
>  delete mode 100644 fs/qnx4/README
>  delete mode 100644 fs/qnx6/README

Applied, thanks.

jon
