Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1619F6FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfKKITx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 03:19:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34983 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726768AbfKKITw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573460390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+d9HgiQd/ROeqheIWevtzZ1281FA0vSMCBkopaTcHI=;
        b=dT2s5dAmT+wheA83Nw7+lNiR+wyzwBWdaTMts40zzh7gCofBz/D28p5hpBH715/RDn+HEz
        78eWT0b2c69dvtYYuDNzPO4jcjrnh5tpMH0DzlTa5vZK9U0YsaN2mtfRKIqKrOVVjN2p6H
        wdpBvHDpOJ4zO15Y+mUNodmBqz2sC5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-_0XAJepROSaUejme0jEEIQ-1; Mon, 11 Nov 2019 03:19:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CAFC107ACC4;
        Mon, 11 Nov 2019 08:19:42 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BFE4100EBA6;
        Mon, 11 Nov 2019 08:19:41 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9754118089C8;
        Mon, 11 Nov 2019 08:19:40 +0000 (UTC)
Date:   Mon, 11 Nov 2019 03:19:40 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        LTP List <ltp@lists.linux.it>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, chrubis <chrubis@suse.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Message-ID: <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191111012614.GC6235@magnolia>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com> <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com> <20191111012614.GC6235@magnolia>
Subject: Re: LTP: diotest4.c:476: read to read-only space. returns 0:
 Success
MIME-Version: 1.0
X-Originating-IP: [10.43.17.163, 10.4.195.18]
Thread-Topic: diotest4.c:476: read to read-only space. returns 0: Success
Thread-Index: OoFxfOUloBUkdPsY/du59GUryWTVqQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _0XAJepROSaUejme0jEEIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


----- Original Message -----
> I can't do a whole lot with a code snippet that lacks a proper SOB
> header.

I'll resend as a patch, maybe split it to 2 returns instead.

> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 2f88d64c2a4d..8615b1f78389 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -318,7 +318,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos=
,
> > loff_t length,
> >                 if (pad)
> >                         iomap_dio_zero(dio, iomap, pos, fs_block_size -
> >                         pad);
> >         }
> > -       return copied ? copied : ret;
> > +       return copied ? (loff_t) copied : ret;
>=20
> I'm a little confused on this proposed fix -- why does casting size_t
> (aka unsigned long) to loff_t (long long) on a 32-bit system change the
> test outcome?

Ternary operator has a return type and an attempt is made to convert
each of operands to the type of the other. So, in this case "ret"
appears to be converted to type of "copied" first. Both have size of
4 bytes on 32-bit x86:

size_t copied =3D 0;
int ret =3D -14;
long long actor_ret =3D copied ? copied : ret;

On x86_64: actor_ret =3D=3D -14;
On x86   : actor_ret =3D=3D 4294967282

> Does this same diotest4 failure happen with XFS?  I ask
> because XFS has been using iomap for directio for ages.

Yes, it fails on XFS too.

