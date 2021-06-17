Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE993AB4E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhFQNjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 09:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhFQNjW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:39:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4FA560BD3;
        Thu, 17 Jun 2021 13:37:13 +0000 (UTC)
Date:   Thu, 17 Jun 2021 09:37:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
Message-ID: <20210617093712.25cfa707@gandalf.local.home>
In-Reply-To: <1192147.1623931489@warthog.procyon.org.uk>
References: <20210615115453.63bc3a63@oasis.local.home>
        <YLAXfvZ+rObEOdc/@localhost.localdomain>
        <643721.1623754699@warthog.procyon.org.uk>
        <1192147.1623931489@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Jun 2021 13:04:49 +0100
David Howells <dhowells@redhat.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Looks fine to me, and even saves 4 bytes on 64 bit machines (events are
> > rounded up to 4 byte increments, so the u16 is no different than a u32
> > here).  
> 
> Can I put that down as a Reviewed-by?

Sure. I was going to recommend consolidating the mappings a bit more to
have the enums and numbers defined in a single macro, but then I saw that
it matches the rest of the header file, and to do the consolidation would
require modifying the existing code, which I thought wasn't worth the
effort.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
