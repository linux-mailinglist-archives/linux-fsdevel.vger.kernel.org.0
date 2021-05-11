Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF29379B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 02:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEKAid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 20:38:33 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:33571
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhEKAib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 20:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620693446; bh=VhS6D9r/U0waDHDfl+JnejLkwpTcId9f5wic8LdH+Uc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=kBiuon/SIFevtxPQma9xKHVBfZtm/Lu3A33dc8kt7h6vM807hpn+/FX/PYqZVCIe5cdAXwJrJWdY/UZCAW0wY0kotl2a+C9b+aycKXumv+c3pAJhPEysKcK3X1FYvrjQDTUkX0u3DlMB4Nzo9iNmWuntZZ8RJ2gk+BzeEELM+xvYHACPAB9Uu52wY9JU2D1bfbVhYrpI81UVr8/J4elj4S6q9A/GRzQ15BEaTKfbc9X36Y8lmiT0pgBN6xjgKkrVRkHAzsWiswcHDAvf/SBfOk8PiUbJ+hIDar/VWvEBMcbyhaQNNNhuCM2EW7c+VL8pccME75vF0eQGQBTJsbz+0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620693446; bh=7QyMiJLb0InDhEDqzlXWCnI432T1MQ2c8uFzPXx1/71=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=KETLGbQfn4MjKhmSwR0WXOJsTQe0gQ1tWUFQq/ZMl7DqccXNqwao3yT5sq35Ujg0NwEE+PFgpEW5VeXrx6pJ2Jocce2QfiVZfF6B8HgHMzYKze4EP5vrXHKrpOeTNULFfuQg8B0uvItuPUcnY/sZ4vT7CqhWYQ7koOZyDvMpmIpuLj5xQyyzoZ0lS5MuvLd5zth/VG3L0KhKbl7qvlQCmBRv7sMe2QWIQVY96q+R7m/27kTqslmZZveAIjWG8EicWhfgliNjccAaIhWpU+GghD00h3gczaE6Fve6TcUB52POGk1lBjtp+sp/vHEzmBy07SGEFn4BsCXOGnnUJmdCew==
X-YMail-OSG: .RH6drsVM1kH4x1ugPUwqHXSrlEesu.M_rPDRULOh71Zh2v.2rT_zPKhvvlWj5G
 oQwP4m14pewg23VlYGo6F2HJugviucA89rUXB6wrQDFmdQFUHtqIlMAglxdVpGjPYVSW8GZjESH.
 lfYzo0VD1XDdgRI30SrBH2xn5rorHpWUd8E7wf0jgRoye.apRZfWHmiDKyRXc7OEes1m7oTmTclp
 hRimXuFTV1WDcBibNad9aPDdqDbQcvVlzho_XDeEsoDte0kZsm9IX0hnO1bYA1lp16lB5WI2wwtL
 7Jv7cfX.HpQjPGCAmy5poS2Ep5DVlDYWrRIqQ4RAiDoEHpEFLPi04VNdJxX_WN4jiUmGoWeQZKkh
 QeiJZvbpsoLFfk.H3pS1SL4O.V9ZDlZuuzOxZEhe7EpEaVjEXEz3Ih6vj2P1aTDqFP4VldFHHXkb
 6JMZ.x.DKEvgTUuNwxGlfg9vLcoQYrrIa5PwsYXdSuPBj3rLgXCd38uIx_iFIq_fI69_qqnsRRiF
 .83qEMl2BAWEmr8wRwaJcmuFs8O0eKtbJ5qal90Qsk2s1c2kwjD7t7ziRqPAhyrNOEHummfe4Dm4
 V7j9UUOJ9k6aFBLgvhElhdnhcDdsREk_H4FRHRtdBPpjs1W6iKuus2f7ExiVz6aAmuxWy7meWHbt
 Yhv1OemlFEW3GlMNLziUVlP2E7XJQvfgBghfPSuv2uAReAy_6gOvUrBu3cR54k3YkpixthL8CPDa
 mIIeu6JBxGsJh8Tyd8OPnm60dW3NJ9kXxw1cGwlY7GReQIUeAu.mgULWMCiD.brhO8jIfUbvobeg
 TPpB__m2p9j8XcJ5Plz5zbaoLEFIpUArd1JtNritvbPIGT5uPu5EWxuF4J3USUPucfvKGCvL8nQC
 FHkqY4Pes8qE7DBWyXbGRYToSYbt6bR00dNor7K7c4yXDD_8UQMctbugwpHpSOcDY8e.DEuiqbnj
 kG2gXqNAN6Sc3oKJ_D7NTaPa4Qn388IWOzeAqVtISvasqzpau.K41JcBxxCGTTdqIU1IUgXbP6sP
 3yqpvVQpCSAJIkecStVLRmhF4bUK8CRIlTkQM4jLGbQt0YfmudL31XkeYNCP8NvzBRvk.PEtdEtt
 T8GQ2.cJwFjhyDXv54Aq1cqMz4H8aOYk4pQUcwkCnYB3Eza6ZFTFf4pqUZQutHcb02o.gt6NLE_s
 tYRctt_woUW8wYOokeOUfReJgHV.X46DUEVMINsQjlLBSjZ2SMxzXH3amVH5_vwnsFjQwL2oSg_E
 qbsSFENpOMs6c3bSpvvy2dBI9pIVj1eF9Nu0..YpJSt3FV7AhDFB6FBVo6ppkLQUaSmup1HK7THT
 uPThxMCUQfK.8GS4h8frWbaxsEpAdrtDX_6ehR.FNe_KEJDK0mxxLrCIgPEOXcluuzTTtAQDmVM4
 NrwSJTe73n14uKCIFRZgEMaaioPfM6GFPF2qamVcajNBripRleehdt526fDyC_5virjmthCo3jld
 tBmchdtNBXG1_nNKW7fGNhQdmpykuNK98qZvOwYXZaXJR_jnu7M51CAuQdKd0EGz7eRFTtXoyKcS
 PJFdQrURUoTCsR0R2pYdya8XzKUDWSIgrcEzUqEjU4GZQl0WcWIBdxwXiYqX_hl8jXui994BdiKL
 KdL2.UNMIH3WjczGAMvdpsLIrfasMvmmmdkb2sUtCUioU46Ut1s7aij_dCHsHt.ses7KKZ_ZPt5f
 _KdRUll9XlCbteRmDFn44.UQw3Ci.zIdD0DfBvLvHS5vwlsZjTgpbPlBcrvu_8IkZ0OYQ3Dur5qb
 o2xNVKW3khVTRGkpkTamf3NTg3CVpsfSycnUbHogxrcXXbwyFkThle3Ccfrp2Y7.eqzyVt9E.rMp
 ld__EY2SWpOjgNlI9IMMrRYx.nsaA0uTGk0Ih.dHfUGHLzkgtLv6mxbpH9OW2zKnJt5dIFDLL4g9
 rnLN9Mv861I0xUD83L3KM14Zd2GrUsq9Bl0t1Vky8XjeeieYcTEa2TFqzc37hCjpaJE_UoM8z_TR
 vZZ6ZbwB1faT2iyU_qgLAwoIOonFIyJoZxVU3FC1d9XZL9JFa54AGKP6xvSWuhwCxfTpzEvjeAVT
 mAlNhQuWT22Xqu7xizKzVvDhgb.rWe1Ksc1PBx3MBNg50lma1Hx6Ygn82gYMzqEZ856y57WAndvz
 R1NHho9PaZjc_uWtv0XJrfOBK8QKCCY73wb2AiJ9ALWCvNFxkpSKX_JEKDVrFI4taIPdR50H7hyH
 hF2TkfoaP8Ot_MOxCRqPgP2n3hVQPtqxLmlge6fDyc0BZI9dqXQ4CMfAGYVCY4Aujf4S7YkzBKQd
 9OzVgxejtF3.bXO_Wt3pEvIcWYuUHcflzr0Vi5masV8XuR6myZBJNoJQd41po5v1AqMfcn2w8s81
 7Pj5KFyH1.nCgV4.cllMCej0NPQ3LgcutQWqfD9V4ruRr6pS03a4Ug2hA3PAG1mSKuZHfz0cRxIN
 C4X1Bgdt8AIMeAT2xrwHK3AhDJzZRif9hgoJZGxscZmuOQU9rsUZFejZoyLIXXWTMNsEVc.Z1Rmm
 OQOZkAL5R5wK4ZrTS.LP93Fr8CNtkNRDY_k8nv4Sl3E_4a6OmrCztEJv4u2D6oFx_y6I7imNmsFZ
 gU_a00dgh3iohwg6FhBa.4BJgXVuh0h6u7xd24SncZ5gkuCNyW3XLhM0EwIECrYR6RgQSnTErMwx
 O7jxFmmGNXnpOtyX1wdPSYMvxt7aTGqo4LN75lNP_OuRIBDgUFtWZySx4npK7rbjK1NpAEUGCoya
 AO7lCUlF798ypuDR5aUIF8cWq5HVNZnDAnumdc.7OcymhmFpiOayr8MhFk8_5REWyxkJK8DYVdSZ
 RvRVLvFE32s3Ha6vpMECTGcK19UJb5ek6TrxU3VjpFlbrAOV9JJRjAxQC2Tb3ngroiF4S2nFIrC.
 b6K8vgHI0wwKMdiOGVBsWWhq_JmjqJaWWZqa.mONCCCL.B2UmtJPlFYjb4XVTBoC5nHO._rSaSUv
 TW9uFdMHpyQMAaUvw71fo5nClMTpgE_Fo0sExMUD9ngT1drNXAY8824Gzh_Y9rSqVdrNeLytjmtv
 txrbb7D.ZtprNyA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 May 2021 00:37:26 +0000
