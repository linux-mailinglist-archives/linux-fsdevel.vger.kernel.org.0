Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E10236A597
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 09:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhDYHug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 03:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhDYHug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619336996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Im4R7SZHjo22hPEh3n8+YlircfIMQ1gHe/V7o9XQRXw=;
        b=AGILV2W8TLniokq/RYWAP8mm4nlnZbKQhNBPwgpPrBdYUMzreJqiyrSMbNaTXBYjXPkeHJ
        uSkwQ5m9WIha5d5ayLV/Nu+yrsdRhYmLDzdDwXlEmjDTd5Ili24TIFMy9BqTVFugFFw9Np
        /y9t+2SpJdM3iYDbMsVQS4GLaKKLAgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-hCefhymWP_6ERB9w6VsZvw-1; Sun, 25 Apr 2021 03:49:54 -0400
X-MC-Unique: hCefhymWP_6ERB9w6VsZvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625F58189C8;
        Sun, 25 Apr 2021 07:49:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9138019C46;
        Sun, 25 Apr 2021 07:49:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSTwNKPdRMwr_F87YCeUyxT775pBd5WcewGpcwSZFVz5=w@mail.gmail.com>
References: <CAOg9mSTwNKPdRMwr_F87YCeUyxT775pBd5WcewGpcwSZFVz5=w@mail.gmail.com> <20210327035019.GG1719932@casper.infradead.org> <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com> <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com> <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com> <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com> <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org> <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com> <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com> <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com> <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com> <1268214.1618326494@warthog.procyon.org.uk
 > <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com> <1612829.1618587694@warthog.procyon.org.uk>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3365452.1619336991.1@warthog.procyon.org.uk>
Date:   Sun, 25 Apr 2021 08:49:51 +0100
Message-ID: <3365453.1619336991@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Marshall <hubcap@omnibond.com> wrote:

> >> I wonder if you should use iov_length(&iter)
> 
> iov_length has two arguments. The first one would maybe be iter.iov and
> the second one would be... ?

Sorry, I meant iov_iter_count(&iter).

I'll look at the other things next week.  Is it easy to set up an orangefs
client and server?

David

