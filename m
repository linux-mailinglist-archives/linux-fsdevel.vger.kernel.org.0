Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0B2C4F3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 08:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbgKZHSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 02:18:51 -0500
Received: from verein.lst.de ([213.95.11.211]:33267 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388325AbgKZHSv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:18:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 281DA68B02; Thu, 26 Nov 2020 08:18:49 +0100 (CET)
Date:   Thu, 26 Nov 2020 08:18:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-kernel@vger.kernel.org, prime.zeng@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH] fs: export vfs_stat() and vfs_fstatat()
Message-ID: <20201126071848.GA17990@lst.de>
References: <1606374948-38713-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606374948-38713-1-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:15:48PM +0800, Yicong Yang wrote:
> The public function vfs_stat() and vfs_fstatat() are
> unexported after moving out of line in
> commit 09f1bde4017e ("fs: move vfs_fstatat out of line"),
> which will prevent the using in kernel modules.
> So make them exported.

And why would you want to use them in kernel module?  Please explain
that in the patch that exports them, and please send that patch in the
same series as the patches adding the users.
