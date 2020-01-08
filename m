Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60AEE133C02
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 08:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgAHHGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 02:06:40 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:47162 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgAHHGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:06:40 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 02:06:39 EST
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 6D12315CBE2;
        Wed,  8 Jan 2020 16:00:34 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00870Xa2011512
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 8 Jan 2020 16:00:34 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00870Wqc046780
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 8 Jan 2020 16:00:32 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 00870HJl046772;
        Wed, 8 Jan 2020 16:00:17 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Jan Kara <jack@suse.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@redhat.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Unification of filesystem encoding options
References: <20200102211855.gg62r7jshp742d6i@pali>
        <20200107133233.GC25547@quack2.suse.cz>
        <20200107173842.ciskn4ahuhiklycm@pali>
Date:   Wed, 08 Jan 2020 16:00:17 +0900
In-Reply-To: <20200107173842.ciskn4ahuhiklycm@pali> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message of
        "Tue, 7 Jan 2020 18:38:42 +0100")
Message-ID: <87y2uiigam.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

>> > 3) Add support for iocharset= and codepage= options for msdos
>> > filesystem. It shares lot of pars of code with vfat driver.
>> 
>> I guess this is for msdos filesystem maintainers to decide.
>
> Yes!

Of course, it's ok to add though. If someone really wants to use, and
someone works for it...

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
