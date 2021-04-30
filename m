Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D736F480
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 05:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhD3DW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 23:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhD3DWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:22:23 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2BDC06138E;
        Thu, 29 Apr 2021 20:21:36 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcJia-009Rdo-M6; Fri, 30 Apr 2021 03:21:28 +0000
Date:   Fri, 30 Apr 2021 03:21:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Justin He <Justin.He@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
Message-ID: <YIt3uKBQnlxHAo/Q@zeniv-ca.linux.org.uk>
References: <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de>
 <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de>
 <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk>
 <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
 <26d06c27-4778-bf75-e39a-3b02cd22d0e3@rasmusvillemoes.dk>
 <CAHk-=whJmDjTLYLeF=Ax31vTOq4PHXKo6JUqm1mQNGZdy-6=3Q@mail.gmail.com>
 <AM6PR08MB43769965CAF732F1DEA4A37AF75E9@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB43769965CAF732F1DEA4A37AF75E9@AM6PR08MB4376.eurprd08.prod.outlook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:17:02AM +0000, Justin He wrote:

> Is it a good idea to introduce a new d_path_nolock() for file_dentry_name()?
> In d_path_nolock(), if it detects that there is conflicts with mount_lock
> or rename_lock, then returned NULL as a name of that vfsmount?

Just what does vfsmount have to do with rename_lock?  And what's the point
of the entire mess, anyway?
