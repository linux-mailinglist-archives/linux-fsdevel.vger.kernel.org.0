Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946A274196A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF1UTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 16:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjF1UTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:19:04 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7777B1FEF;
        Wed, 28 Jun 2023 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687983534;
        bh=PbluAP57CpIIaXvOGapkwKIW8x93+/qYk4SdJ04NFh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1DrQqJx8leEoEgyi77wUmYtSGjlxtSq8XHdLNZniH5D6YKy2B4iYXbny+ib940lJ
         vTYaVFQ6swp5NBCrEkueU4ymaFtF5S0cEqO4e+fVgk4yYM4Cg0HmSl8x33uZiYY3io
         UYwFuCrgxosWW29M9dqURFQVEYNdOAfDhkZkmN5HrpZ/oVBej4xw1xuis0oY5nDYjY
         nV3s3pp1uNQc+2G0zwa/cnMqNjyfUQElCtNr9yC/VoslqWQ+sl2jM631HsKyGPejS/
         85SO3x+jcrhZP4kNl09Xy0E1LP3HC+9h8hZqj8b5zZnPVHrikzbGSImX628p1O6rk5
         MrD3dZW21wdrg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3218115CA;
        Wed, 28 Jun 2023 22:18:54 +0200 (CEST)
Date:   Wed, 28 Jun 2023 22:18:53 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: Re: [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
Message-ID: <3nfsszygfgzpli4xvwuwpli5ozpqtcnlij737qid6riwramjkv@pj23p6q5tzrb>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
 <q2nwpf74fngjdlhukkxvlxuz3xkaaq4aup7hzpqjkqlmlthag5@dsx6m7cgk5yt>
 <CAOQ4uxh-ALXa0N-aZzVtO9E5e6C5++OOnkbL=aPSwRbF=DL1Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kq2jxxetonbh2epl"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh-ALXa0N-aZzVtO9E5e6C5++OOnkbL=aPSwRbF=DL1Pw@mail.gmail.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--kq2jxxetonbh2epl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 09:38:03PM +0300, Amir Goldstein wrote:
> On Wed, Jun 28, 2023 at 8:09=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > On Wed, Jun 28, 2023 at 09:33:43AM +0300, Amir Goldstein wrote:
> > > I think we need to add a rule to fanotify_events_supported() to ban
> > > sb/mount marks on SB_KERNMOUNT and backport this
> > > fix to LTS kernels (I will look into it) and then we can fine tune
> > > the s_fsnotify_connectors optimization in fsnotify_parent() for
> > > the SB_KERNMOUNT special case.
> > > This may be able to save your patch for the faith of NACKed
> > > for performance regression.
> > This goes over my head, but if Jan says it makes sense
> > then it must do.
> Here you go:
> https://github.com/amir73il/linux/commits/fsnotify_pipe
>=20
> I ended up using SB_NOUSER which is narrower than
> SB_KERNMOUNT.
>=20
> Care to test?
> 1) Functionally - that I did not break your tests.
) | gzip -d > inotify13; chmod +x inotify13; exec ./inotify13
tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
inotify13.c:260: TINFO: file_to_pipe
inotify13.c:269: TPASS: =D0=BE=D0=BA
inotify13.c:260: TINFO: file_to_pipe
inotify13.c:269: TPASS: =D0=BE=D0=BA
inotify13.c:260: TINFO: splice_pipe_to_file
inotify13.c:269: TPASS: =D0=BE=D0=BA
inotify13.c:260: TINFO: pipe_to_pipe
inotify13.c:269: TPASS: =D0=BE=D0=BA
inotify13.c:260: TINFO: pipe_to_pipe
inotify13.c:269: TPASS: =D0=BE=D0=BA
inotify13.c:260: TINFO: vmsplice_pipe_to_mem
inotify13.c:269: TPASS: =D0=BE=D0=BA
inotify13.c:260: TINFO: vmsplice_mem_to_pipe
inotify13.c:269: TPASS: =D0=BE=D0=BA

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0

The discrete tests from before also work as expected,
both to a fifo and an anon pipe.

> 2) Optimization - that when one anon pipe has an inotify watch
> write to another anon pipe stops at fsnotify_inode_has_watchers()
> and does not get to fsnotify().
Yes, I can confirm this as well: fsnotify_parent() only continues to
fsnotify() for the watched pipe; writes to other pipes early-exit.

To validate the counterfactual, I reverted "fsnotify: optimize the case
of anonymous pipe with no watches" and fsnotify() was being called
for each anon pipe write, so long as any anon pipe watches were registered.

--kq2jxxetonbh2epl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSclaoACgkQvP0LAY0m
WPGEbg//cj23PmCJ73Ev+PmMefCpRtuYucdcpi5l3icLi2aAsM6rjVn9RzHgj/nj
DYif2JzFoHk4lwsBcx5v2t0aZXAadUFPq8RmrTfplNfsaMcGkCboCOYIRZ8FCnH8
tAuZREZl7mO/8byRzFnSIBiDzPdi/y7WAglnRZpYIGq6LYPD65cQq6Xx83f8d0vi
avzT3S8+jTV9npgfqsuPX6aN9tvVLD/rb70H6eiQT8tLK3IjogU7yPrc7GtqKFN1
jseFtY5Y2R2IfDgbJmMheRQ23vo2R2Avjls1zLk9m6v0HxHnBGUjTYfwpNX1PNjI
1OfbxzNTGmhUpF1shVAljZ3HMQbrYSyKyaWY0zCOaj0h2QVRtC+li5xqIt6o9oTZ
an7on2xShO2UylU9rEnb+pPll9r68zSki5N2nwhIyv/BQDGzao4eNMFMVNknn35b
Nr3xGh0HHUOgbA09PbtrfNU/x22aGs1XVVXLPfWpbuFaz9xUkaeqArEIdHg/yZ2y
nEKwi1cqfE4di2p06obnaODlcvOrGm+2yimd9g6Sdvc9TejfyoeT0wJeD+VJaEiI
zdJQaB8RIR58jI4YCrJ8zIbpn5EPR04+p4qls0dRleWw6jeZxn+weVScVkuH9q01
mSjPLuYuSHTXeCUyiIjPGtrxvX3LbW4FZGiP17jX8S1IpkKjMt0=
=c7nN
-----END PGP SIGNATURE-----

--kq2jxxetonbh2epl--
