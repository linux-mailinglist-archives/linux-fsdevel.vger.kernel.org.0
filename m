Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24B3542F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhDEOre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 10:47:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235948AbhDEOre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 10:47:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 135EZBd7170609;
        Mon, 5 Apr 2021 10:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Afm9EWdHKFvlx5Of1/Wl8tKxK4BLYisZwdykxK2QD1w=;
 b=ZqZd+rkyXJcnVq5Y80+MJ+v9jCbpo0LmK2yhBOzE/pMuZQVApXVEYARtlVZu1yeMueTS
 9mgUlIyMMlNmj2PU7uXVGuYemRuKxSHVX6Y1kJO3nc/elGcMGXZs1gRXcSe+jE34vhgB
 fsFIlsYZRxbnv1XZUDadW28oG4cyCdJu0FSFfY8C70BuhFQQYncm4B2/G6dzcSCfPtOt
 aKNtpV0K3IyOEnpZuYtKymwYnHMraLUlpEwaEM87NSa0bFouLSa1cwPIWxjp5BieYzjS
 SyNyYWBDkRZQyr+1xdqQYfTQydVDMeR2Vyf+lNdXg/TGoiBJrE7fOjkUwO+vkVOrDrzt AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q594vnuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Apr 2021 10:47:09 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 135EaBwW173742;
        Mon, 5 Apr 2021 10:47:09 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q594vntf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Apr 2021 10:47:09 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 135EjfHO007868;
        Mon, 5 Apr 2021 14:47:06 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 37q2nm8q35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Apr 2021 14:47:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 135El41n42074566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Apr 2021 14:47:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0261CAE045;
        Mon,  5 Apr 2021 14:47:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ADD2AE051;
        Mon,  5 Apr 2021 14:47:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.95.226])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Apr 2021 14:47:00 +0000 (GMT)
Message-ID: <4224a40756ca036756493782ece9885967fd5892.camel@linux.ibm.com>
Subject: Re: LSM and setxattr helpers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tyler Hicks <code@tyhicks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>
Date:   Mon, 05 Apr 2021 10:47:00 -0400
In-Reply-To: <CAOQ4uxg+82RLt+KZXVLYhuDvrPLE0zaLf3Nw=oCJ=wBY6j6hTw@mail.gmail.com>
References: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
         <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
         <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
         <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
         <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
         <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
         <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
         <20210331125412.GI30749@quack2.suse.cz>
         <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
         <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
         <20210401102947.GA29690@quack2.suse.cz>
         <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
         <CAOQ4uxgE_bCK_URCe=_4mBq4_72bazM86D859Kzs_ZoWyKJRhw@mail.gmail.com>
         <CAOQ4uxg+82RLt+KZXVLYhuDvrPLE0zaLf3Nw=oCJ=wBY6j6hTw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LzueR-7x5BesJv-g7zIXttCxGZXDXqEf
X-Proofpoint-ORIG-GUID: SQpp_itQSI-D0eQpFMZmt8h2fGxU2NIt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_11:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050100
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

