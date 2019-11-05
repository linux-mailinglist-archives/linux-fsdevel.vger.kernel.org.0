Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BF4F03A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 18:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbfKERAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 12:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389049AbfKERAM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:00:12 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92A7C21A4A;
        Tue,  5 Nov 2019 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572973211;
        bh=ySTh/ddwcV7Yu8diiAhu8ffjs6liaxuv0VeqfTyLj30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzzgyKWZiBurYpBbE5qPNntnlPl9ZgGUjLUUO4eCKT5ac5Pyn55ohh55y4cKpzDsg
         j+wb+Lx1LkpFxj6Hznoa9SklXD/2dIz4tBJnVipVs9Ucw2HQZjj81AiHZXSsjP6L6/
         OJGTUMQ6V8AKjZT2Pisj1/zuSTQJ57gZOXBPsdKE=
Date:   Tue, 5 Nov 2019 17:59:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] staging: exfat: Clean up return codes, revisited
Message-ID: <20191105165959.GA2776207@kroah.com>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 03, 2019 at 08:44:56PM -0500, Valdis Kletnieks wrote:
> The rest of the conversion from internal error numbers to the
> standard values used in the rest of the kernel.
> 
> Patch 10/10 is logically separate, merging multiple #defines
> into one place in errno.h.  It's included in the series because
> it depends on patch 1/10.
> 
> Valdis Kletnieks (10):
>   staging: exfat: Clean up return codes - FFS_FORMATERR
>   staging: exfat: Clean up return codes - FFS_MEDIAERR
>   staging: exfat: Clean up return codes - FFS_EOF
>   staging: exfat: Clean up return codes - FFS_INVALIDFID
>   staging: exfat: Clean up return codes - FFS_ERROR
>   staging: exfat: Clean up return codes - remove unused codes
>   staging: exfat: Clean up return codes - FFS_SUCCESS
>   staging: exfat: Collapse redundant return code translations
>   staging: exfat: Correct return code
>   errno.h: Provide EFSCORRUPTED for everybody

You forgot to say what changed from v1?

