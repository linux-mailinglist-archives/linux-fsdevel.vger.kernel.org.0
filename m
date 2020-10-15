Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6228EB83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 05:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgJODZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 23:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgJODZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:25:14 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41274C061755;
        Wed, 14 Oct 2020 20:25:14 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kStsz-000WW0-3v; Thu, 15 Oct 2020 03:25:01 +0000
Date:   Thu, 15 Oct 2020 04:25:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
Message-ID: <20201015032501.GO3576660@ZenIV.linux.org.uk>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
 <20201010142355.741645-2-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010142355.741645-2-cgxu519@mykernel.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 10, 2020 at 10:23:51PM +0800, Chengguang Xu wrote:
> Currently there is no notification api for kernel about modification
> of vfs inode, in some use cases like overlayfs, this kind of notification
> will be very helpful to implement containerized syncfs functionality.
> As the first attempt, we introduce marking inode dirty notification so that
> overlay's inode could mark itself dirty as well and then only sync dirty
> overlay inode while syncfs.

Who's responsible for removing the crap from notifier chain?  And how does
that affect the lifetime of inode?
