Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8937762FCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 06:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfGIEvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 00:51:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48513 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725886AbfGIEvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:51:40 -0400
Received: from callcc.thunk.org (guestnat-104-133-8-97.corp.google.com [104.133.8.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x694oKBg013059
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Jul 2019 00:50:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8B32242002E; Tue,  9 Jul 2019 00:50:20 -0400 (EDT)
Date:   Tue, 9 Jul 2019 00:50:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: Procedure questions - new filesystem driver..
Message-ID: <20190709045020.GB23646@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
References: <21080.1562632662@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21080.1562632662@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 08:37:42PM -0400, Valdis Klētnieks wrote:
> I have an out-of-tree driver for the exfat file system that I beaten into shape
> for upstreaming. The driver works, and passes sparse and checkpatch (except
> for a number of line-too-long complaints).
> 
> Do you want this taken straight to the fs/ tree, or through drivers/staging?

How have you dealt with the patent claims which Microsoft has
asserted[1] on the exFAT file system design?

[1] https://www.microsoft.com/en-us/legal/intellectualproperty/mtl/exfat-licensing.aspx

I am not making any claims about the validity of Microsoft's patent
assertions on exFAT, one way or another.  But it might be a good idea
for some laywers from the Linux Foundation to render some legal advice
to their employees (namely Greg K-H and Linus Torvalds) regarding the
advisability of taking exFAT into the official Linux tree.

Personally, if Microsoft is going to be unfriendly about not wanting
others to use their file system technology by making patent claims,
why should we reward them by making their file system better by
improvings its interoperability?  (My personal opinion only.)

Cheers,

						- Ted

