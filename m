Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FEA37A854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhEKOBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 10:01:20 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:36837
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231461AbhEKOBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 10:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620741613; bh=0R//I1tvJ1cLHdd+0c9JgdUEI9Yb6smjrXlKEpySuVI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=Iym+bvEmNbqe9yHArpxKzvHOjg4RILB3vcYpVR9ARHF5oTXk4dsAyAoGsqk9WuaZzz2/F0GrH3qkqKLMZ6+qH8SMrEG9HkurqmqxF8Wt2bTw+iJnEXth2s15eHYWz3jIEYMKKzn2E4GJhGaJOiIgEZXX/RixzbwWRAIFrzak48ZjOAX4ODn74qFBEIEF/m6uPimxYOr+fCvlfreHBGIxotTNs79q/bSy34JlZJKxCmNeN2LjKaeYMn6Ju2181TbcQDGs+YcQvvtkZn5EUaZOrm+kw6aKme+fJiGAh7CN9aRO2nlumnscv+wOUVNquSssloRmmhkryCk+w3jk3Zx3Hg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620741613; bh=s10v0WOu1hCa/oNyH+P7KsgHl2wLYaPVqSn4h6WlbRP=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=gQHPKkR4YXmuJVd/83KyWg/w8Pr6yaZKWP+jy7WU7FZLbZUUiiSTnDuQ4KVG+IUwo7KI/vV+2+IAHtoyFJtoeE8QmPJrigAd8cS69hrlGFtW5wYnbVDRNMaqKh/6GC+oFGQqSoYd+1B/0k4PpEDcf0jWPA5lKpUFppiRBUnRZR2V+mcZu/gMdY2Kpb28SJ7u3BkZY3eiWcNx68KGHQbfEf6pbpVHOWdkVjgHAxxvfaCKp5asXsM0tVctdc3uDZdAFgVIrLGNqArlAzGL0/bo8ho86M2jmEC6SIdu5N+2YRlUJegaUx8h4VCcP1Umh1jdnSPQRKnepTIzzem4S63/DQ==
X-YMail-OSG: 02W7dS0VM1nJXyIquqfeO0QTOEYK.bPY8kEWE3Yt7QqHdsq0HUfqjkWduI.vY08
 t3tOjLWYKpttF.TQS6If_0oko4yjxUPY7ZNngxn.7SnowybBW5VQiyTl6WorSBXAgbYpZJnUwY35
 k35VH7cjxgeiBySV2XOiMH.HE3swYkaJUTRpcLee4fuEOAs3S8tG2q52CO2BUS7iG5_9kwjHBmri
 JQ2WDZOxy.zs5.HXedo5qYMI7NZfeBDHkKSv_cjTDTvIeJ30IuCvcAwaLM3chie.3VV5ZvTkyWBc
 zhQdVnH5PNnmXOh3Woi811iX5SEZjAULtHxMQIHKXmd51ysAhdYlB6mA3EEDBxT37YHYyWx4PI7x
 CV.NdsKDfVrZYsW5_n9f.7VHNFdin9z1PU4ZW_PO5mf3uwu6wHMuVxjLzDsbivmVkBDL_D.fEHBJ
 flZAf64mnus1fXFugxdGMNXtkJQWk7..PoFTPsdd4Y3Tgc7EN1GJwRCJOG6pWruPfX3LpGkdoILe
 ro2p6SK2oNp49vLh5NhluwkxyDQA70lxo1FRK3Bx8YIlXCCgpsR7.JXi2FbYhbXoYCbJqKEoJzko
 c8NnZX8SYMbA_DTKhWKtm9s_0uDj668FYnhuT3Xzw9N_ARXa8C_SA9qAZ12_.8ZRH9TsHHxMhJ0a
 9CLtJPyPYaOYR84mQZgvumcP3KFq5bop0t9rY9ZAQMqdwmKYMFIjSyvkF_n2zglfZbYplHEUxOOM
 WT.S35E_APfcHo9fN47wMNBP4t7JkZCVNoqbxlCMiIZ0ma6zo7BLGpNzRO78SbJ4pdOJ._VwAOmR
 eALOfHC5cjN0Y3qjj7dmiOUMyYU0e5JvOy2yRyXfRCMhcMK0jL3YX_H7Us.oDvMhV3KJdRJ1xj3Y
 l3qnQ_R7paq6geg529Bcllf2iCTZQ9UBfqb1KBZgwqs70Xz7Rp3WggDZ6w7xGTmXr.7AlYAoJfby
 76zYsEBiD.84genAcMk5.B9dWgRcbMIWupl0lDviP4TI1WlUdO3KuVqQXbFrl9IoYdGA7AHhhgL3
 osAEinhGhRckY.x22FFIf2An9hqj0AdYX4mM.Tql6Y_g7wvrmkLXQF9zbcYmDf6HJUH51BEEZNyv
 8sxHEntkZvOUWFp4nFt.zSCicWXd658pSJaNE_p_FhDCU2HuBOYhu_XI52FWsVGNjAZk4xeQBh87
 VpkPQI6WYQCnJHQQlQ8Lgp5gOeriFP6_wvj.7t60.1W11Cdt2N1yX1dQ4uT0IBQC9iTulUP6jzTo
 I6ek5q_IMC0NxB5_55TlesCpacwEgERqApn7d9SBtKapgVT_ESpkh7wanDVI3pL._2P7C5q.W_5o
 JeW3pz7SCydKhrNnnsoF89Yz_uZQPLW6sM_GvSW6lNMSDOUc6LqwRplXaV5nXD88rasi1zQfhhBK
 aRQDf0ysmj.7isXoTL6IKc60.CTDcviu6AX6jVotCHi2Qy3EWUy3TO3jd3FqqnafxlWm2lRrOwye
 uR9GhQ_lNYLEoUPMar7QYDaIabHEpIUwgPbzmIVKACYOUo7.rCfaOVxxjviICNxCHU1i22FlAUuh
 4HqYTCG4QZJJo0qF4D0mrcwmIFEgiUZcOwPvL1OA_6sN9AMVuWRjHBl9Bofd5cePJ_ImlJzRW2TJ
 G_9I0ePC.DfqJ7kCeQDyScRyQVumbEdFQbaqCSB_gNHNaknyKxSauCNDGfzIbg7T9H6.d80P1E.q
 88_cGN8Mw6XhoFhRoRdU93tWY12cOYs4D9Gw843bwuI6ARjJvVBZ.qn9YBgScTxgnUQ1hbXR45qH
 W3vueCND0cqYIrdvvqX4cqtDqZuu5DxuI71SlpEPN5d_PQG.7sH9OVqj2kxr9VrnDxK3L.Z.1sqS
 qbrF4obFVYdl6BQ9U4M01Bb3RTeTGnt5UEX9vc7q2VD271wPf30eIoMkQd1ZibUvx_KRAaGhOs.F
 1Coe9xjTNsZmc1MBcpWc39jtuxGSMF1WCyWUAhO6orlhd2DON0I0IHjIlmRRKSEJWksZQKThel8I
 GEzcAi9E1xiVQxjFLyLja.O0xBkPdtPpmPTaeHfOCOO1VqVZRvKUlwHA4AXdSIsqxwqtnBxqOwAF
 BQCT8JgUb1VsX.qV_bNF3nkVdlxmueWqdobbOx2TG2i6NiXM02g.EJ08LZ9qM9M8PoLZNL3wYVdD
 PWt2nqMDDjESJpOTUcIxq2XzWhIVeRqsTK5MD8G8Mjb7xDdmVtkPk6vMsdpV9kYI8Ck94xyLIRv0
 wSgENKHyzHPvm7pq6M3UaDrcBk5mTM38exms7Z1K1l2grIOCB4KI.dy0OkAWpo4pyImoJxzjtELf
 thG4IVrfV7oOMadrtG4P9tb8IgrRMXKg_YwDTqGKhPQO.f8dctf8lgnFuwVmdUYmFp3evGROc_tD
 Gk.Ce71Yi_XMjaMipEuy89jMoOjgDwK6_lz_5IIJjdiYuQnF7xZeictV1mFIA330n.e0wdnNOLVR
 6gCdOUsYZO0pHx40PGwY0OloprOa6ZIqc6iFWUDLrIchfw2wT0tAHSN4kR4bkMBPiAji2JnRxdio
 Ai1DjdKBgT7NX5a0kIGXJjTvFZV1ZKzFGsAuMzzW_rt6IDqzOJNCHs4vufWHxwtr0fFqoBRkxEGn
 HWKUkvWqJB9ps7_HBC1zEpwAyrf6iLFGX8uMooowXU0d4M0ZB5QFoSjUtLeijji9s.aASQ0lWdNU
 a6jvlJsVScFrk2ByC13AZJkwGCjyMb0NqPqlUJIHkG1glRhUmXgxbQLw58S67ZkV5Zrjv.NabvOs
 hVnbUWcfoEndXSo2u5xQMvg.vfQfN5NtrHERQATfKJP.q8jjcBxPNqKQSlVNqwSzq6r7VRurLHTm
 hFjG45C3vknowJQSeT_mXv3RxQTXz11HX3gNucw4vxiXzFyneCX7aOwGTrKM5eYX7rtt_0x4BeS8
 SGARKeDQ0BwRNk5Hc2CA857P3b.GPJ0KjALFezHFIu4RnjBEwHeoueCONdLjf2SWpFhdC1vnKGkk
 G4bQVxphjxVKM1Rpt9Cnvb.oj6Lgg9qnGDgxDdAx5whICrCpss3B0yb7w9UNs8F_gObehLisiIEF
 zQwH_us8vytj_
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 May 2021 14:00:13 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 764dfada18601506adeb3c506bf324f0;
          Tue, 11 May 2021 14:00:08 +0000 (UTC)
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
 <195ac224-00fa-b1be-40c8-97e823796262@schaufler-ca.com>
 <CAHC9VhTPQ-LoqUYJ4HGsFF-sAXR+mYqGga7TxRZOG7BUD-55FQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cf7de129-b801-3f0c-64d6-c58d61fd4c84@schaufler-ca.com>
