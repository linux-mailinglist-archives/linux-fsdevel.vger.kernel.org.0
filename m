Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C436C998
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhD0Qkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:40:46 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:37313
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237470AbhD0Qkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619541597; bh=/hG4kBpLl3YtPECU5ywNPYbaNUeK38KpmE6UVZYJ1Uw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=FMHOtgpwcYa3WgtSnaElbQnp3ofkWDRH/BArGZ2l9pD5kQm6MCB2ZPbQEiwVGwKaThut/JpdsvFvstojGALJZ3QADd8Y2MqCjEccLGxazJuSOsfscrf5anz1/hisbS3NHtIzfiKroiAvDdSCdXF3tkGYmOTTOQI+1NzZEWE8JXxSKI263rhX+Kyqy2NawQ/FfPqxwNnSFN43FLE7JkTdR2JCAWH7gKzSv9oGnDYM83UKxJXshLxgxmWWkepWAolCcf+i/f+hhtRuY6HQW6mIjTR5VEmLUv37eJcJnfwZKZrf4KDHC4sQ8VaZm0RuRRI3HgA2GyGLxOvVJcgCHJzICQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619541597; bh=AVZP/VfOiEaUXUmWmGoF/DBy2dhpn68pcQmK4HJ8PX5=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=uZ7jVUjBzHZuo0g7lbBm71YmFIgt5HzyqJkLZJqBD33xZLso79Nmq2zXBsih0wb9lye/guJPMQI4fxW7ftouhFyqOuT6/oMf1CWXMLOM1nTcSuo/WJKk+sXVejwu6fm8zWmFsm061oYoKpIQ5AXlMmK8Hc+aHeWOIlPKUKDHjIECbuA+I+CjgYHeFn4lvM641HR65xTE35cqd9tqmaU4lZ5MxyvbPvBr0viHsOgQYX5/Fd0MmeQ6fQjLvI76DyWnLoO/GbVOj6lnnktXQ9hjkuOB2eSjZb1b4FtPSZLHVsPJZboYULaJqfbIsqOm+qFYzU0oiEAySh+rh+qKrxfwSw==
X-YMail-OSG: gpsXKKEVM1kZFLPTkW4rSSuy_0YpAvgRrNmGv7C4hhZ9vBlpeG5vMfqZmkpGEbL
 SBCnZBKYX43nDeXk6FJ7iyoAiuXIu49iY_nEg6C_Ribo3wfDGdI.lm.MyE9_Egpa5tz4.1uZLVnE
 Qaj162L7E6hoNJob18ZfmgFDDXMkaUsBiGVD.SE1dQRgdzAHxuG24bHJu99WSihrAeo2sgwJFTJu
 vKdROSiH2ZRMPrTqT2lRmd8QM2u.jd21LNf1j6BOic44YulPy13eKtY6nTJHBbuwjD1kMokz2ZSU
 2Rn1B6OAgKNxJn4P3r4A2Lp5CKghhanN4_Jsd6nU6uZnjVDU7adAKJXy3VgMt768VBWETFFIWiOg
 fvd.3QRAB5.Gkt4syeUx__3cfj.oEDe_jcsk5JtmGL2ffQSQdF9Fg.0ou4a5OnrSGXiTi5PVoRYV
 A_01lzzs4dDVxVOYgqt.5rPS8ajZr_eHM5Gx1qjK.f19qthpbGEaWx8kRP3P3BPnTf2MTKBdkcgl
 1zBMQflEJT6MmSEPfXFD3BChU17kQduw0Mjp2VQuk8BEHjNYBGb8udoZgk2EyOWZZmP_OoENRb8B
 nQMahJYHEsm6Yx5ItHMd._TCG4XWOsyvqtmupLgR0wiRzBq4lCjeqRYEDkTACJR15YQxuB4tvxOk
 AttEfA7jYgIil4RdO29VzG.zR27j4uQJhFXbW42DjGU_dl1ep5JeOPz0xjhbLdj2CQZZvartMyL7
 WmemlrxpeaUJrQFw6VwjUom8_GHe6nxQ6QmL9_0NGDS7tGu.d20yFsyZimaEMLtQb4dQTX.pTCmh
 loKKwqiA9iMGQhfDu48kzYSSJONhlwQtnO7rZwvkC1gsd3NFtLErlv1AF2nYiSpIRB3XCJaEjtRq
 AWZjMq1r8u6AZppdnbC3h5oniBKtUsmXXqPj1E3GnYJuuD5aI5s7BMl3APoqkaEBxrYWZ944gU0e
 7Q5Mki89uOTbStp9TyI6oY7BfcjlTxYJ1auFuJhGtoXBaczwp._ar73rfM6iQ0zykq_moX3rcbww
 sscUNvkQq_qFsou1SSFLO52yDLlGJIrXG7EWr8uRLd_juxuLJNtYuUuaQs29k3T7Rz0N9_zCVzMb
 s.67NP__dCTULYZ.ldbOm38nR5Nd62fOPrD8KCtDvgOEtV763QKjUF3ElQlBjzfBPvA0zztAzXMp
 QXFMTCQq6DC.S5erufjmnPO_FcxYCiNQqAh6HAPVgsOQiSkBPLAgZnQC4tIOGyZmmxABbpljo0O_
 YUX4ZNAngVQLDchZXSMQRlNK6AOXglqkxHPiVBGzLztKNkO7rkypAP2v73F525xejfTgvvnwS.sn
 D6f2OPR7E4XMT4BmQIfogxLcpar7cicD7RSc1_VEZAiFHTsnlfPZ_GS7Z1w.sSna.ChSaBxqtP4a
 T0iBPY4t9DrCr08VcdaKa6Gju9rlbcbY3sSznJJzh1.vy8vHvWNQN1aSJqwSMZRr7QZdGF72jLqk
 Tau38NOjJczy4ww_DPTksIuwlRBrLqR0dG0hKheHngdxReMPbtMjSMWJkYSLrBAUFq_wwIwKr74Y
 FM9Sp.EmedmcQYftsz2jzmDbV6Rj1l66zn9RaVb_hbX4DUmdrDlKElj0XEOA1e.CTChvtbCydT.9
 0GjoDIEKQXiqHGdTVP8Olr_StJI7NmXbV_zZI5cV5YDD5CA.jNnG9U9CmVEYTQPGeMsa4ay9Yr1_
 jXKFDfEYv6OSlZFHytYID4uIV_GaAPcXRZwyGCtPKZ.MBS4mpyqVi2TfM3uW_tTb6iTeAYgRQZji
 jmiLJFcW0MCKuCz8uobqvvNA5JMCC3kFL9iKyqip5Oa3BphNEAWMi3Wd0fcW_6qRKYyZY.MIYKbx
 miz691V6rhNByQJwTu6gPIFvfeDRkrfrp_9UScS.8NkiiRLFzLK8EF9cJaB5yCi41_1YahaAvXzx
 vxyT69LuRFs6dgyzLpqLOyxkJBGDb3PkpKqeJsk7EtmcGZcgfGfkDutD1bgwdgE4OOjPHy7qj2M5
 F5tr6SN4C24k.y3fGmX7TTkMGFB2ah03HnT4sA0dYfuDdeTby.6pbJdmAAmnG3Y0PPPbGplb44DM
 FMVlWH2BwyXE96PIPG0x7I5tN2SAQ5K_LUDOa_ympF5VbBvMc2xeY7SBfaij3PKvnxWWeToX1QJC
 fiPWgES8PkmXzHOOZ7DDsKOYFc8SnGsVjs8APn4gDu5VIVJCikxIdjCPYDpJVwVTPeewSTogduFC
 Png8lexL02lopAy4ku6WVKD81qh2OG_mhgMYkhkQ3JSd7NoGlickUhitUouZ4vRoYQaZekuk7DUN
 XoJW6ZZzbY7u4yMwFn032XF6F.yBafbW2Mlz0IetIiuJ.U2Y.JfN3i.WR3pXBWg6IRLyXTRit4Ce
 MYeI6Q6DmQszunsfPLleJveHmSoIZZwwbxwaDJlSEk1cVlCH7LsjHNooOqOm9r4IRvle_X64UsK1
 d44qVfoCBWDqwhnnhtMP9qeq98qd_pSQIdAwtYb7Vlhtgvnfnl.vzxgBmSc07Lf7txG1AkRpTIWI
 K5HWww1ROXgt4UbD_gQrcBDEU1cTab1hVXpC7kpeKiBjDQ50dzrSY.B8ekeRuVQPoOJQbmKTURyr
 L7T0BXEaYdCAAWHTJ1_N6LXNiHplaoHVB5LfdDE7PrbeJzVCtZCld8XfqxVKSuAaQX9I8eVH7gK1
 ya7WebiPqJ5K6M.AZajw_hRKJUZOCzBiIA_YjFoyvteLn1IA79EySPvgduDb6bKpEictvCH9Dcwn
 S8aEHQPtd1.CW6vJuxeaM9tp4AqFhz07cCrk3tNfHYWNRR_a3N7NU7LlevfIgqDiYQZBFuenQhHO
 uArhq_oGhxxjtwAefOmTgjQ3TfFrsEXDXb9RbiAo6IvdxmrryyzaS_UJY6nNV5I43iffIq57.gD7
 LpsCZMZEcTuEtTc72rifNSb.EraglzsGU38niR00o60VhJHDgmjmrkAzpFnew9XUTganZUgKJZeF
 k8.HL85nfTUDpTxc6JeiW_1NS1BcNVLC1oKtEYtZBpHkCYx_bxR6btUwubK25BcvkcBzGr8FejlN
 wor70xCTOTdRRFXJ4rhJl8AzxX68Uzi2nO8Bibs0UMjdja0iLDxWKmW807Wert4JkWr33w6s0IGT
 z
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Apr 2021 16:39:57 +0000
Received: by kubenode512.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 96eeaddee6e84a2604e654687c2f8362;
          Tue, 27 Apr 2021 16:39:55 +0000 (UTC)
