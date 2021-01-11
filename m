Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25B2F0BC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 05:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbhAKEVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 23:21:01 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:44767 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbhAKEVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:21:00 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6DED7229E;
        Sun, 10 Jan 2021 23:20:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 10 Jan 2021 23:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        UDF/jeENnPalcKRQYrg/TnkaEJR4pTja5gcX7090LeY=; b=TCJhqg9zrMNzCwA+
        cWduJ16UDTlgY+WZHZQr6Cv0Rp2tEQyAk64+dKWoFX5RxJttkyK4ej0yClrpiA5V
        oChZRvNFGHPJ4jXK5YcPCaVbeNjEwlBLpVZ9k0449dJeqLUI0WJnIyQp3XAQissh
        hfwI0loyiQNny6D4+WtBF0wrg2GncADFLpaCnfEu6x4RKX1fwfBudS9vX3sp2tOZ
        ytHg0rFq9lzosAEC7x8PRgTqF61J0AoGSQRVvSHHtVgm7nalKlbuGbgw3mWNqAQS
        f0qC32FPnczD7xLf7Av3TtbkRYBeoIXliPw8geykmmmNdhGCoaXciW/D4R6cauQe
        iIuvYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=UDF/jeENnPalcKRQYrg/TnkaEJR4pTja5gcX7090L
        eY=; b=LN7HfwUewgu4y7T5Kb9kek/EOA7RVFdQJZF9wXYdSKrf0N0Ofcj/LGOb1
        EVKxbLqtGPK1rUcGiAnT3bgizMHN4/GoSJGR3kf5K7vR+4BT6hScYt4GIZAMRMZr
        mbUZ4ceX/qAOnpXp8lIXFnFgiIyprh+ga6Amv3g7qm0ZTHQ2ZWVfmO9M2NHrn/VD
        QuFoE8D71nif8WKet/ZrgqDJJrnLQw9kCTFcfYUoLfoXLA7lhGxskG8btzCRh10T
        fRLvoX0rvwC8ozx44XgmcxNTWSm+DrI+/Qz8KkWNMG4DzYOdGzlC8e+j5D4Wg38O
        65vLGeoS5rz61nKE9DmUGbdE3omyA==
X-ME-Sender: <xms:_dH7X3UGPVLn3ASDIJm7ALtiBYu9AYkMG4m-HpraFxjxmh7EJPSbHg>
    <xme:_dH7Xz3TyeJpH5xfs-G_u23kcl9-WrWkBv5rR90yK7FsIaIh5b7Cf8YpL_2lISvzW
    pFKuBqIS7Yt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrudefuddrvdefne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgv
    nhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:_dH7X-arnkcCYJb36ym6OROvK1Yfwqncqxn40BTioM1HOtCsxvO-1w>
    <xmx:_dH7X2reBgghaqmDncyWyhcsPILrTkQXmaEN4BRe9A401RnPjFNTpw>
    <xmx:_dH7X6qOC2WCu6rMi7LLE7pqQxQ_VuF0LPRgjEBizEXmZhWvhEZ5Mg>
    <xmx:_tH7X8kcUEtNVcLXQu-rP4BNEyDIXvPQ3eknK3Hv28RFJXZxNf6Jdg>
Received: from mickey.themaw.net (unknown [121.44.131.23])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E3551080064;
        Sun, 10 Jan 2021 23:20:09 -0500 (EST)
Message-ID: <42efbb86327c2f5a8378d734edc231e3c5a34053.camel@themaw.net>
Subject: Re: [PATCH 0/6] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 11 Jan 2021 12:20:06 +0800
In-Reply-To: <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
         <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
         <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
         <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
         <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-01-11 at 11:19 +0800, Ian Kent wrote:
> On Wed, 2021-01-06 at 10:38 +0800, Fox Chen wrote:
> > Hi Ian,
> > 
> > I am rethinking this problem. Can we simply use a global lock?
> > 
> >  In your original patch 5, you have a global mutex attr_mutex to
> > protect attr, if we change it to a rwsem, is it enough to protect
> > both
> > inode and attr while having the concurrent read ability?
> > 
> > like this patch I submitted. ( clearly, I missed __kernfs_iattrs
> > part,
> > but just about that idea )
> > https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/
> 
> I don't think so.
> 
> kernfs_refresh_inode() writes to the inode so taking a read lock
> will allow multiple processes to concurrently update it which is
> what we need to avoid.
> 
> It's possibly even more interesting.
> 
> For example, kernfs_iop_rmdir() and kernfs_iop_mkdir() might alter
> the inode link count (I don't know if that would be the sort of thing
> they would do but kernfs can't possibly know either). Both of these
> functions rely on the VFS locking for exclusion but the inode link
> count is updated in kernfs_refresh_inode() too.
> 
> That's the case now, without any patches.

So it's not so easy to get the inode from just the kernfs object
so these probably aren't a problem ...

> 
> I'm not entirely sure what's going on in kernfs_refresh_inode().
> 
> It could be as simple as being called with a NULL inode because
> the dentry concerned is negative at that point. I haven't had
> time to look closely at it TBH but I have been thinking about it.

Certainly this can be called without a struct iattr having been
allocated ... and given it probably needs to remain a pointer
rather than embedded in the node the inode link count update
can't easily be protected from concurrent updates.

If it was ok to do the allocation at inode creation the problem
becomes much simpler to resolve but I thought there were concerns
about ram consumption (although I don't think that was exactly what
was said?).

Ian

