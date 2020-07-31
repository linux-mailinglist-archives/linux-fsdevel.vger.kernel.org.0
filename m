Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CAF234A90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgGaR4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 13:56:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33436 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbgGaR4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:56:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VHrWai066567;
        Fri, 31 Jul 2020 17:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AP9h6jrjCU1OjVmOCvpM4eFekSUAOycCcjScthug83M=;
 b=UPpGg3mJlO7OVSFRYiWx/QIzbPiIeXZ5n1e7DUV5L7gjjZYgAwkdAPkhPwcG2YHNcrIO
 xAUWyMRppnetCs5lEZ7pEjauoEjPSVZfExSGJN+PS325wRq8BNL0KOOjwA0m7FCZAa4v
 oXHEcmHkqoJza0rqdOLNSNdq4mGkJ3DCsDci0R6vEOIpZDw7K0bk3xNwyxGIeBL7MjnC
 tswpRDpfcyvX0GxAmwWnIROpydlimNLsnATFqvKrve+ajhput0UO7jksXs8gJ4y0qxTk
 4ezsnyMOe7BaYcnBgSF3sdb6iBp95Wl35V0UW6bNBlcBFGU1/D3RdLQCLy79pWn/Lh8v 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32hu1jtcbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 17:55:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VHrVxn173950;
        Fri, 31 Jul 2020 17:55:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32hu605r83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 17:55:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VHtCao008827;
        Fri, 31 Jul 2020 17:55:12 GMT
Received: from [10.39.235.87] (/10.39.235.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 10:55:11 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
References: <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
 <20200731165649.GG24045@ziepe.ca>
 <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
 <20200731174837.GH24045@ziepe.ca>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <f4ce3f4a-bdee-ec43-986c-8e4d8b1d2ddc@oracle.com>
Date:   Fri, 31 Jul 2020 13:55:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200731174837.GH24045@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/31/2020 1:48 PM, Jason Gunthorpe wrote:
> On Fri, Jul 31, 2020 at 01:15:34PM -0400, Steven Sistare wrote:
>> On 7/31/2020 12:56 PM, Jason Gunthorpe wrote:
>>> On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
>>>>> Your preservation-across-exec use-case might or might not need the
>>>>> VMA to be mapped at the same address.  
>>>>
>>>> It does.  qemu registers memory with vfio which remembers the va's in kernel
>>>> metadata for the device.
>>>
>>> Once the memory is registered with vfio the VA doesn't matter, vfio
>>> will keep the iommu pointing at the same physical pages no matter
>>> where they are mapped.
>>
>> Yes, but there are other code paths that compute and use offsets between va and the
>> base va.  Mapping at a different va in the new process breaks vfio; I have tried it.
> 
> Maybe you could fix vfio instead of having this adventure, if vfio is
> the only motivation.

Maybe.  We still need to preserve an anonymous segment, though.  MADV_DOEXEC, or mshare,
or something else.  And I think the ability to preserve memory containing pointers to itself
is an interesting use case, though not ours.

- Steve
