Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB798418D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 02:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhI0Ayx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Sep 2021 20:54:53 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:38436
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231873AbhI0Ayw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Sep 2021 20:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632703995; bh=v1rYwjj+qgalY0Dg2wSr1MV+aUG5ceClV7dWhJEHj58=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=mCq9OmSHqOK/1BjolSqcN7if5SJeQC7H+vkvxkz034eppweNd8DKW5Iraf/qjuEHwAdqiHwcFn/YASr7RKul/oa4lxice9uPx8lVmLKMrUX5kWVLHffXhkl9YQ9cM26m1NAqwi49k12QhFoNbWOgBi1GIGMt6GL8bxK1T1bgIRu9jZH9qolAEf/3eJojDrlCw4FmvMJfq/g96aHNPTYGMOlAUpVwNn/0AoP0xQzPSYrx9b+xofa8rJe1GiWPSD16R0unu4CJBVoHys01MhB1pDrb98lhJelfQg1NapfanuhfAwZlD8VPQ2PRnAXCftYz9uKs7SEiWIAE5NIXy96pKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632703995; bh=wa2WKRt+Oh4/RLy6uGGErAk+c9JIAio9SbHwy5qe/oI=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Y3DXqe2c/x1ZEiLSirUErhidU8S3DLrp8R/DzzWppMbkf9wN0p4gYOyp72KFycDwCzvKvKy6x3MuIiZpb2tBNKl4tkGoaGpe56j4QRd9BLba9lrmLb4qkSl/+KjclLnZ08Qs2mV7fpXc0eIw2ILHJDXdeHBwbKgg/EcbA8eKuX7EjY+jTQe956sB4j5xpTjdlc7EGmZof32W8FLAxgvw5pbco1f9l4RG+vViRAx33KSOY9OWGqQSm7OPiFObaRrpSszoEl1Pw3WEzv1/f3Ul0XHftbogwwLGhIfwADwLO5SqmWaxt+R6CgOVV/QyI9pvs29xfX3OTsJPZibk7ciyPA==
X-YMail-OSG: fJkZoMYVM1k.7BAkcp4jCZ_O.mjtSQ9BgPn3Ty_k2waqP7uiZK06MRapr5WYdWB
 lcAtsldfa16XkfsGjx50esEs.P3ZKZGlhwPpcRHPswk.ZZlzbEPUovJf0R_rzJoqmUyoSdJ5boB1
 OXFGwPs4xYhVfOYZRZfDrCmG41mTa.939DK1uvo5fRYA66IMSEm20LftQLY3WYxL5jxoC5p27GL7
 heM7d5pGcgLdD3fbILDGLtjlJ9DbCe2Eru6WB6dsk.qNReUbRrDbjTyZREm6Ob._TiO3kxS2XZut
 ua6QxRXCg09c.IlJN.6P1ktolvfAeMALf3VmLLLpr6yhXh7Nhij2EHy4Y6RfQLMGTkgMAsNqUnVj
 wp2ApKb6vx2Pupaeo06gAD9Ki8JFOkqa44Eu.nYLlCOgzxQ7aWtM.JTGKUT5BOX8fulI_hxdi0iD
 3TnHX4x67FGzT5Kh6eMDy.uGoh6C1nj.dhOCnkxyKbowOFeAukG74C98N2.FzawlNw6Ha7jNEBwn
 Yu8CQL1VS_lZndQKJnVXNiCBZuoy1aCHJUGteGeKq3XbYpL0fU3bc6uHdY8RpApcVQWqnLYyFnaP
 TXeSbgDYrUwX_racXyRCVvXnZeRbEQHm0Ir4tf1s0u_sGhbjAclJqaPRGC1FVB1UK4Y9mYTQ_dwj
 2lzdPwy5Eym6QfJeGAPMCTf7JDjmmCMcnKbpuck7RIsWm9KBpcjcDB9BLQRu8iWVoPNasfJb7D9L
 dtaowp8gmf8LFIUon_6_630z1YH3q5Tgk8.29IM7mA18Rhc53h67bserIjyQ.nkT2NNWMRi0O.0R
 LfZ8gjIg4FhUsQMzb6XJWLTW9IaKClHZTj1nZSQUvkoN47ooao6PNtEviV7SsBsU7z97.BnKxX_j
 9HmbYdOrrFcRBIEIQ6MTn7zaCcJsgKnAFyRg2wqpLGl1h.b8LtBZY.KHI7u9nAzZ4uyNzh6ateXK
 _g5VjeWqB835EqS8N44jalJkXNuM9Jrb3XNlsPj6f7y_u8vBoDELgkeLpGjlC7CGHrh_lD3A0RSC
 .yymo9_5SEdGoY2d4ifFW5qUDR48x7Sj2Yw7fpRPiBIeU2LanbbQD.hpcVm38qJjrJsKyuUHXqfm
 nJ0vQv2znN4y2LHsdwkmh.qUwqSIaMhKEVTRjVr98.LAk0aw5lzvH0C5BLxzLpcipolK18Nw1gzs
 V8DCfTaoRnfRxs5kwKkGewzyF44.q5ggNbS5hhoa9ckkfryCQxeqfpjlRFx.FbsvBjLKPEaXvOhZ
 yVkpOjjv_jWeHkrxanO5wOx7MF53csIT1n9egf.c0Uq7iHITXClB635s5ofzgsWaVHVYbbwcw0kl
 7SFncQt6f.i0f44QWX_J.V_p_FFshyIAxqKS_tyhZlm_hx3uyVs4NLj4FgBSTskj.zGnmwFe8DQ8
 bY3hnC5yFxLPP8vbv.15xznNxRfDmBQArIeZWYIziMBY7m7j6DBqbWHzg1karDZm5oro_V6LuoEd
 7eBWtvR08nYWN9PX6mTUg1WLNtyoR2WxtcPeVYXynw6WhNzQpk3b01vJnW5GyunbAead2G3CCy3J
 ZzgE1QV5N._Yrj0uwWml5k4vppqD3mfJcstdEHOd5Sd1yiYh6b20h1UWcqvfUqP7qybqKD35KsPs
 o3oiiBOLA6R1XjwBF.KYLXlqaGRcUbep7yPAZA3eqXJn8aW2g3e0DTO5MZkB4pEcWaaoshbmvrg1
 f.FPBpO2MGYVwoQCs17f3bdVfhRfSzh4a7H7DnjOpsC7g6TNJRFRxFxvy7mxQH0Cf2Y.8nfuD5kH
 M482mBAqnuUECtzkgPoorOo99cwmpGwW6I.XkQaX_EIhxeD6jzsf96.FkJA1C2c.yGMU6PgbwaLd
 k_mn8cvsTC_j9Q5OPNpD.aqNQK6X5OK5gAeWK0bufrxrgzygygnLraYhbcV.AH.InH1MjXn2zZce
 2udJOXZwLrdBiCc6.guGqwpT6doPLxRZU3.RsQoW0fjj6fT5YujXTlFaT2hBOaGx_Gs48K9ZWSBI
 bACXVe7rj.B866s0yAxZ8QeqgdLTo8iCukSGwctsVT_hQxssciXkcpPtkjZJ1Umv5hOYBGJUlame
 H5JwwbjDN9nYoNbKQGPFsiXAtxBwlGfByn5CZNPlzfsB9jJLVfm9c5A4A3cg_mq3kv1zkvXeSXlv
 wQxLzP3E3ccR4mTAjWeepneqVSGR2qxacK1nvur53ITg1G9P4l6nMjap5LO5sxJIE0X8WCZXuHjp
 KvGuJeUWlo8xuutLYFpT.jevI6Fv6O46REQ0vGciBNeTMQYtTwpGu1vcd9tBI8ma1ZvGEe.cMUKC
 39sosNYE7ekFTAkkF2NA22LRTULi4zuRZTtzVa3T2NAEef6rd9Km9WYp8WETN4DU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Sep 2021 00:53:15 +0000
