Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD90A2CED82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgLDLxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 06:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728582AbgLDLxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607082718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6DMcyImwNW8/yN8tZ5x35hfAGMlLSWgGVlroAI+zwE=;
        b=g6fp3hP4ZtzlYeImnBfqgIC3JLu0ihB3+n9l8GRpubyx4pvqs9fbMim0GzUM925ssp5NED
        us6bPcpMXNfi0qp6W5xhaynSkWmlDkGqugFCnB/AzoDsi6QuetF/4sVZrEXK2S4JNMGylT
        04/igAK+S7lozz8GxlkamJQBfP/S5lI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-leC3jpfvOhWjVCqCD3DNVA-1; Fri, 04 Dec 2020 06:51:54 -0500
X-MC-Unique: leC3jpfvOhWjVCqCD3DNVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2558618C8C00;
        Fri,  4 Dec 2020 11:51:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A484210016F5;
        Fri,  4 Dec 2020 11:51:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201203064536.GE27350@xsang-OptiPlex-9020>
References: <20201203064536.GE27350@xsang-OptiPlex-9020>
To:     kernel test robot <oliver.sang@intel.com>
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
Content-ID: <98293.1607082708.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 04 Dec 2020 11:51:48 +0000
Message-ID: <98294.1607082708@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel test robot <oliver.sang@intel.com> wrote:

> FYI, we noticed a -4.8% regression of will-it-scale.per_process_ops due =
to commit:
> =

> =

> commit: 9bd0e337c633aed3e8ec3c7397b7ae0b8436f163 ("[PATCH 01/29] iov_ite=
r: Switch to using a table of operations")

Out of interest, would it be possible for you to run this on the tail of t=
he
series on the same hardware?

Thanks,
David

