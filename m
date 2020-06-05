Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F481EF9E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgFEOCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 10:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgFEOCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:02:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0C5C08C5C2;
        Fri,  5 Jun 2020 07:02:38 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jhCvV-003aum-2W; Fri, 05 Jun 2020 14:02:29 +0000
Date:   Fri, 5 Jun 2020 15:02:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] afs: Improvements for v5.8
Message-ID: <20200605140229.GI23230@ZenIV.linux.org.uk>
References: <2240660.1591289899@warthog.procyon.org.uk>
 <20200605135003.GH23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605135003.GH23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 02:50:03PM +0100, Al Viro wrote:
> On Thu, Jun 04, 2020 at 05:58:19PM +0100, David Howells wrote:
> > Hi Linus,
> > 
> > Is it too late to put in a pull request for AFS changes?  Apologies - I was
> > holding off and hoping that I could get Al to review the changes I made to
> > the core VFS change commit (first in the series) in response to his earlier
> > review comments.  I have an ack for the Ext4 changes made, though.  If you
> > would prefer it to be held off at this point, fair enough.
> > 
> > Note that the series also got rebased to -rc7 to remove the dependency on
> > fix patches that got merged through the net tree.
> 
> FWIW, I can live with fs/inode.c part in its current form

Which is to say,
ACKed-by: Al Viro <viro@zeniv.linux.org.uk> (fs/inode.c part)
I have not checked the AFS part of the series and AFAICS
ext4 one at least doesn't make things any worse there.
