Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE30C14A0A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 10:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgA0JXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 04:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgA0JXq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:23:46 -0500
Received: from localhost (unknown [84.241.194.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BEB2071E;
        Mon, 27 Jan 2020 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580117026;
        bh=iYDpIp1Lhe1QucBKhS3OM0PcB8AtNh+T1UsXhkaS42Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yYglly/ArJKdnbFpMs91ZIPtMIDXsEIblVJRv7Vx5KPGSlyn3rP3fkARAokI04C1s
         ljMi3aogzPO5/57w7vvg1B6bs7PyEbZtMAzjLHeaE9FlTT9kUjYwUVV1SzcRUcCpQ9
         V8HgC8agxU/YnLJf/E8tyWPZF2iiV7VypUf8M4ac=
Date:   Mon, 27 Jan 2020 10:23:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Namjae Jeon <linkinjeon@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        valdis.kletnieks@vt.edu, sj1557.seo@samsung.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v13 00/13] add the latest exfat driver
Message-ID: <20200127092343.GB392535@kroah.com>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
 <20200125213228.GA5518@lst.de>
 <20200127090409.vvv7sd2uohmliwk5@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127090409.vvv7sd2uohmliwk5@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 10:04:09AM +0100, Pali Rohár wrote:
> On Saturday 25 January 2020 22:32:28 Christoph Hellwig wrote:
> > The RCU changes looks sensible to me:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Great! Are there any other issues with this last version?
> 
> If not, Greg would you take this patch series?

Me?  I'm not the vfs/fs maintainer.

And even if I was, it's _just_ too late as anything for 5.6-rc1 would
have needed to be in linux-next already for usually at least a week.

thanks,

greg k-h
