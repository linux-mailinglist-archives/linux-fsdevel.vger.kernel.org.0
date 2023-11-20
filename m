Return-Path: <linux-fsdevel+bounces-3254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1DA7F1BE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 19:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E151F2530B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031492FE20;
	Mon, 20 Nov 2023 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y48fR4a1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B4AC
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 10:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700503449; bh=YsSUzOehopsOuurjoEtRppweQH73o8CvXnhYaHqSYNA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Y48fR4a1Ue5dN+gcENJyMBe/drjiV2JVr9TJ5W51EETAC7PSyTDXh7nPOXBjXPWG4rVP3l5pMVcBO/+1zfjuvOPVOVZsPvTI5tAKoONrUA4jWZUQyGjsPMMRXKJV0BGgelmBZZa0AXZ5V7zqDg1o7m1mJvDOqFcmP0Td/g0ZrxPAhMlmNaBN4KPB/L/Vo55J/o4glEvtoPlpc8rAyLCSzO/1A8XQh+BMzVRe7M5OlREipzuSeWmtjEDM4Nn+xnrkSkLpKtFIIaisOEnr/aVtxp6PlkpLq6ydLg/t24Gstl+0RQkDIUyoTHT6R5l7MTizf3kkbUaM0px2CWGmH1yz6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700503449; bh=0Cajj7CWL5u42Ymw4ZXt7+/Jl0xbYZhm0bGq/aHkHp+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ill12XfQwbk6r1F8Imm5oSABKvBwfq2pzy1CylQ+REizhYulRW/zYRw5WwKjeau1on11YwjCFAiuuAgMvsjccp40yXF+cdBwCO/lgJb2+8aGBSswo5j9//frT41VoBezYkXPp5r2VZJpzfp9ky8j022rB97v/XqBCMTLhx+7UCW7s5b/sO9GO1jv6mt+ND/fRrE3qlpreChqLx5CC2E18LmzUg/dB8Xo5lsXrc2wZQPvcDIaQmZ+EenTB2DYT1SFWCurM0304+lIshyjcDYl+4xohjQf6oaZEF31KvvhqrsMv9jqyFw+lUQiscbKegJ/qN7M1UPAGtim7O1j8uXH1A==
X-YMail-OSG: i3xlU9UVM1mvC3IPjn2QuideRSRibsfGRbWKrfJrAHBGD2jEboFXXaDDltovQfu
 EpOwZX5a.510h0YvsThKiaI5bvE0ZTuRm5upUnxOAgDisdXW53tUhdqckw_sWYPnvKTm0aBi8LVR
 WWZgJBH0Rhl9A9j1sIrIkxsPc.dHkxVip09lgKSMG6kNrD9PNgwpC8gzIZPqE8tApawhAPnz1hV0
 9xs6hwBd0fNCgKoz7x9meXABK6k2JXidT2oqqpHRFarvL4OP3qvEVI8aFDc6nCQS9z7PaMiafRYU
 nCIDj3wqduW48ROIjTH.LYgUvf2cIvIxDmxCkGlfv5fmPfP98Q1f_bJM6FF1b92FrrM.z9kcu2oC
 uWSOnDjkHrnbjU80I_yaWjZ0fZS0dRIQWfiMWHoXftxYoqm5eH.ssr3cxcOAH9G4sJzDVi3khv0v
 pOcAcX5c8G63M.s.Xqea15NNBXVuvDYZ0rEzmMFQLaf0qbpwBmxSDeURozhuOHP.ofxnz6GCjB3k
 Q1Eaiu4tJ.zwMW.DYdMqhk9W2LF96ZBQYMBQY_z.TAYUUTTuluznc902_tR6zv3oyfGzLbzKYCiX
 Fho2NlqZwNkr2knvtAcyi_8a8nPYjKsLjHibEA9_SPj4MhPHdq0apCfiqLJytcJ4L8GqqdahMNRl
 Ls4UljVUAzELNncmxF2pISJZ5jo6cqRjIaT8NwgMyt0teWSJpd1LJ0UV.hULzlWKKnAByIjp9dDQ
 JTrpdNJLKh5zulxcBv.b5hGhgBzjJcdiUJL0WCRmCtP.OFIUZcUZrm5M7N3wjWjiPBjhQ7qCunOk
 IUHrcyDhFBrhYCxG3_IsFHjMaTA.4OPCTa8D8Rnsh6VqimJJhoM3oSJADi0kKmWYlQROpqz3KvGs
 blpJhcA.1JX8b79LAz4B2CimFpbMZgHKOftPVwSdps2WW.5sMSH31DRs03ojI29Wpvayd5q2Tacl
 v.hB6qFizEAYziT2_Xr2_F2RmysJahAqPv1yXc1ukzujjFLk_iXY0h5PG3qbDcS0CxzoUXmUJ.Mo
 RnqKUXQqEtPbJ4OAfYB3X_RNW.T3w0rVbavYE3gyTEQFzy8IgltoOWjbwDUSrmFPxdlUTbdT_vwW
 Sxv3g9dhf3alBXPAQPQhvISxi6IKd0v4ns4j8s3CjRG6E_hk.tjXnMvkgSSVKMDeDg6Va63w.ma8
 Gl76lnmm6uOOEdNy2qQodCZFvfO5i9xiIIdl1_APuhP2GH4DwGo4aei0V4TK9FGKbrU17kaDJ636
 Z.Vc41DMUEQfFDXPBCU6y4FGH3FP1F.z99_NMWQp_izS4WGIlwob.4zIvj6qkuzPccqJY3A51hqY
 UgsDDsH9HE2SN54YV5AB45WkRsrcH3V0mI9yeA_aaT0Up.JK0KGh_newgHMdL4uZRqzdY5S6lKFU
 z_hgar7oUZSO6uYuhv80yFCabJ.OGEyjO2SEk4kKe25vGUDVecYpLp1v9y7gy1pZjiH0qJe2Ghad
 oUa98D_BU2yZ5HzGwdI_H8tfG_ezIiruxwJzRoGpYwN_ghRmy8_xenf7pOe28fu6oqMpcKWvVL7T
 HkV.3nHiCFzreDyPGWCUikMR78K4kbayCD6144swLw.PNSMd9wHGbpR5Yp4kPjeM3Qsf8xXaE8j7
 C2v1Aavmt375OukEg_qgEJsxsgI9AQor5cNTuSdYVNK8zqgAKErEkpbMs3GTnEoSc.SDq.9UAgbN
 nCXCAGBWBZuOKIaINNqkkDx__wIXJ14Ja3OYAufxTyMZQthDZgQSIzER7FbHsxBW06hZCRdo8BPe
 di6zGpvuhtr3MUlavnRqk30srdTXG8QoU17XHorezj51il4SLyc0_D3fJ5Cx2xat4AB4718WvEjy
 euMmv64bEWu8dEH01pt9gVLJVA.3uiwrBy8RZUOyZ_IJ3smPS3GJYFO_lIpaH5dCwrRIhaFnL092
 9N2UQYbObF4hSQ46S3C9usRGtl2DjRJTcJTs_cB4_xRnguzEeLxWkahUhmHxW0jsZQvykUV9khza
 6T6hul82P3HOoDwB07xYfUk6fThuz9QyWZhhOzPgMB4QY19.nSvOB1bODOp1_042Xk6dVVleKi4d
 VI6PiM9JU6.ogNdKh_mZIXPWY76vjNPor2S5eDKim4mmYdOSEzRIyjIzC.PCGfTgmSiVZityE.nZ
 48kLWF4tkgfJuUKZsV2qi5GLAJRT4J36i9GSF1lARncqN58niNRFfODfEhO57Fkl3EUhp8DGbUmj
 dXuW6Azo2b2uNTS_nOd4T4xhigGpInOwTDbLR3.d6DkR92tplk0EBv2po
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b514ae89-a91e-4c32-9d1c-c882b7e7008c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 20 Nov 2023 18:04:09 +0000
Received: by hermes--production-gq1-59b5df67b6-hs7p7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3916744e962c63c3de3d31fc01bce0cd;
          Mon, 20 Nov 2023 18:04:02 +0000 (UTC)