Received: by kubenode568.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 753037fa619a7dc4ecf1ea9886ed825c;
          Tue, 11 May 2021 00:37:20 +0000 (UTC)
Subject: Re: [PATCH V1] audit: log xattr args not covered by syscall record
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com>
 <7ee601c2-4009-b354-1899-3c8f582bf6ae@schaufler-ca.com>
 <20210508015443.GA447005@madcap2.tricolour.ca>
 <242f107a-3b74-c1c2-abd6-b3f369170023@schaufler-ca.com>
 <CAHC9VhQdV93G5N_BKsxuDCtFbm9-xvAkve02t5sGOi9Mam2Wtg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <195ac224-00fa-b1be-40c8-97e823796262@schaufler-ca.com>
Date:   Mon, 10 May 2021 17:37:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQdV93G5N_BKsxuDCtFbm9-xvAkve02t5sGOi9Mam2Wtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18295 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/2021 4:52 PM, Paul Moore wrote:
> On Mon, May 10, 2021 at 12:30 PM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>> On 5/7/2021 6:54 PM, Richard Guy Briggs wrote:
>>> On 2021-05-07 14:03, Casey Schaufler wrote:
>>>> On 5/7/2021 12:55 PM, Richard Guy Briggs wrote:
>>>>> The *setxattr syscalls take 5 arguments.  The SYSCALL record only l=
ists
>>>>> four arguments and only lists pointers of string values.  The xattr=
 name
