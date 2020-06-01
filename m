Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0743A1EA3F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 14:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgFAMfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 08:35:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49861 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725976AbgFAMfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591014909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBls6dso9hCO4rI4kYDinlWW4RbCZK4JGwW4cnToAWE=;
        b=aTpTPKCGVxWzE9dxR3V88Q1AUuxgwtp/R2vg0bzFEPr8cNTm7dY9RuxcKTNOQnb/TjpvGp
        jM+pcqk5LFLDHKFUNmn3CO4UvMEaTuDkMXLYtKxAU42OfH0ouO9ppjd+dcSfhcUlln+CJI
        vWbmHBUTML5jqUDEyn1GJqz+qmmy/BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-9eo9lp6gNlu9Yo_iflGRGg-1; Mon, 01 Jun 2020 08:35:07 -0400
X-MC-Unique: 9eo9lp6gNlu9Yo_iflGRGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E338005AA;
        Mon,  1 Jun 2020 12:35:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 819432DE93;
        Mon,  1 Jun 2020 12:35:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d8e5aa79-3f83-a5de-5aa8-7bd4a287646e@web.de>
References: <d8e5aa79-3f83-a5de-5aa8-7bd4a287646e@web.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dhowells@redhat.com, Zhihao Cheng <chengzhihao1@huawei.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yi Zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH] afs: Fix memory leak in afs_put_sysnames()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 01 Jun 2020 13:35:01 +0100
Message-ID: <1306563.1591014901@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> wrote:

> > sysnames should be freed after refcnt being decreased to zero in
> > afs_put_sysnames().
>=20
> * I suggest to use the wording =E2=80=9Creference counter=E2=80=9D.

Can you use ASCII quotes please?  Not all fonts contain these quotes, and
occasionally they got copied into commit messages.

> * Where did you notice a =E2=80=9Cmemory leak=E2=80=9D here?

He said "sysnames should be freed after refcnt being decreased to zero in
afs_put_sysnames()".

> * Will the tag =E2=80=9CFixes=E2=80=9D become relevant for the commit mes=
sage?

It is the correct tag.

David

