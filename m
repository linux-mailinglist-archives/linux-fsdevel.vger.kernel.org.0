Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8E3764D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhEGMEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 08:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235577AbhEGMEH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 08:04:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6E7660FE8;
        Fri,  7 May 2021 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620388987;
        bh=vudGHCGXetE5aXwQ1nvuEbeCdB1EcOBpJ+WbalwKr6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1kxSE+n+RPqY9HaUyaCLME/1H6AiR00wQeXArApF/6K9b1ty5scQoL0tm38QJbgE
         7rgl6lXRdZZbGduFPT9DHC72Y2aJf/ly6jQ+MdRHtYDbQB5/cRkJkpOX3ZVDhoJJiB
         Fio5Q6QnzNfT/HCUFVGkfnChrpB/vbsTrsUiWWqU=
Date:   Fri, 7 May 2021 14:03:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: fix security_locked_down() call for SELinux
Message-ID: <YJUseJLHBdvKYEOK@kroah.com>
References: <20210507114150.139102-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507114150.139102-1-omosnace@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 01:41:50PM +0200, Ondrej Mosnacek wrote:
> Make sure that security_locked_down() is checked last so that a bogus
> denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
> ATTR_UID | ATTR_GID)) is zero.

Why would this be "bogus"?

> Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
> debugfs when the kernel is locked down"), but it didn't matter at that
> time, as the SELinux support came in later.
> 
> Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")

What does this "fix"?

What is happening in selinux that it can not handle this sequence now?
That commit showed up a long time ago, this feels "odd"...

thanks,

greg k-h
