Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5243D367BD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 10:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhDVIMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 04:12:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:63336 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhDVIMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:12:32 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210422081156epoutp02aff2eb65f83dc9e32c29eaf03d02a59a~4H_C4iu6H0162801628epoutp028
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 08:11:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210422081156epoutp02aff2eb65f83dc9e32c29eaf03d02a59a~4H_C4iu6H0162801628epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619079116;
        bh=hGN/D79ILXUF4z5gRM4/N5jKv/ExjwkKUiG8meJr/Ws=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ALfdyW8QZqL2vtN0Fq3PZed+8YNXZAB05KURw+ZTN2M4Rz4VEKXTJvYKMKGyBOHAU
         0av2cXcJgCH2qDDWpH8375MrCpXr8JPGv61jKW+Bjbe8DkUjrRiNvGeOwfn3fbO9NZ
         oiAAhm/+yF6kuMbZV4XZr/D0abkyz10LaLMHzwII=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210422081155epcas1p12ea271e9d2ff474fe8bc3c081ef39324~4H_CSxzwt2800528005epcas1p1D;
        Thu, 22 Apr 2021 08:11:55 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FQqrp3gq9z4x9Pr; Thu, 22 Apr
        2021 08:11:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.30.09824.ACF21806; Thu, 22 Apr 2021 17:11:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210422081153epcas1p1520019a9ebf7795ecb6aeca1f8a1d1bf~4H_Axu-z12345923459epcas1p1J;
        Thu, 22 Apr 2021 08:11:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210422081153epsmtrp1cc2f48fec256d50f1e233711f111503b~4H_AwhAdn2208222082epsmtrp1c;
        Thu, 22 Apr 2021 08:11:53 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-df-60812fca9b0d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.82.08163.9CF21806; Thu, 22 Apr 2021 17:11:53 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210422081153epsmtip2f7a480e47fd144d6179c17122caab75d~4H_AfSJ9x1259512595epsmtip2U;
        Thu, 22 Apr 2021 08:11:53 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Amir Goldstein'" <amir73il@gmail.com>
Cc:     "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'Steve French'" <smfrench@gmail.com>, <senozhatsky@chromium.org>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Al Viro'" <viro@zeniv.linux.org.uk>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Christoph Hellwig'" <hch@infradead.org>,
        "'ronnie sahlberg'" <ronniesahlberg@gmail.com>,
        <aurelien.aptel@gmail.com>,
        =?UTF-8?Q?'Aur=C3=A9lien_Aptel'?= <aaptel@suse.com>,
        "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Dan Carpenter'" <dan.carpenter@oracle.com>,
        "'Colin King'" <colin.king@canonical.com>,
        "'Randy Dunlap'" <rdunlap@infradead.org>,
        "'Matthew Wilcox'" <willy@infradead.org>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <stfrench@microsoft.com>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
        "'samba-technical'" <samba-technical@lists.samba.org>,
        "'Jeff Layton'" <jlayton@kernel.org>,
        "'J. Bruce Fields'" <bfields@fieldses.org>
