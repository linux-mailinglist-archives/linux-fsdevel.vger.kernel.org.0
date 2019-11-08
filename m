Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65918F3CC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 01:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfKHAUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 19:20:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46820 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbfKHAUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573172449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gCaMc6tX9QOhF6O+c6COJocW0Fk5ySJnwtoUCLt61c=;
        b=HpVmfJD/DQBRv/cvvDjvriBP+VXRY5WTbazk7tug5xze4QzsM8kReqpiBwmnTi9Zo6RNrS
        5ujPrW/W+JFqcUeZWSd9lC3OgHwJXH4OtpjYm5/am+u+YnXM5e0s7t5Y7dczZJnjXBG5Hi
        ipS3sbIx7yxsJ6S4aXnNXcMLaRd3oKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-iBgSgiDTNUSAR9EJuJy-IQ-1; Thu, 07 Nov 2019 19:20:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61750800C61;
        Fri,  8 Nov 2019 00:20:44 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E05F5C3FD;
        Fri,  8 Nov 2019 00:20:44 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id BA74118095FF;
        Fri,  8 Nov 2019 00:20:43 +0000 (UTC)
Date:   Thu, 7 Nov 2019 19:20:43 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, darrick.wong@oracle.com
Cc:     LTP List <ltp@lists.linux.it>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, chrubis <chrubis@suse.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org
Message-ID: <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
In-Reply-To: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
Subject: Re: LTP: diotest4.c:476: read to read-only space. returns 0:
 Success
MIME-Version: 1.0
X-Originating-IP: [10.43.17.163, 10.4.195.16]
Thread-Topic: diotest4.c:476: read to read-only space. returns 0: Success
Thread-Index: XegtwwjoOKT9tnnmixJeWQ/ZMQQAiQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: iBgSgiDTNUSAR9EJuJy-IQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



----- Original Message -----
> LTP test case dio04 test failed on 32bit kernel running linux next
> 20191107 kernel.
> Linux version 5.4.0-rc6-next-20191107.
>=20
> diotest4    1  TPASS  :  Negative Offset
> diotest4    2  TPASS  :  removed
> diotest4    3  TPASS  :  Odd count of read and write
> diotest4    4  TPASS  :  Read beyond the file size
> diotest4    5  TPASS  :  Invalid file descriptor
> diotest4    6  TPASS  :  Out of range file descriptor
> diotest4    7  TPASS  :  Closed file descriptor
> diotest4    8  TPASS  :  removed
> diotest4    9  TCONF  :  diotest4.c:345: Direct I/O on /dev/null is
> not supported
> diotest4   10  TPASS  :  read, write to a mmaped file
> diotest4   11  TPASS  :  read, write to an unmapped file
> diotest4   12  TPASS  :  read from file not open for reading
> diotest4   13  TPASS  :  write to file not open for writing
> diotest4   14  TPASS  :  read, write with non-aligned buffer
> diotest4   15  TFAIL  :  diotest4.c:476: read to read-only space.
> returns 0: Success
> diotest4   16  TFAIL  :  diotest4.c:180: read, write buffer in read-only
> space
> diotest4   17  TFAIL  :  diotest4.c:114: read allows  nonexistant
> space. returns 0: Success
> diotest4   18  TFAIL  :  diotest4.c:129: write allows  nonexistant
> space.returns -1: Invalid argument
> diotest4   19  TFAIL  :  diotest4.c:180: read, write in non-existant spac=
e
> diotest4   20  TPASS  :  read, write for file with O_SYNC
> diotest4    0  TINFO  :  2/15 test blocks failed

Smaller reproducer for 32-bit system and ext4 is:
  openat(AT_FDCWD, "testdata-4.5918", O_RDWR|O_DIRECT) =3D 4
  mmap2(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb7f7=
b000
  read(4, 0xb7f7b000, 4096)              =3D 0 // expects -EFAULT

Problem appears to be conversion in ternary operator at
iomap_dio_bio_actor() return. Test passes for me with
following tweak:

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 2f88d64c2a4d..8615b1f78389 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -318,7 +318,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, lo=
ff_t length,
                if (pad)
                        iomap_dio_zero(dio, iomap, pos, fs_block_size - pad=
);
        }
-       return copied ? copied : ret;
+       return copied ? (loff_t) copied : ret;
 }

 static loff_t