Received: by kubenode516.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9458edd82297d0adcf987f6576688baa;
          Mon, 27 Sep 2021 00:53:13 +0000 (UTC)
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
To:     Vivek Goyal <vgoyal@redhat.com>, Colin Walters <walters@verbum.org>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        chirantan@chromium.org, Miklos Szeredi <miklos@szeredi.hu>,
        stephen.smalley.work@gmail.com, Daniel J Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
 <a02d3e08-3abc-448a-be32-2640d8a991e0@www.fastmail.com>
 <YU5gF9xDhj4g+0Oe@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8a46efbf-354c-db20-c24a-ee73d9bbe9d6@schaufler-ca.com>
Date:   Sun, 26 Sep 2021 17:53:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YU5gF9xDhj4g+0Oe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19043 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/24/2021 4:32 PM, Vivek Goyal wrote:
> On Fri, Sep 24, 2021 at 06:00:10PM -0400, Colin Walters wrote:
>>
>> On Fri, Sep 24, 2021, at 3:24 PM, Vivek Goyal wrote:
>>> When a new inode is created, send its security context to server alon=
g
>>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SY=
MLINK).
>>> This gives server an opportunity to create new file and set security
>>> context (possibly atomically). In all the configurations it might not=

>>> be possible to set context atomically.
>>>
>>> Like nfs and ceph, use security_dentry_init_security() to dermine sec=
urity
>>> context of inode and send it with create, mkdir, mknod, and symlink r=
equests.
>>>
>>> Following is the information sent to server.
>>>
>>> - struct fuse_secctx.
>>>   This contains total size of security context which follows this str=
ucture.
>>>
>>> - xattr name string.
>>>   This string represents name of xattr which should be used while set=
ting
>>>   security context. As of now it is hardcoded to "security.selinux".
>> Any reason not to just send all `security.*` xattrs found on the inode=
?=20
>>
>> (I'm not super familiar with this code, it looks like we're going from=
 the LSM-cached version attached to the inode, but presumably since we're=
 sending bytes we can just ask the filesytem for the raw data instead)
