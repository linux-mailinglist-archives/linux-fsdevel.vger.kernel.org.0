Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9756B254A45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgH0QMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:12:52 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:47510 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbgH0QMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:12:50 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 29D6B821F8;
        Thu, 27 Aug 2020 19:12:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598544766;
        bh=b0m2YScacBRU4oQW0bpcg+OTA+e/Nm/yF/uS+thlVMI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=laGqsRGlmisNFsw4WpemS9WZFNsY6NuUVUMv2tuJ8GAGj9B26Mu+2IxQBlIuqZCYu
         w6Pz83IGUlZeTkTsZxRleBxgi1BSx8XDS1fpvsWYjNZ2GR0cdqDed8F8VCBh8ga3cJ
         rggDc0cQEz897TpsZZP8EmyvW3alaR+8IwJKTa4I=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 27 Aug 2020 19:12:45 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 27 Aug 2020 19:12:45 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Joe Perches <joe@perches.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: RE: [PATCH v2 00/10] fs: NTFS read-write driver GPL implementation by
 Paragon Software.
Thread-Topic: [PATCH v2 00/10] fs: NTFS read-write driver GPL implementation
 by Paragon Software.
Thread-Index: AdZ30n3KUTPgxpZ7Q/+ZtR0YneODPwABJfsAAS00XHA=
Date:   Thu, 27 Aug 2020 16:12:45 +0000
Message-ID: <8dc38559e18f43238e5b4cba533963cd@paragon-software.com>
References: <904d985365a34f0787a4511435417ab3@paragon-software.com>
 <ed518871bf6182bb7d9a2b95074985cf8af1d5c4.camel@perches.com>
In-Reply-To: <ed518871bf6182bb7d9a2b95074985cf8af1d5c4.camel@perches.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Sent: Friday, August 21, 2020 10:21 PM
>=20
> On Fri, 2020-08-21 at 16:24 +0000, Konstantin Komarov wrote:
> > This patch adds NTFS Read-Write driver to fs/ntfs3.
>=20
> Thanks.
> Proper ntfs read/write support will be great addition.
>=20
> Trivia:
>=20
> If this patchset is submitted again with a new version,
> please use something like "git format-patch --cover-letter"
> and "git send-email" so all parts of the patches and replies
> have the a single message thread to follow.
>=20
> That will add an "in-reply-to" header of the 0/m patch
> message-id to all n/m parts.
>=20

Hi Joe! Thanks a lot. Will use git send-email for V3. format-patch and --co=
ver-letter have been already used for v2.

> One style oddity I noticed is the use of goto labels in
> favor of if block indentation.  It's not terrible style,
> just unusual for kernel code.
>=20

AFAIK goto's are being quite widely used in kernel code as well. However V3=
 will introduce several goto's replacements with if blocks.

Thanks!
