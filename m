Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F246E0E18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDMNJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDMNJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AEF93F2;
        Thu, 13 Apr 2023 06:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0260762E89;
        Thu, 13 Apr 2023 13:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5C8C433EF;
        Thu, 13 Apr 2023 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681391356;
        bh=AWbmYvm0BaPLBXxQYzVBS7Z1o98tfRJX55ZZ9uopePg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cW5WbjWN+LmvoIXAVWeBWo780XujpOR9w00INy4sikwvZCRjBX3zEEzo+EVjYogN8
         fvqSjMiMXtZsNLPRdyDuqdDN+EsC+tIXPC0N72FJjIhnLj98jK79Ud3gcDC2nsGERH
         KtoH+iV5egkyplBkJjIiOgQlZprWEHg01/ZSc1DxriqKYVQ2q2tBVJbhk60dww458r
         tOJHG+fF6iSbzuxreJnUJwpUdw1XcfktVGcwt60BdsR1Y9gbmqS/acs1gpZRTuQ9ps
         B5CXZluaFTT+8J5z8eUd0TwIVlugjryhKP1m/lyH6yvWNHgdCpc/KIkOK6keuTboKK
         hgPz0FsfMX9iw==
Message-ID: <a486f239b361a6f03cf40c3762876e206c5dbfd8.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF for nfsd
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 13 Apr 2023 09:09:14 -0400
In-Reply-To: <20230413-perspektive-glasur-6e2685229a95@brauner>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
         <20230413-perspektive-glasur-6e2685229a95@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-04-13 at 11:33 +0200, Christian Brauner wrote:
> On Wed, Apr 12, 2023 at 06:27:07PM +0000, Chuck Lever III wrote:
> > I'd like to request some time for those interested specifically
> > in NFSD to gather and discuss some topics. Not a network file
> > system free-for-all, but specifically for NFSD, because there
> > is a long list of potential topics:
> >=20
> >     =E2=80=A2 Progress on using iomap for NFSD READ/READ_PLUS (anna)
> >     =E2=80=A2 Replacing nfsd_splice_actor (all)
> >     =E2=80=A2 Transition from page arrays to bvecs (dhowells, hch)
> >     =E2=80=A2 tmpfs directory cookie stability (cel)
> >     =E2=80=A2 timestamp resolution and i_version (jlayton)
>=20
> I'd attend this one.
>=20

I wonder if we ought to propose a separate FS track spot for this? I
sort of expect some lively discussion, and this may be of more interest
than just nfsd folks.

> >     =E2=80=A2 GSS Kerberos futures (dhowells)
> >     =E2=80=A2 NFS/NFSD CI (jlayton)
> >     =E2=80=A2 NFSD POSIX to NFSv4 ACL translation - writing down the ru=
les (all)
>=20
> I have some experience dealing with ACLs so I'm happy to attend just in
> case I may be useful.

That would be helpful! I'll note that there was a draft RFC for this
many years ago, but it expired:

  =C2=A0https://datatracker.ietf.org/doc/html/draft-ietf-nfsv4-acl-mapping-=
05

I think most of the rules are laid out there, but there are some areas
where things just don't work right.

A more radical idea:

I wonder if we could get any traction at the IETF on a POSIX ACL
extension for NFSv4? Basically, we could resurrect the old v3 nfsacl
protocol as new operations for v4, and allow the client and server to
negotiate on using them.

Given that almost all the clients and servers in operation on the planet
have to translate these, it makes some sense to avoid the translation
when we can.

--=20
Jeff Layton <jlayton@kernel.org>
