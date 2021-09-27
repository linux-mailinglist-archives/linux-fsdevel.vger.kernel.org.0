Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93328419DAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhI0R6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 13:58:44 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:33212
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235595AbhI0R6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632765425; bh=MAwaZNXA1KbCqX8rZ4gfggUS7fvxsW70kf/LLMAPu9I=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=RM7rBviwwEJCSRjaT+FG8Gr+7GscDJeiriP382fBJyBnL6v7ONj0zDzf8TsPQceteQW5QB8XjaRKXcJ1o/gXKFq67kCSiQy+Sv4blknk3CMYfHi31npvFmaOmlifsub4kNaTrmcYZqxLSD6tdDy0Ot9jGEWsiT8d9uGahWlCAjNwbg2V6HUiW1cqeKHI9ivr6V4rk3y4ooxXjpOMASooaD/dl+pic7Mkg7jW4nAn/Uz/lCX9LWzXPqeFCUmrHScAZgE2S+0GUVp8LRgcDpznnv9bb6ylB8SdZKapz5tHRsbuPtmdrSbpva4QyJ8Luxmg5YKB1/QR6wFNgmcb8ubQ7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632765425; bh=eyKEdYgXS8G8E+pj1CsHw3Ch46873WsjL/1tKGA5qUf=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=dz6XuVZJ+pOsV06zkhi83LRzKTJCOFg6+jU5iLKxfRdccohqIuzQ5jjH3z18rwDR+NnpXnbXx/JEpHb1kdSj0f9PbhAq4gzXE0Vlh4OSxXcEYAbtddZTI8kftiG9epTq7aZqDxVJTezE4lG0GYC1jCBPUVjR4pLQQlKdAa5WlpR6SQMmHe4iXAJhWFM8Dhg99cfqzDw0k7kgATP7uFMFUVpYfVGvP4B0GxBeHIQr2zHrhPqFGo52j5WZqFT0vvv77E74jSvEwHPJTyIspKnJ5Ztchh4/a5qxHJrYfSLO0owRxHsGMgdkUwEj1iqcbW33VSKnal8/P8ev/SRbX6JRmw==
X-YMail-OSG: fOSXySIVM1lD3kt7n4fRb.qxhUDPnI1RU3e6bXHghTc19XBDutAcgeH7dsldE1h
 2RLpCcijiJ9pXbPI10G6OZrmdjb1OQOK1.mF5I.MTKEvIvrNK3bIR_tucsh9vp5pGrDVDFrF4UsK
 LOALurozX.eYG_uv4PiVtCfjCkGMMSyzNDkdtPtO4m0iQsLwO_hpo39j1fSr6l6vxXWtYeKyo13b
 UMTM3k34.zQabyrPTZaObApKu5hp.egJla.92IdXU6wFfu7Qx7lfT_xHoNN8m284xOg6j2nOymvn
 99eV5xRg3pfwIosCZlAcGV3oYULh_C5c4lfDY5K09.JrrMPbDS9z_XVUiVtc_Ad.J8iXcmh5gJ4u
 d_d7LBU_yU...32RH4qT6Qamb_Ofb_NXXbs5hCp0U5tY9YronRFpP8Yc12_kd48mVCyXCNcQCo5W
 tbyG6YNSL7wcHNw1khCX6I5prQsFfC29aQ7.dTjcIW3jeVF3WbSMI2P8NuZyG0iCWKsfBmYrg5b4
 dDno_OZS.sDgdfyTfr41qG5lB0LqZxgly3_DkZF8Quoa69.Dtduhk1by9Li1kMUgHI8s7wBmgWsh
 EQYQderwBzNto2Zbqm112rax4zuIoPJK5nu.XBdlv42rIAYRWVaJPMYR7smpW_TC5ICStxkFhKkC
 r7ln74YNtMaUjima7CBpfn.xy21C.dEi2nFiI0lpzcw8wjvI.KuVt1NVhTIHqzVSaX9aCeLOS5Zx
 XaBWyMjiNmYvtv.WJF8JNtqVGmbul72G.cpl0Z_6x7Z44.9bgB0JYN1RHN7fSMMNGEVnFh5L7Efd
 FJrbD4GckdpFTxIIX196g9eQIdDZaSAETTENJs6ZteECiQuqNXdgAmG.qSk4q5lKqSnwr6hu.LsR
 Y1AogRk2B6JuXmlNZZQD0Pr.PUtLJvofN5g.oeCtbzrBrNa6ZJVc568NzOpSpkCmLAK5Vcs.6hwf
 bbj8idrkzDkFpNyBJw52pXmYGeITllFenlO0R8mJgPcC8JeMkxlSy4lSNSE.fUlypNiicu5b073g
 roGDvsuQZGQ8xeikuMzpHnN4LZtq7I.aBpUyRB__ubW91taMpiRDAczeA851XAkHGaLNFdvT72rv
 9F8k3dkqUuhXbkbKKNRCmFY7DiTcCfFDWgA8VBRs_IDPgzNyniTw.rEy0PkPNMnOddgDcdH2W4bK
 ccpp9Escho4UZTJkMEuHDArZaqD1oHl03wKJrZ_jKtz0ZYINgn3.U8NDYzg8dfJdiuUplnD1y8t0
 zeKkQVzI1UYq3ZwNSCk0HxH8qp.iBG6xLmi6U6nTTkxGKK6UQODZfR9Y3TUIyhittsg0WOdUaLL9
 p2bJOES6K1uO.431JpUkcKm0FlbmeD75DuxImvocADowwckKVhaAV.D2t3oNnqpQU4ymMG1HKBZx
 HhS0CrrmmCQL4Cu9qhmlrX8tfwXqwo0I.HKUfcXXbEm8zmvnaYNrqDINJeRpmGBw7bZm5fZC.L_Q
 tkIaqOY5IGGM6SnHc7knXwwDpzXEolv6sLAdWV7vx4jyoYoJ_oLKwpeLjAuWuMrtFN12pQ41YPpQ
 R_Buo.xNoKpZ38Br9_7yKMeVhub2ZqtaDhT8_M_CqyX.a2MXBdGO1kuUY8rNd8uuAIYjASw4SXtM
 OO2mS1N.FCStlgGmPPMRvEpwHspd_YewWKF.NDx7xfxSg9rKruNFp9AmtYuN5TIkY1e2kHxG7bNq
 brH0pHqD6PgFX2IUbUtgQgY8bwKmyH6z0UgZH.R928h9yRlAj.7cxLxjgA4c1RT4ptEUIAOQsL4Y
 gGyesOGh6ga3AiNeSmmemlJ22TH8WQqN8AbPwR42LV8o167XZK8zeIWGtWuB2qk9580mIrEhjVKd
 LqN3zhDOUAjUlK4boA0MpeLsjNMQsgi8G8pHIg_Ejd5hKWIo8aY42ePSt8vf1WrHLvchrSMhoY9G
 CxKoRficuwRf1Y7ZB0l3e53K1XjZ7uTwA_VnFGIfJ7DLYj.1AulX9T88jW_s45GXTb6N6dtTwLWH
 NoW9Z9V8Sf26L2MCzTEU0yF_HRCFgvs_9EY2aXUZM1A.L9UxMQ7ytIWtI6o64UQusOtmzARVkgVc
 Gf3Gn0H7kkhW4ZkevDA2k579vNZdLxqGQI0bX92Ni9c793ELeeZbLPIs09LB8xzDs7r9SNKKihNh
 _i0KIjOVWBzN08UdZyUWjaphdj1jCyB3b3U3JKT.LTpXFfaxGLGdo8VMtj3m9.f2jiEsElZHIdIb
 bqz7QFbW3pl15G3MDRGbfNO0DQoNRD9iPa89yoJ3U44idps.GvD4K5gKKnzgK_Zk_kgNs_0e0_tA
 FkhlVLpc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Sep 2021 17:57:05 +0000
