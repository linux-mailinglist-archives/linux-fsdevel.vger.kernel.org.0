Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4806A4435
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 15:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjB0OVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 09:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjB0OVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20953C152
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677507626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DDxsPwEJOPowwYBBWwdBor9P24542C4HOJnuIelrcxA=;
        b=gvzCuWeEBh2IEkCr4E1hFr7OhWwR7eVgTnuPURUkNf5CguEduR/jhK565b9xCcNOOs2egc
        4+pV2KvUZ0o0VzAk6On8Fc27hs3vYYsxHMjFGM3/N09GlzQ6Tw/npTXZGJSLSlzDpZHFg/
        B3fYY6mWNpr4pbAqD5gsmtMBTm3/ubE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-xicVSckyOnqOVKjyn87iwg-1; Mon, 27 Feb 2023 09:20:20 -0500
X-MC-Unique: xicVSckyOnqOVKjyn87iwg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 368FE1871D9F;
        Mon, 27 Feb 2023 14:20:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EA34492B0E;
        Mon, 27 Feb 2023 14:20:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y/y5rFX2koj2W6Wa@casper.infradead.org>
References: <Y/y5rFX2koj2W6Wa@casper.infradead.org> <20230202204428.3267832-5-willy@infradead.org> <20230202204428.3267832-1-willy@infradead.org> <2730679.1677505767@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] afs: Zero bytes after 'oldsize' if we're expanding the file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2733934.1677507617.1@warthog.procyon.org.uk>
Date:   Mon, 27 Feb 2023 14:20:17 +0000
Message-ID: <2733935.1677507617@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> I'll send a patch series with all of this; it doesn't seem terribly
> urgent.  Do you think there's a similar problem for AFS that Brian
> noted with the generic patch?

Do you have a link I can look at?

David

