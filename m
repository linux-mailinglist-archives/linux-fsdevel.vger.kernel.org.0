Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B823A67F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhFNNf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 09:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233589AbhFNNf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623677634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJ181kjLrZlfCW+M6blAkWvz5Hz7Ug2IkqhD/vilICM=;
        b=RRNRpFepwyTxKrvZveH78VcawZXMiecU+VGt7efU7ME9p6X3Nh7HvzYSTgoZxn6oa2IlDe
        k+6ZyFoU0deSXWL9REHcxs0XB+LOLsR2RkLTPTRPDqulbzY4g4+7mcvAxxtAqYG2O2upgf
        dbwCqQNNS4UWWF9iG2l4quprGe+fS00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-sjqxyUcoO3Wp7_3Fs6RSCw-1; Mon, 14 Jun 2021 09:33:52 -0400
X-MC-Unique: sjqxyUcoO3Wp7_3Fs6RSCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E6A5802ED3;
        Mon, 14 Jun 2021 13:33:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 326385C23E;
        Mon, 14 Jun 2021 13:33:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <162367683365.460125.4467036947364047314.stgit@warthog.procyon.org.uk>
References: <162367683365.460125.4467036947364047314.stgit@warthog.procyon.org.uk> <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, jlayton@kernel.org, willy@infradead.org,
        Andrew W Elble <aweits@rit.edu>, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] netfs: fix test for whether we can skip read when writing beyond EOF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <466345.1623677623.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 14 Jun 2021 14:33:43 +0100
Message-ID: <466346.1623677623@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +static noinline bool netfs_skip_page_read(struct page *page, loff_t pos=
, size_t len)

I should've removed the "noinline".

David

