Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDCF30082A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbhAVQCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbhAVQCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:02:17 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248FC0613D6;
        Fri, 22 Jan 2021 08:01:31 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 465896EA0; Fri, 22 Jan 2021 11:01:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 465896EA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611331289;
        bh=C1uyBn2BQyVBzkzoIFDiDLUaJ4GVYrCTmuJOgOCNLm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wS+CszPvgU+UvUOL7glyffz488y1gAW2j+6KJGj+4oMkNlv7gRF31pfQZjlqnHUT0
         1yUos2dQdiC5ry8dTqU/3rvAsvNqyzNB3vhDLNVSC8R0w+7zf0DydKatw+L5rjSrFG
         VKX7er2E95K03LAilNk+NFD2lxGQVieg6S9d4xhI=
Date:   Fri, 22 Jan 2021 11:01:29 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/25] Network fs helper library & fscache kiocb API
Message-ID: <20210122160129.GB18583@fieldses.org>
References: <20210121190937.GE20964@fieldses.org>
 <20210121174306.GB20964@fieldses.org>
 <20210121164645.GA20964@fieldses.org>
 <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
 <1794286.1611248577@warthog.procyon.org.uk>
 <1851804.1611255313@warthog.procyon.org.uk>
 <1856291.1611259704@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1856291.1611259704@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 08:08:24PM +0000, David Howells wrote:
> J. Bruce Fields <bfields@fieldses.org> wrote:
> > So, I'm still confused: there must be some case where we know fscache
> > actually works reliably and doesn't corrupt your data, right?
> 
> Using ext2/3, for example.  I don't know under what circumstances xfs, ext4
> and btrfs might insert/remove blocks of zeros, but I'm told it can happen.

Do ext2/3 work well for fscache in other ways?

--b.
