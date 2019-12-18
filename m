Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD75123E22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 04:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfLRDu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 22:50:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55368 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfLRDu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:50:57 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihQMR-0002Ac-Gi; Wed, 18 Dec 2019 03:50:55 +0000
Date:   Wed, 18 Dec 2019 03:50:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] vfs: Adjust indentation in remap_verify_area
Message-ID: <20191218035055.GG4203@ZenIV.linux.org.uk>
References: <20191218032351.5920-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218032351.5920-1-natechancellor@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 08:23:51PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> ../fs/read_write.c:1760:3: warning: misleading indentation; statement is
> not part of the previous 'if' [-Wmisleading-indentation]
>          if (unlikely((loff_t) (pos + len) < 0))
>          ^
> ../fs/read_write.c:1757:2: note: previous statement is here
>         if (unlikely(pos < 0 || len < 0))
>         ^
> 1 warning generated.
> 
> This warning occurs because there is a space after the tab on this line.
> Remove it so that the indentation is consistent with the Linux kernel
> coding style and clang no longer warns.
> 
> Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
> Link: https://github.com/ClangBuiltLinux/linux/issues/828
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Egads...  This commit message is way, way over the top.

1) the warning is more obscure than the problem it points to.

2) simple "statement accidentally indented one column too deep"
would do just fine

3) crediting the tool is generally a good idea, but in situation
when the quality of warning is that low you'd be better paraphrasing
it and mentioning the tool that has pointed it out.  No need to quote
the verbiage.
