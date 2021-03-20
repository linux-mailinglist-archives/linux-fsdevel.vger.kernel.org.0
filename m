Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23402342FE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 23:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhCTW1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 18:27:36 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:56802 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCTW1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:27:09 -0400
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D43B19EC611;
        Sat, 20 Mar 2021 23:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1616279208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UsXNI5haAYV6BEKBj6L7LHu9P+RpP6CzmUdNITyPG0o=;
        b=sI6BioZLtNV835zQxrGbErLi+I0OXODLYz6UKZCHe4t4NMX2FhUxEesRWp6M5kKu7kG8F1
        aM5SZh79zgODYJna0gAv/BoFU2bUQDjp2jNCGL42DfiFUTYqP02+PlJOjYkNh/SWYZW1DD
        ZIrjsA+NhqIVNea2gi3kbDdk6G3NN7I=
Date:   Sat, 20 Mar 2021 23:26:48 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v24 09/10] fs/ntfs3: Add NTFS3 in fs/Kconfig and
 fs/Makefile
Message-ID: <20210320222648.qgqkqpdxzfejrfbt@spock.localdomain>
References: <20210319185210.1703925-1-almaz.alexandrovich@paragon-software.com>
 <20210319185210.1703925-10-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319185210.1703925-10-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 09:52:09PM +0300, Konstantin Komarov wrote:
> This adds NTFS3 in fs/Kconfig and fs/Makefile
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a55bda4233bb..f61330e4efc0 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -145,6 +145,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
>  source "fs/fat/Kconfig"
>  source "fs/exfat/Kconfig"
>  source "fs/ntfs/Kconfig"
> +source "fs/ntfs3/Kconfig"
>  
>  endmenu
>  endif # BLOCK
> -- 
> 2.25.4
> 

It seems fs/Makefile modification has been dropped from this patch for
some reason. Mistake?

-- 
  Oleksandr Natalenko (post-factum)