Subject: Re: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
 <20210305151923.29039-5-roberto.sassu@huawei.com>
 <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
 <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
 <7a39600c24a740838dca24c20af92c1a@huawei.com>
 <d047d1347e7104162e0e36eb57ade6bba914ea2d.camel@linux.ibm.com>
 <d783e2703248463f9af68e155ee65c38@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3354e1a0-bca2-2cb9-6e82-7209b9106008@schaufler-ca.com>
Date:   Tue, 27 Apr 2021 09:39:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d783e2703248463f9af68e155ee65c38@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18138 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/2021 8:57 AM, Roberto Sassu wrote:
>> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
>> Sent: Tuesday, April 27, 2021 5:35 PM
>> On Tue, 2021-04-27 at 09:25 +0000, Roberto Sassu wrote:
>>>> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
>>>> Sent: Monday, April 26, 2021 9:49 PM
>>>> On Fri, 2021-03-05 at 09:30 -0800, Casey Schaufler wrote:
>>>>> However ...
>>>>>
>>>>> The special casing of IMA and EVM in security.c is getting out of
>>>>> hand, and appears to be unnecessary. By my count there are 9 IMA
>>>>> hooks and 5 EVM hooks that have been hard coded. Adding this IMA
>>>>> hook makes 10. It would be really easy to register IMA and EVM as
>>>>> security modules. That would remove the dependency they currently
>>>>> have on security sub-system approval for changes like this one.
>>>>> I know there has been resistance to "IMA as an LSM" in the past,
>>>>> but it's pretty hard to see how it wouldn't be a win.
>> It sholdn't be one way.  Are you willing to also make the existing
>> IMA/EVM hooks that are not currently security hooks, security hooks
>> too?   And accept any new IMA/EVM hooks would result in new security
>> hooks?  Are you also willing to add dependency tracking between LSMs?
> I already have a preliminary branch where IMA/EVM are full LSMs.

