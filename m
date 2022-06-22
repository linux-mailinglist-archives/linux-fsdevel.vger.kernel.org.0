Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5625541DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiFVEuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiFVEub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:50:31 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0BB35853;
        Tue, 21 Jun 2022 21:50:30 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 013B5C01E; Wed, 22 Jun 2022 06:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655873429; bh=MVob8mlvu/0rVBPNuTrr80XvIgvUL/9hN6SwizR5dFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAU8d5Zhjwg8WqZ/UGcp9RWXKikrRT9O775dD9Q+m7cMqHU8h/jFoKPmMb3vzJPJH
         nP+7wmaM9as6z0jeYUNEcjQwFlneuNYOsckvZEj7KmrRfXvuvaW0yDNzjB9nAw8yUa
         E9/56fuKKCo97pV0t+eICrFZZt+AlK8dJ9alGk58ZWQ2QeB9/FtLMWQXB6JBJG2AZX
         /ER78CX0ZmawhA5mWIgvYBNvJP8EJfnELjEYQVr0pbiVkx2Y0ATfblpu+fawL3HnFn
         MVTw9peF+hUZI0Uewbr+1qLdkY+2MT36X7q8bn94h1a2CXDCmLNeQ0kQgY1C3XAzlK
         BzAFA3jbu8BAg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 5D9F5C009;
        Wed, 22 Jun 2022 06:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655873428; bh=MVob8mlvu/0rVBPNuTrr80XvIgvUL/9hN6SwizR5dFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zZQ0eqheNcPefiEdm84pWuGSNlVzahc79XGOmChUX/AnBIW8jffJ7CvC7ajtnoDgy
         9f4IIchyJuHrJ7sqUiG4Ky0SHXmcCzRgm6UQ+6xhV7iX4wGtX7SdBerPKT03gIzyqa
         hbyEcm8nU2J6hv/mgAKwdJIVGRGRuvDVPoeDW5JOkLPyY2YFD1I0HoyQiwy6Em4UZK
         UL/iODYYdMr3ctwT9RWU7hDfCx0kZ5GGyic+5uXikbZ7DlvQfUo02T1aw1GvGkXT1n
         k0JAkN49isdTUDByg/CbwSXvGpBPCnLHOrih8DjYmhfiN9mO0vUemt8x/wfTHELKQz
         CjLajPgxFByEA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 418d2c3c;
        Wed, 22 Jun 2022 04:50:23 +0000 (UTC)
Date:   Wed, 22 Jun 2022 13:50:08 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [GIT PULL] 9p fixes for 5.19-rc4
Message-ID: <YrKfgD+O9F4IPzua@codewreck.org>
References: <YrKeHMRfXTNw3vTE@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrKeHMRfXTNw3vTE@codewreck.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Resending as my dkim-signing daemon was borked...
Sorry for the trouble if you're getting this twice.

Dominique Martinet wrote on Wed, Jun 22, 2022 at 01:44:12PM +0900:
> 
> Thanks to Tyler and Christian for the patch/reviews/tests!
> 
> 
> The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:
> 
>   Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/martinetd/linux tags/9p-for-5.19-rc4
> 
> for you to fetch changes up to b0017602fdf6bd3f344dd49eaee8b6ffeed6dbac:
> 
>   9p: fix EBADF errors in cached mode (2022-06-17 06:03:30 +0900)
> 
> ----------------------------------------------------------------
> 9p-for-5.19-rc4: fid refcount and fscache fixes
> 
> This contains a couple of fixes:
>  - fid refcounting was incorrect in some corner cases and would
> leak resources, only freed at umount time. The first three commits
> fix three such cases
>  - cache=loose or fscache was broken when trying to write a partial
> page to a file with no read permission since the rework a few releases
> ago. The fix taken here is just to restore old behavior of using the
> special 'writeback_fid' for such reads, which is open as root/RDWR
> and such not get complains that we try to read on a WRONLY fid.
> Long-term it'd be nice to get rid of this and not issue the read at
> all (skip cache?) in such cases, but that direction hasn't progressed
> 
> ----------------------------------------------------------------
> Dominique Martinet (3):
>       9p: fix fid refcount leak in v9fs_vfs_atomic_open_dotl
>       9p: fix fid refcount leak in v9fs_vfs_get_link
>       9p: fix EBADF errors in cached mode
> 
> Tyler Hicks (1):
>       9p: Fix refcounting during full path walks for fid lookups
> 
>  fs/9p/fid.c            | 22 +++++++++-------------
>  fs/9p/vfs_addr.c       | 13 +++++++++++++
>  fs/9p/vfs_inode.c      |  8 ++++----
>  fs/9p/vfs_inode_dotl.c |  3 +++
>  4 files changed, 29 insertions(+), 17 deletions(-)
> 
--
Dominique
