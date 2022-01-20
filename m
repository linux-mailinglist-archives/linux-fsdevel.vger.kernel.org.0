Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783824949C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359340AbiATIqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:46:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41066 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiATIqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:46:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9B36176A;
        Thu, 20 Jan 2022 08:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FEFC340E0;
        Thu, 20 Jan 2022 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642668377;
        bh=zP3H8L0yrvKhCJfCDvCtc/pV9g2tPG9DoyeOBdGOFKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FeqtfDGRhBQtFD2IqzWbr3Kxs0Me8/suyudAtJOzH9rAjOtfnKPcohQMveqex58mu
         t++C1E6Tyty/Uaf92mvE7AE91N5g3FcgyNSvL7h9inT7bdG1rjYc+8/jlVG7TPZ0tf
         ZXGRXqh7SDvqyZY7u1qhYxVw/izQXd5J2/585OpJHu171enVfwYqkVoTcIQrX50FX0
         GRICs1LgU/Rm00W+3lDyT+vTyhSg/6xCjP7qrRVPEk1wmG2u16vTf6HrVHdxDgrx8B
         +9sPgnfQ5ffK+MIwMD3Xl0tla7QoKVmqjDoz9AfLVloLu3pf3qqMh3zxpc4ddcBGtj
         8SGyJ8HQiSIYg==
Date:   Thu, 20 Jan 2022 09:46:12 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devtmpfs: drop redundant fs parameters from internal fs
Message-ID: <20220120084612.hl5ekd4aplmduj6u@wittgenstein>
References: <20220119220248.32225-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119220248.32225-1-ailiop@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:02:48PM +0100, Anthony Iliopoulos wrote:
> The internal_fs_type is mounted via vfs_kernel_mount() and is never
> registered as a filesystem, thus specifying the parameters is redundant
> as those params will not be validated by fs_validate_description().
> 
> Both {shmem,ramfs}_fs_parameters are anyway validated when those
> respective filesystems are first registered, so there is no reason to
> pass them to devtmpfs too, drop them.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---

Ah yes, I "complained" about this on the patch re-enabling
reconfigure_mnt() for devtmpfs.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