Date:   Tue, 11 May 2021 07:00:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTPQ-LoqUYJ4HGsFF-sAXR+mYqGga7TxRZOG7BUD-55FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18295 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/2021 6:28 PM, Paul Moore wrote:
> On Mon, May 10, 2021 at 8:37 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 5/10/2021 4:52 PM, Paul Moore wrote:
>>> On Mon, May 10, 2021 at 12:30 PM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>>>> On 5/7/2021 6:54 PM, Richard Guy Briggs wrote:
>>>>> On 2021-05-07 14:03, Casey Schaufler wrote:
>>>>>> On 5/7/2021 12:55 PM, Richard Guy Briggs wrote:
>>>>>>> The *setxattr syscalls take 5 arguments.  The SYSCALL record only=
 lists
>>>>>>> four arguments and only lists pointers of string values.  The xat=
tr name
>>>>>>> string, value string and flags (5th arg) are needed by audit give=
n the
>>>>>>> syscall's main purpose.
>>>>>>>
>>>>>>> Add the auxiliary record AUDIT_XATTR (1336) to record the details=
 not
>>>>>>> available in the SYSCALL record including the name string, value =
string
>>>>>>> and flags.
>>>>>>>
>>>>>>> Notes about field names:
>>>>>>> - name is too generic, use xattr precedent from ima
>>>>>>> - val is already generic value field name
>>>>>>> - flags used by mmap, xflags new name
>>>>>>>
>>>>>>> Sample event with new record:
>>>>>>> type=3DPROCTITLE msg=3Daudit(05/07/2021 12:58:42.176:189) : proct=
itle=3Dfilecap /tmp/ls dac_override
>>>>>>> type=3DPATH msg=3Daudit(05/07/2021 12:58:42.176:189) : item=3D0 n=
ame=3D(null) inode=3D25 dev=3D00:1e mode=3Dfile,755 ouid=3Droot ogid=3Dro=
ot rdev=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DNORM=
AL cap_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
>>>>>>> type=3DCWD msg=3Daudit(05/07/2021 12:58:42.176:189) : cwd=3D/root=

