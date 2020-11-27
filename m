Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B632C7055
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgK1DXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 22:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbgK0Tyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:54:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92272C061A49;
        Fri, 27 Nov 2020 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CdNvnAHSD334gNTR+orllw3aol+LMLlCaAPl3vfTHe8=; b=XiwfXbC7qW4nB7tIflurP3zh4/
        /100L8mFlKXv+5LUy1LZgWSq9wt9dlj/NZOQJRI1waIOIdHaL+X5c12MGaZuEuupvUuVNp7Tp/mhe
        PxHEm/SGjVNrqI8ruTGHzvzh/ospwLhOdEagPkx682E4Dt/Zk3UHqmFBsFBYkK+wHlxzyq28t+JiK
        UTAKeNlkBWFofDJ2qmxx6xgRVNlVHxaQZW78k5XHp7wm8GKevxZ/kdOUc+5oJXbgwP5E3kSH3wWaU
        7oIHx+EeoUz1DvOxaEtcE9otQzhX7wr8wx77uTOsuTanf0ddxpEsYzqS5gIT5pVqlSRdhCi3/+DnH
        1pzU5mqw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kijo3-0006Nb-Uj; Fri, 27 Nov 2020 19:53:23 +0000
Date:   Fri, 27 Nov 2020 19:53:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     trix@redhat.com
Cc:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locks: remove trailing semicolon in macro definition
Message-ID: <20201127195323.GZ4327@casper.infradead.org>
References: <20201127190707.2844580-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127190707.2844580-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 11:07:07AM -0800, trix@redhat.com wrote:
> +++ b/fs/fcntl.c
> @@ -526,7 +526,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
>  	(dst)->l_whence = (src)->l_whence;	\
>  	(dst)->l_start = (src)->l_start;	\
>  	(dst)->l_len = (src)->l_len;		\
> -	(dst)->l_pid = (src)->l_pid;
> +	(dst)->l_pid = (src)->l_pid

This should be wrapped in a do { } while (0).

Look, this warning is clearly great at finding smelly code, but the
fixes being generated to shut up the warning are low quality.
