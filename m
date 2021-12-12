Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D532D4718D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 07:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhLLGKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 01:10:19 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:19140 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhLLGKS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 01:10:18 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4JBZ4Q0SSxz64;
        Sun, 12 Dec 2021 07:10:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1639289416; bh=VuSaSqZcrW41+uEiAuo1l/ttygVpq/wNgVGxyoOZ6fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Se5KLieRBNcATvBBOunx0rHx7HuEfdgOk9WDp7fVx4+6kG3zs28wFtU9k/J4M21SE
         zGcMLgd4EFo5i4VsU2OyUytJnB5P94a2dy7o+rL1f5PqdCY6d1I1l+qVZNYrcYWrnF
         emwF88A1fMLkqFpXhi+rmLgCnUB9GT6Lbk3X/XxfcLyE1I6QUX4ArcKzTP4BR8qAsC
         Z/viU6GxVCXZkj3WtqkWtv3+favkbkgBsXAzkniR9xhKmlcfQVqXMR9dhyt3143syq
         FQxwbfFM9ShuoiBiNVEdno8gl1Xr7tvt5T2BQs9wrkf2d59rFTKXbIXACuxeWnwjN6
         a9cjxE1oiuL9g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Sun, 12 Dec 2021 07:10:11 +0100
From:   Michal Miroslaw <mirq-linux@rere.qmqm.pl>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        keescook@chromium.org, pmladek@suse.com, david@redhat.com,
        arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com,
        alexei.starovoitov@gmail.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH -mm v2 2/3] cn_proc: replaced old hard-coded 16 with
 TASK_COMM_LEN_16
Message-ID: <YbWSQy0pmO9RgRUu@qmqm.qmqm.pl>
References: <20211211063949.49533-1-laoar.shao@gmail.com>
 <20211211063949.49533-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211211063949.49533-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 11, 2021 at 06:39:48AM +0000, Yafang Shao wrote:
> This TASK_COMM_LEN_16 has the same meaning with the macro defined in
> linux/sched.h, but we can't include linux/sched.h in a UAPI header, so
> we should specifically define it in the cn_proc.h.
[...]
> index db210625cee8..6dcccaed383f 100644
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -21,6 +21,8 @@
>  
>  #include <linux/types.h>
>  
> +#define TASK_COMM_LEN_16 16

Hi,

Since this is added to UAPI header, maybe you could make it a single
instance also used elsewhere? Even though this is constant and not
going to change I don't really like multiplying the sources of truth.

Best Regards
Micha³ Miros³aw