>>>>>>> type=3DXATTR msg=3Daudit(05/07/2021 12:58:42.176:189) : xattr=3D"=
security.capability" val=3D01 xflags=3D0x0
>>>>>> Would it be sensible to break out the namespace from the attribute=
?
>>>>>>
>>>>>>      attrspace=3D"security" attrname=3D"capability"
>>>>> Do xattrs always follow this nomenclature?  Or only the ones we car=
e
>>>>> about?
>>>> Xattrs always have a namespace (man 7 xattr) of "user", "trusted",
>>>> "system" or "security". It's possible that additional namespaces wil=
l
>>>> be created in the future, although it seems unlikely given that only=

>>>> "security" is widely used today.
>>> Why should audit care about separating the name into two distinct
>>> fields, e.g. "attrspace" and "attrname", instead of just a single
>>> "xattr" field with a value that follows the "namespace.attribute"
>>> format that is commonly seen by userspace?
>> I asked if it would be sensible. I don't much care myself.
> I was *asking* a question - why would we want separate fields?  I
> guess I thought there might be some reason for asking if it was
> sensible; if not, I think I'd rather see it as a single field.

I thought that it might make searching records easier, but I'm
not the expert on that. One might filter on attrspace=3Dsecurity then
look at the attrname values. But that bikeshed can be either color.

