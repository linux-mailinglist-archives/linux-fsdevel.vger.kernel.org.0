Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8047C8DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 22:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhLUVqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 16:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUVqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:46:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C027C061574;
        Tue, 21 Dec 2021 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wmyG4GcRJFalrXkbb0B8y6T9Oyn5h7Nc/yyRPx5vccY=; b=tElqbK4j3a5iiMxWZewRz8qZM/
        q8xc04yS2FXDm5sSTnd7XZ73fqt1dwR5JB2Fh4F3jIx8oF3uVesnj4kc/ZotAKsr8VM/IFZKqlJ3O
        6lvRYKyVMWon/J7I6L0+ptTuK5KQH5fWOmHIAQ24u5XdW6fvWYIGsqTylXZ7WRMHp4jMGdFJLfWPs
        1ru6WlqiKFSsk1N3YcX+1E7kwtHU8Eanlvl4kpye5ylly1zJoUYvSYe1w/mKfvk5w+ae3nZyNNg3p
        eG0i3JESWJAz6xB4wAPglixjN+izpgGydUMUPDVCNznfqZjXoygOGmEQkF5E3wIddgPPeO7E6Wm6X
        cEIa3YYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzmxJ-008ZU6-Lw; Tue, 21 Dec 2021 21:45:57 +0000
Date:   Tue, 21 Dec 2021 13:45:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH][next] kernel/sysctl.c: remove unused variable
 ten_thousand
Message-ID: <YcJLFQh9IA2XzXu3@bombadil.infradead.org>
References: <20211221184501.574670-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221184501.574670-1-colin.i.king@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 06:45:01PM +0000, Colin Ian King wrote:
> The const variable ten_thousand is not used, it is redundant and can
> be removed.
> 
> Cleans up clang warning:
> kernel/sysctl.c:99:18: warning: unused variable 'ten_thousand' [-Wunused-const-variable]
> static const int ten_thousand = 10000;
> 
> Fixes: c26da54dc8ca ("printk: move printk sysctl to printk/sysctl.c")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Andrew Morton <akpm@linux-foundation.org>

  Luis
