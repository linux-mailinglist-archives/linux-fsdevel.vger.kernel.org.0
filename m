Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253E9605348
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 00:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJSWnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJSWnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:43:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FF7185420;
        Wed, 19 Oct 2022 15:43:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2BDD44BF;
        Wed, 19 Oct 2022 22:43:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2BDD44BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666219383; bh=NPzka3mRycAJLQAxLwA0u3esb+yUvwRUOV68wtp4qls=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l9SgBR6SnA+plJkZqjX2kvPigUpsbQ5enhv1XnjWN8l/oWmfX6tl14ikdv5uN35d3
         eAGmWyhicXoaNvELf+ignnSAat0dfn0bgTKZDICZln+qsCSRncUYwAeH64weHUnY6I
         ZXUAN8bmCn6jTxhzWWQpKVSOjlDVAWkHuS2PCIGfOufTlr6CUAXcCE9mK0jt4q7vKL
         XSzSirYXndMlN0FPfRJbXem4gA6IhfUBbQn4h7DTQB5xPxZx2KDY8fSFQrkg47W9pp
         SJ9vBSwfZCNNUj0Vqw/B+/AgcN23jVIWBMUqvfjgaG5ziD/svOE/MRoCG5bmxt/d1H
         LKPSet8cFhLGA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH v2 0/5] Update the sysctl/fs documentation
In-Reply-To: <20220930102937.135841-1-steve@sk2.org>
References: <20220930102937.135841-1-steve@sk2.org>
Date:   Wed, 19 Oct 2022 16:43:02 -0600
Message-ID: <87tu3zbfk9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Kitt <steve@sk2.org> writes:

> This patch series updates the sysctl/fs in line with similar changes
> made previously to sysctl/kernel and sysctl/abi:
>
> * add an automatically-generated table of contents,
> * order the entries alphabetically,
> * use consistent markup.
>
> In addition, obsolete entries are removed, and the two aio sections
> are merged.
>
> Changes since v2:
> * added a cover letter
> * request review from linux-fsdevel
> * fix the link to core_pattern
>
> Stephen Kitt (5):
>   docs: sysctl/fs: remove references to inode-max
>   docs: sysctl/fs: remove references to dquot-max/-nr
>   docs: sysctl/fs: merge the aio sections
>   docs: sysctl/fs: remove references to super-max/-nr
>   docs: sysctl/fs: re-order, prettify
>
>  Documentation/admin-guide/sysctl/fs.rst     | 240 ++++++++------------
>  Documentation/admin-guide/sysctl/kernel.rst |   2 +
>  2 files changed, 97 insertions(+), 145 deletions(-)

Series applied, thanks.

jon