I don't think that IMA/EVM need to be full LSMs to address my whinging.
I don't think that changing the existing integrity_whatever() to
security_whatever() is necessary. All that I'm really objecting to is
special cases in security.c:

{
	int ret;

	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
		return 0;
	/*
	 * SELinux and Smack integrate the cap call,
	 * so assume that all LSMs supplying this call do so.
	 */
	ret =3D call_int_hook(inode_removexattr, 1, mnt_userns, dentry, name);
	if (ret =3D=3D 1)
		ret =3D cap_inode_removexattr(mnt_userns, dentry, name);
	if (ret)
		return ret;
	ret =3D ima_inode_removexattr(dentry, name);
	if (ret)
		return ret;
	return evm_inode_removexattr(dentry, name);
}

Not all uses of ima/evm functions in security.c make sense to convert
to LSM hooks. In fact, I could be completely wrong that it makes sense
to change anything. What I see is something that looks like it ought to
be normalized. If there's good reason (and it looks like there may be)
for it to be different there's no reason to pay attention to me.

>
> Indeed, the biggest problem would be to have the new hooks
> accepted. I can send the patch set for evaluation to see what
> people think.
>
>>>> Somehow I missed the new "lsm=3D" boot command line option, which
>>>> dynamically allows enabling/disabling LSMs, being upstreamed.  This
>>>> would be one of the reasons for not making IMA/EVM full LSMs.
>>> Hi Mimi
>>>
>>> one could argue why IMA/EVM should receive a special
>>> treatment. I understand that this was a necessity without
>>> LSM stacking. Now that LSM stacking is available, I don't
>>> see any valid reason why IMA/EVM should not be managed
>>> by the LSM infrastructure.
>>>
>>>> Both IMA and EVM file data/metadata is persistent across boots.  If
>>>> either one or the other is not enabled the file data hash or file
>>>> metadata HMAC will not properly be updated, potentially preventing t=
he
>>>> system from booting when re-enabled.  Re-enabling IMA and EVM would
>>>> require "fixing" the mutable file data hash and HMAC, without any
>>>> knowledge of what the "fixed" values should be.  Dave Safford referr=
ed
>>>> to this as "blessing" the newly calculated values.
>>> IMA/EVM can be easily disabled in other ways, for example
>>> by moving the IMA policy or the EVM keys elsewhere.
>> Dynamically disabling IMA/EVM is very different than removing keys and=

