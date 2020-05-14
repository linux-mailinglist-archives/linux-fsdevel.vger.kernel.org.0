Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189521D251B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENCYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 22:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgENCYM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 22:24:12 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9DB205CB;
        Thu, 14 May 2020 02:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589423051;
        bh=UVerhlpWBnLUUTLMgvH5z644AkRhrk9PQ0XJpWm7g8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=id1EXOEFsd9NC1A7aiFHA4gSUodqeY9yIpipJA6+7ELcRpMpRB/0ELix/ATkp7ZYI
         uj/3MThBJaNdh/tCdE9dQXzNGxGaifQDvK/jm4mvju7sX15Fr+uQHHwhdFMr93qak1
         4meo2CK7yOV361bnxPMBb/8OGWnWGNJZmdtAfK1c=
Date:   Wed, 13 May 2020 19:24:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-Id: <20200513192410.157747af4dee2da5aa0a50b1@linux-foundation.org>
In-Reply-To: <20200512212936.GA450429@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
        <20200512212936.GA450429@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 12 May 2020 17:29:36 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> +		inode_pages_clear(mapping->inode);
> +	else if (populated == 1)
> +		inode_pages_set(mapping->inode);

mapping->host...

I have to assume this version wasn't runtime tested, so I'll drop it.

