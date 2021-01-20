Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9722FD532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391201AbhATQOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 11:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391294AbhATQNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611159135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AhIWTl05pJS4/0GkKJgH3b3lHz5MGot8lNIuSU5VF9Q=;
        b=FTt92ekuVaCgJqP+9SDuhTF1nuNUHHNkx9aXUqj2DxxPhh6s3hLRirqMVeufDoJSuX6sqB
        YPcR+15q7TSO3Twj90dKYrGAr+isNldHJXEJMJ73QJhDR+pWPktnCLGykGmJO1S3/VBXPV
        MGqPNIAjvAqSWWQCdb3Zjrha8EeMZ0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-QXANknRjO5KL1N-e8fVg8A-1; Wed, 20 Jan 2021 11:12:13 -0500
X-MC-Unique: QXANknRjO5KL1N-e8fVg8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B25EB806664;
        Wed, 20 Jan 2021 16:12:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4376310016FF;
        Wed, 20 Jan 2021 16:12:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201020075307.GA17780@infradead.org>
References: <20201020075307.GA17780@infradead.org> <160311941493.2265023.9116264838885193100.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Takashi Iwai <tiwai@suse.de>,
        dwysocha@redhat.com, linux-kernel@vger.kernel.org,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH] cachefiles: Drop superfluous readpages aops NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1175865.1611159129.1@warthog.procyon.org.uk>
Date:   Wed, 20 Jan 2021 16:12:09 +0000
Message-ID: <1175866.1611159129@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> what prevents us from killing of the last ->readpages instance?
> Leaving half-finished API conversions in the tree usually doesn't end
> well..

I never got around to making cachefiles actually use ->readpages, so that's
not an issue.

David