>> preventing the system from booting.  Restoring the keys should result
>> in being able to re-boot the system.  Re-enabling IMA/EVM, requires re=
-
>> labeling the filesystem in "fix" mode, which "blesses" any changes mad=
e
>> when IMA/EVM were not enabled.
> Uhm, I thought that if you move the HMAC key for example
> and you boot the system, you invalidate all files that change,
> because the HMAC is not updated.
>
>>> Also other LSMs rely on a dynamic and persistent state
>>> (for example for file transitions in SELinux), which cannot be
>>> trusted anymore if LSMs are even temporarily disabled.
>> Your argument is because this is a problem for SELinux, make it also a=

>> problem for IMA/EVM too?!   ("Two wrongs make a right")
> To me it seems reasonable to give the ability to people to
> disable the LSMs if they want to do so, and at the same time
> to try to prevent accidental disable when the LSMs should be
> enabled.
>
>>> If IMA/EVM have to be enabled to prevent misconfiguration,
>>> I think the same can be achieved if they are full LSMs, for
>>> example by preventing that the list of enabled LSMs changes
>>> at run-time.
>> That ship sailed when "security=3D" was deprecated in favor of "lsm=3D=
"
>> support, which dynamically enables/disables LSMs at runtime.

security=3D is still supported and works the same as ever. lsm=3D is
more powerful than security=3D but also harder to use.

> Maybe this possibility can be disabled with a new kernel option.
> I will think a more concrete solution.
>
> Roberto
>
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli

