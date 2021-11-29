Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B6461ACB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 16:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbhK2P3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 10:29:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242801AbhK2P1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638199431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aBlKyuUGApLu3DvwZ3/RfkSAkyCOYsE2fsPKSfHk0dM=;
        b=aH/mZDbcUXbkYXpnM0ysyMso6ek2ri40zNv1zCc65sNIdKlgF4ByoMbwpN060PQy536dHE
        692cshl+PeszXamJG1BoIUBOPkzI2yS7p+Ur00kOK4E4Pn1Pai1P6D/a53F0f7s6bouoB/
        YQyoI1VS/eBIj1GYO+ouikrU8Bq7DVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-kKLxsffzNIK16ZGtem_2dw-1; Mon, 29 Nov 2021 10:23:48 -0500
X-MC-Unique: kKLxsffzNIK16ZGtem_2dw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFAAA83DD22;
        Mon, 29 Nov 2021 15:23:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B3185DF4F;
        Mon, 29 Nov 2021 15:23:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2cfdbfd834bb6ff1f7f5cf47e3ea72449fe683b6.camel@redhat.com>
References: <2cfdbfd834bb6ff1f7f5cf47e3ea72449fe683b6.camel@redhat.com> <163706992597.3179783.18360472879717076435.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [Linux-cachefs] [PATCH] netfs: Adjust docs after foliation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <223019.1638199414.1@warthog.procyon.org.uk>
Date:   Mon, 29 Nov 2021 15:23:34 +0000
Message-ID: <223020.1638199414@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> > -/**
> > - * netfs_skip_folio_read - prep a folio for writing without reading first
> > +/*
> ...
> Not sure why you decided to change the last one not to be a kerneldoc
> comment, but OK. The rest of the changes look straightforward.

It's not part of the API.  It's only internal.  None of the other internal
functions are listed in the API reference.

David

