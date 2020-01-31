Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF08514E963
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 09:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgAaIEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 03:04:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26246 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728077AbgAaIEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580457880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqxBP0u9MyUGNYA0T46ZpRaJAvhjzHm/yrssVAOj7S0=;
        b=G3ikPaP114+WfowA/W7uecs74vUrln8kCGcFzbW9U0dxbN13r4/CIxpj3EF2bmbDIFftju
        E/Q3w38VxXfDAz3+V/SMAWU0YgwOslg433ldjrJMXV1N8kRBYPvpoSqaCaE5gNYhcrxBBg
        gcE3ApLrWh4ZR7mT7gArQro1ALcqmZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-AUGLICTTN2ClQBV031KvlQ-1; Fri, 31 Jan 2020 03:04:35 -0500
X-MC-Unique: AUGLICTTN2ClQBV031KvlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4667F1937FFA;
        Fri, 31 Jan 2020 08:04:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-197.rdu2.redhat.com [10.10.120.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 352A887B15;
        Fri, 31 Jan 2020 08:04:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200131053150.GB17457@lst.de>
References: <20200131053150.GB17457@lst.de> <20200117222212.GP8904@ZenIV.linux.org.uk> <20200117235444.GC295250@vader> <20200118004738.GQ8904@ZenIV.linux.org.uk> <20200118011734.GD295250@vader> <20200118022032.GR8904@ZenIV.linux.org.uk> <20200121230521.GA394361@vader> <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com> <20200122221003.GB394361@vader> <20200123034745.GI23230@ZenIV.linux.org.uk> <2173869.1580222138@warthog.procyon.org.uk>
To:     "hch@lst.de" <hch@lst.de>
Cc:     dhowells@redhat.com, Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3773160.1580457868.1@warthog.procyon.org.uk>
Date:   Fri, 31 Jan 2020 08:04:28 +0000
Message-ID: <3773161.1580457868@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hch@lst.de <hch@lst.de> wrote:

> > I'm using direct I/O, so I'm assuming I don't need to fsync().
> 
> Direct I/O of course requires fsync.  What makes you think different?

I guess that's fair.  Even if the data makes it directly to storage, that's
not a guarantee that the metadata does.

David

