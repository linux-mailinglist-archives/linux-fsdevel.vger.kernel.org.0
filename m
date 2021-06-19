Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E113ADA81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jun 2021 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhFSPLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Jun 2021 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhFSPLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Jun 2021 11:11:30 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A91C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jun 2021 08:09:19 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lucay-00A1xw-CS; Sat, 19 Jun 2021 15:09:16 +0000
Date:   Sat, 19 Jun 2021 15:09:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arthur Williams <taaparthur@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Allow open with O_CREAT to succeed if existing dir
 is specified
Message-ID: <YM4InFG2HnrbHdsO@zeniv-ca.linux.org.uk>
References: <20210619110148.30412-1-taaparthur@gmail.com>
 <YM3mJjDovNHUxZ8v@zeniv-ca.linux.org.uk>
 <CAJ6D+Z96OWwZMzickLP3PtUnsJhSfZqTnLrmk4-t5iNUid=N=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ6D+Z96OWwZMzickLP3PtUnsJhSfZqTnLrmk4-t5iNUid=N=Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 19, 2021 at 06:44:52AM -0700, Arthur Williams wrote:

> util-linux explicitly
> acknowledges it. From their sys-utils/flock.c: "Linux doesn't like O_CREAT
> on a directory, even
> though it should be a no-op;"

So does *BSD, while we are at it.  Out of curiosity - which more or less
recent Unices do *not* behave that way?

> And to their point, the man page for open
> does seem to imply that:
>      O_CREAT
>               If pathname does not exist, create it as a regular file.
> 
> But I can also see how it isn't completely clear since it doesn't
> explicitly state what happens when
> the file already exists. If this patch is to be rejected, would it be best
> to
> update the man pages/docs to explain the effect and justification for the
> current behavior?

*shrug*

Quote POSIX in errors section, perhaps?
