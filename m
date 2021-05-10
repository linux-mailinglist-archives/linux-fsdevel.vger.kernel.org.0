Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0473C3793C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhEJQbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 12:31:20 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:35858
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhEJQbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 12:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620664214; bh=Qnr7UaxNwgBN8zCF0aSY64LXuyV9v0jWvo+4oz7Knfo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=qJh6FW6BNrTPeQPyzefjNnP5oUCmZBx63yjxVSjVflVy7jcDn+l2OWEDbBP+plP6GvM0BY12EzgiCqm7/kZVO+zZIWadf4hH9AxTy3okiv7ee+iNsf62dckkztRsKuYjjgw8Fkev0gLZRdcmsKQ6R5Eipct+m+LtMRVyfVf8jmMA4DgPkmqQttYrKdVbg6E+pyzqViNRMO96SJN58FQT6jCpqFCQo7nIekthSCO4sFWKYD5EUL6/B+kAmmL6qHeXiQdlkPYKTwOBL6RidIUxs5g4/Gj/jwClsWe9kM8bd/IKCPF8+SFOOMVRP5oQop8W0tb2fv+JuksWlYL9iItIWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620664214; bh=gPoyhAH6LtbVkE5+cfOjJL5Wm6boqQ8zti/FEFR1+aN=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=qs61NUKKkG0uonqyciafIw02roFz1xGzn9/b52y3U1sjmhUC2pN3NFOBrvAB6Uq1IIjr27g5tRoTQAdsh3gaJsW6Lq5/K7aXtCkJpV9psqGCVg55ueTh7nZV9W0d37hxkSxmsV8yCEe18m34V8KtesklDrZhuOCahQkGNX0j2hjFsu5mECQc9QLjVTQzuyyaLMbPWIY9NBKiAB5Lv8a7MubMxM2A1ROFbkM6yduNIJDeX2SubLll1G9J1DSubgilLO3MKf3Oi9OZTDZCL514T8hCR8+IsIfLKdlHVllMUCGLy26aqIW3mUhK2CUQi63r3F2xsMke4/LS36vgJzCYyQ==
X-YMail-OSG: k_XmSpAVM1nYGVCGP4zmK11WKHweErHA_T7o2U9Hq27YnKu1HyvZpf07vd2FLIY
 VRQSXubHFlJ_HZqKR4DcVOrSVl9f59EwgQ1JT3zt3OP7y1H4J6Zy8DVqaKDFleKpmx7_um4gzPWd
 SRps6o9hXwh4MzleUVDKxpS9xNrZqtURLrNIBOmn9_xlJMho_PTMISFotAmlhjhD56if8kfndu4.
 VAmcz73ha0KtZuzCxhR6SEyB0G06mOMpJScFS3iGkSpeYFuwidoKapWPvs5H23xBE5.g9NAOMFSW
 RxaWdJXsB0e9K_kUgr0r2PItthWluL1WhYNzfRwKlwV1XK4Aib_EHUH7Vf211QfKpBy6RPDAx2Py
 5CcKGzJHjm6holsELpQM5k26ekGEfz6IvqlUgIeZ68dfIxVelsPbeD8pRHUL_z6ZTsxXDbL0o8eR
 Z222e7pnhw2f4XyGo5OLtE269WXY_P0Y6Q7l0Kajw9cEgSpKjOZxbpK1nzx8xZV4xLinZeCNbuQl
 HMV9fdC4fqZUYFfZnCrvtUu1BmIZTQMuZleoBINpwAIZQVaD4RuWDrl4EzWH9.djhrb8Sq.XMee9
 8O7sph0xZtR2eovcFbq5zHp1UwVgXi24Xv7iUpk0c5zEuSOhA0qXY8s7IWGrfHs_NeOez.UjLdMx
 pRvtmLpx8oMYIaqlscdLgIR9wsSYDdDwbDNbR42vQqUcSsYdCrddnl4YrzYSA86igbrLFhpfMsaf
 5muQVJULqSSkyh7TuBh.rKLyFCH_fXVRHS5sddNN8j7rvJ9.CBRqrR.2M3.c78I2n3DzdwEtlP20
 cvWwn.UtsyaEsRpheW0JkAhdcu87L9Lam3fBsiTN_2gr3JVEQLpu5jia8O0j0zz4CU7gLeuUHIZA
 J_w0MCroL6g8nIklQ.jAzt0pS9mZ.pyjGEg3vVjihGL0m0gR59jzmTLUyt4vcBVIFsi0aJZgVPTQ
 gCRqoTrPk_BOspGg28BUPhfj4mUvMOMWfnygzdNdDXsmZWzSLfv1LXBR57MIMDqINxb1dZYDiP1g
 vjz8qf0DrlXfw8B_P7Z5YvglbzXh9kI2.cj6Z41aVsL01rq4V7G1XCvgs5IccEyM0Q8VWIki7l06
 6CpX4PLs9iKQH83JJH9G96PYxFsVZTTG5ZhYBIBABSgsB1YOMACkfPcTaEUI2w_CvwLRnHjXeAUG
 IIPlYjr1JCcD_BC77CQAFlzWsemcuQ0gisVIW8rn9SnRUs8mskL28VWzRlD.RrwmfTDPc.M.e0wz
 AhGLQH93hPMhUoMXYA4FXKbX21DeDuw3fqUg5I5QmoxKEqQlG7a0j2mHpX9nnhkxRdULGgzQqBhw
 jOwt_WeL58O1eRPjzL24c20nU1pk6pHLmkeHaCxAhlwCCI3H_JAodlvzrDz7HJiAN8wVngslUPy2
 MLzR9cUUVdhIm_bEFXuBYQrRwCeOyQkLkAXZ_O65MYgiE1H05.iSmMm.1OUsF1OgYOZg19foYGHd
 .fHqitMkk0_l6RXuYeqUEtjHNXW9nO49b.YMtLmx3xgFq6qMUGYNInZnoNp54T7YFHr9zsK0BpyE
 Mdvp4l5.FZSpBHFYahQf2Kip0SILa_d9KwKfORZhZX6CqxPePLwq5adRB02fv6Y1r87R3.e0RyE9
 KEY_PMqgxzHUVqo8ZanxXfvk1muo9B7LUKk.cClMLkxkUdNKRd48aI4evOj_pPKVY1_F1iT9n1P0
 DA0eQUkDmtccNMdMYie.I44B.g7YjRfkX4Dg4IfdPk9l.E2RINR5LMSEGeOzJcX0AXB8zUsjcScV
 ikf0CBPvqHjPVd9Akebm8He8LqmpUH4DeZFpp_w2_vIMnVvS5uMFhGdLzs.bS2lEens01tkeNOtJ
 WNT6sHdlavbA_i0m6gNpDue1Bb7a_GAfHBeO2dBvk83v5.gDGgtbJMIJLsnwM4KzCDDUZh6N2Uvl
 i2xQRxblxPBoC_d87vue07tN8dpOQhsRKuHG4NFEqGpajGH2wN6z.fTdoKUgr_DjWa0.ZSvQYlDV
 tQpK7Vexi2REqVZTonXDKOre5ZI.ZF3whDnn8oRO2ODacJMEi30WIi0ElDL2Hx3NXp5M51N7oAH8
 jQ7IJXaE53y3vZuhBUjdDbm2wrFmzbCwHdlsKF.LbklHQMhjFxxuGoCNmZLKHKLiWqP9DfL4qBrl
 W9equSmkDMUL5DbCt7TYuWfAFG2JMCDX7ylRL0.k.Sr3S6qz5p_SRN0TuW.rsHbjhIdYvQZO6tX.
 dtHqqs1IbFLsEiq_6EfLaykT.IE1WAhNPZBg.1t3hvyGaxAIMdFaEC_EnVjcI2_5I88nSFD3r2e5
 AxylK7m8QqDoHPAwk7CXiJzy_G9eTjICXXyWDCYTJ3TJxGBlnAg6mP5d4g7VPiQI0A5CIeWcSYbN
 Y0XL08CG2LarHeiTGvd0rMnOis2dyk2zb57pqt3krVlHH9E0DBIG7xJMRaIT78WV5Rxrpf0bpB85
 knFpJVPDy3s2PYn1RiaoPdzXBsZ07G7cO7IWA2ajrlIFDK2oIj4nK7WQxwhqyw0WXJW9.uA_LU0y
 BCpiEnAj1jd7BqP4YOz_ynwiNAnT1UEiwERuUodTxh4a5NBsz9_OeVl0wYwhFkRbggBlaiGzHnWH
 ZNCmhRfU4jPMy_LfCL_g5ieWcNVf9_YxYMeamJUDr9K.QHvuP..BzLUhBjWJYaK7MGWf79kiH9VL
 1ceKV3rr6W4agp8ZG7jcZrPSoP2VdzYQg1HawEyrPB2x2U63smx_kFldYUc6pxibOgXv6jGVc6Ia
 RZTa1fkKGoXRrBrxTpjezdOFBjqqqgTSmCIVeQ08hulLNYRn3Du6LFk3UbFpwxtUOCTu_hg.K1NE
 UJgVWvzRxIPLkhdaWt0v.XjhHLqO8zub16kL5LEZLJUI0grbzQY.TD6sfz9KbdpcoCZf7x1BWB1e
 .xTSqCGt.por_SPKfmw0ESnJFR2NbcSVkwHmCnN8K8BP4.a_b8VktYNugH4vZbfnwI1ZXfDubLQ4
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 10 May 2021 16:30:14 +0000
Received: by kubenode569.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6bb84a3153738347fee81fcfd7060cd1;
          Mon, 10 May 2021 16:30:09 +0000 (UTC)
