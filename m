Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15847E6C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349457AbhLWRR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 12:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349452AbhLWRR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640279846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KO+jpO88WyeMR1W2IVhenVSlSUN8Bo4pG7dceTXF9EM=;
        b=AIm+lPqEnmO9Nvf17YWH6b95waquSnVuZIv9nmJntP+MdJya1nUblpn7qSXuyRNp50gbb+
        V4rR8eWWr24Kfl18kYVrH389jIvRdhkL7UnXmDmFentTMu4xf3nP9tbLl5jDO/W8uIGoOX
        mHH327Cl2W/vE5ZH93zJ22St+4ifIZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-TPNB58yuMteymdXWx3PXKw-1; Thu, 23 Dec 2021 12:17:24 -0500
X-MC-Unique: TPNB58yuMteymdXWx3PXKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93725100C660;
        Thu, 23 Dec 2021 17:17:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25D74A22F;
        Thu, 23 Dec 2021 17:17:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211223163500.2625491-1-bigeasy@linutronix.de>
References: <20211223163500.2625491-1-bigeasy@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Gregor Beck <gregor.beck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH REPOST REPOST v2] fscache: Use only one fscache_object_cong_wait.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <901884.1640279829.1@warthog.procyon.org.uk>
Date:   Thu, 23 Dec 2021 17:17:09 +0000
Message-ID: <901885.1640279829@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, but this is gone in the upcoming fscache rewrite.  I'm hoping that
will get in the next merge window.

David

