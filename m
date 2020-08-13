Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277C2243B76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMOVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgHMOVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:21:38 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E8C061757;
        Thu, 13 Aug 2020 07:21:37 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s189so7509453iod.2;
        Thu, 13 Aug 2020 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZFwKOeefuJ9BwLJB/h+tffKpE4E/wD0tX8RKafaeamo=;
        b=j8brHypjvZXCRtF0FSf9CZ7EVpi+tSuYSHbNnQWo5djucgpeppUtqrWngOIWyONq+B
         E2UtsZKGONeEwJ7aGWsTC61ff4fpmlacQoxfZ9RyOqMuTyygXBe3axG+XWdiDYGxb8SF
         jI+kOj9TAirWQ2Avpl+xJyf9DCD7h0l9oWOYtx1PigGBg7VGLJouAJroA5eHrub3wnzk
         LHAcQAm/ODwTBVnW2nSGqOUeMeHcdkh4axUSZEORacTgsZzMoS4wxu7TlRc98LTb9GSW
         p2RTxjeIYdNyT9d+f+L9ZOzY6AljAmGo2rVqlb+VCmwaj6Uc0/frS3MPc+4xrvaKhzNa
         2bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZFwKOeefuJ9BwLJB/h+tffKpE4E/wD0tX8RKafaeamo=;
        b=dg2w1k4rJdUbMl/4nCAxDkwQJsHYStry/LF4mMUM/fRMzwrXjvc0fZrHAq6xJHRyfx
         DRlWOcZ/APHqSymPqTAy76W/xffA0WZjEyJE3TfzH5GAiLBNPgJiW11LTcn7POYBe6VC
         I5BxIZomCTTvILBrytJuE+S9bA6p355rqprRSamnYJX8iAj/mbX13D2ltBKQrwMLfHmP
         z0OyQ+1K7YuV/azkayYGqRhjja64ktiaY1KtCyAj+NBQjixvHlbqV/e1JOvZXc3STbXy
         KVCh3UlOCk1SxmGD+zM6397R0VORQ+Sd3MMxhDCCh9UvWSSdgRS1tZfGVEiD/uoyR8ZU
         qlpA==
X-Gm-Message-State: AOAM530PABnJW5EWcHqD89NY5y+s7+2+HNaSKTbeDJBlFM1nPFJaE5Up
        OVMa9m4BITF26PUF5JL7wQg=
X-Google-Smtp-Source: ABdhPJyIYg/Gw5O8Yh4tpNhKC70T2a7HFu6GXj7JTm3lSbVP6GV4lvCqcS7CdoqeZfjnwUtDnUf5Jw==
X-Received: by 2002:a02:cc53:: with SMTP id i19mr5342744jaq.33.1597328496878;
        Thu, 13 Aug 2020 07:21:36 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t88sm1541411ild.8.2020.08.13.07.21.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:21:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <1597246946.7293.9.camel@HansenPartnership.com>
Date:   Thu, 13 Aug 2020 10:21:31 -0400
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, nramas@linux.microsoft.com,
        serge@hallyn.com, pasha.tatashin@soleen.com,
        Jann Horn <jannh@google.com>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, mdsakib@microsoft.com,
        open list <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F328A12-25DD-418B-A7D0-64DA09236E1C@gmail.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
 <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com>
 <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
 <1596639689.3457.17.camel@HansenPartnership.com>
 <alpine.LRH.2.21.2008050934060.28225@namei.org>
 <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
 <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
 <da6f54d0438ee3d3903b2c75fcfbeb0afdf92dc2.camel@linux.ibm.com>
 <1597073737.3966.12.camel@HansenPartnership.com>
 <6E907A22-02CC-42DD-B3CD-11D304F3A1A8@gmail.com>
 <1597124623.30793.14.camel@HansenPartnership.com>
 <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
 <1597170509.4325.55.camel@HansenPartnership.com>
 <2CA41152-6445-4716-B5EE-2D14E5C59368@gmail.com>
 <1597246946.7293.9.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 12, 2020, at 11:42 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Wed, 2020-08-12 at 09:56 -0400, Chuck Lever wrote:
>>> On Aug 11, 2020, at 2:28 PM, James Bottomley <James.Bottomley@Hanse
>>> nPartnership.com> wrote:
>>>=20
>>> On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
>>>> Mimi's earlier point is that any IMA metadata format that
>>>> involves unsigned digests is exposed to an alteration attack at
>>>> rest or in transit, thus will not provide a robust end-to-end
>>>> integrity guarantee.
>>>=20
>>> I don't believe that is Mimi's point, because it's mostly not
>>> correct: the xattr mechanism does provide this today.  The point is
>>> the mechanism we use for storing IMA hashes and signatures today is
>>> xattrs because they have robust security properties for local
>>> filesystems that the kernel enforces.  This use goes beyond IMA,
>>> selinux labels for instance use this property as well.
>>=20
>> I don't buy this for a second. If storing a security label in a
>> local xattr is so secure, we wouldn't have any need for EVM.
>=20
> What don't you buy?  Security xattrs can only be updated by local =
root.
> If you trust local root, the xattr mechanism is fine ... it's the only
> one a lot of LSMs use, for instance.  If you don't trust local root or
> worry about offline backups, you use EVM.  A thing isn't secure or
> insecure, it depends on the threat model.  However, if you don't trust
> the NFS server it doesn't matter whether you do or don't trust local
> root, you can't believe the contents of the xattr.
>=20
>>> What I think you're saying is that NFS can't provide the robust
>>> security for xattrs we've been relying on, so you need some other
>>> mechanism for storing them.
>>=20
>> For NFS, there's a network traversal which is an attack surface.
>>=20
>> A local xattr can be attacked as well: a device or bus malfunction
>> can corrupt the content of an xattr, or a privileged user can modify
>> it.
>>=20
>> How does that metadata get from the software provider to the end
>> user? It's got to go over a network, stored in various ways, some
>> of which will not be trusted. To attain an unbroken chain of
>> provenance, that metadata has to be signed.
>>=20
>> I don't think the question is the storage mechanism, but rather the
>> protection mechanism. Signing the metadata protects it in all of
>> these cases.
>=20
> I think we're saying about the same thing.

Roughly.


> For most people the
> security mechanism of local xattrs is sufficient.  If you're paranoid,
> you don't believe it is and you use EVM.

When IMA metadata happens to be stored in local filesystems in
a trusted xattr, it's going to enjoy the protection you describe
without needing the addition of a cryptographic signature.

However, that metadata doesn't live its whole life there. It
can reside in a tar file, it can cross a network, it can live
on a back-up tape. I think we agree that any time that metadata
is in transit or at rest outside of a Linux local filesystem, it
is exposed.

Thus I'm interested in a metadata protection mechanism that does
not rely on the security characteristics of a particular storage
container. For me, a cryptographic signature fits that bill
nicely.


>>> I think Mimi's other point is actually that IMA uses a flat hash
>>> which we derive by reading the entire file and then watching for
>>> mutations. Since you cannot guarantee we get notice of mutation
>>> with NFS, the entire IMA mechanism can't really be applied in its
>>> current form and we have to resort to chunk at a time verifications
>>> that a Merkel tree would provide.
>>=20
>> I'm not sure what you mean by this. An NFS client relies on
>> notification of mutation to maintain the integrity of its cache of
>> NFS file content, and it's done that since the 1980s.
>=20
> Mutation detection is part of the current IMA security model.  If IMA
> sees a file mutate it has to be rehashed the next time it passes the
> gate.  If we can't trust the NFS server, we can't trust the NFS
> mutation notification and we have to have a different mechanism to
> check the file.

When an NFS server lies about mtime and ctime, then NFS is completely
broken. Untrusted NFS server doesn't mean "broken behavior" -- I
would think that local filesystems will have the same problem if
they can't trust a local block device to store filesystem metadata
like indirect blocks and timestamps.

It's not clear to me that IMA as currently implemented can protect
against broken storage devices or incorrect filesystem behavior.


>> In addition to examining a file's mtime and ctime as maintained by
>> the NFS server, a client can rely on the file's NFSv4 change
>> attribute or an NFSv4 delegation.
>=20
> And that's secure in the face of a malicious or compromised server?
>=20
> The bottom line is still, I think we can't use linear hashes with an
> open/exec/mmap gate with NFS and we have to move to chunk at a time
> verification like that provided by a merkel tree.

That's fine until we claim that remote filesystems require one form of
metadata and local filesystems use some other form.

To guarantee an unbroken chain of provenance, everyone has to use the
same portable metadata format that is signed once by the content =
creator.
That's essentially why I believe the Merkle-based metadata format must
require that the tree root is signed.


--
Chuck Lever
chucklever@gmail.com



