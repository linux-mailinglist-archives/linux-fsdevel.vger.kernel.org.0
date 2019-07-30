Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671F07B5C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfG3WiM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 18:38:12 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:56930 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfG3WiM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:38:12 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 18:38:10 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id x6UMSZio119596;
        Wed, 31 Jul 2019 01:28:35 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 2u0a9uvs4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 01:28:34 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 31 Jul 2019 01:28:34 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1395.000; Wed, 31 Jul 2019 01:28:34 +0300
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
CC:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "y2038 Mailman List" <y2038@lists.linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        stoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Richard Weinberger <richard@nod.at>, Tejun Heo <tj@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 03/20] timestamp_truncate: Replace users of
 timespec64_trunc
Thread-Topic: [PATCH 03/20] timestamp_truncate: Replace users of
 timespec64_trunc
Thread-Index: AQHVRrCO7mUMDQahbUu7RSH43rBZCqbjOCQAgABUboA=
Date:   Tue, 30 Jul 2019 22:28:33 +0000
Message-ID: <5340224D-5625-48A6-909E-70B24D2084BC@tuxera.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-4-deepa.kernel@gmail.com>
 <87d0hsapwr.fsf@mail.parknet.co.jp>
 <CABeXuvqgaxDSR8N_D1Tdw06g_5PGinZS--6nx-bPtAWP4v+mwg@mail.gmail.com>
In-Reply-To: <CABeXuvqgaxDSR8N_D1Tdw06g_5PGinZS--6nx-bPtAWP4v+mwg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [86.151.122.143]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92684FF0F17B42478243313B03823A34@tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=800
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300224
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Deepa,

> On 30 Jul 2019, at 18:26, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> 
> On Tue, Jul 30, 2019 at 1:27 AM OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp> wrote:
>> 
>> Deepa Dinamani <deepa.kernel@gmail.com> writes:
>> 
>>> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
>>> index 1e08bd54c5fb..53bb7c6bf993 100644
>>> --- a/fs/fat/misc.c
>>> +++ b/fs/fat/misc.c
>>> @@ -307,8 +307,9 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>>>              inode->i_atime = (struct timespec64){ seconds, 0 };
>>>      }
>>>      if (flags & S_CTIME) {
>>> -             if (sbi->options.isvfat)
>>> -                     inode->i_ctime = timespec64_trunc(*now, 10000000);
>>> +             if (sbi->options.isvfat) {
>>> +                     inode->i_ctime = timestamp_truncate(*now, inode);
>>> +             }
>>>              else
>>>                      inode->i_ctime = fat_timespec64_trunc_2secs(*now);
>>>      }
>> 
>> Looks like broken. It changed to sb->s_time_gran from 10000000, and
>> changed coding style.
> 
> This is using a new api: timestamp_truncate(). granularity is gotten
> by inode->sb->s_time_gran. See Patch [2/20]:
> https://lkml.org/lkml/2019/7/29/1853
> 
> So this is not broken if fat is filling in the right granularity in the sb.

It is broken for FAT because FAT has different granularities for different timestamps so it cannot put the correct value in the sb as that only allows one granularity.  Your patch is totally broken for fat as it would be immediately obvious if you spent a few minutes looking at the code...

Best regards,

	Anton

> 
> -Deepa


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

