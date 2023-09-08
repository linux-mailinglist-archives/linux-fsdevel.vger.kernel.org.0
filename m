Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1F7986AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbjIHMBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjIHMBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:01:42 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE551BE7;
        Fri,  8 Sep 2023 05:01:39 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 320DB1C001B; Fri,  8 Sep 2023 14:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1694174498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCWFkyKfwI9bEpl9fadTSanqQe9wzQPVFsXP12g7JnM=;
        b=Qfg9H76WGa29+pU/g8IBJVLEVWOIBciqJEMQ4/L91p1PVHpZPe95oPKMial89SeH0bix2s
        ovhHBCdHG6DxgiiMwwX7cqh8xibXAdECnt6XZ7K79sTwLPkmJrdBD8Y/nqLZbTUvRlTaZ+
        4Y7zVaw6e/ZgQfCCq1q6uZzyBdtmu50=
Date:   Fri, 8 Sep 2023 14:01:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <ZPsNIXDpcCp/K8L3@duo.ucw.cz>
References: <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
 <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
 <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
 <20230908073244.wyriwwxahd3im2rw@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FKbQv0RtqEq20ooY"
Content-Disposition: inline
In-Reply-To: <20230908073244.wyriwwxahd3im2rw@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--FKbQv0RtqEq20ooY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> What I wanted to suggest is that we should provide means how to make sure
> block device is not being modified and educate admins and tool authors
> about them. Because just doing "umount /dev/sda1" and thinking this means
> that /dev/sda1 is unused now simply is not enough in today's world for
> multiple reasons and we cannot solve it just in the kernel.

It better be enough. And I'm pretty sure it is true in single-user
mode, or for usb sticks, or...

Simply fix the kernel. No need to re-educate anyone.


									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--FKbQv0RtqEq20ooY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPsNIQAKCRAw5/Bqldv6
8nSbAJ97C5cuxAFnBMsLL5cWuCCaxsb01ACgnODxymf5SRxpW8FqNDq6z0S+F9o=
=zx5U
-----END PGP SIGNATURE-----

--FKbQv0RtqEq20ooY--
