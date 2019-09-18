Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A5B6D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 22:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbfIRUNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 16:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391137AbfIRUNV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:13:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01AB9218AE;
        Wed, 18 Sep 2019 20:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568837600;
        bh=5IEjEBIJqu0oLo761zcOugWSggIlKE+XJQ9ZfLBgxv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TigylZRrNnklqsoSyyPeceE5abQuYuzfUnOF3E4GihLzpw7Ww6wpp7xpQxVxVaTVm
         VSLZFtFKlyal09taeseC5ambv1HZZqHKurSsUI6IRnVkmhl6NS1sSLLnrmYe5PmGFa
         sv0JLfGcOBm2HZOPjV7+XK3K4wmM3lBt6Lz6MHYY=
Date:   Wed, 18 Sep 2019 22:13:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Park Ju Hyung <qkrwngud825@gmail.com>
Cc:     alexander.levin@microsoft.com, namjae.jeon@samsung.com,
        sergey.senozhatsky.work@gmail.com, sergey.senozhatsky@gmail.com,
        sj1557.seo@samsung.com, valdis.kletnieks@vt.edu,
        dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: rebase to sdFAT v2.2.0
Message-ID: <20190918201318.GB2025570@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190918195920.25210-1-qkrwngud825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918195920.25210-1-qkrwngud825@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:59:20AM +0900, Park Ju Hyung wrote:
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0-or-later

You just changed the license of this file.  Are you SURE about that?

I would like to get a signed-off-by from a samsung developer/lawyer to
have on the record for this, otherwise I can't take such a thing.

thanks,

greg k-h
