Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A202925F9D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 13:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgIGLtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 07:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729143AbgIGLrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599479270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJK2rYubePS6o9IGw+xv/Kicmr6oDOLLUaC6aIiTRC8=;
        b=ZqQxwYDFcbayd1lysiO7dPr/UJb0SF8NHi55h0NoMl8xL86suyB3shwnSTIcpvw4N931vq
        7bz+WbpV+o7tUP4TnsDTKEamjBlxs60fwZx0p2ZbqHBlZer53z37Ru5/PvG6DjQ1WuaOhK
        x7jk1Djw7qTCjU1+qXcb5xDBEAHtc+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-PYqdx2vkOBuCVrrp-aWETg-1; Mon, 07 Sep 2020 07:47:48 -0400
X-MC-Unique: PYqdx2vkOBuCVrrp-aWETg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B77C100670D;
        Mon,  7 Sep 2020 11:47:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 448141A3D7;
        Mon,  7 Sep 2020 11:47:47 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 36C8C79FE6;
        Mon,  7 Sep 2020 11:47:47 +0000 (UTC)
Date:   Mon, 7 Sep 2020 07:47:47 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1180880820.16044889.1599479267134.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200904161240.GA3730201@kroah.com>
References: <20200811150129.53343-1-vdronov@redhat.com> <20200904114207.375220-1-vdronov@redhat.com> <20200904161240.GA3730201@kroah.com>
Subject: Re: [PATCH] debugfs: Fix module state check condition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.73, 10.4.195.19]
Thread-Topic: debugfs: Fix module state check condition
Thread-Index: Kw0NjrRlcAHw1JiDINDqN4pEdx9zzA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Greg,

----- Original Message -----
> From: "Greg KH" <gregkh@linuxfoundation.org>
> Subject: Re: [PATCH] debugfs: Fix module state check condition
> 
...skip...
> > A customer which has reported this issue replied with a test result:
> > 
> > > I ran the same test.
> > > Started ib_write_bw traffic and started watch command to read RoCE
> > > stats : watch -d -n 1 "cat /sys/kernel/debug/bnxt_re/bnxt_re0/info".
> > > While the command is running, unloaded roce driver and I did not
> > > observe the call trace that was seen earlier.
> 
> Having this info, that this was affecting a user, would have been good
> in the original changelog info, otherwise this just looked like a code
> cleanup patch to me.

Thank you, Greg. Makes sense indeed, I will pay attention to this next time(s).

<rant>oh so many little but important details to know and follow...</rant>

> I'll go queue this up now, thanks.
> 
> greg k-h

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

