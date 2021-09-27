Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2B741A009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 22:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhI0UVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 16:21:11 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:43828
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236897AbhI0UVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632773971; bh=yzMPE1mATSzrxN5uXVIrrY+ksNNliMJpjtBVuJJXRco=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=dVUPiw2ydtLdVgJG8AFCIfBf+PwCUA5YVD/oyF0DaneZViSB8sh6UGG/3q2+xtfngv2fE6VLedjIywYMeWjjFWV+Qd93XvnZKEfrZb1P+raoVTqSj1n5iPG/TCs7Ail4Ss2e92MSGiugjs6eCAvXgp1K1g/j/BqYJ/oHi3bsnAi1N0JQdkQxFqd5OycH/cSwJk5z6mltVAN4Gd9DLna1MGavhD8J8UsG5ZN3yry5b4X80jwh1MNJ3cE3vykm32jJn8Lq7TsgYEB9Q9R+e9r9gWbUnSeKAr+NWKcZVc60whX1iQJnvfkP8yxh9z+feWxNUrC3dkRJrVXrAQVyuFCIQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632773971; bh=Q/5P8B+DgopLtOomiXk59IMD/NwnIUhC16KrX2LIC59=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=X5RZkViJJqH/NnAhVSN9iGj0ixgqdOo5ya78b9RC9DQR8cp80fgY7+sb2Ukqasm0NaqHm9AFU0aGB+SBVktt20h+U3rvH+6e3ldXvD2GSHfSOXp46Yw4lt56SayUthkPsX7AQc0jIEoQvVFSVOfmw48vceFqE9L6aAK1HlmmYGPYbpyP3MaOtgMUrXhTwAqddovLJeV4V2uQDVn1e1HmBu7rjU17cXYAL8jet3iIcT3zgo+91lnoDPdsxs+JnxVibIKtK+nGYccPigi65vYaxXhww72l3V3RYl8ckCg7j72sdYNX8Dj8k8dHAnjxcFnsTqxhxj1/0+/QyklAlgzlTg==
X-YMail-OSG: pd0deXgVM1n0fXGRDDEjoVkDdzj0aNfIDNEYh2_NRj.phd2IFM7KYWjJNhor1Hp
 waFpmHIoXVIbM5GrJIZpVqxC1qJ5H0L9YUZ.UuOG9m6op4nmfRR_6fFFMWnI35uT.mrJtMqAq5kL
 dQabh3toq7xiv30x5pAFvcE.tBUSbQeAhyt6oWW2ml0NFKhB6fxYHHuAX9sUuqTaQYFcdt2.NsaS
 Ien8mj8lUpDCPk98q5tTFcOWUf7QN47MzQ._s5bbrDRXljsqnlTmRrT1cHH00k8RZBtFw0h7mXmJ
 TMkifPoo3SIygIhELqhCZj99ADJuxF6lAs.s2IweUikNR1FqrXLR3k2V3Y.uIO23vRDm8iUtUcyP
 6VimfLwcEz6OFKrs7r_FagGR1EQ9VPXcjIKrLhHLkyinNCnzlV6aYK91ZayfreXAQesO9uF7c6Iv
 Mh3VCKzqegqj7SxadFLxtmcxNa4bbV6bZyPXqNDrhlSGXktp5hGsUazL3ERzleht3hTdrtLr5T7X
 TwZF0f_mthcgVHoL79qu5Ji3aJeQvm.9PIQLlAThvUwZlUzXtp4Rqmuc_nmuwVOpjvUepOjcRn0s
 cPoL8prDp2ogeQ8xs.PcUQ3K_9ryJ5RM.DXAnQBY1JD5VKThJDJNC50KBaQ6DsB6aioKMvfa0jXS
 cQYKg5VM_kv9Gg3Lh4FP4nEUjaDhAAUrIAh5XqpiiKiMJZjGf9Qe.FleeSCii7K9pLG0TF.vfJWd
 0huLBDxs.QToOsv.7EWwCx_MCeiW74TpPNYy4UeDxdeenyUPvBg5g_Dc60paS8K1EFaA5Rl3siNd
 aJFHR5ILnmh0HxEuJTHtocC.vinr9UGyvSZSu6S1CePJdCk5bsvijWWHDdVUu60XzyUZQFmdUtlQ
 0..GN4yhkfhGy.ehS4mCfAqRldJHD095r6gfPdy7rrfL9S.6H1Cbtl7MQ6lb7J7T4hal0bKVp4po
 PZZJBH7CAzYBsbGuJLK4DXYOdkWxOG6P.2aHy5HumX2RxTrEVWhebgDB6tKC2zcruVcCLiGVcMYv
 TVFCzujwQJ41rUUuRDAYTzskuOEFCkkZ9loYbrxPXmR0cxn8IZ.7sjYNNonA__aOBiGcOXZto_4p
 pDfbc06WE_C02WlCTsXSC6kzfecpUQxkomNmbniIq166.MKkizJVFLZ8XCzCIYZM.7ViIIlPHoZH
 NG7WagFTx0r.33RXzZ55AIDAMHC5aH1wb.hldbef8Z4K2naTbrPd.v195P0Vo32togdlewM7bJ7Z
 9Qfq5Y_wLsgIdQkfIyltCtbP03x561FHS717WtCxQE210iK3gb5Mt8QXBw2baMFs7.KShEoRvkPH
 eT9RpNgK4IbIUQvs6cXCn.xAumtwnSLpnSr1Az_c0VTmyuiYXil.ghjkNl1jmlrzVvjPgdtjGKyQ
 ABYelwJNie7pY3DkedM5BgIgzUChGcyVxh1dDa_gXH_glfr7_JGjkpZfJa0gMig0TVx9DNmZI1C0
 ogAo8kpwBS3483f5zA_u5xFErBEBbvZKFN2vKSketnkEjRcRHynGTqhQuRRLaBsDGyBd8V5Qszcl
 bG79IsbgC.SMsk9WaJhXCzYDTdEmjuspIhiZm.9ewGJ.m.rFTNs3KdQObUeSGaX5VP2wOv6d6AAR
 S3jTgGzZgTbA2y.xNs68AJFbitXi5brjx55BDXfKBFt.LgTmnDoZ0XdZb534vm5d3lUS.C5aN_mO
 fKhHpd5bbPGXhmF2GfytzgSjkLLeOMtFDD3BaGN5yQVJJCovO0eQMEqbigwb4Yxpa6wVydWNHTCQ
 sB.XX9qHE4_PTV5zC_9kb3ttvaBA71soIgxg8TWHx7IMbPbhfFuoSlqWC2uvm8toL8xA3yzGgngh
 co.HVr4FL2EqQg509Bjy2CCF1T4cax6inOUSRLAGRGl61X4mZMDqFRtSlpv2gU_E8Eev8O5vU60f
 39gGwGxEfOGlIZlVlhOcb2rwIAeS_K2bMwtkr2pwFhg2UKuIX8vOrWdPQJRIVj8zOi6sJxo882Gl
 .8WFv9JznLojqbulKMfEm8h70p.jdHuWbiE.ceNcggiMbUTAdM1oR39gAa2wauQwe2U9kZC.X2gC
 GyhluHPX1TyU1u.BCze59c1Vbb6LJt9_.YfYqI1cDYEqFpHkCFzbx.tMO9XbpTnlN373P0agSHaQ
 ls4lD3Q8PDAdwVancYZnJOXmqsUh_5VvLEG4XaxQ.peoNib5GxIXHYAlmRUN63dl8vdaiURZLMkF
 HRtvJqdVfgDymJHope54HNpsE7RSO1iSntq5lgh6CsiR70_Jsx4s5BQdBK38frkeGjglJIS7QrXx
 wJi.igVeSeD8tyAf_SAFK5i4yhivCi3ldlWWg5QjhSpO_n.xq_x0Xp5AIDvsm
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Sep 2021 20:19:31 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4cc94631fcc82868c692551b4a982cbe;
          Mon, 27 Sep 2021 20:19:27 +0000 (UTC)
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
 <67e49606-f365-fded-6572-b8c637af01c5@schaufler-ca.com>
 <YVIZfHhS4X+5BNCS@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2e00fbff-b868-3a4f-ecc4-e5f1945834b8@schaufler-ca.com>
