Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5C3764F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhEGMRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 08:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEGMRI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 08:17:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16A816100C;
        Fri,  7 May 2021 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620389767;
        bh=P0YtWzkLD3DOmsVoOQLjgCpAvJO0fNbiSyfCe27kFpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t23RvWqAglIwTyuExNCPYx2MCYpkb/QKyQlA0FNU+2wxbuVKFqlX+xOj1UBjFXr8W
         16xQVmyQrLrLuOi4cfzRHndfMfZWqhqZncMyWG3kfFUw4U+XuL6JVEoaYZZTFCoQKo
         kUrTkQf367rKUCTNJrQnl1mECETbNipj3yKLR7WY=
Date:   Fri, 7 May 2021 14:16:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: fix security_locked_down() call for SELinux
Message-ID: <YJUvhGV5EW0tsIpP@kroah.com>
References: <20210507114150.139102-1-omosnace@redhat.com>
 <YJUseJLHBdvKYEOK@kroah.com>
 <YJUuoiKFjM8Jdx6U@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJUuoiKFjM8Jdx6U@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 01:12:18PM +0100, Matthew Wilcox wrote:
> On Fri, May 07, 2021 at 02:03:04PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, May 07, 2021 at 01:41:50PM +0200, Ondrej Mosnacek wrote:
> > > Make sure that security_locked_down() is checked last so that a bogus
> > > denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
> > > ATTR_UID | ATTR_GID)) is zero.
> > 
> > Why would this be "bogus"?
> 
> I presume selinux is logging a denial ... but we don't then actually
> deny the operation.

That would be nice to note here...
