Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF981DBB68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgETR1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 13:27:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETR1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 13:27:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHRQnD119589;
        Wed, 20 May 2020 17:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZI+6TF7yJH53zB2IfHHOio/WtJQNIx/nlTr5nUcwRyo=;
 b=hbw+Sxm7GgFCtoB0oR+J7ScLExUTPpDmgmRf4XRgPt5ZZq0UbNZuo4tNT0gCwCdsgaXf
 Zb3BNbolWjR02A2T8ZkQzrFAFg7O8tHMR6VSc2X0+0PLoQlmQUezlvDWZDiPuIROF4pO
 Rr0//G2s33Tm0KzkAMhfsk/K+S4edYBBOVgqNZ6lbyqdQgXYOZd9x3uf1rGJtzOxTFqX
 ODyILwoByLK6zyHlXqx/PPTEDDtAzcc+BUMxJOBvT67EZN3otvU/CWRSSEXoz8qrc8XU
 W2G24P7P5DeEfq56RBJWtEnCqTM9eUlz/nv9ZRjUC/uCu4kGeCwoyL8xmLEAWclnwjGE cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31501raxu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 17:27:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHMTgo084411;
        Wed, 20 May 2020 17:27:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 314gm7ej5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 17:27:20 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KHRHeJ023238;
        Wed, 20 May 2020 17:27:17 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 10:27:17 -0700
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000b4684e05a2968ca6@google.com>
 <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <bb232cfa-5965-42d0-88cf-46d13f7ebda3@www.fastmail.com>
 <9a56a79a-88ed-9ff4-115e-ec169cba5c0b@oracle.com>
 <CAJfpegsNVB12MQ-Jgbb-f=+i3g0Xy52miT3TmUAYL951HVQS_w@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <78313ae9-8596-9cbe-f648-3152660be9b3@oracle.com>
Date:   Wed, 20 May 2020 10:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegsNVB12MQ-Jgbb-f=+i3g0Xy52miT3TmUAYL951HVQS_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200141
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/20/20 4:20 AM, Miklos Szeredi wrote:
> On Tue, May 19, 2020 at 2:35 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 5/18/20 4:41 PM, Colin Walters wrote:
>>>
>>> On Tue, May 12, 2020, at 11:04 AM, Miklos Szeredi wrote:
>>>
>>>>> However, in this syzbot test case the 'file' is in an overlayfs filesystem
>>>>> created as follows:
>>>>>
>>>>> mkdir("./file0", 000)                   = 0
>>>>> mount(NULL, "./file0", "hugetlbfs", MS_MANDLOCK|MS_POSIXACL, NULL) = 0
>>>>> chdir("./file0")                        = 0
>>>>> mkdir("./file1", 000)                   = 0
>>>>> mkdir("./bus", 000)                     = 0
>>>>> mkdir("./file0", 000)                   = 0
>>>>> mount("\177ELF\2\1\1", "./bus", "overlay", 0, "lowerdir=./bus,workdir=./file1,u"...) = 0
>>>
>>> Is there any actual valid use case for mounting an overlayfs on top of hugetlbfs?  I can't think of one.  Why isn't the response to this to instead only allow mounting overlayfs on top of basically a set of whitelisted filesystems?
>>>
>>
>> I can not think of a use case.  I'll let Miklos comment on adding whitelist
>> capability to overlayfs.
> 
> I've not heard of overlayfs being used over hugetlbfs.
> 
> Overlayfs on tmpfs is definitely used, I guess without hugepages.
> But if we'd want to allow tmpfs _without_ hugepages but not tmpfs
> _with_ hugepages, then we can't just whitelist based on filesystem
> type, but need to look at mount options as well.  Which isn't really a
> clean solution either.
> 
>> IMO - This BUG/report revealed two issues.  First is the BUG by mmap'ing
>> a hugetlbfs file on overlayfs.  The other is that core mmap code will skip
>> any filesystem specific get_unmapped area routine if on a union/overlay.
>> My patch fixes both, but if we go with a whitelist approach and don't allow
>> hugetlbfs I think we still need to address the filesystem specific
>> get_unmapped area issue.  That is easy enough to do by adding a routine to
>> overlayfs which calls the routine for the underlying fs.
> 
> I think the two are strongly related:  get_unmapped_area() adjusts the
> address alignment, and the is_file_hugepages() call in
> ksys_mmap_pgoff() adjusts the length alignment.
> 
> Is there any other purpose for which  f_op->get_unmapped_area() is
> used by a filesystem?
> 

I am fairly confident it is all about checking limits and alignment.  The
filesystem knows if it can/should align to base or huge page size. DAX has
some interesting additional restrictions, and several 'traditional' filesystems
check if they are 'on DAX'.

In a previous e-mail, you suggested hugetlb_get_unmapped_area could do the
length adjustment in hugetlb_get_unmapped_area (generic and arch specific).
I agree, although there may be the need to add length overflow checks in
these routines (after round up) as this is done in core code now.  However,
this can be done as a separate cleanup patch.

In any case, we need to get the core mmap code to call filesystem specific
get_unmapped_area if on a union/overlay.  The patch I suggested does this
by simply calling real_file to determine if there is a filesystem specific
get_unmapped_area.  The other approach would be to provide an overlayfs
get_unmapped_area that calls the underlying filesystem get_unmapped_area.

-- 
Mike Kravetz
