Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C02634B08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 00:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiKVXWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 18:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVXV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:21:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B7C67F2;
        Tue, 22 Nov 2022 15:21:55 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMMIkd7039599;
        Tue, 22 Nov 2022 23:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oC+XCMatKOqJAPTjzW1TpIq92DjrOmvsufQ1aYb6wEU=;
 b=JHAeISiJntvnrNOSKgwUl5BmInZf6wvMboXQNH3jh5MtYpsdcxBdqea9PsEM7t1/+P6O
 chyy8BDAEdXl51nS+4Dte6sI1ueFQAdkhOyE9iAFhvQs22jb+pYl0cXS4WCwRGMObkSg
 Q88nvP1kjW0iY52MpecarOSbFabU17jKc3VdH3ffDZr4a3ei/DjSEzZf4XsS9YOzRosV
 gPgQucSKzmfVzE7jCn7oDevFId4fYryM9f3Q0JYmuxRcEfH3DulaODY747B6ccWeWoHx
 3oVGGcPuJmJ3tqH9jbC99dEpDfyt2coTD6wn3D+K1giLjAuPYE/WBE6BC9DrDDAb00+w nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10ff3hwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 23:21:16 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AMNAaos017423;
        Tue, 22 Nov 2022 23:21:16 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10ff3hw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 23:21:15 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AMN5Xx3030809;
        Tue, 22 Nov 2022 23:21:14 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3kxpsacwxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 23:21:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AMNLDAp65274116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 23:21:13 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9DB458060;
        Tue, 22 Nov 2022 23:21:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EF435803F;
        Tue, 22 Nov 2022 23:21:11 +0000 (GMT)
Received: from [9.163.61.172] (unknown [9.163.61.172])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 22 Nov 2022 23:21:11 +0000 (GMT)
Message-ID: <d3e8df29-d9b0-5e8e-4a53-d191762fe7f2@linux.vnet.ibm.com>
Date:   Tue, 22 Nov 2022 18:21:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Content-Language: en-US
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com> <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
 <20221119114234.nnfxsqx4zxiku2h6@riteshh-domain>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20221119114234.nnfxsqx4zxiku2h6@riteshh-domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rx6IXruI8J7qA8U13iaDwj3sbvme2lXD
X-Proofpoint-GUID: pm16FMvUALsLfnxbRgs7NJS99XGmi9by
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1011 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220174
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/19/22 06:48, Ritesh Harjani (IBM) wrote:
> Hello Nayna,

Hi Ritesh,

>
> On 22/11/09 03:10PM, Nayna wrote:
>> On 11/9/22 08:46, Greg Kroah-Hartman wrote:
>>> On Sun, Nov 06, 2022 at 04:07:42PM -0500, Nayna Jain wrote:
>>>> securityfs is meant for Linux security subsystems to expose policies/logs
>>>> or any other information. However, there are various firmware security
>>>> features which expose their variables for user management via the kernel.
>>>> There is currently no single place to expose these variables. Different
>>>> platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
>>>> interface as they find it appropriate. Thus, there is a gap in kernel
>>>> interfaces to expose variables for security features.
>>>>
>>>> Define a firmware security filesystem (fwsecurityfs) to be used by
>>>> security features enabled by the firmware. These variables are platform
>>>> specific. This filesystem provides platforms a way to implement their
>>>>    own underlying semantics by defining own inode and file operations.
>>>>
>>>> Similar to securityfs, the firmware security filesystem is recommended
>>>> to be exposed on a well known mount point /sys/firmware/security.
>>>> Platforms can define their own directory or file structure under this path.
>>>>
>>>> Example:
>>>>
>>>> # mount -t fwsecurityfs fwsecurityfs /sys/firmware/security
>>> Why not juset use securityfs in /sys/security/firmware/ instead?  Then
>>> you don't have to create a new filesystem and convince userspace to
>>> mount it in a specific location?
> I am also curious to know on why not use securityfs, given the similarity
> between the two. :)
> More specifics on that below...
>
>>  From man 5 sysfs page:
>>
>> /sys/firmware: This subdirectory contains interfaces for viewing and
>> manipulating firmware-specific objects and attributes.
>>
>> /sys/kernel: This subdirectory contains various files and subdirectories
>> that provide information about the running kernel.
>>
>> The security variables which are being exposed via fwsecurityfs are managed
>> by firmware, stored in firmware managed space and also often consumed by
>> firmware for enabling various security features.
> That's ok. As I see it users of securityfs can define their own fileops
> (like how you are doing in fwsecurityfs).
> See securityfs_create_file() & securityfs_create_symlink(), can accept the fops
> & iops. Except maybe securityfs_create_dir(), that could be since there might
> not be a usecase for it. But do you also need it in your case is the question to
> ask.

Please refer to the function plpks_secvars_init() in Patch 4/4.

