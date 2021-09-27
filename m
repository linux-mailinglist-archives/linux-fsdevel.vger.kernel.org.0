Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0366541A173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbhI0VrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 17:47:00 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:41047
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237205AbhI0Vq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632779120; bh=exJVQl+5l/J1P21jJlF7r+ha1GCZcerAibFKFxpJp1k=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=rWvUAc0OWJ1hz3B2mXWLyeQsTG/L2tghW00AOcabkCGa0Fg6Y/Sq/EYzwXwxVUDsiGuuNz1xYNmcKeiWpxDp+k4Pg4TCJ7LAZvLP3ThzlKnepOEWdRQIIjzANKwh7arkBf5rr78ofkE0XuA63vIVmRYkOBrwkOD2663UOlzp8dxeGDJBaUrNsqMbadtuc6fMy+DHoVj8JX+MdBPmNEtoCaj/fuy85tkT9e36TIM3fDB/cF9g3NOgErmXNN7qCNRpA47UTMJ+QyQo1nYXedip1iZcRXunxGv05dRhear0HQWBBB8D3E/UmBtDd9OE1Iw7QoI8VFuyLNJsyCMFYkO85Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632779120; bh=dp3pqDwz/xiezj5hV8iTRjGmrQvW9oSqADrYi6QBVJh=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=HPH4ZiRonle3jYuGPac+ptm4vSeOIBq74uI1GH73EeXBcIKWMe3IB3Q4C/WeAoIh2FhufKm3Fde8eOqTjNLDscT2H1Ygz8BV98R/OGdkYt6/sPFF4OsvZ02083u5wV7Ymb10Hveg/Jj7TwhWXOKm2hduqM5nciEHjVe1wLZ1wchUFVrfIrZ1hEJwf5u5dhedC3/PuEsh5M8QHVJecIPJYmstJQr9jLp1x1nGBSVqQgO7KJTYY5frbj/S2uZYDtOagxfwbznoIUzSIozQklgYGZd3Pm6k5kubRmQWVZ4fZfwGlF5d81f+KrQRhEK/7bLbgm9EvmAtMNn01TZaIq1YwQ==
X-YMail-OSG: r3VpfAgVM1lUBwuaSt_iANJWFCcslI9iYn8yhtKaDghWi.4KysXJoplonKtj7Wm
 rXyKeqA.XoeAn6t3Qb0jyJfDyQ2a8Z_bxBQU1Y6AzQtbwixFiE4PYAt4v3aKDbaLkOw8nmBwlAZw
 r3NIbv1C4.07VqeTnFMNNIllPvgBpc936kgJFGvmPH1KhzrWRrElvkXrZEB45YesDzttKuhfcPRp
 Py2pGkz9HtIPhwhds_bSKIexw3lOknuQs12pvpuqvka6relWfYT8x0kzT0jgyf.PHIJVqQ2_qWfl
 673.FRsHxFVvCh.cwCmqcGuZanD8jbQxmZ5nHZMUCEXSF0xanYBnXZsHSbAm8loFUw6Cj2NEPpXj
 B8_c.csuUvggsxaM.AUeFGBO9RoFrJbKw0VpIeBy8zpYJPaywB5p5l3gohJJhlbYwR8uPViGcFCy
 X4wE5i82vY6lkYOdaqOv1nuKrKeHgoios5Oat6TMYBvmVaMjeLFuBGjxCaXwH5uanhPnvqBQd34s
 W19g.B9Jf7GhbQjKqsJtYjL1Aad7uXog6GPTcfTLi.ZccGLwmg_Mu7iXSAHKh2.TDSMc__N9zWVm
 qqtE0uSR7YSJtAfU3okF7c88OBiGNUOTH.Nmk7Nlb0pn3cWjf5O9NpAsbiRBHWDD28B6j3GVycox
 xczdVFT3niUSGHx3NUvezNr3_6v0Zbk8SJXDgk2eXTP5UaFLWAdLPxds.U2gSAUr8IbK6HDkOJM8
 ePZI6Ww_gNb5YB0YWCdF51MpCAR92fgfEF8JNFfmdahTY0Zwl1Jv6Mn6U90IabVLIammLKQnvkLf
 SMyjPAtLK0q99R0ignuuzE1bWWzyD6U2ZugTI_zP6OPBRRKPrWbMAuNJWp043YfoyPMq6zmivkwS
 cR7GACB7mqQ0uieh1JA44ud_Io9rhfKdBDyrToU0dBigIuxjmtiIE_jccGktOER7_nZqSaZ4J1v_
 yM8suj7qF7vZ8eYg_18..9AQBimJgY_EvDzgbYImpkzyMC_bGPN5KIRplO_Z7rYxHnRwl.3aCUUW
 PFnd3yF2u.6zGj8iGgHwemEDp5sSXWqethtBuaQPVRcuqhx3kmyw8vXHC0skFv1TubDOsxbvD8Tf
 HpOAA7yIhkDFJAA7DW1bibqQ2vVpFfw.jZ1PA70kTEz_u.Vp.eVZH0cPJaVOgj2mcV.Gsc..2_sS
 J3LF7Z5oPnhMc3o6r0pQW3vxbI3ePZK4XxQ3e.9ZB80BJu1qT8.BOQFPlmw.9OT0JtS8eJTfyQBj
 cQU8OE3YONajQo45T57bg4SeccmjfVvLohB2wYWf8H_n1uM8UBBA6YVIyfrlWaEV80.AMOvBvLbT
 rMfCJYZma_D5W3wf8T5K53tUh4BUckkVSi01QeXjwy9Fmmu5BiBLBPXitTLVqIU2c7tUFngUPIID
 UcnvbtwVg95GqRsTMS3XmDsFPvB0JOzk6SsfuGWypoPyUscp_xJ34dfA7sqMQl.bJF5vG13MblaF
 ccmES06yLkGrElSR8.9MWGrUYetl6XbtE2C6AXutqKpQex6sKWcSU.j_5FkGW9MrYtTyA_WBxapv
 Xv21SjIjRNohjP6jU4W39QtGbQXSXdx_CZCE8tkfvCfvWZo3wi7HYliEPu07ucpekZgjXMTCI7Dg
 8frFqeAM.hXM3yJ22acIiTHVKazq.NzzVG52EGTj_zf9Droeg.QutzSaIgZolyObXcak4RrQus8w
 9ysFhVCUeMtzflf511ZNDokeNAUQVvtsENnrH.pxZA06zxdl8VyBbbTBDpnQtXG3N_5NBBn7i2fC
 9zTzZuUrzwFQ10oje3lV7blbpbkz6VUz_fxHsLgDJCd1225PksDSCq2Si3n25CTj0IZzP7y3Gl8j
 1qisu4Esg.PkgyGhvvw0bsRBT.eZDAoJHyovPuq_nMsgwvtht6ZE2wNHioWVVHCo9t9anLYjMHC9
 b5jNFB20m12AT0PcSKbzHvWpIksL_LRruy.tlxoqEFHiN91uCdB0RrFviuIXRvbGlvGZ6uuZwftI
 4KfDlTwb8vemeiftMisMvXHUx4la..LDos9pa.pT2ydb76Mmadf_aJ_LTpJdGfCCjTIDc5Soqygy
 oM4qdxHyYBn7ppDBuD4eTxP4ul3Y45fshsHgf4Q9NEZiiYuhJ9oJ1qT7.PTvSfsxzn0CrNRtQnPa
 5KXhlLf9m_l6hpWiJoeAZAbTOHtC9UVfB.tKT4xMBQvbKDeYQMfCbl8HXmwNQppXNC4vzHfl7J5n
 wqjdH5MjYZ1Z99f6.HWtV.excI1Qd6CCU6L4qeFfIz3Pp9lfvbJbr_Viq2Qx0AMC9NfJMl6wZTtZ
 Abmm5Ng--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Sep 2021 21:45:20 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3e4a1ccca26a842edd7ab868a84eef16;
          Mon, 27 Sep 2021 21:45:16 +0000 (UTC)
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        chirantan@chromium.org, Miklos Szeredi <miklos@szeredi.hu>,
        stephen.smalley.work@gmail.com, Daniel J Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210924192442.916927-3-vgoyal@redhat.com>
 <a02d3e08-3abc-448a-be32-2640d8a991e0@www.fastmail.com>
 <YU5gF9xDhj4g+0Oe@redhat.com>
 <8a46efbf-354c-db20-c24a-ee73d9bbe9d6@schaufler-ca.com>
 <YVHPxYRnZvs/dH7N@redhat.com>
 <753b1417-3a9c-3129-1225-ca68583acc32@schaufler-ca.com>
 <YVHpxiguEsjIHTjJ@redhat.com>
 <67e49606-f365-fded-6572-b8c637af01c5@schaufler-ca.com>
 <YVIZfHhS4X+5BNCS@redhat.com>
 <2e00fbff-b868-3a4f-ecc4-e5f1945834b8@schaufler-ca.com>
 <YVItb/GctH7PpL0f@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5d6230dc-bba5-a5c1-2c54-da5e6ecfbf2e@schaufler-ca.com>
