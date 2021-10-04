Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3FC420925
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhJDKPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 06:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229760AbhJDKPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633342393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uCf9+2XTU54Gj/OtnQlqxxYbAga8gRYYuCZmIxMpfzQ=;
        b=TU2G2PxL3WP84wwxT9n2nRmoygrlBiwsQS7Q4oYpgH7sRwxDsiOt6n03aYkav4ZkCpmcR5
        ZRO2MfdgJeytX3l8W6z54e1zDPVljQ3vG5SI4cLUdgU2mRqDcg6LVX7armjkM0LH8MWG8L
        Ca1qg0aqRNm9z8GvkM88170T63oddhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-jdCcP78sMda25iVAq9LBIg-1; Mon, 04 Oct 2021 06:13:12 -0400
X-MC-Unique: jdCcP78sMda25iVAq9LBIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90A531006AA3;
        Mon,  4 Oct 2021 10:13:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FC5E5C1BB;
        Mon,  4 Oct 2021 10:13:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Do you want warning quashing patches at this point in the cycle?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <270323.1633342386.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 04 Oct 2021 11:13:06 +0100
Message-ID: <270324.1633342386@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Do you want patches that quash warnings from W=3D1 (mostly kerneldoc warni=
ngs in
comments in this case[1]) at this point in the cycle, or would you rather =
they
waited till the next merge window?

David

[1] https://lore.kernel.org/r/163281899704.2790286.9177774252843775348.stg=
it@warthog.procyon.org.uk/

