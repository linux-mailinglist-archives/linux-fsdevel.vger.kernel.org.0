Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA2A103DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 04:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEACRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 22:17:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:51090 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfEACRq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 22:17:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9A7B22C4;
        Wed,  1 May 2019 02:17:45 +0000 (UTC)
Date:   Tue, 30 Apr 2019 20:17:41 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH 0/4] vfs: update ->get_link() related documentation
Message-ID: <20190430201741.2ffc48b2@lwn.net>
In-Reply-To: <20190501021423.GQ23075@ZenIV.linux.org.uk>
References: <20190411231630.50177-1-ebiggers@kernel.org>
        <20190422180346.GA22674@gmail.com>
        <20190501002517.GF48973@gmail.com>
        <20190501013649.GO23075@ZenIV.linux.org.uk>
        <20190430194943.4a7916be@lwn.net>
        <20190501021423.GQ23075@ZenIV.linux.org.uk>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 May 2019 03:14:23 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> I do have problems with vfs.txt approach in general and I hope we end up
> with per object type documents; however, that's completely orthogonal to
> format conversion.  IOW, I have no objections whatsoever to format switch
> done first; any migration of e.g. dentry-related parts into a separate
> document, with lifecycle explicitly documented and descriptions of
> methods tied to that can just as well go on top of that.

OK, great.  

That said, let's hold the format conversion for 5.3 (or *maybe*
late-merge-window 5.2).  It's a big set of patches to shovel in at this
point, and while it's good work, it's not screamingly urgent.  My
suggestion would be to take Eric's stuff, it shouldn't be a problem to
adjust to it.

Sound good?

Thanks,

jon
