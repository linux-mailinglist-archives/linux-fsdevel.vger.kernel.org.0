Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E73EC8B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhHOLXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 07:23:44 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:32808 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhHOLXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 07:23:44 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id D641815F93A;
        Sun, 15 Aug 2021 20:23:09 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-22) with ESMTPS id 17FBN8lj265086
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 Aug 2021 20:23:09 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-22) with ESMTPS id 17FBN8Jk1660981
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 Aug 2021 20:23:08 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 17FBN6An1660978;
        Sun, 15 Aug 2021 20:23:06 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 01/20] fat: Fix iocharset=utf8 mount option
References: <20210808162453.1653-1-pali@kernel.org>
        <20210808162453.1653-2-pali@kernel.org>
        <87h7frtlu0.fsf@mail.parknet.co.jp>
        <20210815094224.dswbjywnhvajvzjv@pali>
Date:   Sun, 15 Aug 2021 20:23:06 +0900
In-Reply-To: <20210815094224.dswbjywnhvajvzjv@pali> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message of
        "Sun, 15 Aug 2021 11:42:24 +0200")
Message-ID: <871r6vt0it.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To: Pali Rohár <pali@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  linux-ntfs-dev@lists.sourceforge.net,  linux-cifs@vger.kernel.org,  jfs-discussion@lists.sourceforge.net,  linux-kernel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>,  "Theodore Y . Ts'o" <tytso@mit.edu>,  Luis de Bethencourt <luisbg@kernel.org>,  Salah Triki <salah.triki@gmail.com>,  Andrew Morton <akpm@linux-foundation.org>,  Dave Kleikamp <shaggy@kernel.org>,  Anton Altaparmakov <anton@tuxera.com>,  Pavel Machek <pavel@ucw.cz>,  Marek Behún <marek.behun@nic.cz>,  Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 01/20] fat: Fix iocharset=utf8 mount option
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Gcc: nnimap+ibmpc.myhome.or.jp:Sent
--text follows this line--
To: Pali Rohár <pali@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  linux-ntfs-dev@lists.sourceforge.net,  linux-cifs@vger.kernel.org,  jfs-discussion@lists.sourceforge.net,  linux-kernel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>,  "Theodore Y . Ts'o" <tytso@mit.edu>,  Luis de Bethencourt <luisbg@kernel.org>,  Salah Triki <salah.triki@gmail.com>,  Andrew Morton <akpm@linux-foundation.org>,  Dave Kleikamp <shaggy@kernel.org>,  Anton Altaparmakov <anton@tuxera.com>,  Pavel Machek <pavel@ucw.cz>,  Marek Behún <marek.behun@nic.cz>,  Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 01/20] fat: Fix iocharset=utf8 mount option
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Gcc: nnimap+ibmpc.myhome.or.jp:Sent
--text follows this line--
Pali Rohár <pali@kernel.org> writes:

>> This change is not equivalent to utf8=1. In the case of utf8=1, vfat
>> uses iocharset's conversion table and it can handle more than ascii.
>> 
>> So this patch is incompatible changes, and handles less chars than
>> utf8=1. So I think this is clean though, but this would be regression
>> for user of utf8=1.
>
> I do not think so... But please correct me, as this code around is mess.
>
> Without this change when utf8=1 is set then iocharset= encoding is used
> for case-insensitivity implementation (toupper / tolower conversion).
> For all other parts are use correct utf8* conversion functions.
>
> But you use touppper / tolower functions from iocharset= encoding on
> stream of utf8 bytes then you either get identity or some unpredictable
> garbage in utf8. So when comparing two (different) non-ASCII filenames
> via this method you in most cases get that filenames are different.
> Because converting their utf8 bytes via toupper / tolower functions from
> iocharset= encoding results in two different byte sequences in most
> cases. Even for two utf8 case-insensitive same strings.
>
> But you can play with it and I guess it is possible to find two
> different utf8 strings which after toupper / tolower conversion from
> some iocharset= encoding would lead to same byte sequence.
>
> This patch uses for utf8 tolower / touppser function simple 7-bit
> tolower / toupper ascii function. And so for 7-bit ascii file names
> there is no change.
>
> So this patch changes behavior when comparing non 7-bit ascii file
> names, but only in cases when previously two different file names were
> marked as same. As now they are marked correctly as different. So this
> is changed behavior, but I guess it is bug fix which is needed.
> If you want I can put this change into separate patch.
>
> Issue that two case-insensitive same files are marked as different is
> not changed by this patch and therefore this issue stay here.

OK, sure. utf8 looks like broken than I was thinking (although user can
use iocharset=ascii and utf8=1 for this). The code might be better to
clean up a bit more though, looks like good basically.

One thing, please update FAT_DEFAULT_IOCHARSET help in Kconfig and
Documentation/filesystems/vfat.rst (with new warning about iocharset=utf8).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
