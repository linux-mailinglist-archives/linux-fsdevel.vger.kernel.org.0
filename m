Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB21C561FFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 18:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiF3QK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 12:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiF3QK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:10:27 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891029C98
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656605424; bh=vR6xMV0TpqmdBMkMQLI5iqtqFC4uNVajmpng6md7Eew=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qpOiuSnhanoG3CJW5q/h2G9Hm0Z4gJlQaugTN5EAuii/g4w2JqILbsOJyZAHm5XhLFQeYn5pThn2FhW1SOsxvFVutzTu/wcpR60taA4X9CZEslyLt3yhd2YEuaOY1ad9xSJc55cFNYXR0FgQ3En4xx8/eWy2omJZLX2xF33ZQKI5HPQCc7gp0QAbhLwWc6UO3EiFX6vaAHCgI92k7CjWWmdOHIqWOGfB6waQmnY3pLm8iQY/1c+iRXO9hynyx+dlrWM2LwWcPo9d6rtxl1liZvnwLX3WzL61QRdqqbTKRUwOTske35KQFWUmy0uesEDbX6o2NshjXfTAUDlDuNvgfQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656605424; bh=ByCer+SXB0OsMMO0l7obwrYs2cMoSmXNuy45oX5DAvJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qQSJgwbeU5mCe5HiARmYYoum4ur7jz2X8duDKrXn6tTR9mlKldrvRGWX4YGTTQ7jgz1wmqubcnxtdoT1jwsRyhuofAhDbprFqoWPfUBFkRCSWIFFNTpAV8APi2sP+H2sc0TLT2JbAyFqyuHr9Bav/Sa+9XeFlWq4cTwZizR359v3E0T+14rA71kAU2pUiYEqpTQOmkuMeJMX3VFMThhhqcwLvVE/dAxtTh8kmLz0VPOFc9aFkmx/TO3uasWQcmOdlv/av7OtgwGjZE/8GZ2NzoTGSx6Y/h0BK76m7BuKFZ4/57Oc2l4P6w5gFOWWlDj3tJNc6wSQ5ILetIyceIkXEg==
X-YMail-OSG: Qc8zXT8VM1mRcFEhIqEWPnkVzMRDN5foGBjLbX75PqmOpS.WhXWAd4lg5MwSmoQ
 I.eYD3WPHVem7SCRSQVAEpuqwDTAFPZSfOql3yZkr.9BapfIaYHJeXODcrzItQPbEIl.IX9BXLQx
 wPfTFpCmAJ92hHVEJblY4O3LpQWEQTvntYXAQwPdZ3V598PQbU86bzScUAequAC0RoJriUI4p15F
 GyDRNI2yok6MgDoeUD_xrieAuvPtUrheUAmxEgomMgeDsWsNcFeLfDBkcDwNzyl5nbizzb0OwthA
 dVGp8.KpsAoxaJWxxhpzyTUn_JN6cvPCF1vy9c9.pfCO.NGzvDrt9pYAg1m2CSiWa_gUiGKFN_MO
 MkEFFXWMB66bebfuAi2fXPvfrQwz8SP0tVgENe_StLGNj_8UV81YM5vMV6HpL.6aedRdCLsEWJCJ
 rzbcGK5TSTXAoZ9EpnAo5UXzOWe3tOn23khfGHl6qA.OSDTAEf9CETsiPJrI9d3_ShG6x0jjKcOi
 zRc1MeTK2FBybrtwh1N5LqOe4wQ96i_32irwm15AOLlNi5v9cPfWaFpEzJSRQHnclLcIXp7pdH7M
 L99k9R29rFiPr7S.W7B4vzzdDcm78bNV2N8mUyXvEnc0cppfjfJNLtZWQgKGHVVFd8EOR0Pd.Vqu
 S5k1KFTEiO9CFwOQeZkkxoYZWCq.lGxAzLwwt2x3bvVasZGebTt7yJt4kXif5aItGXm3HX5TaRAt
 A8OvVcjMLBVVuO2hL5.YsJtypJukUDHAq5hwpVboypUK9B2GTZE_dggadOoFqGmz8CCGD.guA6Uj
 4WphVjdEEixF5WYAU7RIKDLkIjGvsE9ZRRcBzJGIS9YytwNsGVhCa.TCXAbK6mdXJpSV5TopBMlA
 ZRPj5Lap.WmKQnP44T0ZjIkdRccuXG812W6biCFyq.N6vwr1sLmVnekMjLE3o.UQ3GgkEsh_nSr.
 DnzRAp1KRBBp_uFovGBoMmhqalcLdolZh8xQzgkb7bKAi5TTbUlN_STQc_6tcut09r8F_ExvfSh1
 76WQOUCrQCLv7t0RAmqRuIsFJIU8X87xFWjq7VTjXWe4sT0A_HVs7wWIokpwcgcXKZSktILy961r
 LbRwDK3SjC0zcWRb5VSyh1aVrxCdAtpXxmckDQ82Ko2nE4Js2gkvRtci6AD4WYB4cZDoNUWcpZYk
 dRyvFgIBRcLgDb5PaH1IwNju8JVp6tdlT0CTT6..2yvhTxKXMHEXrdRiayo9eDbIz_ZihVXrE94I
 gZnKLdRZqk8e0Vy6FjwcQJLZ0.rLVPiWUH0d.IQsWOrJopbYQ1vwJ3hoXbymSRJqW9veI_3rky1O
 1QKCeW7i3nv2hL8uC4lU6UB.Z7dJuJr_8QtXJfhFc_P5lHwnWtF2LLlXT8r5_JoZEz29jA2Ti.WP
 KRfuQ5HuiZxM9RReo.1hbjdawqYFCzsfQxlLzj9a7Mzz5lhHWKI34ch5f2C809RgeT4u5_VJ143_
 06OKS5zTVATKxhM5OqFvvLOVR8Yfdd2iOV6uDjxCnPUQFVsKIRY80y6cmdGBm9wKpyGdzC_XUPU7
 NP_svikrPluC00YteGqr.vUqSUn4TseoWIL54_23gZWjbSr62cuQ.46HfWqcpxWypF.f6MJ9rp1R
 RTkKb29CL3W5XtXeyJyq0IVie9DofoVhO.Pz4JKC.ZVYhHWeHjNaM3YnnGdHKyH0.7IkzQKJfAo6
 jGUC5jbeDdI9NuyZkdiqYFnIURHYVvyElBKZxiNdyGY5eHUg7d4EWusBvpmBXQI_lgExy113XOSl
 kekaqUz9QDVsBodbv6CE3ltSLk3KpuFhHKEkoDUe5fR29DSyhdc_jJ4hItM6q23mkEqHz3Fa_G1z
 xrhT6dPwq5lKSgsxiqJoipPOHSvjGCqmmI3cvDNyItzM8Iyx3UilhFas.Tb9O0zgMXH_IE6.I0Eg
 VfjO4jfPSq_.0sdVyUKGvUeZwZz1Y0agzJB2JFZOgZsxymF_MfCROU8WfhzfdKF32AnjK18CrXyd
 kPJyzU.xJPmzzzZdHqGAn4v8h1FSatsqwvrpTNV2oVKrAVvzb7nBpqm_Er5mJeeOsoGZIOofIoWN
 8MHNe3uNIXC7qHgTEIfjUFRlbVe7mY7kRZAzR0APR5kVb786aoXrQ_N8RuCBUMeAhuD33OCl7VXS
 cGTjq69h3opu_tfU86AkYGBBhd6nAbYQQ8yVKJwtIhr32DObPAk.wYug85rBvLHoixHTom_N8mF2
 jpBFQ1qdw5Pb2DmzjwRtThmy220TlsIGXUI3CuQI5XB6lsT1DKjU2yyQTk3NdbeKnnWeWfAg7F8o
 XuRyLSHWc49es
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Jun 2022 16:10:24 +0000
Received: by hermes--production-bf1-58957fb66f-hd57d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 57a2e500a97a24731993080e9c9231e9;
          Thu, 30 Jun 2022 16:10:21 +0000 (UTC)