>
>>  From git commit b67dbf9d4c1987c370fd18fdc4cf9d8aaea604c2, the purpose of
>> securityfs(/sys/kernel/security) is to provide a common place for all kernel
>> LSMs. The idea of
> Which was then seperated out by commit,
> da31894ed7b654e2 ("securityfs: do not depend on CONFIG_SECURITY").
>
> securityfs now has a seperate CONFIG_SECURITYFS config option. In fact I was even
> thinking of why shouldn't we move security/inode.c into fs/securityfs/inode.c .
> fs/* is a common place for all filesystems. Users of securityfs can call it's
> exported kernel APIs to create files/dirs/symlinks.
>
> If we move security/inode.c to fs/security/inode.c, then...
> ...below call within securityfs_init() should be moved into some lsm sepecific
> file.
>
> #ifdef CONFIG_SECURITY
> static struct dentry *lsm_dentry;
> static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
> 			loff_t *ppos)
> {
> 	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> 		strlen(lsm_names));
> }
>
> static const struct file_operations lsm_ops = {
> 	.read = lsm_read,
> 	.llseek = generic_file_llseek,
> };
> #endif
>
> securityfs_init()
>
> #ifdef CONFIG_SECURITY
> 	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
> 						&lsm_ops);
> #endif
>
> So why not move it? Maybe others, can comment more on whether it's a good idea
> to move security/inode.c into fs/security/inode.c?
> This should then help others identify securityfs filesystem in fs/security/
> for everyone to notice and utilize for their use?
>> fwsecurityfs(/sys/firmware/security) is to similarly provide a common place
>> for all firmware security objects.
>>
>> /sys/firmware already exists. The patch now defines a new /security
>> directory in it for firmware security features. Using /sys/kernel/security
>> would mean scattering firmware objects in multiple places and confusing the
>> purpose of /sys/kernel and /sys/firmware.
> We can also think of it this way that, all security related exports should
> happen via /sys/kernel/security/. Then /sys/kernel/security/firmware/ becomes
> the security related firmware exports.
>
> If you see find /sys -iname firmware, I am sure you will find other firmware
> specifics directories related to other specific subsystems
> (e.g.
> root@qemu:/home/qemu# find /sys -iname firmware
> /sys/devices/ndbus0/nmem0/firmware
> /sys/devices/ndbus0/firmware
> /sys/firmware
> )
>
> But it could be, I am not an expert here, although I was thinking a good
> Documentation might solve this problem.

Documentation on 
sysfs(https://man7.org/linux/man-pages/man5/sysfs.5.html) already 
differentiates /sys/firmware and /sys/kernel as I responded earlier.  
The objects we are exposing are firmware objects and not kernel objects.

>
>> Even though fwsecurityfs code is based on securityfs, since the two
>> filesystems expose different types of objects and have different
>> requirements, there are distinctions:
>>
>> 1. fwsecurityfs lets users create files in userspace, securityfs only allows
>> kernel subsystems to create files.
> Sorry could you please elaborate how? both securityfs & fwsecurityfs
> calls simple_fill_super() which uses the same inode (i_op) and inode file
> operations (i_fop) from fs/libfs.c for their root inode. So how it is enabling
> user (as in userspace) to create a file in this filesystem?
>
> So am I missing anything?

The ability to let user(as in userspace) to create a file in a 
filesystem comes by allowing to define inode operations.

Please look at the implementation differences for functions 
xxx_create_dir() and xxx_create_dentry() of securityfs vs fwsecurityfs.  
Also refer to Patch 4/4 for use of fwsecurityfs_create_dir() where inode 
operations are defined.

>
>> 2. firmware and kernel objects may have different requirements. For example,
>> consideration of namespacing. As per my understanding, namespacing is
>> applied to kernel resources and not firmware resources. That's why it makes
>> sense to add support for namespacing in securityfs, but we concluded that
>> fwsecurityfs currently doesn't need it. Another but similar example of it
> It "currently" doesn't need it. But can it in future? Then why not go with
> securityfs which has an additional namespacing feature available?
> That's actually also the point of utilizing an existing FS which can get
> features like this in future. As long as it doesn't affect the functionality
> of your use case, we simply need not reject securityfs, no?

Thanks for your review and feedback. To summarize:

 From the perspective of our use case, we need to expose firmware 
security objects to userspace for management. Not all of the objects 
pre-exist and we would like to allow root to create them from userspace.

 From a unification perspective, I have considered a common location at 
/sys/firmware/security for managing any platform's security objects. And 
I've proposed a generic filesystem, which could be used by any platform 
to represent firmware security objects via /sys/firmware/security.

Here are some alternatives to generic filesystem in discussion:

1. Start with a platform-specific filesystem. If more platforms would 
like to use the approach, it can be made generic. We would still have a 
common location of /sys/firmware/security and new code would live in 
arch. This is my preference and would be the best fit for our use case.

2. Use securityfs.  This would mean modifying it to satisfy other use 
cases, including supporting userspace file creation. I don't know if the 
securityfs maintainer would find that acceptable. I would also still 
want some way to expose variables at /sys/firmware/security.

3. Use a sysfs-based approach. This would be a platform-specific 
implementation. However, sysfs has a similar issue to securityfs for 
file creation. When I tried it in RFC v1[1], I had to implement a 
workaround to achieve that.

[1] 
https://lore.kernel.org/linuxppc-dev/20220122005637.28199-3-nayna@linux.ibm.com/

Thanks & Regards,

      - Nayna

