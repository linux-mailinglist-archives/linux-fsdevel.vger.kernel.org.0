Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293F745657D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 23:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhKRWO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 17:14:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39692 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229978AbhKRWO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:14:27 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AILmZAR020577;
        Thu, 18 Nov 2021 22:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 from : subject : cc : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=gwVD8OLBS/pRb0rakaR8YFqOBdcSR3wQ6kqmPWcX358=;
 b=Kpwvlm6eIxHFxRN9j08IteCG7Z8vgVjqgFHKmnzENeVtN5LjcN2PA9bAjeLCmyld2yDX
 5ts87wGjd15eAk7ryC/bdF+qYz/Y70L66taXi8vW5+A9zvaLlL36beqm83gfnAhc19UK
 I5LAzbHPZTILqUiyB9K0QH7jbPdzwqMQIjssCrdRf2E8BATZjGQSFgQYp0v+KcmwCpeE
 6FegQ6Lppzp787JvG5Fg8Ck6B5RPX7luBxOPQC1FzSS625ustaCZkIu/Pqi81vsMVgqs
 hs5gXuddQgVKnHdJkrmd4RSrfmNG0e4tv/3knYT0bDelTLCOYL6SeCjCik6FvVZ5nsj4 hQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdy2vgmbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 22:11:24 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AILx5Bv032700;
        Thu, 18 Nov 2021 22:11:24 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3ca50ceww7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 22:11:24 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AIMBMAj32964980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 22:11:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEC3DB2067;
        Thu, 18 Nov 2021 22:11:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A4ABB2070;
        Thu, 18 Nov 2021 22:11:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 22:11:22 +0000 (GMT)
Message-ID: <9dc11d1e-0b19-33ac-caf8-f6919c260d8e@linux.ibm.com>
Date:   Thu, 18 Nov 2021 17:11:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     linux-fsdevel@vger.kernel.org
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: SecurityFS for namespaced IMA
Cc:     viro@zeniv.linux.org.uk, Mimi Zohar <zohar@linux.ibm.com>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LJbuSUtkGt4vRml10Y8L4VevU3wUuSS1
X-Proofpoint-ORIG-GUID: LJbuSUtkGt4vRml10Y8L4VevU3wUuSS1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180114
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi !

   I have been looking at the SecurityFS code (security/inode.c) since I 
am currently trying to figure out how to create a version of SecurityFS 
for IMA namespaces support and maybe you have some guidance on this. 
Having a namespace-supporting (multi-instance) version/derivative of 
SecurityFS seems to be key for what we want to do for namespacing IMA. 
Also, I was trying to get a discussion started here that may give you 
some more details about what we are trying to do: 
https://github.com/opencontainers/runc/issues/3288

   I have looked through some of the core code of the Linux filesystem 
subsystem a bit and it seems like what we would need for our intentions 
is some sort of filesystem that is using the function get_tree_keyed() 
where the key is an identifier for the namespace, maybe the IMA/user 
namespace pointer itself. [ 
https://elixir.bootlin.com/linux/latest/source/fs/super.c#L1190 ] This 
would presumably allow us to create an instance of this new filesystem 
per IMA/user namespace (IMA namespace would hang off the user 
namespace). And the next idea then is to pass vfsmount ** and 
vfs_mount_count ( from here 
https://elixir.bootlin.com/linux/latest/source/security/inode.c#L25) via 
a namespaced securityfs API along the lines of this here:

extern struct dentry *securityfs_ns_create_dir(const char *name, struct 
dentry *parent, struct vfsmount **, int *mount_count);

The vsfcount * and mount_count would reside in the 'struct 
ima_namespace'. This would hopefully let us reuse the rather simple 
looking SecurityFS code, which is at least my definite starting point 
before venturing into something more complicated, but I have my doubts 
after the first debugging exercises with a prototype. The first issue I 
know about for sure is due to the fact that we currently initialize 
SecurityFS when we initialize the IMA namespace while the old user 
namespace is still active. This then sets the user_ns in the superblock 
to the current active userns and we'll end up failing to use the 
superblock because of this check here when trying a mount:

share_extant_sb:
     if (user_ns != old->s_user_ns) {
         spin_unlock(&sb_lock);
         destroy_unused_super(s);
         return ERR_PTR(-EBUSY);
     }

https://elixir.bootlin.com/linux/latest/source/fs/super.c#L556

So now the question is whether it is possible to initialize this 
filesystem at clone() time while the old user namespace is active 
(unlikely the way it currently works) or whether the initialization 
(populating filesystem with dirs and files) needs to be deferred until 
the user does a mount with the intended user namespace active? I guess 
in the latter case there would have to be some sort of callback from the 
filesystem code into the IMA namespace-filesystem-population-code that 
gets invoked when the filesystem is mounted (?). So would the 
initialization have to be done that late? I am wondering whether the 
above outlined API could be called then in that callback or whether this 
isn't possible then at all with the vfsmount and mount_count parameters 
(that presumably help associating the directories etc. with the root).

Well, I am hoping the above makes sense and maybe you have some 
directions for how one could go about this before I go down other 
possible erroneous paths.

Regards,

    Stefan

