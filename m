Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB83400763
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhICVTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 17:19:02 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:35806 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233367AbhICVTB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 17:19:01 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 183LEpst046545;
        Sat, 4 Sep 2021 00:17:31 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 3au6qc188e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 00:17:31 +0300
Received: from tuxera.com (77.86.224.47) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sat, 4 Sep
 2021 00:17:30 +0300
Date:   Sat, 4 Sep 2021 00:17:20 +0300
From:   Szabolcs Szakacsits <szaka@tuxera.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        <zajec5@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: NTFS testing (was: [GIT PULL] vboxsf fixes for 5.14-1
In-Reply-To: <YTJf4lBjnliqhI4D@sol.localdomain>
Message-ID: <alpine.DEB.2.20.2109032152440.61958@tuxera.com>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com> <20210716114635.14797-1-papadakospan@gmail.com> <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com> <YQnHxIU+EAAxIjZA@mit.edu> <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu> <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com> <alpine.DEB.2.20.2109030047330.23375@tuxera.com> <YTJf4lBjnliqhI4D@sol.localdomain>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-ORIG-GUID: -ANQCCE1K-waJxmfax5vo_OjD5LGUqls
X-Proofpoint-GUID: -ANQCCE1K-waJxmfax5vo_OjD5LGUqls
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030124
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Fri, 3 Sep 2021, Eric Biggers wrote:
> On Fri, Sep 03, 2021 at 01:09:40AM +0300, Szabolcs Szakacsits wrote:
> > User space drivers can have major disadvantages for certain workloads 
> > however how relevant are those for NTFS users? Most people use NTFS for 
> > file transfers in which case ntfs-3g read and write speed is about 15-20% 
> > less compared to ext4. For example in some quick tests ext4 read was 
> > 3.4 GB/s versus ntfs-3g 2.8 GB/s, and write was 1.3 GB/s versus 1.1 GB/s.
> 
> Your company's own advertising materials promoting your proprietary NTFS driver
> (https://www.tuxera.com/products/tuxera-ntfs-embedded) claim that NTFS-3G is
> much slower than ext4:

Thank you for pointing this out. And please do so whatever else you think 
is not right.

Let's see in detail.

> 	Read:
> 		NTFS-3G: 63.4 MB/s
> 		ext4: 113.8 MB/s
> 		"Microsoft NTFS by Tuxera": 116 MB/s
> 
> 	Write:
> 		NTFS-3G: 16.3 MB/s
> 		ext4: 92.4 MB/s
> 		"Microsoft NTFS by Tuxera": 113.3 MB/s

The page says under the benchmark:

 "Tested on ARM Cortex-A15 Processor / 512 MB RAM / Samsung SSD 840 PRO 256 GB, 
  USB 3.0 / Windows client and Samba over 1 GbE. Actual performance may 
  vary based on software and hardware used."

My quoted benchmark was done on 

 System on Chip: 11th Gen Intel(R) Core(TM) i5-11400 @2.60GHz (12 cores) 
	in ASUSTeK COMPUTER INC. PRIME B560-PLUS motherboard
 OS: Linux 5.10.0-8-amd64 x86_64
 Storage: Samsung SSD 970 PRO 512GB 512GB NVMe
 NTFS-3G 2017.3.23AR.6 (February 1, 2021) integrated FUSE 28 
 ext4 Intree (Linux 5.10.0-8-amd64)
 
> I'm not sure why anything you say should have any credibility 

Please don't believe me and do your own check. Both Ted's logs and the 
performance results which I have shared.

> when it contradicts what your company says elsewhere, 

The text says "Actual performance may vary based on software and hardware 
used." I'm afraid my results don't contradict. Hardware is vastly 
different, software is vastly different:

- The PC is much more powerful. Much faster multi-core CPU, RAM, 
interconnect, and storage compared to an apparently single core Cortex-A15.

- The embedded test used user space Samba, the other one didn't. Samba and 
ntfs-3g competed for one core which made the speed lower than it could have 
been. ksmbd will help a lot on this, just like ntfs3 for samba. And ntfs-3g 
could be also improved a lot, as I mentioned earlier. Isn't it great there 
are so many options?

- Today embedded often has multi-core, so the speed difference is (much) less.

- Tested embedded ntfs-3g version is unknown but it seems to be a (quite) 
old one. My test used one of the latest ones. NTFS-3G performance has 
been improving in time.

- I'm sure the embedded test didn't use the big_writes mount option. 
Otherwise I think the speed could have been around 50 MB/s. Which is still 
not great but at least 3 times faster. We explained and addressed this in 
the latest release note:

https://lore.kernel.org/linux-fsdevel/d343b1d7-6587-06a5-4b60-e4c59a585498@wanadoo.fr/

Overall, you had a good point. That comparison is not the most up-to-date 
one. We will work on it or just remove it.

> and your company has a vested interest in not having proper NTFS support 
> upstreamed

Please explain what you mean exactly by "proper"? 

Linus wrote "does indeed work reasonably well" except the horrible 
performance which was based on misinterpreting test results ntfs-3g being 
4 times slower when in fact it was 21% faster.

If "proper" means being in the kernel then I explained in my previous email 
why we chose FUSE.

> to compete with their proprietary driver.

The proprietary version enables us to pay people working on the open source 
version. The source code is available, anybody could do it. 

> (Note that Tuxera doesn't provide much support for NTFS-3G; most of their 
> efforts are focused on their proprietary driver.)

We provide both commercial and free support for NTFS-3G. We had annually at 
least one stable open source release since 2006, full changelog:

	https://github.com/tuxera/ntfs-3g/releases

And all questions and issues are answered, resolved:

	https://sourceforge.net/p/ntfs-3g/mailman/ntfs-3g-devel/

Thank you Eric again for the very honest feedback.

Best regards,

	Szaka
