Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96B93F35F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 18:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfKGRme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 12:42:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34848 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730510AbfKGRme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573148553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1foU4cyX2MhxBVBENJ4jXE1nzS/4a8PcCvLYQvqpsc=;
        b=I8MRldZasAUCkppfLsj5z/l1loKZR+DDCxqazbPnIRaO55R+IjGt6WZI5hOn5urGYZrGPj
        2ZorB40ied/l0RQEls/xePlVywr5dz/3hdjrIqtAEPjy3HpJKeTK3lsw3OxXRbf/DURfHJ
        kMwwBU9mxVNSSRwGOdnYiOala4zJCEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-D-hZqIeRMxO76CIz0f9Q7w-1; Thu, 07 Nov 2019 12:42:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 026A5477;
        Thu,  7 Nov 2019 17:42:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9AEB5C6DC;
        Thu,  7 Nov 2019 17:42:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
References: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com> <157262967752.13142.696874122947836210.stgit@warthog.procyon.org.uk> <20191107090306.GV29418@shao2-debian>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, lkp report check <rong.a.chen@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Subject: Re: [pipe] d60337eff1: phoronix-test-suite.noise-level.0.activity_level 144.0% improvement
MIME-Version: 1.0
Content-ID: <25251.1573148538.1@warthog.procyon.org.uk>
Date:   Thu, 07 Nov 2019 17:42:18 +0000
Message-ID: <25252.1573148538@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: D-hZqIeRMxO76CIz0f9Q7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > FYI, we noticed a 144.0% improvement of phoronix-test-suite.noise-level=
.0.activity_level due to commit:
> >
> > commit: d60337eff18a3c587832ab8053a567f1da9710d2 ("[RFC PATCH 04/11] pi=
pe: Use head and tail pointers for the ring, not cursor and length [ver #3]=
")
>=20
> That sounds nice, but is odd. That commit really shouldn't change
> anything noticeable. David, any idea?

Yeah, it does sound odd - the only thing that springs particularly to mind =
is
that maybe it's an effect of one of the preceding patches that affects the
waitqueue stuff.

TBH, I'm not sure what the Phoronix test suite is actually testing from the
report.  "noise-level-1.1.0" seems more a reporting script than an actual
test.

David

