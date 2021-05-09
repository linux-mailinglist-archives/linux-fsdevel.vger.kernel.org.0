Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0837793A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 01:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhEIXYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 19:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhEIXYM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 19:24:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F89C6023B;
        Sun,  9 May 2021 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620602587;
        bh=CfjKsIrytuHmGpmMj//X8Y1I82To/YX9YWa7bjqli7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qwmkjQBT6/O7SIfJlgZIb7v9f9jzUrEmQn3+j6Z3LRhWYGSWxqnRDgHGRwBEx5xOJ
         1QHB9xJWfwnUDX4KkAqh4NF/MTsyjcFzi7XMU5m3NSuc2JmsW8sFeHV5hCZtw/YQvy
         jVqu5inp/CHgUfQ0xGT8X1Kk9uit1+t0mpkTKAUw=
Date:   Sun, 9 May 2021 16:23:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     ocfs2-devel@oss.oracle.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Ocfs2-devel] [PATCH 1/3] fs/buffer.c: add new api to allow eof
 writeback
Message-Id: <20210509162306.9de66b1656f04994f3cb5730@linux-foundation.org>
In-Reply-To: <20210426220552.45413-1-junxiao.bi@oracle.com>
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 26 Apr 2021 15:05:50 -0700 Junxiao Bi <junxiao.bi@oracle.com> wrote:

> When doing truncate/fallocate for some filesytem like ocfs2, it
> will zero some pages that are out of inode size and then later
> update the inode size, so it needs this api to writeback eof
> pages.

Seems reasonable.  But can we please update the
__block_write_full_page_eof() comment?  It now uses the wrong function
name and doesn't document the new `eof' argument.

