Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB75D3C71F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhGMOTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 10:19:55 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:46459
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236758AbhGMOTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626185824; bh=qSmib3x1dLQWlJoX90dq7cHQ8qcLZnxM2n0EuG5rzmQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=FFkKSsZe+cCb42thO5qAALp49q8v9dvIE2/84zyvZfFFJwACSvuAXaUPj9m04/zYOGIvAQw1XIwYBLfXWvFXy8az7vOcRZIRlBChNHNo3qXIC+aqiodRmnuVVFEBS7ovTHo5YjQ1HRbTnVBb6Ggt2M794VoVghWDY89yawjeVCsx6kdRYJyx5GSnBS7KMpRS3jjfty43ViA7ktcK6wEqoh3uzeT0rcvFa1S82HbGWRvsYRbTGrk3Oyz2YMKA0Ahu19Qf2CFSJck5jmQk7Pk8NxdhE7C1RHKBbG1SnonKj2L3e/zZQMgchDcJFSNj9t4pRAPrQUEhO/hR9w+ilJCiDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626185824; bh=njsM7fyZvHI/wufBwUx68ggkYEHtVKhjhgmk3RZq/6Z=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=GU5DRt0hsEC35OVpgiX4Whkuiv3ajd+goxAdRBP3QotsyjdJFREuDc88C6D9WhMRI+l1OCqWRkN8Vxa1Xdr26g2UK+Kl33is7G8XWN8mTHsAqII6ZxryeCn2j+KL7dePYDxFaPCGASYvMajv3/2blj8s9oLYqLlByduGTl8zhIX/14NdGXHRSZVBuoqHh1VmTzN7Vpm5gPjZWNcvWZlp3g0x7du8IeNLPiNQzUPms6Ul6wPc6fg7XE2yayABIrruHTV8ry9WHbB78dZtxXyDp/n/lYhzlTknQh5mXc0ASDz8sxvxHMEwjhfmgJzcle6KVbSDPsas1YUodLO0U7VWhQ==
X-YMail-OSG: _n1TojEVM1kx7ATuYgAhAOg0abWpCSz3d642VeFtNqjCfxyMXmRdmHFKH3KWY1Z
 eqhiOi9NXj7KbQ5.gryekrO__6waX3o0Ft5CvPUkTUQhvGaPmJ3.dhMWimwguEsXKDUCoERmDr8q
 PaXnpaBNt0G1TmDQwzhDQ8mWi1fh.fTxr_I6OconM5t9_oFSJgKGFT65hYh6u7WpFFGd4ZSpUIo2
 uUIx86gGRJ4T2F4F3pYib2BbwEDez8cS1nGb9_OtWtihgwfk9Oa.psArJ8lJVo3lHmzwNGKWrsSx
 wESWARPcp0iKQc2f66jug.rlstLsIWS_t8jSpxCb.0gFfPYQotMgzD0YJzF3M7NzYbmsA.8.1Lbg
 naVKXunVEgOXSHZvdidLVonzyBtHaRQmrOcUr4sidYvieCiDYDBCip1llqALf2xaiHpEIrWumoDL
 703Me1epcZ53TfuEc4lKEE8JEues9XKciCA681QrhMySaRPweXkefkf.DIdTrHL9_7jup06UGwFu
 8o2B1o0JzoW0oJ60myYbj6Xh_Hy4hvh4Q8hPb9av41MRbR3s7T36RJeDmauh5OkQBb1c2L7SuuGI
 C8aRYFWDOOPmvOAxHIyS8z9DxaSu_gxqt6Vmk0pxhmi4FBp28sQ65LFcXK.J9Zl3r7s1DeReYwVF
 CgWQKDIvdu0kwQMinD0Mfn4t77onF9m3ztK7as_BaaSt9mJXUSYbvij0qGf8I.Do1m3rYUSySrf_
 sLJoiP0dX3x0rHlM5mIsvucMGDYyoPhy_N09aXUSS2walB1Jg5AKTS7zmC_yutWte5BQVrc_cbh5
 JN.RBPhT66PjtHEbGdfMplLlmupR.ZwYuUWx4A_8If3ppRkPw0XTDVau9lTKcaaHppLEUvWoZ49P
 pkXZVfLylYN0tJLJ.3_gYo15NyKfb.fugqrmqWo7aBkjIbC33HFJR7vRKHxqv3mOqKSKBWoxE3da
 BDt4RAomOy.bvzvBJRkDrUtor_Obya0jQ7rSDhGDSPnwOVid3YsI3aN5PThizpIu4o84RJZqwb5v
 yMEsnGaDcDp07Xqw7OM8Ou_3F8zXQXiV9rIABjooRgUqpGm0j.yWW31IqTHTOumzOI4DXtw00KBU
 EVY.vaIIuC44lqdUi.r2MuY1uoPggVu9kGhYLK68_1qxZtR334.lb4z9FG1ns6vezMMKseX_dkqv
 83yKdIlins3CMaWQ.I1BhHcXf5cT19B3T.d9kk1t9j8eN0YgShZnbrjdF0KHWga2ijfG1TD3ni.7
 5tEvRu_lnFqZYgpCQN7so9iwjmKXq6M3fWcAUFw0HfS3L.Qq0yK9aEr981itMAyJT1ZH9e4sVt22
 mP1vYVlOjNFHQO88g.9GEc4KNcqeCrvYnY9okjjalsG4c0jatCSKy2Dz7p9y96reKX5_BAsI6x9X
 lvsIKcd.IDVhWVLMXegneBpQ5Ms1oTQFtXTKbhO_yCbWQ0z2NTQLBB2fT9aqUHH1JUpX0Z_ppYNj
 zg4Qz3bOsKtYhabc_A6U2U71DnXwhPSccRIANq9QQjtOj2AencPwrG_8UiaI34pX6J2iznrQocQM
 tvKa4g8SEBxrZXxtj3HzZsdjVwQSli7W6mFWd3UzZ1TFcb8dhUJLpPy.DX2y_DP2OXNPmsAzkA7N
 pDDmk4N.9IjlY9ER6.tTs8PytvT9sbuL85TEtuLrd85iAWa6BrMYkYtbSdrZRlKN7dwhJ5JRvFLs
 w8ltbEq998DfW4skJrcrpSIHPk9wIB.goIh8W.bIhSmcLEHTFO17NmX_jFEiF3g8O.Tx3wEISwRg
 gdgV05Ua3ILDNod2XKQoCzFwcpyvsgvjpJBlDWqoEUjHxpti8O.QKPQ8bEmC_g2P1BA28Jdrbmkm
 Vp3cRPc1H8PBxyXtKx026ovFBAktICkpp.c8r9GKLfHlt6mFY5axN_jzegyXteS_Uy24_7pnM1uX
 tIc8vksbyHpl22z1pg0dpZ7i4z37jwYhCvXulwmqP1GCIJa1Hc3B1vdWSKZ_MjGuC2dmxOl4_K3u
 dy8mI3vwKt4bY7ElJOFrK_MXu2h0LBFfohv2.z6zlGwW9KVnXHcDy1WK5sdl9ChcNWSZ0A86CoRj
 iwQk0UH_ze.jxvt29FGdglhQkxRK9M2IV9.UUjx6MLyGrn4nAE1nwmtS5JPYXWpPEvfLY8w_covX
 eA8iGOtiR1VHQzAgmBYQWnDGQaTMMIBIwKc2ZKzmOXg2B2.62DYo7KUVwZGrKSvBW3SntU3moJuX
 15nRkDERyYybhZpMGvKrosY4jtf0hMSl0xRW7ItjburpfUppQNvxO3icLYDYHB61od4bC5TqJCdq
 5HEtyo0nxQR4RGCfnpeirTNLt.HTnPKjU9Etb1imDnEOY.bIfD6q9Z7hFxa3z5zR.nS6QUTHGaTt
 mEeQfwAmZhEefcBJFOh214UEfwllnyJ9PG3RPiMjEpxOOqy9Ex4BN7Tpj5OHyU3Nm5tYZiQ9l6Zf
 FzuYq8DGx1qv5cleudISWsV5PXeM0NjdcT7VdBkwcP4ReiYP2YFzVf0l5umUvtGP4ZB2mCRURguk
 bSCFsvon8yaKjOg4Da5aJGNq57gDHtNxcBWlCL1x9yW99mn7_838b8eoa3lYyq9Y89BB2n99ct_h
 guqEI8JGMg5O7ptwSiGlc4CWy.xHkcqh2J.hKBjXvay4H4drlb7.tssuZcu_jYglxkLjBUSHM4.H
 6IL_jKSpgxivg7kkHh68yDFTQUt0Sd2yA.QnBjLWIgfMELx8LPbtEhsiALn7RY8SH50wfPrBeHdq
 E8VmDi0n5xWyStb1fohV3PF0R0WCxlVKpOn8EtGjRdix_PswCdWyRxfIWbiPbVAx2Mxbdt7Jr9bc
 8G6.e30vMdhNKAgG1mnMjBGhBxBiLRdf5vBOmi6T08vf9JCCpP_Yp90yyTFEtVrmr4pfAapg74z8
 vTASiPepVAjkx_UTVmPvr0okfWVIIq9SuWLow2.yfasxSUAe6qzBRHo2LyCwNjSu7sdyBRF0RITd
 0iuUFLG6CU3uS4VNhvHM52K_6FfImUeOL9wXnXlWOQ1LJkV0tdrpfLwUsr_qkVsYQYRUUtdy8tod
 GSRaYwnwhm6k3mMf4ErPuQbHIxs6qD39peutiWYneq.nW9N3l0bbOW7JgRMapXVGqxjptdKlCYzg
 A5Ry4aIZsBvoxm7B2gR8dTlbO4wJhIi7hcV1Txm2De12.xmS3cTfegWgfI1FPXLqKSz1lMWoIx7a
 _vJ1ZcvK.DmxfYOTy.tYyHFf7vss4ltjNEelMqjZxEpo4eOC48leuT8BYrHc731tsesb23TnXYXp
 GqLaBDXHFsEreiyCaSrOeO.MpNYZSYYDBatXhX8d4uw8CUepIg24Z4PeaL1zlxuIx7HwfXAUJzGF
 zBP8tw1sk0KBKaCCanycF.WMgnlhhrfGeWVdgTzBUJ6cainXFvlIZvPj70Tc5XtnKOEnnSomeEd2
 OQRAwMelaDItXGN0qms0gSiZ1G3ZmRo4M8VKQx3KJ4cir9dEtxinbO_jd3RBPNTY9O8MfbiNEdxe
 SlHbjoXIzHSWbBlgn3e72tzMcEuTvodLxJTSPZCBye2V5wrMq2bevYWfe3gH7_vZT8UaAr8l1BAb
 KqoQQoZN1Kv20jFdvjjHmwkeJaN3MNSPrIxV9OSq0XGxTPkuSdMRZ5URslhfwyVbew.yVDKcR8w-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jul 2021 14:17:04 +0000
