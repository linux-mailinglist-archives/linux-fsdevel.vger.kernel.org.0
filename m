Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DFD3FF736
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347711AbhIBWf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 18:35:26 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:41917
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347675AbhIBWfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630622066; bh=DL0P+QeyDsAZTXxGrFCN4WraPDJPyE4Bz5VY4RxMOxo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=ttiii2a90gAbANL6loKdA2sD+pV4U1tPfDi+0SxQNf1HZaelETTvuf+SgC88b4W4/t/0uPBsrvzSiI/lhBthX0lvhORMayCgW6Tk0VR0b5GNn4OOPldaEqDQZQMo9tfzXNyNbcYcaL3jSsIDbDrZ2mT1PchGj7woOQlmBxXef+9ZmkR/EKLvWlCkWtuuFmQMOElbxKCTM2gJGOvcw8qpvoei+FT58SLIk16wL3/J76QUlrCDcNWTKmgc6fLY9OXSgotOHTwYzmo7uQLGlpNiMbHdkHA7NQFMHczx19RP4721JhEVzTkwf/6JcTVndBTypPaoGVb54GU5GnWckBrNGw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630622066; bh=c6YbGKgY3+THh7W8kpsXtPbsS+F1zlADXIdu4mALExJ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Ootb22ZcXeBsc+WB1EXsGbS5zOgwWSYME2tayFrwMce1JxZviEmEqL36PemomWDISxBebL0CNrP3BTilOZO33V/+Xc3n5JwQk4y7JNGWVJxcm4QlL0mSYCMM0GlHFgHHrt1FCdD2LemElKphqnGpSiorjIX5Bj8acgro48ENB+odgmxvYBqNGaYZGCl0S7v86IV9U4x0mJJHNbxl3pE9pyBU2hOAbXXake/IAwrTaabNvlP25TcIGEipVs17xUih/4LJglb+untBPBqLNIcKSu3a6WH7NQzDy0esRR/kVj9Gl5C/l3wDQNjVBUEIj6x8VliCj716VeosDOFeXBtnZA==
X-YMail-OSG: _W8_QZEVM1l38cCL3daaCHFhncC8Mhog1uQuqkbZFQD.FPRg9xpQcywKKli.rxU
 9Zq6AR3N_YNifavOXL2M63wxNFlTk9RGdfiR9y10o59FlYY154wNS5fuQGNBBa_uRGxePiamLOE.
 ON6h.pV2UVxFbUa1IUh3EonSU7oBzKyvytX4nr2eapvGX8Kk7jil45Y485zdkTqunJeDZFQJADWP
 adTOB0Cj6TbqpV6Le3PIgpm4pW5M47rkHOclUSlSN06tryfK6PxInZynsFJLsWsHX6rMdiEPT.y2
 sKE9gWU7ZQCKsJWwEBEFCSPsan57Sd7qIzXapwSowGD4ISihbaEYWFgC9ikYZyV8HNPS5Fylfmcp
 L2TapgROmu5yoE7Qx6ZTjuCIOIxlvBb8c9gbj2K1EKy_j9P.BpmT6lP1QyluaNIbCwN6_PCEy2Qv
 SH9M5D9eIyv7KxDDxsQHXkiRPt0xrQDkS5FM7yHiStJca.3ke3H5Fk.yRLCF_J5idDZ6YehBPXf0
 f67RgDF1t.UPaA5.A7EGE2u9_q8USLngvrHGMf38E1PDhjqIDKdkP_KhN1zK2T.t07c0VHefb_Yi
 dhHa1oMOHXiVixBd4DiHXiBcEXCnnf9SC1HwpeFw.ZKHWqBzCpej2FxoHn6JpoWXOPzSJwb768Ta
 7z_5dE1w06sRYvh_PE7XI49mMm.2dWoKxnlOxhEi47.sgQCOf_ATJFJ6u1esLgKUpmkPcIsZOvWW
 yXQQbI6JLZgKqYMsIHP3rRz4qptGYpZDHV3V36hdVSvI7Njh_IwPpRWMoczjM5zt0wvcRRdCAQWO
 4CPPw3BeUQbI.B0Pdl0.iTjHBvWhqsKPGmn1PvKTXenfJ32LY8QHEJ08wOgyF1B7Twk8eOlrEGF9
 VyZqDqqYiu93yR25nA3VPISTj.0auPMgnmHNzenp3WV71m06.Ww22ig.cizxjV61TBDobZcxiUZa
 Mfr0oRP0nznDBbNrRGdE6Z8FpQBjd1thxKOwTEstO4hk6gkKEmni4N2ZAFB_4JVEe2akg.DN7xcU
 2fdoii4qMawv6IDtRhIBENc3SeHQKzrydo6Y.R9h8xoPrSC3kseaEOy_jzA7N7I4WGLmIozwXZhG
 KtWgo7NBiCJDBRUvEt_jpS8Racj0DQfNmvj4h_n2Nj85V5kOD1GIJPAtfeoJfXjX8IBIO5WmKQVK
 UlsKliUI8E6x00l0uXYK_0v3SOspeUU1u1Ome5w4XOjYWpdQJtwjyLDKBKeTORzssBBpaPNVBHkr
 Xqpd2iAZIiK9Gi6zWqbQgNMrzNucXwwY8f.lRFxH1xJgg1gC9tlICzPNdOUTYdxIT38uutkY1lQH
 YX6efb2QRDSBb9F_va4cNZFU5vWNYra6kwCkbZDUFRg5BYmNlx4sftXoCI.4dPhNzQ04UyDe3K1_
 pVIjMWABaLiD7FNCiAvvKjvbL1dKgJnkG.78XduHKfKN2PZg0EI_2hh64nU2UQYe9GzC5Qzz8GRE
 XQgW7fF4U7zPei16u3t_CrGDYSNN_s7KWCjmchDW5ESFP1eBWkKFqA1y0lZtZrJNytTayZum7Gks
 YIOSv9Nc_JwvjNnGG0oLwr8FUL394KidufoId8cSSp_9nTteeoCaznDGnwyjx_OBgG7.YuEYELdw
 vFmgTxnz0.XF_vFTvRhnRQ9LMWTH7SHTM1TH3ePCtOD4SYFkedYxm0glPuigwqEcJ9h_K1a58rbl
 9MAeLrcA5_QpkpJOqV8MheiMt9vMp7lp8iXLhjaaZcE0vJc5ZNQPfE3BbWT0EfkU5FmyuAmnriQd
 wyd3GQ07e5kQdQUHrfT3I2DVOGARHC9EcZM5TqbE1PuTfyY5tVn0XRHdGES3QykfTfHPUXAFGscK
 QPFxNzak8yKaz11zb2Wg2yYZLhbP2l6WCeySHuBXA09U8LC7eNQnkoaPu.eV04qvR3GNmspLmgeQ
 naC.V4qtXi.tJTwcGx_EWo5JJoqg8ZS7.7nZMpuo6.UPVZl0DLPslpvK78LGPXjcBKvX6a7wyMnE
 Le2IVjH1iHD8H76QGzxS5cJdqhJLGn761HeGUu0DRdA51DMXhzQ7bnzYuyEfAKBtFBKKbg7k2In5
 cmV3TFqKN751ZAlQUamVOYb.Mhz25j0WF.JGGJgZpMxdB5DSQEr0k93gABdvtHu3JqbcvY5zDtoB
 OCKXz0IRgcoRVRC21E6fUclhha2SssKwmzlu0lWY6T8obyViV_OTHX8ftD3qIbcj.RydIFrGEtLN
 LtCpM3lYZZsJypniB3JrN6thY83z1iT3TtS.a4_ecn8EXfq7LNBa3NGQOgZ4rPo6A1dNehKZo12f
 _HrP8EIDhEReSSsWs7KuyQOmbYNggEcgT1bt99x6EcDBuD1j_sGkSJMnH__sgSOS5KTGDXvuWftK
 JefqY3jfkdjC3wCgqw6Cdn3Vu2HguazLMlGO04eUX0JjiDoL6yx.dRsrByeWdOSfBVuSDETZYzV_
 L6lBMBnE0ciDrJNBYt14-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Sep 2021 22:34:26 +0000
