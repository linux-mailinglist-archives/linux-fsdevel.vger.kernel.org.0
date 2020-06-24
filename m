Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09C206966
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 03:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbgFXBSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 21:18:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24174 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388029AbgFXBSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592961484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3+UUW6YvtIXEKqK6unLKp0s3Sioh7yCdLFU6q9JrlU=;
        b=Di/BtklMDVjU4kQ09Dizk+9+fAp4JNMERTEgB/T12wB57yoLIYU1B5qbEbudMnpo/kUxe/
        KXFYh3ATRRz/9U9fUmEZ80FLzNWKrc8KE+fj4DwxnR1JKsHXCQHoIaXuIcrBRbS3DQ2DsH
        WgJIEdjocK6NJfqD6EdLflbgO6cq5l0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-c0pSj-gQN_qEdwt2-3CGxQ-1; Tue, 23 Jun 2020 21:18:02 -0400
X-MC-Unique: c0pSj-gQN_qEdwt2-3CGxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 220381005512;
        Wed, 24 Jun 2020 01:18:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3632C610FD;
        Wed, 24 Jun 2020 01:17:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAPcyv4gdB6iOD8N0KAHY9WybpJtRx3EfEQCSM1zuTDkURrfuug@mail.gmail.com>
References: <CAPcyv4gdB6iOD8N0KAHY9WybpJtRx3EfEQCSM1zuTDkURrfuug@mail.gmail.com> <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com> <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com> <3015561.1592960116@warthog.procyon.org.uk>
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
Content-ID: <3018028.1592961477.1@warthog.procyon.org.uk>
Date:   Wed, 24 Jun 2020 02:17:57 +0100
Message-ID: <3018029.1592961477@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> wrote:

> Shall I wait for your further reworks to fix this for v5.8, or is that
> v5.9 material?

It could do with stewing in linux-next for a while, so 5.9 probably.

David

