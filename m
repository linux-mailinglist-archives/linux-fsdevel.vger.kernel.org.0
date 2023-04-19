Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA16E7A2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjDSM6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjDSM6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AFEAD30
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681909064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gnR6bjG9bok7jCQk9F5NYnSJuEBp2LyQ4n6UhEpwshQ=;
        b=cEV1JmrekHhsA5Svemf9JcyeC+6m1dVBn3pg3FvFGK3SdDfYmyw6ZezNALgCzFh+yFTugw
        RztsjtJoccwhIV4DeTtFmjEvmh8nEpxk3td0zPdWwI+3cQRqreOSaTztPLZuWps9SfYzWC
        rgIFzX2CBwvqtb1WYtCwJ11GTmizQgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-Bku-NdbwN6yyVpmqR7UGLw-1; Wed, 19 Apr 2023 08:57:38 -0400
X-MC-Unique: Bku-NdbwN6yyVpmqR7UGLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E012185A78B;
        Wed, 19 Apr 2023 12:57:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D05861121314;
        Wed, 19 Apr 2023 12:57:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <168190833944.417103.14222689199936898089.b4-ty@kernel.dk>
References: <168190833944.417103.14222689199936898089.b4-ty@kernel.dk> <1770755.1681894451@warthog.procyon.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Ayush Jain <ayush.jain3@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice: Fix filemap of a blockdev
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1828925.1681909055.1@warthog.procyon.org.uk>
Date:   Wed, 19 Apr 2023 13:57:35 +0100
Message-ID: <1828932.1681909055@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> [1/1] splice: Fix filemap of a blockdev

Actually, would you be able to fix the subject?  I left a word out:

	splice: Fix filemap splice of a blockdev

or maybe:

	splice: Fix buffered splice of a blockdev

Sorry about that,
David

