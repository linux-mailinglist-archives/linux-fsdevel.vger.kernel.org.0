Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04674E605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 06:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjGKEmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 00:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGKEmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:42:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40190;
        Mon, 10 Jul 2023 21:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mPzEscneyvnM3uy7b9LxctE42Boier9y8NyRdeD47b4=; b=oIWebi57kYuAhPxjzqmc2OLJxO
        rBWDmjk4qv//Xb5XtQ6UZw8fttgzCrj/xJttxiSZ32Sh2VKpnYpopxlhIZyXZsqXIw0jeB/6wE9gy
        DJOcHC/yG5+SQkr/xrH3u8+oLUh51b/+S2SzCIas3Gt+I39jZTZqsndwhGpai6NLydbBQJpejcldg
        CE+ACzBPdwHQCP6+Vk2OR0Z+Rzj2WsG8vXdqESZ6rCB6ASygTMjvkFOSgu/X/xQOgcFO/TeaHxJML
        3TPKpZVXUhTUAohY6u9x/grsCxPG/ZE0rMQplH+PKK5b/urwxY/OxBoarymQl77uVHDKQISb7H/TQ
        G4gokrSQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ5Cy-00DehZ-2m;
        Tue, 11 Jul 2023 04:42:40 +0000
Message-ID: <36b37893-c297-dab0-df2d-eeacfa1e06c0@infradead.org>
Date:   Mon, 10 Jul 2023 21:42:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/5] docs: fuse: improve FUSE consistency explanation
Content-Language: en-US
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     me@jcix.top
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
 <20230711043405.66256-6-zhangjiachen.jaycee@bytedance.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230711043405.66256-6-zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 7/10/23 21:34, Jiachen Zhang wrote:
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  Documentation/filesystems/fuse-io.rst | 32 +++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/fuse-io.rst b/Documentation/filesystems/fuse-io.rst
> index 255a368fe534..cdd292dd2e9c 100644
> --- a/Documentation/filesystems/fuse-io.rst
> +++ b/Documentation/filesystems/fuse-io.rst

> @@ -24,7 +31,8 @@ after any writes to the file.  All mmap modes are supported.
>  The cached mode has two sub modes controlling how writes are handled.  The
>  write-through mode is the default and is supported on all kernels.  The
>  writeback-cache mode may be selected by the FUSE_WRITEBACK_CACHE flag in the
> -FUSE_INIT reply.
> +FUSE_INIT reply. In either modes, if the FOPEN_KEEP_CACHE flag is not set in

                       either mode,

> +the FUSE_OPEN, cached pages of the file will be invalidated immediatedly.

                                                               immediately.

>  
>  In write-through mode each write is immediately sent to userspace as one or more
>  WRITE requests, as well as updating any cached pages (and caching previously
> @@ -38,7 +46,27 @@ reclaim on memory pressure) or explicitly (invoked by close(2), fsync(2) and
>  when the last ref to the file is being released on munmap(2)).  This mode
>  assumes that all changes to the filesystem go through the FUSE kernel module
>  (size and atime/ctime/mtime attributes are kept up-to-date by the kernel), so
> -it's generally not suitable for network filesystems.  If a partial page is
> +it's generally not suitable for network filesystems (you can consider the
> +writeback-cache-v2 mode mentioned latter for them).  If a partial page is

                                     later

>  written, then the page needs to be first read from userspace.  This means, that
>  even for files opened for O_WRONLY it is possible that READ requests will be
>  generated by the kernel.


-- 
~Randy
