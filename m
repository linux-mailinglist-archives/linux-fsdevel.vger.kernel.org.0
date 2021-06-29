Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375F13B7652
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhF2QQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 12:16:23 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:35636
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232362AbhF2QQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624983234; bh=wJfMDu0KWNqGSC079Q1h8gastS4L2JtUsRRZlkHsj08=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=T3AgipBMAEnxNB+zeaN8RepsAom9LI2KbRRLCnTS5lRW6/Im3DXSxcTJFCuKBhzOi+/DgzF7s225BKRWGt4Oz+Jr1KYZLkJHT+z+hSaUEBG/BKvhGSf9AJ7wQKdZNZlZ4Vhjmgraeu3kHaiPt2SI8+xUEeDrOAJ+VpevvLhfWvW516OnPs9btbYPyyHzteSxVmA2kvb9VSvsGHTaS4aAYA9epFOn/AuP/toKNbPELPxQSJSVYkUVwZhSC3y76kUxE+u32vF200vtM8Sc2SfimL+ay90JKS5ZeFA6PYryrUMReihb9vcl2yANilUg8QaO8UjdMXsWHmWltut85HiJFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624983234; bh=Gb00NI3vPocHZ+6pYfa4zGNzBOz/ByrTf7xqMpqG+8z=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Pmy22m9CNyw+HOo0brkZpOjDayDgUZ8GmNaBUfrJyV+DCPxTd0iDb7vnYnuU++kLBsUgu/oP4Z0u8m1l+94cULfjBhFsPB2nVCRnrae4AYw4scWByzW7Zm5RxOFyhjK3n9tFWAkuGZGjpIh2llUVgCzlWj535murX2iz5FT7en/JcNBnDyQJYwPG90nGuZBF6ZpOs+Aw41R0mY8i8B/zWCm709upBcS/dsJ9cAe/JqUMC1h2oLlNT/TBMH2Rijy4X5+yS9hoA43BvwwMMh5kYyOUOeOZLz3EpwXos7Pd1upJxQXKACIC+EQnIMTXr8it7GAzYhN4o5CfW4LA2pDYaA==
X-YMail-OSG: 4iNeFgcVM1nrJBQzSkCmU4XH3dId1u9NOeAfyi0apACUJ25nsTFb1t3AbI3O_aT
 0kwNYRwC8QCAd8WavI6eZCOGo9TE54Yw3xdEiuIDfqz4lqLjLzZNejgOx3UlHcNyUb8WOa26TXIf
 lNocl9J4PbQopy4WsvSrciPlxYJR_jlQCI5r3jdoK.uK_UFlcLYWirTyLkjrVJB4xNnD1TaM5DWY
 9Cl3jRRmVR9cYt9Lr3NqY_WIQO1LXLH.zUXsBKuLAcp0Han4.Q7xT5Wk3Oz06bYPexYKD2Vuq9SI
 J.IS6MuqnzBf0cRpGITMELk8b.nWDeJ8DWTaeFXvTZ2fx0rmVudhzQkGAZ5tDOzJHNsMZy7QWn.f
 bMuFTK6B7gtx1xRmOIVm.8.NkfPSCT_t66sN1LuS0Iq5Ka7kBegRMlXGJoTiDsHRAAwqjrEVAkRp
 xX3bZC4F0diqHaXJvgynOCD7pBbC4qCuM7D2Vrr92Uzm1nhJ4UMeCOsNFJPt5q.kS8JM1fOEUgvM
 3evX2dXnhd6uHra3n4TkDtOcW0NsEHuoUT6Su_jGcLvF6tsZqr7VokyssWfVFQAv1Fase36MEnhK
 EEfYoYyvtxbKVF2NKcJimyy36hql3QXQ_iij2fmMkcvbm7fb1srqMVR.iZGGduP4YulVTXw7k47N
 7a0tYVeNgJd5_U8iQfuPD5tYesVJ9xwdiXtMpKaH7fkqhI00_HjBMMVw8PH6yeoq4pl_nnhHPwGH
 fqNP88qULrPgmpJycKf_pBXxBxKcgTtZItKD1kt7ssAzkR.vhuwMWiCvykvF9LVHgLkuNvlmWLqB
 EqREKftis2DWLi00jFxRbRow8HNC3e_0qRz8IlG3WriARpAIC.iKFTpVUYXiCaJ.mGjtoK6sAeVF
 DmFKP3JNyzanvYZCFRluY_bKCH2tEG3tY0ATquj2HWGRz4wvPOy_cpjRbel7VdvcC0tZ4UimPBRC
 a.lZ1iQlqOieGpFNxQQ4fyIt462co95REXHuTXGLzNe_e4j39SvmO_Zc_V8WnnrX2e96b9KwYcre
 IUZvUnEURVv7MaC8xf94_ng5AafIAigGNgjS.exQpROJbdy_9PjhVds6pu5rmNLB2WE1q43OtoqF
 wF0Tw0e2jVynDd_sJHVASglonuRb8Iu4zhUwXi3Cs3iDSzV0HJyR57BsPAzmf2bo7STgiYgpLqqv
 FPl_YXgJMri3dUkIa_jk.NgFwTzBFYpZtEdU_X5zQgsf6.uQhAdkO8G4tjiKlIN88UKoWVB3AbCg
 7u4BEYSuSI4jIXoX4KK8t66oqzZeR1.lDFXJLlzoYzEH2NxBmXk7PNPZwUOPxHUlcewQbTmczSKM
 GYmpR_VUOJw10AbtZZvwZCc1KfP16s4Dlmq2h9uZC1FamjgkfGENBzArJgtNWksRhLBjxu7nSNLt
 CJHIKwZzqvEO4XhQIizX49VMEM9DdJWGNc4TO59wbSdD65VWFIh_NTP.kHPwrfuq044ks9t0Wvxd
 Z4VpbE96k5GatjF1WlexliSEvmigqmqKFAsLyyBahuaGxgSgy7cgVE3QMD4MgzK4eZruZtcplKe3
 5Ylfn3JKywdLBaHZ7lKgkSDTXBLuPmQd684wyj0Mef.MpPEGssTlHXUzJiKn_Hc_iMtax1S3uhwP
 uCaE8NfHCqT.GLd3Sqz2H2zROjqxlkUZxdP964yg63mJKVaxNlx41PBhGPfRL0xDkPbkn8GI44km
 bo2F.QXbppUL_FkEXCeLuU6CytKMjGIHiRbarv1a3DRsh8xKPsU4CSyKyFtii_.LXmGWEjLayNwI
 n0OzTIDXkD2ofC6MmpbNnC2oymT0cMn9OqOocYV7VhRjMfGhDJHaBJHXX8fvWJkFpOrEFZCd0PU.
 kMl4YRwtlO1.2VlgSFHSutqO8KjNDAoGXiSchkjN3Aaw.xUT7ZF_Galiqw4DFlYxZ2c.ehDz9I5h
 u6WPM3.Eg9E255NIfgxU2vmbvcSzFgoFkRCCAXst2OWHpKNHkjKCnZthYCJGiDfdzJM5WRw_Ipdu
 n0.bnTskznfxxz7A437RaBlCz5N0YKoChML6NWzg1XQa40jGqLSRkAkERZLpjDHH7BjM2b_gna08
 6cTr7K5FfVI2rmZ8WxUYCv8W2YLqqJMSdK9jDo4z7kBIxbqflw6sD9unqkX6osXqCR_2g1J9ZUfT
 z_z7xv4K1QNTkkInoUjNn1Z5W5idGM9DaF5LbtD7FVcwN81mbNsU10IKa7YQGD9WYdpsE8bVcOTI
 Jx9EMzJM3ob5Bo4CJUB.caJqhRbzvYY_yStPGPbRZ.b7wGUEdJHaLgNX95qmaqO_5VKj8Ou4BDJ8
 2VYVKsJfLWdDViWFTzw.9RSdav2MUc2eQewvMzcNAbJ2POQNdeI.LjrQceXIDD.VEDCmnLjz_duj
 hPD9wknHvgaQpAoxPY1oDhXLvBcTTqpzEEh_V.nCI_5VGp_FlIYvJffS2BtdGAxfkNHrBtYaNKQs
 BarsnTXzDqN9DkfSd6usaDQHva8qlLMvEg3.KEPMTQ4JUQs8Z7khYwzCd9FJyYPoJABc9bWmSk8F
 pxIssguxTBWNhLoL8JYr842AbxxCQCBCmyDASwgEbya2rZ3qvjW3ARae4GO..iWC7JJLGml5siXg
 .PSxY3_4fJvalmvV8A_V_mYKeYihgI1_WXJVtV30JW4pMIfoSKuQBWLJ.0ix6bGFpSDxjNu7_hnM
 AqYBjpjXEjiqbginv_oUyMgM74r_Zgada8C5e5RQTjY5TY.GEKeWYWRD6RC7HJeHVgwpomEP7MB.
 GnC6G291Qf3yk0AOD1_6eUPi6A.XHPVwyc0NgejaI1JI3bMTu7peXoN9ooOqS1cpB1HdAEZ6ern3
 nL57vb4WagVT36iqV1Yibs5TlDIh1PGgdS62gYdVWsVapdTMA9BG1YyLJwEgfIQ1F7Omy66XZ5RA
 4DDIApnTi3J7ZcjUtImmRl5iBYtO.aPv.ZcmbrDPSqbOWt5g3J7SsRUuha79NIjWIQb2jj5HkaRY
 MZY827_A62VBAWnbl9ANHhaTZZ.Z5KAMhCLnBSu6ovW5unMiVwYaHxuXZU_g7gNwNwGnhsBibIOG
 BzToo_mNo.mEohnfOPBGtmQ6AuvtGo5IwPyxLldsaQ6KszC.WrbawRx_WPIkSdx2yrcBMOUaTfms
 gV55XY6Pm7pewAVA13_PzZBYSY9BomkHXPwmWRWapS58_ShlbRa66Phcj2xzIZ_aa0jtt6uL0SYm
 At4Wmmi9yJNdBUXzoU.kgLMToypQ5oQPcW3nm_FR0okDOPUnfDU1RM2f0RMjeggyHRYbBAhXko3Y
 ViTd1hvYCbxnsbCygliznxGnCC4CDaN0iFBNIw8nx.nC6VpPEN3ERJqHHywuObz23K_C_Dd2Dg2B
 dHJ3jbY_p3Qiys5BZ8mrjk7f_arZXkkV8BFLNf2a1obwWjxFAWgEwBHOTgrqhsk.K3aFILTnoOIx
 KsjGjYyi.ElUNwLwYCxub_.RhafZkfmy21iIfQilpwsmNJWIx3Rgsh_hei7xXSLIza5GpT8QDdTi
 BOLfy9lA4g7cNNnzC8WUHnbVFykQKdn9udShHCvecRRahIRbsOFGOIlRdjPBJUUaW6xUeWOUmcN5
 4vDcgHf9fqmtuzNMAMd44Usw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Jun 2021 16:13:54 +0000
