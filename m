Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5749DA67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 07:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiA0GCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 01:02:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44010 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiA0GCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:02:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16D99B8122D;
        Thu, 27 Jan 2022 06:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9536EC340E4;
        Thu, 27 Jan 2022 06:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643263327;
        bh=18F7TPAyWii7cLJq8O3chhgnB+lzYDieQMqnJvkgd1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qqzt++0S1KfgHJI9jDKXDmWe4kimB0tvA9ruc5+EIxCSJ89bqs3KJdZjbPXDfWUoI
         avRIc54/N68lFGam4zEkxZ03Fn3oJ/6/BTwnBGbQfd7C/oT77z/VEDdGw6tzTfWBFZ
         FAmi4szf/9eFoFJgqtYjfkIPSiAjjyB3sSgvy7Jk=
Date:   Wed, 26 Jan 2022 22:02:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2022-01-26-21-04 uploaded
Message-Id: <20220126220206.2ec57a68c5a803818adbc816@linux-foundation.org>
In-Reply-To: <20220127165110.55e88e44@canb.auug.org.au>
References: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
        <20220127165110.55e88e44@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jan 2022 16:51:10 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> On Wed, 26 Jan 2022 21:04:56 -0800 akpm@linux-foundation.org wrote:
> >
> > * docs-sysctl-kernel-add-missing-bit-to-panic_print.patch
> > * panic-add-option-to-dump-all-cpus-backtraces-in-panic_print.patch
> > * panic-allow-printing-extra-panic-information-on-kdump.patch
> 
> 
> > * sysctl-documentation-fix-table-format-warning.patch
> 
> Just wondering why this patch isn't up just after the above patches
> (instead of being in the post-next section)?

Dependencies are all over the place and are moving around.  Now fixed
up, thanks.