Subject: Re: [PATCH V1] audit: log xattr args not covered by syscall record
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <604ceafd516b0785fea120f552d6336054d196af.1620414949.git.rgb@redhat.com>
 <7ee601c2-4009-b354-1899-3c8f582bf6ae@schaufler-ca.com>
 <20210508015443.GA447005@madcap2.tricolour.ca>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <242f107a-3b74-c1c2-abd6-b3f369170023@schaufler-ca.com>
Date:   Mon, 10 May 2021 09:30:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210508015443.GA447005@madcap2.tricolour.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18295 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/2021 6:54 PM, Richard Guy Briggs wrote:
> On 2021-05-07 14:03, Casey Schaufler wrote:
>> On 5/7/2021 12:55 PM, Richard Guy Briggs wrote:
>>> The *setxattr syscalls take 5 arguments.  The SYSCALL record only lis=
ts
>>> four arguments and only lists pointers of string values.  The xattr n=
ame
>>> string, value string and flags (5th arg) are needed by audit given th=
e
>>> syscall's main purpose.
>>>
>>> Add the auxiliary record AUDIT_XATTR (1336) to record the details not=

>>> available in the SYSCALL record including the name string, value stri=
ng
>>> and flags.
>>>
>>> Notes about field names:
>>> - name is too generic, use xattr precedent from ima
>>> - val is already generic value field name
>>> - flags used by mmap, xflags new name
>>>
>>> Sample event with new record:
>>> type=3DPROCTITLE msg=3Daudit(05/07/2021 12:58:42.176:189) : proctitle=
=3Dfilecap /tmp/ls dac_override
>>> type=3DPATH msg=3Daudit(05/07/2021 12:58:42.176:189) : item=3D0 name=3D=
(null) inode=3D25 dev=3D00:1e mode=3Dfile,755 ouid=3Droot ogid=3Droot rde=
v=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DNORMAL cap=
_fp=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
>>> type=3DCWD msg=3Daudit(05/07/2021 12:58:42.176:189) : cwd=3D/root
>>> type=3DXATTR msg=3Daudit(05/07/2021 12:58:42.176:189) : xattr=3D"secu=
rity.capability" val=3D01 xflags=3D0x0
>> Would it be sensible to break out the namespace from the attribute?
>>
>> 	attrspace=3D"security" attrname=3D"capability"
> Do xattrs always follow this nomenclature?  Or only the ones we care
> about?

