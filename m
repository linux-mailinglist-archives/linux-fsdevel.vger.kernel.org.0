Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425D136D255
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 08:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhD1Gl5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 02:41:57 -0400
Received: from verein.lst.de ([213.95.11.211]:48019 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhD1Gl5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:41:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7F62768B05; Wed, 28 Apr 2021 08:41:10 +0200 (CEST)
Date:   Wed, 28 Apr 2021 08:41:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
Message-ID: <20210428064110.GA5883@lst.de>
References: <20210427025805.GD3122264@magnolia> <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com> <20210427195727.GA9661@lst.de> <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com> <20210428061706.GC5084@lst.de> <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:38:24PM -0700, Linus Torvalds wrote:
> It's a purely informational message,

yes.

> and you guys made it pointlessly
> overcomplicated for absolutely zero reason, and now you're too
> embarrassed to just admit how pointless it was.

"you guys" here is purely me, so I take the blame.  And no, I actually
did have a first version usind %pD, tested it and looked at the output
and saw how it stripped the actual useful part of the path, that is the
first components.
