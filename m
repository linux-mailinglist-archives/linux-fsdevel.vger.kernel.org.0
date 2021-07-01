Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267743B950F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhGARBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 13:01:09 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:42137
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhGARBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625158717; bh=pTBo3a6qeTWyFtKHPmiArodQR9K+DzXWOak/CS0qlaQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=N+ri7YF3REupwg6iXCESHBs6cnsLPkru2W5JzKbNiKaQSYn93Da3FJfl8a5sxwhcm1Gb6gzIFlT/g3f4YcBG1OH6TUZzi85MMGqMtLqA7cIyg7Jg04JTlVVMS356Iq6wln+U4xq/ANM+k1IuG57YPb5LSX5SLAbMN0hQPTAoYr6iiw2HKR/Sq/XPtrAGISGTcv6pyao+ta5kEb+4ENXZiyUreNbFaqoq9EJJ/rEtF86ULQDzyLeWKPsNm60w9NztXDrL2MYwa44Crn3oqsZ2ttM24UqdeobA/RoM363hWX7rl3/TCuJ6vEVsdeT9jebPdfRbKjdIeU/4CB2s0ZtRMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625158717; bh=NsoD/TcaKCX8MxzI2Fx8I48GSX6goVQUx2RDkjSKc3W=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=p40Aw+TG+WQSecQMu340ycJiGB3FJKPO3rwrIEotVjoX+3Wtb3c74xaFKgHhiC0lsZXNpWu2b/JYcWqKvndshDf6o0mkofhhXdmRzX8p/sjU1tNF+7AqMEtBLph2YMNTZSOUPP9lVARBKwWQ3ovDw3X/l663twx4qLie42a1+RNMDTcOwoT6upUnlU0HuNpg0rOVjikovgyiI9jILdLBbu1/LBdWCxBEqpMAVawk5R+79c/UE5lO10O/Eix5zhBUoy/qfK1oFZPsQP+mow2dC6hSpnymmIA0otzrK3x2F18Dxijy5wVkrSmy3abhEhid5ETQ8mx/xrOwT4KsQnayOQ==
X-YMail-OSG: pg.cXP4VM1lFl3p7WxP1vIXjP.ik.Pal79QQR5n2V_1NMfgpiFDawSYeHtnG26O
 H9Wm4yo_cL3YzR8wkSxAko7oqp0PZFnGFzxoUBVqTQSJocpEsvh.Ba68KpHkGz.X7jDVKnhjUEIj
 xwlaE2rKp84Qx339QJ8bDXGtkocJ.rYi0XWHF.2uyFQHulzhG5ztf5caNGyyMzX9TwEwRvTr9Mqz
 _Xuh44W5io7Wlr7lkqTlnAR.67_0u0E5or3bfkoZHZ90mvipgGfLjevny8viMmf7Aw5W8D7qEdpA
 ASRhAfL60gyEafPGo324_C17PEHQxhY2K22UTeaTIMrODCpkNzFDYClagnfjAYYJM.0ylRM97SWW
 mU726214qyWNftJPTXXTtHFgXV1OnxmMv2rFS_8WmGroAF55tIFY.9RWY5a59xnqCWaohrun8LXY
 fR1fXgkzF.nw5NyCikAvsGUoGpudzSLmtCov0lz1cCoi3kVJqhrD1hgRorHz90dbMIOcv0cuhoYB
 TWGvgFV.rbpKI15EKJ._mCMFDbkz8dPKaN.cTKo27f2PHku6pf9Z90c_fkP0c8rECm2Dw0SkWGlK
 NZKSN66U19wrdb3aVWYeI0G4_YY5anrc9QP8dpE6KhSiDHuCnPIBiEHFJeNDZX5dhWRcX4ZWIvKe
 c3Nbt1r565bWMXepXuZZYVi1xbAsO1eU2YiM4Vveg3sYnYWWx2WZfOlIv3WON1zLBxJudtwCPVXD
 iBAeRd_pvjBeTDHn2AiHX2HoTXQqh_H7WXJekPvp0nT0oHyvUNogtgmxHVyHzi4WIU_FCEWzRcGj
 fYxPiNSHHvVaqnMRdyOow0CyF9AHg4mHPz.PaXpQ5G8tnpT7shcMycFUFrEL.Hr6Qw.PUuUG1pyg
 fm7y5Hx2lyPJb89Fqx351zPLDL8_w0hD0O.Gg8TEzPNOoFHHvIBeNJcjyV97CEMvtiwIgAEvmcy8
 Q4CGKMtDMpcLXMecNVOn.7uCWo3haFK6x7VPXDuz2bSmmbKk5uIOLe61VcFsj9wGwG7l45sDJhdK
 PjBLmm52SCarurb_HBxxTJnGhiWLM72rTAf4baIzj3OknOfc5wCM6M61Gyx2858qUsV3KX9nBlMV
 DjChBhCFUtAQVNJI_hrvU5Syd0u0QmwG3qF4RkRohzEQHvhKQO_YSXDsTg7ZU54gyr6jGRJKcNVj
 rJPP5fT7RmuZnyQvS6_FKpgUBKJFJtQwuCZ_qDjg9YwtzMTq5h9ahX1eewKzz4Ddn4UVpoYyTNd4
 E2R2e9sWdJM5_41HNt4uIqZDmbNPZW4jsbxDpO9HV8iyH3KxTDkcEoAXDGtxvd3wNYWRl.FayUvA
 7VHXBaZ10GIsaHTEmYU3qS_WR9ykNE2996nK2RA358gXv9Oi6o8KFgaafLGP8yjBgVuFPouxVQzW
 BLUQh.YOaoKXekX_LhSw38mWGbrMg.wP3x4XodSv4n0NFS4L8f8wiuwFeIvS5WNDP1iivRgt6PIF
 2RRUpmRnBodU.XRxCm6JSwJ2yZbcVHa_wxAS9H_I3Ywpsv9S2sfdRYZ.505iVt.2_7gTNHZBPkGf
 CRHuRhsGjM4F8saCxxP9kxnuU4GSLK2yi1pBalPAdx3h_T9WbVuuRBNCRJK6rRp9_aoMGpB8KrtD
 UfFeoKX32M.HJblpnSyXc.XvCpnhbK7m_26g0jTGhjVHBDzuLvTD4WNTXHtwzL_bfPWLSBpc6tlh
 1kF7Tbtz8NBWs.Gmesr2LsLelSLKDNO_fr0048t8Fm4IyJK.k9WienFy3VlVEwIF0MZN6t4q6P3v
 31NLWuXItxA8TgKfvoRoxzJRc2B.0JD3M23Fz_nA3A7EX9WN6yW2VBqYl0cK_eZpCd4qLWlSL9qe
 6kIvct3CJHe.ozrLbHqB8uuZCxG6vDLGkmLZ40uSnJEEdf1YNsiOWBa4PSxzVxGnTnBikMn6pdJk
 5YqYBqmLzScLycfYEe8.0k6gNP7Ne4FyyjryRZuuu259qjBWaS1XuY0R6NIKn4KGiPlLoGbbDk7D
 bM6MrTbODJzwZeImc8w44EUPIbdbRuU2DXFPIGt982fTAYVkGHF0CPQzV5_UQocFeKpbVquinr_A
 yY_QqfFaNXPotuu5gBaR8I5n30LXJyY70I5ywbh71U1qTr3QN8hzSWH.s7tiz8.1CXhU7RShuiTe
 MP0EpvhsXeDayROlDLNIhUdMK1AatfwF2Q.GIsk5FbpNKXJCaoVqMo3ytYmqrRIx_FzvobsfYzMr
 pb4ttoBg.wcVkGlNgbvYEJIWVaDwyFpUZxBj2Mgpb9d_ocbdDhRU769F4Y7bkZeKFDTM10W1s7RL
 LcXp7IAuks11acfVQ32QW.d6HkEXLM5d3S2B8huLKimNMHWufTXM1NlaTL6NpzyVXp6rDye8UBGn
 7iTzGOTHiaaCQ9vL1zWDgEntPOaTZkqqVK2kwYv6iX25Q2xI6T7WKTaYUcbCr3JM4ppWU..lsntV
 OM3K24YlaCgU5Ywj5skhqrauQZ6AYdP9SmQYf8o8TxVBGxkI8kFGjjcz3HI1YTQw4SIb1hrIn6gF
 qHv5sZt32bMBmZXMp98qDch1jP2BUN4UD98AaxnRkLe0blwJN8gqgm4t7S9bQFO_EWOvf4HPcQJW
 VmCi4PAQLI9IZyKoRvcE0OCbWxN.X9s.ooEIE9iTyTqW1moXfXK2hXwleRbh0NNzbnpaqt3OGZ4Y
 VaxKN8fvI47P6EclLUed2CNd06TrRMlFFTpyoYl8Qd.vwXGRiN41Ad0NNpsJcn7Lx9WrPOxGcA8B
 FWXtT2ngH35kBDgM65W4rgg66LfZMflPVs9dO5GQBZVFwz9hyY0dtyVVm35eDKbcLEeBOYZsq6f6
 lFcKQD7Uv9tlH4cLRinK2ySB6qaU4.OTCbGVW3olKmUxSb3N_q3aFFoaGpfIYOs5gWcwBMwqksvL
 6I8pIim81vZYAE7Yta_k_MmAyWs4aL8uRB8p0kzS9vrfOjSngWteG3lLFbrA6uALr3a7XlJ_WV9u
 W4jlLD1kW.aBhDsUn0eaXKYa0_jyHb5eMxPN5IIbGtEE_dUGhPjqmfTrOM69P.vQE7mjNnOVtvWy
 hUtDkmVMny0Chya5oKAs59X0yCsppBd1Dhq1zXe6UKvA5en9Xa3HqtWjT2YR8PDSYq7ygERBOETL
 Sgc5LcigeAyuGWM.2vCVIi8iZJdc.ZhGGkReNIQ7nIny0u.3y85YO.rWo.HC5EhYehbjt.VP7rth
 p0IsidB2I0FajkRzVdHIn5v5_0YR8ZZKwxGA0Ia3aYuBFhtgc3CiJwpgwTDIRAzgNT1YGhVPKPHo
 4x5GtiqUA_1QrhjnXqpu978rz719B.WP8vMff4x6kbT.WIj2tJVNjBvFWwH2QAGYECOHdatOrXVm
 urotRtArR8dt07DDwcr16ZFsWKzFG3EcCyWmxtl9owRaLAfiqmLH4MlwxzrnwtBCOKS76YV98m6m
 PBYo2d_p9P6.6pQ6DAyh985Am5aX.KGVcn4ZGgMYCbIV_SeqSXk1KV2v4fzuvyilanPfLLcMhTJk
 jSMzCq0BoCYvsKNIjYhEqaMUeFa3G8.rC2a0wVORIMMe9oaIDSrvgx737_3ZttCZv1g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 1 Jul 2021 16:58:37 +0000
