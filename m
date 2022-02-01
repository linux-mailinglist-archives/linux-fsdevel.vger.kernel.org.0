Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964384A615C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbiBAQaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 11:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiBAQa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:30:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5913C061714;
        Tue,  1 Feb 2022 08:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6qWMva38m5BETEjBXB6GjYEK7Al+xJ8+7XcUp509tRY=; b=TAhLTyuyC+liOj4hdGqtK7Yynq
        TrvpGa5hk0Vxxk1TPxnwSq28u6molarKW44pFRSqt4hezAE2eA1OJC2kuH/0lX5i84CSD5ZUMOMGN
        EyAD7A48j+DzV+hdVbgIbMKAVWJoEJm1lW6lAa45kEwAQKmNaWZ+U1akR0dfmLKqS1bZycR+NneeV
        aS11l5S5n3rtGurkfABCW+PFofosYhyXLT6FNUwO16ExHq22gWrFZNo+rOVSsGASl4rx74QSaa22/
        y0yHfyUfc9YprQLL/GI3rsD2GTjKUluWEZgUseE81VPxRXoWp7hLBpskmWAqo/LHu6/qDRdLWFI3g
        ze5/FFbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEw2x-00Cdb7-Qo; Tue, 01 Feb 2022 16:30:23 +0000
Date:   Tue, 1 Feb 2022 16:30:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v3] seq_file: fix NULL pointer arithmetic warning
Message-ID: <YflgH+uaoMJTlUoK@casper.infradead.org>
References: <Yfgo8p6Vk+h4+YHY@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yfgo8p6Vk+h4+YHY@fedora>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:22:42PM -0300, Maíra Canal wrote:
> Implement conditional logic in order to replace NULL pointer arithmetic.
> 
> The use of NULL pointer arithmetic was pointed out by clang with the
> following warning:
> 
> fs/kernfs/file.c:128:15: warning: performing pointer arithmetic on a
> null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>                 return NULL + !*ppos;
>                        ~~~~ ^
> fs/seq_file.c:559:14: warning: performing pointer arithmetic on a
> null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>         return NULL + (*pos == 0);
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
