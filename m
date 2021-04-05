Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BD35450B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbhDEQSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 12:18:41 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:39124
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237975AbhDEQSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617639514; bh=Wk0gSx9KtKlrYHhrWgsRwVo6/wGfpgk4Rrur+WwxGnU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=Yo56Mr4PndVQbbydhsJCvwOLtES1L0NfqupkB6aeAlxuHb/ERhM4F6gfEJv7kwIGtVxNgCnRki9sIogMkQhblo/uXNP7y1SJRrIuInSgwPbYNHZbASaessN9JkGuvrtjaNq74YUnRGB4CAk2tfWcDDtyDcwzM8XAqsAe5RDGZ0DbJQ0m1tIuDpT8Uw8yPZpy2xZcXM3L9wRYK8Ygzm8lATO/C6s9UTfBezLZygD/gMUXSL9BJri8903IrqOJNS7URB4ab9UFPt6t2YiJ+yleboq9c5y1JUcrIzuHdeLGk4xymQf3k2wgMIeKCLK/AfrmH6X0sJ7IAcx0OHUYkNW/4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617639514; bh=0qMNF1TTaExDODwDbnC7p7W9EKJIMzdXkCK+BalPX+K=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=K+FQi02222Hz6nVxYWOJKGBNY47B7yAFAGLeKjENkX4IZjPlhjp6jUNyRdYMYMlJrQLFUXVrTtmHUCez3xr61kRQIVVmjn3vkFfHT8zA3on2mkyeDtM9mIx4V0DQjzv1NkuhBi0WH8A8YhtjYEXE408Ka9e/YN7g1NsakbLDEtDGdo1P8rq66Mpx5hiRmlpRrkSz0elPja/HXRAlKfgWJfRKcPJRmA6JpuKEdoboa6sdA14O4YW2YQ9WFuqnLeCgsVHE7VHt6QJrnY73RamOenyIWDOhl++ho99Nm/xksrBeCIqoRKt9C8XZvSFuK50gr0HQL/cRELMGAFrVV/zDkA==
X-YMail-OSG: mMT4xecVM1kJIK4A4C96aV5O.cRFRBZFI2II6gIopzS5DlX8B55KDZrvV.DDlBz
 YYsGG5w9.Mna5B112egTPvLVi_wrcCptXxOX0W9YQJB7I9XMIfB_y9xXh9tgBPkI8_0v23vnKlxp
 029_jH4AAbBJHmc._ADUBUb.VxIIrnJx398LgpFbWEOf3bUepjmOvudN5u9WttV3juFClwJNAcOY
 9ok5JqC0L5P_chUA7BFATBdok6uFFf6IEU..WJ0CwbJwdH91M4aLbYH2Qj4CAmqL1CuAL3Toj9_z
 wR6Unv.ZC3ASoujjv0MIBcvAv37l5dx27mr69PEhFkpAmVZtbuLXXMX09sNCAJ.cTH5pas7v03g3
 ypeS2EUk50HUw9ohVYJpuWchqzqa3954VGc2MioliiESZb8YAhgp3IjY.Z5Ggx4v2zja20aItnUA
 eS4jDB9fC0XTU44al5x.GSs8W0f_tZX6nshUWvV4ZkB54sXBu0TeR0OAYHMvaJCsEtNJIa9vz0rJ
 yvZVqLCrS8dRcl36fZ62O8JMefkKPOo41Hr9a7wqsMVATLv4K4aZNlVm.FIR6KUEs4WHxY4.r35f
 0rs8wf3jm0Vv9mbHQkXcHCWKRiKq5FP.aP5n2kt9efs1E6ba8tGluGZVE3j5UIEU6HkrV9L1Za6h
 AXBvefLDXyszri4A1sRs3otRipnUr_JN6mhHmslgJRQzCthim9kGxsFgSCf8rV7R4Vv7_xDlu7J7
 wrASGFqG86RHBOGQepoQFvD6IKxgio0vjvB_dCsjFNFrgWeV4O5_neWSgScGxmN..6KidHte9kU1
 pXmyr2HTE3w.2rETVaVv0Xnq_VFjfJFZfT_FGgk4wR41wlKrx5jgaE6fuNz.cEd.4c5biAtvUdLI
 tKsPQeVsgR16sCx_wvMGvQqRlX4fIltSLxHSqmB5mu.EPhlCKRh0EMxrOMqwusBxtgq13d4MSjlS
 3_e4MDnAD3qVeMeYozOndvZO2MAQ6IO1bkWY5vz4I3K5HvjOY3MQFtZiQL4YPtwh9BPJ07PYKtNi
 aohFpvmJUKvmBO.KHAGnV5OWlYCJ4SDVZdOb67UAqp1ZQIXdiqSXunvcWvKmoBQNPGKX_aJHzA4h
 211eV5JsmIxe6D0pTerE0Akir2Vl8s2n2mO7W0lDPHrdxSzDW5WHyzs8LgiqvEbVxaa4sIUMZaTm
 ._t7PDvvkLgxFsNHAxTmqzDAikHYOraw7M6VnfUKfNC19hqtYANuu8YPvYV44tTFsT3ACBJrQS4z
 R6vq6G.xyiUeA1LCCp_6YEeqMbkpQckRkAg_Cs.jQmLpYwAprKMQeJggQkSnWnIUM3p0gWB2eqI7
 xTYivMj3CDpYDThZQvQTPMRX0HEq0wvqX.mb0I6k9HFiqgp9kowViTkkPR6U4C9kKbrTxTKTTjpm
 gXrbycLL.7PciwOsZhoKOIcjYPvWonhOzg_fpHiNO1apBjlZFFPSrc_bXcz0bS.Ov4yr47zEQ.WL
 J99cCwi9AoIE4r_igIteIqj81pjZanmhypQJwUVWCQv_4NEiy97LXUpQgY8N5UdBdDgxJBkpjWz1
 6uGwr3TAUn.uh.PnegTldu6IXe2pU2diKpej5tKwxGN2N7CnffwiuVzG43VXC8hfbckHuofQYWkB
 jqHlBq27eXcj5Mx315RE.RWToRU_rDkJAkgfynCIqx72V2Ee2jj6S8P_.H_ufb7uGIaK5.caVOv8
 no2OhHj6qjw_pcDwKJVWx3svqk09BaXhCelGA_r4Agf6K0xSrnVK7RcWigjPWDszAMxEz2JfqsFn
 __GAhZpD0ateMPDiefH1pbJAKYF92apLq6XcmoG44VdK6rDnm2UubWfbjjaIaBUPz6BVj.LMPKSY
 jZt.SClLpMTaBhLd6A.pk.dUKOBsKtHiApuB_BYqNbnGbDjw1ld5KZyheerf3llc01ZRzh_lCKSU
 QC0z46c_Dcw1Qxchx83zI19zp9dkmKOmJ.ahmjQ_G.HNbtr31G2YYyXc_e976NO61RHhV.JQz.Ga
 rqaRACi5XgTOQJlo0IaYYBCl6YniphtjYMq1OO3VPpe6unySNQ_JiV8zRN0WNBVfsZ8UfDXoDSri
 75uEAAKKtwp5ub1rPR3YxsgSwlCLopWiPo.JxutvzaIlqMgZR8ZSAMESSOeBp0dbvnFtfWvEaupv
 f3RMlw_uoXQK8gAcKyqa_IhB4GEVnVqCAmt2ZRfnUspM_R24.a5EY9chNVdSL1iwCwv_qh8UY3RK
 McMc.DBhjvojuBzl7TmjzNdeoQvyxj_V1Z1DRCc2_5RGJEZCPVLGTdC6iLlzlEx11WgFXLdo6cYW
 mtyMenHvTu.dktInC1lB9FHxuGu87beBMMZgcIKLM_1Oh1xNC6HV1pRlWFOKGDvgKQDQf5eC01M.
 _SEEtR.ElY2XRLVPxVSvnP1wTMmAKNPxcAukRBH5oI92OO1zOk8Jbfttv1HVs.4UAQnaAbeWu.22
 NMuO_1lyoaxhcL9XagyNPKEYHYAkpJWkurHzPvPgOSfuU5DTpFW0cl2dr0.cCJgHJahMKFK1vRD6
 S_j1IMkooCxLcv2QdOoKd9YmKK7Mjl4fnQYKhcLl6f59MxCwBkAhPLI2kD42RnL7GZDfZOECNRYJ
 5UoR3cCgE6WuhKdyVaxyWB1VZw.GRPUuY9nXHeDhju6_trYNgHx7Z7KDDAjPwZTl0HYF_TFi8EX7
 qq5udrV0_vNEHUhCfsnjvl8B1RsdL1yB9g5uyymkEay7JqC4_XA4EHJzvIhsg1BKNQSqZKntutUy
 MgAwcQzrMgiM.nf2OIY.s6mYjXDjK_GyWQdvY6FOuAgFnbLIbU.Q9xYSbIZKuakn43kpo9fO.CCT
 zh.A79OUtWVlSwWyotxtYsRgxtNTfj2Moxttjh2FUVqdVAHHdYlavCMXPJ9dNzV7PJibM_UKH7ok
 x0tHozfs7kwuA_0BlzO9DnzECq4gQNwFoKuMGlG__UW4h9KbGypRgxUsaQ1g0J.zudZkQKFznILm
 etgMP4dqQFjTCmTPfCtXLba1E1T6i0aAVc7a1.2wTWnO6k3ULvtkI4Rzt3aBPGKoYLVat3d3MuTz
 QQeQDHMCtN.o7Usr.PkVqLjcgerGxL7mIfLNBPmeX65yVZuzW59joeHxjpgnZ9OwPaLrOBjledx8
 ktqUDHgmlMAvSSza3n0nZg1bI2okDDkeoejM2UP85.a8xf2.00ziTK_SMgsZdODsAYl6Gp1xP1H6
 w5zhaQDg2X_084UyNalhrhhmLbkMxW6hNSBvwF6pCZc6Nx2mEfrY0Ch3TZInqL0bBmXvfqbVLEyL
 tXKLsBJGQZBg.aw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 5 Apr 2021 16:18:34 +0000
