Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA53A78F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFOIWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhFOIWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623745204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WRiUBB/0b7ZAkyPeO4JFB2ikkG5AP5C+sp+pLHt60ts=;
        b=AsUbOp2oYNvRKujxSGA/lXS9Te3LtBJlLG/VLUdP9rClfuUI4/T9bhO1U/kfDxQDPhgHZg
        D0obE1Fsd2wDo02Gt8hetPFNZPi8NwJkFg6w61zQIlsVs0HWdEjcXQ+wfFSp9sTfiVsTGp
        MKsPCjHSWJcpN/hHJAQKk4VZtvdzk9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-TIAjNvoRMzWeO3sITu6bgg-1; Tue, 15 Jun 2021 04:20:02 -0400
X-MC-Unique: TIAjNvoRMzWeO3sITu6bgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BCD18018A7;
        Tue, 15 Jun 2021 08:20:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3CD360877;
        Tue, 15 Jun 2021 08:20:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YLAXfvZ+rObEOdc/@localhost.localdomain>
References: <YLAXfvZ+rObEOdc/@localhost.localdomain>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <558444.1623745199.1@warthog.procyon.org.uk>
Date:   Tue, 15 Jun 2021 09:19:59 +0100
Message-ID: <558445.1623745199@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:

> -	char afs_SRXCB##name##_name[] __tracepoint_string =	\
> -		"CB." #name

I seem to remember that when I did this, it couldn't be a const string for
some reason, though I don't remember exactly why now if that was indeed the
case.

I wonder if it's better just to turn it into an enum-string table in
linux/events/afs.h.

David

