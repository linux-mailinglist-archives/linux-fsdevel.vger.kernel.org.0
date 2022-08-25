Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A298B5A13B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbiHYOep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiHYOen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ECE9DB7B
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJbbl+qsedWyVL78f0/Vs2C5+wGfE45Nz9agBFaUNaA=;
        b=WeY2+ifhoBDZWPugcjLqRZ2xwUWxPEccKVavvUP1KYvNnX6eozg4VPd1Ukqjl+JtkPQ85S
        YH3E2T/FVCjXY9XS0kZNTV71Yz9fSmer8ZsgZ12srSApjYpmZVoeyVm0KaGG741jYBqFxp
        kK1XwPR5ceXXEllHgYeRlADH8NaMk2g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-Ss6fJDMtMgaSWLxJJ-N_-Q-1; Thu, 25 Aug 2022 10:34:38 -0400
X-MC-Unique: Ss6fJDMtMgaSWLxJJ-N_-Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9848E3C138A3;
        Thu, 25 Aug 2022 14:34:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3529403349;
        Thu, 25 Aug 2022 14:34:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAK896s4uuU=K5Gau9J79GK_pWQuihyfXUoZCq0iFbWt9fHLudQ@mail.gmail.com>
References: <CAK896s4uuU=K5Gau9J79GK_pWQuihyfXUoZCq0iFbWt9fHLudQ@mail.gmail.com> <20220817065200.11543-1-yinxin.x@bytedance.com> <3713582.1661336736@warthog.procyon.org.uk>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, Yongqing Li <liyongqing@bytedance.com>
Subject: Re: [External] Re: [PATCH] cachefiles: make on-demand request distribution fairer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3791692.1661438076.1@warthog.procyon.org.uk>
Date:   Thu, 25 Aug 2022 15:34:36 +0100
Message-ID: <3791693.1661438076@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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

> > Can you give me a Fixes: line please?
> >
> Sure , I will send a V2 patch and add the Fixes line.

Just giving me a Fixes line would do.  I can insert it.

David