In-Reply-To: <CAOQ4uxgCJukhh9c0FjnP_CR0=Jpj+ObK1JPFVjsD4=oxuakcaw@mail.gmail.com>
Subject: RE: cifsd/nfsd interop
Date:   Thu, 22 Apr 2021 17:11:53 +0900
Message-ID: <02f001d7374f$27a667c0$76f33740$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJTyQqcqdQSNpV/lHa5XB7yLgZgIwNL6ZwbAvs6Z/8CAQA1+KmExgzw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGcz96b1Eq18LcATLB63Ba+WithYORxSmwu+Ami2HZIBt09Iai
        pe3a4pzMpJgAygQkoGKBQFC7CWMIEoEyBxZdg2RjbuCiTpmjNRQoCmQTxsfW9rKM/37nnOc5
        73nek5ePCU+TQfxstYHVqeUqmliDX+/bJo64E5WfIe5yBsJ81wAOf/qmCYG2iSUSjlWmwoWm
        EgJOLJ/H4cCZBhReabqNwnsjz0g4b24k4bc3+t2G3gEedP3mlpSUzvDg4qUeEhYMiWB3awMB
        m2dHSTg51kfAB+V1BBxcsvHgwlwNsWcDYzKWEEy18S7OXD17gmC6TI9I5tpXIqat8RTB1FWb
        UKb7vpFgCjqXSGba8QBn2i8+QZmW9mGcmW3byLTZXWjyulTVbiUrV7C6UFadqVFkq7Pi6KSD
        6fvSZdFiSYQkFsbQoWp5DhtHx+9PjkjMVrmz06FH5Kpc91ayXK+no17frdPkGthQpUZviKNZ
        rUKllYi1kXp5jj5XnRWZqcnZJRGLd8jcygyV8kbLZUzbLjp6s7KKZ0RsG4sRPh9QO0FRx/Fi
        ZA1fSHUioN7aSnKLGQSYhxwYt5hFQPWgkVeM+Hgdc4WtKHdgQcCLK8veAyHlREChEfMwQUWA
        5cUewsMB1HYwZrntNWDUZRI0LIx6RT7Uu6Dh2hekh/2pEPBovsjLOBUGzJM2xMMCKhYsWRZ5
        HK8H/RfsuIcxt77DVYNxLwoF8w4zjyuWCL53FCKcJgBUnyr0RgBUnw8oGDbhnCEefD3etcL+
        YNzWTnIcBJxlhSTXmDww3bNy/0kEjL2I41gK7rdc5XkkGLUNtFiiuO1NoGuhdqXsOjD152ke
        d4sAnCwUcpIwUPpzH8pxMCguek6eQWjTqmCmVcFMqwKY/i9Wj+CNyAZWq8/JYvUSrXT1X7ch
        3rEQxXQi51zPI60IykesCOBjdICgWW/MEAoU8s+OsTpNui5XxeqtiMzd6nIs6KVMjXuu1IZ0
        iWyHVCqFO6NjomVS+mVB1r68DCGVJTewh1lWy+r+86F8nyAjKs8uKblpsceMCelwQaKZ51v7
        wegfmx/7bn2YUHqilz9XXvp+kR8Z4DdkHfySL7UXVclCth6YCuxBO9i3Rn3DAEiJ2h98ofKX
        X633qlSq68Ehe88aNBNv56/3Tzt8KfDz7pb3Pn0zMN5RY1K+lpbg73gl079879LaGp8juP1h
        +PmLyqS0+KS1eABEPywV9Cp+T/8k9aj575ynsa5z+a23VB/Vv3pgV8Pxxb/uluFOYe+WqWdP
        IhMsj53D1T/G6yccYb2O7fMVWoiNHzuUcrAsNq928uOqbEWxa6bHMN1cn+u3pa4uwVlBj9gq
        7Mihd0Z+eCrG9szcitn8zxvi70R3+iNTwmlcr5RLRJhOL/8XBBPq9J8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCSvO5J/cYEg47HGhaNb0+zWFxYt5rR
        4vjrv+wWL6ZEWfxe3ctm8frfdBaL0xMWMVmsXH2UyeLa/ffsFj+XrWK32LP3JFDDgdOsFm/v
        AJX09n1itfizZD+7ResVLYvdGxexWaz9/Jjd4s2Lw2wWtybOZ7M4//c4q8XvH3PYHMQ8ZjX0
        snnMbrjI4rFhahObx85Zd9k9Nq/Q8ti0qpPNY/7sWUweu282sHm07vjL7vHx6S0Wjy2LHzJ5
        rN9ylcXj8yY5j01P3jIF8EVx2aSk5mSWpRbp2yVwZexdv5S5YItWxcEpM1gbGI/LdTFyckgI
        mEj8aNvIBGILCexglNi3KxUiLi1x7MQZ5i5GDiBbWOLw4eIuRi6gkueMEktnHACrZxPQlfj3
        Zz8biC0ioC3xYtdRJpAiZoGt7BIvpuxlguhoYZJYtnkyI0gVp0CgxKLN3ewgtrCAvMTdn+1g
        NouAqsSyN8fBangFLCX+7vrDCmELSpyc+YQFxGYG2tD7sJURwpaX2P52DjPEpQoSP58uY4W4
        wk3i2NM2qBoRidmdbcwTGIVnIRk1C8moWUhGzULSsoCRZRWjZGpBcW56brFhgVFearlecWJu
        cWleul5yfu4mRnDi0NLawbhn1Qe9Q4xMHIyHGCU4mJVEeNcWNyQI8aYkVlalFuXHF5XmpBYf
        YpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwHQlu1OF94frzlrv6a/lJf6F//rlx1iv
        aj5xhegpr4mXv1y2CkltWLam4dGlu9ct/QVvrYk97vXy6IqciVouV9k8JB4wpv62Zn14sNty
        jx0L85zADMvsedIyb3vcDbh2uP/g8X5vMHuGzbqbOwVSQnSfus/5ulw8dgJT99+lB4RONdw7
        +OSJemM1352MRaWiUx+x/+rza7F+qrj1f0N8X068wM9tXacXfD22+pQwg+rUBDGOqemnbhyf
        rZT9ly/e1C9h3WaVQ5OuxzXvPZO81+ugrt/yEjuNHz3taf61PAniB9uM5C+fEt3hPSHmbN3S
        sxWii2QfzjT79ml3Iufq1rwHkV9svWsDKirqA+41FymxFGckGmoxFxUnAgBi5+16iwMAAA==
