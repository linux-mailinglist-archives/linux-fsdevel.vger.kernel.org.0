Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408E73702E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfFFJlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 05:41:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfFFJlI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:41:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AF2C2F8BFE;
        Thu,  6 Jun 2019 09:41:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A126A79401;
        Thu,  6 Jun 2019 09:41:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <655f9c53f809a727bcc087228efc1b5dc3ec1f2d.camel@netapp.com>
References: <655f9c53f809a727bcc087228efc1b5dc3ec1f2d.camel@netapp.com> <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk> <155862834550.26654.17230477291010963688.stgit@warthog.procyon.org.uk>
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>, steved@redhat.com
Cc:     dhowells@redhat.com,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/23] NFS: Add fs_context support.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17420.1559814062.1@warthog.procyon.org.uk>
Date:   Thu, 06 Jun 2019 10:41:02 +0100
Message-ID: <17421.1559814062@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 06 Jun 2019 09:41:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Schumaker, Anna <Anna.Schumaker@netapp.com> wrote:

> >  17 files changed, 1293 insertions(+), 1331 deletions(-)
> 
> Can you please split this patch up?

Um...  Al and I have split it up somewhat.  See the other 22 patches in the
series ;-)

Splitting it up further is going to be tricky because of the way stuff weaves
around all over the place in fs/nfs/.  I can have a go, but, for various
reasons, I'm not going to have time to look at that till after the next merge
window.  I don't know whether SteveD has a sufficiently empty plate to offload
that to him?

> The mailing list dropped it because it's over 100,000 characters
> (http://vger.kernel.org/majordomo-info.html#taboo) and I can't use the
> version you sent directly to me because Office365 / Evolution keeps
> converting tabs to spaces somewhere along the line.

Note also this bit in the cover letter:

	The patches can be found here also:

		https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

	on branch:

		mount-api-nfs

;-)

David
