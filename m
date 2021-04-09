Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623133591AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 03:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhDIBwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 21:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhDIBwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:52:32 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41434C061760;
        Thu,  8 Apr 2021 18:52:20 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUgJf-003sVF-Ge; Fri, 09 Apr 2021 01:52:11 +0000
Date:   Fri, 9 Apr 2021 01:52:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] fileattr API
Message-ID: <YG+zSwlFggNWPJ1I@zeniv-ca.linux.org.uk>
References: <YG4GjNEqC6Pmhmod@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG4GjNEqC6Pmhmod@miu.piliscsaba.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:22:52PM +0200, Miklos Szeredi wrote:
> Hi Al,
> 
> Please pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git fileattr_v4
> 
> Convert all (with the exception of CIFS) filesystems from handling
> FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR themselves to new i_ops and
> common code moved into the VFS for these ioctls.  This removes boilerplate
> from filesystems, and allows these operations to be properly stacked in
> overlayfs.

Umm...  v4 or v5?
