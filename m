Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FF17A7FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 15:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCEOn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 09:43:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23038 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCEOn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583419407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwIzNESuUZFLv2swghASvgdJ5b2f9zf7o+dRg9fWt2Q=;
        b=LpgSTabc0g9MALzXa2fap1ZBlrEsrrYflIhEuA4lhi6/1Za5+EdoDjgUwvxh3jwvmAfb5a
        1Cm9Z8BqjEKty7hk5vprIP3kbMXS7igoCJDu9l+J6mbtPVot32fXmo5c44R9s+bzzMCRq8
        ibnGHarowuWtEgpmLsHmLgeLM7Q7Ohc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-yurzBPoAPpWjd4sCFJb0bA-1; Thu, 05 Mar 2020 09:43:25 -0500
X-MC-Unique: yurzBPoAPpWjd4sCFJb0bA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E897B8048FE;
        Thu,  5 Mar 2020 14:43:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08869277B5;
        Thu,  5 Mar 2020 14:43:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <875zfi989k.fsf@oldenburg2.str.redhat.com>
References: <875zfi989k.fsf@oldenburg2.str.redhat.com> <87y2sjlygl.fsf@oldenburg2.str.redhat.com> <96563.1582901612@warthog.procyon.org.uk> <20200228152427.rv3crd7akwdhta2r@wittgenstein> <87h7z7ngd4.fsf@oldenburg2.str.redhat.com> <20200302115239.pcxvej3szmricxzu@wittgenstein> <8736arnel9.fsf@oldenburg2.str.redhat.com> <20200302121959.it3iophjavbhtoyp@wittgenstein> <20200302123510.bm3a2zssohwvkaa4@wittgenstein> <3606975.1583418833@warthog.procyon.org.uk>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     dhowells@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        metze@samba.org, torvalds@linux-foundation.org, cyphar@cyphar.com,
        sfrench@samba.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3607682.1583419401.1@warthog.procyon.org.uk>
Date:   Thu, 05 Mar 2020 14:43:21 +0000
Message-ID: <3607683.1583419401@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Florian Weimer <fweimer@redhat.com> wrote:

> But will those be O_ flags that need to be passed to openat?

Ah, sorry, you were talking about openat().  I doubt there's sufficient O_*
space for that.

David

