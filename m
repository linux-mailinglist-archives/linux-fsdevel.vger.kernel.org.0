Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41282DB444
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 20:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgLOTGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 14:06:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56668 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbgLOTGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:06:20 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFJ05Nn166879;
        Tue, 15 Dec 2020 19:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rPaA1lXHtSIrJnQXSfEHzf/QB0dDoI9KLHNNF9d2vyk=;
 b=XxG8yezhuwhvdL/NoipNesCnm3sm5cjA8YlgvbvW1HHxEITZTP0ZyhE82MIDP+GN9/5j
 /UZJZ7hWT3uni1b4nkheEECeEBHEr1L2SnshTtQVU/iqLCgyI7D+ORP5ghWepy3TfEgC
 0m6V/K1enEiivJ1Jiiiq2UvfS1meyUKLdtShxrbkD0aSPeyF2GLlG0llWmfavR8YciAQ
 ar+LEZmRhmWrMOrGwGdcmluYiQ74ngB7eLg1+QbsEWoR4Hl88lMeQ9Zgq5zyTg3P69Ti
 /1zZpwj5XBbTcCQjYQY80V+mav+tk0T+ALeAhgWPt2AA+kYasicfoyT8hMUB07BJOemq 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35ckcbcgye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 19:05:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFJ1C3e048331;
        Tue, 15 Dec 2020 19:05:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35d7enf2hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 19:05:14 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BFJ5AuJ024299;
        Tue, 15 Dec 2020 19:05:10 GMT
Received: from [10.159.136.92] (/10.159.136.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 11:05:09 -0800
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
 <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <3b35604c-57e2-8cb5-da69-53508c998540@oracle.com>
Date:   Tue, 15 Dec 2020 11:05:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/2020 3:58 AM, Ruan Shiyang wrote:
> Hi Jane
> 
> On 2020/12/15 上午4:58, Jane Chu wrote:
>> Hi, Shiyang,
>>
>> On 11/22/2020 4:41 PM, Shiyang Ruan wrote:
>>> This patchset is a try to resolve the problem of tracking shared page
>>> for fsdax.
>>>
>>> Change from v1:
>>>    - Intorduce ->block_lost() for block device
>>>    - Support mapped device
>>>    - Add 'not available' warning for realtime device in XFS
>>>    - Rebased to v5.10-rc1
>>>
>>> This patchset moves owner tracking from dax_assocaite_entry() to pmem
>>> device, by introducing an interface ->memory_failure() of struct
>>> pagemap.  The interface is called by memory_failure() in mm, and
>>> implemented by pmem device.  Then pmem device calls its ->block_lost()
>>> to find the filesystem which the damaged page located in, and call
>>> ->storage_lost() to track files or metadata assocaited with this page.
>>> Finally we are able to try to fix the damaged data in filesystem and do
>>
>> Does that mean clearing poison? if so, would you mind to elaborate 
>> specifically which change does that?
> 
> Recovering data for filesystem (or pmem device) has not been done in 
> this patchset...  I just triggered the handler for the files sharing the 
> corrupted page here.

Thanks! That confirms my understanding.

With the framework provided by the patchset, how do you envision it to
ease/simplify poison recovery from the user's perspective?

And how does it help in dealing with page faults upon poisoned
dax page?

thanks!
-jane