Message-ID: <13f7542f-4039-47a8-abde-45a702b85718@schaufler-ca.com>
Date: Mon, 20 Nov 2023 10:03:59 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/23] security: Introduce inode_post_removexattr hook
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
 <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
 <85c5dda2-5a2f-4c73-82ae-8a333b69b4a7@schaufler-ca.com>
 <1999ed6f77100d9d2adc613c9748f15ab8fcf432.camel@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1999ed6f77100d9d2adc613c9748f15ab8fcf432.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/20/2023 9:31 AM, Roberto Sassu wrote:
> On Tue, 2023-11-07 at 09:33 -0800, Casey Schaufler wrote:
>> On 11/7/2023 5:40 AM, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
>>> the inode_post_removexattr hook.
>>>
>>> At inode_removexattr hook, EVM verifies the file's existing HMAC value. At
>>> inode_post_removexattr, EVM re-calculates the file's HMAC with the passed
>>> xattr removed and other file metadata.
>>>
>>> Other LSMs could similarly take some action after successful xattr removal.
>>>
>>> The new hook cannot return an error and cannot cause the operation to be
>>> reverted.
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>> ---
>>>  fs/xattr.c                    |  9 +++++----
>>>  include/linux/lsm_hook_defs.h |  2 ++
>>>  include/linux/security.h      |  5 +++++
>>>  security/security.c           | 14 ++++++++++++++
>>>  4 files changed, 26 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/xattr.c b/fs/xattr.c
>>> index 09d927603433..84a4aa566c02 100644
>>> --- a/fs/xattr.c
>>> +++ b/fs/xattr.c
>>> @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>>>  		goto out;
>>>  
>>>  	error = __vfs_removexattr(idmap, dentry, name);
>>> +	if (error)
>>> +		goto out;
>> Shouldn't this be simply "return error" rather than a goto to nothing
>> but "return error"?
> I got a review from Andrew Morton. His argument seems convincing, that
> having less return places makes the code easier to handle.

