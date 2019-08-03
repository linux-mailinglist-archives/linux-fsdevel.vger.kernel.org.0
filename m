Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF280853
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 23:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfHCVHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 17:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfHCVHs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 17:07:48 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 608F621726;
        Sat,  3 Aug 2019 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564866467;
        bh=GyUseNIq/TOH+J0pqQVl0ttWouIq5laojh4Jgs4Gnps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0ufmtJyVDpkkKuh/ZNpBn7FwsB2gRYd1keOXDOk2jXPyaFu8aIKi6IemELXoxpDP
         MIhY1qrZCErDo3LBKy844+Xc3Zu1EzX177X+FqQ8u/WO3GFQcA/nEOQmHnf/U3ppf5
         5v9JUPZ9mQBq7UGgLIsgMANGo5+1CVEKrVmUzTko=
Date:   Sat, 3 Aug 2019 14:07:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: cleanups for 5.3-rc3
Message-ID: <20190803210746.GM7138@magnolia>
References: <20190803163312.GK7138@magnolia>
 <CAHk-=wgg8Y=KxZaHy66BdOKKtDzQ_XN4sR6YWa00+v+06azt4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgg8Y=KxZaHy66BdOKKtDzQ_XN4sR6YWa00+v+06azt4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 03, 2019 at 10:46:38AM -0700, Linus Torvalds wrote:
> On Sat, Aug 3, 2019 at 9:33 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Here are a couple more bug fixes that trickled in since -rc1.  It's
> > survived the usual xfstests runs and merges cleanly with this morning's
> > master.  Please let me know if anything strange happens.
> 
> Hmm. This was tagged, but not signed like your usual tags are.
> 
> I've pulled it (I don't _require_ signed tags from kernel.org), but
> would generally be much happier if I saw the signing too...

D'oh.  Sorry, I forgot to git tag -a. :(

/me rummages around to see if there's a way to configure git to sign
always...

--D

> Thanks,
> 
>                  Linus
