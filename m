Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63F1BD74E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 10:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgD2IbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 04:31:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgD2IbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:31:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T83YgD115099;
        Wed, 29 Apr 2020 04:30:47 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhc23ug7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 04:30:47 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03T8Kpd4025685;
        Wed, 29 Apr 2020 08:30:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 30mcu59mdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 08:30:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03T8UgdM3408150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 08:30:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73C9DAE04D;
        Wed, 29 Apr 2020 08:30:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69A0DAE051;
        Wed, 29 Apr 2020 08:30:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.252])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Apr 2020 08:30:39 +0000 (GMT)
Subject: Re: [PATCHv2] fibmap: Warn and return an error in case of block >
 INT_MAX
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
References: <58f0c64a3f2dbd363fb93371435f6bcaeeb7abe4.1588058868.git.riteshh@linux.ibm.com>
 <20200428114141.GL29705@bombadil.infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 29 Apr 2020 14:00:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200428114141.GL29705@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200429083039.69A0DAE051@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_02:2020-04-28,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004290062
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/28/20 5:11 PM, Matthew Wilcox wrote:
> On Tue, Apr 28, 2020 at 01:08:31PM +0530, Ritesh Harjani wrote:
>> @@ -71,6 +72,13 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>>   	block = ur_block;
>>   	error = bmap(inode, &block);
>>   
>> +	if (block > INT_MAX) {
>> +		error = -ERANGE;
>> +		pr_warn_ratelimited("[%s/%d] FS (%s): would truncate fibmap result\n",
>> +				    current->comm, task_pid_nr(current),
>> +				    sb->s_id);
> 
> Why is it useful to print the pid?
For e.g. a case where you have pthreads. pid could be different there.

> And why print the superblock when we could print the filename instead? > We have a struct file, so we can printk("%pD4", filp) to print the
> last four components of the pathname.
> 

Sure, let me use below print msg then. This should cover everything now
If no objections, I could send this in v3. Pls, do let me know if
otherwise.

Since this has changed again from the 1st version, will drop all
Reviewed-by: and you could directly review v3 then.

		pr_warn_ratelimited("[%s/%d] FS: %s File: %pD4 would truncate fibmap 
result\n",
				    current->comm, task_pid_nr(current),
				    sb->s_id, filp);

About %pD from (Documentation/core-api/printk-formats.rst)
========================================================
<..>
	%pd{,2,3,4}
	%pD{,2,3,4}

For printing dentry name; if we race with :c:func:`d_move`, the name might
be a mix of old and new ones, but it won't oops.  %pd dentry is a safer
equivalent of %s dentry->d_name.name we used to use, %pd<n> prints ``n``
last components.  %pD does the same thing for struct file.



-ritesh
