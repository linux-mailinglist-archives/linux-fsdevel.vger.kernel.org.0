Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02117A7E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 15:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCEOim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 09:38:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgCEOil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583419121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TP9pMLEuFFfcigfwVPNdkTMKm05VsLz8cLozAukb7nY=;
        b=NNb4KQ1fjoiKrd/2ESn/Grlr5fYj55O0M2jlqol86YBAUqIut4zYIv+z5wqUintTwN7rxv
        c0i0lmkWac5XtbJIs68YcXrlvw//gCPQE/MqUDyN4/jwvdGbH88CNu0jyN8JrZLXkv1rMS
        BiMIxb03o83ZdR5L0FxS9nOE1LTTipg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-4cKaHQjVP5iMo8p40VUiZA-1; Thu, 05 Mar 2020 09:38:37 -0500
X-MC-Unique: 4cKaHQjVP5iMo8p40VUiZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 873E4802B80;
        Thu,  5 Mar 2020 14:38:35 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-226.ams2.redhat.com [10.36.116.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11D7C73895;
        Thu,  5 Mar 2020 14:38:32 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        metze@samba.org, torvalds@linux-foundation.org, cyphar@cyphar.com,
        sfrench@samba.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
References: <87y2sjlygl.fsf@oldenburg2.str.redhat.com>
        <96563.1582901612@warthog.procyon.org.uk>
        <20200228152427.rv3crd7akwdhta2r@wittgenstein>
        <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
        <20200302115239.pcxvej3szmricxzu@wittgenstein>
        <8736arnel9.fsf@oldenburg2.str.redhat.com>
        <20200302121959.it3iophjavbhtoyp@wittgenstein>
        <20200302123510.bm3a2zssohwvkaa4@wittgenstein>
        <3606975.1583418833@warthog.procyon.org.uk>
Date:   Thu, 05 Mar 2020 15:38:31 +0100
In-Reply-To: <3606975.1583418833@warthog.procyon.org.uk> (David Howells's
        message of "Thu, 05 Mar 2020 14:33:53 +0000")
Message-ID: <875zfi989k.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* David Howells:

> Florian Weimer <fweimer@redhat.com> wrote:
>
>> Will there be any new flags for openat in the future?  If not, we can
>> just use a constant mask in an openat2-based implementation of openat.
>
> One thing we might want to look at is implementing support for
> lock-on-open/create and sharing modes in openat2().  Various network
> filesystems support this.  Wine, CIFS and Samba particularly might be
> interested in this.

But will those be O_ flags that need to be passed to openat?

Ignoring locking requests on older kernels because of the openat flag
handling seems problematic.

Thanks,
Florian

