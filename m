Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699361CCDF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgEJUf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 16:35:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729365AbgEJUf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 16:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589142956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DSFlNYwfdCpOV/I7s5/Tc33w1643YGxcvEZSHoh8T7o=;
        b=SGbEDa3sEdDlG77g96bkiE5ApCm0NQ9dniCa7M1NIzRVnQCMmiqibqNlzQxmYcrzJGkEoA
        SD4zpsAsIYYziGnhuwv64t50l+HOZl7Hj3/cxGWp9Psbn6tElksqcv5k9UYP+FTheJi32y
        dVuPApVeCYEnrMslM5qtfa0+BZ6sc6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-K3k0KoFINIa8H5p22cqmrw-1; Sun, 10 May 2020 16:35:52 -0400
X-MC-Unique: K3k0KoFINIa8H5p22cqmrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68F19107ACCA;
        Sun, 10 May 2020 20:35:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C83C160DB4;
        Sun, 10 May 2020 20:35:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d4efead1d6dba67f5c862a8d00ca88dd3c45dd34.camel@hammerspace.com>
References: <d4efead1d6dba67f5c862a8d00ca88dd3c45dd34.camel@hammerspace.com> <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "cmaiolino@redhat.com" <cmaiolino@redhat.com>,
        "carmark.dlut@gmail.com" <carmark.dlut@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] cachefiles, nfs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1787829.1589142943.1@warthog.procyon.org.uk>
Date:   Sun, 10 May 2020 21:35:43 +0100
Message-ID: <1787830.1589142943@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> I can pull this branch, and send it together with the NFS client
> bugfixes for 5.7-rc5.

Thanks!

David

