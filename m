Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8B628D28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 00:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiKNXHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 18:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbiKNXGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:06:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2520F66;
        Mon, 14 Nov 2022 15:04:35 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEMhhSi027321;
        Mon, 14 Nov 2022 23:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=r2fzDqWsStLA1xUQ8hFm6TfQBbcyzJkCztYXsu/2swA=;
 b=Sm/Lp2TX1gppX2Z5a9Mns5MPvNGLBnKFMG0y1Olw/g8Em+og+eRJLS9LWumlXbmUovqU
 dkrtXwZGaaMchdsWqRkNnVvxkIAXUhbfhAMwzrxPN/0oBwNpRw06WPn+IcofHjWhUF5P
 /2AgtoudXJDAEu0XaHjQz295RoCJPAy6t46Hn5ze6mFsb2gIkqA9t+6KSx7lbCqQEg0h
 7KArhQC/f9HjMxnoCnGtjPM58zSMDutYS530qmb+KPD3kfuC9ATqjoEHWB6m5VRD0gXJ
 gTyUpWZXwbF0MgWKkEqxzVKadK6hTK+VTyJQ2L8uV2s9Iw9jsm+jzxQlxzP8zV0f9jL/ VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kuxqnrbk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:03:48 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AEN07xD012744;
        Mon, 14 Nov 2022 23:03:48 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kuxqnrbjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:03:48 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEMpLxM017257;
        Mon, 14 Nov 2022 23:03:47 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3kt349ms1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:03:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEN3jIF1835724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 23:03:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3582D5807D;
        Mon, 14 Nov 2022 23:03:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 753D35808C;
        Mon, 14 Nov 2022 23:03:43 +0000 (GMT)
Received: from [9.163.46.135] (unknown [9.163.46.135])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 23:03:43 +0000 (GMT)
Message-ID: <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
Date:   Mon, 14 Nov 2022 18:03:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
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
        Stefan Berger <stefanb@linux.ibm.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com> <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
 <Y2zLRw/TzV/sWgqO@kroah.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <Y2zLRw/TzV/sWgqO@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cMTICiR-Ic39zShUHbdlZAJATSRcqSOJ
X-Proofpoint-ORIG-GUID: Ruez-Aie2yvxjHXtRL2XCcyi2xuMRRAi
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/10/22 04:58, Greg Kroah-Hartman wrote:
> On Wed, Nov 09, 2022 at 03:10:37PM -0500, Nayna wrote:
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
> Ok, then just use the normal sysfs interface for /sys/firmware, why do
> you need a whole new filesystem type?
>
>>  From git commit b67dbf9d4c1987c370fd18fdc4cf9d8aaea604c2, the purpose of
>> securityfs(/sys/kernel/security) is to provide a common place for all kernel
>> LSMs. The idea of
>> fwsecurityfs(/sys/firmware/security) is to similarly provide a common place
>> for all firmware security objects.
>>
>> /sys/firmware already exists. The patch now defines a new /security
>> directory in it for firmware security features. Using /sys/kernel/security
>> would mean scattering firmware objects in multiple places and confusing the
>> purpose of /sys/kernel and /sys/firmware.
> sysfs is confusing already, no problem with making it more confusing :)
>
> Just document where you add things and all should be fine.
>
>> Even though fwsecurityfs code is based on securityfs, since the two
>> filesystems expose different types of objects and have different
>> requirements, there are distinctions:
>>
>> 1. fwsecurityfs lets users create files in userspace, securityfs only allows
>> kernel subsystems to create files.
> Wait, why would a user ever create a file in this filesystem?  If you
> need that, why not use configfs?  That's what that is for, right?

The purpose of fwsecurityfs is not to expose configuration items but 
rather security objects used for firmware security features. I think 
these are more comparable to EFI variables, which are exposed via an 
EFI-specific filesystem, efivarfs, rather than configfs.

>
>> 2. firmware and kernel objects may have different requirements. For example,
>> consideration of namespacing. As per my understanding, namespacing is
>> applied to kernel resources and not firmware resources. That's why it makes
>> sense to add support for namespacing in securityfs, but we concluded that
>> fwsecurityfs currently doesn't need it. Another but similar example of it
>> is: TPM space, which is exposed from hardware. For containers, the TPM would
>> be made as virtual/software TPM. Similarly for firmware space for
>> containers, it would have to be something virtualized/software version of
>> it.
> I do not understand, sorry.  What does namespaces have to do with this?
> sysfs can already handle namespaces just fine, why not use that?

Firmware objects are not namespaced. I mentioned it here as an example 
of the difference between firmware and kernel objects. It is also in 
response to the feedback from James Bottomley in RFC v2 
[https://lore.kernel.org/linuxppc-dev/41ca51e8db9907d9060cc38adb59a66dcae4c59b.camel@HansenPartnership.com/].

>
>> 3. firmware objects are persistent and read at boot time by interaction with
>> firmware, unlike kernel objects which are not persistent.
> That doesn't matter, sysfs exports what the hardware provides, and that
> might persist over boot.
>
> So I don't see why a new filesystem is needed.
>
> You didn't explain why sysfs, or securitfs (except for the location in
> the tree) does not work at all for your needs.  The location really
> doesn't matter all that much as you are creating a brand new location
> anyway so we can just declare "this is where this stuff goes" and be ok.

For rest of the questions, here is the summarized response.

Based on mailing list previous discussions [1][2][3] and considering 
various firmware security use cases, our fwsecurityfs proposal seemed to 
be a reasonable and acceptable approach based on the feedback [4].

[1] https://lore.kernel.org/linuxppc-dev/YeuyUVVdFADCuDr4@kroah.com/#t
[2] https://lore.kernel.org/linuxppc-dev/Yfk6gucNmJuR%2Fegi@kroah.com/
[3] 
https://lore.kernel.org/all/Yfo%2F5gYgb9Sv24YB@kroah.com/t/#m40250fdb3fddaafe502ab06e329e63381b00582d
[4] https://lore.kernel.org/linuxppc-dev/YrQqPhi4+jHZ1WJc@kroah.com/

RFC v1 was using sysfs. After considering feedback[1][2][3], the 
following are design considerations for unification via fwsecurityfs:

1. Unify the location: Defining a security directory under /sys/firmware 
facilitates exposing objects related to firmware security features in a 
single place. Different platforms can create their respective directory 
structures within /sys/firmware/security.

2. Unify the code:  To support unification, having the fwsecurityfs 
filesystem API allows different platforms to define the inode and file 
operations they need. fwsecurityfs provides a common API that can be 
used by each platform-specific implementation to support its particular 
requirements and interaction with firmware. Initializing 
platform-specific functions is the purpose of the 
fwsecurityfs_arch_init() function that is called on mount. Patch 3/4 
implements fwsecurityfs_arch_init() for powerpc.

Similar to the common place securityfs provides for LSMs to interact 
with kernel security objects, fwsecurityfs would provide a common place 
for all firmware security objects, which interact with the firmware 
rather than the kernel. Although at the API level, the two filesystem 
look similar, the requirements for firmware and kernel objects are 
different. Therefore, reusing securityfs wasn't a good fit for the 
firmware use case and we are proposing a similar but different 
filesystem -  fwsecurityfs - focused for firmware security.

>
> And again, how are you going to get all Linux distros to now mount your
> new filesystem?

It would be analogous to the way securityfs is mounted.

Thanks & Regards,

     - Nayna

>
> thanks,
>
> greg k-h