Date:   Mon, 27 Sep 2021 13:19:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVIZfHhS4X+5BNCS@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19043 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2021 12:20 PM, Vivek Goyal wrote:
> On Mon, Sep 27, 2021 at 10:56:59AM -0700, Casey Schaufler wrote:
>> On 9/27/2021 8:56 AM, Vivek Goyal wrote:
>>> On Mon, Sep 27, 2021 at 08:22:48AM -0700, Casey Schaufler wrote:
>>>> On 9/27/2021 7:05 AM, Vivek Goyal wrote:
>>>>> On Sun, Sep 26, 2021 at 05:53:11PM -0700, Casey Schaufler wrote:
>>>>>> On 9/24/2021 4:32 PM, Vivek Goyal wrote:
>>>>>>> On Fri, Sep 24, 2021 at 06:00:10PM -0400, Colin Walters wrote:
>>>>>>>> On Fri, Sep 24, 2021, at 3:24 PM, Vivek Goyal wrote:
>>>>>>>>> When a new inode is created, send its security context to serve=
r along
>>>>>>>>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and F=
USE_SYMLINK).
>>>>>>>>> This gives server an opportunity to create new file and set sec=
urity
>>>>>>>>> context (possibly atomically). In all the configurations it mig=
ht not
>>>>>>>>> be possible to set context atomically.
>>>>>>>>>
>>>>>>>>> Like nfs and ceph, use security_dentry_init_security() to dermi=
ne security
>>>>>>>>> context of inode and send it with create, mkdir, mknod, and sym=
link requests.
>>>>>>>>>
>>>>>>>>> Following is the information sent to server.
>>>>>>>>>
>>>>>>>>> - struct fuse_secctx.
>>>>>>>>>   This contains total size of security context which follows th=
is structure.
>>>>>>>>>
>>>>>>>>> - xattr name string.
>>>>>>>>>   This string represents name of xattr which should be used whi=
le setting
>>>>>>>>>   security context. As of now it is hardcoded to "security.seli=
nux".
>>>>>>>> Any reason not to just send all `security.*` xattrs found on the=
 inode?=20
