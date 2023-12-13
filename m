Return-Path: <linux-fsdevel+bounces-5991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E62811BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257FDB21100
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AF5A100;
	Wed, 13 Dec 2023 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q2GcCXjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32076107
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702490930; bh=Nwz1uIbomBE991r6kFnI9Xx0i9y6GbKeBjvJtumt8iE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Q2GcCXjATEzjSTSYXHKbXeurOv5yespsSz0ml7JCsSLZqxVHAfvFb/s9tzIt1evnQhz4XLu9bqJKAIA0uPqHtwBjEm4XnLk+vTgaltgUQOZV9b1W/MFTK19WwGySEVVSWxIinyGwjgcfn6rt6N1Prk04cDhYw59eTJ+j6WHqWYBW89gv9guNPRowISjp1KdTZK0yQQSOaN/ST6QuKOTUrS+dNe9wV9evHwRGEg8E3f/cnG21gzKQW1iFofjp2sNHQcon30MXNzf0cSDA0rRHmMleNNc8aVqghAMr5Wu1H7beuwg8EOVCRgGJTca1PQes/0qpj5l4+dRgEZVJr8Dd4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702490930; bh=+/TJOZ6srOEMVvhuufXWRh0/msMyFtSymbS2RoNkwdQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jb4TkrgIre+9ji4ewfMOvSl6OLiXVlIvDGCY4riHNE4MLKe9WNidkohEECUqi1Rj+Qb7ja4JfB+hQ40ROlFPoA8fvGkDMunhCHbDlqECIZqe8GSDuIRk7aiiUJr2lt24Ildhu6cfPmlG0xQaFKoBMU3d1eMhl4YbkeyYMarx51p/X154GQeYIUS0UYFGJ+itQukr9ZuIj9wSZwquwUhkkX57Z9zxapwJlT+CIq8zumYoL2AVtUI3C1OzYhHb+LO0BJUpi3iWPmjDvOtpwb+3RD3MejxooCgKRi5LKD51T+cIJGSdIazwoWLEXkSYTvyEk50NXe1ZWWeUO/rQULHZCg==
X-YMail-OSG: ZY4uPfkVM1nL9XI0hibln_9cRAXR4K6ZlsvOdVR.ZIvGnWPklpsBsrntt6L3vuB
 8VdYwHE9wV80Ll.nAtMpE0Dt8RTxtsJz3u1gWV4nsZUCwDRbJ8VkqeK9UWIeymWBXAu21aTTGAJG
 HT9hrQzNG4o0l0UTVb.HTb0EwxJ4ZoiWPfp.f9sXgrqtH_HPR.gPo8EQhfUG.moEDU299IyzYYt7
 H2VJ4gba07t4nhBg0hwMpeCMVVdYbSiF.b5JQtZ341VBE3Z_RClBvv03hzVGL5RPVg28ocD1tWZW
 qV8QkvM_DGUEgGH_7Ru7FhHBx6iH3dMwRvMjgsT12JGT5Liqqn2OkcxAOYm9eZ3ICnq4iC2WNqBE
 hjX1EwtFmRbH4wjQ7dtex2xphhuRPR8DrwR2167If94s7MNdj7LDf0.H3FXWsVdWHkKf.Gv0vYWu
 xhBt1kDDUTKBzbW0AAU4BylURMOtonvV1VLwhckz7CgtpkZ.7vdoMoCweN2aGa5lXotaRyseo8lC
 EdfNFXhOSOuckRGSrm6L9QixTrvg.48xgMjI1T_csZMPenPYNwuMI_TOZNvDCFzPjQ4vEl76fYuB
 CAgxOAvU80M8uHZQnLrXsGiLBUaANszyXIhM5zAlHQPVG8IBAJkKmqSR5Riy41WNhLHrMx1AxhaX
 c3WAjD.XYT_2sOD6re0MlrPH_3bI01ZyQFUtulQHTy2u7.odLifj3hGDEbJU.5Z._j7_qV9Nz6eF
 ijaFLsqsGe7Kwr0gXj1X20O1o5bkWa7rvy7rd9LFu2L_mrWOzJ.Mf6YQMdN5Tex7wFvZplvRQGTZ
 d7hRb9arVcB.ijSL4IIGKv5UBUmqej2Iz.LmKZFGPDMMcqRRK_Z8a01tIDb0ZHeDR4jTjtin.xqH
 zh_3sjv4rQ.rLL65jKk5YpQyZDSVRedQ8wrpFPuuQuFddHIunKuZoIHNTYHmDDnffbHzMgfzE6p2
 0csSu.Y_21KcZjcvn9ECmQgvLobMz3Vud_qM_6s0yeOaw4nhTx9oy6UvZyRB.IG8aMuypMWYgVcs
 N13p6zGyc1pQK8XkxkXktpfNMU2.T6pu7bjZAIdFSXRAb3UFmmonKUr2PNf1I76HPdEKP.oRMCwC
 7_kaH1kaQwi2d.P1uP0hoAAERtrJ_O6XN.85qafgWLRls_CRTlzNKNlzBRIE.GvDvFRe_njUnjAJ
 pof3DD3hOddOtKXQ721C59YmpyIetqf7dtAKPVAXhx6_dMur6n.PdX0AQzxFDlALEpKFdMIuIXsB
 70lDIeAeUc.FDPFUL3F8tTR6EeYSEkVzhU3O0uBm1JFolTLTa16FiY87G70txBJjXU0HZidBxBht
 fzSugNDamX5gnlKPmb6zJeNBJWStv.j0GMv64EluNPOCWeVcH3cVTHAT1dFrDB7oXblC3Rum8j4v
 s7uHPuWZVY5OIehsAUS1Mrwj1xjXM.uTX8klNWSSxeJn.4pJgNHCrdw2xp5fhN2jrWMTNTxGCVVB
 YSyNVzm4wtWxaPLpUIclAPQ_Hur5.u3GQFVi9p4pKKM.8F12uF_sn166dxANn5LSuyF7LaCBEgPZ
 nuFUb5a0XV5QzqAt29KHaKpzJaHr54l5N2_V_7ZPiXVOnr5BzGOGGi.EwGm4.V.UKEFkC.an4kpS
 EwODjE3lu19jis0IwGrSZpQ_XP_H2oBdKNc1.XyNjfkKPduWiJOSGiixgDWenRKYnamM8kShG6YS
 qJvWikUacPnSTDzcwrUZaapwLMSlSBAXcQ6zXPwO1zrl7fjGsJga3hQMCh9HTvGNRmTuEr6LNeY_
 IO_eMH4VxsDi42uBI1W.33c6A4Kj1ZlwEfTC0V3yQeEKpYI4PNtMI3bI66EgCiawKiIffAXwauNe
 gV8B1JA9dIA6O9aSaWqCP9U9bnNn4JN1bKtAqdxn95NMCSPOeXSOofRUOsISQkz9ad_g3.tBd0V.
 0JMpxvAN1olw2ZGSJWD4dVLRA2whVdwpIIxRisbaRSPB5bLiD2YtFx68SxJKwh8m8mf8ujQh5Y19
 HW0..VY6s2cZSXBnXqIRLzXcdZHD1vT_gGAG5h9ZadaHnCUMcRhVNjerK_UP7kIDDeruOMTHFNKO
 17_iZeBREEot_D7mQh9g4RlApRvP6J0._dhqqVyBD4IjGrRsF0RqQe63FOe4dl1cOaME5zwmdNvd
 LF6_A9TI9WOEHe7Tp_96mVtICBAGWoIOCVf3QqJ1qhrL50oadzN.9BMhtjt0WfskACGhiyemIPKc
 9qYreb0Lox2deMagqPuimHpY.9QOIyLBhw6nh1VyM_8MLPcf2OszolI2.YWdN
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0351f85c-4cc1-41cd-b475-55877dfed226
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Dec 2023 18:08:50 +0000
Received: by hermes--production-gq1-6949d6d8f9-k52jv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 83a3aff6f9fe93ecbddc221ed9cc56f5;
          Wed, 13 Dec 2023 18:08:48 +0000 (UTC)
