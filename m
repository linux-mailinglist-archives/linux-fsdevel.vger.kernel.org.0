Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F22B2EF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKNR0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 12:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgKNR0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 12:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605374800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vmvw3RC1z3JypMyBUQwHH1jFpxF8GcrqbYNzcI9yyzg=;
        b=Dty2OqbGuEExPJ+mFQmkFgw3Bf2alD9bzGgawJwTlUHJjH/rmNi/SV13a3+Xo8TlgQdiJi
        5LnERB7gZRKZBpwUN//yei2ObYT50VYonv9O4v7x95TvMJzGO7WLmewzTe7VizBiLCkZ4j
        bLB9jueBOpfiWQTSZ4wc9IF6GeYHurs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-aXmcwjgUMuCuKVWgQ58lnQ-1; Sat, 14 Nov 2020 12:26:35 -0500
X-MC-Unique: aXmcwjgUMuCuKVWgQ58lnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 851B95700A;
        Sat, 14 Nov 2020 17:26:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9041D60C13;
        Sat, 14 Nov 2020 17:26:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <160537415141.3024088.7100009150583164795.stgit@warthog.procyon.org.uk>
References: <160537415141.3024088.7100009150583164795.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix afs_write_end() when called with copied == 0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3082893.1605374792.1@warthog.procyon.org.uk>
Date:   Sat, 14 Nov 2020 17:26:32 +0000
Message-ID: <3082894.1605374792@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops.  I forgot to compile it after picking it from a patch series.  There's
an uninitialised warning in it.

David