Received: by kubenode585.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3baa5e9cbccd1499411aa4dd1da50415;
          Mon, 27 Sep 2021 17:57:03 +0000 (UTC)
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        chirantan@chromium.org, Miklos Szeredi <miklos@szeredi.hu>,
        stephen.smalley.work@gmail.com, Daniel J Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
 <a02d3e08-3abc-448a-be32-2640d8a991e0@www.fastmail.com>
 <YU5gF9xDhj4g+0Oe@redhat.com>
 <8a46efbf-354c-db20-c24a-ee73d9bbe9d6@schaufler-ca.com>
 <YVHPxYRnZvs/dH7N@redhat.com>
 <753b1417-3a9c-3129-1225-ca68583acc32@schaufler-ca.com>
 <YVHpxiguEsjIHTjJ@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <67e49606-f365-fded-6572-b8c637af01c5@schaufler-ca.com>
Date:   Mon, 27 Sep 2021 10:56:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVHpxiguEsjIHTjJ@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19043 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2021 8:56 AM, Vivek Goyal wrote:
> On Mon, Sep 27, 2021 at 08:22:48AM -0700, Casey Schaufler wrote:
>> On 9/27/2021 7:05 AM, Vivek Goyal wrote:
>>> On Sun, Sep 26, 2021 at 05:53:11PM -0700, Casey Schaufler wrote:
>>>> On 9/24/2021 4:32 PM, Vivek Goyal wrote:
>>>>> On Fri, Sep 24, 2021 at 06:00:10PM -0400, Colin Walters wrote:
>>>>>> On Fri, Sep 24, 2021, at 3:24 PM, Vivek Goyal wrote:
>>>>>>> When a new inode is created, send its security context to server =
along
>>>>>>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUS=
E_SYMLINK).
>>>>>>> This gives server an opportunity to create new file and set secur=
ity
>>>>>>> context (possibly atomically). In all the configurations it might=
 not
