Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45021457A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 15:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgAVOWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 09:22:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725871AbgAVOWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579702930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64bFfhBq2ZcRM0veKqBtg2V5qHwGYQXKOH1WkP/dJrM=;
        b=ITWxzgOC8zwWPICR6xTRxVYifMqUUe6zJ9UFQTpOjE+awUSm2s7ysxWQqAh1KgLS49y256
        N56+S7lemj68GZP7aNL1CNRHtruw54X8t7uFK0oDHqrrx4rU5IFjH1+j9H8z0DWnBmd7iA
        OxcRfKo3WUZWsNFshfqQXm/dHdxeHrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-lAtWdH9MO3q9TW6DKMvE1A-1; Wed, 22 Jan 2020 09:22:08 -0500
X-MC-Unique: lAtWdH9MO3q9TW6DKMvE1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9DFF2F60;
        Wed, 22 Jan 2020 14:22:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41131620D8;
        Wed, 22 Jan 2020 14:22:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <17045.1578548716@jrobl>
References: <17045.1578548716@jrobl>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: Q, SIGIO on pipe
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3574294.1579702923.1@warthog.procyon.org.uk>
Date:   Wed, 22 Jan 2020 14:22:03 +0000
Message-ID: <3574295.1579702923@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

J. R. Okajima <hooanon05g@gmail.com> wrote:

> Between v5.4 and v5.5-rc5, big changes are made around pipe and my test
> program behaves differently.

Do you have a full test program I can look at?

David

