Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2149E71E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbiA0QJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238426AbiA0QJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643299792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7WoybKu6jP1QrYEjNppjV5tqvzvxfK13MZO3ivIjeOQ=;
        b=XYwqxcJ0yR2ggVC0XNud5/hESxiUARAEwHbTXOIQDzhpWQMP76RMCtWaG384bM4VmWBIPm
        7fk/7TCOUnUyqmfwfTKJePFbVFti1oO2mHCX5Ug1h+KFJrYiRn3A+Dm1NM1WAHKq2WcTHm
        uKqbvbnzergu2g7uz224bvNK2UqilQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-4-5cPEDoPbGB8a8bgOKtgA-1; Thu, 27 Jan 2022 11:09:49 -0500
X-MC-Unique: 4-5cPEDoPbGB8a8bgOKtgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA651835BD2;
        Thu, 27 Jan 2022 16:09:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0F4A798B9;
        Thu, 27 Jan 2022 16:09:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
References: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] cifs: Use fscache I/O again after the rewrite disabled it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <855752.1643299784.1@warthog.procyon.org.uk>
Date:   Thu, 27 Jan 2022 16:09:44 +0000
Message-ID: <855753.1643299784@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  (4) Make ->readahead() call

 (4) Make cifs_readahead() call into the cache to query if and where is has
     data available, and if it has, read data from it.

David