>>>>> string, value string and flags (5th arg) are needed by audit given =
the
>>>>> syscall's main purpose.
>>>>>
>>>>> Add the auxiliary record AUDIT_XATTR (1336) to record the details n=
ot
>>>>> available in the SYSCALL record including the name string, value st=
ring
>>>>> and flags.
>>>>>
>>>>> Notes about field names:
>>>>> - name is too generic, use xattr precedent from ima
>>>>> - val is already generic value field name
>>>>> - flags used by mmap, xflags new name
>>>>>
>>>>> Sample event with new record:
>>>>> type=3DPROCTITLE msg=3Daudit(05/07/2021 12:58:42.176:189) : proctit=
le=3Dfilecap /tmp/ls dac_override
>>>>> type=3DPATH msg=3Daudit(05/07/2021 12:58:42.176:189) : item=3D0 nam=
e=3D(null) inode=3D25 dev=3D00:1e mode=3Dfile,755 ouid=3Droot ogid=3Droot=
 rdev=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DNORMAL=
 cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
>>>>> type=3DCWD msg=3Daudit(05/07/2021 12:58:42.176:189) : cwd=3D/root
>>>>> type=3DXATTR msg=3Daudit(05/07/2021 12:58:42.176:189) : xattr=3D"se=
curity.capability" val=3D01 xflags=3D0x0
>>>> Would it be sensible to break out the namespace from the attribute?
>>>>
>>>>      attrspace=3D"security" attrname=3D"capability"
>>> Do xattrs always follow this nomenclature?  Or only the ones we care
>>> about?
>> Xattrs always have a namespace (man 7 xattr) of "user", "trusted",
>> "system" or "security". It's possible that additional namespaces will
>> be created in the future, although it seems unlikely given that only
>> "security" is widely used today.
> Why should audit care about separating the name into two distinct
> fields, e.g. "attrspace" and "attrname", instead of just a single
> "xattr" field with a value that follows the "namespace.attribute"
> format that is commonly seen by userspace?

