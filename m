Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7CF6E0122
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDLVqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDLVqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4C85241
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681335946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ilGBHufiMuaxBpgsvUmfNQz6PArJGM0NKDutiuuFlQ=;
        b=VjerENfEFFyhNv6Rs8FB2fhZlfFriasdxfy5tkmDSZjLYlDUe6idhedAPyB5zf/NigtUdw
        ST6kLG/JXcv+RmTA9p0zRExgmUFDPMCAyK5lKj3a+Apfxy2/oR7SkwG9YX8amkcpGRnnV+
        jRY618CZCoTgTw2SSHABvu17TSAa8dU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-Xgs_wkh3NcKNsJv-O4nu6Q-1; Wed, 12 Apr 2023 17:45:44 -0400
X-MC-Unique: Xgs_wkh3NcKNsJv-O4nu6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 784D43C10EC1;
        Wed, 12 Apr 2023 21:45:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6BC61121320;
        Wed, 12 Apr 2023 21:45:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230403142543.1913749-3-hch@lst.de>
References: <20230403142543.1913749-3-hch@lst.de> <20230403142543.1913749-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] iov_iter: remove iov_iter_get_pages_alloc
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <394965.1681335943.1@warthog.procyon.org.uk>
Date:   Wed, 12 Apr 2023 22:45:43 +0100
Message-ID: <394966.1681335943@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> -EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
> +EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc2);

This is not within the description of the patch and should probably be a
separate patch.

David

