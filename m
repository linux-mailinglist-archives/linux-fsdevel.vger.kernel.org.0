Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839EF2A0A72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgJ3PyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:54:24 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:55814 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbgJ3PyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:54:23 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id DCC2A821E1;
        Fri, 30 Oct 2020 18:54:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1604073259;
        bh=syPIYL65kzdSI9QtlC1kkmn71u9ZYAZkCYUkgaozJR0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=CYotYB9f5yhJUVk3re1IZ5/cHgQOFkf/NWjQh6GkFrDl2D+BC3PdllRfbU5yfAUIa
         TbpyTNfnzfDlNnr9HU9F0V1cRRKlkmTPM2Cl2gxcsSCrEnqO8Mer8XUregPd7hUlwW
         5+PNO56HiSIMHexxCC+GjcgY6TzHv5//DVbzs5A4=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 30 Oct 2020 18:54:19 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 30 Oct 2020 18:54:19 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>
Subject: RE: [PATCH v10 02/10] fs/ntfs3: Add initialization of super block
Thread-Topic: [PATCH v10 02/10] fs/ntfs3: Add initialization of super block
Thread-Index: AQHWqVNpqBsn1Djmw0u2qExWV5sKkamlTrSAgAsIPMA=
Date:   Fri, 30 Oct 2020 15:54:19 +0000
Message-ID: <afb07a383dc747398f65ac541206b562@paragon-software.com>
References: <20201023154431.1853715-1-almaz.alexandrovich@paragon-software.com>
 <20201023154431.1853715-3-almaz.alexandrovich@paragon-software.com>
 <20201023182503.GE20115@casper.infradead.org>
In-Reply-To: <20201023182503.GE20115@casper.infradead.org>
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

From: Matthew Wilcox <willy@infradead.org>
Sent: Friday, October 23, 2020 9:25 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; rdunlap@infradead.org; joe@perches.com; mark@harmstone.c=
om; nborisov@suse.com; linux-ntfs-
> dev@lists.sourceforge.net; anton@tuxera.com
> Subject: Re: [PATCH v10 02/10] fs/ntfs3: Add initialization of super bloc=
k
>=20
> On Fri, Oct 23, 2020 at 06:44:23PM +0300, Konstantin Komarov wrote:
> > +
> > +/*ntfs_readpage*/
> > +/*ntfs_readpages*/
> > +/*ntfs_writepage*/
> > +/*ntfs_writepages*/
> > +/*ntfs_block_truncate_page*/
>=20
> What are these for?
>=20
> > +int ntfs_readpage(struct file *file, struct page *page)
> > +{
> > +	int err;
> > +	struct address_space *mapping =3D page->mapping;
> > +	struct inode *inode =3D mapping->host;
> > +	struct ntfs_inode *ni =3D ntfs_i(inode);
> > +	u64 vbo =3D (u64)page->index << PAGE_SHIFT;
> > +	u64 valid;
> > +	struct ATTRIB *attr;
> > +	const char *data;
> > +	u32 data_size;
> > +
> [...]
> > +
> > +	if (is_compressed(ni)) {
> > +		if (PageUptodate(page)) {
> > +			unlock_page(page);
> > +			return 0;
> > +		}
>=20
> You can skip this -- the readpage op won't be called for pages which
> are Uptodate.
>=20
> > +	/* normal + sparse files */
> > +	err =3D mpage_readpage(page, ntfs_get_block);
> > +	if (err)
> > +		goto out;
>=20
> It would be nice to use iomap instead of mpage, but that's a big ask.
>=20
> > +	valid =3D ni->i_valid;
> > +	if (vbo < valid && valid < vbo + PAGE_SIZE) {
> > +		if (PageLocked(page))
> > +			wait_on_page_bit(page, PG_locked);
> > +		if (PageError(page)) {
> > +			ntfs_inode_warn(inode, "file garbage at 0x%llx", valid);
> > +			goto out;
> > +		}
> > +		zero_user_segment(page, valid & (PAGE_SIZE - 1), PAGE_SIZE);
>=20
> Nono, you can't zero data after the page has been unlocked.  You can
> handle this case in ntfs_get_block().  If the block is entirely beyond
> i_size, returning a hole will cause mpage_readpage() to zero it.  If it
> straddles i_size, you can either ensure that the on-media block contains
> zeroes after the EOF, or if you can't depend on that, you can read it
> in synchronously in your get_block() and then zero the tail and set the
> buffer Uptodate.  Not the most appetising solution, but what you have her=
e
> is racy with the user writing to it after reading.

Hello Matthew! Thanks a lot for this feedback. Fixed in v11, please check o=
ut.

Cheers!
