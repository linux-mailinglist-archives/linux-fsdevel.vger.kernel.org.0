Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655962DB6AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 23:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgLOWyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 17:54:37 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:38745
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727788AbgLOWyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608072830; bh=m16PyXyoq2UaqlVRkpPOZ1X8umnZw9exqt4kLlfDM/0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ka3aWRDcs+TESUBbnE/XxJbhrxFBjuwZwOiJt+ULcnrG+A8rUmp7qthhtAAIW9zAZ67PLit0Z0FJ5Axze4fq0ioGbfhIjEJHk+6YKxR6X+Aviz6/s8bkzAZ0vLOnqxb1MeQSpJff3gcqKy+vQFXkXiIXwSdkdmo2hSb73Sx05oLFvUFAaH/67CYimrqvrZPxinsXc0o1CcqP1Xt1X1G9lsf+/wyA7b9tA6IjHF4uEGGWXBapA3HLWiARNi3R887Ufs6HInRs1brP3kLR6FCfuBwaELQQ6tVlUhrrazUdZh0sQpK62UU+YXWKhIFsBCecsTS34sDBVm3HoeYSWAMV7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608072830; bh=nBu+N9JnwMMwAGOJWn+E5Hd9/HCksBof/2rlBQMm/gk=; h=Subject:To:From:Date:From:Subject; b=b1LzHVB5/k4xn/X1UOtseMtu0S7a+ABkKDjMTXyDHo3ecexQDoP0Fuf5Ltf8S0UrAaKT5C+3UH5fwy1ABhTBm5SVl8p6R9Nk3ay5NnMFAEVqmoiAgfDgC4dLtxMccU+EPc4tjEyfViyfUII27IVjo1GozPAH2JKqeGJypa+Q5dFMdIQwIaW9wgXc3koQnRJEoei3c19mi1o5rZTrQU2NNe35NYQ1hdYtUwkukZES4GkscxoUneZ2lQVSSVB5dW2zdrhr88lYv25gP8yrdo6yjQzlxEZlAO+Z/WDXglUhnvCcTGE1LfI5qkqbqlu/4QHWHKAP4x8iK2OTHtRzR4ar4A==
X-YMail-OSG: zbUPHSMVM1nTFiqQNoDOZXzhpdUuqMi9IYs6xjafKYeERXAUgpvpIuot1XFKg9S
 OWYMDnNB_52jRNJnGvKkrfw1wJyUf843YGBK0rs8nJdUCNZD1jqdMiB051DzEY4I9CLewH.LBkHw
 _8tg514iUSkbjnUFrc1tZXBauU_VTlBzgO4LX4sNo2ziHKxc9eibO.dylLHW9sARBL.RUwo7fCI6
 njlpcJ6voB22KMTQcP0THYFoOIB9_7580JHFVHUN2fL5JRn2OpBay9XZGZhN6GpTDznHoReMDQvZ
 UOQqvJDOkwVt8qRKKlKzPC_DpFULueMVAuM2FdyMtiTOYbj8I2BGwGcol3di7pCmMGVfUQhgCucX
 jJ__nTNBXwlg_9iOwULUfm.jsCEUMW4syA3pqpVgjzfJ4xVhSU.5MeRh1PrTGFOHFjKFnflMrifQ
 UwCywzRfNfMenlHwq_H50bq5Z25SOstrGRnntWdT5vANANZJj9GdujJR2AoCrDjaeCL8AMrzaaOA
 Fz8OzhMFQg60v33jvcsXNqbTwxY9323px4Oz8rPN2AdBDi3h7RjwHSCJSV.f..oZ_.QFNFscMOfk
 ykqH3Y7Mla.MMNHJ0owLTnhXNrkB5KSi2x_fiQqjKVox5ONnlNGy03eCh31WVdYIeNY8xSDCjFeX
 VeUKVk9ZxNWXvxfLeCVqLEaVC5I5QDVznZLWsZZmFXihcf0.Hm6NPxAd.w9C1iBb62iTjiHOijHP
 ZojjAphBTSMFy2kcgcY1sKZjiXV_cLqSgO3RBG9iEqKbhaHsFUBSnfqz08pPAcNxzAE4IpjC5du8
 7iw1.USdfsRsgR3GgFN.mzT5JR0pG0kHQL5pujcgK2Hl4oWpacnoBFPWg48r5WH.aeI1tyY8RQiU
 1mfIbhavc0b0ukQtWsHHxJTGfH.IQbDc98sMujME1rWf7uRDQob2tvQF62YENpSZO5zDbqUfMha5
 9HyimMc5ghxK6I1VdS05Cbu6_0pQefwUsk_Hwa_feBaXzTNxn9WIjereDvvmr74DH1OApHsaupKF
 JDTQv3fu58DbxWsuzJt4_5J.Qk8EPy9F0O_6WpSg5cEuURskmWYbgP77k8Knzv6Okf.WCNuuKMiE
 1tPWmwQOc4LwXzEX.UBZ29.f847xDAf45lAoU_rv1ekOwWfE8C9cL97mD3uX1KgkJaty72Wn.1Sr
 D30_e3mgOJde0PgrB7j2EOV9G4XX8ewtYho33Zs0wjQL.3ZELY1PJ_x1Go62bQqkps.PEi1lm5WQ
 FrVsl2UrUCaWpaVvelSfkaePYPSvUtZpzlmm3TMp4Dxc3sCqwpWcKFLdtxCYRKqKTvlKig_Rw2BU
 jJECDFEt8LmUecz4Z_HSjBDOOFotH6f_9xbimDFVxcRCOy9Oh2jEuOr7mur4XqMpwozDCz8yRQTS
 oH6DVDLuJsFj0JO8Zdd.I2MIcmjmgEHWq2Q6YP3ETqzCheSOfjb8IKWTPGXsKtiqtk_a9_K9fL5U
 VRFGB.QOAzv8q6He1uqXqmmgFt3NlgRiH.rkfls693y6hlk5U5M.11Yko3Y3CFT_X_QQ_d_CGKFo
 ZC9ZwG0DIWR3tDmbheXaIipeD3nbmIqYd02ae2AzS37X1z0VlwegXKdyy.XywM2RfTjb7QgJ4dff
 TxrCooHxQ2Q4hYpjh_6rn9lI1bMzh.sEnKJqUdSU_QcmR5xGoGaSxdnyAwBbATmn5kE26H6ttKJP
 89NJHk9eUC_JpcwkrIGkW6Nv7y8mH_sKsFMkOIuC1O222QIBF8ZmJXFAAeFwFzwzzsZ9jofPUCDu
 idroO5F7YtvEhIs.WHKMaUdYbKibVqw4syyr7SR.l_LG4ydbWPyCbPq66U23LXhY02V_4KHgUPmd
 1FKwS.uRExLIMymDh3sIe12k7MExEj.tWwl7A1g3_pJDalrUGYPxzE3c0xhLYVF7rLoW7QI4z7GT
 n.P_pE5gJvBBi3LnuPG1_r7r6Yq.8iDl7.nRhNLEE63Y4Y9U426X6e17Z.K67L996TFjC8RDJky_
 YWH6lVdrVFexo_CXjHiWIkHf.0KL82H._mnQZaEQKy0o0HUNdnaQ2IsgRnZ2iiyKSYk5QMBbMpa7
 2yw66c52LulbobJNfw5Wp2KDNavobOsZ8aX6UGu8VwUOi2u8c6Fi8lC_2KKwvBHQl7Gkoi57vNgT
 hreaZ6fthxJ77R9mkXvmYoY8EQhd9LBlfZfR4t1DEmFnD_q3vyYKupQGcsDIsZhSurSeoZFx8Pc.
 GyeR0XZTC3C3p9ZGzbJOIx1EpjSvtGcF36MTX8hNOvX8EijDp6owOaKqV7RXc_YnWMolSWq40jku
 yh884Ske8lmC7BMwg4yeMxStNB5bA6nsrh5PAV4edzYRJqBm98olDKef1xrW4ROwbHsZmnj2VlxM
 p0rTFoXPx73uEF9q961_gnbxN_MvveaO1o3VtHHFCiQuSuSNa9Fqf1Ch4rahGmdfLcRE4HzHr6RC
 pUGiS2nizrGXMnyO8FIXBEyYt9pWf0RaDFvqUqjZDu.9Hqvw9JYv8MX2O6o2NVyBdaCyH3Fpa5_W
 oC4C9bugTj81TvRShMFvvBe6yRe7oHnFnNpm2ibd5rbeKFYxzVDBKlBHRgyf.N5SuEGnSeoiU8yy
 VfGQx4CY51IcHgOfTqAdkSrRqwJ0JHKdhVbres_SqxGJrHSVcfkMsukHnGFkGo3VONBE64VJzgIM
 K5PKQVSXJ.bFrk92UCVybgKkCJYsmwgAbnAvkceQXMcFasBIpu0dMj5WwaiiwF1UkaeU3vcL2Bqo
 RaB493xAvoQG35KkR97gEPPNAkn19ckuAqqNMS0tcG8bKWJmWZBCV4zKEKsUAYOJv41rDVdJW8CM
 C2tDrjNcmsOiNROMiVhoNg27HB60XQ.SkbnjKqRtqCPn2mXAuZYPRBtu.gsWKjCsbT.wYF0jYYRJ
 uQLL8Wq707hzsVClgUCsIf8XgyB31X1X3CUAO55NF3e10OHu8zUwthLdW7oINTilS1Djf83ZG_99
 kg9P4rejzhrHskA7C7Ez4ZrbFL4jLlrZhZ7nO2ZmSgBdUlg_tSom_wngtXcUgvtL77NlUfbOOp1R
 RpC2uVStDqPq.AWYpA2AxcKag1zvnyJuDeatbkBZ1rMjYagvkU93fMXxhfdCeNJp9730P70BgCdB
 fzXErQKHlZiDccQzRxIM11bMb0ISlUYBMSoJ9K7hTLNQyyMClaUogyI6QdwEL1pKsSrG_9dC1rEy
 vHKd5T1zqvUa2nGNkClflskT5xnwWX8TOxr6nfy.NAmAlAQ0nslh2G4bOezhbfrGD1SPhu1NySux
 tRGY0fslJwk1C_JSocPuDQyLIyZNGOAha_hI539cf3Oy44ge7lCefTpd8EdpaRY52PfOxbdLJP7B
 ba1q.HxxcdITfgf9p2jwgr04rM7dqEMDZudBNxJllOGil78U4183D0wAzAvJhZYdvKmHE3caDxZR
 8Dh8rFQQymCYLsFlbg2rorlXu0oPYVHP8dZ0BuxkGY1QLB0vTKbOzpRFTyLJDwGAxfyoGs7sCpql
 lK7tluqfihMVvTnwe9sSs3j.aKQBUK.zblscRoLJSTg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Dec 2020 22:53:50 +0000
