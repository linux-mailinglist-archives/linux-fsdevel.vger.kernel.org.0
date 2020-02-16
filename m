Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C342160179
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 04:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBPDAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 22:00:53 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:32802 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbgBPDAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 22:00:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9CF298EE302;
        Sat, 15 Feb 2020 19:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581822052;
        bh=cTM4up6ZHWt6uvFdR9pTu6vFaE8kPAInf9FaNsvghgM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oVxp8hYp4moaQyeb7yWg+sGEeGWSNh4wuMSb/MeirpKFJ8Ey5ned5jdFCOwb9yOYo
         7t5KemaarhAW8Z8ayffy80Af+yjTGW0pEH8WYPMrJ638cr2DL3ZtYtlj6XCWMZHHxh
         SPhzA3t7EC1vgtAnv2JcIMuifW8B2qSSXakAKRgA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I7F1e5gXOGAD; Sat, 15 Feb 2020 19:00:52 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ABC098EE121;
        Sat, 15 Feb 2020 19:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581822052;
        bh=cTM4up6ZHWt6uvFdR9pTu6vFaE8kPAInf9FaNsvghgM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oVxp8hYp4moaQyeb7yWg+sGEeGWSNh4wuMSb/MeirpKFJ8Ey5ned5jdFCOwb9yOYo
         7t5KemaarhAW8Z8ayffy80Af+yjTGW0pEH8WYPMrJ638cr2DL3ZtYtlj6XCWMZHHxh
         SPhzA3t7EC1vgtAnv2JcIMuifW8B2qSSXakAKRgA=
Message-ID: <1581822026.3847.7.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 3/6] configfd: syscall: wire up configfd syscalls
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 15 Feb 2020 22:00:26 -0500
In-Reply-To: <20200216021615.letuocbf4jvqk6nj@yavin>
References: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
         <20200215153609.23797-4-James.Bottomley@HansenPartnership.com>
         <20200216021615.letuocbf4jvqk6nj@yavin>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iSmJS3JGUDs+hD7+BPsx"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-iSmJS3JGUDs+hD7+BPsx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-02-16 at 13:16 +1100, Aleksa Sarai wrote:
> On 2020-02-15, James Bottomley <James.Bottomley@HansenPartnership.com
> > wrote:
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl
> > b/arch/x86/entry/syscalls/syscall_32.tbl
> > index c17cb77eb150..fc5101e9e6c4 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -442,3 +442,5 @@
> >  435	i386	clone3			sys_clone3=09
> > 		__ia32_sys_clone3
> >  437	i386	openat2			sys_openat2=09
> > 		__ia32_sys_openat2
> >  438	i386	pidfd_getfd		sys_pidfd_getfd=09
> > 		__ia32_sys_pidfd_getfd
> > +436	i386	configfd_open		sys_configfd_o
> > pen		__ia32_sys_configfd_open
> > +437	i386	configfd_action		sys_configfd
> > _action		__ia32_sys_configfd_action
>=20
> Did you mean:
>=20
> +439	i386	configfd_open		sys_configfd_ope
> n		__ia32_sys_configfd_open
> +440	i386	configfd_action		sys_configfd_a
> ction		__ia32_sys_configfd_action

Yes, I obviously screwed up the rebase on that one.

James

--=-iSmJS3JGUDs+hD7+BPsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXkiwSgAKCRDnQslM7pis
hYwxAP9p5gY2q0aN7fbQKZ+ieX8qRWdNtIda4eqBK2DC/VsUdwEA5veSVnw6Af0e
V71nURr6OwiIujLnXAQM41Y7hWsNp8U=
=TQQ5
-----END PGP SIGNATURE-----

--=-iSmJS3JGUDs+hD7+BPsx--

