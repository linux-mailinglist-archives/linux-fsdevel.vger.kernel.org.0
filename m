Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06E143432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgATWqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 17:46:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56152 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATWqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:46:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itfoP-00CHqS-Q4; Mon, 20 Jan 2020 22:46:25 +0000
Date:   Mon, 20 Jan 2020 22:46:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120224625.GE8904@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp>
 <20200120214046.f6uq7rlih7diqahz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120214046.f6uq7rlih7diqahz@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 10:40:46PM +0100, Pali Rohár wrote:

> Ok, I did some research. It took me it longer as I thought as lot of
> stuff is undocumented and hard to find all relevant information.
> 
> So... fastfat.sys is using ntos function RtlUpcaseUnicodeString() which
> takes UTF-16 string and returns upper case UTF-16 string. There is no
> mapping table in fastfat.sys driver itself.

Er...  Surely it's OK to just tabulate that function on 65536 values
and see how could that be packed into something more compact?  Whatever
the license of that function might be, this should fall under
interoperability exceptions...

Actually, I wouldn't be surprised if f(x) - x would turn out to be constant
on large enough intervals to provide sufficiently compact representation...

What am I missing here?