Message-ID: <7d42faf7-1f55-03cb-e17e-e12f7cffe3de@schaufler-ca.com>
Date:   Thu, 30 Jun 2022 09:10:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for
 bpf_getxattr
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Serge Hallyn <serge@hallyn.com>, casey.schaufler@intel.com
References: <20220628173344.h7ihvyl6vuky5xus@wittgenstein>
 <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
 <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
 <20220629081119.ddqvfn3al36fl27q@wittgenstein>
 <20220629095557.oet6u2hi7msit6ff@wittgenstein>
 <CAADnVQ+HhhQdcz_u8kP45Db_gUK+pOYg=jObZpLtdin=v_t9tw@mail.gmail.com>
 <20220630114549.uakuocpn7w5jfrz2@wittgenstein>
 <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
 <20220630132635.bxxx7q654y5icd5b@wittgenstein>
 <CACYkzJ6At2T9YGgs25mbqdVUiLtOh1LabZ5Auc+oDm4605A31A@mail.gmail.com>
 <20220630134702.bn2eq3mxeiqmg2fj@wittgenstein>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220630134702.bn2eq3mxeiqmg2fj@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20381 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/2022 6:47 AM, Christian Brauner wrote:
> On Thu, Jun 30, 2022 at 03:29:53PM +0200, KP Singh wrote:
>> On Thu, Jun 30, 2022 at 3:26 PM Christian Brauner <brauner@kernel.org> wrote:
>>> On Thu, Jun 30, 2022 at 02:21:56PM +0200, KP Singh wrote:
>>>> On Thu, Jun 30, 2022 at 1:45 PM Christian Brauner <brauner@kernel.org> wrote:
>>>>> On Wed, Jun 29, 2022 at 08:02:50PM -0700, Alexei Starovoitov wrote:
>>>>>> On Wed, Jun 29, 2022 at 2:56 AM Christian Brauner <brauner@kernel.org> wrote:
>>>> [...]
>>>>
>>>>>>>>>>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
>>>>>>>>>>>> ---
>>>>>>>>>>>>  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
>>>>>>>>>> [...]
>>>>>>>>>>
>>>>>>>>>>>> +SEC("lsm.s/bprm_committed_creds")
>>>>>>>>>>>> +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +     struct task_struct *current = bpf_get_current_task_btf();
>>>>>>>>>>>> +     char dir_xattr_value[64] = {0};
>>>>>>>>>>>> +     int xattr_sz = 0;
>>>>>>>>>>>> +
>>>>>>>>>>>> +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
>>>>>>>>>>>> +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
>>>>>>>>>>>> +                             dir_xattr_value, 64);
>>>>>>>>>>> Yeah, this isn't right. You're not accounting for the caller's userns
>>>>>>>>>>> nor for the idmapped mount. If this is supposed to work you will need a
>>>>>>>>>>> variant of vfs_getxattr() that takes the mount's idmapping into account
>>>>>>>>>>> afaict. See what needs to happen after do_getxattr().
>>>>>>>>>> Thanks for taking a look.
>>>>>>>>>>
>>>> [...]
>>>>
>>>>>>>>> That will not be correct.
>>>>>>>>> posix_acl_fix_xattr_to_user checking current_user_ns()
>>>>>>>>> is checking random tasks that happen to be running
>>>>>>>>> when lsm hook got invoked.
>>>>>>>>>
>>>>>>>>> KP,
>>>>>>>>> we probably have to document clearly that neither 'current*'
>>>>>>>>> should not be used here.
>>>>>>>>> xattr_permission also makes little sense in this context.
>>>>>>>>> If anything it can be a different kfunc if there is a use case,
>>>>>>>>> but I don't see it yet.
>>>>>>>>> bpf-lsm prog calling __vfs_getxattr is just like other lsm-s that
>>>>>>>>> call it directly. It's the kernel that is doing its security thing.
>>>>>>>> Right, but LSMs usually only retrieve their own xattr namespace (ima,
>>>>>>>> selinux, smack) or they calculate hashes for xattrs based on the raw
>>>>>>>> filesystem xattr values (evm).
>>>>>>>>
>>>>>>>> But this new bpf_getxattr() is different. It allows to retrieve _any_
>>>>>>>> xattr in any security hook it can be attached to. So someone can write a
>>>>>>>> bpf program that retrieves filesystem capabilites or posix acls. And
>>>>>>>> these are xattrs that require higher-level vfs involvement to be
>>>>>>>> sensible in most contexts.
>>>>>>>>
>>>> [...]
>>>>
>>>>>>>> This hooks a bpf-lsm program to the security_bprm_committed_creds()
>>>>>>>> hook. It then retrieves the extended attributes of the file to be
>>>>>>>> executed. The hook currently always retrieves the raw filesystem values.
>>>>>>>>
>>>>>>>> But for example any XATTR_NAME_CAPS filesystem capabilities that
>>>>>>>> might've been stored will be taken into account during exec. And both
>>>>>>>> the idmapping of the mount and the caller matter when determing whether
>>>>>>>> they are used or not.
>>>>>>>>
>>>>>>>> But the current implementation of bpf_getxattr() just ignores both. It
>>>>>>>> will always retrieve the raw filesystem values. So if one invokes this
>>>>>>>> hook they're not actually retrieving the values as they are seen by
>>>>>>>> fs/exec.c. And I'm wondering why that is ok? And even if this is ok for
>>>>>>>> some use-cases it might very well become a security issue in others if
>>>>>>>> access decisions are always based on the raw values.
>>>>>>>>
>>>>>>>> I'm not well-versed in this so bear with me, please.
>>>>>>> If this is really just about retrieving the "security.bpf" xattr and no
>>>>>>> other xattr then the bpf_getxattr() variant should somehow hard-code
>>>>>>> that to ensure that no other xattrs can be retrieved, imho.
>>>>>> All of these restrictions look very artificial to me.
>>>>>> Especially the part "might very well become a security issue"
>>>>>> just doesn't click.
>>>>>> We're talking about bpf-lsm progs here that implement security.
>>>>>> Can somebody implement a poor bpf-lsm that doesn't enforce
>>>>>> any actual security? Sure. It's a code.
>>>>> The point is that with the current implementation of bpf_getxattr() you
>>>>> are able to retrieve any xattrs and we have way less control over a
>>>>> bpf-lsm program than we do over selinux which a simple git grep
>>>>> __vfs_getxattr() is all we need.
>>>>>
>>>>> The thing is that with bpf_getxattr() as it stands it is currently
>>>>> impossible to retrieve xattr values - specifically filesystem
>>>>> capabilities and posix acls - and see them exactly like the code you're
>>>>> trying to supervise is. And that seems very strange from a security
>>>>> perspective. So if someone were to write
>>>>>
>>>>> SEC("lsm.s/bprm_creds_from_file")
>>>>> void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
>>>>> {
>>>>>         struct task_struct *current = bpf_get_current_task_btf();
>>>>>
>>>>>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
>>>>>                                 bprm->file->f_path.dentry->d_inode,
>>>>>                                 XATTR_NAME_POSIX_ACL_ACCESS, ..);
>>>>>         // or
>>>>>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
>>>>>                                 bprm->file->f_path.dentry->d_inode,
>>>>>                                 XATTR_NAME_CAPS, ..);
>>>>>
>>>>> }
>>>>>
>>>>> they'd get the raw nscaps and the raw xattrs back. But now, as just a
>>>>> tiny example, the nscaps->rootuid and the ->e_id fields in the posix
>>>>> ACLs make zero sense in this context.
>>>>>
>>>>> And what's more there's no way for the bpf-lsm program to turn them into
>>>>> something that makes sense in the context of the hook they are retrieved
>>>>> in. It lacks all the necessary helpers to do so afaict.
>>>>>
>>>>>> No one complains about the usage of EXPORT_SYMBOL(__vfs_getxattr)
>>>>>> in the existing LSMs like selinux.
>>>>> Selinux only cares about its own xattr namespace. It doesn't retrieve
>>>>> fscaps or posix acls and it's not possible to write selinux programs
>>>>> that do so. With the bpf-lsm that's very much possible.
>>>>>
>>>>> And if we'd notice selinux would start retrieving random xattrs we'd ask
>>>>> the same questions we do here.
>>>>>
>>>>>> No one complains about its usage in out of tree LSMs.
>>>>>> Is that a security issue? Of course not.
>>>>>> __vfs_getxattr is a kernel mechanism that LSMs use to implement
>>>>>> the security features they need.
>>>>>> __vfs_getxattr as kfunc here is pretty much the same as EXPORT_SYMBOL
>>>>>> with a big difference that it's EXPORT_SYMBOL_GPL.
>>>>>> BPF land doesn't have an equivalent of non-gpl export and is not going
>>>>>> to get one.
>>>> I want to reiterate what Alexei is saying here:
>>>>
>>>> *Please* consider this as a simple wrapper around __vfs_getxattr
>>>> with a limited attach surface and extra verification checks and
>>>> and nothing else.
>>>>
>>>> What you are saying is __vfs_getxattr does not make sense in some
>>>> contexts. But kernel modules can still use it right?
>>>>
>>>> The user is implementing an LSM, if they chose to do things that don't make
>>>> sense, then they can surely cause a lot more harm:
>>>>
>>>> SEC("lsm/bprm_check_security")
>>>> int BPF_PROG(bprm_check, struct linux_binprm *bprm)
>>>> {
>>>>      return -EPERM;
>>>> }
>>>>
>>>>> This discussion would probably be a lot shorter if this series were sent
>>>>> with a proper explanation of how this supposed to work and what it's
>>>>> used for.
>>>> It's currently scoped to BPF LSM (albeit limited to LSM for now)
>>>> but it won't just be used in LSM programs but some (allow-listed)
>>>> tracing programs too.
>>>>
>>>> We want to leave the flexibility to the implementer of the LSM hooks. If the
>>>> implementer choses to retrieve posix_acl_* we can also expose
>>>> posix_acl_fix_xattr_to_user or a different kfunc that adds this logic too
>>>> but that would be a separate kfunc (and a separate use-case).
>>> No, sorry. That's what I feared and that's why I think this low-level
>>> exposure of __vfs_getxattr() is wrong:
>>> The posix_acl_fix_xattr_*() helpers, as well as the helpers like
>>> get_file_caps() will not be exported. We're not going to export that
>> I don't want to expose them and I don't want any others to be
>> exposed either.
>>
>>> deeply internal vfs machinery. So I would NACK that. If you want that -
>>> and that's what I'm saying here - you need to encapsulate this into your
>>> vfs_*xattr() helper that you can call from your kfuncs.
>> It seems like __vfs_getxattr is already exposed and does the wrong thing in
>> some contexts, why can't we just "fix" __vfs_getxattr then?
> To me having either a version of bpf_getxattr() that restricts access to
> certain xattrs or a version that takes care to perform the neccesary
> translations is what seems to make the most sense. I suggested that in
> one of my first mails.
>
> The one thing where the way the xattrs are retrieved really matters is
> for vfscaps (see get_vfs_caps_from_disk()) you really need something
> like that function in order for vfs caps to make any sense and be
> interpretable by the user of the hook.
>
> But again, I might just misunderstand the context here and for the
> bpf-lsm all of this isn't really a concern. If your new series comes out
> I'll try to get more into the wider context.
> If the security folks are happy with this then I won't argue.

A security module (BPF) using another security module's (Smack)
xattrs without that module's (Smack) explicit approval would be
considered extremely rude.  Smack and SELinux use published interfaces
of the capability security module, but never access the capability
attributes directly. The details of a security module's implementation
are not a factor. The fact that BPF uses loadable programs as opposed
to loadable policy is not relevant. The only security.xattr values
that the BPF security module should allow the programs it runs to
access are the ones it is managing. If you decided to create an eBPF
implementation of SELinux you would still have to use attributes
specific to the BPF security module. If, on the other hand, you wanted
to extend Smack using eBPF programs, and the Smack maintainer liked
the idea, it would be OK for the BPF security module to access some
of the security.SMACK64 attributes.

I want it to be clear that BPF is a Linux Security Module (LSM) and
a collection of eBPF programs is *not* an LSM. BPF is responsible
for being a good kernel citizen, and must ensure that it does not
allow a set of configuration data that violates proper behavior.
You can't write an SELinux policy that monster-mashes an ACL.
You can't allow BPF to permit that either. You can't count on the
good intentions, wisdom or skill of the author of an unreviewed,
out of tree, eBPF program. I believe that this was understood during
the review process of the BPF LSM.


