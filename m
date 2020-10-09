Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA89288BEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbgJIO55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:57:57 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:44916 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388811AbgJIO55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:57:57 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 363F2820AC;
        Fri,  9 Oct 2020 17:57:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1602255474;
        bh=QxnLJ1s0AAVUtv6Yg0GXUFXfxq0lduuog+0DpMGrZ7A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=j9qF+kM/8+kd2mdoxtJlBVxjBCS/ndOR1Q19eyUpXohy8uSf7oJzKgryJ+zyxXMlK
         8sctQWqUsMB2/HgS09WlV17/JFdMeyJ1vjd/5AhYTEDgBMcnnUejTvCS3PKmPm9dmT
         kwX+/B3fWHALqwxdyqpqV7voG10IBo7TvxFKA4/Q=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 9 Oct 2020 17:57:53 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 9 Oct 2020 17:57:53 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Joe Perches <joe@perches.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        linux-ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>
Subject: RE: [PATCH v7 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Thread-Topic: [PATCH v7 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Thread-Index: AQHWk1Sa2wLqUS628U6j9N8+RWiOE6l5ZhEAgBYJkOA=
Date:   Fri, 9 Oct 2020 14:57:53 +0000
Message-ID: <2fa19fb9767948ca920bead9e2e65f91@paragon-software.com>
References: <20200925155537.1030046-1-almaz.alexandrovich@paragon-software.com>
 <670bc2f60983d9d08c697031ea5a59937f5ed489.camel@perches.com>
In-Reply-To: <670bc2f60983d9d08c697031ea5a59937f5ed489.camel@perches.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Sent: Friday, September 25, 2020 8:16 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; linux-=
fsdevel@vger.kernel.org; Anton Altaparmakov
> <anton@tuxera.com>
> Cc: viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; pali@kernel.or=
g; dsterba@suse.cz; aaptel@suse.com;
> willy@infradead.org; rdunlap@infradead.org; mark@harmstone.com; nborisov@=
suse.com; linux-ntfs-dev <linux-ntfs-
> dev@lists.sourceforge.net>
> Subject: Re: [PATCH v7 00/10] NTFS read-write driver GPL implementation b=
y Paragon Software
>=20
> (adding cc's to Anton Altaparmakov and linux-ntfs-dev)
>=20
> On Fri, 2020-09-25 at 18:55 +0300, Konstantin Komarov wrote:
> > This patch adds NTFS Read-Write driver to fs/ntfs3.
>=20
> This code should eventually supplant the existing NTFS
> implementation right?
>=20
> Unless there is some specific reason you have not done so,
> I believe you should cc the current NTFS maintainer and
> NTFS mailing list on all these patches in the future.
>=20
> MAINTAINERS-NTFS FILESYSTEM
> MAINTAINERS-M:  Anton Altaparmakov <anton@tuxera.com>
> MAINTAINERS-L:  linux-ntfs-dev@lists.sourceforge.net
>=20
> Link to the v7 patches:
> https://lore.kernel.org/lkml/20200925155537.1030046-1-almaz.alexandrovich=
@paragon-software.com/
>=20

Hi Joe. Thanks a lot! Added both Anton and linux-ntfs-dev to the v8 cc list=
.
Hi Anton. Did you have a chance to look at NTFS3 code?

Thanks.
