Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5FB45EBFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 11:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhKZK6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 05:58:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhKZK4X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:56:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C07B561052;
        Fri, 26 Nov 2021 10:53:09 +0000 (UTC)
Date:   Fri, 26 Nov 2021 11:53:05 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] fs: split off vfs_getdents function of getdents64
 syscall
Message-ID: <20211126105305.pmgmkae6pnxx62me@wittgenstein>
References: <20211123181010.1607630-1-shr@fb.com>
 <20211123181010.1607630-3-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211123181010.1607630-3-shr@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:10:09AM -0800, Stefan Roesch wrote:
> This splits off the vfs_getdents function from the getdents64 system
> call. This allows io_uring to call the function.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
