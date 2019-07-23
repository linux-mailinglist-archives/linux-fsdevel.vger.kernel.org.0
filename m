Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316A57207C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 22:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfGWUHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 16:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbfGWUHb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:07:31 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D4F32084D;
        Tue, 23 Jul 2019 20:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912450;
        bh=aJAwIMG/PcNFQKUZTnI3xqTnmOSc6qBWaaEdBvulUpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VX9USo4Gy2dVgkf+TNz6HITq9P3GchWQKOUSzY/le0qD3BWAE3Fbfj7zdKjsmUOzb
         Dd1tT7mXRLQHqbUBmsJ2jqrXD2UEQHY2yKfHn0GeQXCYvKA/9zMzwnYY5F7fXbovHX
         FImaoH6ldCnadpDFM15AqXu4eNYu4RKODmNdv8DM=
Date:   Tue, 23 Jul 2019 13:07:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm/backing-dev: show state of all bdi_writeback in
 debugfs
Message-Id: <20190723130729.522976a1f075d748fc946ff6@linux-foundation.org>
In-Reply-To: <156388617236.3608.2194886130557491278.stgit@buzz>
References: <156388617236.3608.2194886130557491278.stgit@buzz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Jul 2019 15:49:32 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> Currently /sys/kernel/debug/bdi/$maj:$min/stats shows only root bdi wb.
> With CONFIG_CGROUP_WRITEBACK=y there is one for each memory cgroup.
> 
> This patch shows here state of each bdi_writeback in form:
> 
> <global state>
> 
> Id: 1
> Cgroup: /
> <root wb state>
> 
> Id: xxx
> Cgroup: /path
> <cgroup wb state>
> 
> Id: yyy
> Cgroup: /path2
> <cgroup wb state>

Why is this considered useful?  What are the use cases.  ie, why should
we add this to Linux?

> mm/backing-dev.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 93 insertions(+), 13 deletions(-)

No documentation because it's debugfs, right?

I'm struggling to understand why this is a good thing :(.  If it's
there and people use it then we should document it for them.  If it's
there and people don't use it then we should delete the code.

