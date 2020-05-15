Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6144D1D5C1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 00:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOWPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 18:15:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36588 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOWPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 18:15:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FMBnZM029431;
        Fri, 15 May 2020 22:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2kGRzsjaRGAXe1KvMIuG2Z2gwGj3Jnd8bvP3/TCsvXU=;
 b=wgYl/oLleBEBHiZhkcCodEzbVKC/Otg3zgV3+oHjt3VUQ+Q1u6k3vdeA3pg0yl9ZSKU8
 GeZ0feNYYp6T01DDM7+NAHf6u8PjUbyoYUi2LL5pJsyzTKldX9EPRs+IX2I9VeHowq6k
 OCFWd0gT8FwS1JRn6IdNPrwSecJU8ChgN8qDcxC6Q28Y0S2VpwLMDUfzWOCn5MomRdBe
 rQrspoj3gK5H8ypDU4OsCvgg7kMrjxqzh6OLapzvOHAeJ6NUF/I2XTHKgqKrmIa41Rnc
 Pbw/4dd5N6RRo+n4dtsrdC/oARZoeBqljrnlUam9Jm3qtzOXPiyAMx638vDXCLdNW23/ Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3100xwx2vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 22:15:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FMCpqE165873;
        Fri, 15 May 2020 22:15:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3100ysb9jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 22:15:39 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04FMFaqC003865;
        Fri, 15 May 2020 22:15:37 GMT
Received: from [192.168.2.157] (/50.38.34.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 May 2020 15:15:36 -0700
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000b4684e05a2968ca6@google.com>
 <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <d32b8579-04a3-2a9b-cd54-1d581c63332e@oracle.com>
Message-ID: <86c504b3-52c9-55f6-13db-ab55b2f6980e@oracle.com>
Date:   Fri, 15 May 2020 15:15:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d32b8579-04a3-2a9b-cd54-1d581c63332e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9622 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005150186
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9622 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150186
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/20 11:11 AM, Mike Kravetz wrote:
> On 5/12/20 8:04 AM, Miklos Szeredi wrote:
>> On Tue, Apr 7, 2020 at 12:06 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>> On 4/5/20 8:06 PM, syzbot wrote:
>>>
>>> The routine is_file_hugepages() is just comparing the file ops to huegtlbfs:
>>>
>>>         if (file->f_op == &hugetlbfs_file_operations)
>>>                 return true;
>>>
>>> Since the file is in an overlayfs, file->f_op == ovl_file_operations.
>>> Therefore, length will not be rounded up to huge page size and we create a
>>> mapping with incorrect size which leads to the BUG.
>>>
>>> Because of the code in mmap, the hugetlbfs mmap() routine assumes length is
>>> rounded to a huge page size.  I can easily add a check to hugetlbfs mmap
>>> to validate length and return -EINVAL.  However, I think we really want to
>>> do the 'round up' earlier in mmap.  This is because the man page says:
>>>
>>>    Huge page (Huge TLB) mappings
>>>        For mappings that employ huge pages, the requirements for the arguments
>>>        of  mmap()  and munmap() differ somewhat from the requirements for map‐
>>>        pings that use the native system page size.
>>>
>>>        For mmap(), offset must be a multiple of the underlying huge page size.
>>>        The system automatically aligns length to be a multiple of the underly‐
>>>        ing huge page size.
>>>
>>> Since the location for the mapping is chosen BEFORE getting to the hugetlbfs
>>> mmap routine, we can not wait until then to round up the length.  Is there a
>>> defined way to go from a struct file * to the underlying filesystem so we
>>> can continue to do the 'round up' in early mmap code?
>>
>> That's easy enough:
>>
>> static inline struct file *real_file(struct file *file)
>> {
>>     return file->f_op != ovl_file_operations ? file : file->private_data;
>> }
>>
>> But adding more filesystem specific code to generic code does not
>> sound like the cleanest way to solve this...
> 
> We can incorporate the above 'real_file' functionality in the filesystem
> specific routine is_file_hugepages(), and I think that would address this
> specific issue.  I'll code that up.
> 
>>> One other thing I noticed with overlayfs is that it does not contain a
>>> specific get_unmapped_area file_operations routine.  I would expect it to at
>>> least check for and use the get_unmapped_area of the underlying filesystem?
>>> Can someone comment if this is by design?
>>
>> Not sure.  What exactly is f_op->get_unmapped_area supposed to do?
>>
> 
> IIUC, filesystems can define their own routines to get addresses for mmap
> operations.  Quite a few filesystems define get_unmapped_area.
> 
> The generic mmap code does the following,
> 
> 	get_area = current->mm->get_unmapped_area;
> 	if (file) {
> 		if (file->f_op->get_unmapped_area)
> 			get_area = file->f_op->get_unmapped_area;
> 	} else if (flags & MAP_SHARED) {
> 		/*
> 		 * mmap_region() will call shmem_zero_setup() to create a file,
> 		 * so use shmem's get_unmapped_area in case it can be huge.
> 		 * do_mmap_pgoff() will clear pgoff, so match alignment.
> 		 */
> 		pgoff = 0;
> 		get_area = shmem_get_unmapped_area;
> 	}
> 
> 	addr = get_area(file, addr, len, pgoff, flags);
> 
> If the filesystem provides a get_unmapped_area, it will use it.  I beleive
> overlayfs prevents this from happening for the underlying filesystem.
> 
> Perhaps we do need to add something like a call 'real_file' to this generic
> code?  I can't think of any other way to get to the underlying filesystem
> get_unmapped_area here.

I started going down the path of creating a get_unmapped_area f_op for
overlayfs.  That is pretty straight forward and works well.  But that
did not take care of the is_file_hugepages() routine.  Recall that
is_file_hugepages simply does if (file->f_op == &hugetlbfs_file_operations).

I suppose I could add a specific overlayfs check like real_file here.  But,
that does not seem like a clean solution.

I also discovered other routines doing comparisons like
if (file->f_op == <expected_fops>), they are:
is_dma_buf_file()
is_file_shm_hugepages()
get_pipe_info()
is_file_epoll()

So, it seems that these routines are also impacted if operating on files
in an overlayfs? 

Any suggestions on how to move forward?  It seems like there may be the
need for a real_file() routine?  I see a d_real dentry_op was added to
deal with this issue for dentries.  Might we need something similiar for
files (f_real)?

Looking for suggestions as I do not normally work with this code.
-- 
Mike Kravetz
