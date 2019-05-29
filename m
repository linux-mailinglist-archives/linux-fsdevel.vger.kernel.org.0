Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF532DDC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfE2NMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 09:12:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfE2NMP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 09:12:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD52DC05FBD7;
        Wed, 29 May 2019 13:12:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EADF60487;
        Wed, 29 May 2019 13:12:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpeguPTQ00zVjpwVQ4R8mEqE3aijCzNMAz6Wvr56xE-jfJag@mail.gmail.com>
References: <CAJfpeguPTQ00zVjpwVQ4R8mEqE3aijCzNMAz6Wvr56xE-jfJag@mail.gmail.com> <155905621951.1304.5956310120238620025.stgit@warthog.procyon.org.uk> <155905622921.1304.8775688192987027250.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer [ver #13]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29054.1559135525.1@warthog.procyon.org.uk>
Date:   Wed, 29 May 2019 14:12:05 +0100
Message-ID: <29055.1559135525@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 29 May 2019 13:12:15 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Would it make sense to use relayfs for the implementation of the
> mapped ring buffer?

Note that I reposted the notification patches under the correct cover note
later.  Could you repost your response there.

Subject: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications

David
