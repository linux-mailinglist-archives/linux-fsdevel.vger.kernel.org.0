Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF464A38B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 20:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356013AbiA3TfM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 14:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiA3TfM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:35:12 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34801C061714;
        Sun, 30 Jan 2022 11:35:11 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEFyd-005v5I-Pp; Sun, 30 Jan 2022 19:35:07 +0000
Date:   Sun, 30 Jan 2022 19:35:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tal Zussman <tz2294@columbia.edu>
Cc:     "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Xijiao Li <xl2950@columbia.edu>,
        Hans Montero <hjm2133@columbia.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        OS-TA <cucs4118-tas@googlegroups.com>
Subject: Re: [PATCH] fs: Remove FIXME comment in generic_write_checks()
Message-ID: <Yfboax2Yw/s5xAnp@zeniv-ca.linux.org.uk>
References: <20211231075750.GA1376@charmander>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231075750.GA1376@charmander>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 31, 2021 at 02:57:50AM -0500, Tal Zussman wrote:
> This patch removes an unnecessary comment that had to do with block special
> files from `generic_write_checks()`.
> 
> The comment, originally added in Linux v2.4.14.9, was to clarify that we only
> set `pos` to the file size when the file was opened with `O_APPEND` if the file
> wasn't a block special file. Prior to Linux v2.4, block special files had a
> different `write()` function which was unified into a generic `write()` function
> in Linux v2.4. This generic `write()` function called `generic_write_checks()`.
> For more details, see this earlier conversation:
> https://lore.kernel.org/linux-fsdevel/Yc4Czk5A+p5p2Y4W@mit.edu/
> 
> Currently, block special devices have their own `write_iter()` function and no
> longer share the same `generic_write_checks()`, therefore rendering the comment
> irrelevant.

Applied
