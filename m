Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD2438B8A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 20:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhJXSwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 14:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhJXSwA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BABF60E74;
        Sun, 24 Oct 2021 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635101379;
        bh=1kqycnVC8fukz0uELJHiRc1ElEC5mtlD4Z21MQOaCco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkdIJtZqofdqkgfp44isp63Hs/p6GmYy/OVlz2jYbdX9DtNnpEhQ84pk0kfliUfXh
         3lGMnSbuxWiuGr06uhbplT8vnuQpRKpDx8aVYWWr2oghba7ctjVtc4L1g1OPkSJWIP
         teS7nOSmsFLHrz/bLZGySaCh4SkwyytVTiYFJJWhqh1/pIoF4Ma0OY+7ViAUogvUH4
         6qZ12pqSCctLUmEp0uJEOKJg8LwJdTpPgR9av092gP8vfOGnr5GGKVfFrbFRxTKNrh
         PWdqF35Ai6bEufKD2mqjJ6TnJz2XDYfyCOiJaeQJb2WBZAp4zwR/RrkBtleQe/iikN
         4yVfSrJbFQZ/A==
Date:   Sun, 24 Oct 2021 13:54:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] sysctl: Avoid open coded arithmetic in memory
 allocator functions
Message-ID: <20211024185427.GA1420234@embeddedor>
References: <20211023105414.7316-1-len.baker@gmx.com>
 <YXQbxSSw9qan87cm@casper.infradead.org>
 <20211024091328.GA2912@titan>
 <YXWeAdsMRcR5tInN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXWeAdsMRcR5tInN@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 24, 2021 at 06:55:13PM +0100, Matthew Wilcox wrote:
> On Sun, Oct 24, 2021 at 11:13:28AM +0200, Len Baker wrote:
> 
> I think it's better for code to be understandable.  Your patch makes
> the code less readable in the name of "security", which is a poor
> justification.

I agree with Matthew. Those functions seem to be a bit too much, for
now.

Let's keep it simple and start by replacing the open-coded instances
when possible, first. Then we can dig much deeper depending on each
particular case, taking into consideration readability, which is
certainly important.

Thanks
--
Gustavo
