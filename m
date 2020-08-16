Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0809424569D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Aug 2020 09:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgHPH4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Aug 2020 03:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgHPH4H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Aug 2020 03:56:07 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0072F2065C;
        Sun, 16 Aug 2020 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597564567;
        bh=WBoK5fgAJLyzBGCPs2ZM73uEvs9Y4AnzIU1vghJTqvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3Z2ilzQuS9+MNNMUvFYwb4DdOAsh2dR6Kldq4ez4/qBX2pBUYOv/bA+voMZpnaA9
         MooFmMorP1YSsum1MX1PuYoC/gsQ0nFG93G4bV2ijWzS6gSoZw+BNSV1dQCD+1U1QQ
         dXrXun6sIQTpMEezw0j/hSPvrlI0WvFjSmQY1uO4=
Received: by pali.im (Postfix)
        id 677667BC; Sun, 16 Aug 2020 09:56:04 +0200 (CEST)
Date:   Sun, 16 Aug 2020 09:56:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Message-ID: <20200816075604.nx62kg5qz6ddp6gl@pali>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 14 August 2020 12:29:01 Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.
> 
> Having decades of expertise in commercial file systems development and huge
> test coverage, we at Paragon Software GmbH want to make our contribution to
> the Open Source Community by providing implementation of NTFS Read-Write
> driver for the Linux Kernel.
> 
> This is fully functional NTFS Read-Write driver. Current version works with
> NTFS(including v3.1) normal/compressed/sparse files and supports journal replaying.
> 
> We plan to support this version after the codebase once merged, and add new
> features and fix bugs. For example, full journaling support over JBD will be
> added in later updates.
> 
> The patch is too big to handle it within an e-mail body, so it is available to download 
> on our server: https://dl.paragon-software.com/ntfs3/ntfs3.patch
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Hello Konstantin! I agree with David that patch is big and could be
split into smaller patches per file, like exfat driver was reviewed.

When you send a new version of ntfs driver, please add me to CC and I
will try to find some time to do code review. Thanks!
