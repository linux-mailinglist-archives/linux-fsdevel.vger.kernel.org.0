Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4342D3EC70B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 05:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhHODx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 23:53:29 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:60986 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhHODx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 23:53:29 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Aug 2021 23:53:27 EDT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 8176115F93A;
        Sun, 15 Aug 2021 12:43:01 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-22) with ESMTPS id 17F3gtqK259876
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 Aug 2021 12:42:56 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-22) with ESMTPS id 17F3gtTX1634462
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 Aug 2021 12:42:55 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 17F3glQI1634454;
        Sun, 15 Aug 2021 12:42:47 +0900
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
Date:   Sun, 15 Aug 2021 12:42:47 +0900
In-Reply-To: <20210808162453.1653-2-pali@kernel.org> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message
        of "Sun, 8 Aug 2021 18:24:34 +0200")
Message-ID: <87h7frtlu0.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> Currently iocharset=utf8 mount option is broken and error is printed to
> dmesg when it is used. To use UTF-8 as iocharset, it is required to use
> utf8=1 mount option.
>
> Fix iocharset=utf8 mount option to use be equivalent to the utf8=1 mount
> option and remove printing error from dmesg.

This change is not equivalent to utf8=1. In the case of utf8=1, vfat
uses iocharset's conversion table and it can handle more than ascii.

So this patch is incompatible changes, and handles less chars than
utf8=1. So I think this is clean though, but this would be regression
for user of utf8=1.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
