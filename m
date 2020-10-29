Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4541F29E90D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgJ2Kck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 06:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgJ2Kck (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:32:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED54A20791;
        Thu, 29 Oct 2020 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603967503;
        bh=onK+bef0PPKGJdtDgSQW3J9TSTDyI5I3MrlVHp8gLvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdYnxOHnp99O/JEKxgqd8KQDr9VXwAZAEBg3VOj6xpGw07i26328xRND1Xmn4OK3T
         /94IlE8bgc2CkeZivWElHACI3fHdsJxkLXuQ0zrsON0W6PtIYQTC93msCSLlXVfu4u
         hlxuhPUdU4xR/2PM1bpIv4eybZsh68Oq3MGluigQ=
Date:   Thu, 29 Oct 2020 11:32:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] proc: wire up generic_file_splice_read for iter ops
Message-ID: <20201029103233.GC3764182@kroah.com>
References: <20201029100950.46668-1-hch@lst.de>
 <20201029100950.46668-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100950.46668-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:09:49AM +0100, Christoph Hellwig wrote:
> Wire up generic_file_splice_read for the iter based proxy ops, so
> that splice reads from them work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/proc/inode.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
