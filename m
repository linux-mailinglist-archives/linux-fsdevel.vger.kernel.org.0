Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2D3E444F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 12:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhHILAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 07:00:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhHILAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:00:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E505B21E7F;
        Mon,  9 Aug 2021 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628506784;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+819Y6QMhTvZXoFwSHV0pNp7MewP22hxJjnmmnW1lo=;
        b=L7iNq+QO8kIx+jtgLE41cT9LClu7YvI3duAku3cSfi2XbLnSP9Mq6IN0gMHqcDHJFUKt4z
        NdpUZLJrbhDPbMvYUziR6TGqxej/USUzLzRRjpbXnAI1LefQ3GQz7WjAWeeUl6cEeCv3BV
        qHQkiKxJCi2OAlHQ0xWizHz9kCzQPUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628506784;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+819Y6QMhTvZXoFwSHV0pNp7MewP22hxJjnmmnW1lo=;
        b=be7gYdlgEviTolWcfsfJdFKIzb9Tns6XSfUJrxWftZ5oEHJ33Gvm4ikYyglqluZyBuObX4
        PzZmXavwV+bJcjAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3355BA3B89;
        Mon,  9 Aug 2021 10:59:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F240DA880; Mon,  9 Aug 2021 12:56:52 +0200 (CEST)
Date:   Mon, 9 Aug 2021 12:56:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
Subject: Re: [PATCH v27 10/10] fs/ntfs3: Add MAINTAINERS
Message-ID: <20210809105652.GK5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-11-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729134943.778917-11-almaz.alexandrovich@paragon-software.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 04:49:43PM +0300, Konstantin Komarov wrote:
> This adds MAINTAINERS
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c3428380..3b6b48537 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13279,6 +13279,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
>  F:	Documentation/filesystems/ntfs.rst
>  F:	fs/ntfs/
>  
> +NTFS3 FILESYSTEM
> +M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> +S:	Supported
> +W:	http://www.paragon-software.com/
> +F:	Documentation/filesystems/ntfs3.rst
> +F:	fs/ntfs3/

Can you please add a git tree and mailing list entries?
