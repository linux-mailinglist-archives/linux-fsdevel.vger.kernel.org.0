Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5193EA6A32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfICNlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:41:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbfICNlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:41:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83DbIpt086592
        for <linux-fsdevel@vger.kernel.org>; Tue, 3 Sep 2019 09:41:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usrsuskf7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 09:41:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 3 Sep 2019 14:41:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 14:41:32 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83DfVYW51839196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 13:41:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A9CBA4062;
        Tue,  3 Sep 2019 13:41:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC5E6A405B;
        Tue,  3 Sep 2019 13:41:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 13:41:29 +0000 (GMT)
Subject: Re: [RFC] - vfs: Null pointer dereference issue with symlink create
 and read of symlink
To:     Gao Xiang <hsiangkao@aol.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        Jeff Layton <jlayton@kernel.org>, wugyuan@cn.ibm.com
References: <20190903115827.0A8A0A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20190903125946.GA11069@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 3 Sep 2019 19:11:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190903125946.GA11069@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090313-0016-0000-0000-000002A620A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090313-0017-0000-0000-0000330688B1
Message-Id: <20190903134129.EC5E6A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030144
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/3/19 6:29 PM, Gao Xiang wrote:
> On Tue, Sep 03, 2019 at 05:28:26PM +0530, Ritesh Harjani wrote:
>> Hi Viro/All,
>>
>> Could you please review below issue and it's proposed solutions.
>> If you could let me know which of the two you think will be a better
>> approach to solve this or in case if you have any other better approach, I
>> can prepare and submit a official patch with that.
>>
>>
>>
>> Issue signature:-
>>   [NIP  : trailing_symlink+80]
>>   [LR   : trailing_symlink+1092]
>>   #4 [c00000198069bb70] trailing_symlink at c0000000004bae60  (unreliable)
>>   #5 [c00000198069bc00] path_openat at c0000000004bdd14
>>   #6 [c00000198069bc90] do_filp_open at c0000000004c0274
>>   #7 [c00000198069bdb0] do_sys_open at c00000000049b248
>>   #8 [c00000198069be30] system_call at c00000000000b388
>>
>>
>>
>> Test case:-
>> shell-1 - "while [ 1 ]; do cat /gpfs/g1/testdir/file3; sleep 1; done"
>> shell-2 - "while [ 1 ]; do ln -s /gpfs/g1/testdir/file1
>> /gpfs/g1/testdir/file3; sleep 1; rm /gpfs/g1/testdir/file3 sleep 1; done
>>
>>
>>
>> Problem description:-
>> In some filesystems like GPFS below described scenario may happen on some
>> platforms (Reported-By:- wugyuan)
>>
>> Here, two threads are being run in 2 different shells. Thread-1(cat) does
>> cat of the symlink and Thread-2(ln) is creating the symlink.
>>
>> Now on any platform with GPFS like filesystem, if CPU does out-of-order
>> execution (or any kind of re-ordering due compiler optimization?) in
>> function __d_set_and_inode_type(), then we see a NULL pointer dereference
>> due to inode->i_uid.
>>
>> This happens because in lookup_fast in nonRCU path or say REF-walk (i.e. in
>> else condition), we check d_is_negative() without any lock protection.
>> And since in __d_set_and_inode_type() re-ordering may happen in setting of
>> dentry->type & dentry->inode => this means that there is this tiny window
>> where things are going wrong.
>>
>>
>> (GPFS like):- Any FS with -inode_operations ->permission callback returning
>> -ECHILD in case of (mask & MAY_NOT_BLOCK) may cause this problem to happen.
>> (few e.g. found were - ocfs2, ceph, coda, afs)
>>
>> int xxx_permission(struct inode *inode, int mask)
>> {
>>           if (mask & MAY_NOT_BLOCK)
>>                   return -ECHILD;
>> 	<...>
>> }
>>
>> Wugyuan(cc), could reproduce this problem with GPFS filesystem.
>> Since, I didn't have the GPFS setup, so I tried replicating on a native FS
>> by forcing out-of-order execution in function __d_set_inode_and_type() and
>> making sure we return -ECHILD in MAY_NOT_BLOCK case in ->permission
>> operation for all inodes.
>>
>> With above changes in kernel, I could as well hit this issue on a native FS
>> too.
>>
>> (basically what we observed is link_path_walk will do nonRCU(REF-walk)
>> lookup due to may_lookup -> inode_permission return -ECHILD and then
>> unlazy_walk drops the LOOKUP_RCU flag (nd->flag). After that below race is
>> possible).
>>
>>
>>
>> Sequence of events:-
>>
>> Thread-2(Comm: ln)		Thread-1(Comm: cat)
>>
>> 				dentry = __d_lookup() //nonRCU
>>
>> __d_set_and_inode_type() (Out-of-order execution)
>> 	flags = READ_ONCE(dentry->d_flags);
>> 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
>> 	flags |= type_flags;
>> 	WRITE_ONCE(dentry->d_flags, flags);
>>
>> 					
>> 				if (unlikely(d_is_negative()) // fails
>>    					{}
>> 				// since type is already updated in
>> 				// Thread-2 in parallel but inode
>> 				// not yet set.
>> 				// d_is_negative returns false
>>
>> 				*inode = d_backing_inode(path->dentry);
>> 				// means inode is still NULL
>>
>> 	dentry->d_inode = inode;
>> 	
>> 				trailing_symlink()
>> 					may_follow_link()
>> 						inode = nd->link_inode;
>> 						// nd->link_inode = NULL
>> 						//Then it crashes while
>> 						//doing inode->i_uid
>> 					
>> 	
> 
> It seems much similar to
> https://lore.kernel.org/r/20190419084810.63732-1-houtao1@huawei.com/

Thanks, yes two same symptoms with different use cases.
But except the fact that here, we see the issue with GPFS quite 
frequently. So let's hope that we could have some solution to this 
problem in upstream.

 From the thread:-
 >> We could simply use d_really_is_negative() there, avoiding all that
 >> mess.  If and when we get around to whiteouts-in-dcache (i.e. if
 >> unionfs series gets resurrected), we can revisit that

I didn't get this part. Does it mean, d_really_is_negative can only be 
used, once whiteouts-in-dcache series is resurrected?
If yes, meanwhile could we have any other solution in place?

-ritesh

