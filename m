Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB22BBB7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 02:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKUBWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 20:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKUBWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 20:22:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F6C0613CF;
        Fri, 20 Nov 2020 17:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2Tu2WMYWe1xPWgPSzQT5Rh33RGDZGN6dtZ56n2KT/lg=; b=hjdf06Pgn0RzN6ZtxnXQAicAdK
        oZSAL8rMWGk63BQhkn7CLHztm5kRnP4xh9fksxOEX7k3XZdabgvutYvIa2V18gqjhKbXLI0krhq2T
        ca8sJ5nyYgKoW/gEtn1QBsPj7qG2CfreVv26RBpf/kGilsmM51UKe6bUYZ8waE6eHuzA2tspaoeqh
        a1EzXTpV9b6KzGImXBy5raZ+LE+bqtWByFh8H6HO2oMrBJh7QKJIC1bTlG9i3jBrXzN1jGe6XP9QE
        JkYly/EWRvUEC396/2xfSAA1VDT8blUwPBoS6LDIRek7I7XIfDc2dezo9jkL6S2jY+XErAMLUsKsx
        8nyULHiA==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgHc0-00064a-PM; Sat, 21 Nov 2020 01:22:49 +0000
Subject: Re: [PATCH v4] fs/aio.c: Cosmetic
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Joe Perches <joe@perches.com>
Cc:     Alejandro Colomar <colomar.6.4.3@gmail.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201103095015.3911-1-colomar.6.4.3@gmail.com>
 <20201120220647.8026-1-colomar.6.4.3@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cdcef7ab-3f06-1d61-35d5-dc9dd2561b8c@infradead.org>
Date:   Fri, 20 Nov 2020 17:22:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120220647.8026-1-colomar.6.4.3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/20/20 2:06 PM, Alejandro Colomar wrote:
> Changes:
> - Consistently use 'unsigned int', instead of 'unsigned'.
> - Add a blank line after variable declarations.
> - Move variable declarations to the top of functions.
> - Invert logic of 'if's to reduce indentation and simplify function logic.
> 	- Add goto tags when needed.
> 	- Early return when appropriate.
> - Add braces to 'else' if the corresponding 'if' used braces.
> - Replace spaces by tabs
> - Add spaces when appropriate (after comma, around operators, ...).
> - Split multiple assignments.
> - Align function arguments.
> - Fix typos in comments.
> - s/%Lx/%llx/  Standard C uses 'll'.
> - Remove trailing whitespace in comments.
> 
> This patch does not introduce any actual changes in behavior.
> 
> Signed-off-by: Alejandro Colomar <colomar.6.4.3@gmail.com>
> ---
> 
> Hi,
> 
> I rebased the patch on top of the current master,
> to update it after recent changes to aio.c.
> 
> Thanks,
> 
> Alex
> 
>  fs/aio.c | 466 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 243 insertions(+), 223 deletions(-)

Hi,
I reviewed this patch.
I think it looks OK, but I wish that there was a better way to review it.

I'm not asking you to redo the patch, but I think that it would have been easier
to review 2 patches: one that contains trivial changes[1] and one that requires
thinking to review it -- where the trivial changes are not getting in the way
of looking at the non-trivial changes.

[1] the trivial set of changes, taken from your patch description:

> - Consistently use 'unsigned int', instead of 'unsigned'.
> - Add a blank line after variable declarations.
> - Move variable declarations to the top of functions.
> - Add braces to 'else' if the corresponding 'if' used braces.
> - Replace spaces by tabs
> - Add spaces when appropriate (after comma, around operators, ...).
> - Split multiple assignments.
> - Align function arguments.
> - Fix typos in comments.
> - s/%Lx/%llx/  Standard C uses 'll'.
> - Remove trailing whitespace in comments.

OK, that's everything except for this:
> - Invert logic of 'if's to reduce indentation and simplify function logic.
> 	- Add goto tags when needed.
> 	- Early return when appropriate.


thanks.
-- 
~Randy
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

