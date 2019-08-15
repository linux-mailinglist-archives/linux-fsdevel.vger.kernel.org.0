Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7EA8EDC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbfHOOJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 10:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfHOOJk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:09:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A3B2086C;
        Thu, 15 Aug 2019 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565878179;
        bh=CIem41+aGIPI0ShLoJjGUdD5jnLIgiP1Cy1SmH3wCMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYstUvpPXEPFH7IqKbs8onE5vnccfHXRMWL7vsugDA6iNjGUNE3iuIVmbmjB7vFw1
         WY0Ie7yKZh/F0M5lTRInW0CxAZU9VD6rPVVETeM4WhXwqWcfwdufVzBO+RyQqOqjj/
         JgVS4ZEESONECWXuedzB/Nodu5cSjO2mjtmIDMi8=
Date:   Thu, 15 Aug 2019 16:09:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <dima@arista.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 11/18] tty: handle compat PPP ioctls
Message-ID: <20190815140937.GB23267@kroah.com>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814205521.122180-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814205521.122180-2-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:54:46PM +0200, Arnd Bergmann wrote:
> Multiple tty devices are have tty devices that handle the
> PPPIOCGUNIT and PPPIOCGCHAN ioctls. To avoid adding a compat_ioctl
> handler to each of those, add it directly in tty_compat_ioctl
> so we can remove the calls from fs/compat_ioctl.c.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
