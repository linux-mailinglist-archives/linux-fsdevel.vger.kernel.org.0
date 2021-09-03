Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB7400550
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350939AbhICSuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 14:50:54 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:37950
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235938AbhICSux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630694992; bh=O2GL4tnOkFYjzHjDuGylvrMTbnPGkeKf3V90zsjBhr0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=iEVLXFbv1EsNxwZSm+AGrSfJ4PaAHWBqP05Ew5nkcHhAMfG5xebjMnFRb5+zSDqSdzsJMjwr9vtHj1wIFovfoUe06npQy5eYHwXsGmMCjlRdv8XPEyOqEXIHhiGY2RT9oZjILyQjAap4Rg39Ji8BnByV8WXmBZZbLErV5xhJh4fNPpcGzqW6RMDuI0I9E4k1BgKstn1ptLpwvjtY6g8WHa8nXtkdc6d38d8nfkAmq6EP1jXqOjD05FaJjBsRk3tEw4AfeeICij+kTLpHeCaTLhylD4Trq+ZqFWdj8NgI8iFBNpt7A41qQAuPL7YO9bFVCJgF2+w8JUCSE0G3d+dL3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630694992; bh=RdPJxpQn+YemB/nASDhp9tRtWWtF/WZEQp3Qo2cVLIf=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=aNKs60yFrxPXW9bgwdr8c/bKNPAHa7D0njMY95nLbCUWJjcDH+ed1SoI9pHT0TIJ1Hd8+m35DGIaN75bmAi+kXjdOg3QEl/99QivusxzRmC61NgBn/Z2yHtxd4gJFKsuigiqaFY1Eip2oEz9ltX3em94Lkc42pNU219B5QEchVtfBJovLiRHSrJeCMfh5LzLWmk14ZZnzQaOcAmo+EndoO7uOiIZPZJHpgqDJx4oX63imA2xVMSQe3LLgoWNcltdruGvQazqObSzHkrS8VH4fydogm/R5ivCz7jZUUfsOytqLZm6XfvTWJ/QQ5WTpFvyFy65Rh481Lw+Qmx3/mm1LQ==
X-YMail-OSG: PjCszGUVM1m2L0jpbcPMjztM2KYwcH50C8qLyCz_oiI4AbuGD6qc_ekKfayP0Ny
 vWWSdjvqKJb5xKAnUVTT3RmdLzzHyBBLxBEgtvFeuPhT_wshZBMRXggfq2iZwjpt1ohoMO8FFrSS
 f2px0YcHhCpTE8_IPQ50OCzwhdqDeRJAltNoZByvQgImkavBitfZWXjcZnfwJ0VjgJgASzzrO.yN
 Y.anOmbbftpXy6a5FIr1RZThSc07BhLOmksvd28zzP4nx8USF4DcVo9nkFJ_hLjLvnxPcVDrGziq
 PCPcQmETIibEQXjAEXAS2VU6cf60mDkq.1gpc69kVcOhZvRhxxySF4AFFravCY.KlD2gd7mS0IyS
 d.aQit9FLocoSwnV6Ej.C40wja1fs.6TVA6Hmw3Q8BUdG.744zfwJX3Yprbn.JrnHQu3yoGxl.P9
 UJk1Y3V5fo2UUEDynE30C4.4D8.kiw671RJxgdDq4_1dT9ksZy6TGeViYxK3qeExFyTfZGHblP.I
 _M9XEJU6YidmWX45nYlnZSVG9Z0td_dwCp8p.iyMOJh73MB_6r7Cfn0AXr2.9UMfT7w542AgaphZ
 LRvy5D.jOPMAwUd21HP0hfLnGQzleG76HOYbb8NozqpWbZhiFdIQACe80XnwyC8SjQFmrKF5GXUW
 lbqvAC7IeqrgM4688iqe1bQUumKzeig1oz3nHGucwhHMT4eGGOmUJx2DcmlajgB3wnP8IMqZ.BkE
 q6SCKXQvPyCvzN6k04VW.rG6xxN69W8aFQSBdyZL_MH04AKxA1z2D0Q9WLgqz_va00y.kww9Tx85
 ubP4d8HjYiQC0j4u.iFj.aa2NRU.PrRnvFQb6V4pgW3zKo5vU_nzm_IAWtMZ350gNSjGNqGNDH9Z
 ZZiyHZouH3DyljSHDDP1UxNPF4.ToPGtsoEg8NiZ0uBlAs_MEyF4ZbQCv2TaF4UFAS34BAMVwfnN
 rY0zYstkUPa2z1zB4qVMPa4jj8oA1Vc9uNTSdWRooQZu2R9mq74wo_YbXB1flY.OeDVANojiYpl0
 nGzvMlxwTNMpqGx2JtVIWL_vbgOjSM92H0u.qLhSpvyiaTBoMXQN9J_BhlX8ZY19IdBSoxdZJ.e5
 23kVMrUT1LG6hoFO3r66GCQOsX2xLY0xZRW7KGJxzGh0VH.qDKOrGlOQ8v2cDnT.LMRMfwAPVHZ.
 0ssMrZXIcIC5iS_W1os4TOOatOYHqZmd7JdTfIQc99TLfkFEewCp3o2lSDflJdy1IZW7uSIgeMk0
 o4dk4UI8mdXH0Yq9Yjf34HUGx5MemFMprWroX7XH.uVGu2wAronaROisVZoEPFQWNRKNG42pK.bd
 Yqxps4L7VwApwhAQHYrXDi9hhec0HF1VWUkHzVh2fNVLT1M345TUZl4ULEWyDOB3CMTvuSUlwbAc
 8WUZeXlxobAURc0BQ8ZvJSJpIGpnBaeP0.ZXWHkk9igDyiNw.ms6kkCT2Jcernf0lgrdJg0rmMnC
 XeyvvLBSbpVSgiH4nU29uV3i___1n1XZGNjjRrlG3qVGENrCCDKRqPJDh.KuTBU60JpZkqCFRe8_
 7rtEY5QeqzZu4Qw84Zemkhvk1uS3BN7GsG61Clr9IcowITIasZl3jPXOIkTzXWZG.VIuvThgGNQA
 ORwpGS1W5_4DxfuYs.zctITmrKtbdmx3Og.N52JvFtZvt3pimEe69UGsBWeabaX2hIDmePG1kQt1
 9gDCF36SG_LQhEV0iO1gcr_3o7cPyTpAqmLLq3wQhfI.qhRcmzLxf3cfxf2ypdvXPmNAU7Q47_4m
 SPa5Z60bDshpYyOTTg_dmY5ltoWmOgz_W2z9xcmBTu7Hb8tx3ituj25NkbfY0T61YYT5mUaztiwc
 C0adel_BzhZ3om5kn3oyTsuLFPGjlzvVcgbzHHQg9TJmhcz7g0MW8AjrUtn6BkCLBYvDLSKcmnQl
 dEujcRWkhW3sMoKzctz4d3YH26CZ3HjReSbGOwue6d8LZwBcnpBg.k56AqqUp4AsNxc2271CSNbl
 7ZwzvZi7F545zRB.teUr403hZRyks.AcwYKer16Calx4zsKseoSpokH.DicR0xEV3b3B2hNHY0vp
 QOZ5lPEsWvnG_O6C2qIXSSG2iBS9Wt8mosWxmxyh3FdO8nZHqDALq2trdSDv.6_r08GxqkKIrSA5
 owTu0jXhDdJSNtB1YhemTvWNiF_dcuPnnWzePEA6bbSQsh4Bl_W2R7fvic9BgGfOHymxGjgmiMBu
 loi2N3LP_NMFM4wnS7MrC2KpiVUhlfAAfQ_y_u1U5kYAIjpW4TqgbjtboFgcxsTlBx596xgzsPkl
 uF_YCDbC_XZ3byMRsRj4IpaaGKe4dAT5wKV1ieaPS.lh2OYC3RewyBmb_hFnFkg6sB7vDf.TYcI9
 Y7vlgelfbdBH1Jj2UEwWVsoPrp1egR6ChG2WjfqtJj8J.jeC.fC8LnpDOptNZC5NHo8QceWG8JeX
 ythCZWTfh4mMtnSHqGQVvJDRPvKoY59huGgNkj6JxWZTj6EOVq.RfQIJMvwMag5CHRGrn1RU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 Sep 2021 18:49:52 +0000
