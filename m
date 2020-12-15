Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511002DB357
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 19:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgLOSKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 13:10:20 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:36551
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730585AbgLOSKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608055762; bh=aogMOmk4bsmznjsALWaTSguRC9pC6jg4i6uPza5PDJk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Fl/N1A1acpCXp3hv5b9TkN/mGdoop1UOi5hFVVpdYdahCPjXq/SqhPzduUF1c9ikQER2l02p0DjEjYa3F1IwTou6dEy9fUi0UQR5ho9PuhaBwNb0vRNYSE1qY/VIJZmqA0OYm/J0+bS9XKLoxOouCyAsjxTZ4KEOH6mdSP0OSYoxinepJY1HppRmX1BVbQyBusP14VTk8o0aKXObir7Ypsdbn3AH3G751AwsZi+L4hAtRCYW+Nljq0DHYMu3H2LOo6IQVm7iI6VID25pDCHjCQErZSWGQyQGn+0Ktot3UmJo5EgUDsrefOkmYXIlFe9UM5T0uYcOAJKYFMV9W2QFhw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608055762; bh=khpEFUhYniJCGq9vvq6RUHv+txXviNHPRcq8peiHIha=; h=Subject:To:From:Date:From:Subject; b=AX7XaqCrvWhajtghC7LS8zHCefG6weH+xXIlPyCWk5zZpx7SGx5uaP81nYVbJ+nAHFcuNTCWPK8EJavOK5PL2BF34ShiuoFAgxar+ksPT1b5FiTg3Vq0kvDUzyXUowO/+cikLYXGGJDbz4nA75qhFw0SBbkO6JPKyY3IdAGAeJB14DL7c4gukDhIXguVGH4bOCoPhxZYN48QrSXwYFbUo7iKfzpgosFCUcZyQNGDZj68h8IdA1UddEwYwHxb1PJbcY0w75Do76ntxeHAC3LfEMKUlvgFRZgN+nzz6oGzXOralvHnIcM8SFifTlklMOcb+xydsekkuf35GfLEwQhB7w==
X-YMail-OSG: NRRNDrYVM1mUn_vYqQNv4JZOQ8Z.xnNcaRyIP09zH4UlPr81IeKtU_WotjsYCix
 WSzFIyJj8GEzDV6xod1SI59kDov4Ip3DnXe9s6ZHoyk0Jfg6m._ba3Ny6ahN0Dy6tDpu5XykNfn.
 ugkDB8WsDr.SgN00l8BCDl7Z7kEUgbPWSCTnP.EeIbKyrgW.4y_tplBj2eEZaGijl1_C91EYFdLo
 GunkoQQLYUnIQzHrSdsnpoAhrF5WwY1s733vXTnLQj5Q9CtR1fQ_0PP0YBC25tiVqMTxL7h4x.nn
 .kJ8j1ujwGdmrZ9_pW8kRNyRtjw8QcAgP7JvWKYh0QUHMRgXtzXpikP1YhS2MmluAIFecP3_7Caw
 0_UgocZs8VIRSsF58aq4eFn5cGpzDhq58qJh7duzEW96QZ.F3q9NrGSGNr4cw8Zw.0YEwP13oawV
 icSw2H5xGhCQghjyy2iKbpJ01dkQsn6gUf0FcyouSVQ3yHz5fzpCvTDQccSSSwG03Maz7Q9Fo0Bv
 tXIqUmvcoDYUqYlQtBBrYb8WO.9Ee1N7rQAJqqog3RHmUYgBcmbRkKL8zyJta7R89cERWIzPcNK1
 sgd7dxBuSNi5vXDPBNvOPvdgminGfqDdrQgULII8haX5XY51JJZ5Hzr9MdWkqyeaori6n6yBWTFe
 NsNpBGQabMq1CVG3e6ipq90P1AQX15GfTA4Zk3flBRVjE8mCeGu3usGVZZvItigXFGHEKFUeqyuU
 3RMx90sO4L7B2pb7CSzTqWb_mPR63SMn4771qxYESDra.aO7cLjomJwU.eS1WvA1sE_KEoP_zmTH
 XjbjbkQ3fUU8R.1uBeCJy8YKSfFJwm71HMzA.MCO3LG9H9AqRwe8WS5Q7EFbdGY8eLavgzvpb3td
 cnw8vGxbWotVGAH0dFVwkjZ7cG1WbCpY59HtVj7DgyU61DHKItqNLTNZta0e1chfbMNxbjmgu0Mq
 CU.PF7QIgVygFk049EG7JWjIeks9gh5sQ.Gf29wLd1zbflDkoBAR7B3LT9A94OT3g0hhnskQlUUK
 n1AP6t1cAVScZPioHdZPqhLLw4bB4C2Yrtn1vudxVEfzhoNEkGN6nUHBK7FQFBo9eyw_wgXQXhcK
 Q3WMRp9NRHc7IlTu7KVSBFNGVo5VO0DHl.3ZzXGkRJy5cb3mRAHzKI1foUYQK7BYDf1UUcScAxMJ
 EQMQb5XCEN0ofeXfdjLHFImqOH3o95Kmm_Y4gnDkyz1zfV.bI0q6xWXDAu2yt7IVPjUxpmmVjSd6
 mJ0cRT6PWBBum40jIzPWH8_Wfhpsm2wcZhpJ_Tx_TAiur3kKaYrkFBACFMs.43utiOrAJKrgb6L7
 lRt.Y4ddOnsnpaL1P8erwkici.6IQpqoMAOu2DhlH_xmv3d.x3Vse0rEc.iIuvoc1Hh_YDS5ArlY
 w6SMbngBZR2ppoXSrlVF2LwxiY6X6mMhPAB6lYNLerWkzs6f2H7xccgfULrk_SDfvWj9guvMhe7F
 Djnh84EeWBpn3f1cgTK_QpDXULy3rG8iftrdPfZbpcuGrPKTABsTyWyKmJ.Vv.LJYbZTtApmhA27
 OJv2CTfRj25ERwPuphAU2DYgIXqYKioEdV1JJEwVWd9hpjSVJFWaK0IeUaUFGqXYzliV6LvV.A6K
 700Fdru0Gq6O7I2gU.Y15Ya2IkmNR3uRBLMtAJRQp_Vwvhb6TPr4K0IpBQmdUOhuIcCnFPamiogY
 r.etCMTCAd6Sef6yM0DG_BD5Qu4tUzz6EvjnLwg9CU4KLejcbr6ZCQJshKjPaGUjuEx0aR71kGW3
 7fNNGicrK2o9r6MYK2VeEIJXdfPLUYFoo4CHos1GL8rwb5xG1rCf.QO63mYSeqXLQJDjKfHnGZJ1
 imy5CB_3JA1gL1Ox6mosqWZs4DT1214B9Ziog09.KRF50ok5zVaY8jAE0vp7HCKgGPL_t5.z07f1
 88rAik0MQ6vkl0DHfS1TfHDWpL2WaRMon8dnSyqTBCnSuFPR7GIEU_7KGKEM2bZfugQ177S5KQHU
 gj9bpC3PdnxGGbZrNr6C12j1CGlzOSj5pU7CgooGwU2j6_A1jREdtZHnb_enSjAPoruF2LWrE9OO
 JhRN4IRfErmGbAvXjzNtXXMHFn7UBo3S9DltSw6cdoFM4Vnp15P4jOgs7ip3gZZTyXfPEIploJOo
 ObZaUuw2GJdy_MrA_4I_AEkRcYIspsbXhBQd8GwaaDDPqdHAJp6neXQKajPSl1usNKcuvOxU9YzL
 3a1wx8HKjLMjr5_u2JBeOxV.wwGqZ0oFxetEEOIhwYmliI7KQqE8GWAou5yqNsCIOcscPAXZchtV
 3_5vlsPg2rL3fsT_34pZHFd6JYoO3mGb1dzswx_eNIP2sEBU6lRf4xESkstOMoUnb42PAGXFdHOw
 s9WNNLeeVBgoCMitb14h.T4hB_TymEm0TT6ZCCa.U1kgzEizGB9uj_d3xzK85.h1_.jC3MjI6FfP
 wMTJVCP9bJ_T5fKdZtjb4IPGQWuznqHERLmYwm9EYUJRaMw51Mk5mPf17aoEH6CeAkITtxI55mma
 S81LYn9P2oQXfPJyLk.v2id2z4gRuwAuJchtpNR1GOs6t680XTrqbNYvJcVzvo8dDLVgxWDKuB4c
 95YtzOyDWiRUZcA8qbIa.ng_QY7G.umAeH8g4_LFTBlzEz3vhxf7sX0pdcTHF4ZdDrqVGVQfZI05
 U.1rYMbpRJ4bRkYxj0s9U0IqXMYhJbRnKQ5P5Oq7AyQbazn.6X2cM2aiTLphHO1Ua5Uo_GL.6hLv
 bEmTSVdzvoA3QKJbZ1AhXnZD9gcw5TKv759NpyP3rILlDlEHl76d1C.nI9TX3co9EMU5IQfPRcKD
 N7lln6tvi8v0mh.QHHxJAloM4BcEgVyRuN5aRHwzVjt8320AHwPB7pqxRVbRFf_8vmXT7.4WB4PC
 zJv79uWuN57Hv.XV0Fp6bPPoLaUtIWRJ0pffpwBfaSaasP5ny2X8B.vH8XqPCPguJWYUszob4oZX
 o81IouOPhyrlF4im7zw.bkwj52GW50UcAOWexcmGUsh7IhMNDSDRF0Zy6ZU3i0Z5QOtqfJKfRhB.
 cszBIYWbY6k072XNJxXiGrCtRvJYhML0pJlTaY0h3cYyFyJI882a698QRdmtQ_8N7r0GppKiiQcB
 2Mt.zQXsaasnKHlqXtbKboqilp6Gpis.s10I5sQoPWA2Qrm71fuG.eeRFTQpo2Yj1XQyzCmVBoVb
 NtxGsE9RyfvdIWqjv_mQKqYjLQZJsz6rPwCcH9A.5pnLSV_1nUN5j12T9vSZEYaKWUshx4nHYGEd
 PDpZ8TtI6DaIJYXlH4BemWuNQl5VN5yiPrYKz_hEeKPzS88bSnDilJnG4cPVnaSA05fwmwPjdqEt
 2jLdrl4xul.3vzB3R_qnVPk9MrfjFCNDHee4LSPSh.mDmpOcWNoxEcbyc7LDLryq7q9bByt1K7n8
 OP_GKEcxXcSBqwQ147S2PD8CmNBY5uJD5XNyk4BZYwjQZ9FDbjCjVDTRzDYorzrtAwdg_HDQzNsN
 7Hlg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Dec 2020 18:09:22 +0000
