Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8523A5CF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 08:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhFNG0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 02:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbhFNG0C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:26:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7437C6120E;
        Mon, 14 Jun 2021 06:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623651839;
        bh=Ge9PXkJ3x+2rYLqQasfgt/guqfuYt6sXPCK3uNcZYz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axHsHsrUfRolC8TqmHfGEwq0iE7042axP6APvTfwrQiuU/OogRnkRzQNb7BXG5LAW
         b/wsT+qUK1KRO0X0m4L2gq3lbbby3o5zJCx6xGMuDbLhuVqNxGflMQSNbOiycu8GFa
         lHvcjhzUBOsaEVey4RyFKLnUvMK+5aerCZVFIwfk=
Date:   Mon, 14 Jun 2021 08:23:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: unexport __set_page_dirty
Message-ID: <YMb1/SF38CZdybn/@kroah.com>
References: <20210614061512.3966143-1-hch@lst.de>
 <20210614061512.3966143-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614061512.3966143-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 08:15:10AM +0200, Christoph Hellwig wrote:
> __set_page_dirty is only used by built-in code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/buffer.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
