Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D603E4989
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhHIQRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 12:17:01 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:43718 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232707AbhHIQRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:17:00 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 377AA8204F;
        Mon,  9 Aug 2021 19:16:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1628525793;
        bh=hV8BuQ4XGeVeEzQJ9C3R5KKb0YJVQwXbWV5mttl1z2s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=OERvHu/Co4Ip6GwS5PcB9LI8PkAj68oAnuc6PpSekkvqoJ7J6TYgBoJupWYwRbPs+
         2EsbNTtZrdcdMB33hw1YfrUpIe7YfsN0XHxzZP3FcPs9JX3YgRNxYWs24uUV7l7a6I
         3goVLSgIM5jeXhezAjQ7ivNSDlWz9SA+Yu64ypxg=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 19:16:32 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.2176.009; Mon, 9 Aug 2021 19:16:32 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "kari.argillander@gmail.com" <kari.argillander@gmail.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: RE: [PATCH v27 10/10] fs/ntfs3: Add MAINTAINERS
Thread-Topic: [PATCH v27 10/10] fs/ntfs3: Add MAINTAINERS
Thread-Index: AQHXhICc1pQ/IBT4qUef2OyFKHPZBatq3zkAgACJiZA=
Date:   Mon, 9 Aug 2021 16:16:32 +0000
Message-ID: <918ff89414fa49f8bcb2dfd00a7b0f0b@paragon-software.com>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-11-almaz.alexandrovich@paragon-software.com>
 <20210809105652.GK5047@twin.jikos.cz>
In-Reply-To: <20210809105652.GK5047@twin.jikos.cz>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: David Sterba <dsterba@suse.cz>
> Sent: Monday, August 9, 2021 1:57 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.=
com; mark@harmstone.com; nborisov@suse.com;
> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@ora=
cle.com; hch@lst.de; ebiggers@kernel.org;
> andy.lavr@gmail.com; kari.argillander@gmail.com; oleksandr@natalenko.name
> Subject: Re: [PATCH v27 10/10] fs/ntfs3: Add MAINTAINERS
>=20
> On Thu, Jul 29, 2021 at 04:49:43PM +0300, Konstantin Komarov wrote:
> > This adds MAINTAINERS
> >
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software=
.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9c3428380..3b6b48537 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13279,6 +13279,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kern=
el/git/aia21/ntfs.git
> >  F:	Documentation/filesystems/ntfs.rst
> >  F:	fs/ntfs/
> >
> > +NTFS3 FILESYSTEM
> > +M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > +S:	Supported
> > +W:	http://www.paragon-software.com/
> > +F:	Documentation/filesystems/ntfs3.rst
> > +F:	fs/ntfs3/
>=20
> Can you please add a git tree and mailing list entries?
Hi David, I'll add the git tree link for the sources to MAINTAINERS in the =
next patch. As for the mailing list,
apologies for the newbie question here, but will it possible to have the @v=
ger.kernel.org list for the ntfs3,
or it must be external for our case?
Thanks!
