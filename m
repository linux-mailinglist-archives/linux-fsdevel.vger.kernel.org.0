Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D735E77B8D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjHNMkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHNMkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0957E52
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692016778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCWjLWX0jYHGbLRrRgLrEnurGr/nDg65nKZxrsGK2PI=;
        b=htT+U4Ur8PVj/rgK/l8J8Phor2e4M1RiGiHPxJ2UmVcPIiVLXAbtsT1n2/YduYKszrXdDm
        LS5KqPqOmx0S879HkAm73U+I9v748GckzNbQqFZWdzq+y08yHpLGR4IPvRYVbzHTQUbx4P
        fYHoLLRpOdc+k7TPe3alfgLtQlIjcfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-9EnGxdHsMxyzxevp6CtnbQ-1; Mon, 14 Aug 2023 08:39:35 -0400
X-MC-Unique: 9EnGxdHsMxyzxevp6CtnbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5F36185A7A4;
        Mon, 14 Aug 2023 12:39:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CE1740C2063;
        Mon, 14 Aug 2023 12:39:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230814093534.18278-1-guozihua@huawei.com>
References: <20230814093534.18278-1-guozihua@huawei.com>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fscache: Remove duplicated include
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4000875.1692016773.1@warthog.procyon.org.uk>
Date:   Mon, 14 Aug 2023 13:39:33 +0100
Message-ID: <4000876.1692016773@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

GUO Zihua <guozihua@huawei.com> wrote:

> Remove duplicated include for linux/uio.h. Resolves checkincludes
> message.
> 
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

Acked-by: David Howells <dhowells@redhat.com>

