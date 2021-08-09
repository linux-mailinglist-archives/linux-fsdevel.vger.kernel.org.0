Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46F53E4BB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 20:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhHISBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhHISAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:00:55 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE9C06179C
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 11:00:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d2so13210150qto.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AAhrsJC66Dx61Rd+R0En9xSeyn+Y7a3fdKNMwl3SmV8=;
        b=C0z7fOVtv7xwyNq2ULxDTWBgiDiksaU5+3HrkSSE0+YAMfOwDGb3z2QxgMzpBwRhPv
         IJIv8Jcn2zdkSUNM5svDTPmzFJom/BDy2o4AuFQLhDPHTF6I15WVw/dSxJoqsVOSZ1Cb
         W4oQq3okSZ+c6t9/tXu1mtxGEjfyOfLs5PO3JPTOAzr1aESarTGuxT4PlJIfCs78j5tf
         EJr6/POmRH4eknj1regIdXrAR5fCHCeWaaDHnTNfXNqLroOKMPWZWQrn4b1SAFksBLPj
         3ozwqoWMzQNUQaaWHVTFNsV2eGVzErWUtSvwp7srUzrIDAjM/UP1OEZMwfJ6NvEMbgyW
         6e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AAhrsJC66Dx61Rd+R0En9xSeyn+Y7a3fdKNMwl3SmV8=;
        b=Sl35/zZGVxYUI0XICoKnN0+Sg1dIcBfTCqA14V0fkKeR1lwiKvwv7HCAyUl21BAWHA
         hiImOD3x0uCOSPoZaHr5O6zaohbq2ggGWQqFEFvM6yeihfRYTCFwi068wbBVI4OVjPRL
         E5p45S/Vu5ZQy0b9gbTt9sjY7SN6yksxHtg3fFO0rsyumDJPeifeS6PP0DMvo7p1xRdk
         vbHwohDgafB5QGnQ2KNuiB1qvL1+zEVlfbS0tyNQ3l5yc+527iLC0T+Pe8kU908xch0o
         szHc8mlpJL25eNm3Z44A07jSytS1n3IMjtxuMnhZGlhwdk6zm2PH3uOeu3NXT51n7Ynw
         VRUQ==
X-Gm-Message-State: AOAM5301r2AOa7xFpRvmrI8a8rtYUc01fAYhjZSY00CNY50oVEvujQQ8
        nfqn4tSUUOfPjMPdlz8WYsVSXQ==
X-Google-Smtp-Source: ABdhPJzBGaMUF7I+EqzTqVqs/l3Cby4L23FljkyG1TqQehnViMfTh5LhLZoOh/mvaEH+yytNB+IJ1g==
X-Received: by 2002:a05:622a:243:: with SMTP id c3mr10162127qtx.61.1628532033991;
        Mon, 09 Aug 2021 11:00:33 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:615b:6e84:29a:3bc6])
        by smtp.gmail.com with ESMTPSA id m188sm9658536qkc.99.2021.08.09.11.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 11:00:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 11/20] hfs: Explicitly set hsb->nls_disk when
 hsb->nls_io is set
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <YRFnz6kn1UbSCN/S@casper.infradead.org>
Date:   Mon, 9 Aug 2021 11:00:29 -0700
Cc:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E85E6FF7-AA14-4FA6-82AA-859D93BD0069@dubeyko.com>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-12-pali@kernel.org>
 <D0302F93-BAE5-48F0-87D0-B68B10D7757B@dubeyko.com>
 <YRFnz6kn1UbSCN/S@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 9, 2021, at 10:37 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Mon, Aug 09, 2021 at 10:31:55AM -0700, Viacheslav Dubeyko wrote:
>>> On Aug 8, 2021, at 9:24 AM, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>>>=20
>>> It does not make any sense to set hsb->nls_io (NLS iocharset used =
between
>>> VFS and hfs driver) when hsb->nls_disk (NLS codepage used between =
hfs
>>> driver and disk) is not set.
>>>=20
>>> Reverse engineering driver code shown what is doing in this special =
case:
>>>=20
>>>   When codepage was not defined but iocharset was then
>>>   hfs driver copied 8bit character from disk directly to
>>>   16bit unicode wchar_t type. Which means it did conversion
>>>   from Latin1 (ISO-8859-1) to Unicode because first 256
>>>   Unicode code points matches 8bit ISO-8859-1 codepage table.
>>>   So when iocharset was specified and codepage not, then
>>>   codepage used implicit value "iso8859-1".
>>>=20
>>> So when hsb->nls_disk is not set and hsb->nls_io is then explicitly =
set
>>> hsb->nls_disk to "iso8859-1".
>>>=20
>>> Such setup is obviously incompatible with Mac OS systems as they do =
not
>>> support iso8859-1 encoding for hfs. So print warning into dmesg =
about this
>>> fact.
>>>=20
>>> After this change hsb->nls_disk is always set, so remove code paths =
for
>>> case when hsb->nls_disk was not set as they are not needed anymore.
>>=20
>>=20
>> Sounds reasonable. But it will be great to know that the change has =
been tested reasonably well.
>=20
> I don't think it's reasonable to ask Pali to test every single =
filesystem.
> That's something the maintainer should do, as you're more likely to =
have
> the infrastructure already set up to do testing of your filesystem and
> be aware of fun corner cases and use cases than someone who's working
> across all filesystems.

I see the point. But the whole approach needs to be tested as minimum =
for one particular file system. :) And it could be any favorite one.

Thanks,
Slava.