That was in a case where you did more than just "return". Nonetheless,
I think it's a matter of style that's not worth debating. Do as you will.

>
> Thanks
>
> Roberto
>
>>> -	if (!error) {
>>> -		fsnotify_xattr(dentry);
>>> -		evm_inode_post_removexattr(dentry, name);
>>> -	}
>>> +	fsnotify_xattr(dentry);
>>> +	security_inode_post_removexattr(dentry, name);
>>> +	evm_inode_post_removexattr(dentry, name);
>>>  
>>>  out:
>>>  	return error;
>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>>> index 67410e085205..88452e45025c 100644
>>> --- a/include/linux/lsm_hook_defs.h
>>> +++ b/include/linux/lsm_hook_defs.h
>>> @@ -149,6 +149,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
>>>  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
>>>  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
>>>  	 struct dentry *dentry, const char *name)
>>> +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
>>> +	 const char *name)
>>>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>>>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
>>>  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index 664df46b22a9..922ea7709bae 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -380,6 +380,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
>>>  int security_inode_listxattr(struct dentry *dentry);
>>>  int security_inode_removexattr(struct mnt_idmap *idmap,
>>>  			       struct dentry *dentry, const char *name);
>>> +void security_inode_post_removexattr(struct dentry *dentry, const char *name);
>>>  int security_inode_need_killpriv(struct dentry *dentry);
>>>  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
>>>  int security_inode_getsecurity(struct mnt_idmap *idmap,
>>> @@ -940,6 +941,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
>>>  	return cap_inode_removexattr(idmap, dentry, name);
>>>  }
>>>  
>>> +static inline void security_inode_post_removexattr(struct dentry *dentry,
>>> +						   const char *name)
>>> +{ }
>>> +
>>>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>>>  {
>>>  	return cap_inode_need_killpriv(dentry);
>>> diff --git a/security/security.c b/security/security.c
>>> index ce3bc7642e18..8aa6e9f316dd 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -2452,6 +2452,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>>>  	return evm_inode_removexattr(idmap, dentry, name);
>>>  }
>>>  
>>> +/**
>>> + * security_inode_post_removexattr() - Update the inode after a removexattr op
>>> + * @dentry: file
>>> + * @name: xattr name
>>> + *
>>> + * Update the inode after a successful removexattr operation.
>>> + */
>>> +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
>>> +{
>>> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>> +		return;
>>> +	call_void_hook(inode_post_removexattr, dentry, name);
>>> +}
>>> +
>>>  /**
>>>   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>>>   * @dentry: associated dentry

