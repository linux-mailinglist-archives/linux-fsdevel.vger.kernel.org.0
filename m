Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA28635F000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350377AbhDNIlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 04:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350387AbhDNIlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618389655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eDVMJkpRK1Zblh+QKUchn0+EWb/JoRAGYZO+L/mZbdU=;
        b=BlL69nv3bKUEizesfXE4Ss2Oe2KcFO1d5TYvUcmtwBGFZRLTjeGhAseiEECk6APN9KYQDr
        Obmdb0tZl/WradG/suSzg6b/GLlBU8kzijOpHZXzc0KDw5rh9VqgP+NiYX/nxo0olAIRHT
        55w1uuj2j3BBSWHofRtTtX8vEP3hQhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-pyeGloAtMc223IRxWQU0_A-1; Wed, 14 Apr 2021 04:40:52 -0400
X-MC-Unique: pyeGloAtMc223IRxWQU0_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 683D28030CA;
        Wed, 14 Apr 2021 08:40:51 +0000 (UTC)
Received: from localhost (ovpn-114-209.ams2.redhat.com [10.36.114.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D46AA6A039;
        Wed, 14 Apr 2021 08:40:50 +0000 (UTC)
Date:   Wed, 14 Apr 2021 09:40:49 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     vgoyal@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: remove useless function
Message-ID: <YHaqkV0rUc7iu66f@stefanha-x1.localdomain>
References: <1618305743-42003-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iAAPjvzcPxYyW4TN"
Content-Disposition: inline
In-Reply-To: <1618305743-42003-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--iAAPjvzcPxYyW4TN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 05:22:23PM +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
>=20
> fs/fuse/virtio_fs.c:130:35: warning: unused function 'vq_to_fpq'
> [-Wunused-function].
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/fuse/virtio_fs.c | 5 -----
>  1 file changed, 5 deletions(-)

The function was never used...

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iAAPjvzcPxYyW4TN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmB2qpEACgkQnKSrs4Gr
c8iE9Af/a/YtHLu0Ely+QkjFL93NVsZwlPbkJERhv9mpU3qzK2gU9aHG0fD4bdPQ
fpvXmjcncPiB4OX8se/gdVg2YrVaBC9w/t/DPho4JZvnMeZsTLMvpk2oncKyZObb
s+Tp4GoTg++uWS8e7b4bu7R79mm8q9xGpyc9t9grC7VbHbMN8OMJwmcMJz/hHndg
fRoojMr9xsZQ9wThmAgmMrQy4W3XwIX8JDv1hAl3wiUWJSIr+izEmNMjLsN2QV61
vV1PpKhL07W1sTTLxMm5krVi0DNV8HInQTsTCF6gBYGocDoWl/BvAXKm4SpmnlS2
9g7Fk6BwxZYIiNJawHq3u4F6xLlttg==
=AMFq
-----END PGP SIGNATURE-----

--iAAPjvzcPxYyW4TN--

