Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B52234906
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 18:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgGaQOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 12:14:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaQOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:14:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VG7xY4044215;
        Fri, 31 Jul 2020 16:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lJW6ynvYl/y2RoviMF1BbdMs9UZIJzFTSbv3Elu4rIk=;
 b=xHSTZ70EG7fxtY+PAXvIOuZO89QrBFpkDThedjEnjaMizfijU4B+qpTDAOUes2PUdJ80
 eEj/ndYduXIJyO876MNq4d9VQ6Owa15z6ir8YY/vYJGt562dv0+8QMfWJCjz7vBeZ1/d
 +NU5O/xfEuuPf0HhfOjO0LbfN3ZJkq39+OTk7daIU6zqhF/ymb/4AInIn4Dy4rLqn+Mq
 p9+1i+FEZaRYXXvjilDIhI6fRMeRpnZ128szIPpGqxjJ377j6kC0RtdvNdfnK28JCSHe
 vt/aXY9dOXK4XWoviqD61mYRkgBzDeJy4CThcQHk5Tg7upJS1+ftV8F0qcpKeEqUXSD2 PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32mf702833-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 16:14:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VG8rqp187364;
        Fri, 31 Jul 2020 16:12:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32hu603sum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 16:12:03 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VGBvPJ010939;
        Fri, 31 Jul 2020 16:11:57 GMT
Received: from [10.39.235.87] (/10.39.235.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 09:11:56 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
Date:   Fri, 31 Jul 2020 12:11:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200731152736.GP23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/31/2020 11:27 AM, Matthew Wilcox wrote:
> On Fri, Jul 31, 2020 at 10:57:44AM -0400, Steven Sistare wrote:
>> Matthews sileby/mshare proposal has the same issue.  If a process opts-in
>> and mmap's an address in the shared region, then content becomes mapped at
>> a VA that was known to the pre-fork or pre-exec process.  Trust must still
>> be established.
> 
> It's up to the recipient whether they try to map it at the same address
> or at a fresh address.  The intended use case is a "semi-shared" address
> space between two processes (ie partway between a threaded, fully-shared
> address space and a forked un-shared address space), in which case
> there's a certain amount of trust and cooperation between the processes.

Understood, but if the recipient does map at any of the same, which is the whole
point because you want to share the page table.  The trust relationship is no
different than for the live update case.  
 
> Your preservation-across-exec use-case might or might not need the
> VMA to be mapped at the same address.  

It does.  qemu registers memory with vfio which remembers the va's in kernel
metadata for the device.

> I don't know whether qemu stores
> pointers in this VMA which are absolute within the qemu address space.
> If it's just the emulated process's address space, then everything will
> be absolute within its own address space and everything will be opaque
> to qemu.  If qemu is storing its own pointers in it, then it has to be
> mapped at the same address.

qemu does not do the latter but that could be a nice way for apps to use
preserved memory.

>>> Here is another suggestion.
>>>
>>> Have a very simple program that does:
>>>
>>> 	for (;;) {
>>> 		handle = dlopen("/my/real/program");
>>> 		real_main = dlsym(handle, "main");
>>> 		real_main(argc, argv, envp);
>>> 		dlclose(handle);
>>> 	}
>>>
>>> With whatever obvious adjustments are needed to fit your usecase.
>>>
>>> That should give the same level of functionality, be portable to all
>>> unices, and not require you to duplicate code.  It belive it limits you
>>> to not upgrading libc, or librt but that is a comparatively small
>>> limitation.
>>>
>>>
>>> Given that in general the interesting work is done in userspace and that
>>> userspace has provided an interface for reusing that work already.
>>> I don't see the justification for adding anything to exec at this point. 
>>
>> Thanks for the suggestion.  That is clever, and would make a fun project,
>> but I would not trust it for production.  These few lines are just
>> the first of many that it would take to reset the environment to the
>> well-defined post-exec initial conditions that all executables expect,
>> and incrementally tearing down state will be prone to bugs.  Getting a
>> clean slate from a kernel exec is a much more reliable design.  The use
>> case is creating long-lived apps that never go down, and the simplest
>> implementation will have the fewest bugs and is the best.  MADV_DOEXEC is
>> simple, and does not even require a new system call, and the kernel already
>> knows how to exec without bugs.
> 
> It's a net increase of 200 lines of kernel code.  If 4 lines of userspace
> code removes 200 lines of kernel code, I think I know which I prefer ...

It will be *far* more than 4 lines.
Much of the 200 lines is mostly for the elf opt in, and much of the elf code is from
anthony reviving an earlier patch that use MAP_FIXED_NOREPLACE during segment setup.

- Steve