Received: by kubenode518.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3d827835a38cb53e19a2ca52fbee9efd;
          Thu, 02 Sep 2021 22:34:20 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
Date:   Thu, 2 Sep 2021 15:34:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTEur7h6fe4xBJRb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/2021 1:06 PM, Vivek Goyal wrote:
> On Thu, Sep 02, 2021 at 11:55:11AM -0700, Casey Schaufler wrote:
>> On 9/2/2021 10:42 AM, Vivek Goyal wrote:
>>> On Thu, Sep 02, 2021 at 01:05:01PM -0400, Vivek Goyal wrote:
>>>> On Thu, Sep 02, 2021 at 08:43:50AM -0700, Casey Schaufler wrote:
>>>>> On 9/2/2021 8:22 AM, Vivek Goyal wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This is V3 of the patch. Previous versions were posted here.
>>>>>>
>>>>>> v2:
>>>>>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoy=
al@redhat.com/
>>>>>> v1:
>>>>>> https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgo=
yal@redhat.co
>>>>>> +m/
>>>>>>
>>>>>> Changes since v2
>>>>>> ----------------
>>>>>> - Do not call inode_permission() for special files as file mode bi=
ts
>>>>>>   on these files represent permissions to read/write from/to devic=
e
>>>>>>   and not necessarily permission to read/write xattrs. In this cas=
e
>>>>>>   now user.* extended xattrs can be read/written on special files
>>>>>>   as long as caller is owner of file or has CAP_FOWNER.
>>>>>> =20
>>>>>> - Fixed "man xattr". Will post a patch in same thread little later=
=2E (J.
>>>>>>   Bruce Fields)
>>>>>>
>>>>>> - Fixed xfstest 062. Changed it to run only on older kernels where=

