Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9E35626F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 01:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiF3XXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 19:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiF3XXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:23:08 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED6FB44
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 16:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656631386; bh=shM7AUPxh6GRe6LHTJHjhkGpCnuNlD/mXhGZ7iR4aKc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=erJS8X2m9guQvCuUZVjG019GCbSlhSZKDi9/eJJ3V/dHPPt66+ri/ooBCDIQrvialEBaCnsV3OFchOI+2OyK/y9cNbn1ZHDgs47V85csEFOTk6OMThN5rzyrMRSpjiH2aA7hybvoWkN3iP5blx6FphmeJOJxHso5FxCBsEBpqAasuefZcfeECfOwM9rmJfnLe6TLrUt2lCiulw68zyOPhs1rbQivuuzB/eLkfZfTPGYPmcIagsrMODIzj3aqicZxycWaO/oYKLW6la3krm9TRfgoiw60r1miwK6ul6xdFe77/MBoqiYmSLOrDK6fkkUZU2AzmHgBfXh54PxdXU3Rzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656631386; bh=Ed7jQI5lgiwrWGOSxuZvL+D891k6yIk/EXaZZdIoimX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TDUasTkVofp4+rgRZHZAgudYujLbP9mqoELOGyplHyG8qI2tnxMW5Zm3BXvXCpT3kwICzMM6gQWeUsLsVV4AF5x+WsgXk+RTzSU6Ih8pALNnnBiuej8ROpk1kPQN/lb0x2Ly9mIn3ZKIVmVm+1zhNi5z9b/nmLMTftufbkrQbF3j1iH1e6NJjcXyfzq9NOKjml6Zjg5qW5OuXVAYRRRcDEcZq2BOGxpJSLHB81B477WhClVNf9/UfBQW0rh02jX5ImY5fyA6FWVWz+himkyCxMIW2mERoKYGMxdn//RXKn2TmIUwKkNA3WVy6WAa6w0wk1U5OM9SP+eSpPsyQcRPyw==
X-YMail-OSG: .QXqowEVM1kGFB0AGiE.PIyU2OE0UMRZHVjDuMUFa_4q3MKPUmp78JlbokAb2wD
 5LQBzOc36Gb3VTifGVHr4wLush3ncar6K3fIIwTyeBJvjcsXApryVqSR8Ez.1Vz7AU_xD3uZ4MSb
 U6lCzOkZfAdoddtcvJsHrH0Z.Eta3G.WLe6B0R_DsHb1WsHEV57WviyNITkHHwfDlBA5aFFSNXuE
 aW1vpwjcxciLMAaxBok2ev6HIt9maJkqBRL2m50yl0YWS7.F_1NtAk1Jd31EeBt8DeVTbZkhc74q
 4odHu.qiCGAm7cFnlnLx0iSLSoyTnOq5eODEDR.tAvXred_qBZkQ1lWPMVo5wQSKaHx_vW0xyL5v
 ZIA_fVzgEDXhpNWtnkmG3hvw_6Kx3GPDkM1fYjB8ccc_osaAQA2255zjFt.1j8un48b7Us05IHBR
 q_WJCskV4lmh_PmavGrdC5438NlARcswIMp5PxCfg3eFPlgkgOv0fmfh3Nevv4NvE6ECd51qN3SS
 8Evc7Z49Kt9t46kHXxpZGczx1mDAz.r7jxRgY3e7C8h2GwmvYs6Uo0CCYsK3NTy3IcmysWdAUruc
 rnMir4yjDMfDh0dhsHdNB1SPZZAtS17.vD2ntU_V4aan5S6zZL3Q1ADcC4rqUsufibVOBfuGdQe8
 BODt1wTFE9.7ETwqa6T2CSkdx7DvQtomgNI0dZJAYrGCiVliutz.h1NDgjZZV2PNOeOrgHK4SRdw
 EFuGO3uooPiztfckRciuATA_n9e6z.yHN.OVXqxqzcfE0GDYNHxbO.jDH85upxAS1ByFai.FLw7R
 5V47Oz1GN5WwNYdjDgrBaNbiA5Z7QGVDGBGpzUFGKJd3lGdPNCIZK2AjeARVLa5OrtNf4kDhX2f2
 aZSGwSP_q4ocm9GQzwctj1ensEjGwHCa8gA0r7EAfQoN6bmaWoT8mQ1XEr1fDDxqi3iGKKN6Eytw
 myChKpLICJMaX0_vSVVSkShlR8iRJP9VgwVpX0NG4Ds5lQ3dd8W5lQtvsAk04DaJwCOl0oMuRoNQ
 34GSPbMcZEeR76wREGf.IEuvZcXG.AtWZEAN2IRfLyN2BWwzDYoHQrgqK5sYNhVK4DH4vgz2GaBM
 a3iUKGELlYbdVriHdukmsthR6urbD8o_.V.S9ZA11Twrw89AO3a_Hh9MtNiMDtS9tsJ3MheZg26l
 .08X_hYg9UiplHRXzLmqeo8cn6ISmk5vijUaiZ1TpyHNAUlk0Rx9EHtJdtN_yuDHx3snbO5POxku
 FpxhljPUhx4cruwVUx9ZHNQ0iJWCPFr8ubilno_f3AM5OVP4y2uoGlI9b.i9YGD0LJ68yAtdXZ2f
 vGTzPhIa8dAWyBer9aY4GogXld5jbouo_Pr9zDsgolvuBiB1ZV3N__tz4keboiEEIblsr3AUNlzs
 qPDL9CY1HMXZjW3w0.SG3vuOGbvlEBwlulCLKVLWVxT3q4vAee4Oz_z0ApgxbCWBHCXBY2S6vVGk
 BLSgXggymrQsxK4sopBjI5XV8E0lkAMFqy3qRhj_XIYlYhjFiXEWw5Y2r2_d1fNoo5zhP8G4TNmK
 rm6SmXYwi0E6G74gQjb5vXBchpHoLXbz4IjyxDcc0ECfMSPtfMFTjo3Qi6Iv62NqzdQUI5FGOO2W
 oBPY6HaDtJkLDch4jtoaiVl.CxRqAwBT73Vc6MFBtTW4hehhS5fZjjnZZyL3bXedLRLQ7ujk5WEw
 6WnGy4q5.gBI4qQS1FiZuFlcLyEV_s7px1YCq5qI0j5cmQZUEaTjHB8wtY3qeEzhrQ_QqO2NPOA5
 D.WoObjrCD15MYXM2lfU2_PmbT_iRE8.W._F2MW9itSRrzJZCAT.n9vy6wmGK7H6kccDjWnsrzfn
 9Yf3EPmCA5DPeH03b8LiHo.NeSd7ObljVBiSYig7YqklLTqXaQS2M4gFvy3E8UNU7ob3VE4X94mp
 ZnvWTo1l2q8Jjgbk6Z7nUVffO0IMKYlA30O2mZfzpNxdT4kos4dBbYZddST8hwnimlfHxGiEU6Cj
 EimWbTCsIHrcDTavTJXUY6r0oPrZvBfxD7K44gUp7albo04ZXcqzoNhGSSjirp7waD6Artecv305
 thjh_esUmaC4PynPz4H6PL0XXEiqImPF229swMuhnzB0e1a_VO93idk.5gVZ3l6XqEsFPi3DFVJL
 rryAYlKs.soL5XnuBaSFLtWiROF1atK4Xf_uhIfb6GcriZ4zEjrHupQalzTpX31x510a9hvNcTq1
 _KjrEARoiebrXR..KkIK0zfUFZqWB0lBFVfgPf6zOXg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Jun 2022 23:23:06 +0000
