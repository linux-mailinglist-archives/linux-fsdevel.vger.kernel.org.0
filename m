Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64912286DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 19:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgGURMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGURMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:12:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B71C061794;
        Tue, 21 Jul 2020 10:12:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxvoM-00HKHa-M2; Tue, 21 Jul 2020 17:12:14 +0000
Date:   Tue, 21 Jul 2020 18:12:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 13/24] init: add an init_unlink helper
Message-ID: <20200721171214.GY2786714@ZenIV.linux.org.uk>
References: <20200721162818.197315-1-hch@lst.de>
 <20200721162818.197315-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721162818.197315-14-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 06:28:07PM +0200, Christoph Hellwig wrote:
> diff --git a/init/fs.c b/init/fs.c
> index 73423f5461f934..1bdb5dc5ec12ba 100644
> --- a/init/fs.c
> +++ b/init/fs.c
> @@ -3,6 +3,7 @@
>  #include <linux/mount.h>
>  #include <linux/namei.h>
>  #include <linux/fs.h>
> +#include <../fs/internal.h>

... and that is why the damn thing would be better off in fs/
