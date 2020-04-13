Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766701A6891
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgDMPNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 11:13:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51487 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729696AbgDMPNi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586790817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJowtOvzAa19C32LJEMTxVyIKp1fzSsgOgfg3CQWfw0=;
        b=H1EOraWx+HWU79UO96IXOJVYVBbx0thl6/zJCnbVlKTB43Evfa7C/wHvk+a4v3BvJDRz12
        HZIWGFRlZke0YrpyUIEbd+dJomLO30EQ0kq3cS3UxWQ6rlWutXD5IF5BULgMTV1Cfh8w9s
        YUJLEcXkXGZA+PyZsEdvgrJyUpkamHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-VqRzGYoNMgSl-wmSX7-zdg-1; Mon, 13 Apr 2020 11:13:35 -0400
X-MC-Unique: VqRzGYoNMgSl-wmSX7-zdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A4768017FD;
        Mon, 13 Apr 2020 15:13:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-224.rdu2.redhat.com [10.10.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2090B5C1B5;
        Mon, 13 Apr 2020 15:13:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2940559.1586789415@warthog.procyon.org.uk>
References: <2940559.1586789415@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] afs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3060969.1586790812.1@warthog.procyon.org.uk>
Date:   Mon, 13 Apr 2020 16:13:32 +0100
Message-ID: <3060970.1586790812@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

>  (1) Fix the decoding of fetched file status records do that in advances
>      the xdr pointer under all circumstances.

As Willy points out, this isn't very English.  Let me try that again.

David