>>>>>>>>
>>>>>>>> (I'm not super familiar with this code, it looks like we're goin=
g from the LSM-cached version attached to the inode, but presumably since=
 we're sending bytes we can just ask the filesytem for the raw data inste=
ad)
>>>>>>> So this inode is about to be created. There are no xattrs yet. An=
d
>>>>>>> filesystem is asking LSMs, what security labels should be set on =
this
>>>>>>> inode before it is published.=20
>>>>>> No. That's imprecise. It's what SELinux does. An LSM can add any
>>>>>> number of attributes on inode creation, or none. These attributes
>>>>>> may or may not be "security labels". Assuming that they are is the=

>>>>>> kind of thinking that leads people like Linus to conclude that the=

>>>>>> LSM community is clueless.
>>>>>>
>>>>>>
>>>>>>> For local filesystems it is somewhat easy. They are the one creat=
ing
>>>>>>> inode and can set all xattrs/labels before inode is added to inod=
e
>>>>>>> cache.
>>>>>>>
>>>>>>> But for remote like filesystems, it is more tricky. Actual inode
>>>>>>> creation first will happen on server and then client will instant=
iate
>>>>>>> an inode based on information returned by server (Atleast that's
>>>>>>> what fuse does).
>>>>>>>
>>>>>>> So security_dentry_init_security() was created (I think by NFS fo=
lks)
>>>>>>> so that they can query the label and send it along with create
>>>>>>> request and server can take care of setting label (along with fil=
e
>>>>>>> creation).
>>>>>>>
>>>>>>> One limitation of security_dentry_init_security() is that it prac=
tically
>>>>>>> supports only one label. And only SELinux has implemented. So for=

>>>>>>> all practical purposes this is a hook to obtain selinux label. NF=
S
>>>>>>> and ceph already use it in that way.
>>>>>>>
>>>>>>> Now there is a desire to be able to return more than one security=

>>>>>>> labels and support smack and possibly other LSMs. Sure, that grea=
t.
>>>>>>> But I think for that we will have to implement a new hook which
>>>>>>> can return multiple labels and filesystems like nfs, ceph and fus=
e
>>>>>>> will have to be modified to cope with this new hook to support
>>>>>>> multiple lables.=20
>>>>>>>
>>>>>>> And I am arguing that we can modify fuse when that hook has been
>>>>>>> implemented. There is no point in adding that complexity in fuse
>>>>>>> code as well all fuse-server implementations when there is nobody=

>>>>>>> generating multiple labels. We can't even test it.
>>>>>> There's a little bit of chicken-and-egg going on here.
>>>>>> There's no point in accommodating multiple labels in
>>>>>> this code because you can't have multiple labels. There's
>>>>>> no point in trying to support multiple labels because
>>>>>> you can't use them in virtiofs and a bunch of other
>>>>>> places.
>>>>> Once security subsystem provides a hook to support multiple lables,=
 then
