Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B525D82F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgIDL6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 07:58:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730069AbgIDL6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:58:30 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-0fypSvtTPzuBU8yy6NCR7w-1; Fri, 04 Sep 2020 07:58:28 -0400
X-MC-Unique: 0fypSvtTPzuBU8yy6NCR7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E773873085;
        Fri,  4 Sep 2020 11:58:27 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87BF95D9CC;
        Fri,  4 Sep 2020 11:58:27 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7B26D79DA2;
        Fri,  4 Sep 2020 11:58:27 +0000 (UTC)
Date:   Fri, 4 Sep 2020 07:58:27 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1368247890.15496631.1599220707457.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200904115048.GA2964117@kroah.com>
References: <20200811150129.53343-1-vdronov@redhat.com> <20200904114207.375220-1-vdronov@redhat.com> <20200904115048.GA2964117@kroah.com>
Subject: Re: [PATCH] debugfs: Fix module state check condition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.51, 10.4.195.2]
Thread-Topic: debugfs: Fix module state check condition
Thread-Index: e5aKqC+SWN99YQvQqyZUd2FQT/pMlQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Greg, all,

----- Original Message -----
> From: "Greg KH" <gregkh@linuxfoundation.org>
> Subject: Re: [PATCH] debugfs: Fix module state check condition
> 
...skip...
> 
> It's in my queue, but bugs you can only trigger while root are a bit
> lower on the priority list :)

Oh, apologies. I really thought this has been somehow lost/slipped.
Thank you for the reply and a confirmation.

/me stops bothering people.

> thanks,
> 
> greg k-h
> 
> 

Regards,
Vladis

