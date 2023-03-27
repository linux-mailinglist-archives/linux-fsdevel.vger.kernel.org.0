Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7653D6CA9E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjC0QCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 12:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjC0QCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:02:32 -0400
X-Greylist: delayed 1385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 09:02:03 PDT
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7C949DB
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=AaSiFEt747OYX/FlMBHNQmZ4ArJHr1TpFZs9gh0OC08=; b=NZrj7Gh0E8z3Gow1jhx8jaJAq0
        yWqunMZSpKSSxCaFrmwpwKXnIqffvoAAwg34dh03mjAXB8ur9zbRC/3Fqbnm5daAuXxFjWRjlInPv
        LEeHYbYDs+DzLJADGizhSlvdoL7jt5aRmldzE9NVnBygIa5iM4D6xXCaqxpOYWeqqqCY8m9LDTde/
        7xITS/L50aks4j3FK5OvbXaM6MwloMLO8PrT/hZdOjX1cK+WdYsCvOOpADuMTx+mmon+ZpDzpqvRc
        GZECmq1eMKoq31xoVioeN2Kp43UJb+naFTReGFnbl5YK2RxoezoeAL9SAISopvb2b80tuWclLSHYC
        mEga8txJ5f71PpRwWoGnfb0KXHeV2MBQ6g28hbFg29pWk3+49ptw7QDI/C16sBWRxmYaz/aRVlK3f
        EJqDwyo8hHPRiwF+Wjo0RUoWTQlm8Hw7cwT0VOABHHY5jD1tNz+XYvXL569fk2nKDBFztBx/ZC6em
        aOMsBbw5Qbotzz6/hPtG9H3WBdQI54SNI1miLdBoIIbGXoVy5gXS2VF9Cs3JVmaArXHx72Y7p/V0K
        7sNMVJfgND1FnnrvhVGCzXy9iGGjJeUssuGcO8PZ+9tO/J/MX7vbci/a0PknQfsyj+PMjM57U0TDf
        izwQSBlWob/Zurw88kQkhTM3msh+R+EnDN6Zat+Ds=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@kernel.org>
Cc:     asmadeus@codewreck.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Add new options to Documentation
Date:   Mon, 27 Mar 2023 17:38:41 +0200
Message-ID: <3443961.DhAEVoPbTG@silver>
In-Reply-To: <ZCEIEKC0s/MFReT0@7e9e31583646>
References: <ZCEIEKC0s/MFReT0@7e9e31583646>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday, March 27, 2023 5:05:52 AM CEST Eric Van Hensbergen wrote:
> Need to update the documentation for new mount flags
> and cache modes.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  Documentation/filesystems/9p.rst | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> index 0e800b8f73cc..6d257854a02a 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -78,19 +78,18 @@ Options
>    		offering several exported file systems.
>  
>    cache=mode	specifies a caching policy.  By default, no caches are used.
> -
> -                        none
> -				default no cache policy, metadata and data
> -                                alike are synchronous.
> -			loose
> -				no attempts are made at consistency,
> -                                intended for exclusive, read-only mounts
> -                        fscache
> -				use FS-Cache for a persistent, read-only
> -				cache backend.
> -                        mmap
> -				minimal cache that is only used for read-write
> -                                mmap.  Northing else is cached, like cache=none
> +		Modes are progressive and inclusive.  For example, specifying fscache
> +		will use loose caches, writeback, and readahead.  Due to their
> +		inclusive nature, only one cache mode can be specified per mount.

I would highly recommend to rather specify below for each option "this option
implies writeback, readahead ..." etc., as it is not obvious otherwise which
option would exactly imply what. It is worth those extra few lines IMO to
avoid confusion.

> +
> +			=========	=============================================
> +			none		no cache of file or metadata
> +			readahead	readahead caching of files
> +			writeback	delayed writeback of files
> +			mmap		support mmap operations read/write with cache
> +			loose		meta-data and file cache with no coherency
> +			fscache		use FS-Cache for a persistent cache backend
> +			=========	=============================================
>  
>    debug=n	specifies debug level.  The debug level is a bitmask.
>  
> @@ -137,6 +136,10 @@ Options
>    		This can be used to share devices/named pipes/sockets between
>  		hosts.  This functionality will be expanded in later versions.
>  
> +  directio	bypass page cache on all read/write operations
> +
> +  ignoreqv	ignore qid.version==0 as a marker to ignore cache
> +
>    noxattr	do not offer xattr functions on this mount.
>  
>    access	there are four access modes.
> 




