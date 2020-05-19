Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1743F1D9C33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgESQPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 12:15:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729053AbgESQPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 12:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589904950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEQD9h/kF91l4yOX6GQ7jX2yDtwS4/ThsvtEtohlnp4=;
        b=bXf3BiIaC1zIgPq5SN9V7rngCSvvyri9WCIWsJzcyLCQURs0Cn37mfh2k9pf2jMD0tzhH6
        0Ej2QfnaVcHrdanKeSIZMYlnfPSYty8Fc5l78picVlejbYP6JZG0YdoDVLWcDXJa07MY27
        EwPi/+5nraCPSXOSoOkCK+RTtN2OpFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-d6wPtHNMM7eUw2dTr1S_Mg-1; Tue, 19 May 2020 12:15:48 -0400
X-MC-Unique: d6wPtHNMM7eUw2dTr1S_Mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D635107ACCA;
        Tue, 19 May 2020 16:15:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C3395D9C5;
        Tue, 19 May 2020 16:15:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200514181926.16571-1-colin.king@canonical.com>
References: <20200514181926.16571-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fsinfo: fix an uninialized variable 'conn'
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1514049.1589904935.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 May 2020 17:15:35 +0100
Message-ID: <1514050.1589904935@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> =

> Variable conn is not initialized and can potentially contain
> garbage causing a false -EPERM return on the !conn check.
> Fix this by initializing it to false.
> =

> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: f2494de388bd ("fsinfo: Add an attribute that lists all the visibl=
e mounts in a namespace")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, I've folded that in.

David