>>>>> atleast one filesystem will have to be converted to make use of thi=
s new
>>>>> hook at the same time and rest of the filesystems can catch up late=
r.
>>>> Clearly you haven't been following the work I've been doing on
>>>> module stacking. That's completely understandable. There aren't
>>>> new hooks being added, or at least haven't been yet. Some of the
>>>> existing hooks are getting changed to provide the data required
>>>> for multiple security modules (e.g. secids become a set of secids).
>>>> Filesystems that support xattrs properly are unaffected because,
>>>> for all it's shortcomings, the LSM layer hides the details of
>>>> the security modules sufficiently.=20
>>>>
>>>> Which filesystem are you saying will have to "be converted"?
>>> When I grep for "security_dentry_init_security()" in current code,
>>> I see two users, ceph and nfs.
>> Neither of which support xattrs fully. Ceph can support them properly,=

>> but does not by default. NFS is ancient and we've talked about it at
>> length. Also, the fact that they use security_dentry_init_security()
>> is a red herring. Really, this has no bearing on the issue of fuse.
> Frankly speaking, I am now beginning to lose what's being asked for,
> w.r.t this patch.

1. Support for multiple concurrent security.* xattrs
2. Abandon mapping security.* attrs to user.* xattrs

> I see that NFS and ceph are supporting single security label at
> the time of file creation and I added support for the same for
> fuse.

NFS took that course because the IETF refused for a very long time
to accept a name+value pair in the protocol. The implementation
was a compromise.

>
> You seem to want to have capability to send multiple "name,value,len"
> tuples so that you can support multiple xattrs/labels down the
> line.

No, so I can do it now. Smack keeps multiple xattrs on filesystem objects=
=2E
	security.SMACK64		- the "security label"
	security.SMACK64EXEC		- the Smack label to run the program with
	security.SMACK64TRANSMUTE	- controls labeling on files created

There has been discussion about using additional attributes for things
like socket labeling.

This isn't hypothetical. It's real today.=20

> Even if I do that, I am not sure what to do with those xattrs at
> the other end. I am using /proc/thread-self/attr/fscreate to
> set the security attribute of file.

Either you don't realize that attr/fscreate is SELinux specific, or
you don't care, or possibly (and sadly) both.

>
> https://listman.redhat.com/archives/virtio-fs/2021-September/msg00100.h=
tml
>
> How will this work with multiple labels. I think you will have to
> extend fscreate or create new interface to be able to deal with it.

Yeah. That thread didn't go to the LSM mail list. It was essentially
kept within the RedHat SELinux community. It's no wonder everyone
involved thought that your approach is swell. No one who would get
goobsmacked by it was on the thread.

>
> That's why I think that it seems premature that fuse interface be
> written to deal with multiple labels when rest of the infrastructure
> is not ready. It should be other way, instead. First rest of the
> infrastructure should be written and then all the users make use
> of new infra.

Today the LSM infrastructure allows a security module to use as many
xattrs as it likes. Again, Smack uses multiple security.* xattrs today.

> BTW, I am checking security_inode_init_security(). That seems to
> return max 2 xattrs as of now?
>
> #define MAX_LSM_EVM_XATTR       2
> struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];

You're looking at the bowels of the EVM subsystem. That herring is red, t=
oo.

> So we are allocating space for 3 xattrs. Last xattr is Null to signify
> end of array. So, we seem to use on xattr for LSM and another for EVM.
> Do I understand it correctly. Does that mean that smack stuff does
> not work even with security_inode_init_security(). Or there is somethin=
g
> else going on.

There's something else going on.

>
> Vivek
>
>>> fs/ceph/xattr.c
>>> ceph_security_init_secctx()
>>>
>>> fs/nfs/nfs4proc.c
>>> nfs4_label_init_security()
>>>
>>> So looks like these two file systems will have to be converted
>>> (along with fuse).
>>>
>>> Vivek
>>>
>>>> NFS is going to require some work, but that's because it was
>>>> done as a special case for "MAC labels". The NFS support for
>>>> security.* xattrs came much later. This is one of the reasons
>>>> why I'm concerned about the virtiofs implementation you're
>>>> proposing. We were never able to get the NFS "MAC label"
>>>> implementation to work properly with Smack, even though there is
>>>> no obvious reason it wouldn't.
>>>>
>>>>
>>>>> Vivek
>>>>>

