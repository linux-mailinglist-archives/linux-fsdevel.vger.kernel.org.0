Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F90B7C38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390649AbfISOYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 10:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13527 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbfISOYF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:24:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64D0C18C4275;
        Thu, 19 Sep 2019 14:24:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B41FB60C18;
        Thu, 19 Sep 2019 14:24:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190919131537.GA15392@bombadil.infradead.org>
References: <20190919131537.GA15392@bombadil.infradead.org> <28368.1568875207@warthog.procyon.org.uk> <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com> <16147.1568632167@warthog.procyon.org.uk> <16257.1568886562@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
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
Content-ID: <8820.1568903040.1@warthog.procyon.org.uk>
Date:   Thu, 19 Sep 2019 15:24:00 +0100
Message-ID: <8821.1568903040@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 19 Sep 2019 14:24:05 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Why is it organised this way?  I mean, yes, technically, rxrpc is a
> generic layer-6 protocol that any blah blah blah, but in practice no
> other user has come up in the last 37 years, so why bother pretending
> one is going to?  Just git mv net/rxrpc fs/afs/ and merge everything
> through your tree.

Note that, unlike 9p, sunrpc and ceph, rxrpc is exposed as a network protocol
and can be used directly with socket(AF_RXRPC, ...).  I have part of a
userspace tool suite that uses this.

David
