Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C7E13CE98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 22:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgAOVHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 16:07:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729469AbgAOVHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579122464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LdDxJ4TaImd6q6K/Midoj6ftwyCpFTFDZIo2bBl0h+Y=;
        b=geGugIIvxmNu6yxzJmIxe7A2O4ZbQlU8CmZWo6NZXo6n6sDgAWva3N2yHz8Al8x9lTTToS
        hFjOoe4SEhAEA7PJO5VAKDr36WfXX7VN5VMD/pBfSyLhYU35tB3ip5sVsTmLrxTLeeb4o/
        DHhT7cR9XIJXaLUs8XJSw2l/6Oq47dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Nm7f_jTgN36eBJiQzWf3_A-1; Wed, 15 Jan 2020 16:07:41 -0500
X-MC-Unique: Nm7f_jTgN36eBJiQzWf3_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4A13801E6C;
        Wed, 15 Jan 2020 21:07:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97A721000329;
        Wed, 15 Jan 2020 21:07:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
References: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com> <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] pipe: Keyrings, Block and USB notifications [ver #3]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24898.1579122454.1@warthog.procyon.org.uk>
Date:   Wed, 15 Jan 2020 21:07:34 +0000
Message-ID: <24899.1579122454@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I no longer hate the implementation, but I do want to see the
> actual user space users come out of the woodwork and try this out for
> their use cases.

I'll see if I can get someone to help fix this:

	https://bugzilla.redhat.com/show_bug.cgi?id=1551648

for the KEYRING kerberos cache using notifications.  Note that the primary
thrust of this BZ is with KCM cache, but it affects KEYRING as well.

Also, I'll poke Greg, since he was interested in using it for USB
notifications.

David

