Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87F9D0E26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 14:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfJIMCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 08:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfJIMCX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:02:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D58E987630;
        Wed,  9 Oct 2019 12:02:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC5DF19C69;
        Wed,  9 Oct 2019 12:02:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <515a67cd-f847-8885-da30-1eab3931f1fb@gmail.com>
References: <515a67cd-f847-8885-da30-1eab3931f1fb@gmail.com> <153126269451.14533.13592791373864325188.stgit@warthog.procyon.org.uk> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <15519.1531263314@warthog.procyon.org.uk>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [MANPAGE PATCH] Add manpage for fsinfo(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17942.1570622540.1@warthog.procyon.org.uk>
Date:   Wed, 09 Oct 2019 13:02:20 +0100
Message-ID: <17943.1570622540@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Oct 2019 12:02:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:

> There is no fsinfo(2) in the system call in the kernel currently.
> Will that call still be added,

Hopefully, but I'm not sure it'll be ready by the next merge window.

> or was it replaced by fsconfig(2),

They're different things and not interchangeable.

David
