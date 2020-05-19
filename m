Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0D1D9C43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgESQSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 12:18:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729053AbgESQSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 12:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589905088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Qrhv2MHcmowyV5LiaC9P4RZtjx9DBBpr0tpbzf5lPc=;
        b=byLE+f96s8cvDBhX0tERZd/Hk1rdfoTZOBjdZR2dMCscMmDq0UlY/bJeeT8LJjXKxcefPU
        CCMwkdqfddy2qj8u8RHAGi/Euk/sHLy34/dQ7WN++czwbqWXJXGYYvm8gveb13qM+XNVzh
        RehORo9RbtDWTS/XkjyDN3d6cKM5vmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-zjlBHk-INtKFUFEsNxAk6g-1; Tue, 19 May 2020 12:18:06 -0400
X-MC-Unique: zjlBHk-INtKFUFEsNxAk6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B751005510;
        Tue, 19 May 2020 16:18:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC856F7E0;
        Tue, 19 May 2020 16:18:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200515120908.GB575846@mwanda>
References: <20200515120908.GB575846@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fsinfo: Fix uninitialized variable in fsinfo_generic_mount_all()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1514222.1589905083.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 May 2020 17:18:03 +0100
Message-ID: <1514223.1589905083@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "conn" variable is never set to false.
> =

> Fixes: f2494de388bd ("fsinfo: Add an attribute that lists all the visibl=
e mounts in a namespace")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The buggy commit looks like preliminary stuff not pushed to anywhere so
> probably this can just be folded in.

I folded in someone else's equivalent patch, thanks.

David