Received: by smtp404.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 26d2e2ce293a63d56fb28c8d1d5769bd;
          Tue, 15 Dec 2020 22:53:46 +0000 (UTC)
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Matthew Wilcox <willy@infradead.org>,
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
 <3504e55a-e429-8f51-1b23-b346434086d8@schaufler-ca.com>
 <87im92d8tw.fsf@x220.int.ebiederm.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ee27cf98-5636-33e8-5c2e-019529848617@schaufler-ca.com>
Date:   Tue, 15 Dec 2020 14:53:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87im92d8tw.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/2020 2:04 PM, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
>
>> On 12/13/2020 3:00 PM, Paul Moore wrote:
>>> On Sun, Dec 13, 2020 at 11:30 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>> On Sun, Dec 13, 2020 at 08:22:32AM -0600, Eric W. Biederman wrote:
>>>>> Matthew Wilcox <willy@infradead.org> writes:
>>>>>
>>>>>> On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
>>>>>>> -void pid_update_inode(struct task_struct *task, struct inode *inode)
>>>>>>> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
>>>>>>> +                         unsigned int flags)
>>>>>> I'm really nitpicking here, but this function only _updates_ the inode
>>>>>> if flags says it should.  So I was thinking something like this
>>>>>> (compile tested only).
>>>>>>
>>>>>> I'd really appreocate feedback from someone like Casey or Stephen on
>>>>>> what they need for their security modules.
>>>>> Just so we don't have security module questions confusing things
>>>>> can we please make this a 2 patch series?  With the first
>>>>> patch removing security_task_to_inode?
>>>>>
>>>>> The justification for the removal is that all security_task_to_inode
>>>>> appears to care about is the file type bits in inode->i_mode.  Something
>>>>> that never changes.  Having this in a separate patch would make that
>>>>> logical change easier to verify.
>>>> I don't think that's right, which is why I keep asking Stephen & Casey
>>>> for their thoughts.
>>> The SELinux security_task_to_inode() implementation only cares about
>>> inode->i_mode S_IFMT bits from the inode so that we can set the object
>>> class correctly.  The inode's SELinux label is taken from the
>>> associated task.
>>>
>>> Casey would need to comment on Smack's needs.
>> SELinux uses different "class"es on subjects and objects.
>> Smack does not differentiate, so knows the label it wants
>> the inode to have when smack_task_to_inode() is called,
>> and sets it accordingly. Nothing is allocated in the process,
>> and the new value is coming from the Smack master label list.
>> It isn't going to go away. It appears that this is the point
>> of the hook. Am I missing something?
> security_task_to_inode (strangely named as this is proc specific) is
> currently called both when the inode is initialized in proc and when
> pid_revalidate is called and the uid and gid of the proc inode
> are updated to match the traced task.
>
> I am suggesting that the call of security_task_to_inode in
> pid_revalidate be removed as neither of the two implementations of this
> security hook smack nor selinux care of the uid or gid changes.

