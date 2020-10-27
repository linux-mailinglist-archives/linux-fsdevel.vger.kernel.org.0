Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0D29A9DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 11:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898626AbgJ0KkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 06:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2898503AbgJ0Ki0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603795106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CCFkL5YPwZhrmFegn8R+P6Gr+wPqzLjyH+PKfuNRXxY=;
        b=aGg/qZd8duSzJ8OcvoNw9Pe8uHtg0UkMqhfqlNKadThrMW/Xl47mv4n1v7qTICY8EzCy7K
        oU+FlTBepRju3oi+XjSjGFzSeeG7THct00U582f2cMAS8XvHUGhIU4vKEs09INKnsP7+61
        T5r8kcwwuya+dmQPUCvQWeYPDeg9M9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-Tghq4TRVMxClG5BzL4_sXw-1; Tue, 27 Oct 2020 06:38:22 -0400
X-MC-Unique: Tghq4TRVMxClG5BzL4_sXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB843100F967;
        Tue, 27 Oct 2020 10:38:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD8176EF57;
        Tue, 27 Oct 2020 10:38:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201027095455.GA30298@lst.de>
References: <20201027095455.GA30298@lst.de> <3088368.1603790984@warthog.procyon.org.uk> <20200827150030.282762-3-hch@lst.de> <20200827150030.282762-1-hch@lst.de> <3155818.1603792294@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/10] fs: don't allow splice read/write without explicit ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3161302.1603795098.1@warthog.procyon.org.uk>
Date:   Tue, 27 Oct 2020 10:38:18 +0000
Message-ID: <3161303.1603795098@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> > That said, for afs at least, the fix seems to be just this:
> 
> And that is the correct fix, I was about to send it to you.

Thanks.

David

