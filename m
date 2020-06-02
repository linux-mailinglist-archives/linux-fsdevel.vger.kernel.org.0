Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FD41EB28E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 02:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFBAJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 20:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFBAJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:09:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B5CC05BD43;
        Mon,  1 Jun 2020 17:09:49 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfuUz-001dqa-P2; Tue, 02 Jun 2020 00:09:45 +0000
Date:   Tue, 2 Jun 2020 01:09:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [git pull] vfs patches from Miklos
Message-ID: <20200602000945.GI23230@ZenIV.linux.org.uk>
References: <20200601184036.GH23230@ZenIV.linux.org.uk>
 <CAHk-=wjQ8vRE3jSby=KOejXORsL2qgQ2g=KQ=Y10NvVoVBFtxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQ8vRE3jSby=KOejXORsL2qgQ2g=KQ=Y10NvVoVBFtxQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:46:45PM -0700, Linus Torvalds wrote:
> On Mon, Jun 1, 2020 at 11:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Assorted patches from Miklos; an interesting part here is /proc/mounts
> > stuff...
> 
> You know, this could really have done with more of a real description, Al...

Umm...  Assorted VFS work:
	* faster /proc/*/mount* iterator - insert a cursor into the list
instead of rescan in event of any change
	* several mount options parser cleanups
	* statx patches, including the ability to report mnt_id on statx(2)
	* introduction of faccessat2(2)
	* utimensat(2) with AT_EMPTY_PATH
	* allow creating whiteouts (via mknod(2)) for non-root
	* an aio bugfix
That stuff is really all over the place - there are several groups of related
patches, but the above is about as far as it can be compacted...
