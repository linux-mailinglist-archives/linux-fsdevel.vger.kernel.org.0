Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416194230D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhJETfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 15:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235424AbhJETfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633462405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIz24nBWGhxPvmnmxAPoU/I9s0e84WcoRyDehHE/D4A=;
        b=InZtW96Dn1uC1vRNSiJ6MltC8Gsl6LLdHqRNueqWRlHN5SzsDngz6noG8uTAktr7vuLcYT
        7IhGp2ACvjv55WHoXl4k6QZnK0Uhhn+Zq3bCscM4dQJndqJY6aH/xKJkpRJFHX0x40h05Q
        wvFq6AnrMx3P98DYA6puXHknz+Z+3Q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-6LoWTaDAM5aJsJ_9mdGUwg-1; Tue, 05 Oct 2021 15:33:21 -0400
X-MC-Unique: 6LoWTaDAM5aJsJ_9mdGUwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FD3A180831C;
        Tue,  5 Oct 2021 19:33:20 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6257560C9F;
        Tue,  5 Oct 2021 19:33:19 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ramji Jiyani <ramjiyani@google.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RESEND PATCH] aio: Add support for the POLLFREE
References: <20210928194509.4133465-1-ramjiyani@google.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 05 Oct 2021 15:35:10 -0400
In-Reply-To: <20210928194509.4133465-1-ramjiyani@google.com> (Ramji Jiyani's
        message of "Tue, 28 Sep 2021 19:45:08 +0000")
Message-ID: <x49ilybjmdt.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Ramji,

Thanks for the explanation of the use after free.  I went ahead and
ran the patch through the libaio test suite and it passed.

> -#define POLLFREE	(__force __poll_t)0x4000	/* currently only for epoll */
> +#define POLLFREE	((__force __poll_t)0x4000)

You added parenthesis, here, and I'm not sure if that's a necessary part
of this patch.

Other than that:

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

