Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727161D1AA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbgEMQIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 12:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgEMQIo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 12:08:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3E9204EC;
        Wed, 13 May 2020 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589386124;
        bh=xENrYOLRKxUHJZrp+JmavDdZ/UKSb+Y8/NlbM/O49u0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVnPnqCQzu6sKGo2G8yYkn+Wdx92oAedw+XTsq0coaVfDeYR2l8X1Vxy/fAGPSgb6
         CurZQ5dNws/E4yk1ZLz7Nc6lKg/ux80ax0X/dURotSB1dmXxAKoE/Lz3oMPmsidGGg
         6HybQ5/jV/tPjKUDq0k8a4H0PBYFTZkQ8wRTyqfQ=
Date:   Wed, 13 May 2020 18:08:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     viro@zeniv.linux.org.uk, rafael@kernel.org, ebiederm@xmission.com,
        jeyu@kernel.org, jmorris@namei.org, keescook@chromium.org,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, nayna@linux.ibm.com, zohar@linux.ibm.com,
        scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs: move kernel_read*() calls to its own symbol
 namespace
Message-ID: <20200513160841.GB1362525@kroah.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513152108.25669-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513152108.25669-4-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 03:21:08PM +0000, Luis Chamberlain wrote:
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

I can't take patches without any changelog text at all, sorry.

greg k-h
