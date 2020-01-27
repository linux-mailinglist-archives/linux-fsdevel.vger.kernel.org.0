Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4F014A0E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 10:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgA0Jdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 04:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbgA0Jdb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:33:31 -0500
Received: from localhost (unknown [84.241.194.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53602071E;
        Mon, 27 Jan 2020 09:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580117611;
        bh=Ef9oXJraHrZcKRv51kyBrh6GiZS62kKnN8mPno2E3vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rN7Px3OMO+IPDGSNQ0oOUJHHtSsQVk8+4YQKqKsKRm1XGoyYM6DSR3b0EBCrmhtdr
         eUiJu4GrMY/Eh79tGYLVE6vP1NseMZwj2TRXNiM5GCncTpVl3phUZFwPTDz3RDhhKx
         68TCnSfpvoZQxS7bArQdpoMP+VuyulA5Pphg1Q+c=
Date:   Mon, 27 Jan 2020 10:33:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Namjae Jeon <linkinjeon@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        valdis.kletnieks@vt.edu, sj1557.seo@samsung.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v13 00/13] add the latest exfat driver
Message-ID: <20200127093328.GA413113@kroah.com>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
 <20200125213228.GA5518@lst.de>
 <20200127090409.vvv7sd2uohmliwk5@pali>
 <20200127092343.GB392535@kroah.com>
 <20200127092840.gogcrq3pozgfayiy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127092840.gogcrq3pozgfayiy@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 10:28:40AM +0100, Pali Rohár wrote:
> On Monday 27 January 2020 10:23:43 Greg KH wrote:
> > On Mon, Jan 27, 2020 at 10:04:09AM +0100, Pali Rohár wrote:
> > > On Saturday 25 January 2020 22:32:28 Christoph Hellwig wrote:
> > > > The RCU changes looks sensible to me:
> > > > 
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > Great! Are there any other issues with this last version?
> > > 
> > > If not, Greg would you take this patch series?
> > 
> > Me?  I'm not the vfs/fs maintainer.
> 
> You took exfat driver (into staging), so I thought that exfat handled by you.

I am the maintainer of drivers/staging/*.

scripts/get_maintainer.pl is your friend :)

