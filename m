Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07F1FBBE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgFPQip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 12:38:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729051AbgFPQip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592325524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSJotguBdFBYyK+pUl65kbk275Ty1BxEdcqfPDRs84Q=;
        b=hFN1OJ64y1WzvU+aIIUycdGarWDTdFXRyIND/Noh0rls/uY64GgLt8ZTxPE/ZnOIRyaSbO
        uadAk03kqcA5/awG3oXqE13nRzHZcb0UhT9QVPlDNOjp01GlQBF/YAV+gWnDme5C+FC5r6
        ea50tyOSyt9DTaxotPlUUKscXgW8cdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-WI0dNr14MHqcv6gMogQ6Qg-1; Tue, 16 Jun 2020 12:38:41 -0400
X-MC-Unique: WI0dNr14MHqcv6gMogQ6Qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A045D80F5C6;
        Tue, 16 Jun 2020 16:38:40 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 983E55D9D3;
        Tue, 16 Jun 2020 16:38:40 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8B7171809543;
        Tue, 16 Jun 2020 16:38:40 +0000 (UTC)
Date:   Tue, 16 Jun 2020 12:38:38 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <700590041.34131118.1592325518407.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200616162539.GN11245@magnolia>
References: <20200615160244.741244-1-agruenba@redhat.com> <20200615233239.GY2040@dread.disaster.area> <20200615234437.GX8681@bombadil.infradead.org> <20200616003903.GC2005@dread.disaster.area> <315900873.34076732.1592309848873.JavaMail.zimbra@redhat.com> <20200616132318.GZ8681@bombadil.infradead.org> <CAHc6FU7uU8rUMdkspqH+Zv_O5zi2eEyOYF4x4Je-eCNeM+7NHA@mail.gmail.com> <20200616162539.GN11245@magnolia>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.115.80, 10.4.195.18]
Thread-Topic: iomap: Make sure iomap_end is called after iomap_begin
Thread-Index: wS7oU/E1DznEWp9eUWGUUSaaHTVcaA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> So... you found this through code inspection, and not because you
> actually hit this on gfs2, or any of the other iomap users?
> 
> I generally think this looks ok, but I want to know if I should be
> looking deeper. :)
> 
> --D

Correct. Code-inspection only. I never actually hit the problem.
If those errors are really so unusual and catastrophic, perhaps
we should just change them to BUG_ONs or something instead.
Why bother unlocking if we're already 1.9 meters underground?

Bob Peterson

