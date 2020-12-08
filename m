Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42CC2D3368
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgLHUSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgLHUSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:18:25 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B768C0617A6;
        Tue,  8 Dec 2020 12:17:44 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmizP-00HU9e-B3; Tue, 08 Dec 2020 19:49:35 +0000
Date:   Tue, 8 Dec 2020 19:49:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201208194935.GH3579531@ZenIV.linux.org.uk>
References: <20201115155355.GR3576660@ZenIV.linux.org.uk>
 <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk>
 <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk>
 <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk>
 <20201127162902.GA11665@lst.de>
 <20201208163552.GA15052@lst.de>
 <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:34:45AM -0800, Linus Torvalds wrote:
> On Tue, Dec 8, 2020 at 8:35 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Shouldn't this go to Linus before v5.10 is released?
> >
> > ping?
> 
> So by now I'm a bit worried about this series, because the early fixes
> caused more problems than the current state.

*nod*

Said that, it does appear to survive all beating, and it does fix
a regression introduced in this cycle, so, provided that amount of
comments in there is OK with you...

The following changes since commit d4d50710a8b46082224376ef119a4dbb75b25c56:

  seq_file: add seq_read_iter (2020-11-06 10:05:18 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 4bbf439b09c5ac3f8b3e9584fe080375d8d0ad2d:

  fix return values of seq_read_iter() (2020-11-15 22:12:53 -0500)

----------------------------------------------------------------
Al Viro (1):
      fix return values of seq_read_iter()

 fs/seq_file.c | 57 +++++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)
