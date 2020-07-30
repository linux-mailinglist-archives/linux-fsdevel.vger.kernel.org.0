Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950EC232F2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 11:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgG3JGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 05:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgG3JGX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:06:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFDC92072A;
        Thu, 30 Jul 2020 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596099983;
        bh=ieC3UQSH9xTQQlFP1mBTpQK8Jaet0JuMdqnPvTiLzSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/OlMNCjgJjVCDEAUFFVbS7j9qnE79NsrCIar3YE+oLzkykZo4SyLPjtjBmvhhkcD
         T9PkgtjWLgbnsiDPD6gD6YwuUd+7hajjK66mABoLrTUlc/yFV744DxvWyv+/e12Zv2
         o7cXTtiuU4bHGqJbB2DKVrNBS9iI30MBTfDZpeMY=
Date:   Thu, 30 Jul 2020 11:06:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     madvenka@linux.microsoft.com
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v1 2/4] [RFC] x86/trampfd: Provide support for the
 trampoline file descriptor
Message-ID: <20200730090612.GA900546@kroah.com>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <20200728131050.24443-3-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728131050.24443-3-madvenka@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 08:10:48AM -0500, madvenka@linux.microsoft.com wrote:
> +EXPORT_SYMBOL_GPL(trampfd_valid_regs);

Why are all of these exported?  I don't see a module user in this
series, or did I miss it somehow?

EXPORT_SYMBOL* is only needed for symbols to be used by modules, not by
code that is built into the kernel.

thanks,

greg k-h
