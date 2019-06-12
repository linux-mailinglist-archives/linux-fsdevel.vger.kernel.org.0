Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBED242D45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392154AbfFLRQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 13:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfFLRQb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:16:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC5B21019;
        Wed, 12 Jun 2019 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560359791;
        bh=4r1wuhM6+MGt67JwlvaIzVaS1w3fGsvvtHIyIOtQfSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAsQSn02M3bNERhTLwR+Px2AQb9z8COtL3LvkAp77AAYprqcCCfu+nZJlhqVMFMLF
         WORV9xx199fDlOx095F7Uu3gefzmv6+bUTdNm/LaRNvHvjKtp9jWe+SKyqce2hZDWg
         5Z9mllLCVzhBl8vL9yM/R7Yb279AWfB+xqrFivVY=
Date:   Wed, 12 Jun 2019 19:16:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH 01/12] Compiler Attributes: add __flatten
Message-ID: <20190612171628.GA7518@kroah.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610191420.27007-2-kent.overstreet@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:14:09PM -0400, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  include/linux/compiler_attributes.h | 5 +++++
>  1 file changed, 5 insertions(+)

I know I reject patches with no changelog text at all.  You shouldn't
rely on other maintainers being more lax.

You need to describe why you are doing this at the very least, as I sure
do not know...

thanks,

greg k-h
