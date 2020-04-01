Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15219AB40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 14:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbgDAMFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 08:05:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20142 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732246AbgDAMFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585742743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+GR7MHEG6xiBbbkMGHrCHUiX06iUrxcdELI0CxLfVTo=;
        b=f7sqGqZI0rvD8I7UrwxvZ+ovZwX7m9q8g8gr03tQAZUuoRTz1NcZsf5asJT3GE6rkb8pDI
        eaD2IR2NEP3gY3CGG3Ky3ZkpEO/DQd9tk/aDtOgxjCC4IikkT9K5qXHmqKu6xaHmLq6jXz
        yU6vQm31w+NKYljCb8CqiRXC9mlZ7rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-XALTqPojP4mFhLhFshbhmQ-1; Wed, 01 Apr 2020 08:05:41 -0400
X-MC-Unique: XALTqPojP4mFhLhFshbhmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D128BDB60;
        Wed,  1 Apr 2020 12:05:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CBC999DFD;
        Wed,  1 Apr 2020 12:05:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegvv3-oh6iPNXa8bjXmjhkR8KzQPWN4tAH18_tM5wFkQ9A@mail.gmail.com>
References: <CAJfpegvv3-oh6iPNXa8bjXmjhkR8KzQPWN4tAH18_tM5wFkQ9A@mail.gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: Why does test-fsinfo require static libraries?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2479848.1585742738.1@warthog.procyon.org.uk>
Date:   Wed, 01 Apr 2020 13:05:38 +0100
Message-ID: <2479849.1585742738@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> This is annoying:
> 
>   HOSTCC  samples/vfs/test-fsinfo
> /usr/bin/ld: cannot find -lm
> /usr/bin/ld: cannot find -lc
> collect2: error: ld returned 1 exit status

Sorry, yes.  I've been building on one system and running on an older one and
the libraries are incompatible.  I need to undo that bit.

David

