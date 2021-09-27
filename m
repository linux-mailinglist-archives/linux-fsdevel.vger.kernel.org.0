Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38404197C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhI0PYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 11:24:34 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:35221
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235030AbhI0PYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632756173; bh=B53XcA+L4Y5L/z5bZcj1rYfF9Yvd8Kf1B4YD4HXt5D8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=YWIFvJGDRMmHgDi/bt2FvbTIXVE1ADVpqp28XkA1HhWAuBe7hmErYMOUEorP+GKhylwrw/6RJMhDNFyeEmClCcEosqSVfNz2SyR1b+koQRtaUt7aY0bvUzsxTMIjsuQAsvJZ1SCdexuOMrDb/fc29iabui+dU/nIP/+bXhDSCrOsZzV9HhB7OEcP3raFXWl1y1zGplh7Y063dQb/Arajnlum8DTmH8c11x2FaWtKznWHglYL8P6aB939iCVg6P5EpOqEtLjpUK7ElxINlc1/3rJ21/FvsDPcXN4dc0W2nfsU2eqVRnXgNeftFa4yAi4QRNHAkvbK1eEP2sjB77dFIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632756173; bh=7dYZ0DQHnt80kXlBe+sNeP7RBCH/2+ikVsxLddbs61L=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=XiNn5JLodwXv3K45dxK7l5WLU7G0l+KX144i3Q3Sh8OfiULf8CuepFTzPO4QyaaZyJHL55LWRroP7XxfJZo/vAQQ/AnD7SoNecMfGLPhm4guLnasjv2N56Uu0jp8PjM7WdVLjIyOvy97lvOOgtTNtFzinoFQNT1oxgiD1HlX2JPBeMT6NeJfMTuSHL+R3IYQOIjsutEJPqxGjOvSDirbh/zsX8m0sFakS5BJeFZxdrSlOhsPwAsz/E0fL17IPyf7Jewgdf66aLU/gUj5Iq2ZEX5ROB8F6JTODX44YobfhyXBOr53OuSwFZvbqlT9M+SKCSRJwSY9jn/vNzzWsmoFSg==
X-YMail-OSG: PrLlXIcVM1lXOMKrDWt4S2OhlQNLBfv9hFqaFgS0_SHOuY4Anq0X3xFhHw9DmEi
 Bg0eVASAbkt2nrBywpVsf69Jjv6JaApjMzYCfxMtbOeiyhIA2pGrZw5gj4cwBVPwmSc3R7LByJhA
 q.nvTOeI9mfF8vhlnzcQ5j54UvkLvPG8OKq_P2JCc5FzRt.Tyw4dCV2mFu7XagHLUralJ9jnJl1s
 rUeZQDKCzw4SFQTdZZrLScSIIFiqSZNnOZa4uIUygTarTOv8RcJyHvTNWtBNUOXCpcSc6dWk3_d9
 KsQHPQdKN5XuV7a4hntdp5QDPi2iD1t96LXOfjfbrOopQes59E4woD8nzgrHe3dc9m3fspYRxBF5
 PHzT6u8vxCRsDWoitQG4cFWLhAx7NVfpYfsj6jCgx7Fx7UfirCSyMOpx2Unl1jpNDd9r6L7pEt9D
 yBBc1Fr7TprLBGllwXeTUQwzc5RsCaqXsbeW_CQpgYSqRTKCYXEOv0uv6Tw.vFPNHauEYdA8XENC
 0OD7QJ5MA_ZTk2U5qeNpHtok8z2wBVd5yWBVeweAUUaWDPO653u8FV.qO861Yd18YFkAJmtac0A8
 QiB3w23MrVZQs7OJcA5AieUnqzGOLiGxVdYPauAlQlO8r8MsdjHArUWX.jiFY1mso2Pt2zIoo4YN
 S1kRf7bUPA4eiGXpk1HQS1CPhiz0_J8SSXZqKV5R.C_rXOnrThavBKVfWRFqcxDAs_E4oRP0IAu3
 uVkzYPwLMYu.emldE01v2ty4._MSaf5eypLHg9jqzEB2QkhYu1kGbRnLwUnKzv9Qfb8dbq_t_gjO
 1jxstsuBE1fftWuP.C_7hWo58d7Hn6LQ1eA88OZwPeVk4NDvWjj4YXVJ0KUCBWZ8bQytjsOt4iGT
 12JSxTkr6lJG6f1VpJ2ndn8FhDG1LoTZMGDGsF9WSkurgLcAhdVH4E9K39_7D0zzYbURg1j72yxX
 EQI2vOJrHTZa5aQYOHSSYcPcWEf_I2koKi8sa4yYTIJU2GUHjKV9Ee0Z1TlowpfRdHJJa2MyBq6D
 XMxJikZcxm4qc70IkTTlBsOCwZ3y2OZbxUCe3qs7qD1s28Dntr5SkODf38XlGKWnRO2vEBnJdQpF
 PVaOgEDvP2vWlip6bhYZsamMqvoosKF_jIoYvvub7xcaSFqBIWQwg7E7CnCD_luBoADlPCmfAuag
 eJIkfb6KcgUfW2nPhBMjzPNktxTJAwSaciiDe9UzDJ0laLn0wWFOuf4UbCelgzLKzDj0E0Pdu3fl
 sWYXfw2W45TkLZAyGkqtufwtnn.zNt9T630D6fGUHqB4IriSOe6t7LWtZOy4qZZAbiAcE5PZUwtb
 zEM7iVfkWwnSVN1BsxB6M_OSxCVqhpqimZ2v0yCKSK86gDf95_JwtkkyVLIr1fedZBZ6TzL_xETl
 5tLv0McVy84jriKK_vjn3exfYaqKhoc4VLeMX7QBpcNko_nrFFvuBrlp.qAseZFZjf5dMu9Rujz8
 x.hVk327GagAIx_T1WXjca816Sf_c2KOAtegU2FhMEPmixk4cuRREZk6hEULhM4sZykYxUYZXMLT
 xlMz8iRaNCu.4Rd.JEY5u9MWK54QmZBawCAlWLs4qbANowwe_edWFoHx1RH.fEQWITvhCv1mGQa5
 j997hWe7jzb0vD9DBQSPTelSorgBjWuBQzp_474e0qW6TBzmhQZhlxLSKVIXGzDCuJO0ao4BqtTs
 TR11TD0mrsLWvsNG9s199rhsM_NvGZy5wOrgEEUfigiIyFO2RjUrBroVNAyckIGbYAriqRur4SWJ
 7fgZrxjeseHKcdwxun3uX9_6UTT_2NPL3ssYFNNPldr2sXHUwcaFp.kD5u_rCmYV5mLY5jFAsP9I
 BYTEim7xAmJYwL1QzDvsQbe8vaPeyU4NYRyc7ztgYUYiSSjwGqwwmFYsqdi4sB1KE1lDv2154gDr
 kVdFBcPd64tssopeaUuazcDKxo4mVZBc35O2SZhNaKeLZz8EupBFAfZimzEEsQJ_StFPBjxs0VQ8
 1iqaUev_AcabcdbbMt38pY8dRE.O9D4CGHCNYjebJh7KGtV0ef0eTChxmyM.oT1W_hYqYrLNKBa2
 ay8O_JlerCcZVy5OeeyhbClauszn0hgmLfQ2zBp6JwJ_t7kIWcfIxH05fGbrO0z3gMl8MhVoeNL6
 D56RmzKrXtYTvvzmps0awXi9G4Muel3617BVVNJDnWRX3xJSxjZdjg9j2GHU0Hy4FTE0zD46PMCV
 b8ZJPpJEfWjZ1QXAa8S0cOp.XD4m2iSn9mlA4pcDgeAqFr06QpUHidq9iyDT4_j7CHl02GwuwRIn
 yEDtv
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Sep 2021 15:22:53 +0000
Received: by kubenode537.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d1e98f6bbaabf21a36da283e8437484c;
          Mon, 27 Sep 2021 15:22:50 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <753b1417-3a9c-3129-1225-ca68583acc32@schaufler-ca.com>