If you're sure that the only case where pid_revalidate() would matter
is for the uid/gid cases that would be OK.

>
> Removal of the security check will allow proc to be accessed in rcu look
> mode.  AKA give proc go faster stripes.
>
> The two implementations are:
>
> static void selinux_task_to_inode(struct task_struct *p,
> 				  struct inode *inode)
> {
> 	struct inode_security_struct *isec = selinux_inode(inode);
> 	u32 sid = task_sid(p);
>
> 	spin_lock(&isec->lock);
> 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
> 	isec->sid = sid;
> 	isec->initialized = LABEL_INITIALIZED;
> 	spin_unlock(&isec->lock);
> }
>
>
> static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
> {
> 	struct inode_smack *isp = smack_inode(inode);
> 	struct smack_known *skp = smk_of_task_struct(p);
>
> 	isp->smk_inode = skp;
> 	isp->smk_flags |= SMK_INODE_INSTANT;
> }
>
> I see two questions gating the safe removal of the call of
> security_task_to_inode from pid_revalidate.
>
> 1) Does any of this code care about uids or gids.
>    It appears the answer is no from a quick inspection of the code.

It looks that way.

>
> 2) Does smack_task_to_inode need to be called after exec?
>    - Exec especially suid exec changes the the cred on a task.
>    - Execing of a non-leader thread changes the thread_pid of a task
>      so that it is the pid of the entire thread group.

I think so. If SMACK64EXEC is set on a binary the label will
be changed on exec. The /proc inode Smack label would need to
be changed.

>
>    If either of those are significant perhaps we can limit calling
>    security_task_to_inode if task->self_exec_id is different.
>
>    I haven't yet take the time to trace through and see if
>    task_sid(p) or smk_of_task_struct(p) could change based on
>    the security hooks called during exec.  Or how bad the races are if
>    such a change can happen.
>
> Does that clarify the question that is being asked?
>
> Eric
