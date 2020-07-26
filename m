Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B350922DCF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGZHnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGZHnK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:43:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B1E2065F;
        Sun, 26 Jul 2020 07:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595749389;
        bh=4rKZH64Zbiy83+h01nqKrcL6n0VVrtwg4ZMe+QZwIRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HY0hQztRqLg6G8Q0yBnmMqG005o1z+P1Yc2ak3vJ4d51ZZboJIrkjsNc3e3yjGEC/
         QpD3EzKSp8Ok5LWLMxylIjGQaYkKLB0NVOxQfBkipq4ujre5F/pUD7W7BYzy4lkHcd
         uJlYa8c52/5k4hjHAGC4y16hYKzoM7k+OXYG2YEY=
Date:   Sun, 26 Jul 2020 09:43:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 04/21] devtmpfs: refactor devtmpfsd()
Message-ID: <20200726074306.GA444745@kroah.com>
References: <20200726071356.287160-1-hch@lst.de>
 <20200726071356.287160-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726071356.287160-5-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 09:13:39AM +0200, Christoph Hellwig wrote:
> Split the main worker loop into a separate function.  This allows
> devtmpfsd itself and devtmpfsd_setup to be marked __init, which will
> allows us to call __init routines for the setup work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/devtmpfs.c | 47 +++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)

Nice cleanup, thanks for doing this:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
