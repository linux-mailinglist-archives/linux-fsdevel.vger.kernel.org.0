Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8768C3AB33C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhFQMHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 08:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhFQMHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623931494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w3DWU7HfIYHS+RygXYUk8MWIxhHo4n71DR7hT+nkhVM=;
        b=Q/ylbje9laf/oDS+MjgFjyylDKxy9R0SEc2/F11iy6Ycx+ruQX7ol5VVSFa4sYUP9S7PTN
        rIxXJmg3LlafoxI5xI6/KEmULHg4aNZDzMtoqBKxXsRJHZepWuKh+VAtK55A//6f/uLcmH
        Yf2/x7fHLNX00qjTT4grobjdipCDf68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-2RfWm_lrNx-UgGsr_MmP5w-1; Thu, 17 Jun 2021 08:04:53 -0400
X-MC-Unique: 2RfWm_lrNx-UgGsr_MmP5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A25E1084F42;
        Thu, 17 Jun 2021 12:04:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82D7260C54;
        Thu, 17 Jun 2021 12:04:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210615115453.63bc3a63@oasis.local.home>
References: <20210615115453.63bc3a63@oasis.local.home> <YLAXfvZ+rObEOdc/@localhost.localdomain> <643721.1623754699@warthog.procyon.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     dhowells@redhat.com, Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1192146.1623931489.1@warthog.procyon.org.uk>
Date:   Thu, 17 Jun 2021 13:04:49 +0100
Message-ID: <1192147.1623931489@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:

> Looks fine to me, and even saves 4 bytes on 64 bit machines (events are
> rounded up to 4 byte increments, so the u16 is no different than a u32
> here).

Can I put that down as a Reviewed-by?

David