Date:   Mon, 27 Sep 2021 14:45:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVItb/GctH7PpL0f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19076 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2021 1:45 PM, Vivek Goyal wrote:
> On Mon, Sep 27, 2021 at 01:19:25PM -0700, Casey Schaufler wrote:
>> On 9/27/2021 12:20 PM, Vivek Goyal wrote:
>>> On Mon, Sep 27, 2021 at 10:56:59AM -0700, Casey Schaufler wrote:
>>>> On 9/27/2021 8:56 AM, Vivek Goyal wrote:
>>>>> On Mon, Sep 27, 2021 at 08:22:48AM -0700, Casey Schaufler wrote:
>>>>>> On 9/27/2021 7:05 AM, Vivek Goyal wrote:
>>>>>>> On Sun, Sep 26, 2021 at 05:53:11PM -0700, Casey Schaufler wrote:
>>>>>>>> On 9/24/2021 4:32 PM, Vivek Goyal wrote:
>>>>>>>>> On Fri, Sep 24, 2021 at 06:00:10PM -0400, Colin Walters wrote:
>>>>>>>>>> On Fri, Sep 24, 2021, at 3:24 PM, Vivek Goyal wrote:
>>>>>>>>>>> When a new inode is created, send its security context to ser=
ver along
>>>>>>>>>>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and=
 FUSE_SYMLINK).
