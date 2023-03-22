Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0830F6C4415
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 08:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCVH3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVH3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:29:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E55B9D;
        Wed, 22 Mar 2023 00:28:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9981B20AD0;
        Wed, 22 Mar 2023 07:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679470133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cymDLHsKErmhpfJVevitVVO6X1IcQsyXzRz4TMydPWI=;
        b=HqxxYv8w66oKUKmuICtM7fXmOPOun/5xVYIob9LRuwNBLJJccJqRVEjLEF+OO20vwxgCMr
        rIsh48lVgxsWOraYch2q8wqcr9tcxnc3E9+VcYojz3Yoc6TPW4JVaceH94Bvd/KVXjIjaB
        vUhx8C+O+On23OLHzI12eruEYFZpyag=
Received: from suse.de (unknown [10.163.42.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7AFFB2C141;
        Wed, 22 Mar 2023 07:28:51 +0000 (UTC)
Date:   Wed, 22 Mar 2023 08:28:50 +0100
From:   Johannes Segitz <jsegitz@suse.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr
 fix
Message-ID: <20230322072850.GA18056@suse.de>
References: <Yao51m9EXszPsxNN@redhat.com>
 <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com>
 <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
 <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com>
 <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com>
 <CAHC9VhQkLSBGQ-F5Oi9p3G6L7Bf_jQMWAxug_G4bSOJ0_cYXxQ@mail.gmail.com>
 <CAOQ4uxhfU+LGunL3cweorPPdoCXCZU0xMtF=MekOAe-F-68t_Q@mail.gmail.com>
 <YitWOqzIRjnP1lok@redhat.com>
 <CAHC9VhQ+x3ko+=oU-P+w4ssqyyskRxaKsBGJLnXtP_NzWNuxHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ+x3ko+=oU-P+w4ssqyyskRxaKsBGJLnXtP_NzWNuxHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2022 at 03:52:54PM -0500, Paul Moore wrote:
> On Fri, Mar 11, 2022 at 9:01 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > Agreed. After going through the patch set, I was wondering what's the
> > overall security model and how to visualize that.
> >
> > So probably there needs to be a documentation patch which explains
> > what's the new security model and how does it work.
>=20
> Yes, of course.  I'll be sure to add a section to the existing docs.
>=20
> > Also think both in terms of DAC and MAC. (Instead of just focussing too
> > hard on SELinux).
>=20
> Definitely.  Most of what I've been thinking about the past day or so
> has been how to properly handle some of the DAC/capability issues; I
> have yet to start playing with the code, but for the most part I think
> the MAC/SELinux bits are already working properly.
>=20
> > My understanding is that in current model, some of the overlayfs
> > operations require priviliges. So mounter is supposed to be priviliged
> > and does the operation on underlying layers.
> >
> > Now in this new model, there will be two levels of check. Both overlay
> > level and underlying layer checks will happen in the context of task
> > which is doing the operation. So first of all, all tasks will need
> > to have enough priviliges to be able to perform various operations
> > on lower layer.
> >
> > If we do checks at both the levels in with the creds of calling task,
> > I guess that probably is fine. (But will require a closer code inspecti=
on
> > to make sure there is no privilege escalation both for mounter as well
> > calling task).
>=20
> I have thoughts on this, but I don't think I'm yet in a position to
> debate this in depth just yet; I still need to finish poking around
> the code and playing with a few things :)
>=20
> It may take some time before I'm back with patches, but I appreciate
> all of the tips and insight - thank you!

Let me resurrect this discussion. With=20
https://github.com/fedora-selinux/selinux-policy/commit/1e8688ea694393c9d91=
8939322b72dfb44a01792
the Fedora policy changed kernel_t to a confined domain. This means that
many overlayfs setups that are created in initrd will now run into issues,
as it will have kernel_t as part of the saved credentials. So while the
original use case that inspired the patch set was probably not very common
that now changed.

It's tricky to work around this. Loading a policy in initrd causes a lot of
issues now that kernel_t isn't unconfined anymore. Once the policy is
loaded by systemd changing the mounts is tough since we use it for /etc and
at this time systemd already has open file handles for policy files in
/etc.

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Frankenstra=DFe 146, 90461 N=FCrnberg=
, Germany
Gesch=E4ftsf=FChrer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moer=
man
(HRB 36809, AG N=FCrnberg)

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmQarjEACgkQvCfdnSzE
/WZskw/9FYgktDjOsvztkB5Utny04C0x3z8y+aHfEyEwMndpczZ3CXNIM9mjKu7c
a1KFZEKqucb1wudqloCPoyleZJ5tym/h5gkyQ6jotEW6Y9+hzfB0pfZhg4ePS0OR
OXTOuLumVuh/bWOTGbTF87S6Be5jJ1L9OorWC0God5jJwDi37OJURT2pe41DvPGQ
oWPLmcr8olO7JmdVoFPzoTYqzOyB6eZvNOZX37X9mLowTE7gNIHm9kT01ca2ac3R
4NoT0zJq4g8ZiW8WcM1GI2FM5B6GJ0DAhqGXAlICBz+K7sD2FrLfye0oJwr1xOZO
zbA1Gzc0Va9d06mqmXUXM3fKzCko76HSUVSu2JfLs+9ScL9CZb9qyr4W6LjwdbjW
3ZVswI8wXuuTrcv2+iZ+pr+wrNaOkTZPU3qX78xcBTbkrtDjDJKM2QWJJlbDMSYH
mjL7A3N7676pwarozT5zmXse599yxTrN/EeRiLevTv4NhVYVzxjOppnXQGrX/s52
Cy4PO9mR5U2NnbjduvnWhFnTXnmhmtU6pbCg3XSwHbFboquqD9D3IeZExnRhYa7Z
DgGNPkWjHI+2O2+ZL323i6hJjGGKFUhV41dUrBvE0TBLZNSaBogE9loWvArTd8S0
fA4gOhtBH68vM0m+OvveqRyFF6jWXQucPS5iTEQvKsEyNmErxbE=
=+WdL
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
