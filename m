Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1AD2337CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgG3RjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 13:39:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60556 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbgG3RjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:39:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UHbvLl172962;
        Thu, 30 Jul 2020 17:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SXCUepiDTX+vx54a8iA6+ZtY81yMmUvI+9/VSXWa7XE=;
 b=WnwKM+JtGJfXHauviA9MLCbwH7CTGlwqyClTnrQLXIFTwCO8wqz96S3CmpBMCvqT7IJY
 QtidvrSrcW2gmOnZbaB8odQ/WblAwwhta9XTkwcYmAdvmuF6YZvt1McQZhV7dvavRx5S
 FjyhG0bn4i+4nA9sF3uvalh7i9hz+lKs/ioR8zeQZVSYc3k6NsrAw5wTsdRvxvzwH2eK
 rt9W7IJBUwPvF0r3KvFi3G3brP6wZhhO8ui/o/uPPWPOpK2frdPoA/zi+2phGkBZYP29
 zyV5WkqMp2JN+UZtGYfEwFIdtVqxk/O9XAmMntGhvd+4PyoQixFUp7GYIBKlhclAJGcE fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32hu1jn22x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 17:38:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UHMg7b023959;
        Thu, 30 Jul 2020 17:36:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32hu5x6wfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 17:36:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UHZur7013559;
        Thu, 30 Jul 2020 17:35:56 GMT
Received: from [10.39.200.60] (/10.39.200.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 10:35:55 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
Date:   Thu, 30 Jul 2020 13:35:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730171251.GI23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/30/2020 1:12 PM, Matthew Wilcox wrote:
> On Thu, Jul 30, 2020 at 11:59:42AM -0400, Steven Sistare wrote:
>> On 7/30/2020 11:22 AM, Matthew Wilcox wrote:
>>> On Mon, Jul 27, 2020 at 10:11:22AM -0700, Anthony Yznaga wrote:
>>>> This patchset adds support for preserving an anonymous memory range across
>>>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
>>>> sharing memory in this manner, as opposed to re-attaching to a named shared
>>>> memory segment, is to ensure it is mapped at the same virtual address in
>>>> the new process as it was in the old one.  An intended use for this is to
>>>> preserve guest memory for guests using vfio while qemu exec's an updated
>>>> version of itself.  By ensuring the memory is preserved at a fixed address,
>>>> vfio mappings and their associated kernel data structures can remain valid.
>>>> In addition, for the qemu use case, qemu instances that back guest RAM with
>>>> anonymous memory can be updated.
>>>
>>> I just realised that something else I'm working on might be a suitable
>>> alternative to this.  Apologies for not realising it sooner.
>>>
>>> http://www.wil.cx/~willy/linux/sileby.html
>>>
>>> To use this, you'd mshare() the anonymous memory range, essentially
>>> detaching the VMA from the current process's mm_struct and reparenting
>>> it to this new mm_struct, which has an fd referencing it.
>>>
>>> Then you call exec(), and the exec'ed task gets to call mmap() on that
>>> new fd to attach the memory range to its own address space.
>>>
>>> Presto!
>>
>> To be suitable for the qemu use case, we need a guarantee that the same VA range
>> is available in the new process, with nothing else mapped there.  From your spec,
>> it sounds like the new process could do a series of unrelated mmap's which could
>> overlap the desired va range before the silby mmap(fd) is performed??
> 
> That could happen.  eg libc might get its text segment mapped there
> randomly.  I believe Khalid was working on a solution for reserving
> memory ranges.

mshare + VA reservation is another possible solution.

Or MADV_DOEXEC alone, which is ready now.  I hope we can get back to reviewing that.

>> Also, we need to support updating legacy processes that already created anon segments.
>> We inject code that calls MADV_DOEXEC for such segments.
> 
> Yes, I was assuming you'd inject code that called mshare().

OK, mshare works on existing memory and builds a new vma.

> Actually, since you're injecting code, why do you need the kernel to
> be involved?  You can mmap the new executable and any libraries it depends
> upon, set up a new stack and jump to the main() entry point, all without
> calling exec().  I appreciate it'd be a fair amount of code, but it'd all
> be in userspace and you can probably steal / reuse code from ld.so (I'm
> not familiar with the details of how setting up an executable is done).

Duplicating all the work that the kernel and loader do to exec a process would
be error prone, require ongoing maintenance, and be redundant.  Better to define 
a small kernel extension and leave exec to the kernel.

- Steve
