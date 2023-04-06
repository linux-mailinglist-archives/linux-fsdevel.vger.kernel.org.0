Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76296D9D43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 18:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbjDFQKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239951AbjDFQKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:10:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00BB9755;
        Thu,  6 Apr 2023 09:10:15 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336FUGuc022381;
        Thu, 6 Apr 2023 16:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5693Cus/qNkpiZCTVWnDxSRruDb522wM3A9d/ufocEY=;
 b=a0vPK1CWe4oF+DTsn+HfjKC0918cphhV44BtzPxwJbb3PUWDSYDndFZzlqgLc2qfc35+
 jaK29SoWG3gm55LyD6ndn7hyFChG1aU+5yP52bHgjMLXQcHTLiIn395QxMbaDcFgSpeq
 XN+7Tfv1veTyzi1ath376YlimK/a6ye5geAYHfAu9yuB1TiwC7hIMrCC+Y2bZtCT6MBD
 xWJrETMZ962a4R5W9uscpMQU9OkIk6w8cLC/9on9mX1rQEY6zFyxMSSy5qb3kF1Ozwka
 Hb9VZVPe0YAuLkhsUa2phjjEYFtyZaMHyclXmPf21+CCn508fO1tXyHmizNsNTXyMm4i 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt03sagy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 16:10:10 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 336FqLBM010942;
        Thu, 6 Apr 2023 16:10:10 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt03sagwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 16:10:10 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336FeUo6028006;
        Thu, 6 Apr 2023 16:10:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ppc88jahp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 16:10:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 336GA6IO16450106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Apr 2023 16:10:07 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D086458059;
        Thu,  6 Apr 2023 16:10:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E585D5805E;
        Thu,  6 Apr 2023 16:10:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Apr 2023 16:10:05 +0000 (GMT)
Message-ID: <a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com>
Date:   Thu, 6 Apr 2023 12:10:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <brauner@kernel.org>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
 <20230406-diffamieren-langhaarig-87511897e77d@brauner>
 <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
 <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
 <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MV4lEkvse16aqDIDhTP18FyS6RFkpIMQ
X-Proofpoint-ORIG-GUID: nxsYdAQTmibWu6xHKkQlJ-xBymrZVnNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304060143
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/6/23 10:36, Paul Moore wrote:
> On Thu, Apr 6, 2023 at 10:20 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>> On 4/6/23 10:05, Paul Moore wrote:
>>> On Thu, Apr 6, 2023 at 6:26 AM Christian Brauner <brauner@kernel.org> wrote:
>>>> On Wed, Apr 05, 2023 at 01:14:49PM -0400, Stefan Berger wrote:
>>>>> Overlayfs fails to notify IMA / EVM about file content modifications
>>>>> and therefore IMA-appraised files may execute even though their file
>>>>> signature does not validate against the changed hash of the file
>>>>> anymore. To resolve this issue, add a call to integrity_notify_change()
>>>>> to the ovl_release() function to notify the integrity subsystem about
>>>>> file changes. The set flag triggers the re-evaluation of the file by
>>>>> IMA / EVM once the file is accessed again.
>>>>>
>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> ---
>>>>>    fs/overlayfs/file.c       |  4 ++++
>>>>>    include/linux/integrity.h |  6 ++++++
>>>>>    security/integrity/iint.c | 13 +++++++++++++
>>>>>    3 files changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>>>>> index 6011f955436b..19b8f4bcc18c 100644
>>>>> --- a/fs/overlayfs/file.c
>>>>> +++ b/fs/overlayfs/file.c
>>>>> @@ -13,6 +13,7 @@
>>>>>    #include <linux/security.h>
>>>>>    #include <linux/mm.h>
>>>>>    #include <linux/fs.h>
>>>>> +#include <linux/integrity.h>
>>>>>    #include "overlayfs.h"
>>>>>
>>>>>    struct ovl_aio_req {
>>>>> @@ -169,6 +170,9 @@ static int ovl_open(struct inode *inode, struct file *file)
>>>>>
>>>>>    static int ovl_release(struct inode *inode, struct file *file)
>>>>>    {
>>>>> +     if (file->f_flags & O_ACCMODE)
>>>>> +             integrity_notify_change(inode);
>>>>> +
>>>>>         fput(file->private_data);
>>>>>
>>>>>         return 0;
>>>>> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
>>>>> index 2ea0f2f65ab6..cefdeccc1619 100644
>>>>> --- a/include/linux/integrity.h
>>>>> +++ b/include/linux/integrity.h
>>>>> @@ -23,6 +23,7 @@ enum integrity_status {
>>>>>    #ifdef CONFIG_INTEGRITY
>>>>>    extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
>>>>>    extern void integrity_inode_free(struct inode *inode);
>>>>> +extern void integrity_notify_change(struct inode *inode);
>>>>
>>>> I thought we concluded that ima is going to move into the security hook
>>>> infrastructure so it seems this should be a proper LSM hook?
>>>
>>> We are working towards migrating IMA/EVM to the LSM layer, but there
>>> are a few things we need to fix/update/remove first; if anyone is
>>> curious, you can join the LSM list as we've been discussing some of
>>> these changes this week.  Bug fixes like this should probably remain
>>> as IMA/EVM calls for the time being, with the understanding that they
>>> will migrate over with the rest of IMA/EVM.
>>>
>>> That said, we should give Mimi a chance to review this patch as it is
>>> possible there is a different/better approach.  A bit of patience may
>>> be required as I know Mimi is very busy at the moment.
>>
>> There may be a better approach actually by increasing the inode's i_version,
>> which then should trigger the appropriate path in ima_check_last_writer().
> 
> I'm not the VFS/inode expert here, but I thought the inode's i_version
> field was only supposed to be bumped when the inode metadata changed,
> not necessarily the file contents, right?
> 
> That said, overlayfs is a bit different so maybe that's okay, but I
> think we would need to hear from the VFS folks if this is acceptable.
> 

Exactly.

In ima_check_last_writer() I want to trigger the code path with iint->flags &= ...



	if (atomic_read(&inode->i_writecount) == 1) {
		update = test_and_clear_bit(IMA_UPDATE_XATTR,
					    &iint->atomic_flags);
		if (!IS_I_VERSION(inode) ||
		    !inode_eq_iversion(inode, iint->version) ||
		    (iint->flags & IMA_NEW_FILE)) {
			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
			iint->measured_pcrs = 0;
			if (update)
				ima_update_xattr(iint, file);
		}
	}


This patch here resolves it for my use case and triggers the expected code paths when
ima_file_free() -> ima_check_last_writer() is called because then the i_version is seen
as having been modified.

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 6011f955436b..1dfe5e7bfe1c 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -13,6 +13,7 @@
  #include <linux/security.h>
  #include <linux/mm.h>
  #include <linux/fs.h>
+#include <linux/iversion.h>
  #include "overlayfs.h"

  struct ovl_aio_req {
@@ -408,6 +409,8 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
                 if (ret != -EIOCBQUEUED)
                         ovl_aio_cleanup_handler(aio_req);
         }
+       if (ret > 0)
+               inode_maybe_inc_iversion(inode, false);
  out:
         revert_creds(old_cred);
  out_fdput:



I have been testing this in a OpenBMC/Yocto environment where overlayfs is used as
root filesystem with the lower filesystem being a squashfs.

Regards,
    Stefan
