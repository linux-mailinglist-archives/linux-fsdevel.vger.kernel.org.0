Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61D63AD1BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhFRSFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 14:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234782AbhFRSFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624039415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQAGTbIKTlX+eSDKtwFxg8eJEsQ646RlIwkzsIfqLBM=;
        b=YwFMLOMtzLnhAXjTQQ7iOfZlhEFHHQL1mI4KBwa8Mg/EE8Ext/OQtx+frhE0FnE1yC6Say
        7tDDIElds2I+00S5ZVdiNbdYFurxvGiJY9LOiEozU/BwIJ6sHk+lEr1qp8Ed6fGQ38akFA
        qmK7eA+onWpPfl6hAacflukAHjo3I/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-PJiakoOuMgyLdP39Wx6lAQ-1; Fri, 18 Jun 2021 14:03:33 -0400
X-MC-Unique: PJiakoOuMgyLdP39Wx6lAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E811804145;
        Fri, 18 Jun 2021 18:03:32 +0000 (UTC)
Received: from localhost (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA1CA19710;
        Fri, 18 Jun 2021 18:03:28 +0000 (UTC)
Date:   Fri, 18 Jun 2021 19:03:27 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] support booting of arbitrary non-blockdevice file
 systems
Message-ID: <YMzf72yCJqnDTYYo@stefanha-x1.localdomain>
References: <20210617153649.1886693-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BJ2t6DUwu2C54aee"
Content-Disposition: inline
In-Reply-To: <20210617153649.1886693-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--BJ2t6DUwu2C54aee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 17, 2021 at 05:36:47PM +0200, Christoph Hellwig wrote:
> this series adds support to boot off arbitrary non-blockdevice root file
> systems, based off an earlier patch from Vivek.

Cool, thanks for working on generic syntax for mounting non-blockdevice
file systems. Looks good modulo the comments Vivek had.

Stefan

--BJ2t6DUwu2C54aee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDM3+8ACgkQnKSrs4Gr
c8iYRQf7BnTsXpltlcUc1ZB0ZEVw8116KM4IDmMLTrZI2+DB6dQUUDoVFGhDQ8Js
8H+kO2B6gCyRK1kem+d6JF0B9YkWkGmot4c0LljqJs55aAmRRFNFqga3fuGu7/h8
amS/Hm+QKgmCLIj+U/+nLkUqbxI/vSdmGMLOVgHC05Qw6m/3IRlJlXKjss2jOIzP
NhaVbWL1WIaDjpgLFFZunGqNQ0jLN7o3SRUhtiJPwZ/9xXJcGem9X7/cFZQ12/Nd
qP1ATC/vjVnwIZoHFjgn4O0wk3bv8zUMBLZqnnT9PYC5IbAW9oX8LWEine+T58X0
yQNil38SKTfuWw2ZIRdiX2W7CfuZ3w==
=zBxt
-----END PGP SIGNATURE-----

--BJ2t6DUwu2C54aee--