Date:   Mon, 27 Sep 2021 08:22:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVHPxYRnZvs/dH7N@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19043 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2021 7:05 AM, Vivek Goyal wrote:
> On Sun, Sep 26, 2021 at 05:53:11PM -0700, Casey Schaufler wrote:
>> On 9/24/2021 4:32 PM, Vivek Goyal wrote:
>>> On Fri, Sep 24, 2021 at 06:00:10PM -0400, Colin Walters wrote:
>>>> On Fri, Sep 24, 2021, at 3:24 PM, Vivek Goyal wrote:
>>>>> When a new inode is created, send its security context to server al=
ong
>>>>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_=
SYMLINK).
>>>>> This gives server an opportunity to create new file and set securit=
y
>>>>> context (possibly atomically). In all the configurations it might n=
ot
>>>>> be possible to set context atomically.
>>>>>
>>>>> Like nfs and ceph, use security_dentry_init_security() to dermine s=
ecurity
>>>>> context of inode and send it with create, mkdir, mknod, and symlink=
 requests.
>>>>>
>>>>> Following is the information sent to server.
>>>>>
>>>>> - struct fuse_secctx.
>>>>>   This contains total size of security context which follows this s=
tructure.
>>>>>
>>>>> - xattr name string.
>>>>>   This string represents name of xattr which should be used while s=
etting
>>>>>   security context. As of now it is hardcoded to "security.selinux"=
=2E
>>>> Any reason not to just send all `security.*` xattrs found on the ino=
de?=20
>>>>
>>>> (I'm not super familiar with this code, it looks like we're going fr=
om the LSM-cached version attached to the inode, but presumably since we'=
re sending bytes we can just ask the filesytem for the raw data instead)
>>> So this inode is about to be created. There are no xattrs yet. And
>>> filesystem is asking LSMs, what security labels should be set on this=

