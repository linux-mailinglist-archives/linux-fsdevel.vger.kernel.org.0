Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B684242AB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgHLN4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHLN4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:56:21 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88409C061383;
        Wed, 12 Aug 2020 06:56:21 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p16so1701652ile.0;
        Wed, 12 Aug 2020 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L10aSxHQCG16LTPX2VDKvrZoq6RMS4QxZCBViQUa0lE=;
        b=pgS1Tr5ueTVxZumiz4wki6pU3O7plai+CT/VVA46teg+WQ4G7PjFw9jXbAkPep9RIa
         Qt0wI4PUBiBgdym8VglqLFW8DwHtKbEn+DJ12ycZHuBY1Hss9F4m/wniM5H6PPOyoPrr
         aD1cP9CgF3plaa4a2rWA37vrYnNk36dBkvnN0CzxGf5V7CEDaL4rwXqc1PVCiSbQ1n3u
         cYycOsymBZn+8+Ehk8H+x4wh9NSawJCwlPkYBa8Z/rsitOHLjQ9KDv+s1bD5Zhyjh+T4
         bi4L+psJ7MGWE/aYjZx+bKzn5FstLg5haAZaUzahe8f8Oc9Ex0JzBt7j+4/BDOW+ev+K
         eFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L10aSxHQCG16LTPX2VDKvrZoq6RMS4QxZCBViQUa0lE=;
        b=J4jshY8n9JJCDSXNOImKEHpEeULokLFqrzFDjzkJDiQBi1tfS6bLeIkD121hUgejiZ
         ejCQatumfnnXTDotKL2mjDgaZGL7fu2whO+OcEKUit8HQIVcUrvkDROQWljtkXDePbLj
         wi+CmjtLXd1wlX59WKegUppAr6G8byZxMdvMxrgx01jOkRRFHjqEbJIhjFBsjV8UAFQ6
         OmKTJhkQygyEJ4CI+JWBj86ubND2riKVMXGH1uhPglO/lM0xWeigdF7ZdJm4WT6hxV0W
         ptnvANBzFqL/H+xsM3KUYazXgoezVSivknB54MH+otFsrOUq1vLQ4xxXfE0KzlnIkmYL
         mgQg==
X-Gm-Message-State: AOAM531jeD3O2pwdaznwOo0mqNujqw5Drjb58iY0ywoX+4u378tQXsfK
        /BXL6+xqUN4prztmNdIkS6w=
X-Google-Smtp-Source: ABdhPJx/cW3b6ZCypx93XUp2fbLhIViYbxQNo1qPh97cr/CWUQguPl3jz7RLGcshibVycc8x8OWdVg==
X-Received: by 2002:a92:9adc:: with SMTP id c89mr6878133ill.272.1597240580818;
        Wed, 12 Aug 2020 06:56:20 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u62sm1117047ilc.87.2020.08.12.06.56.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:56:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <1597170509.4325.55.camel@HansenPartnership.com>
Date:   Wed, 12 Aug 2020 09:56:17 -0400
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
Message-Id: <2CA41152-6445-4716-B5EE-2D14E5C59368@gmail.com>
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
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 11, 2020, at 2:28 PM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
>> Mimi's earlier point is that any IMA metadata format that involves
>> unsigned digests is exposed to an alteration attack at rest or in
>> transit, thus will not provide a robust end-to-end integrity
>> guarantee.
>=20
> I don't believe that is Mimi's point, because it's mostly not correct:
> the xattr mechanism does provide this today.  The point is the
> mechanism we use for storing IMA hashes and signatures today is xattrs
> because they have robust security properties for local filesystems =
that
> the kernel enforces.  This use goes beyond IMA, selinux labels for
> instance use this property as well.

I don't buy this for a second. If storing a security label in a
local xattr is so secure, we wouldn't have any need for EVM.


> What I think you're saying is that NFS can't provide the robust
> security for xattrs we've been relying on, so you need some other
> mechanism for storing them.

For NFS, there's a network traversal which is an attack surface.

A local xattr can be attacked as well: a device or bus malfunction
can corrupt the content of an xattr, or a privileged user can modify
it.

How does that metadata get from the software provider to the end
user? It's got to go over a network, stored in various ways, some
of which will not be trusted. To attain an unbroken chain of
provenance, that metadata has to be signed.

I don't think the question is the storage mechanism, but rather the
protection mechanism. Signing the metadata protects it in all of
these cases.


> I think Mimi's other point is actually that IMA uses a flat hash which
> we derive by reading the entire file and then watching for mutations.=20=

> Since you cannot guarantee we get notice of mutation with NFS, the
> entire IMA mechanism can't really be applied in its current form and =
we
> have to resort to chunk at a time verifications that a Merkel tree
> would provide.

I'm not sure what you mean by this. An NFS client relies on notification
of mutation to maintain the integrity of its cache of NFS file content,
and it's done that since the 1980s.

In addition to examining a file's mtime and ctime as maintained by
the NFS server, a client can rely on the file's NFSv4 change attribute
or an NFSv4 delegation.


> Doesn't this make moot any thinking about
> standardisation in NFS for the current IMA flat hash mechanism because
> we simply can't use it ... If I were to construct a prototype I'd have
> to work out and securely cache the hash of ever chunk when verifying
> the flat hash so I could recheck on every chunk read.  I think that's
> infeasible for large files.
>=20
> James
>=20

--
Chuck Lever
chucklever@gmail.com



