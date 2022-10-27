Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71B260F89B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiJ0NKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 09:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiJ0NKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D753A57
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666876209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O59xZLkhVp9n6CE3WnFVuePBF6VXdtbIlYgcHesyaqQ=;
        b=JKE+iI2aTJ63U5LNTCt47RSMJJ4fXSTw7Dw4edj99QjymqbLV3YCEygop4zO7lb2WS6DV5
        sn+gbiPHTeiq9SPT0hP3LK9JCVxBohrEnbxt/ltaiFlbSkQlfELGhIIhi+5CVxeTATOgWN
        mfeKELc8yqyu8Nqoly3N0uGvz9aFF9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-oKhzdWgDNWelnqNvp0SiQg-1; Thu, 27 Oct 2022 09:10:06 -0400
X-MC-Unique: oKhzdWgDNWelnqNvp0SiQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE174857D0F;
        Thu, 27 Oct 2022 13:10:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C15A64221F;
        Thu, 27 Oct 2022 13:10:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221027083547.46933-6-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-6-jefflexu@linux.alibaba.com> <20221027083547.46933-1-jefflexu@linux.alibaba.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] fscache,netfs: rename netfs_cache_ops as fscache_ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306532.1666876204.1@warthog.procyon.org.uk>
Date:   Thu, 27 Oct 2022 14:10:04 +0100
Message-ID: <3306533.1666876204@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Rename netfs_cache_ops as fscache_ops to make raw fscache APIs more
> neutral independent on libnetfs.

This is intended to be cache-architecture independent, in case someone comes
along with a cache other than fscache they want to use.

David

