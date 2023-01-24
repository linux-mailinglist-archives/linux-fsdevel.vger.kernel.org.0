Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D68C679E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjAXQV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjAXQV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:21:56 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7364A1EB;
        Tue, 24 Jan 2023 08:21:53 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C4B09FFC;
        Tue, 24 Jan 2023 16:21:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C4B09FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674577313; bh=e9Ms9NIy69DBSpc92O0jPbndqt+BbCrpQpQKJy7enug=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WPbLObmI5eAb0UsjPjiNUr79jLBFhGBDmCGswQ79irtiddDZD2UhaHwuf8wU5gtfI
         2jAAKuH+RBriYMbp7LixiK6L7pNeOUSxZFezSVb/0m50PA3orzwhQC4NuRPNqwGCwB
         XDrYpBoLrZhu/1rM+RSTjEWiP7ym60bfW/4Vo1Lg/rKXyJovUrqZu7VNX82OlQTAZC
         ZyjzajqT1YDtnHxcrXFSGDlm8v77Ug8RcmouOhagCzpz0AYS92XrGo6W7CfyimkdKa
         Jf1qzBf10+bNkiATeHsiLRqWoz2H91c1xuBWPntnymecG7+43dW6zNirv1E1MWCaQ7
         YZ0dyfisBnmwQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v1 10/20] docs: document general_profit sysfs
 knob
In-Reply-To: <Y89Zko/TWYcphmJA@debian.me>
References: <20230123173748.1734238-1-shr@devkernel.io>
 <20230123173748.1734238-11-shr@devkernel.io> <Y89Zko/TWYcphmJA@debian.me>
Date:   Tue, 24 Jan 2023 09:21:51 -0700
Message-ID: <87h6wfhpi8.fsf@meer.lwn.net>
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

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Seems like the wording is confusing me, so I write the improv:
>
> ---- >8 ----
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> index 7768e90f7a8fef..5309a912ab679b 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> @@ -56,6 +56,6 @@ What:		/sys/kernel/mm/ksm/general_profit
>  Date:		January 2023
>  KernelVersion:  6.1
>  Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> -Description:	Measure how effective KSM is.
> -		general_profit: how effective is KSM. The formula for the
> -		calculation is in Documentation/admin-guide/mm/ksm.rst.
> +Description:	Measure the KSM profit. See
> +		:ref:`KSM documentation <monitoring-ksm-profit>` for details
> +		on the calculated formula.

So the original at least attempted to tell us what "KSM profit" is; the
"improved" version makes no such effort.  I don't think that is actually
better.

jon
