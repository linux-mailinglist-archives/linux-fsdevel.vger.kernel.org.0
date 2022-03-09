Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1B4D3D88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 00:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiCIX1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 18:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiCIX1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:27:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1177A122F79
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 15:26:18 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E745C2CD;
        Wed,  9 Mar 2022 23:26:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E745C2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646868377; bh=Wrwgt7HXDmvhrJfZQQLH8FOF8me4AXFD7djPQdhzA+Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XS1pBDUp6cGTSINeE/bJ63FCmGnbpEsE8qTlo3N/SNF5OQSQqTXyC2HCHTG34UWdX
         JkIscYV6hN/F3emDII1XHgmGMnayvf7XhcQLRFx4dCEVNfEqPgCwYwiejmUMWc6t7F
         PPcdk4WIB9WLSR7S02WU/62v3YhxBanVT3sxyuguULa0T9zXRwd/C6allnDuul/Tke
         Tcc2V31aNqdgJ2Nsv3GRCSOUetmAUHVJYf5vqNuwop0POOFiP17G5Uyv6DQO0TwZQK
         MNll/Z8anQvuxexOHmhqzstk8gvmAeV4uWPH1wgyMlD+9GwpVWqAEMJxZGTULNyBBv
         TnfJ8cacrDZcQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     YI <afctgo@gmail.com>, trivial@kernel.org
Cc:     YI <afctgo@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Colin Cross <ccross@google.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: proc.rst: fix wrong time unit
In-Reply-To: <20220302161122.3984304-1-uuuuuu@protonmail.com>
References: <20220302161122.3984304-1-uuuuuu@protonmail.com>
Date:   Wed, 09 Mar 2022 16:26:16 -0700
Message-ID: <87r17a7lnr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

YI <afctgo@gmail.com> writes:

> From: YI <afctgo@gmail.com>
>
> Dear Trivial Patch Monkey, 

The trivial patch monkey has gone into retirement, I'm as close as
you're going to get.

> This commit fixes a small documentaion problem reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=194593.
>
> Some fields in the file /proc/$pid/stat represent time.
> Their units are clock_t, not jiffies as stated in the documentation.
> This commit fixes https://bugzilla.kernel.org/show_bug.cgi?id=194593.

We certainly don't need to give the bugzilla URL twice; I'm not
convinced it's needed even once.  The changelog should just say what the
patch does, please.

Also, "clock_t" isn't really a unit type; what are the actual units of
the field?

> Reported-by: hujunjie

This isn't a valid reported-by line

> Signed-off-by: YI <afctgo@gmail.com>

...and the signoff need to have your full name, please.

Thanks,

jon
