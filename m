Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278829E9C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 11:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJ2K62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 06:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbgJ2K62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603969107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMzM2PD4Cl0KsoHV5h937ssY5oEvvitgNeN1ICxr3Cs=;
        b=UeLrVwPvFthtqtKUm71Bl/G2mKHCPzRcoookSrfTjCu3apFKdg7soQ+GKJ3cE29vcqikyI
        y8PVMgldqFoHysWyvYsYYstMRdZiVEdeeTVe6WbUbl59clzuHLuVVe8XrM8BInIwDk0jv+
        JtyKTMIYxq4/0IfvCEnQUJDF+Cj5aU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-KAGYd23eOtyXJpCe4oEnmg-1; Thu, 29 Oct 2020 06:58:25 -0400
X-MC-Unique: KAGYd23eOtyXJpCe4oEnmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2F1806B38;
        Thu, 29 Oct 2020 10:58:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0598F5B4AA;
        Thu, 29 Oct 2020 10:58:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <160392381226.592578.8767181452598051635.stgit@warthog.procyon.org.uk>
References: <160392381226.592578.8767181452598051635.stgit@warthog.procyon.org.uk> <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] afs: Wrap page->private manipulations in inline functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <856098.1603969093.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 29 Oct 2020 10:58:13 +0000
Message-ID: <856099.1603969093@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> @@ -206,22 +206,20 @@ int afs_write_end(struct file *file, struct addres=
s_space *mapping,
> ..
> +		SetPagePrivate(page);
> +		get_page(page);

Oops.  These got accidentally reintroduced due to a merge conflict.  I've
removed the addition from this patch.

David

