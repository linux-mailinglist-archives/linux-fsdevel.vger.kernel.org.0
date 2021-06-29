Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9A3B76B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhF2QyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 12:54:23 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:46546
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232441AbhF2QyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624985514; bh=CdVaAyKCUH7a5+INbjm8wM+T+DCBoLIHH2QYKaF4BCY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=ST4SpWv5vXqMXmPQtWevZKBoXfK5o21HELWE0k/iFc769czhS3zknNIdeDL0/6X4CUAQDNFwrcd4Rc2x3b9mbcIFG6dB7z+p6Gs1IjxK94TaVGxYehaCjRf0JY0Fex92rCxmCtySasREz8M+da+Oh2vAf4wFQEwpGXeE/CjTrbny89Hj43ywoYnm92qcSr/c5pcAXLOVXK0vZ1te9Bd+roSG0JKzZb0QbN5NK6M9jduZ25jpGOKvAK90I4r/VMd92RIxbpFBzr7X4/pMRxhx660p5KMmW4Q1F9k+WEZTbIUeYc/0Zxk5/z6HTWDWs6/QuWpnQhHAHrwbMPd76sKELQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624985515; bh=P3Tp04mbBPby5ViMntYXQ4zuW29vHtpM6+3qHv0r68V=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=t723ffPdbWn3w04qXzFtqdri0Hr5+umy9FA0K8zNMK3CA5ynE7mwUof433+olp++/DRlBRy7e28ClFcdI8yE8W8zN8z9ZwhHZaIH+KnRNq96/cHKCbjWc57JQIjqcx9Jy4y4ILi+8E7G7t/GWt+pmeeomntPuM2EgFJVDwY8miaYPwlXRkGHAMfkDsjv1E4UNh2VQe+U3qTlC8tBZUaNipubUSutJQRjnYrR+5O3kyA3jxTbtVAydwaGDOD3zE3hakLbozU4iSmIWfGRjGxLKHUCpBBwATkP8Ys0h18CIUlGKffy3ehqENnEWCd1Puh5kcR6uowZkOVWq6VMigsb0Q==
X-YMail-OSG: cktPX7kVM1lVkxmpIZcDpjof8uNMI5DIzqiMwGchT_G2NB0Fz1LLq_kxpsQYcW7
 yPN0b4posa0Ss0oimSoF5rDPVB5r39ShlcNbeJDOerkVkjPWjQQwNhxRpYX9JtOaySQRz4.FjrYY
 CB7TYuLEgnhdBo.hvmXaBX9wbO0_rm.4H6nbHAm_1.coAPPC_86n7Z3M9jcIPwFqktAgvBEuXMbs
 pOsQrwvDUotQIssY_qcYBwxdVTPAiH2vb2aMV6eUkIDH_mnkU0CClSfwUt6GTTRgWTrvDHNk_VxM
 I_vTMQpTbtnUTfAiVi5OTohwCPpLAjrfMpiS_ht3hVWRm._mYfnUL.3pGCCAdal.rv2bM2Me8iJE
 10wVfr43X65SuIPL_2R_S0C3LvbKtHNaL.2sICQSd_XcbUorxwJIvnpqpjyvyCqdMidlB5MdeSxL
 bcPu27nxJcuCT9uud32rPUyPIO.GBXTWLMrkN9I3uQkSnn9oj5bYuRGfKdwaSGlXqDM0aK5YP0jq
 o3GRN1oAWm3lEsUc9nPUkc7H.zMICOsWHozvavhv0WERi8B88s2pNf7VjBzkmfdED8s4Ebt6JyfB
 OnRmHDu.v9pzwAs28dpiWZGvBvY6.vA39RNtU1ZuS1Lls.DOHZONRBdHA8fpITxE9FfcDUhRYPaa
 cvhHu8j9HTftfKKkJjhL6UUX2acHza2jKnlqKeikpXnD_aGKUnacVAnR3BockSXaiCgdf1qyhJqS
 XVI6v.wgAARv6h.IYttv.zOAWWpGhXPGZGaAR7IWK9f1rRGZ9kfIvDXi8skjs7zhDZmb3v_bGVf_
 5t1JCtiPToJ4hCUG2rVORJo.CIDDdU2TVomph.kZexT5spn.oyUIV8MnJYoeT3nexeDHdzqu8P8t
 lgAkZnKwBbLOQcsVivulFibSkNNnCGxESG0J6AQ3aluOzHZV0v6k49Waqk91sq1lYyD7MU2KXios
 6.VZYOlK2A8ivEP17tNxD4WvIKysSdh_km9PBcSa_.SyOI.xNf.Oepd3ydsCItlnbabuMzAySwxF
 rXQSS5DAD2VjWa18myh0GEo224S0zhTUS0_v.p7yOANeaZeCxaxvwGtzwCRNqAAGAwDAYtTXjyHn
 OBmftT7uNcmEqhLW0h63Go4Sk85E6gZlGy0zy.5vCQmgOnixs7JwZr1gCNN4oOjEr4oD2q.SS05J
 XC5n3dVMO0Lh0GhZYSicQvqnB_mVre8DrrHwLB.XDOzMOo3LgD2dQIRlf2JJYpoPFLNWGVOYgNWr
 JGH.EyxSg6eHPDSZshzHvkO_zt7nWqKJlWsfIHFDrytnHe5QvHrfk_uJmkXUqsQKgC8g5ehoCQen
 KNp69sf7DWbJDgeyNWE5eVM5vRLglAEH16X_vi4Tfi0nisWjSmrFdOqBKhxevfsN8xOd0RxObr1G
 vSUd3JLhhvTOi.kTBNOx3rwsH9LKrRYE6yr9QSnd8ziRNTkZUR29fBStU3GgA6HBKUxrwxVYNyNw
 ASlc8w1uQCWdDKnbR.mIflmD_LaMekjCdNISMcrNvw6LloSqwdKPbvUVd4JdsW6.T9NsA_4Lz7So
 a3XBEjXHAb9QxUUgMaQpMCwwObYcPQhV7T9owbx1BYBHoI928sa04SJ8ETByY9b1Tp0fJYk5tHhx
 8VYjg4mTXVS6kqLUxTVH5cx9l088iqx5r4dkooqUWpQwkjQ_iDKxuJHvwGVJftefMnqa6l6N.zpX
 mh_H5XICix3s_bymghaRYbX2jMa9dtsM7mWW153xVCweS_IRh4XwrMf1is_eg5D4tlwf0VNSGR44
 PWR9kHz.9XGFNCjOQv4Y3h8sCPlOOQC9gmoJsp7U9_SpGtqeCGpdrvROXQ5XwG96B_kq2Zj1nGCI
 9fcf.4smHtZemdP3Uo_PyMeqb5E1AckCtTC3sbD_RBrfw7no1lBSqwcp0rrnPfhFUEnr2IQgkHXt
 rFJrF8V41vWz4mzJ48tT1tlBC_5eV8X.ty82sH0vXcrwtopY4PE2ihj957Hte0Mj1mLsiwdbJ0oM
 ML0wpvmXjbjRW9InQnK68XWt6HgrV1MaNN7BA8iEu7lgN4lq41PUM5SMa0tmjM1jcTCn2q2HpNiM
 QXZIVV18vqB_D8IEUe39yar0INIa.YHwV73qZSt3gdv4Mzt4DodxcpNsHTwU_kl1y5yPPHcEr_4F
 DjU7YXLwUPzDdJN5PtzuO3TI6kDnjDUG0wJ.tjuLr28Svpxa9ZCn17yHqEgswj2i7fywGt4A9.xp
 Aikd.r5hi7D1d5kIisJ7SAfyGR7E.TQBcRiSRffVdxJrkGV.BIjfDjKntSCUruQVOviXcfIqNK2P
 Ta.b7kIsh0DXH5MKHypwtkr45sbu9QbeUNr2NUnQzA4S4hwo_yo978ucIsdV0MTNE0kj8BbUAwWL
 yYskvh.9EOQg7x6G9PAs.viTV4eZv_zT5QuP.dZNoluBsOyn0saGiYUeB6Sht0IfHmsx_wokm4A8
 nHZycmpqk06cX6vb6.PkPttLjkEyoIJqQOtwnd5IlyVqNQL9gr7A0DOvvwtITX9V_On0szky4pfq
 6L6e01KIqu_KzgxS9_DkfBrD7zfKS5ZGCH6WbZCsf5SNxWdgWgIEE0qSE6fOs0d2kN_t.vF1uAwq
 uB2pR4J.gb1wplk9jXMD0vDEdBhEdtZgb3Yp4ivI.z4QN.rm7dbDLp.XvgcDqBJr3c16McllDLcD
 NBeRR0diOrJYCwsqz5HRGRq5k8SzYrNwSrksPXXxK2m19JcDyDPG6PY9MVwdQkZA4BNPNgROxeMi
 CVGRKl1iUwwt8crgg8L_kpgmxg5MFp81AAJc7_bdvI5MqRa8GvU31TK4AMKt3ucl69qq5V9qGNr9
 eic6lzdtFRiMuVCmz3zVRgtWIIhuq_1NJ_2fTdrQ8.rlKqYkOn.4k6ffNAX1S9gbROTEenXz6QDO
 E7KeZkeVb8ncr8t1MLPEeo7KdBPQeY_BwlPLP9xmtEQfZ80zQsL102tiwuQzM9C9AkP_1rFLnwiY
 tJGSTOm2gOA9R4sM4f2OvOpp3mB0i3plx8n67OOwAWzWRehTXrcCdX1efw.NS9rz7teJsyvFEw7O
 22BCDD4imuR1bM9B7ymsULvnh6_3pw6dhqXW3NO5fgzUC5xmBveSyx_ZFs8O5GWNUmGAxqL0UKvs
 .5fCl0tG1yZ1dB8JdtaK5p83T.H9jP5p8g1ZkBww671Sk32HNaA1esMg5.S8n77ivz90fmcrUJyg
 sHsVbDrP5YH9zFYQuJtdE1wgeWwqKus0DhNtpaMdeP8Yn.PZS6PYTLqWmcXbZEznobJ9hjm1oKYd
 wwI_woudX2XbeJzoaUK0oyl9916dXaTUbv151oBWCSlN8QwIegbYGPWmkwBV4TLkhbNoaoNta.NY
 UTdsFGYztKjikO88zD2x_1MkcTG4_MODCljaol_4pdMHGgl7iNjOsMk9VdASjzkPTlPcZ1u5KbNl
 bxfHYWPUEOeq_fxtUQpdqiK5Kj.1LLwcfWw8CsqeUSwLq9dXrpdWKbxZkmCjUCE5g9u0u5rY7GW1
 oLEuI0HYQWkfr.FEwtTTee2XXACDu
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Jun 2021 16:51:54 +0000
Received: by kubenode531.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 65c4703f68bf33dd281163585999fcf0;
          Tue, 29 Jun 2021 16:51:49 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, dwalsh@redhat.com,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <YNtLtkkDMWye485A@work-vm>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <93e87539-29d1-2bed-9a79-ec378f6869b9@schaufler-ca.com>
