Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD628DC51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgJNJEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgJNJEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:04:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E2CC04585A;
        Tue, 13 Oct 2020 22:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=IdhOyX8mp5fGGELCgVGNcDwrDWcw+hOZR/T72lwdWPo=; b=SvpO3gra0mcEhMWNzaL4cZoMQI
        R4dtbDEwwaRdy9rLKaCRf4V7yd2uWut8Qo4h2FiDO5A28PHNKw3oHtE5Aa1xO3/rPtZVcCmEKk7Z/
        HWFq2AiIQjf8ebXjFZvwE6GhWCxtMZS2Ysuze7xreUut9O5T4ls20qVO1nd6z1B8x7nvtb0v5A16g
        wN+j4Cpe3xWGRdhppKxTbEpqhM7mvKR7eY2dyPhDiRWU3o9Tp62JboZv/W/W5kJTR2bHtTrBFcxCZ
        O72YCcmODgaQf4AxjigWKdiLCZeCBkxYXsAHKlB57fRVlt4oJnegO5Ow8rfCRZdsbHMRa6RwBkP2C
        Y1c2xF0Q==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSZJt-0008BZ-LA; Wed, 14 Oct 2020 05:27:25 +0000
Subject: Re: [PATCH] procfs: delete duplicated words + other fixes
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
References: <20200805024915.12231-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e01420e-397b-4abf-c31d-fd103cb690de@infradead.org>
Date:   Tue, 13 Oct 2020 22:27:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200805024915.12231-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping.

On 8/4/20 7:49 PM, Randy Dunlap wrote:
> Delete repeated words in fs/proc/.
> {the, which}
> where "which which" was changed to "with which".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> To: linux-fsdevel@vger.kernel.org
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/proc/base.c     |    2 +-
>  fs/proc/proc_net.c |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20200804.orig/fs/proc/base.c
> +++ linux-next-20200804/fs/proc/base.c
> @@ -2016,7 +2016,7 @@ const struct dentry_operations pid_dentr
>   * file type from dcache entry.
>   *
>   * Since all of the proc inode numbers are dynamically generated, the inode
> - * numbers do not exist until the inode is cache.  This means creating the
> + * numbers do not exist until the inode is cache.  This means creating
>   * the dcache entry in readdir is necessary to keep the inode numbers
>   * reported by readdir in sync with the inode numbers reported
>   * by stat.
> --- linux-next-20200804.orig/fs/proc/proc_net.c
> +++ linux-next-20200804/fs/proc/proc_net.c
> @@ -140,7 +140,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_data);
>   * @mode: The file's access mode.
>   * @parent: The parent directory in which to create.
>   * @ops: The seq_file ops with which to read the file.
> - * @write: The write method which which to 'modify' the file.
> + * @write: The write method with which to 'modify' the file.
>   * @data: Data for retrieval by PDE_DATA().
>   *
>   * Create a network namespaced proc file in the @parent directory with the
> @@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_single
>   * @mode: The file's access mode.
>   * @parent: The parent directory in which to create.
>   * @show: The seqfile show method with which to read the file.
> - * @write: The write method which which to 'modify' the file.
> + * @write: The write method with which to 'modify' the file.
>   * @data: Data for retrieval by PDE_DATA().
>   *
>   * Create a network-namespaced proc file in the @parent directory with the
> 


-- 
~Randy

