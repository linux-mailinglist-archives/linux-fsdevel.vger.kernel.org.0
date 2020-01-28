Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C5E14BE2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgA1Q5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 11:57:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49313 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgA1Q5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580230636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7DBMwVmJngVtUjqv6kxn0wRq6MJ3QeZYu0UNLHoqYE=;
        b=jAgFRf5Urs3MUPXWkPJD6HpbPvfaEcc3YyDUhRr7gzzbiSBiTitYJuecTXPoNrCeRMxbmr
        dLhUfTtiHSN6dggyJIyw4LTusedf9z8f+C5m1V0N62zyn81tR5IFsoaIEQfMvCjzAHKtE2
        LsGNf6c3ogcnciCOsHpqztZ6cg7dhQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-Wxg8UVVYMTScUDLGueeVsw-1; Tue, 28 Jan 2020 11:57:13 -0500
X-MC-Unique: Wxg8UVVYMTScUDLGueeVsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC6ADB6C;
        Tue, 28 Jan 2020 16:57:12 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D8861001B23;
        Tue, 28 Jan 2020 16:57:12 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 68F0B1803C32;
        Tue, 28 Jan 2020 16:57:12 +0000 (UTC)
Date:   Tue, 28 Jan 2020 11:57:11 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <709339483.5163729.1580230631945.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200127090330.GA31504@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114161225.309792-6-hch@lst.de> <20200127090330.GA31504@lst.de>
Subject: Re: [Cluster-devel] [PATCH 05/12] gfs2: fix O_SYNC write handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.36.116.223, 10.4.195.23]
Thread-Topic: gfs2: fix O_SYNC write handling
Thread-Index: 0n/dpSBdXXSh+Eqydc1FfoQly459yA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> Bob and Andreas,
> 
> can you please look at this fix and the prep patch?

Hi Christoph,

Thanks for your recent gfs2 patches.
I'm sorry Andreas and I haven't had the time to look at them yet.
We've both been really busy trying to get a rather complex patch set ready
for this merge window, among other things.

We haven't forgotten your patches, and we still plan to review them as soon
as we can.

Regards,

Bob Peterson