On Sun, 2021-04-04 at 13:27 +0300, Amir Goldstein wrote:
> [forking question about security modules]
> 
> >
> > Nice thing about vfs_{set,remove}xattr() is that they already have
> > several levels of __vfs_ helpers and nfsd already calls those, so
> > we can hoist fsnotify_xattr() hooks hooks up from the __vfs_xxx
> > helpers to the common vfs_xxx helpers and add fsnotify hooks to
> > the very few callers of __vfs_ helpers.
> >
> > nfsd is consistently calling __vfs_{set,remove}xattr_locked() which
> > do generate events, but ecryptfs mixes __vfs_setxattr_locked() with
> > __vfs_removexattr(), which does not generate event and does not
> > check permissions - it looks like an oversight.
> >
> > The thing is, right now __vfs_setxattr_noperm() generates events,
> > but looking at all the security/* callers, it feels to me like those are
> > very internal operations and that "noperm" should also imply "nonotify".
> >
> > To prove my point, all those callers call __vfs_removexattr() which
> > does NOT generate an event.
> >
> > Also, I *think* the EVM setxattr is something that usually follows
> > another file data/metadata change, so some event would have been
> > generated by the original change anyway.
> >
> > Mimi,
> >
> > Do you have an opinion on that?

Right, EVM is re-calculating the EVM HMAC, which is based on other LSM
xattrs and includes some misc file metadata (e.g. ino, generation, uid,
gid, mode).

> >
> > The question is if you think it is important for an inotify/fanotify watcher
> > that subscribed to IN_ATTRIB/FAN_ATTRIB events on a file to get an
> > event when the IMA security blob changes.

Probably not.  Programs could open files R/W, but never modify the
file.  Perhaps to detect mutable file changes, but I'm not aware of
anyone doing so.

> 
> Guys,
> 
> I was doing some re-factoring of the __vfs_setxattr helpers
> and noticed some strange things.
> 
> The wider context is fsnotify_xattr() hooks inside internal
> setxattr,removexattr calls. I would like to move those hooks
> to the common vfs_{set,remove}xattr() helpers.
> 
> SMACK & SELINUX:
> For the callers of __vfs_setxattr_noperm(),
> smack_inode_setsecctx() and selinux_inode_setsecctx()
> It seems that the only user is nfsd4_set_nfs4_label(), so it
> makes sense for me to add the fsnotify_xattr() in nfsd context,
> same as I did with other fsnotify_ hooks.
> 
> Are there any other expected callers of security_inode_setsecctx()
> except nfsd in the future? If so they would need to also add the
> fsnotify_xattr() hook, if at all the user visible FS_ATTRIB event is
> considered desirable.
> 
> SMACK:
> Just to be sure, is the call to __vfs_setxattr() from smack_d_instantiate()
> guaranteed to be called for an inode whose S_NOSEC flag is already
> cleared? Because the flag is being cleared by __vfs_setxattr_noperm().
> 
> EVM:
> I couldn't find what's stopping this recursion:
> evm_update_evmxattr() => __vfs_setxattr_noperm() =>
> security_inode_post_setxattr() => evm_inode_post_removexattr() =>
> evm_update_evmxattr()

EVM is triggered when file metadata changes, causing the EVM HMAC to be
re-calculated. Before updating security.evm, EVM first verifies, on the
evm_inode_setattr/setxattr/removexattr() hooks, that the existing
security.evm value is correct.

On the _post hooks, security.evm is updated or removed, if no LSM xattr
exists.

> It looks like the S_NOSEC should already be clear when
> evm_update_evmxattr() is called(?), so it seems more logical to me to
> call __vfs_setxattr() as there is no ->inode_setsecurity() hook for EVM.
> Am I missing something?

EVM is triggered when an LSM updates/removes its xattr.   The LSM is
responsible for taking the inode lock.   Thus it is calling
__vfs_setxattr_noperm.

> 
> It seems to me that updating the EVM hmac should not generate
> a visible FS_ATTRIB event to listeners, because it is an internal
> implementation detail and because update EVM hmac happens
> following another change to the inode which anyway reports a
> visible event to listeners.

Ok

> Also, please note that evm_update_evmxattr() may also call
> __vfs_removexattr() which does not call the fsnotify_xattr() hook.
> 
> IMA:
> Similarly, ima_fix_xattr() should be called on an inode without
> S_NOSEC flag and no other LSM should be interested in the
> IMA hash update, right? So wouldn't it be better to use
> __vfs_setxattr() in this case as well?
> 
> ima_fix_xattr() can be called after file data update, which again
> will have other visible events, but it can also be called in "fix mode"
> I suppose also when reading files? Still, it seems to me like an
> internal implementation detail that should not generate a user
> visible event.

Originally, IMA took the inode lock really early, way before calling
setxattr.  Taking the inode lock can probably be deferred to setxattr. 
I have a vague recollection that SELinux also prevented IMA from
writing its own xattr label.  I don't know if that is still true.

thanks,

Mimi

> 
> If you agree with my proposed changes, please ACK the
> respective bits of your subsystem from the attached patch.
> Note that my patch does not contain the proposed change to
> use __vfs_setxattr() in IMA/EVM.
> 
> Thanks,
> Amir.