>>>>>>> be possible to set context atomically.
>>>>>>>
>>>>>>> Like nfs and ceph, use security_dentry_init_security() to dermine=
 security
>>>>>>> context of inode and send it with create, mkdir, mknod, and symli=
nk requests.
>>>>>>>
>>>>>>> Following is the information sent to server.
>>>>>>>
>>>>>>> - struct fuse_secctx.
>>>>>>>   This contains total size of security context which follows this=
 structure.
>>>>>>>
>>>>>>> - xattr name string.
>>>>>>>   This string represents name of xattr which should be used while=
 setting
>>>>>>>   security context. As of now it is hardcoded to "security.selinu=
x".
>>>>>> Any reason not to just send all `security.*` xattrs found on the i=
node?=20
>>>>>>
>>>>>> (I'm not super familiar with this code, it looks like we're going =
from the LSM-cached version attached to the inode, but presumably since w=
e're sending bytes we can just ask the filesytem for the raw data instead=
)
>>>>> So this inode is about to be created. There are no xattrs yet. And
>>>>> filesystem is asking LSMs, what security labels should be set on th=
is
>>>>> inode before it is published.=20
>>>> No. That's imprecise. It's what SELinux does. An LSM can add any
>>>> number of attributes on inode creation, or none. These attributes
>>>> may or may not be "security labels". Assuming that they are is the
>>>> kind of thinking that leads people like Linus to conclude that the
>>>> LSM community is clueless.
>>>>
>>>>
>>>>> For local filesystems it is somewhat easy. They are the one creatin=
g
>>>>> inode and can set all xattrs/labels before inode is added to inode
>>>>> cache.
>>>>>
>>>>> But for remote like filesystems, it is more tricky. Actual inode
>>>>> creation first will happen on server and then client will instantia=
te
>>>>> an inode based on information returned by server (Atleast that's
>>>>> what fuse does).
>>>>>
>>>>> So security_dentry_init_security() was created (I think by NFS folk=
s)
>>>>> so that they can query the label and send it along with create
>>>>> request and server can take care of setting label (along with file
>>>>> creation).
>>>>>
>>>>> One limitation of security_dentry_init_security() is that it practi=
cally
>>>>> supports only one label. And only SELinux has implemented. So for
>>>>> all practical purposes this is a hook to obtain selinux label. NFS
>>>>> and ceph already use it in that way.
>>>>>
>>>>> Now there is a desire to be able to return more than one security
>>>>> labels and support smack and possibly other LSMs. Sure, that great.=

>>>>> But I think for that we will have to implement a new hook which
>>>>> can return multiple labels and filesystems like nfs, ceph and fuse
>>>>> will have to be modified to cope with this new hook to support
>>>>> multiple lables.=20
>>>>>
>>>>> And I am arguing that we can modify fuse when that hook has been
>>>>> implemented. There is no point in adding that complexity in fuse
>>>>> code as well all fuse-server implementations when there is nobody
>>>>> generating multiple labels. We can't even test it.
>>>> There's a little bit of chicken-and-egg going on here.
>>>> There's no point in accommodating multiple labels in
>>>> this code because you can't have multiple labels. There's
>>>> no point in trying to support multiple labels because
>>>> you can't use them in virtiofs and a bunch of other
>>>> places.
>>> Once security subsystem provides a hook to support multiple lables, t=
hen
>>> atleast one filesystem will have to be converted to make use of this =
new
>>> hook at the same time and rest of the filesystems can catch up later.=

>> Clearly you haven't been following the work I've been doing on
>> module stacking. That's completely understandable. There aren't
>> new hooks being added, or at least haven't been yet. Some of the
>> existing hooks are getting changed to provide the data required
>> for multiple security modules (e.g. secids become a set of secids).
>> Filesystems that support xattrs properly are unaffected because,
>> for all it's shortcomings, the LSM layer hides the details of
>> the security modules sufficiently.=20
>>
>> Which filesystem are you saying will have to "be converted"?
> When I grep for "security_dentry_init_security()" in current code,
> I see two users, ceph and nfs.

Neither of which support xattrs fully. Ceph can support them properly,
but does not by default. NFS is ancient and we've talked about it at
length. Also, the fact that they use security_dentry_init_security()
is a red herring. Really, this has no bearing on the issue of fuse.

>
> fs/ceph/xattr.c
> ceph_security_init_secctx()
>
> fs/nfs/nfs4proc.c
> nfs4_label_init_security()
>
> So looks like these two file systems will have to be converted
> (along with fuse).
>
> Vivek
>
>> NFS is going to require some work, but that's because it was
>> done as a special case for "MAC labels". The NFS support for
>> security.* xattrs came much later. This is one of the reasons
>> why I'm concerned about the virtiofs implementation you're
>> proposing. We were never able to get the NFS "MAC label"
>> implementation to work properly with Smack, even though there is
>> no obvious reason it wouldn't.
>>
>>
>>> Vivek
>>>

