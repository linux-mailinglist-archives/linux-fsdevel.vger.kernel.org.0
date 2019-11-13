Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06162FB2B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 15:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKMOkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 09:40:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21675 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbfKMOkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573656012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSHrFQsbaC1yAitK7Law8cbj6Z2ZKZzmHqlB5M3qljE=;
        b=CVRobaX/zg1fEGwJX5b9dR4DiYfTAwblF8YyXa0zxsw3TXDDx6d6b7pun6GJfBCYstgCm+
        qLOTFc5eDUUdSe20ZcIjlNdqh1DI3oCcjLGlqi10NQ75o0zqd50uZWlBHi2OjYtQ3yDFj+
        gCuvdHJoGG0Fn5S8LvLnnqOa1xr11NY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-yOlrfIIcMb-iBtVC6B25Hg-1; Wed, 13 Nov 2019 09:40:08 -0500
X-MC-Unique: yOlrfIIcMb-iBtVC6B25Hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C76C8EDBC1;
        Wed, 13 Nov 2019 14:40:07 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBE4860C88;
        Wed, 13 Nov 2019 14:40:03 +0000 (UTC)
Date:   Wed, 13 Nov 2019 14:40:02 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, virtualization@lists.linux-foundation.org,
        miklos@szeredi.hu, dgilbert@redhat.com
Subject: Re: [PATCH 3/3] virtiofs: Use completions while waiting for queue to
 be drained
Message-ID: <20191113144002.GB554680@stefanha-x1.localdomain>
References: <20191030150719.29048-1-vgoyal@redhat.com>
 <20191030150719.29048-4-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191030150719.29048-4-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 11:07:19AM -0400, Vivek Goyal wrote:
> While we wait for queue to finish draining, use completions instead of
> uslee_range(). This is better way of waiting for event.

s/uslee_range()/usleep_range()/

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MFcIACgkQnKSrs4Gr
c8iVMQgAlnZ9d6GvnmORD+LRCvqgvHMMUlFoZS9nF/QBnEG7N4Pqr8BPRJw7Gi0D
uBdcZjReMZY2fG9ZNXoMA0ivvPUPa3eDEBeuXlQrp8Qw4yx32ciL9VYvKly8vvV2
2SMpOnsiuxDhldW2norjAP2piC7VCt+ni8x0yMTECQbaIfvrMhAxR/be/NWOj3pa
RIFzuyeB4yqi73m0yRXtuN4AwL8Fzq/R0NFAfZDlGSiDmhWJ+xIJpPiL4ZfwVBaK
hwzVPIkrA6TmDNNLtI7aCmVrQiA8lpnMH5FbKLmobmXjhedf4PwtiUEMSa3ESC6Y
lBzMsJ4gnruQmDefdEdC1G7ohBHzSg==
=47Ie
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--

