Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9918C41C8F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbhI2QA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 12:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345524AbhI2P7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632931090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9QQVC3ObAKQWGkVakHBATBn/ed3/zk0MSyQjfvAbQY=;
        b=RmGk876D+FZSftJwmowNgF5HLvzNLGJ9n428ip0WBPShZ0LVenHSs5FwP96lommb+7Je5p
        Icjqm75UB8r3RfYUqym4GzD9gaF6quIBvjTwb2JOVo3fIGSOlu7mYj6QPXsDEMk/q7m+Co
        bj3BaTWhWpI/WYIVqPvPC5xfXTSJ+Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-zSJ6v7QbN42_3vJ6y17AMg-1; Wed, 29 Sep 2021 11:58:09 -0400
X-MC-Unique: zSJ6v7QbN42_3vJ6y17AMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E742362A7;
        Wed, 29 Sep 2021 15:58:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C82E45C25D;
        Wed, 29 Sep 2021 15:58:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <163292979744.4004896.11826056491597096493.stgit@warthog.procyon.org.uk>
References: <163292979744.4004896.11826056491597096493.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] afs: Fix data corruptor in page laundering
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4006399.1632931085.1@warthog.procyon.org.uk>
Date:   Wed, 29 Sep 2021 16:58:05 +0100
Message-ID: <4006400.1632931085@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmmm... for some reason stgit didn't use patch numbering.

David

