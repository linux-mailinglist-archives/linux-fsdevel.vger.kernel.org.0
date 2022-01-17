Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18242490BF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 16:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiAQP5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 10:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235153AbiAQP5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642435072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlW7wziCR/iSWHom9gifGt8Wr9zVXy1LW82p3EUsHAw=;
        b=YJwwrKaJWkFiSUDkd2XPsA0622/gLYck+D9MjrxFP6d/qdHq9ki8WGB4RI7Y/Y2HU0PjlZ
        CusSKwtnnNOrKT3uxBuybAfLDAzy1s/0eXG14BLBHQ7PSQKijSLDcnIWlfl3TXHWkNFVhM
        7Pd2TwF9biArylSlLuheut8M0TvsOsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-ZVuekCvMPoSkuz0VL21--Q-1; Mon, 17 Jan 2022 10:57:49 -0500
X-MC-Unique: ZVuekCvMPoSkuz0VL21--Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 440F0100E337;
        Mon, 17 Jan 2022 15:57:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45B687BB67;
        Mon, 17 Jan 2022 15:57:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YeVzZZLcsX5Krcjh@casper.infradead.org>
References: <YeVzZZLcsX5Krcjh@casper.infradead.org> <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, ceph-devel@vger.kernel.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ceph: Uninline the data on a file opened for writing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2811245.1642435061.1@warthog.procyon.org.uk>
Date:   Mon, 17 Jan 2022 15:57:41 +0000
Message-ID: <2811246.1642435061@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> read_mapping_folio() does what you want, as long as you pass 'filp'
> as your 'void *data'.  I should fix that type ...

Ah, but *can* I pass file in at that point?  It's true that I have a file* -
but that's in the process of being set up.

David

