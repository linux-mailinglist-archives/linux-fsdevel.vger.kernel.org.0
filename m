Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA51AB5B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 04:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgDPCAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 22:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729707AbgDPCAI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:00:08 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3052E20725;
        Thu, 16 Apr 2020 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587002408;
        bh=5bHgMxkxq5OoYHIzY8aB3H41HjFShB2x1gkOMnn4UaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqdHtB2+f39HOV/1KklFM7kz2IRs+UE4U5NEM24XS9qhVfSivSIuZu2tuH3Xmmil3
         LUQqY9DdqLqivO4cFa7K7yf8QP2/g9w01Gmuc0HGVKpLdEd7ITU9kG5HwQ7IqQ3RDj
         YPmJvSZmtXjFmvOcok3d51qugwUjcu7VkPVrgdZ0=
Date:   Wed, 15 Apr 2020 19:00:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/34] docs: filesystems: rename path-lookup.txt file
Message-ID: <20200416020006.GC816@sol.localdomain>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
 <ddee231f968fcf8a9558ff39f251fdd7b2357ff2.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddee231f968fcf8a9558ff39f251fdd7b2357ff2.1586960617.git.mchehab+huawei@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 04:32:35PM +0200, Mauro Carvalho Chehab wrote:
> There are two files called "patch-lookup", with different contents:
> one is a ReST file, the other one is the text.
> 
> As we'll be finishing the conversion of filesystem documents,
> let's fist rename the text one, in order to avoid messing with
> the existing ReST file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../filesystems/{path-lookup.txt => path-walking.txt}       | 0
>  Documentation/filesystems/porting.rst                       | 2 +-
>  fs/dcache.c                                                 | 6 +++---
>  fs/namei.c                                                  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/filesystems/{path-lookup.txt => path-walking.txt} (100%)

Wouldn't it make more sense to consolidate path-lookup.rst and path-lookup.txt
into one file?  The .txt one is less detailed and hasn't been updated since
2011, so maybe it should just be deleted?  Perhaps there's something useful in
it that should be salvaged, though.

- Eric
