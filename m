Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C4B21ED71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgGNJ5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 05:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgGNJ5y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:57:54 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E32A217A0;
        Tue, 14 Jul 2020 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594720673;
        bh=PAdSfbpBmRbnMU7A1O6minsmu+lDf1hpmAeeDkxsRe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yr3zUo1xo2rmMBSgx36SZwFNh0PY9LWMpZy8/P6Z/DBfWIb6+hFvOlumI9g4BVP9E
         2wIfjx1byumJZBteu20wcVX7/LT+rbHiHSfXE9jOsK43CJGPxGRGElxy+7ci845Mcn
         sCge/TQ7iPAtBCpeOxOIGU9W7mrLQTVATlyxayhg=
Date:   Tue, 14 Jul 2020 12:57:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     adobriyan@gmail.com, corbet@lwn.net, mchehab+huawei@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: filesystems: proc: Fix literal blocks
Message-ID: <20200714095747.GB1181712@kernel.org>
References: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
 <20200714090644.13011-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714090644.13011-2-chris.packham@alliedtelesis.co.nz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:06:44PM +1200, Chris Packham wrote:
> Sphinx complains
> 
>   Documentation/filesystems/proc.rst:2194: WARNING: Inconsistent literal block quoting.
> 
> Update the command line snippets to be properly formed literal blocks.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/filesystems/proc.rst | 38 +++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 53a0230a08e2..6027dc94755f 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2190,25 +2190,27 @@ mountpoints within the same namespace.
>  
>  ::
>  
> -# grep ^proc /proc/mounts
> -proc /proc proc rw,relatime,hidepid=2 0 0
> + # grep ^proc /proc/mounts
> + proc /proc proc rw,relatime,hidepid=2 0 0
>  
> -# strace -e mount mount -o hidepid=1 -t proc proc /tmp/proc
> -mount("proc", "/tmp/proc", "proc", 0, "hidepid=1") = 0
> -+++ exited with 0 +++
> + # strace -e mount mount -o hidepid=1 -t proc proc /tmp/proc
> + mount("proc", "/tmp/proc", "proc", 0, "hidepid=1") = 0
> + +++ exited with 0 +++
>  
> -# grep ^proc /proc/mounts
> -proc /proc proc rw,relatime,hidepid=2 0 0
> -proc /tmp/proc proc rw,relatime,hidepid=2 0 0
> + # grep ^proc /proc/mounts
> + proc /proc proc rw,relatime,hidepid=2 0 0
> + proc /tmp/proc proc rw,relatime,hidepid=2 0 0
>  
>  and only after remounting procfs mount options will change at all
>  mountpoints.
>  
> -# mount -o remount,hidepid=1 -t proc proc /tmp/proc
> +::
> +
> + # mount -o remount,hidepid=1 -t proc proc /tmp/proc
>  
> -# grep ^proc /proc/mounts
> -proc /proc proc rw,relatime,hidepid=1 0 0
> -proc /tmp/proc proc rw,relatime,hidepid=1 0 0
> + # grep ^proc /proc/mounts
> + proc /proc proc rw,relatime,hidepid=1 0 0
> + proc /tmp/proc proc rw,relatime,hidepid=1 0 0
>  
>  This behavior is different from the behavior of other filesystems.
>  
> @@ -2217,8 +2219,10 @@ creates a new procfs instance. Mount options affect own procfs instance.
>  It means that it became possible to have several procfs instances
>  displaying tasks with different filtering options in one pid namespace.
>  
> -# mount -o hidepid=invisible -t proc proc /proc
> -# mount -o hidepid=noaccess -t proc proc /tmp/proc
> -# grep ^proc /proc/mounts
> -proc /proc proc rw,relatime,hidepid=invisible 0 0
> -proc /tmp/proc proc rw,relatime,hidepid=noaccess 0 0
> +::
> +
> + # mount -o hidepid=invisible -t proc proc /proc
> + # mount -o hidepid=noaccess -t proc proc /tmp/proc
> + # grep ^proc /proc/mounts
> + proc /proc proc rw,relatime,hidepid=invisible 0 0
> + proc /tmp/proc proc rw,relatime,hidepid=noaccess 0 0
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