Received: by kubenode529.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0f3a188a38af10bab7cd85cdd35e4a2b;
          Thu, 01 Jul 2021 16:58:35 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Daniel Walsh <dwalsh@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com> <YNvvLIv16jY8mfP8@mit.edu>
 <YNwmXOqT7LgbeVPn@work-vm> <YNyECw/1FzDCW3G8@mit.edu>
 <YNyHVhGPe1bFAt+C@work-vm> <YNzNLTxflKbDi8W2@mit.edu>
 <YN2BYXv79PswrN2E@work-vm> <20210701131030.GB159380@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <318ec3fd-187e-23cb-b30b-3cb9bb37ca54@schaufler-ca.com>
Date:   Thu, 1 Jul 2021 09:58:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701131030.GB159380@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/1/2021 6:10 AM, Vivek Goyal wrote:
> On Thu, Jul 01, 2021 at 09:48:33AM +0100, Dr. David Alan Gilbert wrote:
>> * Theodore Ts'o (tytso@mit.edu) wrote:
>>> On Wed, Jun 30, 2021 at 04:01:42PM +0100, Dr. David Alan Gilbert wrote:
>>>> Even if you fix symlinks, I don't think it fixes device nodes or
>>>> anything else where the permissions bitmap isn't purely used as the
>>>> permissions on the inode.
>>> I think we're making a mountain out of a molehill.  Again, very few
>>> people are using quota these days.  And if you give someone write
>>> access to a 8TB disk, do you really care if they can "steal" 32k worth
>>> of space (which is the maximum size of an xattr, enforced by the VFS).
>>>
>>> OK, but what about character mode devices?  First of all, most users
>>> don't have access to huge number of devices, but let's assume
>>> something absurd.  Let's say that a user has write access to *1024*
>>> devices.  (My /dev has 233 character mode devices, and I have write
>>> access to well under a dozen.)
>>>
>>> An 8TB disk costs about $200.  So how much of the "stolen" quota space
>>> are we talking about, assuming the user has access to 1024 devices,
>>> and the file system actually supports a 32k xattr.
>>>
>>>     32k * 1024 * $200 / 8TB / (1024*1024*1024) = $0.000763 = 0.0763 cents
>>>
>>> A 2TB SSD is less around $180, so even if we calculate the prices
>>> based on SSD space, we're still talking about a quarter of a penny.
>>>
>>> Why are we worrying about this?
>> I'm not worrying about storage cost, but we would need to define what
>> the rules are on who can write and change a user.* xattr on a device
>> node.  It doesn't feel sane to make it anyone who can write to the
>> device; then everyone can start leaving droppings on /dev/null.
>>
>> The other evilness I can imagine, is if there's a 32k limit on xattrs on
>> a node, an evil user could write almost 32k of junk to the node
>> and then break the next login that tries to add an acl or breaks the
>> next relabel.
> I guess 64k is per xattr VFS size limit.
>
> #define XATTR_SIZE_MAX 65536
>
> I just wrote a simple program to write "user.<N>" xattrs of size 1K
> each and could easily write 1M xattrs. So that 1G worth data right
> there. I did not try to push it further.
>
> So a user can write lot of data in the form of user.* xattrs on
> symlinks and device nodes if were to open it unconditionally. Hence
> permission semantics will probably will have to defined properly.
>
> I am wondering will it be alright if owner of the file (or CAP_FOWNER),
> is allowed to write user.* xattrs on symlinks and special files.

That would be sensible.
That's independent of your xattr mapping scheme.

>
> Vivek
>