I asked if it would be sensible. I don't much care myself.

>>>> Why isn't val=3D quoted?
>>> Good question.  I guessed it should have been since it used
>>> audit_log_untrustedstring(), but even the raw output is unquoted unle=
ss
>>> it was converted by auditd to unquoted before being stored to disk du=
e
>>> to nothing offensive found in it since audit_log_n_string() does add
>>> quotes.  (hmmm, bit of a run-on sentence there...)
>>>
>>>> The attribute value can be a .jpg or worse. I could even see it bein=
g an eBPF
>>>> program (although That Would Be Wrong) so including it in an audit r=
ecord could
>>>> be a bit of a problem.
>>> In these cases it would almost certainly get caught by the control
>>> character test audit_string_contains_control() in
>>> audit_log_n_untrustedstring() called from audit_log_untrustedstring()=

>>> and deliver it as hex.
>> In that case I'm more concerned with the potential size than with
>> quoting. One of original use cases proposed for xattrs (back in the
>> SGI Irix days) was to attach a bitmap to be used as the icon in file
>> browsers as an xattr. Another was to attach the build instructions
>> and source used to create a binary. None of that is information you'd
>> want to see in a audit record. On the other hand, if the xattr was an
>> eBPF program used to make access control decisions, you would want at
>> least a reference to it in the audit record.
> It would be interesting to see how this code would handle arbitrarily
> large xattr values, or at the very least large enough values to blow
> up the audit record size.
>
> As pointed out elsewhere in this thread, and brought up again above
> (albeit indirectly), I'm guessing we don't really care about *all*
> xattrs, just the "special" xattrs that are security relevant, in which
> case I think we need to reconsider how we collect this data.

Right. And you can't know in advance which xattrs are relevant in the
face of "security=3D". We might want something like

	bool security_auditable_attribute(struct xattr *xattr)

which returns true if the passed xattr is one that an LSM in the stack
considers relevant. Much like security_ismaclabel(). I don't think that
we can just reuse security_ismaclabel() because there are xattrs that
are security relevant but are not MAC labels. SMACK64TRANSMUTE is one.
File capability sets are another. I also suggest passing the struct xattr=

rather than the name because it seems reasonable that an LSM might
consider "user.execbyroot=3Dnever" relevant while "user.execbyroot=3Dposs=
ible"
isn't.

> I think it would also be very good to see what requirements may be
> driving this work.  Is it purely a "gee, this seems important" or is
> it a hard requirement in a security certification for example.
>

