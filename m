Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8A14470F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 23:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUWOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 17:14:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53156 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUWOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:14:51 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iu1nL-000IWy-7c; Tue, 21 Jan 2020 22:14:47 +0000
Date:   Tue, 21 Jan 2020 22:14:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200121221447.GD23230@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp>
 <20200120214046.f6uq7rlih7diqahz@pali>
 <20200120224625.GE8904@ZenIV.linux.org.uk>
 <20200120235745.hzza3fkehlmw5s45@pali>
 <20200121000701.GG8904@ZenIV.linux.org.uk>
 <20200121203405.7g7gisb3q55u2y2f@pali>
 <20200121213625.GB23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121213625.GB23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:36:25PM +0000, Al Viro wrote:
> On Tue, Jan 21, 2020 at 09:34:05PM +0100, Pali Rohár wrote:
> 
> > This is a great idea to get FAT equivalence classes. Thank you!
> > 
> > Now I quickly tried it... and it failed. FAT has restriction for number
> > of files in a directory, so I would have to do it in more clever way,
> > e.g prepare N directories and then try to create/open file for each
> > single-point string in every directory until it success or fail in every
> > one.
> 
> IIRC, the limitation in root directory was much harder than in
> subdirectories...  Not sure, though - it had been a long time since
> I had to touch *FAT for any reasons...

Interesting...  FWIW, Linux vfat happily creates 65536 files in root
directory.  What are the native limits?