Received: by hermes--production-bf1-58957fb66f-ldc6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4c9d9690ca4aa33a27fe8711debadabc;
          Thu, 30 Jun 2022 23:23:03 +0000 (UTC)
Message-ID: <e95e107e-e279-6efc-0011-3995b96414af@schaufler-ca.com>
Date:   Thu, 30 Jun 2022 16:23:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for
 bpf_getxattr
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Serge Hallyn <serge@hallyn.com>, casey@schaufler-ca.com
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
 <7d42faf7-1f55-03cb-e17e-e12f7cffe3de@schaufler-ca.com>
 <CACYkzJ7fVCWFtKhFqth5CNHGTiPnS8d=T2+-xSc03UBGLgW+4Q@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CACYkzJ7fVCWFtKhFqth5CNHGTiPnS8d=T2+-xSc03UBGLgW+4Q@mail.gmail.com>
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

On 6/30/2022 3:23 PM, KP Singh wrote:
> On Thu, Jun 30, 2022 at 6:10 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/30/2022 6:47 AM, Christian Brauner wrote:
>>> On Thu, Jun 30, 2022 at 03:29:53PM +0200, KP Singh wrote:
>>>> On Thu, Jun 30, 2022 at 3:26 PM Christian Brauner <brauner@kernel.org> wrote:
>>>>> On Thu, Jun 30, 2022 at 02:21:56PM +0200, KP Singh wrote:
>>>>>> On Thu, Jun 30, 2022 at 1:45 PM Christian Brauner <brauner@kernel.org> wrote:
>>>>>>> On Wed, Jun 29, 2022 at 08:02:50PM -0700, Alexei Starovoitov wrote:
>>>>>>>> On Wed, Jun 29, 2022 at 2:56 AM Christian Brauner <brauner@kernel.org> wrote:
>>>>>> [...]
>>>>>>
>>>>>>>>>>>>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
>>>>>>>>>>>> [...]
>>>>>>>>>>>>
>>>>>>>>>>>>>> +SEC("lsm.s/bprm_committed_creds")
>>>>>>>>>>>>>> +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>> +     struct task_struct *current = bpf_get_current_task_btf();
>>>>>>>>>>>>>> +     char dir_xattr_value[64] = {0};
>>>>>>>>>>>>>> +     int xattr_sz = 0;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
>>>>>>>>>>>>>> +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
>>>>>>>>>>>>>> +                             dir_xattr_value, 64);
>>>>>>>>>>>>> Yeah, this isn't right. You're not accounting for the caller's userns
>>>>>>>>>>>>> nor for the idmapped mount. If this is supposed to work you will need a
>>>>>>>>>>>>> variant of vfs_getxattr() that takes the mount's idmapping into account
>>>>>>>>>>>>> afaict. See what needs to happen after do_getxattr().
>>>>>>>>>>>> Thanks for taking a look.
>>>>>>>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>>>>> That will not be correct.
>>>>>>>>>>> posix_acl_fix_xattr_to_user checking current_user_ns()
>>>>>>>>>>> is checking random tasks that happen to be running
>>>>>>>>>>> when lsm hook got invoked.
>>>>>>>>>>>
>>>>>>>>>>> KP,
>>>>>>>>>>> we probably have to document clearly that neither 'current*'
>>>>>>>>>>> should not be used here.
>>>>>>>>>>> xattr_permission also makes little sense in this context.
>>>>>>>>>>> If anything it can be a different kfunc if there is a use case,
>>>>>>>>>>> but I don't see it yet.
>>>>>>>>>>> bpf-lsm prog calling __vfs_getxattr is just like other lsm-s that
>>>>>>>>>>> call it directly. It's the kernel that is doing its security thing.
>>>>>>>>>> Right, but LSMs usually only retrieve their own xattr namespace (ima,
>>>>>>>>>> selinux, smack) or they calculate hashes for xattrs based on the raw
>>>>>>>>>> filesystem xattr values (evm).
>>>>>>>>>>
>>>>>>>>>> But this new bpf_getxattr() is different. It allows to retrieve _any_
>>>>>>>>>> xattr in any security hook it can be attached to. So someone can write a
>>>>>>>>>> bpf program that retrieves filesystem capabilites or posix acls. And
>>>>>>>>>> these are xattrs that require higher-level vfs involvement to be
>>>>>>>>>> sensible in most contexts.
>>>>>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>>>> This hooks a bpf-lsm program to the security_bprm_committed_creds()
>>>>>>>>>> hook. It then retrieves the extended attributes of the file to be
>>>>>>>>>> executed. The hook currently always retrieves the raw filesystem values.
>>>>>>>>>>
>>>>>>>>>> But for example any XATTR_NAME_CAPS filesystem capabilities that
>>>>>>>>>> might've been stored will be taken into account during exec. And both
>>>>>>>>>> the idmapping of the mount and the caller matter when determing whether
>>>>>>>>>> they are used or not.
>>>>>>>>>>
>>>>>>>>>> But the current implementation of bpf_getxattr() just ignores both. It
>>>>>>>>>> will always retrieve the raw filesystem values. So if one invokes this
>>>>>>>>>> hook they're not actually retrieving the values as they are seen by
>>>>>>>>>> fs/exec.c. And I'm wondering why that is ok? And even if this is ok for
>>>>>>>>>> some use-cases it might very well become a security issue in others if
>>>>>>>>>> access decisions are always based on the raw values.
>>>>>>>>>>
>>>>>>>>>> I'm not well-versed in this so bear with me, please.
>>>>>>>>> If this is really just about retrieving the "security.bpf" xattr and no
>>>>>>>>> other xattr then the bpf_getxattr() variant should somehow hard-code
>>>>>>>>> that to ensure that no other xattrs can be retrieved, imho.
>>>>>>>> All of these restrictions look very artificial to me.
>>>>>>>> Especially the part "might very well become a security issue"
>>>>>>>> just doesn't click.
>>>>>>>> We're talking about bpf-lsm progs here that implement security.
>>>>>>>> Can somebody implement a poor bpf-lsm that doesn't enforce
>>>>>>>> any actual security? Sure. It's a code.
>>>>>>> The point is that with the current implementation of bpf_getxattr() you
>>>>>>> are able to retrieve any xattrs and we have way less control over a
>>>>>>> bpf-lsm program than we do over selinux which a simple git grep
>>>>>>> __vfs_getxattr() is all we need.
>>>>>>>
>>>>>>> The thing is that with bpf_getxattr() as it stands it is currently
>>>>>>> impossible to retrieve xattr values - specifically filesystem
>>>>>>> capabilities and posix acls - and see them exactly like the code you're
>>>>>>> trying to supervise is. And that seems very strange from a security
>>>>>>> perspective. So if someone were to write
>>>>>>>
>>>>>>> SEC("lsm.s/bprm_creds_from_file")
>>>>>>> void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
>>>>>>> {
>>>>>>>         struct task_struct *current = bpf_get_current_task_btf();
>>>>>>>
>>>>>>>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
>>>>>>>                                 bprm->file->f_path.dentry->d_inode,
>>>>>>>                                 XATTR_NAME_POSIX_ACL_ACCESS, ..);
>>>>>>>         // or
>>>>>>>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
>>>>>>>                                 bprm->file->f_path.dentry->d_inode,
>>>>>>>                                 XATTR_NAME_CAPS, ..);
>>>>>>>
>>>>>>> }
>>>>>>>
>>>>>>> they'd get the raw nscaps and the raw xattrs back. But now, as just a
>>>>>>> tiny example, the nscaps->rootuid and the ->e_id fields in the posix
>>>>>>> ACLs make zero sense in this context.
>>>>>>>
>>>>>>> And what's more there's no way for the bpf-lsm program to turn them into
>>>>>>> something that makes sense in the context of the hook they are retrieved
>>>>>>> in. It lacks all the necessary helpers to do so afaict.
>>>>>>>
>>>>>>>> No one complains about the usage of EXPORT_SYMBOL(__vfs_getxattr)
>>>>>>>> in the existing LSMs like selinux.
>>>>>>> Selinux only cares about its own xattr namespace. It doesn't retrieve
>>>>>>> fscaps or posix acls and it's not possible to write selinux programs
>>>>>>> that do so. With the bpf-lsm that's very much possible.
>>>>>>>
>>>>>>> And if we'd notice selinux would start retrieving random xattrs we'd ask
>>>>>>> the same questions we do here.
>>>>>>>
>>>>>>>> No one complains about its usage in out of tree LSMs.
>>>>>>>> Is that a security issue? Of course not.
>>>>>>>> __vfs_getxattr is a kernel mechanism that LSMs use to implement
>>>>>>>> the security features they need.
>>>>>>>> __vfs_getxattr as kfunc here is pretty much the same as EXPORT_SYMBOL
>>>>>>>> with a big difference that it's EXPORT_SYMBOL_GPL.
>>>>>>>> BPF land doesn't have an equivalent of non-gpl export and is not going
>>>>>>>> to get one.
>>>>>> I want to reiterate what Alexei is saying here:
>>>>>>
>>>>>> *Please* consider this as a simple wrapper around __vfs_getxattr
>>>>>> with a limited attach surface and extra verification checks and
>>>>>> and nothing else.
>>>>>>
>>>>>> What you are saying is __vfs_getxattr does not make sense in some
>>>>>> contexts. But kernel modules can still use it right?
>>>>>>
>>>>>> The user is implementing an LSM, if they chose to do things that don't make
>>>>>> sense, then they can surely cause a lot more harm:
>>>>>>
>>>>>> SEC("lsm/bprm_check_security")
>>>>>> int BPF_PROG(bprm_check, struct linux_binprm *bprm)
>>>>>> {
>>>>>>      return -EPERM;
>>>>>> }
>>>>>>
>>>>>>> This discussion would probably be a lot shorter if this series were sent
>>>>>>> with a proper explanation of how this supposed to work and what it's
>>>>>>> used for.
>>>>>> It's currently scoped to BPF LSM (albeit limited to LSM for now)
>>>>>> but it won't just be used in LSM programs but some (allow-listed)
>>>>>> tracing programs too.
>>>>>>
>>>>>> We want to leave the flexibility to the implementer of the LSM hooks. If the
>>>>>> implementer choses to retrieve posix_acl_* we can also expose
>>>>>> posix_acl_fix_xattr_to_user or a different kfunc that adds this logic too
>>>>>> but that would be a separate kfunc (and a separate use-case).
>>>>> No, sorry. That's what I feared and that's why I think this low-level
>>>>> exposure of __vfs_getxattr() is wrong:
>>>>> The posix_acl_fix_xattr_*() helpers, as well as the helpers like
>>>>> get_file_caps() will not be exported. We're not going to export that
>>>> I don't want to expose them and I don't want any others to be
>>>> exposed either.
>>>>
>>>>> deeply internal vfs machinery. So I would NACK that. If you want that -
>>>>> and that's what I'm saying here - you need to encapsulate this into your
>>>>> vfs_*xattr() helper that you can call from your kfuncs.
>>>> It seems like __vfs_getxattr is already exposed and does the wrong thing in
>>>> some contexts, why can't we just "fix" __vfs_getxattr then?
>>> To me having either a version of bpf_getxattr() that restricts access to
>>> certain xattrs or a version that takes care to perform the neccesary
>>> translations is what seems to make the most sense. I suggested that in
>>> one of my first mails.
>>>
>>> The one thing where the way the xattrs are retrieved really matters is
>>> for vfscaps (see get_vfs_caps_from_disk()) you really need something
>>> like that function in order for vfs caps to make any sense and be
>>> interpretable by the user of the hook.
>>>
>>> But again, I might just misunderstand the context here and for the
>>> bpf-lsm all of this isn't really a concern. If your new series comes out
>>> I'll try to get more into the wider context.
>>> If the security folks are happy with this then I won't argue.
>> A security module (BPF) using another security module's (Smack)
>> xattrs without that module's (Smack) explicit approval would be
>> considered extremely rude.  Smack and SELinux use published interfaces
>> of the capability security module, but never access the capability
>> attributes directly. The details of a security module's implementation
>> are not a factor. The fact that BPF uses loadable programs as opposed
>> to loadable policy is not relevant. The only security.xattr values
>> that the BPF security module should allow the programs it runs to
>> access are the ones it is managing. If you decided to create an eBPF
> What about kernel modules who can use __vfs_getxattr already as
> it's an exported symbol? This can still end up influencing
> security policy or using them in any way they like.

If I put code in Smack to read SELinux attributes I would expect
to get a possibly polite but definitely strongly worded email
from Paul Moore regarding that behavior. The integrity subsystem
looks at Smack and SELinux attributes, but that's upstream and
we can see what nefarious things are being done with them. Because
I can see the upstream kernel code I can convince myself that
regardless of the SELinux policy loaded SELinux isn't going to
muck with the Smack attributes. I can't say the same for eBPF
programs that aren't going to be in Linus' tree.

> Anyways, I think, for now, for the use case we have, it can work with
> a restriction to security.bpf xattrs.

I can't say that this whole discussion is making me feel better
about the BPF LSM concept. The approval was based on the notion
that eBPF programs were restricted to "safe" behavior. It's
hard to see how allowing access to security.selinux could be
guaranteed to be in support of safe behavior.