>>> inode before it is published.=20
>> No. That's imprecise. It's what SELinux does. An LSM can add any
>> number of attributes on inode creation, or none. These attributes
>> may or may not be "security labels". Assuming that they are is the
>> kind of thinking that leads people like Linus to conclude that the
>> LSM community is clueless.
>>
>>
>>> For local filesystems it is somewhat easy. They are the one creating
>>> inode and can set all xattrs/labels before inode is added to inode
>>> cache.
>>>
>>> But for remote like filesystems, it is more tricky. Actual inode
>>> creation first will happen on server and then client will instantiate=

>>> an inode based on information returned by server (Atleast that's
>>> what fuse does).
>>>
>>> So security_dentry_init_security() was created (I think by NFS folks)=

>>> so that they can query the label and send it along with create
>>> request and server can take care of setting label (along with file
>>> creation).
>>>
>>> One limitation of security_dentry_init_security() is that it practica=
lly
>>> supports only one label. And only SELinux has implemented. So for
>>> all practical purposes this is a hook to obtain selinux label. NFS
>>> and ceph already use it in that way.
>>>
>>> Now there is a desire to be able to return more than one security
>>> labels and support smack and possibly other LSMs. Sure, that great.
>>> But I think for that we will have to implement a new hook which
>>> can return multiple labels and filesystems like nfs, ceph and fuse
>>> will have to be modified to cope with this new hook to support
>>> multiple lables.=20
>>>
>>> And I am arguing that we can modify fuse when that hook has been
>>> implemented. There is no point in adding that complexity in fuse
>>> code as well all fuse-server implementations when there is nobody
>>> generating multiple labels. We can't even test it.
>> There's a little bit of chicken-and-egg going on here.
>> There's no point in accommodating multiple labels in
>> this code because you can't have multiple labels. There's
>> no point in trying to support multiple labels because
>> you can't use them in virtiofs and a bunch of other
>> places.
> Once security subsystem provides a hook to support multiple lables, the=
n
> atleast one filesystem will have to be converted to make use of this ne=
w
> hook at the same time and rest of the filesystems can catch up later.

Clearly you haven't been following the work I've been doing on
module stacking. That's completely understandable. There aren't
new hooks being added, or at least haven't been yet. Some of the
existing hooks are getting changed to provide the data required
for multiple security modules (e.g. secids become a set of secids).
Filesystems that support xattrs properly are unaffected because,
for all it's shortcomings, the LSM layer hides the details of
the security modules sufficiently.=20

Which filesystem are you saying will have to "be converted"?
NFS is going to require some work, but that's because it was
done as a special case for "MAC labels". The NFS support for
security.* xattrs came much later. This is one of the reasons
why I'm concerned about the virtiofs implementation you're
proposing. We were never able to get the NFS "MAC label"
implementation to work properly with Smack, even though there is
no obvious reason it wouldn't.


>
> Vivek
>