Message-ID: <9dc633d8-65a7-4b97-ab98-a21ada1d4ea5@schaufler-ca.com>
Date: Wed, 13 Dec 2023 10:08:48 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
 <7c226242-2eda-41cd-9be8-c2c010f3fc49@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <7c226242-2eda-41cd-9be8-c2c010f3fc49@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/13/2023 2:45 AM, Roberto Sassu wrote:
> On 17.11.23 21:57, Paul Moore wrote:
>> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>>>
>>> ...
>>>
>>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>>> index 882fde2a2607..a5edd3c70784 100644
>>> --- a/security/integrity/iint.c
>>> +++ b/security/integrity/iint.c
>>> @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
>>>       return 0;
>>>   }
>>>   +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
>>> +    .lbs_inode = sizeof(struct integrity_iint_cache *),
>>> +};
>>
>> I'll admit that I'm likely missing an important detail, but is there
>> a reason why you couldn't stash the integrity_iint_cache struct
>> directly in the inode's security blob instead of the pointer?  For
>> example:
>>
>>    struct lsm_blob_sizes ... = {
>>      .lbs_inode = sizeof(struct integrity_iint_cache),
>>    };
>>
>>    struct integrity_iint_cache *integrity_inode_get(inode)
>>    {
>>      if (unlikely(!inode->isecurity))
>>        return NULL;
>
> Ok, this caught my attention...
>
> I see that selinux_inode() has it, but smack_inode() doesn't.
>
> Some Smack code assumes that the inode security blob is always non-NULL:
>
> static void init_inode_smack(struct inode *inode, struct smack_known
> *skp)
> {
>     struct inode_smack *isp = smack_inode(inode);
>
>     isp->smk_inode = skp;
>     isp->smk_flags = 0;
> }
>
>
> Is that intended? Should I add the check?

Unless there's a case where inodes are created without calling
security_inode_alloc() there should never be an inode without a
security blob by the time you get to the Smack hook. That said,
people seem inclined to take all sorts of shortcuts and create
various "inodes" that aren't really inodes. I also see that SELinux
doesn't check the blob for cred or file structures. And that I
wrote the code in both cases.

Based on lack of bug reports for Smack on inodes and SELinux on
creds or files, It appears that the check is unnecessary. On the
other hand, it sure looks like good error detection hygiene. I
would be inclined to include the check in new code, but not get
in a panic about existing code.

>
> Thanks
>
> Roberto
>
>>      return inode->i_security + integrity_blob_sizes.lbs_inode;
>>    }
>>
>> -- 
>> paul-moore.com
>
>

