Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7253A9830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhFPK45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232030AbhFPK44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623840890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+PwrPHBq3pTuKKG3BfQq6KS6b3Dt4OWtFDFB1BsQlc=;
        b=PtqN3w19Y7IJKAhcCFADi2iF0fwYgk3nbkwReNxi3cg3f8ROfJg95AGUCdoJXs2OuYGh1W
        0ZOX0NESySH4tkOgl0MLR09p5ZD0vOjKVGpoIhVgrgkoDlVPia9nE3nwosSPaDbSE+pZc+
        XvNtqRtHLcpUQ8pcn/KNPKpZhe83d/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-YElwmKJ8Oa-h0YlclpZSjQ-1; Wed, 16 Jun 2021 06:54:49 -0400
X-MC-Unique: YElwmKJ8Oa-h0YlclpZSjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A9121015C84;
        Wed, 16 Jun 2021 10:54:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5F8B1002F12;
        Wed, 16 Jun 2021 10:54:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/33] Memory folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <817591.1623840884.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:54:44 +0100
Message-ID: <817592.1623840884@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some reason I didn't receive patches 3, 12, 17, 20, 23, 25, 29 and 31.

You can add my Reviewed-by to 3, 6, 12, 17, 20, 25, 29 and 31.

With patch 23, should __folio_lock_or_retry() return a bool?  (Same for
__lock_page_or_retry()).  Looks good apart from that.

David

