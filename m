Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03F9435661
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 01:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJTXUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 19:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTXUt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 19:20:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2820560EFE;
        Wed, 20 Oct 2021 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634771914;
        bh=TWlR7qXBnj3Vsm8mAM/r2TdcOX5UhJFd1hVGZd99xyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3a8pK8kYSmQLGb6ZHur3eUUUg4KO8gqcz7stt2rlKGzA5S8Aq6tWc5pnzpSDFM1m
         LQA1MqBbHVoYgewjAQyrxIU/jGNxx5JfLUOyhz75TnACayJyNfo9MLsQdrbmXrB87p
         iI1bUt/vLXdqSKB8KRjmnVa7D07h7vlcbPV7tedNwTRibOuaIZB/shNklNq/ZlaLL6
         HYtRX4cK7I5VRBddpEXaubQlNX/SAyXrKjj7GSQulzjW8sAKBcvtHtMInZnK+uUYpa
         /sVe78yxxgYyvlrRk4HKvsT9mAJ1W6/P23UOiA098H21yuMrfM00ct3m+X98UE5+xP
         10gBr3gQq30+w==
Date:   Wed, 20 Oct 2021 18:23:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Len Baker <len.baker@gmx.com>, Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Prefer struct_size over open coded arithmetic
Message-ID: <20211020232314.GA1314273@embeddedor>
References: <20210919094539.30589-1-len.baker@gmx.com>
 <6cd35222-cc17-b3f5-dad4-ed540e0df79b@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd35222-cc17-b3f5-dad4-ed540e0df79b@embeddedor.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 07:11:17PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 9/19/21 04:45, Len Baker wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or similar)
> > function arguments due to the risk of them overflowing. This could lead
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> > 
> > So, use the struct_size() helper to do the arithmetic instead of the
> > argument "size + size * count" in the kzalloc() function.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> > 
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I'm taking this in my -next tree.

Thanks, Len.
--
Gustavo
