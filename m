Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75D2E9F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbhADVLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 16:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbhADVLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 16:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609794587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw163ixfY01RT7kDYVefC/RgolkuqGtQaxoWbwe+jE8=;
        b=hZqM4ACtHwENXA1lXSV+vdzJS3H4cTq+2zU3TBC8vg1PFQvZ2oaBh5ftNQN+p1V+dyngi8
        MChr5x6KklFidzT45laiD2DFGfFPSDy/ugzirfGSlFTtCTP07zprrLHl/m8iMTT8hebGxI
        99Y09FzZR2c4wZ2dGK+iNmq9LnaI3GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-FjgFZH_-NgyExHCUth6J-g-1; Mon, 04 Jan 2021 16:09:45 -0500
X-MC-Unique: FjgFZH_-NgyExHCUth6J-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4985C281;
        Mon,  4 Jan 2021 21:09:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 495EF7086C;
        Mon,  4 Jan 2021 21:09:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjFom7xhs5SHcWi1toxrBDwmyhBmVmGOqn9e3g6+bf5sw@mail.gmail.com>
References: <CAHk-=wjFom7xhs5SHcWi1toxrBDwmyhBmVmGOqn9e3g6+bf5sw@mail.gmail.com> <365031.1608567254@warthog.procyon.org.uk> <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com> <257074.1609763562@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Daniel Axtens <dja@axtens.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <297267.1609794581.1@warthog.procyon.org.uk>
Date:   Mon, 04 Jan 2021 21:09:41 +0000
Message-ID: <297268.1609794581@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> array (or the overflow[] one) is actually used. But I assume you've
> tested this.
> 
> Do you want me to apply the patch as-is, or will I be getting a pull
> request with this (and the number-of-slots calculation thing you
> mention in the commit message)?

I can give you a pull req for them as a pair.  I don't know if Daniel wants to
comment on the first patch.

David

