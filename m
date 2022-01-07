Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C541D48737A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 08:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiAGHW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 02:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiAGHW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:22:58 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245AFC061201
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 23:22:58 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5jaR-000IFY-NT; Fri, 07 Jan 2022 07:22:55 +0000
Date:   Fri, 7 Jan 2022 07:22:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
Message-ID: <YdfqT+KyYV+pqEc6@zeniv-ca.linux.org.uk>
References: <20220105180259.115760-1-bfoster@redhat.com>
 <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
 <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
 <b14cd1790c18e2be0ab6e5cfce91dee5611ceb9d.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b14cd1790c18e2be0ab6e5cfce91dee5611ceb9d.camel@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:04:46PM +0800, Ian Kent wrote:

> > Ummm....  Mind resending that?  I'm still digging myself from under
> > the huge pile of mail, and this seems to have been lost in process...
> 
> Brain wrote and sent the patch, I'm sure he'll resent it.
> 
> The re-factor I mention is just pulling out the needed bits from
> complete_walk() rather than open coding it or reverting the original
> change, commit 72287417abd1 ("open_last_lookups(): don't abuse
> complete_walk() when all we want is unlazy").

Good grief...  Ian, please fix your MUA - something's crapping those
NBSP (this time - UTF8 ones) into your replies...

Anyway, the problem is that it's not an equivalent transformation
and I'm not sure at the moment that there won't be interplay with
the things added during the last couple of years.

Tomorrow...
