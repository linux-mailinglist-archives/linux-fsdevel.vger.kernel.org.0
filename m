Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784352D11B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 14:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgLGNVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 08:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgLGNVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607347228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUiOfk966dJJcf9pZKvx+8hjWQVZNkI78m5XaAH1pfQ=;
        b=OdsuD1kyFTl9Uz1LmvIdp2eZ2dhFXxnOGtzyWSfLHiW4tJIty0xAesOcHVlBwGGRItt61K
        t4YRpT+FSw8y0JTG1FUvUEjEYcGsla766FSjVAlRC0PBFbO71pbv8PlMQitvMGdBydW4Mi
        PEJacp7dbDrB43cCFgaSVQe8bP0KGNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-BN3x6tUpNwakD-FcVPDnfQ-1; Mon, 07 Dec 2020 08:20:25 -0500
X-MC-Unique: BN3x6tUpNwakD-FcVPDnfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7960858180;
        Mon,  7 Dec 2020 13:20:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32B0760CA3;
        Mon,  7 Dec 2020 13:20:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201207131037.GA3826@xsang-OptiPlex-9020>
References: <20201207131037.GA3826@xsang-OptiPlex-9020> <20201203064536.GE27350@xsang-OptiPlex-9020> <98294.1607082708@warthog.procyon.org.uk>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     dhowells@redhat.com, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [iov_iter] 9bd0e337c6: will-it-scale.per_process_ops -4.8% regression
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <478031.1607347219.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 07 Dec 2020 13:20:19 +0000
Message-ID: <478032.1607347219@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oliver Sang <oliver.sang@intel.com> wrote:

> > Out of interest, would it be possible for you to run this on the tail =
of the
> > series on the same hardware?
> =

> sorry for late. below is the result adding the tail of the series:
> * ded69a6991fe0 (linux-review/David-Howells/RFC-iov_iter-Switch-to-using=
-an-ops-table/20201121-222344) iov_iter: Remove iterate_all_kinds() and it=
erate_and_advance()

Thanks very much for doing that!

David