Xattrs always have a namespace (man 7 xattr) of "user", "trusted",
"system" or "security". It's possible that additional namespaces will
be created in the future, although it seems unlikely given that only
"security" is widely used today.

>> Why isn't val=3D quoted?
> Good question.  I guessed it should have been since it used
> audit_log_untrustedstring(), but even the raw output is unquoted unless=

> it was converted by auditd to unquoted before being stored to disk due
> to nothing offensive found in it since audit_log_n_string() does add
> quotes.  (hmmm, bit of a run-on sentence there...)
>
>> The attribute value can be a .jpg or worse. I could even see it being =
an eBPF
>> program (although That Would Be Wrong) so including it in an audit rec=
ord could
>> be a bit of a problem.
> In these cases it would almost certainly get caught by the control
> character test audit_string_contains_control() in
> audit_log_n_untrustedstring() called from audit_log_untrustedstring()
> and deliver it as hex.

In that case I'm more concerned with the potential size than with
quoting. One of original use cases proposed for xattrs (back in the
SGI Irix days) was to attach a bitmap to be used as the icon in file
browsers as an xattr. Another was to attach the build instructions
and source used to create a binary. None of that is information you'd
want to see in a audit record. On the other hand, if the xattr was an
eBPF program used to make access control decisions, you would want at
least a reference to it in the audit record.=20

>> It seems that you might want to leave it up to the LSMs to determine w=
hich xattr
>> values are audited. An SELinux system may want to see "security.selinu=
x" values,
>> but it probably doesn't care about "security.SMACK64TRANSMUTE" values.=

> Are you suggesting that any that don't follow this nomenclature are
> irrelevant or harmless at best and are not worth recording?

Nope. I'm saying that unless an xattr is going to be used for security
related purposes it isn't security relevant and hence shouldn't go in
the audit trail. The "security" namespace indication may not be sufficien=
t
to make that determination, although it's a pretty good indicator today.
As I pointed out, setting an attribute used by Smack on an SELinux system=

is not security relevant.

There is nothing preventing an LSM from using "user" namespace attributes=
=2E
I could imagine a security policy that looks a user supplied attributes
(user.runasroot=3Dnever) and restricts when a program can be used. Thus, =
it
needs to be up to the LSM to decide if an attribute should be audited. We=

have to leave ACLs as an exception, of course, because they don't (and in=

their current form can't) use the LSM infrastructure.

> This sounds like you are thinking about your LSM stacking patchset that=

> issues a new record for each LSM attribute if there is more than one.
> And any system that has multiple LSMs active should be able to indicate=

> all of interest.

There's some of that, but realize that Smack already uses multiple xattrs=
,
none of which are "security.selinux". Logging setting of "security.SMACK6=
4EXEC"
makes sense. Logging "security.MyDogHasNoNose" does not. On the other han=
d,
if Yama decided to start using that attribute you'd have to look for it a=
s well.


