Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1241F34CD2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhC2JiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 05:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231618AbhC2Jhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617010666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHvcErCvxADECOGTLJILP3/slpAOGbwKIYW1BequVWk=;
        b=apcABMKmxgchjg3eL/GuySIskuu74bfbyLxQe2IxBDsYFVfD+M5qvGpptAN+XOxmHuwnUJ
        FsjUeMts2NDUbP9Brn9cJNr9OpJXbdOuVExruS+seYwf139cr2/dvjJC/Yv/d9q2D2FEXN
        mvFy3lBlGNeco/IBbEeFUS5EQ9CoK2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-Oozk1BK0NYyeS1JpF52luw-1; Mon, 29 Mar 2021 05:37:42 -0400
X-MC-Unique: Oozk1BK0NYyeS1JpF52luw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 179D41009E3E;
        Mon, 29 Mar 2021 09:37:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5028260864;
        Mon, 29 Mar 2021 09:37:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com>
References: <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com> <20210327035019.GG1719932@casper.infradead.org> <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com> <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com> <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com> <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com> <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org> <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com> <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1720947.1617010659.1@warthog.procyon.org.uk>
Date:   Mon, 29 Mar 2021 10:37:39 +0100
Message-ID: <1720948.1617010659@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Marshall <hubcap@omnibond.com> wrote:

> Then I got rid of David's patches, I'm at
> generic Linux 5.12-rc4, and am no longer
> failing those tests.

Um - which patches?

David

