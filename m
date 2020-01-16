Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A90BC13D7E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 11:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgAPKaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 05:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgAPKaT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:30:19 -0500
Received: from localhost (static-140-208-78-212.thenetworkfactory.nl [212.78.208.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD4D207FF;
        Thu, 16 Jan 2020 10:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579170618;
        bh=a4ewz/hH4CwNTd4F4Q2qUyy5DVwlXtDQmCi+UaaQq10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=14/Z/HK4kS39Z9ieLuam+x1f3GKmqCfBBFQaYnt+FOQispvESwg5gB+5RII7stABr
         8RhtbZf4Dy+IapIHelqvNhVBh3RtsmtNsVccTbgjMyr2seFzYLKNUYjy59QL8PFiPz
         5HQTabeH9wP9PK7Yk02nJ/xf3SOTF9cuFKpxilVs=
Date:   Thu, 16 Jan 2020 11:30:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [v10 00/14] add the latest exfat driver
Message-ID: <20200116103015.GA182905@kroah.com>
References: <c4fdc6af-04c2-81a5-891d-5a3db4778caa@web.de>
 <20200116102041.i52l3eoas7xrhlxv@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116102041.i52l3eoas7xrhlxv@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:20:41AM +0100, Pali Rohár wrote:
> On Thursday 16 January 2020 10:43:50 Markus Elfring wrote:
> > > Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
> > >
> > > Next steps for future:
> > 
> > How does this tag fit to known open issues?
> 
> Is there any list of known open issues? Or what do you mean by known
> open issues?

You are trying to discuss things with an email address that many of us
have added to their kill-file and is thought just to be a bot.

Don't waste your time :)

greg k-h
