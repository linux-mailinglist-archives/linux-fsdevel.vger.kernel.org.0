Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB8336D21E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 08:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhD1GRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 02:17:54 -0400
Received: from verein.lst.de ([213.95.11.211]:47975 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhD1GRx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:17:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7252F68B05; Wed, 28 Apr 2021 08:17:06 +0200 (CEST)
Date:   Wed, 28 Apr 2021 08:17:06 +0200
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
Message-ID: <20210428061706.GC5084@lst.de>
References: <20210427025805.GD3122264@magnolia> <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com> <20210427195727.GA9661@lst.de> <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:05:13PM -0700, Linus Torvalds wrote:
> So how many _would_ be enough? IOW, what would make %pD work better
> for this case?

Preferably all.

> Why are the xfstest messages so magically different from real cases
> that they'd need to be separately distinguished, and that can't be
> done with just the final path component?
> 
> If you think the message is somehow unique and the path is something
> secure and identifiable, you're very confused. file_path() is in no
> way more "secure" than using %pD4 would be, since if there's some
> actual bad actor they can put newlines etc in the pathname, they can
> do chroot() etc to make the path look anything they like.

Nothing needs to be secure.  It just needs to not scare users because
they can see that the first usually two components clearly identify
this is the test file system.
