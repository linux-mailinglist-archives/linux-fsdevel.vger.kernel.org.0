Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB56125AFAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgIBPnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgIBPnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599061399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CB8EgsKBeg/IG+XVx0gas91UTIVj4YQl8q5goKB9lmk=;
        b=IfX4cDa7MseM77QLn16ovV+QYfFI9uqE5Dl5RO+oidNH6ekeTFE7wettWkKh4YeMwL9pWs
        dJxQMx9ZUIyzQVQoduZ/MjwofktQ7QcpTtrRYFdobpBwtTNlE3GpkZ12O4GKq+eh37SfSk
        CMcnL4mQJ0nBECHSqXqiluQ0X0+2RKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-9FDWcFLAPFC6PEPyevxQXA-1; Wed, 02 Sep 2020 11:42:52 -0400
X-MC-Unique: 9FDWcFLAPFC6PEPyevxQXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03527100855E;
        Wed,  2 Sep 2020 15:42:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3758672C0;
        Wed,  2 Sep 2020 15:42:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200901164545.GP14765@casper.infradead.org>
References: <20200901164545.GP14765@casper.infradead.org> <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk> <20200901164132.GD669796@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] mm: Make more use of readahead_control
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <663002.1599061368.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 02 Sep 2020 16:42:49 +0100
Message-ID: <663003.1599061369@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> He's done it on top of http://git.infradead.org/users/willy/pagecache.gi=
t

Sorry, yes, I should've mentioned that.

> I was hoping he'd include
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/c71de78732=
8809026cfabbcc5485cb01caca8646
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/f3a1cd6447=
e29a54b03efc2189d943f12ac1c9b9
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/c03d3a5a57=
16bb0df2fe15ec528bbd895cd18e6e
> =

> as the first three patches in the series; then it should apply to Linus'
> tree.

Did you want me to carry those patches and pass them to Linus through my
fscache branch?

David