>>>>>>   user extended xattrs are not allowed on symlinks/special files. =
Added
>>>>>>   a new replacement test 648 which does exactly what 062. Just tha=
t
>>>>>>   it is supposed to run on newer kernels where user extended xattr=
s
>>>>>>   are allowed on symlinks and special files. Will post patch in=20
>>>>>>   same thread (Ted Ts'o).
>>>>>>
>>>>>> Testing
>>>>>> -------
>>>>>> - Ran xfstest "./check -g auto" with and without patches and did n=
ot
>>>>>>   notice any new failures.
>>>>>>
>>>>>> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
>>>>>>   filesystems and it works.
>>>>>> =20
>>>>>> Description
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>
>>>>>> Right now we don't allow setting user.* xattrs on symlinks and spe=
cial
>>>>>> files at all. Initially I thought that real reason behind this
>>>>>> restriction is quota limitations but from last conversation it see=
med
>>>>>> that real reason is that permission bits on symlink and special fi=
les
>>>>>> are special and different from regular files and directories, henc=
e
>>>>>> this restriction is in place. (I tested with xfs user quota enable=
d and
>>>>>> quota restrictions kicked in on symlink).
>>>>>>
>>>>>> This version of patch allows reading/writing user.* xattr on symli=
nk and
>>>>>> special files if caller is owner or priviliged (has CAP_FOWNER) w.=
r.t inode.
>>>>> This part of your project makes perfect sense. There's no good
>>>>> security reason that you shouldn't set user.* xattrs on symlinks
>>>>> and/or special files.
>>>>>
>>>>> However, your virtiofs use case is unreasonable.
>>>> Ok. So we can merge this patch irrespective of the fact whether virt=
iofs
>>>> should make use of this mechanism or not, right?
>> I don't see a security objection. I did see that Andreas Gruenbacher
>> <agruenba@redhat.com> has objections to the behavior.
>>
>>
>>>>>> Who wants to set user.* xattr on symlink/special files
>>>>>> -----------------------------------------------------
>>>>>> I have primarily two users at this point of time.
>>>>>>
>>>>>> - virtiofs daemon.
>>>>>>
>>>>>> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unpri=
viliged
>>>>>>   fuse-overlay as well and he ran into similar issue. So fuse-over=
lay
>>>>>>   should benefit from this change as well.
>>>>>>
>>>>>> Why virtiofsd wants to set user.* xattr on symlink/special files
>>>>>> ----------------------------------------------------------------
>>>>>> In virtiofs, actual file server is virtiosd daemon running on host=
=2E
>>>>>> There we have a mode where xattrs can be remapped to something els=
e.
>>>>>> For example security.selinux can be remapped to
>>>>>> user.virtiofsd.securit.selinux on the host.
>>>>> As I have stated before, this introduces a breach in security.
>>>>> It allows an unprivileged process on the host to manipulate the
>>>>> security state of the guest. This is horribly wrong. It is not
>>>>> sufficient to claim that the breach requires misconfiguration
>>>>> to exploit. Don't do this.
>>>> So couple of things.
>>>>
>>>> - Right now whole virtiofs model is relying on the fact that host
>>>>   unpriviliged users don't have access to shared directory. Otherwis=
e
>>>>   guest process can simply drop a setuid root binary in shared direc=
tory
>>>>   and unpriviliged process can execute it and take over host system.=

>>>>
>>>>   So if virtiofs makes use of this mechanism, we are well with-in
>>>>   the existing constraints. If users don't follow the constraints,
>>>>   bad things can happen.
>>>>
>>>> - I think Smalley provided a solution for your concern in other thre=
ad
>>>>   we discussed this issue.
>>>>
>>>>   https://lore.kernel.org/selinux/CAEjxPJ4411vL3+Ab-J0yrRTmXoEf8pVR3=
x3CSRgPjfzwiUcDtw@mail.gmail.com/T/#mddea4cec7a68c3ee5e8826d6500203610302=
09d6
>>>>
>>>>
>>>>   "So for example if the host policy says that only virtiofsd can se=
t
>>>> attributes on those files, then the guest MAC labels along with all
>>>> the other attributes are protected against tampering by any other
>>>> process on the host."
>> You can't count on SELinux policy to address the issue on a
>> system running Smack.
>> Or any other user of system.* xattrs,
>> be they in the kernel or user space. You can't even count on
>> SELinux policy to be correct. virtiofs has to present a "safe"
>> situation regardless of how security.* xattrs are used and
>> regardless of which, if any, LSMs are configured. You can't
>> do that with user.* attributes.
> Lets take a step back. Your primary concern with using user.* xattrs
> by virtiofsd is that it can be modified by unprivileged users on host.
> And our solution to that problem is hide shared directory from
> unprivileged users.

You really don't see how fragile that is, do you? How a single
errant call to rename(), chmod() or chown() on the host can expose
the entire guest to exploitation. That's not even getting into
the bag of mount() tricks.


> In addition to that, LSMs on host can block setting "user.*" xattrs by
> virtiofsd domain only for additional protection.

Try thinking outside the SELinux box briefly, if you possibly can.
An LSM that implements just Bell & LaPadula isn't going to have a
"virtiofs domain". Neither is a Smack "3 domain" system. Smack doesn't
distinguish writing user xattrs from writing other file attributes
in policy. Your argument requires a fine grained policy a'la SELinux.
And an application specific SELinux policy at that.

>  If LSMs are not configured,
> then hiding the directory is the solution.

It's not a solution at all. It's wishful thinking that
some admin is going to do absolutely everything right, will
never make a mistake and will never, ever, read the mount(2)
man page.

> So why that's not a solution and only relying on CAP_SYS_ADMIN is the
> solution. I don't understand that part.

It comes back to your design, which is fundamentally flawed. You
can't store system security information in an attribute that can
be manipulated by untrusted entities. That's why we have system.*
xattrs. You want to have an attribute on the host that maps to a
security attribute on the guest. The host has to protect the attribute
on the guest with mechanisms of comparable strength as the guest's
mechanisms. Otherwise you can't trust the guest with host data.

It's a real shame that CAP_SYS_ADMIN is so scary. The capability
mechanism as implemented today won't scale to the hundreds of individual
capabilities it would need to break CAP_SYS_ADMIN up. Maybe someday.
I'm not convinced that there isn't a way to accomplish what you're
trying to do without privilege, but this isn't it, and I don't know
what is. Sorry.

> Also if directory is not hidden, unprivileged users can change file
> data and other metadata.

I assumed that you've taken that into account. Are you saying that
isn't going to be done correctly either?

>  Why that's not a concern and why there is
> so much of focus only security xattr.

As with an NFS mount, the assumption is that UID 567 (or its magically
mapped equivalent) has the same access rights on both the server/host
and client/guest. I'm not worried about the mode bits because they are
presented consistently on both machines. If, on the other hand, an
attribute used to determine access is security.esprit on the guest and
user.security.esprit on the host, the unprivileged user on the host
can defeat the privilege requirements on the guest. That's why.

>  If you were to block modification
> of file then you will have rely on LSMs.

No. We're talking about the semantics of the xattr namespaces.
LSMs can further constrain access to xattrs, but the basic rules
of access to the user.* and security.* attributes are different
in any case. This is by design.

>  And if LSMs are not configured,
> then we will rely on shared directory not being visible.

LSMs are not the problem. LSMs use security.* xattrs, which is why
they come up in the discussion.

> Can you please help me understand why hiding shared directory from
> unprivileged users is not a solution

Maybe you can describe the mechanism you use to "hide" a shared directory=

on the host. If the filesystem is mounted on the host it seems unlikely
that you can provide a convincing argument for sufficient protection.

>  (With both LSMs configured or
> not configured on host). That's a requirement for virtiofs anyway.=20
> And if we agree on that, then I don't see why using "user.*" xattrs
> for storing guest sercurity attributes is a problem.
>
> Thanks
> Vivek
>

