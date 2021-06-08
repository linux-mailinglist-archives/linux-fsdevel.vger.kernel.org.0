Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7724939EA87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 02:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFHAEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 20:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhFHAEb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:04:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E16260200;
        Tue,  8 Jun 2021 00:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623110548;
        bh=7v9F9tZ4VsJWJXm6G7kmNYKKSpWS4x2hM8W5w21E+2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O0+Qep8Gz/4M7ZHLIGGTUu2af7NI3iJmT2OM8OZdPCdieE4pVg4qcuGjWYMlkq5Uu
         zIo8RKWb/VZH3nu9es94FG5ghpC+ozjF67+sTFHpiYUhX3ZpZADGLLaUX+3kgeuiAK
         rbd3ireZDInyvc689ST9o07zpndvUXSxcYeonxeU=
Date:   Mon, 7 Jun 2021 17:02:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     <naoya.horiguchi@nec.com>, <jack@suse.cz>, <tytso@mit.edu>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <yukuai3@huawei.com>
Subject: Re: [PATCH v2] mm/memory-failure: make sure wait for page writeback
 in memory_failure
Message-Id: <20210607170228.ec4c390ac592cbb0a6f8dbaf@linux-foundation.org>
In-Reply-To: <20210604084705.3729204-1-yangerkun@huawei.com>
References: <20210604084705.3729204-1-yangerkun@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Jun 2021 16:47:05 +0800 yangerkun <yangerkun@huawei.com> wrote:

> Our syzkaller trigger the "BUG_ON(!list_empty(&inode->i_wb_list))" in
> clear_inode:
> 
> [  292.016156] ------------[ cut here ]------------
> [  292.017144] kernel BUG at fs/inode.c:519!
>
> ...
> 
> Fixes: 0bc1f8b0682c ("hwpoison: fix the handling path of the victimized page frame that belong to non-LRU")

Merged in 2014.

> Signed-off-by: yangerkun <yangerkun@huawei.com>

So I shall place a cc:stable here.  But why did it take so long to
discover this?

