Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4069C1F4E47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgFJGe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 02:34:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgFJGe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:34:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A6X4pj187195;
        Wed, 10 Jun 2020 02:34:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jaydtk5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 02:34:39 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05A6YctA002469;
        Wed, 10 Jun 2020 02:34:38 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jaydtk4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 02:34:38 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A6MLM4012047;
        Wed, 10 Jun 2020 06:34:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 31jf1grag8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 06:34:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A6YYIq57540632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 06:34:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00B7811C054;
        Wed, 10 Jun 2020 06:34:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 354E411C04A;
        Wed, 10 Jun 2020 06:34:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Jun 2020 06:34:32 +0000 (GMT)
Subject: Re: [PATCHv2 1/1] ext4: mballoc: Use this_cpu_read instead of
 this_cpu_ptr
To:     Christoph Hellwig <hch@infradead.org>, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, jack@suse.com,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
References: <534f275016296996f54ecf65168bb3392b6f653d.1591699601.git.riteshh@linux.ibm.com>
 <20200610062538.GA24975@infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 10 Jun 2020 12:04:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610062538.GA24975@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200610063432.354E411C04A@d06av25.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_02:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=845 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100049
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/10/20 11:55 AM, Christoph Hellwig wrote:
> On Tue, Jun 09, 2020 at 04:23:10PM +0530, Ritesh Harjani wrote:
>> Simplify reading a seq variable by directly using this_cpu_read API
>> instead of doing this_cpu_ptr and then dereferencing it.
>>
>> This also avoid the below kernel BUG: which happens when
>> CONFIG_DEBUG_PREEMPT is enabled
> 
> I see this warning all the time with ext4 using tests VMs, so lets get
> this fixed ASAP before -rc1:

Couldn't agree more.

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks

-ritesh