> So this inode is about to be created. There are no xattrs yet. And
> filesystem is asking LSMs, what security labels should be set on this
> inode before it is published.=20

No. That's imprecise. It's what SELinux does. An LSM can add any
number of attributes on inode creation, or none. These attributes
may or may not be "security labels". Assuming that they are is the
kind of thinking that leads people like Linus to conclude that the
LSM community is clueless.


>
> For local filesystems it is somewhat easy. They are the one creating
> inode and can set all xattrs/labels before inode is added to inode
> cache.
>
> But for remote like filesystems, it is more tricky. Actual inode
> creation first will happen on server and then client will instantiate
> an inode based on information returned by server (Atleast that's
> what fuse does).
>
> So security_dentry_init_security() was created (I think by NFS folks)
> so that they can query the label and send it along with create
> request and server can take care of setting label (along with file
> creation).
>
> One limitation of security_dentry_init_security() is that it practicall=
y
> supports only one label. And only SELinux has implemented. So for
> all practical purposes this is a hook to obtain selinux label. NFS
> and ceph already use it in that way.
>
> Now there is a desire to be able to return more than one security
> labels and support smack and possibly other LSMs. Sure, that great.
> But I think for that we will have to implement a new hook which
> can return multiple labels and filesystems like nfs, ceph and fuse
> will have to be modified to cope with this new hook to support
> multiple lables.=20
>
> And I am arguing that we can modify fuse when that hook has been
> implemented. There is no point in adding that complexity in fuse
> code as well all fuse-server implementations when there is nobody
> generating multiple labels. We can't even test it.

There's a little bit of chicken-and-egg going on here.
There's no point in accommodating multiple labels in
this code because you can't have multiple labels. There's
no point in trying to support multiple labels because
you can't use them in virtiofs and a bunch of other
places.

>
> Thanks
> Vivek
>

