Return-Path: <linux-fsdevel+bounces-4294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F0B7FE6F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50358B20F0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1652134C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CsRcpzLW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0599D54
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 16:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701304889; bh=7PLvtj/expN3SSJOj9oZcxu2Xnd68UimqPC1esqe2P0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CsRcpzLWaEsNWwDxkAyGKJrnfna1N5pSnUif3rxe1mykuFIrvupFHfdoRlaVxQEjfxj27FiXSpPNKoD+q27k81+Dt3QTSi08jh1E9cB9yaiAL5ky51HH1nDryRLIhaY+yYoXDG6PJW49k0Wfj10TbtmzR+aKlJRsyCm+NvGgONUsQ/ugCdbZjXL/YbM4rr5uNmRY+/SDWqsIcU7BeKSSEd6HBsiFuNRdKf0jjGgisMMz4UgsrdAGE8feWdIjYAmx7M4DtjuXyMp8E7Js/6xRSytjPLrdp/T6He7MnxILIq3hNmdpZvaKWZsEkMNI9hElAN1f6/XCmLvAxFhZv2XWQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701304889; bh=D5XgQV6+zk2gKx2BK7L1452wzoGVlK2WqfctkwXeAfi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lAt8+6aCouyDheEOEmOSBOdaLC84X5nEmCLYI8DgvCIPYQ6JeOUlroJ0DhBWoLK2R+fAPbBDB2UIjE14avnr/IvWgMEx1TTSMCi4/xHmC2KR95y10z+Okrxcy15+PD7Bl98G2dMmiFCIImiGaWBJrIq7MU+fdmA5D6SCVOfbGIpaJdWUzhcFlkx8sB/b0PVr6LFeGqqWF83e/uTJoYvz2zOq2sj6D37wwHgbdKerIYeC4s89IGLarjYcVYu66BY1WqxC5XoKS83f2tDqVraIaUHzyIP2U1/d9yvLXgtxNiu/Y43SF8+GTGGDKP+YOGjXcNHbUMHbbAOou+i0YoUxYg==
X-YMail-OSG: tOKDMEEVM1mDu2RlWNcEkfYAgHtbMlN9VjNnR3JzFEBV6rn6XJcvE0CKTtEC7rT
 jtoJ0JLkaCQjYPHHv.c.yBsNzFIEFCYyOZ1DJm6DOt_u2rY9Bdt4bw18rjyPLzcaGG_Mf9A75wZI
 C3gOW5SE7_5cBtv3U2661pj.yrWVCx6Vvaxglcf.7D.e8uIvTCE89WL8FAP62Qz01HLcjhGwXdMX
 HlkzDIqkpheDcmEM0co1gn0cbWLNzZBSbwUkYcAisSf1lpXrtHQ.4zEbIGBg1P2.qkozibnT4WY7
 .GFXibh7yl0ttVpIQLipKkisyTtWnINbXtRx4CltHGVSzpq8UzxMkV83KMn4qKiABCVaXkH.mczu
 7YSP_HlejV5ryFCLa_BaALK5ZFgKCIHX2CPlKDEExjTQigHr_nSpRI.FsHYFXjmIA0WXY4WAHvnr
 tCELDdoLWr7yue12D9eHHYBoEtFGtMNyzoWIWlRWMb8lefXxWvu8il4Ft0XHJp_uagBIUWfGeaj2
 y9ihtKrvmUk7oQe7UqstRVEqo3sD1HyE0trA7CTqf4mNs3DU9_k5G1wBQbU_6E6wVvbCw.Mkzlgc
 wphf00IK_SRekyRSRDSfqkkP4cj4vf_hLCFYkNtYvY0vD2Zz6WxvlqqCdHzxHFi_AUUtRjuw8XvZ
 bNN4jh_0511epBOipQRBMck27lgChX4SgmYSw6NYyf9UttHoUBvdAhcz.sq7YfAn07NSTH4Rs9bJ
 PyBo7NdTN.5PmC.lBAjKXIpYVnQQi00KZtTJy988peHAlzOo1KmMMyfMQYj5nqBEDLhc2ESpnRKg
 I3EWST9FWlubc83RYgHYuLX_WVPDXpYlGTJ0KduSJQow6nGkZHYCNTwZ3DotFa_LEwBZZvM_oigt
 LvvRbEmuGnpf96E1Kll2l30A16IT4CsE59ivlFkKXSTYEKkwBrgUr7mTZZPf.US0MmZGtp3JCtd4
 85IIETE0udFMDXXB8OyRLYarxG8YKVqEwuW2PM_qQsrrjU0LyGxGo4tdudnV1Sg0CBXhGou.XwQn
 cuYNa0ngFaTVY6RgJR7GAJKdpW4FeQpsdIgKu9pf81Vzgt33uWVXWpJxrjfNHG3AFXfi2nJ0Zovt
 x.nSvGmrUzlmwmKvS4WNvYTuV6UGgnxjGC1fqENRDIp8_pJZtV8JXD6vc3ey2yPhanwjjFZ2oDEN
 2W4UI3Kx6k00hmngzXjoCS5lGbH_iyC7CDCqKanJvgI27ksmbfYNjlsEbEqSjTtGRG7uaEdLHGnH
 K_T9GZWHQz8StG7CKfIk.2Ed7HxXI8h5LiJklLBrrS_z0MzDK5g.6U92JXc4j6tBzm_JSbJ6qaVm
 MAYfjspn409CTmtbfhzIDXWV7K9RSyrpEwLD5KiexSn3JYdXT3ttmvrMZe.NmeQRegHHutftm8qR
 E3pahbb0mhqSeKHfZjbqfAU1dbhOPX245NYRVpN1tRaLb3jgtYIyP5Hl80izt1QuIJKfgj.u3FZs
 ZUyd5CAYug_Osbabb0AuVSxu7GkygJLIDYGeSiIP8HXY3Oh0i5ZVXHMGF6ek4LSldjL9Y4K9N6Gw
 Y9F_prvGglzV2xxWucQmS48UEJSfLmMZ5gLrIu8ZlCJ6MmtM9fIwBjRJ.Jq7GOZzBx34saW0JyQT
 5UoFb7KsAkMUYdS_.ysL4.7DUn3aCSGA3VMnnFgj8J0KS4iRCE7k32jKdN_9O6Voylf42j.s0flG
 wv.Vt1x.TVKh0qT_1VQ58.6IlT5GMEHdVA5Z6c_dSMB.y9cCbz2JzJ3HYJ1WtSnynZy8Dq.kFzQT
 zi_QF5MRqJl8SMzQYhltFmtzMg2Ij8Hl0Cp5R0DztCdz1LCBjSWtzAZmQGNcuyV1o22z9TOs_N4t
 TnQ2mCQkNNDQQO79lsfuWlgMFFZT3Bup_eSs4sAt7RKjcW02MOuF06gY.b6diVSfSbibAP3RjVBD
 6j4RYybQsad1kuiPRer6d0OmOF.RBCfIX4_V6cKZNlGRxI..fpaQB4x8gaiE5xswqvO66T9ukOiB
 hqWwKjG45pOr_riyuFxiExMYfPo7_eH0cqI3cuqo2xKVKqYm4K3r5.XSrON3D7GfzQhLjXJxqaSK
 hwGR.RdF0pzFX3caC.HWdz9.6ekoYP4KL7GMo3qiV6N1O1onL_9vpRg7dD9SuevCfreuJQlSXk45
 Yjn77GilgOt3oLMK_JQWyR.HY1ieCuL87xrGoxZu0pKKubg.iERAAOKsmHWMgmPwyQiqMw6Ewq1o
 lfd6uBGpSe6aA7I5JhPIyJjoZQ4GLJccACkrPFiptOvFe9HD75Z23csqE
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f6981e06-aa01-43d8-bf3e-e42b9737a592
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Nov 2023 00:41:29 +0000
Received: by hermes--production-gq1-5cf8f76c44-gkdjg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 60b9cc94d738a195be44ede07002c82f;
          Thu, 30 Nov 2023 00:41:28 +0000 (UTC)
