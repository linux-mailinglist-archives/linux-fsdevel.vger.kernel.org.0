Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB823ADA08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jun 2021 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhFSMo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Jun 2021 08:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhFSMo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:44:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E684AC061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jun 2021 05:42:15 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luaIg-009zP9-KW; Sat, 19 Jun 2021 12:42:14 +0000
Date:   Sat, 19 Jun 2021 12:42:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arthur Williams <taaparthur@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Allow open with O_CREAT to succeed if existing dir
 is specified
Message-ID: <YM3mJjDovNHUxZ8v@zeniv-ca.linux.org.uk>
References: <20210619110148.30412-1-taaparthur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619110148.30412-1-taaparthur@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 19, 2021 at 06:01:48AM -0500, Arthur Williams wrote:
> Make opening a file with the O_CREAT flag a no-op if the specified file
> exists even if it exists as a directory. Allows userspace commands, like
> flock, to open a file and create it if it doesn't exist instead of
> having to parse errno.

Not going to happen.  It's a user-visible behaviour, consistent between
all kinds of Unices, consistent with POSIX and it does make sense.

NAK.
