Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A51419999
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhI0QuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 12:50:02 -0400
Received: from mta-201a.oxsus-vadesecure.net ([51.81.229.180]:45787 "EHLO
        mta-201a.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235285AbhI0QuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:50:02 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2021 12:50:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; bh=D095d71dBQW78/giudMG5ZpKsgPW3hOVnZbqSX
 nWmZk=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1632760999;
 x=1633365799; b=OdCaG/b5iLIYPcAmFYFClUEZjcBBVHHydAC7Aae0EVscDQMQ6MXOljS
 ay6DzX3i0UUmIeCUHld6c46tSe/JIIEozQ48xd2hPkF0LR14/UxrlWJh6WLPKT577QnUBx5
 rCHCpatUSZgYMAWPrXl7YguAWM8mohzKozk9LK2thr6PAD+1CMkEMUQEPma3KfrMEtQaTVB
 KGs8ix1Q1yeHP1E4yQaL2i3zZ1LGs9iEJnnElyL9gEE7d3bZATbHbd43A/iRpryEpEX2jbh
 XQPA1jnssmeU9jkNdbQGZJ8PDckXvjGq8OYPm0h1qefB47nXNYbwhUPc2clpBUlRrWw+WoB
 +CA==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao01p with ngmta
 id 617a60f5-16a8bb7a5559963b; Mon, 27 Sep 2021 16:43:19 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Bernd Schubert'" <bernd.schubert@fastmail.fm>,
        "'Kent Overstreet'" <kent.overstreet@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-bcachefs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <YVEjEwCiqje7yDyV@moria.home.lan> <dbe56ac2-22bd-74d5-ab5d-9f6673884212@fastmail.fm>
In-Reply-To: <dbe56ac2-22bd-74d5-ab5d-9f6673884212@fastmail.fm>
Subject: RE: bcachefs - snapshots
Date:   Mon, 27 Sep 2021 09:43:19 -0700
Message-ID: <000901d7b3be$c7783120$56689360$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHCRnh4jFWeawLJluj8xr2TSBBLCwJ/DqcMq873OMA=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 9/27/21 3:49 AM, Kent Overstreet wrote:
> > Snapshots have been merged! 9 months of work and 3k lines of new =
code,
> > finally released. Some highlights:
> >
> >  - btrfs style subvolumes & snapshots interface
> >  - snapshots are writeable
> >  - highly scalable: number of snapshots is limited only by your disk
> > space
> >  - highly space efficient: no internal fragmentation issues
> >
> > Design doc here: https://bcachefs.org/Snapshots/
> >
> > The core functionality is complete - snapshot creation and deletion
> > works, fsck changes are done (most of the complexity was in making
> > fsck work without O(number of snapshots) performance - tricky). =
Everything
> else is a todo item:
> >
> >  - still need to export different st_dev for files in different =
subvolumes
> >    (we'll never allocate a new inode with an inode number that =
collides with an
> >    inode inother subvolume - but snapshots will naturally result in =
colliding
> >    inode numbers)
>=20
> With my limited high level view on it - shouldn't you discuss with =
Neil about a
> solution and to avoid going the btrfs route for colliding inode =
numbers?

I was going to ask that also having been watching the btrfs subvolume =
saga. As maintainer of the Ganesha user space NFS server I have an =
interest in this also though we haven't had anyone talk about bcachefs =
yet.

Frank