Received: by kubenode525.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4dfb39c1956f8d97a94ec7f2c98ebc53;
          Fri, 03 Sep 2021 18:49:48 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
 <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
 <YTI+k29AoeGdX13Q@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <91f894af-027f-3eb8-e86f-0d196084c0c5@schaufler-ca.com>
Date:   Fri, 3 Sep 2021 11:49:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTI+k29AoeGdX13Q@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/3/2021 8:26 AM, Vivek Goyal wrote:
> On Thu, Sep 02, 2021 at 03:34:17PM -0700, Casey Schaufler wrote:
>> On 9/2/2021 1:06 PM, Vivek Goyal wrote:
>>> On Thu, Sep 02, 2021 at 11:55:11AM -0700, Casey Schaufler wrote:
>>>> On 9/2/2021 10:42 AM, Vivek Goyal wrote:
>>>>> On Thu, Sep 02, 2021 at 01:05:01PM -0400, Vivek Goyal wrote:
>>>>>> On Thu, Sep 02, 2021 at 08:43:50AM -0700, Casey Schaufler wrote:
>>>>>>> On 9/2/2021 8:22 AM, Vivek Goyal wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> This is V3 of the patch. Previous versions were posted here.
>>>>>>>>
>>>>>>>> v2:
>>>>>>>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vg=
oyal@redhat.com/
>>>>>>>> v1:
>>>>>>>> https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-v=
goyal@redhat.co
>>>>>>>> +m/
>>>>>>>>
>>>>>>>> Changes since v2
>>>>>>>> ----------------
>>>>>>>> - Do not call inode_permission() for special files as file mode =
bits
>>>>>>>>   on these files represent permissions to read/write from/to dev=
ice
>>>>>>>>   and not necessarily permission to read/write xattrs. In this c=
ase
>>>>>>>>   now user.* extended xattrs can be read/written on special file=
s
>>>>>>>>   as long as caller is owner of file or has CAP_FOWNER.
>>>>>>>> =20
>>>>>>>> - Fixed "man xattr". Will post a patch in same thread little lat=
er. (J.
>>>>>>>>   Bruce Fields)
>>>>>>>>
>>>>>>>> - Fixed xfstest 062. Changed it to run only on older kernels whe=
re
>>>>>>>>   user extended xattrs are not allowed on symlinks/special files=
=2E Added
>>>>>>>>   a new replacement test 648 which does exactly what 062. Just t=
hat
>>>>>>>>   it is supposed to run on newer kernels where user extended xat=
trs
>>>>>>>>   are allowed on symlinks and special files. Will post patch in =

