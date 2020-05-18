Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64331D7B43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEROal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 10:30:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42914 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727005AbgEROak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 10:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589812239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qLGWwr7pu6uwkkCaEo2q9GcnoY6Eg3hYnb4VN3qBPU=;
        b=EAX+Ye5r4M/iQO4Igog1cqP0euM1OqUQcVHXnQ7PFtkqcLy+42QwxxdbLCut5vs8Pm+bPG
        bOJ+nzlgK9ea9WKCQWFnYHpI8bD/wZ3H6XbLfTgiYuvPsTNVwoPbz4zWhH3405xw7T7KxU
        0iwVAfN5N3j/H4rvfYP31AV6lXncNgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-fSgEJzz0PV2LPqGaVrE7Gw-1; Mon, 18 May 2020 10:30:38 -0400
X-MC-Unique: fSgEJzz0PV2LPqGaVrE7Gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2166B80B71F;
        Mon, 18 May 2020 14:30:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57E311001925;
        Mon, 18 May 2020 14:30:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
References: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
To:     mtk.manpages@gmail.com
Cc:     dhowells@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: Setting mount propagation type in new mount API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <909695.1589812234.1@warthog.procyon.org.uk>
Date:   Mon, 18 May 2020 15:30:34 +0100
Message-ID: <909768.1589812234@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:

> I've been looking at the new mount API (fsopen(), fsconfig(),
> fsmount(), move_mount(), etc.) and among the details that remain
> mysterious to me is this: how does one set the propagation type
> (private/shared/slave/unbindable) of a new mount and change the
> propagation type of an existing mount?

Christian said he was going to have a go at writing mount_setattr().  It's not
trivial as it has to be able to handle AT_RECURSIVE.

David

