Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2742DEC05E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 10:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfKAJPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 05:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbfKAJPg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:15:36 -0400
Received: from localhost (unknown [84.241.195.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF252080F;
        Fri,  1 Nov 2019 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572599736;
        bh=dDSsvh/349/YsGRUcUEAZPUmQFj6QhYNPNtOxvWz+Ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOIRsTldvF2msS/hgSTcDFUYANptm0qqIXeVbeTbUPtNSdIhUlB7eIsIp3bkw8InD
         BIShOY6e8ugng2BPI3DjjsXm+1Ed2fYDOn9k80jb/bTtr1irA8uHATjMvnzcEz2j1N
         AXKwmWS+oUxgcnwxjACqF+keaJHWI+sPPZmRI6xc=
Date:   Fri, 1 Nov 2019 10:12:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, devel@driverdev.osuosl.org,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v17 0/1] staging: Add VirtualBox guest shared folder
 (vboxsf) support
Message-ID: <20191101091241.GA2734789@kroah.com>
References: <20191028111744.143863-1-hdegoede@redhat.com>
 <20191028113950.GA2406@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028113950.GA2406@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 04:39:50AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 28, 2019 at 12:17:43PM +0100, Hans de Goede wrote:
> > Hi Greg,
> > 
> > As discussed previously can you please take vboxsf upstream through
> > drivers/staging?
> > 
> > It has seen many revisions on the fsdevel list, but it seems that the
> > fsdevel people are to busy to pick it up.
> > 
> > Previous versions of this patch have been reviewed by Al Viro, David Howells
> > and Christoph Hellwig (all in the Cc) and I believe that the current
> > version addresses all their review remarks.
> 
> Please just send it to Linus directly.  This is the equivalent of
> consumer hardware enablement and it is in a state as clean as it gets
> for the rather messed up protocol.

Ok, I've merged this to my -linus staging tree and will push it to Linus
in a few days, thanks.

greg k-h
