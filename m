Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA710550C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfKUPEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:04:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbfKUPEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574348681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1JphBz5QVhgb+kKcXCnIHoV9eqJ1dLsIOajB+Whm5A=;
        b=Y0QTiS8tK1tDV0fqRLRTuUPrUAvsLZ2qeKP+n/JVnwXxdD5J82I/uLu2aI2H0peG4xZAO0
        +6FRKpmyPwZUvOMRnJurJaAB+eJyF8FwsaZ8uY74PbFLde+0LxnK2rAVDtNYeDZUyA8u1e
        KCPizgz0Fg2jeJGiO/eQKpACCgM2msk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-7apfarw2Mhe0SJwzprQa3w-1; Thu, 21 Nov 2019 10:04:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C836801E5B;
        Thu, 21 Nov 2019 15:04:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3F4F5DDAB;
        Thu, 21 Nov 2019 15:04:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191121145410.lxrkxzmfioxbll37@wittgenstein>
References: <20191121145410.lxrkxzmfioxbll37@wittgenstein> <1574295100.17153.25.camel@HansenPartnership.com> <17268.1574323839@warthog.procyon.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <christian@brauner.io>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Feature bug with the new mount API: no way of doing read only bind mounts
MIME-Version: 1.0
Content-ID: <5623.1574348672.1@warthog.procyon.org.uk>
Date:   Thu, 21 Nov 2019 15:04:32 +0000
Message-ID: <5624.1574348672@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7apfarw2Mhe0SJwzprQa3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> Also, I thought we've agreed a while back that the flags would move into
> a struct since mount is gaining flags quickly too. :)

I think we did agree that.  What I just wrote in the email was more of a
tentative illustration.

David

