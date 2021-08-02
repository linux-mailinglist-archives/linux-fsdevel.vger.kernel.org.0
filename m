Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FD3DDBA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhHBOzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 10:55:14 -0400
Received: from mta-102a.oxsus-vadesecure.net ([51.81.61.66]:33925 "EHLO
        mta-102a.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233981AbhHBOzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:55:13 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 10:55:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; bh=kOYgkgt1Eovr4+CuMMxXz1DZVQXHQDhi+reUiD
 H50Qk=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1627915653;
 x=1628520453; b=k5hQVO/SHE5D98YVr+2IwaENw1BGVaPvd798Bvz8noqJFOrQHrwQvVd
 acbkXb+GuUdFmtD7Im7xt5N3I3dDUjx2MMuH6wUFjkTcpQEi3tXU0YMZpM8MgNPjmEK6wXX
 7n66vUEYcA1iSZCaAltdccPBuqKqIoX8gGFuzWfhGRj97mc1UnsfIpcv75bNhoafaxxIPs1
 4VmdXE7SLVp2Lngptvwwwy1hsokE4TtY0QO2xHns8t07DsqzckT2tfcQPjY3pbdnA+vIcke
 NKw7QwjOjrrsYbxqE8TXLjuLhi7L41SA+6xJHUGBtYowQI4hEuS9yH7rV3XVDCedWJwuSxH
 2pg==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao02p with ngmta
 id af69139b-169784a9170c7b41; Mon, 02 Aug 2021 14:47:33 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Amir Goldstein'" <amir73il@gmail.com>,
        "'NeilBrown'" <neilb@suse.de>
Cc:     "'Al Viro'" <viro@zeniv.linux.org.uk>,
        "'Miklos Szeredi'" <miklos@szeredi.hu>,
        "'Christoph Hellwig'" <hch@infradead.org>,
        "'Josef Bacik'" <josef@toxicpanda.com>,
        "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Chris Mason'" <clm@fb.com>, "'David Sterba'" <dsterba@suse.com>,
        "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'Linux NFS list'" <linux-nfs@vger.kernel.org>,
        "'Btrfs BTRFS'" <linux-btrfs@vger.kernel.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown> <162742546548.32498.10889023150565429936.stgit@noble.brown> <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk> <162762290067.21659.4783063641244045179@noble.neil.brown.name> <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com> <162762562934.21659.18227858730706293633@noble.neil.brown.name> <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com> <162763043341.21659.15645923585962859662@noble.neil.brown.name> <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com> <162787790940.32159.14588617595952736785@noble.neil.brown.name> <YQeB3ASDyO0wSgL4@zeniv-ca.linux.org.uk> <162788285645.32159.12666247391785546590@noble.neil.brown.name> <CAOQ4uxgnGWMUvtyJ0MMxMzHFwiyR68FHorDNmLSva0CdpVNNcQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgnGWMUvtyJ0MMxMzHFwiyR68FHorDNmLSva0CdpVNNcQ@mail.gmail.com>
Subject: RE: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
Date:   Mon, 2 Aug 2021 07:47:31 -0700
Message-ID: <02d201d787ad$53dfd930$fb9f8b90$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQGsQ4rocC8JdciffDlk4WCbcNd5JAH9XzyyAdavEn8CATAmtQHAf3kAAq0/zdEChfj1cAJ+oSVgAZcNCFgCKp+e3AHI9mimAhJ4xdwCcfkHUqrsHG6A
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> In any case, instead of changing st_dev and st_ino or changing the =
world to
> work with file handles, why not add inode generation (and maybe subvol =
id) to
> statx().
> filesystem that care enough will provide this information and tools =
that care
> enough will use it.

And how is NFS (especially V2 and V3 - V4.2 at least can add attributes) =
going to provide these values for statx if applications are going to =
start depending on them, and especially, will this work for those =
applications that need to distinguish inodes that are working on an NFS =
exported btrfs filesystem?

Frank

