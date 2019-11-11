Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36561F725A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKKjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 05:39:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbfKKKjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573468740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtJ5pv77U2r0G6ksqsSYckeZ6pvSP6wLt/Y5uCN51BI=;
        b=gX6VKX1YGSQBI/P7OkvrH8I9iedPzu5Owoj68/TimgZxIogBVL9lB2mlcILm37mLI6OhY+
        KBmGypspQcRqNqkEA1sxK+Ou2e7bfAKgBjIY/vq6QCMsHGvS57gKZYwMrT/rDLOp6gb99k
        Xc5zsiEjM+MsvqWYLt86/mwuxguMlvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-S1iNAS8jNHuFSYbreh69fQ-1; Mon, 11 Nov 2019 05:38:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D4F5107ACC4;
        Mon, 11 Nov 2019 10:38:55 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5C755D6A3;
        Mon, 11 Nov 2019 10:38:54 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id C14C94BB5C;
        Mon, 11 Nov 2019 10:38:54 +0000 (UTC)
Date:   Mon, 11 Nov 2019 05:38:54 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LTP List <ltp@lists.linux.it>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, chrubis <chrubis@suse.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Message-ID: <1757087132.11450258.1573468734360.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191111083815.GA29540@infradead.org>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com> <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com> <20191111012614.GC6235@magnolia> <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com> <20191111083815.GA29540@infradead.org>
Subject: Re: LTP: diotest4.c:476: read to read-only space. returns 0:
 Success
MIME-Version: 1.0
X-Originating-IP: [10.43.17.163, 10.4.195.18]
Thread-Topic: diotest4.c:476: read to read-only space. returns 0: Success
Thread-Index: 910IB+66jrM2sMmDpKAiK7gJA7sQsg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: S1iNAS8jNHuFSYbreh69fQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


----- Original Message -----
> Is this a new test?

No, it's not new.

> If not why was this never reported?  Sounds like
> we should add this test case to xfstests.

I'm guessing not that many users still run 32bit kernels.
Naresh' setup is using ext4, so I assume he noticed only
after recent changes in linux-next wrt. directio and ext4.

Regards,
Jan

