Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B946B20224E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFTHVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgFTHVk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:21:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D912339E;
        Sat, 20 Jun 2020 07:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592637699;
        bh=2trF8Rl71vLjUmI4LWiemqpWXIwR+dSGuwBYjMu4i9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVByj6HuKLUZsUNryxdHUVRFktM6e23MzuYLWdXxrtEpMkK71deEyNDQr7PEFgd/V
         6elp82TWdKrqRBOsSJjzlz6ZR73vxFWxEowgBjeZORZFrOvXdmCzm553sbh6V+JJ8Y
         eIdAE2bi990dSnN1Uob0l+zLJoaAkEGvmMrwXF2c=
Date:   Sat, 20 Jun 2020 09:21:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] tty/sysrq: emergency_thaw_all does not depend on
 CONFIG_BLOCK
Message-ID: <20200620072136.GA66401@kroah.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620071644.463185-2-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 09:16:35AM +0200, Christoph Hellwig wrote:
> We can also thaw non-block file systems.  Remove the CONFIG_BLOCK in
> sysrq.c after making the prototype available unconditionally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/tty/sysrq.c | 2 --
>  include/linux/fs.h  | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
