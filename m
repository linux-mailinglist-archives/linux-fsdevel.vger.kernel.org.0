Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA711BA7D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 17:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgD0PWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 11:22:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727104AbgD0PWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588000956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1VlYjyrp5z9iYzGcVVSIIdloZupfYhtxaO9PDFUePI=;
        b=fFVO423O7aohdETVAvx3NhGJkdHhQyPJKjnKQAYpsYDsdhSi/OpShhqMKXy/Ld/3y0j4Dj
        JxyNV/WikAgXnYxoT91fWR4LJlik1g6fThJSq/NQANiFjHSUqbgEy51chhSbMsaxbyiWm5
        aXmIh092Zedc8Q3T2LpnrUMaA6dQnqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-xw-SsyXPN9yQfQBNkdnocw-1; Mon, 27 Apr 2020 11:22:31 -0400
X-MC-Unique: xw-SsyXPN9yQfQBNkdnocw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D72F81EF81;
        Mon, 27 Apr 2020 15:22:30 +0000 (UTC)
Received: from localhost (ovpn-114-226.ams2.redhat.com [10.36.114.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1A6C5D716;
        Mon, 27 Apr 2020 15:22:23 +0000 (UTC)
Date:   Mon, 27 Apr 2020 16:22:22 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>, slp@redhat.com
Subject: Re: [PATCH 2/2] fuse: virtiofs: Add basic multiqueue support
Message-ID: <20200427152222.GA1043329@stefanha-x1.localdomain>
References: <20200424062540.23679-1-chirantan@chromium.org>
 <20200424062540.23679-2-chirantan@chromium.org>
 <20200427151934.GB1042399@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200427151934.GB1042399@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2020 at 04:19:34PM +0100, Stefan Hajnoczi wrote:
> On Fri, Apr 24, 2020 at 03:25:40PM +0900, Chirantan Ekbote wrote:
> The C implementation of virtiofsd has request parallelism and there is
> work underway to do it in Rust for cloud-hypervisor too.  Perhaps you
> can try the cloud-hypervisor code, I have CCed Sergio Lopez?

Sergio pointed me to this commit:

https://github.com/cloud-hypervisor/cloud-hypervisor/commit/710520e9a1860c587b4b3ec6aadc466ba1709557

Stefan

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6m+K4ACgkQnKSrs4Gr
c8jQ1Qf/bspMKGE/YgytaeWeBS8mI63yrhYNllexXvVZv7z0CKNbdO4wkt3RsbgB
/Wf5Mir12k7uPduMvC0H94m72oWX7fpd+ABJL0NMarfLtni8fPMqz1RYGGiIrsvU
tfLicwx6dvVxNSoscYaV96OhWqhBdUnLQzl47KzcZkLpYqT8H7qjyxfVll2wWs7i
QPMZtp+1FkBM2did+wOSajypYDc1UqcVbzK8ncbCofyZqyjRPo03Gk8c2isrTM9g
Vjskh4XJAIupD3Sa80rlGbRJ27dGyecuqpnVYyyYlGPnwNymJhwPlWEk3gcYVoAz
ibEGDUlZN11R5T+zin9BXR6nZZPl6w==
=DS17
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

