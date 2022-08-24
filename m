Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD61759F7A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiHXK1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 06:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbiHXK0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9180F7C
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661336743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/3NPQIEnyZaF2bh0a3xd0SHO0DWyl4paf/M4BxNDwc=;
        b=dgHF4JbdscA9KYK7iXsPbo3ebiTXA4fWNh2gqaIKBJFQfaaROVo9+vplrWSDYSwNOd8bRk
        +wQ2eEQcSYH/mzqqWUWYZDgTPTInqgfXw28JPYTtiKV4POkojNE6S/vaWGpFum6tSv1ukV
        1mcimW/gw29CdqDSLXrt0FaJ+T97+Po=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-WRRx6bIUPpKQquaMb0zXYA-1; Wed, 24 Aug 2022 06:25:38 -0400
X-MC-Unique: WRRx6bIUPpKQquaMb0zXYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35F9F101AA45;
        Wed, 24 Aug 2022 10:25:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4591E1410DD7;
        Wed, 24 Aug 2022 10:25:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220817065200.11543-1-yinxin.x@bytedance.com>
References: <20220817065200.11543-1-yinxin.x@bytedance.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, Yongqing Li <liyongqing@bytedance.com>
Subject: Re: [PATCH] cachefiles: make on-demand request distribution fairer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3713581.1661336736.1@warthog.procyon.org.uk>
Date:   Wed, 24 Aug 2022 11:25:36 +0100
Message-ID: <3713582.1661336736@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xin Yin <yinxin.x@bytedance.com> wrote:

> Reported-by: Yongqing Li <liyongqing@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

Can you give me a Fixes: line please?

David

