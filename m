Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15021165D70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 13:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBTMWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 07:22:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39327 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727705AbgBTMWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582201335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sgne7vEZYUlNT6R014gNlgb5JFShF1C38DgPIAIxt3w=;
        b=U0EHMboB7HuOiwK4jZyeXjeFuWyuEgBnuwADpJwzSZQ9fEKOt7+dyZBKq76QzkWlTHS4xw
        WdMDDja8imMuqDIQ8kHzAIBum1cMavm16ZtP1WSMR+S5/RghGxZJoQDA3cjN/ZU4/mCjDV
        v8QcYg/LGBmx1t6Tzw2lFT4UODHaH4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-rleZgANVOiu2qcgllCao9w-1; Thu, 20 Feb 2020 07:22:13 -0500
X-MC-Unique: rleZgANVOiu2qcgllCao9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE29318C35A1;
        Thu, 20 Feb 2020 12:22:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF5E819C4F;
        Thu, 20 Feb 2020 12:22:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200219163705.GC9496@magnolia>
References: <20200219163705.GC9496@magnolia> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204552063.3299825.17824500635078230412.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/19] fsinfo: Provide a bitmap of supported features [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <596566.1582201328.1@warthog.procyon.org.uk>
Date:   Thu, 20 Feb 2020 12:22:08 +0000
Message-ID: <596567.1582201328@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> > +struct fsinfo_features {
> > +	__u8	features[(FSINFO_FEAT__NR + 7) / 8];
> 
> Hm...the structure size is pretty small (56 bytes) and will expand as we
> add new _FEAT flags.  Is this ok because the fsinfo code will truncate
> its response to userspace to whatever buffer size userspace tells it?

Yes.  Also, you can ask fsinfo how many feature bits it supports.

I should put this in the struct first rather than putting it elsewhere.

David

