Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0BB76A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 11:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfISJtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 05:49:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388872AbfISJtY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:49:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7466898104;
        Thu, 19 Sep 2019 09:49:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5535D5D9CC;
        Thu, 19 Sep 2019 09:49:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <28368.1568875207@warthog.procyon.org.uk>
References: <28368.1568875207@warthog.procyon.org.uk> <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com> <16147.1568632167@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL afs: Development for 5.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16256.1568886562.1@warthog.procyon.org.uk>
Date:   Thu, 19 Sep 2019 10:49:22 +0100
Message-ID: <16257.1568886562@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Thu, 19 Sep 2019 09:49:24 +0000 (UTC)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > However, I was close to unpulling it again. It has a merge commit with
> > this merge message:
> > 
> >     Merge remote-tracking branch 'net/master' into afs-next
> > 
> > and that simply is not acceptable.
> 
> Apologies - I meant to rebase that away.  There was a bug fix to rxrpc in
> net/master that didn't get pulled into your tree until Saturday.

Actually, waiting for all outstanding fixes to get merged and then rebasing
might not be the right thing here.  The problem is that there are fixes in
both trees: afs fixes go directly into yours whereas rxrpc fixes go via
networking and I would prefer to base my patches on both of them for testing
purposes.  What's the preferred method for dealing with that?  Base on a merge
of the lastest of those fixes in each tree?

David