Received: by smtp422.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d3456e8f81da9775419af5a53f939e16;
          Tue, 15 Dec 2020 18:09:16 +0000 (UTC)
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Paul Moore <paul@paul-moore.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <20201212205522.GF2443@casper.infradead.org>
 <877dpln5uf.fsf@x220.int.ebiederm.org>
 <20201213162941.GG2443@casper.infradead.org>
 <CAHC9VhSytjTGPhaKFC7Cq1qotps7oyFjU7vN4oLYSxXrruTfAQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3504e55a-e429-8f51-1b23-b346434086d8@schaufler-ca.com>
Date:   Tue, 15 Dec 2020 10:09:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSytjTGPhaKFC7Cq1qotps7oyFjU7vN4oLYSxXrruTfAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/2020 3:00 PM, Paul Moore wrote:
> On Sun, Dec 13, 2020 at 11:30 AM Matthew Wilcox <willy@infradead.org> w=
rote:
>> On Sun, Dec 13, 2020 at 08:22:32AM -0600, Eric W. Biederman wrote:
>>> Matthew Wilcox <willy@infradead.org> writes:
>>>
>>>> On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
>>>>> -void pid_update_inode(struct task_struct *task, struct inode *inod=
e)
>>>>> +static int do_pid_update_inode(struct task_struct *task, struct in=
ode *inode,
>>>>> +                         unsigned int flags)
>>>> I'm really nitpicking here, but this function only _updates_ the ino=
de
>>>> if flags says it should.  So I was thinking something like this
>>>> (compile tested only).
>>>>
>>>> I'd really appreocate feedback from someone like Casey or Stephen on=