>>>>>> Why isn't val=3D quoted?
>>>>> Good question.  I guessed it should have been since it used
>>>>> audit_log_untrustedstring(), but even the raw output is unquoted un=
less
>>>>> it was converted by auditd to unquoted before being stored to disk =
due
>>>>> to nothing offensive found in it since audit_log_n_string() does ad=
d
>>>>> quotes.  (hmmm, bit of a run-on sentence there...)
>>>>>
>>>>>> The attribute value can be a .jpg or worse. I could even see it be=
ing an eBPF
>>>>>> program (although That Would Be Wrong) so including it in an audit=
 record could
>>>>>> be a bit of a problem.
>>>>> In these cases it would almost certainly get caught by the control
>>>>> character test audit_string_contains_control() in
>>>>> audit_log_n_untrustedstring() called from audit_log_untrustedstring=
()
>>>>> and deliver it as hex.
>>>> In that case I'm more concerned with the potential size than with
>>>> quoting. One of original use cases proposed for xattrs (back in the
>>>> SGI Irix days) was to attach a bitmap to be used as the icon in file=

>>>> browsers as an xattr. Another was to attach the build instructions
>>>> and source used to create a binary. None of that is information you'=
d
>>>> want to see in a audit record. On the other hand, if the xattr was a=
n
>>>> eBPF program used to make access control decisions, you would want a=
t
>>>> least a reference to it in the audit record.
>>> It would be interesting to see how this code would handle arbitrarily=

>>> large xattr values, or at the very least large enough values to blow
>>> up the audit record size.
>>>
>>> As pointed out elsewhere in this thread, and brought up again above
>>> (albeit indirectly), I'm guessing we don't really care about *all*
>>> xattrs, just the "special" xattrs that are security relevant, in whic=
h
>>> case I think we need to reconsider how we collect this data.
>> Right. And you can't know in advance which xattrs are relevant in the
>> face of "security=3D". We might want something like
>>
>>         bool security_auditable_attribute(struct xattr *xattr)
>>
>> which returns true if the passed xattr is one that an LSM in the stack=

>> considers relevant. Much like security_ismaclabel(). I don't think tha=
t
>> we can just reuse security_ismaclabel() because there are xattrs that
>> are security relevant but are not MAC labels. SMACK64TRANSMUTE is one.=

>> File capability sets are another. I also suggest passing the struct xa=
ttr
>> rather than the name because it seems reasonable that an LSM might
>> consider "user.execbyroot=3Dnever" relevant while "user.execbyroot=3Dp=
ossible"
>> isn't.
> Perhaps instead of having the audit code call into the LSM to
> determine if an xattr is worth recording in the audit event, we leave
> it to the LSMs themselves to add a record to the event?

That would be even better. The LSM has all the information it needs.
No reason to add infrastructure.
=C2=A0


