Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DEC7B54B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 16:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbjJBNx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbjJBNx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:53:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55592B0;
        Mon,  2 Oct 2023 06:53:24 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392DR234011306;
        Mon, 2 Oct 2023 13:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hFzxnbC2zQL74LdOXOKSy2xkkwswmK4nirAzoS0cvQo=;
 b=MJy/r6060fDQuXHUr7O7oWsHov1Nl4FhcsfHQlXcuKfWse6Zn6nQOsWdD47uhchDmIrf
 VevfyPPzA+dHIXlrZKQ0Qi+3u23XYjpzrKh41B6aMICol3UXqqL1xebsRvNfqs/7uMRi
 YQBC+7MnYvOuf7sapDCvvIHp3eCRwm25s5HUUQcPks4HiyOJvvu1HblY9wnID8KtnvGh
 85HQI9hozAZFTpv2BJXImsx8kqULJFfU9aSo2tD4aixNosy0lKnHinOVNOI1MC9z/WA3
 9zqisdPSNdny5iy3G0/BzAdtA9J1E2mme82SZwFj6+5lG0sMJdfQ3I1DGk+D1Xe8/7Qs 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tfwqpjqwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 13:53:03 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 392DR5RC011694;
        Mon, 2 Oct 2023 13:53:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tfwqpjqvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 13:53:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 392CcloG025094;
        Mon, 2 Oct 2023 13:53:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcxt4rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 13:53:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 392Dr0WO3736130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Oct 2023 13:53:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2A7158068;
        Mon,  2 Oct 2023 13:53:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A1F85803F;
        Mon,  2 Oct 2023 13:53:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Oct 2023 13:53:00 +0000 (GMT)
Message-ID: <146b0d63-9986-0e6b-6a15-bd05c1020fff@linux.ibm.com>
Date:   Mon, 2 Oct 2023 09:52:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface
 function
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
 <CAOQ4uxiuQxTDqn4F62ueGf_9f4KC4p7xqRZdwPvL8rEYrCOWbg@mail.gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxiuQxTDqn4F62ueGf_9f4KC4p7xqRZdwPvL8rEYrCOWbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -EPfJZvmNQr7HMMehohvIYDGfvd3RRgZ
X-Proofpoint-ORIG-GUID: E2WngRSwSvUQBKf8Eyhq7a1l6LykWxaB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020102
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/2/23 09:22, Amir Goldstein wrote:
> On Mon, Oct 2, 2023 at 3:57 PM Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> When vfs_getattr_nosec() calls a filesystem's getattr interface function
>> then the 'nosec' should propagate into this function so that
>> vfs_getattr_nosec() can again be called from the filesystem's gettattr
>> rather than vfs_getattr(). The latter would add unnecessary security
>> checks that the initial vfs_getattr_nosec() call wanted to avoid.
>> Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
>> with the new getattr_flags parameter to the getattr interface function.
>> In overlayfs and ecryptfs use this flag to determine which one of the
>> two functions to call.
>>
>> In a recent code change introduced to IMA vfs_getattr_nosec() ended up
>> calling vfs_getattr() in overlayfs, which in turn called
>> security_inode_getattr() on an exiting process that did not have
>> current->fs set anymore, which then caused a kernel NULL pointer
>> dereference. With this change the call to security_inode_getattr() can
>> be avoided, thus avoiding the NULL pointer dereference.
>>
>> Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
>> Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Amir Goldstein <amir73il@gmail.com>
>> Cc: Tyler Hicks <code@tyhicks.com>
>> Cc: Mimi Zohar <zohar@linux.ibm.com>
>> Suggested-by: Christian Brauner <brauner@kernel.org>
>> Co-developed-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> Now let's see what vfs maintainers think about this...


Thanks.

For the other reviewers, the original syzbot message with the 'final 
oops' is here:

https://lore.kernel.org/linux-integrity/bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com/T/#m616371f8ac1a316be13865e1699ac59ccf8ce6ef

Regards,

    Stefan


