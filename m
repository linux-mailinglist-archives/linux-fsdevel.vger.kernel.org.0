Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C091B861A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 13:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDYLPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 07:15:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgDYLPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 07:15:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03PB1RYM058156;
        Sat, 25 Apr 2020 07:15:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhr3tsyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Apr 2020 07:15:05 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03PBF5D4084488;
        Sat, 25 Apr 2020 07:15:05 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhr3tsy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Apr 2020 07:15:05 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03PBAQqF029811;
        Sat, 25 Apr 2020 11:15:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7rdff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Apr 2020 11:15:02 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03PBF0Pe63242294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Apr 2020 11:15:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A5D4C040;
        Sat, 25 Apr 2020 11:15:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2A484C046;
        Sat, 25 Apr 2020 11:14:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.185.245])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 25 Apr 2020 11:14:56 +0000 (GMT)
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
To:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <20200424101153.GC456@infradead.org>
 <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com>
 <CAOQ4uxgiome-BnHDvDC=vHfidf4Ru3jqzOki0Z_YUkinEeYCRQ@mail.gmail.com>
 <20200425094350.GA11881@infradead.org>
 <CAOQ4uxg2KOVBxqF400KW3VaQEaX4JGqfb_vCW=esTMkJqZWwvA@mail.gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 25 Apr 2020 16:44:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxg2KOVBxqF400KW3VaQEaX4JGqfb_vCW=esTMkJqZWwvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200425111456.A2A484C046@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-25_05:2020-04-24,2020-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=947
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004250092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/25/20 4:19 PM, Amir Goldstein wrote:
> On Sat, Apr 25, 2020 at 12:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Sat, Apr 25, 2020 at 12:11:59PM +0300, Amir Goldstein wrote:
>>> FWIW, I agree with you.
>>> And seems like Jan does as well, since he ACKed all your patches.
>>> Current patches would be easier to backport to stable kernels.
>>
>> Honestly, the proper fix is pretty much trivial.  I wrote it up this
>> morning over coffee:
>>
>>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fiemap-fix
>>
>> Still needs more testing, though.
> 
> Very slick!
> 
> I still think Ritesh's patches are easier for backporting because they are
> mostly contained within the ext4/overlayfs subsystems and your patch
> can follow up as interface cleanup.
> 
> I would use as generic helper name generic_fiemap_checks()
> akin to generic_write_checks() and generic_remap_file_range_prep() =>
> generic_remap_checks().

If it's ok, I will be happy to do this cleanup in the 2nd round.


-ritesh
