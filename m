Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2938B23ADEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHCUEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 16:04:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgHCUEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:04:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073K39Jf003459;
        Mon, 3 Aug 2020 20:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7669qL3S88I58HL7dnTpCNibUM3RomZTzMGtd4cZ7RM=;
 b=zOuBCb8UEdIuoPhRncWCn69rOkipJMyX8V2sNYL6Cry8lQttK0FjSPXZlMMEQASPy9S3
 aOWJuLCVFmhxyevxnmAFle6RGh9njHg2ReiDZrbG/Jh8Jy6qW8NTyZQYw9b6bq9dP/QN
 L/uG5QHGmA6H7Q6/ZA2nZ8JBCAzv2GfacJjuRawPVfWI3GvUh3uc2NWUL27B3IzD7CYo
 Zsu6u53cqnIeVtNsHlsMUZ+fcrCC1DsQ71cvJW7xLKLeAlayax4t8ImI7N+UVRukrwfA
 F+858wh4KseAZMSYZig35BZVgzuIYEL32dYYt1b5fMgCWFntScgLpDCC/ZhDvag55idP Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32pdnq3sah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 20:04:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073K34Zd028201;
        Mon, 3 Aug 2020 20:04:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32p5gr726j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 20:04:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073K434H002398;
        Mon, 3 Aug 2020 20:04:03 GMT
Received: from [10.39.192.124] (/10.39.192.124)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 13:04:03 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
 <877dufvje9.fsf@x220.int.ebiederm.org>
 <1596469370.29091.13.camel@HansenPartnership.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <e4bf2e19-adc2-ad5e-f516-e8014500456d@oracle.com>
Date:   Mon, 3 Aug 2020 16:03:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1596469370.29091.13.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030139
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/3/2020 11:42 AM, James Bottomley wrote:
> On Mon, 2020-08-03 at 10:28 -0500, Eric W. Biederman wrote:
> [...]
>> What is wrong with live migration between one qemu process and
>> another qemu process on the same machine not work for this use case?
>>
>> Just reusing live migration would seem to be the simplest path of
>> all, as the code is already implemented.  Further if something goes
>> wrong with the live migration you can fallback to the existing
>> process.  With exec there is no fallback if the new version does not
>> properly support the handoff protocol of the old version.
> 
> Actually, could I ask this another way: the other patch set you sent to
> the KVM list was to snapshot the VM to a PKRAM capsule preserved across
> kexec using zero copy for extremely fast save/restore.  The original
> idea was to use this as part of a CRIU based snapshot, kexec to new
> system, restore.  However, why can't you do a local snapshot, restart
> qemu, restore using the PKRAM capsule to achieve exactly the same as
> MADV_DOEXEC does but using a system that's easy to reason about?  It
> may be slightly slower, but I think we're still talking milliseconds.

Hi James, good to hear from you.  PKRAM or SysV shm could be used for
a restart in that manner, but it would only support sriov guests if the
guest exports an agent that supports suspend-to-ram, and if all guest
drivers support the suspend-to-ram method.  I have done this using a linux
guest and qemu guest agent, and IIRC the guest pause time is 500 - 1000 msec.
With MADV_DOEXEC, pause time is 100 - 200 msec.  The pause time is a handful
of seconds if the guest uses an nvme drive because CC.SHN takes so long
to persist metadata to stable storage.

We could instead pass vfio descriptors from the old process to a 3rd party escrow 
process and pass  them back to the new qemu process, but the shm that vfio has 
already registered must be remapped at the same VA as the previous process, and 
there is no interface to guarantee that.  MAP_FIXED blows away existing mappings 
and breaks the app. MAP_FIXED_NOREPLACE respects existing mappings but cannot map 
the shm and breaks the app.  Adding a feature that reserves VAs would fix that, we 
have experimnted with one.  Fixing the vfio kernel implementation to not use the 
original VA base would also work, but I don't know how doable/difficult that would be.

Both solutions would require a qemu instance to be stopped and relaunched using shm
as guest ram, and its guest rebooted, so they do not let us update legacy 
already-running instances that use anon memory.  That problem solves itself if we 
get these rfe's into linux and qemu, and eventually users shut down the legacy
instances, but that takes years and we need to do it sooner.

- Steve
