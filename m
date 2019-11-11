Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773F5F6C40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 02:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKKB0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 20:26:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfKKB0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:26:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAB1O9GW089143;
        Mon, 11 Nov 2019 01:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=rfHdU6/XNEaBywpxAH8t9QCjQ+pIBE8zfhrbaRJmplw=;
 b=QkWoTUzvtNRpdnRIMcpv//Ny6sAc+cat0JxoLpIaQKJh2JEDqZ0CUQTNfneOELaOREvT
 ksf4YKg20Lp5LR0MusZpDxX8OQV9HexLVERN5xw/hIJyx8GtxxEeBWsu7EwGI2LJjxZ8
 LTs9Hn2B/tFrK3ne81nAHEfVdYd/1gymyiSbsaYX7Si8tIHOThu5WKjyXmG5Blxeh4LB
 ijrt3/HEx87aNmWXhjNoQR9cfvBbrEiXchhbOUIM+fkNxcIRYwED2znn+S7cF8oTJC/N
 4bZxy8xCKq9BMTuVUPv9QTVtdWS7YHTjDE6Vm+akNCfV3b1Yngx6sXAM2DxneSQmqvdQ Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w5p3qc27x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 01:26:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAB1MswV097958;
        Mon, 11 Nov 2019 01:26:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w66ytnuta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 01:26:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAB1QH9C001225;
        Mon, 11 Nov 2019 01:26:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 Nov 2019 17:26:16 -0800
Date:   Sun, 10 Nov 2019 17:26:14 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Stancek <jstancek@redhat.com>
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
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: LTP: diotest4.c:476: read to read-only space. returns 0: Success
Message-ID: <20191111012614.GC6235@magnolia>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
 <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9437 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911110010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9437 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911110010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[add the other iomap maintainer to cc]
[add the ext4 list to cc since they just added iomap directio support]
[add the ext4 maintainer for the same reason]

On Thu, Nov 07, 2019 at 07:20:43PM -0500, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > LTP test case dio04 test failed on 32bit kernel running linux next
> > 20191107 kernel.
> > Linux version 5.4.0-rc6-next-20191107.
> > 
> > diotest4    1  TPASS  :  Negative Offset
> > diotest4    2  TPASS  :  removed
> > diotest4    3  TPASS  :  Odd count of read and write
> > diotest4    4  TPASS  :  Read beyond the file size
> > diotest4    5  TPASS  :  Invalid file descriptor
> > diotest4    6  TPASS  :  Out of range file descriptor
> > diotest4    7  TPASS  :  Closed file descriptor
> > diotest4    8  TPASS  :  removed
> > diotest4    9  TCONF  :  diotest4.c:345: Direct I/O on /dev/null is
> > not supported
> > diotest4   10  TPASS  :  read, write to a mmaped file
> > diotest4   11  TPASS  :  read, write to an unmapped file
> > diotest4   12  TPASS  :  read from file not open for reading
> > diotest4   13  TPASS  :  write to file not open for writing
> > diotest4   14  TPASS  :  read, write with non-aligned buffer
> > diotest4   15  TFAIL  :  diotest4.c:476: read to read-only space.
> > returns 0: Success
> > diotest4   16  TFAIL  :  diotest4.c:180: read, write buffer in read-only
> > space
> > diotest4   17  TFAIL  :  diotest4.c:114: read allows  nonexistant
> > space. returns 0: Success
> > diotest4   18  TFAIL  :  diotest4.c:129: write allows  nonexistant
> > space.returns -1: Invalid argument
> > diotest4   19  TFAIL  :  diotest4.c:180: read, write in non-existant space
> > diotest4   20  TPASS  :  read, write for file with O_SYNC
> > diotest4    0  TINFO  :  2/15 test blocks failed
> 
> Smaller reproducer for 32-bit system and ext4 is:
>   openat(AT_FDCWD, "testdata-4.5918", O_RDWR|O_DIRECT) = 4
>   mmap2(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f7b000
>   read(4, 0xb7f7b000, 4096)              = 0 // expects -EFAULT
> 
> Problem appears to be conversion in ternary operator at
> iomap_dio_bio_actor() return. Test passes for me with
> following tweak:

I can't do a whole lot with a code snippet that lacks a proper SOB
header.

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 2f88d64c2a4d..8615b1f78389 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -318,7 +318,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>                 if (pad)
>                         iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
>         }
> -       return copied ? copied : ret;
> +       return copied ? (loff_t) copied : ret;

I'm a little confused on this proposed fix -- why does casting size_t
(aka unsigned long) to loff_t (long long) on a 32-bit system change the
test outcome?  Does this same diotest4 failure happen with XFS?  I ask
because XFS has been using iomap for directio for ages.

AFAICT @copied is a simple byte counter, and the other variable @n that
gets added to @copied is also a simple byte counter -- nobody should
ever be trying to stuff a negative value in there?

(Or is this a bug with the ext4 code that calls iomap_dio_rw?)

--D

>  }
> 
>  static loff_t
> 