>>>>>>>>>>> This gives server an opportunity to create new file and set s=
ecurity
>>>>>>>>>>> context (possibly atomically). In all the configurations it m=
ight not
>>>>>>>>>>> be possible to set context atomically.
>>>>>>>>>>>
>>>>>>>>>>> Like nfs and ceph, use security_dentry_init_security() to der=
mine security
>>>>>>>>>>> context of inode and send it with create, mkdir, mknod, and s=
ymlink requests.
>>>>>>>>>>>
>>>>>>>>>>> Following is the information sent to server.
>>>>>>>>>>>
>>>>>>>>>>> - struct fuse_secctx.
>>>>>>>>>>>   This contains total size of security context which follows =
this structure.
>>>>>>>>>>>
>>>>>>>>>>> - xattr name string.
>>>>>>>>>>>   This string represents name of xattr which should be used w=
hile setting
>>>>>>>>>>>   security context. As of now it is hardcoded to "security.se=
linux".
>>>>>>>>>> Any reason not to just send all `security.*` xattrs found on t=
he inode?=20
>>>>>>>>>>
>>>>>>>>>> (I'm not super familiar with this code, it looks like we're go=
ing from the LSM-cached version attached to the inode, but presumably sin=
ce we're sending bytes we can just ask the filesytem for the raw data ins=
tead)
>>>>>>>>> So this inode is about to be created. There are no xattrs yet. =
And
>>>>>>>>> filesystem is asking LSMs, what security labels should be set o=
n this
>>>>>>>>> inode before it is published.=20
>>>>>>>> No. That's imprecise. It's what SELinux does. An LSM can add any=

