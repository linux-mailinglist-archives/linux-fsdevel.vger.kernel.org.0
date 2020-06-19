Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA42A2002F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgFSHrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 03:47:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49775 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgFSHrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592552830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPVknvCNz1QP6ohtrHsCmBM6NipNoCGeSPrrMO0N38w=;
        b=SGgS5mDEt1QKUXLZ4+5OvjjEpQks4PBvUtZ5+FxehlCov8E7wgtZaSX6MjU0JoG1EHpqSP
        4dIofoT3LCKg+qC0ItnES9WLn9j/i5KOBJDZtFB58SlbHLVssErKVZjWHFwunfLuo7knRW
        GYZ0+++Juz8KCSIpQYnNFlDzbWlr6bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-ag7SrsgZMYiq-N07DYEYtw-1; Fri, 19 Jun 2020 03:47:06 -0400
X-MC-Unique: ag7SrsgZMYiq-N07DYEYtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B4C18FE861;
        Fri, 19 Jun 2020 07:47:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA0235C1BB;
        Fri, 19 Jun 2020 07:47:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     dhowells@redhat.com, ebiggers@google.com, viro@zeniv.linux.org.uk,
        mszeredi@redhat.com, linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1696714.1592552822.1@warthog.procyon.org.uk>
Date:   Fri, 19 Jun 2020 08:47:02 +0100
Message-ID: <1696715.1592552822@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stefan Priebe - Profihost AG <s.priebe@profihost.ag> wrote:

> while using fuse 2.x and nonempty mount option - fuse mounts breaks
> after upgrading from kernel 4.19 to 5.4.

Can you give us an example mount commandline to try?

Thanks,
David

