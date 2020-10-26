Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31116298FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782123AbgJZOvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1782094AbgJZOvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603723873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0BF60IbUloszIPNvTCRfHWqbaPnuvkkUkdJOMYu+iZY=;
        b=bZ122neBucZFvj6WUBKm6zj7+4rHBV1JLNTVwqzZEuCJLv8N6Z+180dfLtCtUfQ+/HNXMO
        AkD+Akzd7LnY7DvKl0MfkIF3xPpeo9s/agJOSP4B/pAnvr0BP9yYrACmx6VyyjK91P2am5
        X/QoppDbw30caqunrAtTZ7aL0DlfErg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-04C20Y1nOCaT15yv_t-25A-1; Mon, 26 Oct 2020 10:51:11 -0400
X-MC-Unique: 04C20Y1nOCaT15yv_t-25A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44655192CC47;
        Mon, 26 Oct 2020 14:51:09 +0000 (UTC)
Received: from ovpn-113-173.rdu2.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7FCA10013D9;
        Mon, 26 Oct 2020 14:51:07 +0000 (UTC)
Message-ID: <fe6f9dae03f65fb4f35330556a43112a38b6b6d6.camel@redhat.com>
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
From:   Qian Cai <cai@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 26 Oct 2020 10:51:07 -0400
In-Reply-To: <d06d3d2a-7032-91da-35fa-a9dee4440a14@kernel.dk>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
         <20201022004906.GQ20115@casper.infradead.org>
         <20201026094948.GA29758@quack2.suse.cz>
         <20201026131353.GP20115@casper.infradead.org>
         <d06d3d2a-7032-91da-35fa-a9dee4440a14@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-10-26 at 07:55 -0600, Jens Axboe wrote:
> I've tried to reproduce this as well, to no avail. Qian, could you perhaps
> detail the setup? What kind of storage, kernel config, compiler, etc.

This should work:

https://gitlab.com/cailca/linux-mm/-/blob/master/x86.config