Date:   Tue, 29 Jun 2021 09:51:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNtLtkkDMWye485A@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/29/2021 9:35 AM, Dr. David Alan Gilbert wrote:
> * Casey Schaufler (casey@schaufler-ca.com) wrote:
>> On 6/29/2021 8:20 AM, Vivek Goyal wrote:
>>> On Tue, Jun 29, 2021 at 07:38:15AM -0700, Casey Schaufler wrote:
>>>
>>> [..]
>>>>>>>> User xattrs are less protected than security xattrs. You are exp=
osing the
>>>>>>>> security xattrs on the guest to the possible whims of a maliciou=
s, unprivileged
>>>>>>>> actor on the host. All it needs is the right UID.
>>>>>>> Yep, we realise that; but when you're mainly interested in making=
 sure
>>>>>>> the guest can't attack the host, that's less worrying.
>>>>>> That's uncomfortable.
>>>>> Why exactly?
>>>> If a mechanism is designed with a known vulnerability you
>>>> fail your validation/evaluation efforts.
>>> We are working with the constraint that shared directory should not b=
e
>>> accessible to unpriviliged users on host. And with that constraint, w=
hat
>>> you are referring to is not a vulnerability.
>> Sure, that's quite reasonable for your use case. It doesn't mean
>> that the vulnerability doesn't exist, it means you've mitigated it.=20
>>
>>
>>>> Your mechanism is
>>>> less general because other potential use cases may not be
>>>> as cavalier about the vulnerability.
>>> Prefixing xattrs with "user.virtiofsd" is just one of the options.
>>> virtiofsd has the capability to prefix "trusted.virtiofsd" as well.
>>> We have not chosen that because we don't want to give it CAP_SYS_ADMI=
N.
>>>
>>> So other use cases which don't like prefixing "user.virtiofsd", can
>>> give CAP_SYS_ADMIN and work with it.
>>>
>>>> I think that you can
>>>> approach this differently, get a solution that does everything
>>>> you want, and avoid the known problem.
>>> What's the solution? Are you referring to using "trusted.*" instead? =
But
>>> that has its own problem of giving CAP_SYS_ADMIN to virtiofsd.
>> I'm coming to the conclusion that xattr namespaces, analogous
>> to user namespaces, are the correct solution. They generalize
>> for multiple filesystem and LSM use cases. The use of namespaces
>> is well understood, especially in the container community. It
>> looks to me as if it would address your use case swimmingly.
> Yeh; although the details of getting the semantics right is tricky;
> in particular, the stuff which clears capabilitiies/setuid/etc on write=
s
> - should it clear xattrs that represent capabilities?  If the host
>   performs a write, should it clear mapped xattrs capabilities?  If the=

> namespace performs a write should it clear just the mapped ones or the
> host ones as well?  Our virtiofsd code performs acrobatics to make
> sure they get cleared on write that are painful.

Dealing with tricky semantics is the difference between a feature
and a hack. Doing so in a way that other people can take advantage
of the feature is the hallmark of a feature well done.

>
> Dave
>
>>> Thanks
>>> Vivek
>>>

