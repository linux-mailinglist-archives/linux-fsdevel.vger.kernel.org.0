Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BAB12D54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfECMQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 08:16:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:47900 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfECMQ6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 08:16:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 21D5F7DC;
        Fri,  3 May 2019 12:16:57 +0000 (UTC)
Date:   Fri, 3 May 2019 06:16:54 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH 0/4] vfs: update ->get_link() related documentation
Message-ID: <20190503061654.58c26b5e@lwn.net>
In-Reply-To: <20190501041515.GA9149@eros.localdomain>
References: <20190411231630.50177-1-ebiggers@kernel.org>
        <20190422180346.GA22674@gmail.com>
        <20190501002517.GF48973@gmail.com>
        <20190501013649.GO23075@ZenIV.linux.org.uk>
        <20190430194943.4a7916be@lwn.net>
        <20190501021423.GQ23075@ZenIV.linux.org.uk>
        <20190501041515.GA9149@eros.localdomain>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 May 2019 14:15:15 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Since the conversion set I did did not fundamentally change the content
> but just moved it to the source files it seemed like this set was a dead
> end.
> 
> FWIW I don't think that a _simple_ conversion for vfs.txt to vfs.rst is
> useful if the VFS is to be re-documented.  It isn't trivial to do if we
> want to make any use of RST features and if we do not want to then why
> bother converting it?

I think it's worth converting; it's sufficiently better than nothing,
IMO, that we don't want to just throw it away.  If we bring it up to
current formatting standards and make it more accessible, it just might
motivate others to help make it better.  So if you feel like sending me a
current patch set, I'd be happy to apply it.

Thanks,

jon
