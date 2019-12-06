Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC64B114DB1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 09:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLFIfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 03:35:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbfLFIfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575621333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPZy+V17MKteQvTO9+cmdtR7EFzYQSfyCwkrYE6HtDQ=;
        b=PdWnXlEFOFUAt/R5raSUUtqmvKxnWVhCrVKNU9T1OqupthqsQHEl8Jfr8UmyeePQGLz5Pt
        Qw3Y7A1btz7sAIx5NttksFs0sL4xxDjfCF+xJesIAsEQcYl9LcFD30zE8pZl2DTVnPz/Dd
        /od+8PrUidaUPf24rUutBcpWetnfHyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-23rVRtNFMvyLMhb_N0T65g-1; Fri, 06 Dec 2019 03:35:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE4EE107ACC9;
        Fri,  6 Dec 2019 08:35:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C479B5C1C3;
        Fri,  6 Dec 2019 08:35:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191121160725.GA19291@infradead.org>
References: <20191121160725.GA19291@infradead.org> <20191121081923.GA19366@infradead.org> <157432403818.17624.9300948341879954830.stgit@warthog.procyon.org.uk> <30992.1574327471@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, sfrench@samba.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cifs: Don't use iov_iter::type directly
MIME-Version: 1.0
Content-ID: <26835.1575621327.1@warthog.procyon.org.uk>
Date:   Fri, 06 Dec 2019 08:35:27 +0000
Message-ID: <26836.1575621327@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 23rVRtNFMvyLMhb_N0T65g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > However, all the code that is doing direct accesses using '&' has to
> > change to make that work - so I've converted it all to using accessors =
so
> > that I only have to change the header file, except that the patch to do
> > that crossed with a cifs patch that added more direct accesses, IIRC.
>=20
> But I still don't really see the point of the wrappers.  Maybe they are
> ok as a migration strategy, but in that case this patch mostly makes
> sense as part of the series only.

Can we at least push this patch?  All the other users have been converted t=
o
use the wrappers upstream, just not these because the patch adding them
crossed with the wrapper patch.  Then everything is consistent (unless more
unwrapped users got added in the merge window).

David

