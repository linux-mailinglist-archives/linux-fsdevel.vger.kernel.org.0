Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC04143CC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 13:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgAUM0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 07:26:38 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:60894 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUM0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:26:38 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 08B13129664;
        Tue, 21 Jan 2020 21:26:37 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00LCQZ9I061591
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 21:26:36 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00LCQZK4079652
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 21:26:35 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 00LCQYm5079651;
        Tue, 21 Jan 2020 21:26:34 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
References: <20200119221455.bac7dc55g56q2l4r@pali>
        <87sgkan57p.fsf@mail.parknet.co.jp> <20200120173215.GF15860@mit.edu>
        <87eevt4ga5.fsf@mail.parknet.co.jp>
        <20200121110049.4upreexmv5kxwp5n@pali>
Date:   Tue, 21 Jan 2020 21:26:34 +0900
In-Reply-To: <20200121110049.4upreexmv5kxwp5n@pali> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message of
        "Tue, 21 Jan 2020 12:00:49 +0100")
Message-ID: <87muahov0l.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

> On Tuesday 21 January 2020 12:52:50 OGAWA Hirofumi wrote:
>> BTW, VFAT has to store the both of shortname (codepage) and longname
>> (UTF16), and using both names to open a file. So Windows should be using
>> current locale codepage to make shortname even latest Windows for VFAT.
>
> fastfat.sys stores into shortnames only 7bit characters. Which is same
> in all OEM codepages. Non-7bit are replaced by underline or shortened by
> "~N" syntax. According to source code of fastfat.sys it has some
> registry option to allow usage also of full 8bit OEM codepage.
>
> So default behavior seems to be safe.

Are you sure if default is 7bit only? I'm pretty sure, at least, old
Windows version stored 8bit chars by default install.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
