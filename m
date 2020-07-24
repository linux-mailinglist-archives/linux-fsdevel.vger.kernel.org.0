Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F322C388
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGXKpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 06:45:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24936 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726258AbgGXKpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595587539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dP5qwmAy0dGXBb00hD2b2i9QHk2HM2volq4yxKaXFGc=;
        b=LaYKZqXQ0rauFMy1hH05iTC+u242Noj90Qj95Wa9MIDscahEreew9tESrauZ7vmdAYeFm8
        69ZbmSGxBPlTPk3QspeaWrHVp6cS2/moJSM7nKWX/D/IVc1OISPh4e95dO63SoTKjKsZ6b
        DhBp5yTYqRrUpj+NBasKzBxrb6G4jBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-0QXk46cJP8CQv4Knyv0-Ww-1; Fri, 24 Jul 2020 06:45:37 -0400
X-MC-Unique: 0QXk46cJP8CQv4Knyv0-Ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ED028014D7;
        Fri, 24 Jul 2020 10:45:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083FF5D9E2;
        Fri, 24 Jul 2020 10:45:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAKgNAkjyXcXZkEczRz2yvJRFBy2zAwTaNfyiSmskAFWN_3uY1g@mail.gmail.com>
References: <CAKgNAkjyXcXZkEczRz2yvJRFBy2zAwTaNfyiSmskAFWN_3uY1g@mail.gmail.com>
To:     mtk.manpages@gmail.com
Cc:     dhowells@redhat.com, Petr Vorel <pvorel@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Mount API manual pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2007334.1595587534.1@warthog.procyon.org.uk>
Date:   Fri, 24 Jul 2020 11:45:34 +0100
Message-ID: <2007335.1595587534@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:

> Would you be willing to do the following please:
> 
> 1. Review the pages that you already wrote to see what needs to be
> updated. (I did take a look at some of those pages a while back, and
> some pieces--I don't recall the details--were out of sync with the
> implementation.)
> 
> 2. Resend the pages, one patch per page.
> 
> 3. Please CC linux-man@, linux-api@, linux-kernel@, and the folk in CC
> on this message.

For this week and next, I have an online language course taking up 8-10 hours
a day.  I'll pick it up in August, if that's okay with you.

David

