Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC79506D09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350888AbiDSNFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350880AbiDSNFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4D12377CD
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650373352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z4Kl7+froBrIWrE+d8xHFKl2dYlBi9s4KDLQMa5Aj80=;
        b=iQh/y4rcQ3YMTfISt7AIBhVv9jGVAwkQgBUAlSKzxb6aGAeZ2WnBAEMJm5TewYHoWKwgTK
        IS+NUb+LCFnNom5qZQzNrdGqDTeUVcsOw340gXzUnxdk3gBfsq7aSS9fk3tvrjZbgAF1VT
        /Eqbfk6dFBB9Bc3zmnTkag59z1neZWM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-Oknl4-evNKWoUlmRoWs0qQ-1; Tue, 19 Apr 2022 09:02:22 -0400
X-MC-Unique: Oknl4-evNKWoUlmRoWs0qQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95AF01014A64;
        Tue, 19 Apr 2022 13:02:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8FCD40146E;
        Tue, 19 Apr 2022 13:02:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <454833.1650373340.1@warthog.procyon.org.uk>
Date:   Tue, 19 Apr 2022 14:02:20 +0100
Message-ID: <454834.1650373340@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

> two weeks ago, I updated a cluster of web servers to Linux kernel
> 5.17.1 (5.16.x previously) which includes your rewrite of the fscache
> code.

I presume you are actually using a cache?

David

