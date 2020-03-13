Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C63184CE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCMQtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 12:49:14 -0400
Received: from hr2.samba.org ([144.76.82.148]:26618 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMQtO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Cc:To:From:Date;
        bh=4vhKPMR7SeZxlf7ZpBtqsj7Dz5N+IM1oiuv9cBc+Ink=; b=iKm45esCD3Z7W10y62bNXkvQId
        yQpjzJBHnGD8w/MVLMPLZSzXI3W1J0ESUAzUdCzKsrTNuazHyXEZuU6Un0upKxGdtnHfRTNdzXqlL
        E8WpeKrqXYyNYPmOy+ukbYgpqiE16Za+rqYwxLlMvA22gUMj8SxYEbGGbeD/1a+4eqihAs4n9I2Tb
        NZOOZh2TvLbutKsObumOFis7hoi4QZbGdla4YE0M25C2Ze8dCxTMvLgNLYzAZCxE0NH5vs1maItsK
        9GzZP4YjFpJt2eAqHJmS8SaZqvxN1AsLwDyH76zUZ4Zo1vVDoXJASgCkN2QfVQzlHV0GfIGN0DVOU
        uD1tuibwoGkWrtuinM5SyWGu+mx0eCb/BYwZjEssXYc+bj0KTc0I+E/FVYy5313XY6P6ghsaorG21
        RRRfxJvciWou6kGv/9FQR66d98ys9flGp9S8QD5tUXbxcmQZQbPASuDNh5aB9ANU5diyWYtTkeRnc
        d3m96Qz+vwBVqoehb9dqX+1G;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1jCnUj-0001NY-Ee; Fri, 13 Mar 2020 16:49:09 +0000
Date:   Fri, 13 Mar 2020 09:48:57 -0700
From:   Jeremy Allison <jra@samba.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph =?iso-8859-1?Q?B=F6hme?= <slow@samba.org>,
        Volker Lendecke <vl@sernet.de>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200313164857.GA17682@jeremy-acer>
Reply-To: Jeremy Allison <jra@samba.org>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
 <20200313095901.tdv4vl7envypgqfz@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313095901.tdv4vl7envypgqfz@yavin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 08:59:01PM +1100, Aleksa Sarai wrote:
> 
> I have heard some folks asking for a way to create a directory and get a
> handle to it atomically -- so arguably this is something that could be
> inside openat2()'s feature set (O_MKDIR?). But I'm not sure how popular
> of an idea this is.

This would be very useful to prevent race conditions between making
a directory and EA's on it, as are needed by Samba for
DOS attributes and Windows/NFSv4 ACLS.
