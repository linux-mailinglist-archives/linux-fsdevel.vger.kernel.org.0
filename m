Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786D1206935
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 02:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbgFXAzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 20:55:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35325 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387586AbgFXAzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592960124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8YDKYWSS8vDlTiiBW94TviByEXAP7JxXxS7ijuo3BU=;
        b=QPjkTr4K9YSX7Gf7CWkHbWgBFw8YObBekLBPD9GZ3St/QUidds7ahHdBHBfACL3wWgv4FB
        DIdjpjNgDAYE2Ktje86s1GDwga7j+/qoPgnb69VfrX5pQzWWO1JxsjPxYt2Oo5hkEj2lAM
        ebmJ1vhh7bNnQRijrjFKlSIJJ7WqwPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-SUNRbfhUNlOrRx30UX_RVQ-1; Tue, 23 Jun 2020 20:55:22 -0400
X-MC-Unique: SUNRbfhUNlOrRx30UX_RVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C601804001;
        Wed, 24 Jun 2020 00:55:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 032357CCF9;
        Wed, 24 Jun 2020 00:55:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com>
References: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com> <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dhowells@redhat.com,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "raven@themaw.net" <raven@themaw.net>,
        "kzak@redhat.com" <kzak@redhat.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dray@redhat.com" <dray@redhat.com>,
        "swhiteho@redhat.com" <swhiteho@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "andres@anarazel.de" <andres@anarazel.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3015560.1592960116.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 24 Jun 2020 01:55:16 +0100
Message-ID: <3015561.1592960116@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> wrote:

> > This commit:
> >
> > >       keys: Make the KEY_NEED_* perms an enum rather than a mask
> >
> > ...upstream as:
> >
> >     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a=
 mask
> >
> > ...triggers a regression in the libnvdimm unit test that exercises the
> > encrypted keys used to store nvdimm passphrases. It results in the
> > below warning.
> =

> This regression is still present in tip of tree. David, have you had a
> chance to take a look?

nvdimm_lookup_user_key() needs to indicate to lookup_user_key() what it wa=
nts
the key for so that the appropriate security checks can take place in SELi=
nux
and Smack.  Note that I have a patch in the works that changes this still
further.

Does setting the third argument of lookup_user_key() to KEY_NEED_SEARCH wo=
rk
for you?

David

