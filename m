Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B498812E730
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 15:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgABOTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 09:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgABOTS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:19:18 -0500
Received: from localhost (unknown [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B840520848;
        Thu,  2 Jan 2020 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577974758;
        bh=azw6s+4YpK/zg0zwfD1zIRd9wypiLG8FH6IqHaoMSdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7A4dqgONgna/uhxg1dWe7oStJT/A7WggEj56SZbprqOf5F1CTit165Ag6P+oZiNx
         E4gFXxnyMejVLppWzuIZ1eonVB7NjZFbPkCTmxisMVkCi5e4V20TLgmtaOVQmmgYCC
         st7q6gqK0zbcW17JMAGzqeFMYdtbDEmoin7tv6mM=
Date:   Thu, 2 Jan 2020 15:19:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        valdis.kletnieks@vt.edu, hch@lst.de, sj1557.seo@samsung.com
Subject: Re: [PATCH v9 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Message-ID: <20200102141910.GA4020603@kroah.com>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082408epcas1p194621a6aa6729011703f0c5a076a7396@epcas1p1.samsung.com>
 <20200102082036.29643-13-namjae.jeon@samsung.com>
 <20200102125830.z2uz673dlsdttjvo@pali>
 <CAKYAXd9Y6o+a7q_yismLP8nNXOUqrudC3KW8N6Z05OghYLt1jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9Y6o+a7q_yismLP8nNXOUqrudC3KW8N6Z05OghYLt1jg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 02, 2020 at 10:07:16PM +0900, Namjae Jeon wrote:
> >> index 98be354fdb61..2c7ea7e0a95b 100644
> >> --- a/fs/Makefile
> >> +++ b/fs/Makefile
> >> @@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
> >>  obj-$(CONFIG_CODA_FS)		+= coda/
> >>  obj-$(CONFIG_MINIX_FS)		+= minix/
> >>  obj-$(CONFIG_FAT_FS)		+= fat/
> >> +obj-$(CONFIG_EXFAT)		+= exfat/
> >>  obj-$(CONFIG_BFS_FS)		+= bfs/
> >>  obj-$(CONFIG_ISO9660_FS)	+= isofs/
> >>  obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
> >
> > Seems that all filesystems have _FS suffix in their config names. So
> > should not have exfat config also same convention? CONFIG_EXFAT_FS?
> Yeah, I know, However, That name conflicts with staging/exfat.
> So I subtracted _FS suffix.

If it's a problem, please send me a patch to rename the staging/exfat/
config option so that you can use the "real" one someday soon.

thanks,

greg k-h
