Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B328636E4F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 08:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhD2Gos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 02:44:48 -0400
Received: from verein.lst.de ([213.95.11.211]:51910 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2Gos (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:44:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E5A667357; Thu, 29 Apr 2021 08:43:59 +0200 (CEST)
Date:   Thu, 29 Apr 2021 08:43:58 +0200
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
Message-ID: <20210429064358.GA2788@lst.de>
References: <20210427025805.GD3122264@magnolia> <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com> <20210427195727.GA9661@lst.de> <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com> <20210428061706.GC5084@lst.de> <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com> <20210428064110.GA5883@lst.de> <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:14:42AM -0700, Linus Torvalds wrote:
> Of course, %pD has some other limitations too. It doesn't follow
> mount-points up. It's kind of intentionally a "for simple
> informational uses only", but good enough in practice exactly for
> things like debug printouts.

Which thinking about my testing is probably the real problem.  When
running xfstests the it only printed "swap" as the file name, as the
tests create it under the rest mount points.  Which really is of
not use.  While printing /fstests/scratch/swap actually is useful.

I suspect the s390 issue with the hardcoded "/dev/" prefix is somewhat
similar.
