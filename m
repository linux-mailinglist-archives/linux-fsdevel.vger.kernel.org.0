Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A514EDCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 14:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgAaNsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 08:48:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728687AbgAaNsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580478531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sx57NbRtTsBjX3bDrRIFqZodAMgs1iTQiSrgDAo00Jw=;
        b=HoWdU1qGynYivuNyNbd5Y9uKK6h2+FUvw1VoYy0BHDJ8yJLW6klYK9XWgawxpbs6AziTXE
        crAwe9e3yaYnRmKFAetTyjcaOi0PRucp1g08avCKtcCCn+zHec3CB0xPWovHzvyNdXrZHE
        QXTIt9h4ec6LxHkfA0q18eJyJ7ZOpX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-uLcYM3WVNISw-nVeR3eI5g-1; Fri, 31 Jan 2020 08:48:47 -0500
X-MC-Unique: uLcYM3WVNISw-nVeR3eI5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DECE800D54;
        Fri, 31 Jan 2020 13:48:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68A5310027A1;
        Fri, 31 Jan 2020 13:48:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5b94d23baef8c2a256384f436650f4c4868915a2.1580251857.git.osandov@fb.com>
References: <5b94d23baef8c2a256384f436650f4c4868915a2.1580251857.git.osandov@fb.com> <cover.1580251857.git.osandov@fb.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com,
        linux-api@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>
Subject: Re: [RFC PATCH v4 1/4] fs: add flags argument to i_op->link()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <134624.1580478522.1@warthog.procyon.org.uk>
Date:   Fri, 31 Jan 2020 13:48:42 +0000
Message-ID: <134625.1580478522@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Omar Sandoval <osandov@osandov.com> wrote:

> -	int (*link) (struct dentry *,struct inode *,struct dentry *);
> +	int (*link) (struct dentry *,struct inode *,struct dentry *, int);

Can you make it unsigned int?

David

