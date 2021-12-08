Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5546046DC8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 20:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhLHT7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 14:59:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239919AbhLHT7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638993343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HmG9k+urqjCT5P/C79yXHidwD7VZjGOrgaeS5VLahvQ=;
        b=XPVesCjp59DOXld3Qtq46oAeZSXJnLy+rxJm+q1/nwHWKXqFPdm0heln0FVatXKdjiynTL
        +AK+7aHxY3S0RqLomA4+mhGcH/GEozrRFHbbjcPdbD7fUSnSJHgJ2eWNo43PO0tmqmwNpU
        s7xbG/MnCSP08rsG73a81xnl1AwY7Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-430-XRLCGAnMPsWUXl3CXByO0g-1; Wed, 08 Dec 2021 14:55:37 -0500
X-MC-Unique: XRLCGAnMPsWUXl3CXByO0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 429EE85B660;
        Wed,  8 Dec 2021 19:55:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1C475C1C5;
        Wed,  8 Dec 2021 19:55:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHC9VhTP-HbRU1z66MOkSyw9w7vhK7Vq8p0FrxVfEX-+tSD43A@mail.gmail.com>
References: <CAHC9VhTP-HbRU1z66MOkSyw9w7vhK7Vq8p0FrxVfEX-+tSD43A@mail.gmail.com> <163898788970.2840238.15026995173472005588.stgit@warthog.procyon.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        anna.schumaker@netapp.com, kolga@netapp.com,
        casey@schaufler-ca.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] security: Remove security_add_mnt_opt() as it's unused
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2846547.1638993312.1@warthog.procyon.org.uk>
Date:   Wed, 08 Dec 2021 19:55:12 +0000
Message-ID: <2846548.1638993312@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Paul Moore <paul@paul-moore.com> wrote:

> There is already a patch in the selinux/next tree which does this.

Looks pretty much identical to mine.  Feel free to add:

	Reviewed-by: David Howells <dhowells@redhat.com>

David