X-CMS-MailID: 20210422081153epcas1p1520019a9ebf7795ecb6aeca1f8a1d1bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003836epcas1p391ed30aed1cf7b010b93c32fc1aebe89
References: <CGME20210422003836epcas1p391ed30aed1cf7b010b93c32fc1aebe89@epcas1p3.samsung.com>
        <20210422002824.12677-1-namjae.jeon@samsung.com>
        <20210422002824.12677-2-namjae.jeon@samsung.com>
        <CAOQ4uxgCJukhh9c0FjnP_CR0=Jpj+ObK1JPFVjsD4=oxuakcaw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> On Thu, Apr 22, 2021 at 4:31 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
> >
> > This adds a document describing ksmbd design, key features and usage.
> >
> > Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> > Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
> > Signed-off-by: Steve French <stfrench@microsoft.com>
> > ---
> >  Documentation/filesystems/cifs/cifsd.rst | 152
> > +++++++++++++++++++++++  Documentation/filesystems/cifs/index.rst |  10 ++
> >  Documentation/filesystems/index.rst      |   2 +-
> >  3 files changed, 163 insertions(+), 1 deletion(-)  create mode 100644
> > Documentation/filesystems/cifs/cifsd.rst
> >  create mode 100644 Documentation/filesystems/cifs/index.rst
> >
> > diff --git a/Documentation/filesystems/cifs/cifsd.rst
> > b/Documentation/filesystems/cifs/cifsd.rst
> > new file mode 100644
> > index 000000000000..cb9f87b8529f
> > --- /dev/null
> > +++ b/Documentation/filesystems/cifs/cifsd.rst
> > @@ -0,0 +1,152 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==========================
> > +CIFSD - SMB3 Kernel Server
> > +==========================
> > +
> > +CIFSD is a linux kernel server which implements SMB3 protocol in
> > +kernel space for sharing files over network.
> > +
> 
> Hello cifsd team!
Hi Amir,
> 
> I am very excited to see your work posted and especially excited to learn about the collaboration with
> the samba team.
Thanks!
> 
> One of the benefits from kernel smbd implementation is improved ability to interoperate with VFS in
> general and nfsd in particular.
Agreed. This seems to be an important issue, I was missing this.
> 
> For example, I have discussed with several samba team members the option that ksmbd will serve as a
> kernel lease agent for samba, instead of having to work around the limitations of file lock UAPI.
> 
> Could you share your plans (if any) for interoperability improvements with vfs/nfsd?
> 
> It would be useful to add an "Interop" column to the Features table below to document the current
> state and future plans or just include a note about it in the Status column.
Okay, First, I need to check your previous mails about this. Then I will update it in features table.
> 
> Off the top of my head, a list of features that samba supports partial kernel/nfsd interop with are:
> - Leases (level 1)
> - Notify
> - ACLs (NT to POSIX map)
> - Share modes
> 
> In all of those features, ksmbd is in a position to do a better job.
Right.
> 
> I only assume that ksmbd implementation of POSIX extensions is a "native" implementation (i.e. a
> symlink is implemented as a symlink) so ksmbd and nfsd exporting the same POSIX fs would at least
> observe the same objects(?), but I would rather see this explicitly documented.
Okay.
> 
> Thanks,
Thank you!
> Amir.
> 
> [...]
> 
> > +
> > +CIFSD Feature Status
> > +====================
> > +
> > +============================== =================================================
> > +Feature name                   Status
> > +============================== =================================================
> > +Dialects                       Supported. SMB2.1 SMB3.0, SMB3.1.1 dialects
> > +                               excluding security vulnerable SMB1.
> > +Auto Negotiation               Supported.
> > +Compound Request               Supported.
> > +Oplock Cache Mechanism         Supported.
> > +SMB2 leases(v1 lease)          Supported.
> > +Directory leases(v2 lease)     Planned for future.
> > +Multi-credits                  Supported.
> > +NTLM/NTLMv2                    Supported.
> > +HMAC-SHA256 Signing            Supported.
> > +Secure negotiate               Supported.
> > +Signing Update                 Supported.
> > +Pre-authentication integrity   Supported.
> > +SMB3 encryption(CCM, GCM)      Supported.
> > +SMB direct(RDMA)               Partial Supported. SMB3 Multi-channel is required
> > +                               to connect to Windows client.
> > +SMB3 Multi-channel             In Progress.
> > +SMB3.1.1 POSIX extension       Supported.
> > +ACLs                           Partial Supported. only DACLs available, SACLs is
> > +                               planned for future. ksmbd generate random subauth
> > +                               values(then store it to disk) and use uid/gid
> > +                               get from inode as RID for local domain SID.
> > +                               The current acl implementation is limited to
> > +                               standalone server, not a domain member.
> > +Kerberos                       Supported.
> > +Durable handle v1,v2           Planned for future.
> > +Persistent handle              Planned for future.
> > +SMB2 notify                    Planned for future.
> > +Sparse file support            Supported.
> > +DCE/RPC support                Partial Supported. a few calls(NetShareEnumAll,
> > +                               NetServerGetInfo, SAMR, LSARPC) that needed as
> > +                               file server via netlink interface from
> > +                               ksmbd.mountd.
> > +==============================
> > +=================================================
> > +

