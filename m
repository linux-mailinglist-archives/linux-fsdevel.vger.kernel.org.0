Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4747B435650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 01:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJTXQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 19:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTXQp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 19:16:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE85610A2;
        Wed, 20 Oct 2021 23:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634771670;
        bh=oi8a3JG/XkmKsI8mfGwa2zI65CTPnyciySVi1vE9Ta8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuiD96fQvwo7N0m8LmOuS8+Hdz9ngko76+qhxxL2fxsJXaxpKzVtaYiPGQsfmlYGj
         gPMeHy1ITuu+kEC5Qi3LLDIF206EN3X7NGynD9mVS+1u3nLjlUuQ5k9IwpjXhSxOB8
         VX0OTArOjQ12nYLnGhUWaCRnXFz/U+udE15+x8J3IbiBvlU9PC8DzeC/Gwn8SE4zfL
         IWxYHkZc/0jbT9uESoX3O9UxsIuA//e50GJJdYUM8Eu/NQeQPyHrSKNlQsZ90hnjOD
         CzJIgA0PlB23s8aVADlchl99MhNmJmenLIJoRjpLftDol6l/OLkgAv7kaHxYJSIgLy
         6EVLMm3gnz3LA==
Date:   Wed, 20 Oct 2021 18:19:10 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Len Baker <len.baker@gmx.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: prefer struct_size over open coded
 arithmetic
Message-ID: <20211020231910.GA1313548@embeddedor>
References: <20210925114308.11455-1-len.baker@gmx.com>
 <20211020144044.GB16460@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020144044.GB16460@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 04:40:44PM +0200, Jan Kara wrote:
[..]
> > This code was detected with the help of Coccinelle and audited and fixed
> > manually.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> > 
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> BTW, writeback patches are usually merged by Andrew Morton so probably send
> it to him. Thanks!

I'm taking this in my -next tree.

Thank you both, Len and Jan.
--
Gustavo
