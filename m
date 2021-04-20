Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F73654E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhDTJKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 05:10:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:36818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhDTJKg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:10:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618909804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yjmwGXL95hrOTOiLoePNgjzr/aVIaC4rCsRgjXD+Ih4=;
        b=rQ4aiKfXozvbbX71hOvvbdh7Ca0q/3X063CDyFWMK+pX/uTOoCfeJ1dw6CL3KPUaYJJDBc
        xqg1B2H+sdQpK7GMFOqEDDuQWY3xyMmL+J/cjxDv9doDSJJbPAEuDgtxfXdJQ2Yf7BltJa
        R5NG9pJ01TsoDmtQyJJsZG3VQ7WBR8I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 876CAAEE6;
        Tue, 20 Apr 2021 09:10:04 +0000 (UTC)
Date:   Tue, 20 Apr 2021 11:10:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] docs: proc.rst: meminfo: briefly describe gaps in memory
 accounting
Message-ID: <YH6aa8WJotXh8F+b@dhcp22.suse.cz>
References: <20210420085105.1156640-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420085105.1156640-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-04-21 11:51:05, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>

Some trivial changelog would be better than nothing.

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

But I do agree that this is a useful information to have in the
documentation. Having networking counters as an example is helpful as
well. I am not familiar with those myself much and I do remember there
is much to it than just sockstat. It would be great to consult this with
some networking expert and extend the documentation for that case which
tends to be quite common AFAIK.

Anyway this is already an improvement and a step into the right
direction.

Acked-by: Michal Hocko <mhocko@suse.com>

one nit below
> ---
>  Documentation/filesystems/proc.rst | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 48fbfc336ebf..bf245151645b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -929,8 +929,15 @@ meminfo
>  ~~~~~~~
>  
>  Provides information about distribution and utilization of memory.  This
> -varies by architecture and compile options.  The following is from a
> -16GB PIII, which has highmem enabled.  You may not have all of these fields.
> +varies by architecture and compile options. Please note that is may happen

that it may happen

> +that the memory accounted here does not add up to the overall memory usage
> +and the difference for some workloads can be substantial. In many cases
> +there are other means to find out additional memory using subsystem
> +specific interfaces, for instance /proc/net/sockstat for networking
> +buffers.
> +
> +The following is from a 16GB PIII, which has highmem enabled.
> +You may not have all of these fields.
>  
>  ::
>  
> -- 
> 2.29.2

-- 
Michal Hocko
SUSE Labs
