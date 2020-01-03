Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5912FB1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 18:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgACRIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 12:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgACRIk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:08:40 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A7520866;
        Fri,  3 Jan 2020 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071319;
        bh=LRI0fj+VA2I4+uKI4FIhQqiYK3mZfwRLgeKo7n8eJQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYhwY5A5asqoJvfgyTKNS2fl83jrU1n44A3+2bqqDGF1oPbLjlCiJzuQjnEsMDlvr
         YoBqjpp2V0MQHiMlC3y6igAb2GOd1dONSFaQqTpTB0j3+BK+oebKW9jbT0uicQIMk6
         stxTya8Mw+Fcw5y/JaUWWBalvg11gLqyiAWLfrwI=
Date:   Fri, 3 Jan 2020 09:08:37 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] ubifs: fixes for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS
Message-ID: <20200103170837.GN19521@gmail.com>
References: <20191209222325.95656-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209222325.95656-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 09, 2019 at 02:23:23PM -0800, Eric Biggers wrote:
> On ubifs, fix FS_IOC_SETFLAGS to not clear the encrypt flag, and update
> FS_IOC_GETFLAGS to return the encrypt flag like ext4 and f2fs do.
> 
> Eric Biggers (2):
>   ubifs: fix FS_IOC_SETFLAGS unexpectedly clearing encrypt flag
>   ubifs: add support for FS_ENCRYPT_FL
> 
>  fs/ubifs/ioctl.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

Richard, can you consider applying this series to the UBIFS tree for 5.6?

- Eric