>>>> what they need for their security modules.
>>> Just so we don't have security module questions confusing things
>>> can we please make this a 2 patch series?  With the first
>>> patch removing security_task_to_inode?
>>>
>>> The justification for the removal is that all security_task_to_inode
>>> appears to care about is the file type bits in inode->i_mode.  Someth=
ing
>>> that never changes.  Having this in a separate patch would make that
>>> logical change easier to verify.
>> I don't think that's right, which is why I keep asking Stephen & Casey=

>> for their thoughts.
> The SELinux security_task_to_inode() implementation only cares about
> inode->i_mode S_IFMT bits from the inode so that we can set the object
> class correctly.  The inode's SELinux label is taken from the
> associated task.
>
> Casey would need to comment on Smack's needs.

SELinux uses different "class"es on subjects and objects.
Smack does not differentiate, so knows the label it wants
the inode to have when smack_task_to_inode() is called,
and sets it accordingly. Nothing is allocated in the process,
and the new value is coming from the Smack master label list.
It isn't going to go away. It appears that this is the point
of the hook. Am I missing something?

>
>> For example,
>>
>>  * Sets the smack pointer in the inode security blob
>>  */
>> static void smack_task_to_inode(struct task_struct *p, struct inode *i=
node)
>> {
>>         struct inode_smack *isp =3D smack_inode(inode);
>>         struct smack_known *skp =3D smk_of_task_struct(p);
>>
>>         isp->smk_inode =3D skp;
>>         isp->smk_flags |=3D SMK_INODE_INSTANT;
>> }
>>
>> That seems to do rather more than checking the file type bits.

