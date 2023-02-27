Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4B46A4368
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 14:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB0Nys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 08:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjB0Nyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596121DBA1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 05:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677506043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=XuInmkYo02OjAGLdcr/ZKCR1FQs4dMy6r5f/AbK03aM=;
        b=OWT/oxGb/hZ/dzfpdRQeXR5aetw7ePGuKK80lkSUlx6QbMqfOi7JoDWMwpgo8OKT+4BLt5
        0UyOWdgw//TThShNzPLdhEN6I7d0jAwziJSN/Mv0ksa6OnDzgybxkJaBgCIo/XwTL8EBEq
        mzc1AD3UhFMDwYQDN8gsFxADcexGziI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-eBO0a9uQPDKSZjbhjmqWsg-1; Mon, 27 Feb 2023 08:53:58 -0500
X-MC-Unique: eBO0a9uQPDKSZjbhjmqWsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2BF618E0044;
        Mon, 27 Feb 2023 13:53:57 +0000 (UTC)
Received: from localhost (unknown [10.39.193.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E18D2026D4B;
        Mon, 27 Feb 2023 13:53:56 +0000 (UTC)
Date:   Mon, 27 Feb 2023 08:53:55 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     slava@dubeyko.com
Cc:     linux-fsdevel@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
        luka.perkov@sartura.hr, bruno.banelli@sartura.hr
Subject: Re: [RFC PATCH 00/76] SSDFS: flash-friendly LFS file system for ZNS
 SSD
Message-ID: <Y/y182cYxNo3zJmb@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h58prB83eJZjLr88"
Content-Disposition: inline
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--h58prB83eJZjLr88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Benchmarking results show that SSDFS is capable:

Is there performance data showing IOPS?

These comparisions include file systems that don't support zoned devices
natively, maybe that's why IOPS comparisons cannot be made?

> (3) decrease the write amplification factor compared with:
>     1.3x - 116x (ext4),
>     14x - 42x (xfs),
>     6x - 9x (btrfs),
>     1.5x - 50x (f2fs),
>     1.2x - 20x (nilfs2);
> (4) prolong SSD lifetime compared with:

Is this measuring how many times blocks are erased? I guess this
measurement includes the background I/O from ssdfs migration and moving?

>     1.4x - 7.8x (ext4),
>     15x - 60x (xfs),
>     6x - 12x (btrfs),
>     1.5x - 7x (f2fs),
>     1x - 4.6x (nilfs2).

Thanks,
Stefan

--h58prB83eJZjLr88
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP8tfMACgkQnKSrs4Gr
c8jiTgf9FIyVv6HBOn4x+53iYhRlbDc/WWQkcg2if9cqucNdaFo/3xuFFRnCnPQs
wIk4272cO2lEzDCylxBhDouijeR/eTswmBdQn2fhKEHbfp/GehsN04feGP4/Ce3W
2o3k333jp10ZRA3h5OMKjeTyCbggjKdSRuzheRotKXDgr6D1JdpWRFG1FPgrSoEh
Pebj/E00lYTky/b61zCqGR/NHQZrd+wal299rNVULR+hxD6oKQfrWa1FXC9lleaT
Uyopu3HPaygTwF11rZ53DjDAsasagKVqDCVZh5mKiAbaHvcjcugO/dNM0GgR3lO8
Spo0ER82f0VUv85/2j408M/Qkt5F2A==
=Pivz
-----END PGP SIGNATURE-----

--h58prB83eJZjLr88--

