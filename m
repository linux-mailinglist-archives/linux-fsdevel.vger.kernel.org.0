Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC0513E7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbiD1WYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiD1WYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:24:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2F875629
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 15:21:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E8E0A1F45D4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651184486;
        bh=hBkBUZw10IVGmAaKtNrSKt10877miolj4UFIptIcPrQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iyJH9N4d2v0HYJANbwFUxEgR42iN+WEWvl0MUHw9wty35uXo20KMly2yww8bmZ5F3
         nnLSVf0GjyQSTet/kBHOhXfbd5h8Sfbbn3ymW5+ivrPut6X2y46NCSKUzhdQ3FucBV
         ZqhrLRwoDYErqwDZI+wyEAkgu02lA/LFwjw/JNlYwD3VXEf3B6buOX9uXjTOYUlidq
         MjM05WORT/7L507BdlBuDsn4UUyfg9IjrRumg85j9lw9g2KT8E58nVQPc+19CmVSkN
         /wlzkPWDRN8HEzvdd5LA+HUW2VSn3YSDHy07l4Na74EThNlN1K/bmz4laa7kGdPW5H
         8ZAowhG7KLsZg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jianchunfu <jianchunfu@cmss.chinamobile.com>
Cc:     ebiggers@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] unicode: Handle memory allocation failures in mkutf8data
Organization: Collabora
References: <20220329024954.12721-1-jianchunfu@cmss.chinamobile.com>
Date:   Thu, 28 Apr 2022 18:21:22 -0400
In-Reply-To: <20220329024954.12721-1-jianchunfu@cmss.chinamobile.com>
        (jianchunfu@cmss.chinamobile.com's message of "Tue, 29 Mar 2022
        10:49:54 +0800")
Message-ID: <87mtg4g87x.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

jianchunfu <jianchunfu@cmss.chinamobile.com> writes:

> Adding and using a helper function "xmalloc()"
> to handle memory allocation failures.
>
> Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>

Thanks, applied.

-- 
Gabriel Krisman Bertazi
