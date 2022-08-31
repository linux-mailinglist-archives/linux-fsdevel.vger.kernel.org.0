Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758205A7F48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 15:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiHaNwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHaNw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE1D59A9
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661953946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xm51xcub1wuRQLMM4F6btrUxwFJHZ9ruPTJ/iTp6tbc=;
        b=Jcfv5rwHAt1mRr+x2ZzEXfWy1cASx8KfdKB3ip1qv/JGmo2rc6nYHrABSpp57uoo7KGNe+
        SMVcGAJxdejoXQZffaO701SS00BWEzszCKZWcs2bcVTJiGY4SYsdK5Q7V7yBpJo0eZQQdk
        weB0GTTTJoM8qQr7NCZ9NlhMb+qp1bA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-vb5iahavMR6409xh4Jft7w-1; Wed, 31 Aug 2022 09:52:21 -0400
X-MC-Unique: vb5iahavMR6409xh4Jft7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C20561C20AEC;
        Wed, 31 Aug 2022 13:52:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B31BA2026D4C;
        Wed, 31 Aug 2022 13:52:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220826043706.GC2071@kadam>
References: <20220826043706.GC2071@kadam> <20220826023515.3437469-1-sunke32@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dhowells@redhat.com, Sun Ke <sunke32@huawei.com>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jefflexu@linux.alibaba.com, hsiangkao@linux.alibaba.com
Subject: Re: [PATCH v4] cachefiles: fix error return code in cachefiles_ondemand_copen()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1544478.1661953939.1@warthog.procyon.org.uk>
Date:   Wed, 31 Aug 2022 14:52:19 +0100
Message-ID: <1544479.1661953939@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Thanks!

Can I put that down as a Reviewed-by?

David

