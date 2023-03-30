Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73DD6CFB27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjC3GCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 02:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjC3GCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:02:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878365B8;
        Wed, 29 Mar 2023 23:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FD7161EE5;
        Thu, 30 Mar 2023 06:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B84DC433EF;
        Thu, 30 Mar 2023 06:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680156125;
        bh=MatsWcKGv66X0GG9UiUtyibm2aW+Mc1KwnNPQlz05QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9l+o6oG9PPtB1m2nPF99hD029z22ZIl1k97974fnK2LhK28ABP9MgqgRFEBbSHXW
         bg3kZPLcSaKlEbCGwRuzlfN/YU/dgg+s5NCsB8Ux/SqzYpCC7E5MNAqhWuNZQ12nMU
         lo6pW2mavFr5uZ8cPG1png/oPf+T0pKaSlhTjCMk=
Date:   Thu, 30 Mar 2023 08:02:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: consolidate dt_type() helper definitions
Message-ID: <ZCUl27HmB4pVkAb_@kroah.com>
References: <20230329192425.194793-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329192425.194793-1-jlayton@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 03:24:23PM -0400, Jeff Layton wrote:
> There are 4 functions named dt_type() in the kernel. Consolidate the 3
> that are basically identical into one helper function in fs.h that
> takes a umode_t argument. The v9fs helper is renamed to distinguish it
> from the others.
> 
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/9p/vfs_dir.c    | 6 +++---
>  fs/configfs/dir.c  | 8 +-------
>  fs/kernfs/dir.c    | 8 +-------
>  fs/libfs.c         | 9 ++-------
>  include/linux/fs.h | 6 ++++++
>  5 files changed, 13 insertions(+), 24 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