Message-ID: <366a6e5f-d43d-4266-8421-a8a05938a8fd@schaufler-ca.com>
Date: Wed, 29 Nov 2023 16:41:26 -0800
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
 Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
 tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, mic@digikod.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/29/2023 10:46 AM, Roberto Sassu wrote:
> On 11/29/2023 6:22 PM, Paul Moore wrote:
>> On Wed, Nov 29, 2023 at 7:28 AM Roberto Sassu
>> <roberto.sassu@huaweicloud.com> wrote:
>>>
>>> On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
>>>> On Mon, Nov 20, 2023 at 3:16 AM Roberto Sassu
>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>> On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
>>>>>> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>>>>>>>
>>>>>>> Before the security field of kernel objects could be shared
>>>>>>> among LSMs with
>>>>>>> the LSM stacking feature, IMA and EVM had to rely on an
>>>>>>> alternative storage
>>>>>>> of inode metadata. The association between inode metadata and
>>>>>>> inode is
>>>>>>> maintained through an rbtree.
>>>>>>>
>>>>>>> Because of this alternative storage mechanism, there was no need
>>>>>>> to use
>>>>>>> disjoint inode metadata, so IMA and EVM today still share them.
>>>>>>>
>>>>>>> With the reservation mechanism offered by the LSM
>>>>>>> infrastructure, the
>>>>>>> rbtree is no longer necessary, as each LSM could reserve a space
>>>>>>> in the
>>>>>>> security blob for each inode. However, since IMA and EVM share the
>>>>>>> inode metadata, they cannot directly reserve the space for them.
>>>>>>>
>>>>>>> Instead, request from the 'integrity' LSM a space in the
>>>>>>> security blob for
>>>>>>> the pointer of inode metadata (integrity_iint_cache structure).
>>>>>>> The other
>>>>>>> reason for keeping the 'integrity' LSM is to preserve the
>>>>>>> original ordering
>>>>>>> of IMA and EVM functions as when they were hardcoded.
>>>>>>>
>>>>>>> Prefer reserving space for a pointer to allocating the
>>>>>>> integrity_iint_cache
>>>>>>> structure directly, as IMA would require it only for a subset of
>>>>>>> inodes.
>>>>>>> Always allocating it would cause a waste of memory.
>>>>>>>
>>>>>>> Introduce two primitives for getting and setting the pointer of
>>>>>>> integrity_iint_cache in the security blob, respectively
>>>>>>> integrity_inode_get_iint() and integrity_inode_set_iint(). This
>>>>>>> would make
>>>>>>> the code more understandable, as they directly replace rbtree
>>>>>>> operations.
>>>>>>>
>>>>>>> Locking is not needed, as access to inode metadata is not
>>>>>>> shared, it is per
>>>>>>> inode.
>>>>>>>
>>>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>>>>>> ---
>>>>>>>   security/integrity/iint.c      | 71
>>>>>>> +++++-----------------------------
>>>>>>>   security/integrity/integrity.h | 20 +++++++++-
>>>>>>>   2 files changed, 29 insertions(+), 62 deletions(-)
>>>>>>>
>>>>>>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>>>>>>> index 882fde2a2607..a5edd3c70784 100644
>>>>>>> --- a/security/integrity/iint.c
>>>>>>> +++ b/security/integrity/iint.c
>>>>>>> @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
>>>>>>>      return 0;
>>>>>>>   }
>>>>>>>
>>>>>>> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
>>>>>>> +   .lbs_inode = sizeof(struct integrity_iint_cache *),
>>>>>>> +};
>>>>>>
>>>>>> I'll admit that I'm likely missing an important detail, but is there
>>>>>> a reason why you couldn't stash the integrity_iint_cache struct
>>>>>> directly in the inode's security blob instead of the pointer?  For
>>>>>> example:
>>>>>>
>>>>>>    struct lsm_blob_sizes ... = {
>>>>>>      .lbs_inode = sizeof(struct integrity_iint_cache),
>>>>>>    };
>>>>>>
>>>>>>    struct integrity_iint_cache *integrity_inode_get(inode)
>>>>>>    {
>>>>>>      if (unlikely(!inode->isecurity))
>>>>>>        return NULL;
>>>>>>      return inode->i_security + integrity_blob_sizes.lbs_inode;
>>>>>>    }
>>>>>
>>>>> It would increase memory occupation. Sometimes the IMA policy
>>>>> encompasses a small subset of the inodes. Allocating the full
>>>>> integrity_iint_cache would be a waste of memory, I guess?
>>>>
>>>> Perhaps, but if it allows us to remove another layer of dynamic memory
>>>> I would argue that it may be worth the cost.  It's also worth
>>>> considering the size of integrity_iint_cache, while it isn't small, it
>>>> isn't exactly huge either.
>>>>
>>>>> On the other hand... (did not think fully about that) if we embed the
>>>>> full structure in the security blob, we already have a mutex
>>>>> available
>>>>> to use, and we don't need to take the inode lock (?).
>>>>
>>>> That would be excellent, getting rid of a layer of locking would be
>>>> significant.
>>>>
>>>>> I'm fully convinced that we can improve the implementation
>>>>> significantly. I just was really hoping to go step by step and not
>>>>> accumulating improvements as dependency for moving IMA and EVM to the
>>>>> LSM infrastructure.
>>>>
>>>> I understand, and I agree that an iterative approach is a good idea, I
>>>> just want to make sure we keep things tidy from a user perspective,
>>>> i.e. not exposing the "integrity" LSM when it isn't required.
>>>
>>> Ok, I went back to it again.
>>>
>>> I think trying to separate integrity metadata is premature now, too
>>> many things at the same time.
>>
>> I'm not bothered by the size of the patchset, it is more important
>> that we do The Right Thing.  I would like to hear in more detail why
>> you don't think this will work, I'm not interested in hearing about
>> difficult it may be, I'm interested in hearing about what challenges
>> we need to solve to do this properly.
>
> The right thing in my opinion is to achieve the goal with the minimal
> set of changes, in the most intuitive way.
>
> Until now, there was no solution that could achieve the primary goal
> of this patch set (moving IMA and EVM to the LSM infrastructure) and,
> at the same time, achieve the additional goal you set of removing the
> 'integrity' LSM.
>
> If you see the diff, the changes compared to v5 that was already
> accepted by Mimi are very straightforward. If the assumption I made
> that in the end the 'ima' LSM could take over the role of the
> 'integrity' LSM, that for me is the preferable option.
>
> Given that the patch set is not doing any design change, but merely
> moving calls and storing pointers elsewhere, that leaves us with the
> option of thinking better what to do next, including like you
> suggested to make IMA and EVM use disjoint metadata.
>
>>> I started to think, does EVM really need integrity metadata or it can
>>> work without?
>>>
>>> The fact is that CONFIG_IMA=n and CONFIG_EVM=y is allowed, so we have
>>> the same problem now. What if we make IMA the one that manages
>>> integrity metadata, so that we can remove the 'integrity' LSM?
>>
>> I guess we should probably revisit the basic idea of if it even makes
>> sense to enable EVM without IMA?  Should we update the Kconfig to
>> require IMA when EVM is enabled?
>
> That would be up to Mimi. Also this does not seem the main focus of
> the patch set.
>
>>> Regarding the LSM order, I would take Casey's suggestion of introducing
>>> LSM_ORDER_REALLY_LAST, for EVM.
>>
>> Please understand that I really dislike that we have imposed ordering
>> constraints at the LSM layer, but I do understand the necessity (the
>> BPF LSM ordering upsets me the most).  I really don't want to see us
>> make things worse by adding yet another ordering bucket, I would
>> rather that we document it well and leave it alone ... basically treat
>> it like the BPF LSM (grrrrrr).
>
> Uhm, that would not be possible right away (the BPF LSM is mutable),
> remember that we defined LSM_ORDER_LAST so that an LSM can be always
> enable and placed as last (requested by Mimi)?

It would be nice if the solution directly addresses the problem.
EVM needs to be after the LSMs that use xattrs, not after all LSMs.
I suggested LSM_ORDER_REALLY_LAST in part to identify the notion as
unattractive.

You could add an element to lsm_info:

	u64 *follows;

which can be initialized to a list of LSM_ID values that this LSM
cannot precede. LSM_ID_CAPABILITY would be included by all other
LSMs, either implicitly or explicitly. EVM would include all the
LSMs that use xattrs in the list.

	static u64 evm_follow_list[] = {
		LSM_ID_CAPABILITY,
		LSM_ID_SELINUX,
		LSM_ID_SMACK,
		...
	};

		...
		.follows = evm_follow_list;
		...

>
> Thanks
>
> Roberto
>