Received: by kubenode500.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 22ee6e8af3ad361e443af089b48e912a;
          Mon, 05 Apr 2021 16:18:33 +0000 (UTC)
Subject: Re: LSM and setxattr helpers
To:     Amir Goldstein <amir73il@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tyler Hicks <code@tyhicks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1e86be00-91b5-9ce5-33e6-c0c54c38293b@schaufler-ca.com>
Date:   Mon, 5 Apr 2021 09:18:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxg+82RLt+KZXVLYhuDvrPLE0zaLf3Nw=oCJ=wBY6j6hTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/4/2021 3:27 AM, Amir Goldstein wrote:
> [forking question about security modules]
>
>> Nice thing about vfs_{set,remove}xattr() is that they already have
>> several levels of __vfs_ helpers and nfsd already calls those, so
>> we can hoist fsnotify_xattr() hooks hooks up from the __vfs_xxx
>> helpers to the common vfs_xxx helpers and add fsnotify hooks to
>> the very few callers of __vfs_ helpers.
>>
>> nfsd is consistently calling __vfs_{set,remove}xattr_locked() which
>> do generate events, but ecryptfs mixes __vfs_setxattr_locked() with
>> __vfs_removexattr(), which does not generate event and does not
>> check permissions - it looks like an oversight.
>>
>> The thing is, right now __vfs_setxattr_noperm() generates events,
>> but looking at all the security/* callers, it feels to me like those are
>> very internal operations and that "noperm" should also imply "nonotify".
>>
>> To prove my point, all those callers call __vfs_removexattr() which
>> does NOT generate an event.
>>
>> Also, I *think* the EVM setxattr is something that usually follows
>> another file data/metadata change, so some event would have been
>> generated by the original change anyway.
>>
>> Mimi,
>>
>> Do you have an opinion on that?
>>
>> The question is if you think it is important for an inotify/fanotify watcher
>> that subscribed to IN_ATTRIB/FAN_ATTRIB events on a file to get an
>> event when the IMA security blob changes.
>>
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

That seems reasonable to me, but the SELinux team would
have more experience with NFS deployemnts than Smack does.

> Are there any other expected callers of security_inode_setsecctx()
> except nfsd in the future? If so they would need to also add the
> fsnotify_xattr() hook, if at all the user visible FS_ATTRIB event is
> considered desirable.

Not that I know of.

> SMACK:
> Just to be sure, is the call to __vfs_setxattr() from smack_d_instantiate()
> guaranteed to be called for an inode whose S_NOSEC flag is already
> cleared? Because the flag is being cleared by __vfs_setxattr_noperm().

My understanding is that the inode is always in the process of being
initialized, and that S_NOSEC should never have been set.

>
> EVM:
> I couldn't find what's stopping this recursion:
> evm_update_evmxattr() => __vfs_setxattr_noperm() =>
> security_inode_post_setxattr() => evm_inode_post_removexattr() =>
> evm_update_evmxattr()
>
> It looks like the S_NOSEC should already be clear when
> evm_update_evmxattr() is called(?), so it seems more logical to me to
> call __vfs_setxattr() as there is no ->inode_setsecurity() hook for EVM.
> Am I missing something?
>
> It seems to me that updating the EVM hmac should not generate
> a visible FS_ATTRIB event to listeners, because it is an internal
> implementation detail and because update EVM hmac happens
> following another change to the inode which anyway reports a
> visible event to listeners.
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
>
> If you agree with my proposed changes, please ACK the
> respective bits of your subsystem from the attached patch.
> Note that my patch does not contain the proposed change to
> use __vfs_setxattr() in IMA/EVM.
>
> Thanks,
> Amir.
