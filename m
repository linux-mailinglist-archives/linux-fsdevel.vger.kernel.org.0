Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7611DC6DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 08:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgEUGJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 02:09:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbgEUGJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 02:09:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04L61wef066528;
        Thu, 21 May 2020 02:08:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312cb2g1v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 02:08:43 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04L62LtU067906;
        Thu, 21 May 2020 02:08:42 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312cb2g1u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 02:08:42 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04L65BHP001836;
        Thu, 21 May 2020 06:08:39 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 313wne24am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 06:08:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04L68b9L60358742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 06:08:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D28652050;
        Thu, 21 May 2020 06:08:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.40.126])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 855415204F;
        Thu, 21 May 2020 06:08:33 +0000 (GMT)
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <20200519024311.7bkxi2fkxboon2ig@xzhoux.usersys.redhat.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 21 May 2020 11:38:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200519024311.7bkxi2fkxboon2ig@xzhoux.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200521060833.855415204F@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_02:2020-05-20,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210035
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Murphy,

On 5/19/20 8:13 AM, Murphy Zhou wrote:
> On Thu, Apr 23, 2020 at 04:17:52PM +0530, Ritesh Harjani wrote:
>> Hello All,
>>
>> Here are some changes, which as I understand, takes the right approach in fixing
>> the offset/length bounds check problem reported in threads [1]-[2].
>> These warnings in iomap_apply/ext4 path are reported after ext4_fiemap()
>> was moved to use iomap framework and when overlayfs is mounted on top of ext4.
>> Though the issues were identified after ext4 moved to iomap framework, but
>> these changes tries to fix the problem which are anyways present in current code
>> irrespective of ext4 using iomap framework for fiemap or not.
> 
> Ping?

It's superseded by below mentioned patch series.
Please follow below thread.
https://lore.kernel.org/linux-ext4/20200520032837.GA2744481@mit.edu/T/#t

-ritesh