>>>>>>>> number of attributes on inode creation, or none. These attribute=
s
>>>>>>>> may or may not be "security labels". Assuming that they are is t=
he
>>>>>>>> kind of thinking that leads people like Linus to conclude that t=
he
>>>>>>>> LSM community is clueless.
>>>>>>>>
>>>>>>>>
>>>>>>>>> For local filesystems it is somewhat easy. They are the one cre=
ating
>>>>>>>>> inode and can set all xattrs/labels before inode is added to in=
ode
>>>>>>>>> cache.
>>>>>>>>>
>>>>>>>>> But for remote like filesystems, it is more tricky. Actual inod=
e
>>>>>>>>> creation first will happen on server and then client will insta=
ntiate
>>>>>>>>> an inode based on information returned by server (Atleast that'=
s
>>>>>>>>> what fuse does).
>>>>>>>>>
>>>>>>>>> So security_dentry_init_security() was created (I think by NFS =
folks)
>>>>>>>>> so that they can query the label and send it along with create
>>>>>>>>> request and server can take care of setting label (along with f=
ile
>>>>>>>>> creation).
>>>>>>>>>
>>>>>>>>> One limitation of security_dentry_init_security() is that it pr=
actically
>>>>>>>>> supports only one label. And only SELinux has implemented. So f=
or
>>>>>>>>> all practical purposes this is a hook to obtain selinux label. =
NFS
>>>>>>>>> and ceph already use it in that way.
>>>>>>>>>
>>>>>>>>> Now there is a desire to be able to return more than one securi=
ty
>>>>>>>>> labels and support smack and possibly other LSMs. Sure, that gr=
eat.
>>>>>>>>> But I think for that we will have to implement a new hook which=

>>>>>>>>> can return multiple labels and filesystems like nfs, ceph and f=
use
>>>>>>>>> will have to be modified to cope with this new hook to support
>>>>>>>>> multiple lables.=20
>>>>>>>>>
>>>>>>>>> And I am arguing that we can modify fuse when that hook has bee=
n
>>>>>>>>> implemented. There is no point in adding that complexity in fus=
e
>>>>>>>>> code as well all fuse-server implementations when there is nobo=
dy
>>>>>>>>> generating multiple labels. We can't even test it.
>>>>>>>> There's a little bit of chicken-and-egg going on here.
>>>>>>>> There's no point in accommodating multiple labels in
>>>>>>>> this code because you can't have multiple labels. There's
>>>>>>>> no point in trying to support multiple labels because
>>>>>>>> you can't use them in virtiofs and a bunch of other
>>>>>>>> places.
>>>>>>> Once security subsystem provides a hook to support multiple lable=
s, then
>>>>>>> atleast one filesystem will have to be converted to make use of t=
his new
>>>>>>> hook at the same time and rest of the filesystems can catch up la=
ter.
>>>>>> Clearly you haven't been following the work I've been doing on
>>>>>> module stacking. That's completely understandable. There aren't
>>>>>> new hooks being added, or at least haven't been yet. Some of the
>>>>>> existing hooks are getting changed to provide the data required
>>>>>> for multiple security modules (e.g. secids become a set of secids)=
=2E
>>>>>> Filesystems that support xattrs properly are unaffected because,
>>>>>> for all it's shortcomings, the LSM layer hides the details of
>>>>>> the security modules sufficiently.=20
>>>>>>
>>>>>> Which filesystem are you saying will have to "be converted"?
>>>>> When I grep for "security_dentry_init_security()" in current code,
>>>>> I see two users, ceph and nfs.
>>>> Neither of which support xattrs fully. Ceph can support them properl=
y,
>>>> but does not by default. NFS is ancient and we've talked about it at=

>>>> length. Also, the fact that they use security_dentry_init_security()=

>>>> is a red herring. Really, this has no bearing on the issue of fuse.
>>> Frankly speaking, I am now beginning to lose what's being asked for,
>>> w.r.t this patch.
>> 1. Support for multiple concurrent security.* xattrs
> Supporting SMACK is not my priority right now. I am only interested
> in SELinux at this point of time. I am willing to do some extra
> work if SMACK can be easily incorporated in current framework. But
> if current infrastructure does not support it properly, I am not
> planning to write all that to support SMACK. That's a work for
> somebody else who needs to support SMACK over fuse/virtiofs.

Nuts. I was just getting comfortable with the level of cooperation
I've had from the SELinux side recently.

>> 2. Abandon mapping security.* attrs to user.* xattrs
> That I have moved away, for now. Planning to remap security.* xattrs
> to trusted.* and will ask users to give CAP_SYS_ADMIN to daemon.
>
> Once trusted xattrs are namespaced, this all should work very well.

That's good to hear.


>>> I see that NFS and ceph are supporting single security label at
>>> the time of file creation and I added support for the same for
>>> fuse.
>> NFS took that course because the IETF refused for a very long time
>> to accept a name+value pair in the protocol. The implementation
>> was a compromise.
>>
>>> You seem to want to have capability to send multiple "name,value,len"=

