Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B0D1665E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 19:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgBTSLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 13:11:40 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:37077
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728407AbgBTSLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582222298; bh=q6UjrjE6DHvxFVsNl/iL7eDH3TLOf4/1fX67xW+i3FY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=VGC/1istFeIoAwEQw+FhtFiR365iNRDZa5aWCPlZEAxvNBEKfiIGUC2gE4PFf/tUX81QI86J1HIb9Rb60CFw2AwQq/16J7K2mXtmHGYo7+Z6avgBweD636zdjM3x3LUgZErvRh6dwgVwQq5QNRGlwFe8Wc8Thxo5YiQEN9NeX83LN8xzgsANV8JM92mDWl3CB7SjG3dlKYqS8c38qbjwsI3aQRzgYPFqRDzjwCb4GXO5yyrRLviyh7+VT6WWdAg3yZLcqQ82t1/0TaEKxbjWzR8dzsZi4KEJOAWBk1+UIao4wzaUIRUD3ylT7Ua6Acs5WW3djMMgKN1vt0pmJ58Kww==
X-YMail-OSG: pPjDUuQVM1ms14ONCgjem.eISD8MwlVJBucfpVJ5JK5t5iMwrnUiQ8VO1jVNuAp
 mimT2t_t8V9eAsqtBMYelI4p0.yhloDPKoqcF.wCwgJh2c.Q6VXS.XU.mR2LJCkq.8zta78_lhTp
 4QKdqmV8tdEonOFWmHffr8f7tmobnlKSwkhm2xUybxiph3nmsCNJs4NN4GrKL.9mrQ.ZPLH8vFtx
 _k4R3q5h2EVmLBlt9DLW56CdYIas_rngGGkeJm5cC8Qv02TPaQWKt2HCc16Rut1V1m8Qk6qNADrB
 oS8NxFE3JD3sK694al9b9t4R._U4WLX6msYvaqQlQj.FEIzRnSDuPdW8czRxQ94Oj2EzzhQ5dj2n
 jc.RIlosHnP9oSPXra2FzLlfjGWEWDCEmoLk2UJKlgfvFzJOtOM1ADLzwtF6er0bogF6MEcpStS4
 WCO5wDUZ9Lr2uCczcTLJbTtKRvMhWFpm4sXS.ScNNQulig2GWlbH5o2joD89Gi0ajXe9PM3Jk0w8
 7FZ7UQVq2KxWVDFYQzYH4eUybE0jcWWUHapvUgcDo_aNR95zy.1qQZbsz8CZqmcyliRdimEjoZLa
 gNvoMu5.8Grqlb1naqnbwSwtmJt9QzZ8LMg4d95TkTj3o1U9qoPVbi.HZWKaRP8GlzCpLWb4UcuG
 7V6v2Q18nVCpCJks04A8dsyKYlGrB9pHv8AAI9RhICoavWYr05WdFRNW1UXTBpkp_jrW3YBOwVFI
 hpash_0jDfLPJGozdhJ0sqi.XJqYqK229UQ.YmlNT78iOXt.dkybj565umOf6agrhuKY6ho7JC68
 RY8BbPiLhQjnWfkRE4Ze1jSqMGUJrPmi_tTFz4MydJjtgkVPgQrpTV8BeAl5lQHFRKW3t2eXbqyh
 tXsMi3LsbbUaLt2oTFtGjGEbdLrxgIdba9RLBWtUdpCoqjo0GFBPHmI2xWFH69ukG0ytbguwKg.O
 meYvYMGRufVfnjvIK7HkEoq5.ecyWSTcq02AsC4De.mfE3nuzMCLykcmyie1rm_pA_9FLKFBdDly
 o9cJvYB8vf_yZerPauqOiCsjX5CiQV4NubZZ76R1cF6_vr5Dr6dAZFMiH0yJMWtO.QN_dHLR2dY0
 MRCbb286o8eqVBk4IkXdqNFhkxL3_z7RrH2eH9.J9NYb5nVXnsf0zYER2OMFaDJ0fwRIwZ7EaBoj
 RP88b8ZMbzGCLS2nMYxdXp1Cm78nlS90kTe1W25LUgJZkI8lLc_aQfHPfVpFS8HzTtJX4zSObNj.
 lpwBSJ0hNw6kel2BFQ9AlVlhO_HlgnkyVO5kuGgNEbC4_xGSui6QvW6sMAObD2geTDxP.CGEY2rv
 _GP0MrOdXZQj4BZIUEZq.i0neMYYiWtfGYJCCAauuW26n4y1qBqzvIY6IcWi90yBasTfnz_Qf.d4
 j1G_8qCN9b898gPDcxXD0S38Ks0Gwp33uIpvjxdzHnAkYFRVBQJhA8.uR70OORfJlqS5e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2020 18:11:38 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9be6706b3feab7ead6eccd5f32f440ad;
          Thu, 20 Feb 2020 18:11:36 +0000 (UTC)
