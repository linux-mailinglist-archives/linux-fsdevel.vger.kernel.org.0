Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D24A616C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 17:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiBAQck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 11:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbiBAQcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:32:36 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A8C061714;
        Tue,  1 Feb 2022 08:32:36 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEw4x-006MKm-Eg; Tue, 01 Feb 2022 16:32:27 +0000
Date:   Tue, 1 Feb 2022 16:32:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v3] seq_file: fix NULL pointer arithmetic warning
Message-ID: <Yflgm3kv1059tIDH@zeniv-ca.linux.org.uk>
References: <Yfgo8p6Vk+h4+YHY@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yfgo8p6Vk+h4+YHY@fedora>
Sender: Al Viro <viro@ftp.linux.org.uk>
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
> ---
> V1 -> V2:
> - Use SEQ_START_TOKEN instead of open-coding it
> - kernfs_seq_start call single_start instead of open-coding it
> V2 -> V3:
> - Remove the EXPORT of the single_start symbol

Applied.
