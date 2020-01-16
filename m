Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4401C13DAFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 14:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgAPNBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 08:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgAPNBl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:01:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7122E20730;
        Thu, 16 Jan 2020 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579179700;
        bh=v9Po416KwW4s4njLFElwLgFMcq7ajvjcLbyC7QhnKjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjnAAyILSY9QT+fId0MJTQK4p5sFJh7R8BwyUjVFuQ4uYLqn/Qt1ya/wlcmxGWz0n
         5V1ZBtnG45rGUvmvxivu63LyXTLoCOAwgH9TDNFSqpm5G5t6Prwku5zyRAJUgpR/Kv
         //YUfK1h38QnH9bIHVLtgEXjrnALcG8FDd+2w2DA=
Date:   Thu, 16 Jan 2020 14:01:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        valdis.kletnieks@vt.edu, sj1557.seo@samsung.com,
        linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 00/14] add the latest exfat driver
Message-ID: <20200116130138.GA214226@kroah.com>
References: <CGME20200115082818epcas1p4892a99345626188afd111ee263132458@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com>
 <20200115094732.bou23s3bduxpnr4k@pali>
 <20200116105108.GA16924@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116105108.GA16924@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:51:08AM +0100, Christoph Hellwig wrote:
> > * After applying this patch series, remote staging exfat implementation.
> 
> I think Greg wants to do that separately.  I still hope we can do that
> in the same merge window, though.

I will be glad to do it in the same merge window, just let me know when
this gets accepted and I'll drop the staging version.

thanks,

greg k-h
