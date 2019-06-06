Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0173776A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfFFPGU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 6 Jun 2019 11:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfFFPGU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0269B3086200;
        Thu,  6 Jun 2019 15:06:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C86F810ABD60;
        Thu,  6 Jun 2019 15:06:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <176F8189-3BE9-4B8C-A4D5-8915436338FB@amacapital.net>
References: <176F8189-3BE9-4B8C-A4D5-8915436338FB@amacapital.net> <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <155981413016.17513.10540579988392555403.stgit@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] security: Override creds in __fput() with last fputter's creds [ver #3]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11030.1559833574.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 06 Jun 2019 16:06:14 +0100
Message-ID: <11031.1559833574@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 06 Jun 2019 15:06:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> wrote:

> > So that the LSM can see the credentials of the last process to do an fput()
> > on a file object when the file object is being dismantled, do the following
> > steps:
> > 
> 
> I still maintain that this is a giant design error.

Yes, I know.  This was primarily a post so that Greg could play with the USB
notifications stuff I added.  The LSM support isn't resolved and is unchanged.

> Can someone at least come up with a single valid use case that isn't
> entirely full of bugs?

"Entirely full of bugs"?

How would you propose I deal with Casey's requirement?  I'm getting the
feeling you're going to nak it if I try to fulfil that and he's going to nak
it if I don't.

David