Received: by kubenode524.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 28950ba845a757077a448cf8bdb00262;
          Tue, 13 Jul 2021 14:17:01 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
To:     Vivek Goyal <vgoyal@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Bruce Fields <bfields@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
 <20210709175947.GB398382@redhat.com>
 <CAPL3RVGKg4G5qiiHo7KYPcsWWgeoW=qNPOSQpd3Sv329jrWrLQ@mail.gmail.com>
 <20210712140247.GA486376@redhat.com> <20210712154106.GB18679@fieldses.org>
 <20210712174759.GA502004@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3d55ff30-c6cf-46c4-0e32-3b578099343d@schaufler-ca.com>
Date:   Tue, 13 Jul 2021 07:17:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712174759.GA502004@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/12/2021 10:47 AM, Vivek Goyal wrote:
> On Mon, Jul 12, 2021 at 11:41:06AM -0400, J. Bruce Fields wrote:
>> On Mon, Jul 12, 2021 at 10:02:47AM -0400, Vivek Goyal wrote:
>>> On Fri, Jul 09, 2021 at 04:10:16PM -0400, Bruce Fields wrote:
>>>> On Fri, Jul 9, 2021 at 1:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>>> nfs seems to have some issues.
>>>> I'm not sure what the expected behavior is for nfs.  All I have for
>>>> now is some generic troubleshooting ideas, sorry:
>>>>
>>>>> - I can set user.foo xattr on symlink and query it back using xattr name.
>>>>>
>>>>>   getfattr -h -n user.foo foo-link.txt
>>>>>
>>>>>   But when I try to dump all xattrs on this file, user.foo is being
>>>>>   filtered out it looks like. Not sure why.
>>>> Logging into the server and seeing what's set there could help confirm
>>>> whether it's the client or server that's at fault.  (Or watching the
>>>> traffic in wireshark; there are GET/SET/LISTXATTR ops that should be
>>>> easy to spot.)
>>>>
>>>>> - I can't set "user.foo" xattr on a device node on nfs and I get
>>>>>   "Permission denied". I am assuming nfs server is returning this.
>>>> Wireshark should tell you whether it's the server or client doing that.
>>>>
>>>> The RFC is https://datatracker.ietf.org/doc/html/rfc8276, and I don't
>>>> see any explicit statement about what the server should do in the case
>>>> of symlinks or device nodes, but I do see "Any regular file or
>>>> directory may have a set of extended attributes", so that was clearly
>>>> the assumption.  Also, NFS4ERR_WRONG_TYPE is listed as a possible
>>>> error return for the xattr ops.  But on a quick skim I don't see any
>>>> explicit checks in the nfsd code, so I *think* it's just relying on
>>>> the vfs for any file type checks.
>>> Hi Bruce,
>>>
>>> Thanks for the response. I am just trying to do set a user.foo xattr on
>>> a device node on nfs.
>>>
>>> setfattr -n "user.foo" -v "bar" /mnt/nfs/test-dev
>>>
>>> and I get -EACCESS.
>>>
>>> I put some printk() statements and EACCESS is being returned from here.
>>>
>>> nfs4_xattr_set_nfs4_user() {
>>>         if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
>>>                 if (!(cache.mask & NFS_ACCESS_XAWRITE)) {
>>>                         return -EACCES;
>>>                 }
>>>         }
>>> }
>>>
>>> Value of cache.mask=0xd at the time of error.
>> Looks like 0xd is what the server returns to access on a device node
>> with mode bits rw- for the caller.
>>
>> Commit c11d7fd1b317 "nfsd: take xattr bits into account for permission
>> checks" added the ACCESS_X* bits for regular files and directories but
>> not others.
>>
>> But you don't want to determine permission from the mode bits anyway,
>> you want it to depend on the owner,
> Thinking more about this part. Current implementation of my patch is
> effectively doing both the checks. It checks that you are owner or
> have CAP_FOWNER in xattr_permission() and then goes on to call
> inode_permission(). And that means file mode bits will also play a
> role. If caller does not have write permission on the file, it will
> be denied setxattr().
>
> If I don't call inode_permission(), and just return 0 right away for
> file owner (for symlinks and special files), then just being owner
> is enough to write user.* xattr. And then even security modules will
> not get a chance to block that operation.

That isn't going to fly. SELinux and Smack don't rely on ownership
as a criteria for access. Being the owner of a symlink conveys no
special privilege. The LSM must be consulted to determine if the
module's policy allows the access.

>  IOW, if you are owner of
> a symlink or special file, you can write as many user.* xattr as you
> like and except quota does not look like anything else can block
> it. I am wondering if this approach is ok?
>
>
>
>> so I guess we should be calling
>> xattr_permission somewhere if we want that behavior.
>> The RFC assumes user xattrs are for regular files and directories,
>> without, as far as I can tell, actually explicitly forbidding them on
>> other objects.  We should also raise this with the working group if we
>> want to increase the chances that you'll get the behavior you want on
>> non-Linux servers.
> Ok. I am hoping once this patch merges in some form, then I can
> follow it up with relevant working group.
>
>> The "User extended attributes" section of the xattr(7) man page will
>> need updating.
> Agreed. I will take care of that in a separate patch.
>
> Right now, I am not too sure if being owner should be the only check
> and I should skip calling inode_permission() entirely or not.
>
> Thanks
> Vivek
>
>> --b.
>>