>
> Thanks,
> Amir.
>
>>   fs/ecryptfs/inode.c        | 12 ++++++++++--
>>   fs/overlayfs/inode.c       | 10 +++++-----
>>   fs/overlayfs/overlayfs.h   |  8 ++++++++
>>   fs/stat.c                  |  6 +++++-
>>   include/uapi/linux/fcntl.h |  3 +++
>>   5 files changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
>> index 992d9c7e64ae..5ab4b87888a7 100644
>> --- a/fs/ecryptfs/inode.c
>> +++ b/fs/ecryptfs/inode.c
>> @@ -998,6 +998,14 @@ static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
>>          return rc;
>>   }
>>
>> +static int ecryptfs_do_getattr(const struct path *path, struct kstat *stat,
>> +                              u32 request_mask, unsigned int flags)
>> +{
>> +       if (flags & AT_GETATTR_NOSEC)
>> +               return vfs_getattr_nosec(path, stat, request_mask, flags);
>> +       return vfs_getattr(path, stat, request_mask, flags);
>> +}
>> +
>>   static int ecryptfs_getattr(struct mnt_idmap *idmap,
>>                              const struct path *path, struct kstat *stat,
>>                              u32 request_mask, unsigned int flags)
>> @@ -1006,8 +1014,8 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap,
>>          struct kstat lower_stat;
>>          int rc;
>>
>> -       rc = vfs_getattr(ecryptfs_dentry_to_lower_path(dentry), &lower_stat,
>> -                        request_mask, flags);
>> +       rc = ecryptfs_do_getattr(ecryptfs_dentry_to_lower_path(dentry),
>> +                                &lower_stat, request_mask, flags);
>>          if (!rc) {
>>                  fsstack_copy_attr_all(d_inode(dentry),
>>                                        ecryptfs_inode_to_lower(d_inode(dentry)));
>> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
>> index 83ef66644c21..fca29dba7b14 100644
>> --- a/fs/overlayfs/inode.c
>> +++ b/fs/overlayfs/inode.c
>> @@ -171,7 +171,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
>>
>>          type = ovl_path_real(dentry, &realpath);
>>          old_cred = ovl_override_creds(dentry->d_sb);
>> -       err = vfs_getattr(&realpath, stat, request_mask, flags);
>> +       err = ovl_do_getattr(&realpath, stat, request_mask, flags);
>>          if (err)
>>                  goto out;
>>
>> @@ -196,8 +196,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
>>                                          (!is_dir ? STATX_NLINK : 0);
>>
>>                          ovl_path_lower(dentry, &realpath);
>> -                       err = vfs_getattr(&realpath, &lowerstat,
>> -                                         lowermask, flags);
>> +                       err = ovl_do_getattr(&realpath, &lowerstat, lowermask,
>> +                                            flags);
>>                          if (err)
>>                                  goto out;
>>
>> @@ -249,8 +249,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
>>
>>                          ovl_path_lowerdata(dentry, &realpath);
>>                          if (realpath.dentry) {
>> -                               err = vfs_getattr(&realpath, &lowerdatastat,
>> -                                                 lowermask, flags);
>> +                               err = ovl_do_getattr(&realpath, &lowerdatastat,
>> +                                                    lowermask, flags);
>>                                  if (err)
>>                                          goto out;
>>                          } else {
>> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
>> index 9817b2dcb132..09ca82ed0f8c 100644
>> --- a/fs/overlayfs/overlayfs.h
>> +++ b/fs/overlayfs/overlayfs.h
>> @@ -397,6 +397,14 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
>>          return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
>>   }
>>
>> +static inline int ovl_do_getattr(const struct path *path, struct kstat *stat,
>> +                                u32 request_mask, unsigned int flags)
>> +{
>> +       if (flags & AT_GETATTR_NOSEC)
>> +               return vfs_getattr_nosec(path, stat, request_mask, flags);
>> +       return vfs_getattr(path, stat, request_mask, flags);
>> +}
>> +
>>   /* util.c */
>>   int ovl_want_write(struct dentry *dentry);
>>   void ovl_drop_write(struct dentry *dentry);
>> diff --git a/fs/stat.c b/fs/stat.c
>> index d43a5cc1bfa4..5375be5f97cc 100644
>> --- a/fs/stat.c
>> +++ b/fs/stat.c
>> @@ -133,7 +133,8 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>>          idmap = mnt_idmap(path->mnt);
>>          if (inode->i_op->getattr)
>>                  return inode->i_op->getattr(idmap, path, stat,
>> -                                           request_mask, query_flags);
>> +                                           request_mask,
>> +                                           query_flags | AT_GETATTR_NOSEC);
>>
>>          generic_fillattr(idmap, request_mask, inode, stat);
>>          return 0;
>> @@ -166,6 +167,9 @@ int vfs_getattr(const struct path *path, struct kstat *stat,
>>   {
>>          int retval;
>>
>> +       if (WARN_ON_ONCE(query_flags & AT_GETATTR_NOSEC))
>> +               return -EPERM;
>> +
>>          retval = security_inode_getattr(path);
>>          if (retval)
>>                  return retval;
>> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
>> index 6c80f96049bd..282e90aeb163 100644
>> --- a/include/uapi/linux/fcntl.h
>> +++ b/include/uapi/linux/fcntl.h
>> @@ -116,5 +116,8 @@
>>   #define AT_HANDLE_FID          AT_REMOVEDIR    /* file handle is needed to
>>                                          compare object identity and may not
>>                                          be usable to open_by_handle_at(2) */
>> +#if defined(__KERNEL__)
>> +#define AT_GETATTR_NOSEC       0x80000000
>> +#endif
>>
>>   #endif /* _UAPI_LINUX_FCNTL_H */
>> --
>> 2.40.1
>>
