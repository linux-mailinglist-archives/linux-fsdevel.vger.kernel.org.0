Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B431430E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgATRiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 12:38:18 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38834 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgATRiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:38:17 -0500
Received: from callcc.thunk.org ([38.98.37.142])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00KHboLl005395
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 12:37:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 689AB420057; Mon, 20 Jan 2020 12:37:49 -0500 (EST)
Date:   Mon, 20 Jan 2020 12:37:49 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Pali =?iso-8859-1?Q?Roh=E1r'?=" <pali.rohar@gmail.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120173749.GG15860@mit.edu>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:07:20PM +0000, David Laight wrote:
> What happens if the filesystem has filenames that invalid UTF8 sequences
> or multiple filenames that decode from UTF8 to the same 'wchar' value.
> Never mind ones that are just case-differences for the same filename.
> 
> UTF8 is just so broken it should never have been allowed to become
> a standard.

Internationalization is an overconstrained problem which is impacted
and influenced by human politics, incuding from the Cold War and who
attended which internal standards bodies meetings.  So much so that an
I18N expert (very knowledgable about the problems in this domain) has
been known to have said (in a bar, late at night, and after much
alcohol) that it would be simpler to teach the entire human race
English.

Unfortunately, that's not going to happen, and if we are going to deal
with the market of "everyone which doesn't speak English", we're going
to have to live with Unicode, warts at and all.  Seriously speaking,
UTF-8 is the worst encoding, except for all of the others.  :-)

						- Ted
