Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5E2174DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgGGROP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGGROP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:14:15 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C173206F6;
        Tue,  7 Jul 2020 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594142055;
        bh=iK55vtVxUr8fQsUNFL2mhLYhthVXTFjjC+DeRhc38jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zcQ8BDd9wJbSqIVVsZmGD3K6CXApHOCoLw0inkEEsIR8iQXaYYFTIBUS9AvQJWoGn
         BJZO73UVZTI7YFkGNYbrCChP8ah/wmj4P91Z4sr9NLHASNur1GBo9B/UlBDoSJnFq6
         qTSsJq/EMpyOL/3yvhhEgzHUtlYt2MNJHXeWtoLA=
Date:   Tue, 7 Jul 2020 10:14:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: Re: [PATCH 0/6] fs/minix: fix syzbot bugs and set s_maxbytes
Message-ID: <20200707171400.GA3372845@gmail.com>
References: <20200628060846.682158-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628060846.682158-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 27, 2020 at 11:08:39PM -0700, Eric Biggers wrote:
> This series fixes all syzbot bugs in the minix filesystem:
> 
> 	KASAN: null-ptr-deref Write in get_block
> 	KASAN: use-after-free Write in get_block
> 	KASAN: use-after-free Read in get_block
> 	WARNING in inc_nlink
> 	KMSAN: uninit-value in get_block
> 	WARNING in drop_nlink
> 
> It also fixes the minix filesystem to set s_maxbytes correctly, so that
> userspace sees the correct behavior when exceeding the max file size.
> 
> Al or Andrew: one of you will need to take these patches, since no one
> is maintaining this filesystem.
> 

Andrew, any interest in taking these patches?

- Eric