Received: by kubenode565.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 70106849725f1c1225e29d7e29fd2cdb;
          Tue, 29 Jun 2021 16:13:51 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>, dwalsh@redhat.com,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
Date:   Tue, 29 Jun 2021 09:13:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629152007.GC5231@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/29/2021 8:20 AM, Vivek Goyal wrote:
> On Tue, Jun 29, 2021 at 07:38:15AM -0700, Casey Schaufler wrote:
>
> [..]
>>>>>> User xattrs are less protected than security xattrs. You are expos=
ing the
>>>>>> security xattrs on the guest to the possible whims of a malicious,=
 unprivileged
>>>>>> actor on the host. All it needs is the right UID.
>>>>> Yep, we realise that; but when you're mainly interested in making s=
ure
>>>>> the guest can't attack the host, that's less worrying.
>>>> That's uncomfortable.
>>> Why exactly?
>> If a mechanism is designed with a known vulnerability you
>> fail your validation/evaluation efforts.
> We are working with the constraint that shared directory should not be
> accessible to unpriviliged users on host. And with that constraint, wha=
t
> you are referring to is not a vulnerability.

Sure, that's quite reasonable for your use case. It doesn't mean
that the vulnerability doesn't exist, it means you've mitigated it.=20


>> Your mechanism is
>> less general because other potential use cases may not be
>> as cavalier about the vulnerability.
> Prefixing xattrs with "user.virtiofsd" is just one of the options.
> virtiofsd has the capability to prefix "trusted.virtiofsd" as well.
> We have not chosen that because we don't want to give it CAP_SYS_ADMIN.=

>
> So other use cases which don't like prefixing "user.virtiofsd", can
> give CAP_SYS_ADMIN and work with it.
>
>> I think that you can
>> approach this differently, get a solution that does everything
>> you want, and avoid the known problem.
> What's the solution? Are you referring to using "trusted.*" instead? Bu=
t
> that has its own problem of giving CAP_SYS_ADMIN to virtiofsd.

I'm coming to the conclusion that xattr namespaces, analogous
to user namespaces, are the correct solution. They generalize
for multiple filesystem and LSM use cases. The use of namespaces
is well understood, especially in the container community. It
looks to me as if it would address your use case swimmingly.

>
> Thanks
> Vivek
>

