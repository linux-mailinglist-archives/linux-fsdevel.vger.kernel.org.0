Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314A6143615
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 04:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAUDwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 22:52:54 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:52628 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUDwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:52:54 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 726CC129664;
        Tue, 21 Jan 2020 12:52:53 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00L3qq9W045329
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 12:52:53 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00L3qpbp049522
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 12:52:51 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 00L3qoc3049521;
        Tue, 21 Jan 2020 12:52:50 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
References: <20200119221455.bac7dc55g56q2l4r@pali>
        <87sgkan57p.fsf@mail.parknet.co.jp> <20200120173215.GF15860@mit.edu>
Date:   Tue, 21 Jan 2020 12:52:50 +0900
In-Reply-To: <20200120173215.GF15860@mit.edu> (Theodore Y. Ts'o's message of
        "Mon, 20 Jan 2020 12:32:15 -0500")
Message-ID: <87eevt4ga5.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> On Mon, Jan 20, 2020 at 01:04:42PM +0900, OGAWA Hirofumi wrote:
>> 
>> To be perfect, the table would have to emulate what Windows use. It can
>> be unicode standard, or something other. And other fs can use different
>> what Windows use.
>
> The big question is *which* version of Windows.  vfat has been in use
> for over two decades, and vfat predates Window starting to use Unicode
> in 2001.  Before that, vfat would have been using whatever code page
> its local Windows installation was set to sue; and I'm not sure if
> there was space in the FAT headers to indicate the codepage in use.
>
> It would be entertaining for someone with ancient versions of Windows
> 9x to create some floppy images using codepage 437 and 450, and then
> see what a modern Windows system does with those VFAT images --- would
> it break horibbly when it tries to interpret them as UTF-16?  Or would
> it figure it out?  And if so, how?  Inquiring minds want to know....

Perfect encode converter have to support all versions if Windows changed
the table.  However, right. Normal user would be ok with current unicode
standard, and doesn't care subtle differences.  But strict custom system
will care subtle differences, it is why I'm saying *perfect*.

I'm not against to use current unicode standard. Just a noting.


BTW, VFAT has to store the both of shortname (codepage) and longname
(UTF16), and using both names to open a file. So Windows should be using
current locale codepage to make shortname even latest Windows for VFAT.

And before vfat (in linux fs driver, msdos) is using shortname
(codepage) only.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