>>> tuples so that you can support multiple xattrs/labels down the
>>> line.
>> No, so I can do it now. Smack keeps multiple xattrs on filesystem obje=
cts.
>> 	security.SMACK64		- the "security label"
>> 	security.SMACK64EXEC		- the Smack label to run the program with
>> 	security.SMACK64TRANSMUTE	- controls labeling on files created
>>
>> There has been discussion about using additional attributes for things=

>> like socket labeling.
>>
>> This isn't hypothetical. It's real today.=20
> It is real from SMACK point of view but it is not real from=20
> security_dentry_init_security() hook point of view. What's equivalent
> of that hook to support SMACK and multiple labels?

When multiple security modules support this hook they will
each get called. So where today security_dentry_init_security()
calls selinux_dentry_init_security(), in the future it will
also call any other <lsm>_dentry_init_security() hook that
is registered. No LSM infrastructure change required.


>>> Even if I do that, I am not sure what to do with those xattrs at
>>> the other end. I am using /proc/thread-self/attr/fscreate to
>>> set the security attribute of file.
>> Either you don't realize that attr/fscreate is SELinux specific, or
>> you don't care, or possibly (and sadly) both.
> I do realize that it is SELinux specific and that's why I have raised
> the concern that it does not work with SMACK.
>
> What's the "fscreate" equivalent for SMACK so that I file server can
> set it before creation of file and get correct context file?

The Smack attribute will be inherited from the creating process.
There is no way to generally change the attribute of a file on
creation. The appropriateness of such a facility has been debated
long and loud over the years. SELinux, which implements so varied
a set of "security" controls opted for it. Smack, which sticks much
more closely to an access control model, considers it too dangerous.
You can change the Smack label with setxattr(1) if you have
CAP_MAC_ADMIN. If you really want the file created with a particular
Smack label you can change the process Smack label by writing to
/proc/self/attr/smack/current on newer kernels and /proc/self/attr/curren=
t
on older ones.


>>> https://listman.redhat.com/archives/virtio-fs/2021-September/msg00100=
=2Ehtml
>>>
>>> How will this work with multiple labels. I think you will have to
>>> extend fscreate or create new interface to be able to deal with it.
>> Yeah. That thread didn't go to the LSM mail list. It was essentially
>> kept within the RedHat SELinux community. It's no wonder everyone
>> involved thought that your approach is swell. No one who would get
>> goobsmacked by it was on the thread.
> My goal is to support SELinux at this point of time. If you goal is
> to support SMACK, feel free to send patches on top to support that.

It helps to know what's going on before it becomes a major overhaul.

> I sent kernel patches to LSM list to make it plenty clear that this
> interface only supports single label which is SELinux. So there is
> no hiding here. And when I am supporting only SELinux, making use
> of fscreate makes perfect sense to me.

I bet it does.

>>> That's why I think that it seems premature that fuse interface be
>>> written to deal with multiple labels when rest of the infrastructure
>>> is not ready. It should be other way, instead. First rest of the
>>> infrastructure should be written and then all the users make use
>>> of new infra.
>> Today the LSM infrastructure allows a security module to use as many
>> xattrs as it likes. Again, Smack uses multiple security.* xattrs today=
=2E
> security_dentry_init_security() can handle that? If not, what's the
> equivalent.

Yes, it can.


>>> BTW, I am checking security_inode_init_security(). That seems to
>>> return max 2 xattrs as of now?
>>>
>>> #define MAX_LSM_EVM_XATTR       2
>>> struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>> You're looking at the bowels of the EVM subsystem. That herring is red=
, too.
>>
>>> So we are allocating space for 3 xattrs. Last xattr is Null to signif=
y
>>> end of array. So, we seem to use on xattr for LSM and another for EVM=
=2E
>>> Do I understand it correctly. Does that mean that smack stuff does
>>> not work even with security_inode_init_security(). Or there is someth=
ing
>>> else going on.
>> There's something else going on.
> Help me understand what's going on. How are you returning multiple
> xattrs from security_inode_init_security() when you have allocated
> space for only one LSM xattr.

Look into CONFIG_EVM_EXTRA_SMACK_XATTRS if you like. As I said,
you're digging deeply into EVM at this point. It's not the LSM
infrastructure.

>
> Vivek
>

