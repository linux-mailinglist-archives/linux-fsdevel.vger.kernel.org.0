Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336A91145DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfLERZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:25:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48311 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730154AbfLERZb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575566730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w59JjKWkV4ZxKRNKisQ9Y1kZnArUOKkU4g6jxO2GRWU=;
        b=gjjB6qzl1hOgpkbSSGcDvkJhwqpULaN31RPQGPQhP0K9qTunYFSnXtiiWXANgDnrVbx2hT
        Xj5m4i/lssARIP2ImXwU7pKH3J5n3+fQ9fYIHvJk4uA2FSkJI2+9QL8n+bwq4KTq7Pl2l8
        e6d3p+UU55f+KRdVZHT5y9qX2c+iyY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-3O5RBmQEOS2GZnfvW0B_UQ-1; Thu, 05 Dec 2019 12:25:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8264E107ACC4;
        Thu,  5 Dec 2019 17:25:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A463419756;
        Thu,  5 Dec 2019 17:25:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191205172127.GW2734@suse.cz>
References: <20191205172127.GW2734@suse.cz> <20191205125826.GK2734@twin.jikos.cz> <31452.1574721589@warthog.procyon.org.uk> <1593.1575554217@warthog.procyon.org.uk>
To:     dsterba@suse.cz
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pipe: Notification queue preparation
MIME-Version: 1.0
Content-ID: <21492.1575566720.1@warthog.procyon.org.uk>
Date:   Thu, 05 Dec 2019 17:25:20 +0000
Message-ID: <21493.1575566720@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3O5RBmQEOS2GZnfvW0B_UQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've just posted a couple of patches - can you check to see if they fix you=
r
problem?

https://lore.kernel.org/linux-fsdevel/157556649610.20869.853707964949534356=
7.stgit@warthog.procyon.org.uk/T/#t

Thanks,
David