>>>>>>>>   same thread (Ted Ts'o).
>>>>>>>>
>>>>>>>> Testing
>>>>>>>> -------
>>>>>>>> - Ran xfstest "./check -g auto" with and without patches and did=
 not
>>>>>>>>   notice any new failures.
>>>>>>>>
>>>>>>>> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
>>>>>>>>   filesystems and it works.
>>>>>>>> =20
>>>>>>>> Description
>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>
>>>>>>>> Right now we don't allow setting user.* xattrs on symlinks and s=
pecial
>>>>>>>> files at all. Initially I thought that real reason behind this
>>>>>>>> restriction is quota limitations but from last conversation it s=
eemed
>>>>>>>> that real reason is that permission bits on symlink and special =
files
>>>>>>>> are special and different from regular files and directories, he=
nce
>>>>>>>> this restriction is in place. (I tested with xfs user quota enab=
led and
>>>>>>>> quota restrictions kicked in on symlink).
>>>>>>>>
>>>>>>>> This version of patch allows reading/writing user.* xattr on sym=
link and
>>>>>>>> special files if caller is owner or priviliged (has CAP_FOWNER) =
w.r.t inode.
>>>>>>> This part of your project makes perfect sense. There's no good
>>>>>>> security reason that you shouldn't set user.* xattrs on symlinks
>>>>>>> and/or special files.
>>>>>>>
>>>>>>> However, your virtiofs use case is unreasonable.
>>>>>> Ok. So we can merge this patch irrespective of the fact whether vi=
rtiofs
>>>>>> should make use of this mechanism or not, right?
>>>> I don't see a security objection. I did see that Andreas Gruenbacher=

>>>> <agruenba@redhat.com> has objections to the behavior.
>>>>
>>>>
>>>>>>>> Who wants to set user.* xattr on symlink/special files
>>>>>>>> -----------------------------------------------------
>>>>>>>> I have primarily two users at this point of time.
>>>>>>>>
>>>>>>>> - virtiofs daemon.
>>>>>>>>
>>>>>>>> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unp=
riviliged
>>>>>>>>   fuse-overlay as well and he ran into similar issue. So fuse-ov=
erlay
>>>>>>>>   should benefit from this change as well.
>>>>>>>>
>>>>>>>> Why virtiofsd wants to set user.* xattr on symlink/special files=

>>>>>>>> ----------------------------------------------------------------=

>>>>>>>> In virtiofs, actual file server is virtiosd daemon running on ho=
st.
>>>>>>>> There we have a mode where xattrs can be remapped to something e=
lse.
>>>>>>>> For example security.selinux can be remapped to
>>>>>>>> user.virtiofsd.securit.selinux on the host.
>>>>>>> As I have stated before, this introduces a breach in security.
>>>>>>> It allows an unprivileged process on the host to manipulate the
>>>>>>> security state of the guest. This is horribly wrong. It is not
>>>>>>> sufficient to claim that the breach requires misconfiguration
>>>>>>> to exploit. Don't do this.
>>>>>> So couple of things.
>>>>>>
>>>>>> - Right now whole virtiofs model is relying on the fact that host
>>>>>>   unpriviliged users don't have access to shared directory. Otherw=
ise
>>>>>>   guest process can simply drop a setuid root binary in shared dir=
ectory
>>>>>>   and unpriviliged process can execute it and take over host syste=
m.
>>>>>>
>>>>>>   So if virtiofs makes use of this mechanism, we are well with-in
>>>>>>   the existing constraints. If users don't follow the constraints,=

>>>>>>   bad things can happen.
>>>>>>
>>>>>> - I think Smalley provided a solution for your concern in other th=
read
>>>>>>   we discussed this issue.
>>>>>>
>>>>>>   https://lore.kernel.org/selinux/CAEjxPJ4411vL3+Ab-J0yrRTmXoEf8pV=
R3x3CSRgPjfzwiUcDtw@mail.gmail.com/T/#mddea4cec7a68c3ee5e8826d65002036103=
0209d6
>>>>>>
>>>>>>
>>>>>>   "So for example if the host policy says that only virtiofsd can =
set
>>>>>> attributes on those files, then the guest MAC labels along with al=
l
>>>>>> the other attributes are protected against tampering by any other
>>>>>> process on the host."
>>>> You can't count on SELinux policy to address the issue on a
>>>> system running Smack.
>>>> Or any other user of system.* xattrs,
>>>> be they in the kernel or user space. You can't even count on
>>>> SELinux policy to be correct. virtiofs has to present a "safe"
>>>> situation regardless of how security.* xattrs are used and
>>>> regardless of which, if any, LSMs are configured. You can't
>>>> do that with user.* attributes.
>>> Lets take a step back. Your primary concern with using user.* xattrs
>>> by virtiofsd is that it can be modified by unprivileged users on host=
=2E
>>> And our solution to that problem is hide shared directory from
>>> unprivileged users.
>> You really don't see how fragile that is, do you?
> Yes, I am not sure why we are so opposed to the idea of using=20
> user.* xattrs for storing the guest security.selinux xattrs by virtiofs=
d.
> And I am trying to understand that. And this discussion should help.
>
> With virtiofsd, we want to keep all shared directory trees in a
> parent directory which has read/write/search permissions only for root
> so that no unpriviliged process can get to files in shared directory
> and do any of the operations.
>
> For example, /var/lib/containers/storage setup by podman has
> following permissions.
>
> ll -d /var/lib/containers/storage/
> drwx------. 10 root root 4096 Jun 18  2020 /var/lib/containers/storage/=

>
> Now I should be able to create /var/lib/containers/storage/shared1
> directory and ask virtiofsd to export "share1" to guest. Unprivileged
> process on host can not open any of the files in shared1 dir, hence
> should not be able to modify any data/metadata associated with the
> file.
>
> If this assumption is correct, then I should be able to use "user.*"
> xattrs without having to worry about unprivileged processes modifying
> security labels of guest/nested-guest.

The only attributes you can really count on to protect an object
are the attributes on the object itself. Path based protections are
not reliable.


>> How a single
>> errant call to rename(), chmod() or chown() on the host can expose
>> the entire guest to exploitation. That's not even getting into
>> the bag of mount() tricks.
> I am relying on unpriviliged processes not having permissions to
> read/search in shared directory. And I guess I have to. Even if
> I use "trusted.*" xattrs, what about file data. Unpriviliged
> processes can modify file data and that's going to be equally
> problematic, isn't it? So why are we so focussed only on
> security label part of it.

We are concentrating on your proposed clever mapping trick.
We are doing so because it won't work, and when it blows up
into a full security bruhaha someone is going to try putting
the blame on the xattr mechanism.

>
> You have mentioned that file data is not necessarily
> that big a problem because UID 1000 on host and UID 1000 in guest
> should be treated same. But I am not sure we can do that. In kata
> container model, guest images are untrusted. So they can simply cook
> up UID 1000 or UID 0 or any other UID. Now there can be use
> cases where we are ready to trust guest and treat UID 1000
> on host and guest in same way. But primary model I am focussing
> on is that guest shared directory remains isolated from other
> users on host.

I don't have the time just now to examine the rest of virtiofs.
I am quite afraid that you are making dangerous assumptions on
a number of things. It sure doesn't sound like you've thought
through all of the implications of sharing between the host and
guest.

>>> In addition to that, LSMs on host can block setting "user.*" xattrs b=
y
>>> virtiofsd domain only for additional protection.
>> Try thinking outside the SELinux box briefly, if you possibly can.
>> An LSM that implements just Bell & LaPadula isn't going to have a
>> "virtiofs domain". Neither is a Smack "3 domain" system. Smack doesn't=

>> distinguish writing user xattrs from writing other file attributes
>> in policy. Your argument requires a fine grained policy a'la SELinux.
>> And an application specific SELinux policy at that.
> Ok, so does we have to have capability for every LSM to block write
> to user xattr. I mean in above example, virtiofsd is relying on DAC so =
that
> unprivileged processes can't modify user xattr labels. If we were to
> use "trusted.*" xattr then we are relying on CAP_SYS_ADMIN.
>
> IOW, it will be nice if one or more LSMs can provide mechanism fine
> grained enough to block write to user xattr by unwanted application
> and that provides extra level of security. But should it be mandatory?

No. The behavior of user xattrs is just fine the way it is.
It works as designed.=20

>
>>>  If LSMs are not configured,
>>> then hiding the directory is the solution.
>> It's not a solution at all. It's wishful thinking that
>> some admin is going to do absolutely everything right, will
>> never make a mistake and will never, ever, read the mount(2)
>> man page.
> I agree that its easy to make mistakes. But making mistakes is already
> disastrous. So lets say and admin makes mistake and unprivileged
> processes can open/read/write files in shared directory on host.
> Assume I am using "trusted" xattrs to store guest's security labels.
>
> Now file's data can be modified on host in unwated way and be very
> problematic.
>
> Guest can drop a setuid root binary in shared directory and unprivilege=
d
> process on host can run it and take over the system.
>
> Isn't that even bigger problem. So to me making sure shared directory
> is not reachable by unprivileged processes is absolute must requirement=

> for virtiofsd (when running as root). If we break that assumption,
> we already have much bigger problems.

I can't help but think you probably do already have much bigger problems.=


>>> So why that's not a solution and only relying on CAP_SYS_ADMIN is the=

>>> solution. I don't understand that part.
>> It comes back to your design, which is fundamentally flawed. You
>> can't store system security information in an attribute that can
>> be manipulated by untrusted entities.
> You are assuming untrusted entities can have access to the shared dir. =
But
> assumption in this model is, shared directory is not reachable by
> unprivileged entities. If we break that requirement, there are much
> bigger issues to deal with then just security attributes.

That's a bad assumption. You have all sorts of issues.

>
>> That's why we have system.*
>> xattrs. You want to have an attribute on the host that maps to a
>> security attribute on the guest. The host has to protect the attribute=

>> on the guest with mechanisms of comparable strength as the guest's
>> mechanisms. Otherwise you can't trust the guest with host data.
> Ok, I understand your desire that security xattrs as seen by guest kern=
el
> should be protected by something stronger than simply user xattr.
>
>> It's a real shame that CAP_SYS_ADMIN is so scary. The capability
>> mechanism as implemented today won't scale to the hundreds of individu=
al
>> capabilities it would need to break CAP_SYS_ADMIN up. Maybe someday.
>> I'm not convinced that there isn't a way to accomplish what you're
>> trying to do without privilege, but this isn't it, and I don't know
>> what is. Sorry.
>>
>>> Also if directory is not hidden, unprivileged users can change file
>>> data and other metadata.
>> I assumed that you've taken that into account. Are you saying that
>> isn't going to be done correctly either?
> I am relying on shared directory not accessible to unprivileged process=
es.
> If that assumption is broken, I guess,  all bets are off. Until and unl=
ess
> one designs SELinux (or other LSM) policy in such a way so that
> only virtiofsd can read/write to these shared directories.
>
> I think Dan Walsh has got SELinux policy written for atleast kata
> containers case.
>
> So I guess we will rely on MAC to block unwanted access if users
> make a mistake? Is that the idea? I guess that's why you want
> a stronger mechansim to store guest security xattrs on host. If
> users make a mistake then we have a fallback path?
>
>>>  Why that's not a concern and why there is
>>> so much of focus only security xattr.
>> As with an NFS mount, the assumption is that UID 567 (or its magically=

>> mapped equivalent) has the same access rights on both the server/host
>> and client/guest. I'm not worried about the mode bits because they are=

>> presented consistently on both machines. If, on the other hand, an
>> attribute used to determine access is security.esprit on the guest and=

>> user.security.esprit on the host, the unprivileged user on the host
>> can defeat the privilege requirements on the guest. That's why.
> Hmm..., so if a user id 1000 inside guest can't modify security
> xattrs then same user on host should be allowed to bypass that
> by modifying user xattr. I agree with that.
>
> Just that I am relying on shared directory not being accessible
> to uid 1000 on host and you don't want to rely on that because
> users can easily make mistake. And that's why want to stronger
> form of mechanism to store security xattrs.
>
>>>  If you were to block modification
>>> of file then you will have rely on LSMs.
>> No. We're talking about the semantics of the xattr namespaces.
>> LSMs can further constrain access to xattrs, but the basic rules
>> of access to the user.* and security.* attributes are different
>> in any case. This is by design.
>>
>>>  And if LSMs are not configured,
>>> then we will rely on shared directory not being visible.
>> LSMs are not the problem. LSMs use security.* xattrs, which is why
>> they come up in the discussion.
>>
>>> Can you please help me understand why hiding shared directory from
>>> unprivileged users is not a solution
>> Maybe you can describe the mechanism you use to "hide" a shared direct=
ory
>> on the host. If the filesystem is mounted on the host it seems unlikel=
y
>> that you can provide a convincing argument for sufficient protection.
> I am relying on changing direcotry permissions to allow read/write/sear=
ch
> permission to root only.

Then you have a real mess of problems coming your way. Sorry.

>
> Thanks
> Vivek
>

