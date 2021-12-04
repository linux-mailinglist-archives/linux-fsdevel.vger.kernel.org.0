Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431A7468497
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384812AbhLDMAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 07:00:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59064 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhLDMAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:00:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B7B560E73;
        Sat,  4 Dec 2021 11:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BA6C341C2;
        Sat,  4 Dec 2021 11:56:36 +0000 (UTC)
Date:   Sat, 4 Dec 2021 12:56:33 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        James Morris <jamorris@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/inode: avoid unused-variable warning
Message-ID: <20211204115633.2h2xb35xhg352ubn@wittgenstein>
References: <20211203190123.874239-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211203190123.874239-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 03, 2021 at 08:01:01PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Now that 'inodes_stat' is marked 'static', it causes a harmless warning
> whenever it is unused:
> 
> fs/inode.c:73:29: error: 'inodes_stat' defined but not used [-Werror=unused-variable]
>    73 | static struct inodes_stat_t inodes_stat;
> 
> Move it into the #ifdef that guards its only references.
> 
> Fixes: 245314851782 ("fs: move inode sysctls to its own file")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