Subject: Re: [RFC PATCH] security,anon_inodes,kvm: enable security support for
 anon inodes
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     selinux@vger.kernel.org, kvm@vger.kernel.org, dancol@google.com,
        nnk@google.com, Stephen Smalley <sds@tycho.nsa.gov>
References: <20200213194157.5877-1-sds@tycho.nsa.gov>
 <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <eb2dbe22-91af-17c6-3dfb-d9ec619a4d7a@schaufler-ca.com>
Date:   Thu, 20 Feb 2020 10:11:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/2020 4:14 PM, Paul Moore wrote:
> On Thu, Feb 13, 2020 at 2:41 PM Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
>> Add support for labeling and controlling access to files attached to a=
non
>> inodes. Introduce extended interfaces for creating such files to permi=
t
>> passing a related file as an input to decide how to label the anon
>> inode. Define a security hook for initializing the anon inode security=

>> attributes. Security attributes are either inherited from a related fi=
le
>> or determined based on some combination of the creating task and polic=
y
>> (in the case of SELinux, using type_transition rules).  As an
>> example user of the inheritance support, convert kvm to use the new
>> interface for passing the related file so that the anon inode can inhe=
rit
>> the security attributes of /dev/kvm and provide consistent access cont=
rol
>> for subsequent ioctl operations.  Other users of anon inodes, includin=
g
>> userfaultfd, will default to the transition-based mechanism instead.
>>
>> Compared to the series in
>> https://lore.kernel.org/selinux/20200211225547.235083-1-dancol@google.=
com/,
>> this approach differs in that it does not require creation of a separa=
te
>> anonymous inode for each file (instead storing the per-instance securi=
ty
>> information in the file security blob), it applies labeling and contro=
l
>> to all users of anonymous inodes rather than requiring opt-in via a ne=
w
>> flag, it supports labeling based on a related inode if provided,
>> it relies on type transitions to compute the label of the anon inode
>> when there is no related inode, and it does not require introducing a =
new
>> security class for each user of anonymous inodes.
>>
>> On the other hand, the approach in this patch does expose the name pas=
sed
>> by the creator of the anon inode to the policy (an indirect mapping co=
uld
>> be provided within SELinux if these names aren't considered to be stab=
le),
>> requires the definition of type_transition rules to distinguish userfa=
ultfd
>> inodes from proc inodes based on type since they share the same class,=

>> doesn't support denying the creation of anonymous inodes (making the h=
ook
>> added by this patch return something other than void is problematic du=
e to
>> it being called after the file is already allocated and error handling=
 in
>> the callers can't presently account for this scenario and end up calli=
ng
>> release methods multiple times), and may be more expensive
>> (security_transition_sid overhead on each anon inode allocation).
>>
>> We are primarily posting this RFC patch now so that the two different
>> approaches can be concretely compared.  We anticipate a hybrid of the
>> two approaches being the likely outcome in the end.  In particular
>> if support for allocating a separate inode for each of these files
>> is acceptable, then we would favor storing the security information
>> in the inode security blob and using it instead of the file security
>> blob.
> Bringing this back up in hopes of attracting some attention from the
> fs-devel crowd and Al.  As Stephen already mentioned, from a SELinux
> perspective we would prefer to attach the security blob to the inode
> as opposed to the file struct; does anyone have any objections to
> that?

Sorry for the delay - been sick the past few days.

I agree that the inode is a better place than the file for information
about the inode. This is especially true for Smack, which uses
multiple extended attributes in some cases. I don't believe that any
except the access label will be relevant to anonymous inodes, but
I can imagine security modules with policies that would.

I am always an advocate of full xattr support. It goes a long
way in reducing the number and complexity of special case interfaces.=20


