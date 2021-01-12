Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AFC2F2F2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 13:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbhALMfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 07:35:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbhALMfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610454830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHlM+T4WurqYpUdDKiZ8LkMAd+Vm+HmVpW3FZP0eNx0=;
        b=Qaw29JoNzY5fli7cdmYjriw5XmIRpxuxKBZsmviFZbyvCWymsDD0V0c46wJD2EeVSist/7
        W9ovdFuPrU5415F1wC/rAhfnrOk3sHd//qi04r9elSryfuOYWmoFU+ZUVo7qh8/+kJ7KZ4
        R8IT6cxb8fYNqfBol382dKHr8Mr4JGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-W086FQGlOdO002X_Jqy7FA-1; Tue, 12 Jan 2021 07:33:48 -0500
X-MC-Unique: W086FQGlOdO002X_Jqy7FA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99715107ACF7;
        Tue, 12 Jan 2021 12:33:46 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-114-67.ams2.redhat.com [10.36.114.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F1B95C1B4;
        Tue, 12 Jan 2021 12:33:45 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mtk.manpages@gmail.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH manpages] epoll_wait.2: add epoll_pwait2
References: <20210112004820.4013953-1-willemdebruijn.kernel@gmail.com>
Date:   Tue, 12 Jan 2021 13:33:43 +0100
In-Reply-To: <20210112004820.4013953-1-willemdebruijn.kernel@gmail.com>
        (Willem de Bruijn's message of "Mon, 11 Jan 2021 19:48:20 -0500")
Message-ID: <87turmibbs.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Willem de Bruijn:

> From: Willem de Bruijn <willemb@google.com>
>
> Expand the epoll_wait page with epoll_pwait2, an epoll_wait variant
> that takes a struct timespec to enable nanosecond resolution timeout.
>
>     int epoll_pwait2(int fd, struct epoll_event *events,
>                      int maxevents,
>                      const struct timespec *timeout,
>                      const sigset_t *sigset);

Does it really use struct timespec?  With 32-bit times on most 32-bit
targets?

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

