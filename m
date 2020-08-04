Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA1523B246
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 03:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgHDB23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 21:28:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38007 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDB22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:28:28 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200804012824epoutp01678e43cb435accc2cc508471cfb256ab~n7GNRyXxD1490214902epoutp01V
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 01:28:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200804012824epoutp01678e43cb435accc2cc508471cfb256ab~n7GNRyXxD1490214902epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596504504;
        bh=a64K75HOXp/fNxG3qbBUDcNDX7qI+cBFEOavzZ7OjDU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=RFGnL2IdpglHTaVT4GqSJy6rVJEltEcKQ54yvXrhsTy6KYZuDR6hqdVjyLplIKfKF
         V00Zk9u9bDbTQH84O0O+2rX58tivXGHWoyI3dN76cOFdc3Zv3V5idqHvJNCVXH28DJ
         hxSSD+8rxTtjGJws5T1DLgdayW6sIebjeKjp7K/4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200804012823epcas1p1b7c625dc7073e40369c78716c3c3c563~n7GM7OojI2591825918epcas1p1k;
        Tue,  4 Aug 2020 01:28:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BLHFf6RzkzMqYky; Tue,  4 Aug
        2020 01:28:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.FE.18978.6B9B82F5; Tue,  4 Aug 2020 10:28:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200804012822epcas1p47b75d17e03ac8db6d2307d9c9d48c435~n7GLlpAj71017010170epcas1p40;
        Tue,  4 Aug 2020 01:28:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200804012822epsmtrp2fb59f415905f7ef19332dfb7482d6b76~n7GLlBKGO0631306313epsmtrp2-;
        Tue,  4 Aug 2020 01:28:22 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-ee-5f28b9b6ae84
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.C4.08382.6B9B82F5; Tue,  4 Aug 2020 10:28:22 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200804012822epsmtip1d3ed32a068799467c49fa91390a711e9~n7GLWrWu32568025680epsmtip1b;
        Tue,  4 Aug 2020 01:28:22 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <TY2PR01MB287579A95A7994DE2B34E425904D0@TY2PR01MB2875.jpnprd01.prod.outlook.com>
Subject: RE: [PATCH v2] exfat: integrates dir-entry getting and validation
Date:   Tue, 4 Aug 2020 10:28:22 +0900
Message-ID: <001c01d669fe$8ab7cf80$a0276e80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJkKvf3lVanaAlN2afWcUIlbNXqzwJnQ0rYAkopOF4BRzP236fb23SA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTX3fbTo14g+YNJhZvTk5lsdiz9ySL
        xeVdc9gsLv//xGKx7MtkFost/46wOrB5fJlznN2jbfI/do/mYyvZPPq2rGL0+LxJLoA1Kscm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsb1
        FaYFP/Qq1l4/x97AuE6li5GTQ0LARGJZ92LmLkYuDiGBHYwSD463sUA4nxglDvX9Z4dwvjFK
        9M2fygTTsvfYIzBbSGAvo8TEHm6IopeMEnP/XGAHSbAJ6Er8+7OfrYuRg0NEwEji6clCkDCz
        wHlGicYJ/iA2p0CsxLTFa1lAbGEBL4kl0zaBzWQRUJH4sHIuC0grr4ClxJILYCW8AoISJ2c+
        YYEYIy+x/e0cZohzFCR+Pl3GCmKLCLhJ3Np6gwmiRkRidmcb2GcSAlM5JDo6P7ODzJQQcJG4
        ftcUoldY4tXxLewQtpTE53d72SBKqiU+7oca38Eo8eK7LYRtLHFz/QZWkBJmAU2J9bv0IcKK
        Ejt/z2WE2Mon8e5rDyvEFF6JjjYhiBJVib5Lh6HhJy3R1f6BfQKj0iwkf81C8tcsJPfPQli2
        gJFlFaNYakFxbnpqsWGBIXI8b2IEJ0wt0x2ME99+0DvEyMTBeIhRgoNZSYT342f1eCHelMTK
        qtSi/Pii0pzU4kOMpsCAnsgsJZqcD0zZeSXxhqZGxsbGFiZm5mamxkrivA9vKcQLCaQnlqRm
        p6YWpBbB9DFxcEo1MB2ebnyjWCrZ7KXZnml2d41jTuy1q4r6bHJrz607UYZ+lmeDJEpfMVRK
        pvzuvnvkib3HznC2R3pNNi8Xnuvun8bS2jZXLrWmjauz+vmdRp379xrO12y5r/KNz/q75tKA
        g9Na1ywWdb676VEmR+v/KtGNHBG/vDwan6ztmHvU3+Zs84QLis5/1fcoXGa8yzXPaPuEr68c
        XRdsKLHWjD1urbqu8F3WW+uFXkHBl3jMlr4MvX8/eNLvvrCCx9uyjvNrJ/BXG8856HU/2U9o
        ovN8H1fxszcvTeAqdfx38dpkjxcaVR0Sjj8+fejLMlnK4MpVdC8i35CntntCUGLcks3ceqJF
        P57a7rH+9KR+2ZMFF5RYijMSDbWYi4oTAXU+cUghBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnO62nRrxBn8fCFi8OTmVxWLP3pMs
        Fpd3zWGzuPz/E4vFsi+TWSy2/DvC6sDm8WXOcXaPtsn/2D2aj61k8+jbsorR4/MmuQDWKC6b
        lNSczLLUIn27BK6M6ytMC37oVay9fo69gXGdShcjJ4eEgInE3mOPmLoYuTiEBHYzSvRM/cMC
        kZCWOHbiDHMXIweQLSxx+HAxRM1zRonXP44yg9SwCehK/Puznw2kRkTASOLpyUKQGmaBi4wS
        /xfuYYZo6GSSOLLzGiNIA6dArMS0xWvBFggLeEksmbaJCcRmEVCR+LByLgvIIF4BS4klF8BK
        eAUEJU7OfAJmMwtoS/Q+bGWEsOUltr+dwwxxp4LEz6fLWEFsEQE3iVtbbzBB1IhIzO5sY57A
        KDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNIS3MH
        4/ZVH/QOMTJxMB5ilOBgVhLh/fhZPV6INyWxsiq1KD++qDQntfgQozQHi5I4743ChXFCAumJ
        JanZqakFqUUwWSYOTqkGJs04rxt3733SYbNq5DgUofFFsC/kT2jXDq/+S2urXhkKcBZ8kfP9
        +jH2Z9Je3bmWbs+nz0ooqdFLypiysurV1WkLF2/qKuDREvl/u7pukveERgan5oUX7r7721jD
        YqfO7mm7xpH5i0iR2QubBR0a1ZWV/EX2czbvsZOvO6BU+OXrrlg+nT3T+H46RcfqFG53//lh
        o0LBrc31ppfddpxv97c87+7F+v33mbo2B+lSh8WVay9xVUekHthYbfFsWZlC211Zv+SeihvV
        W2at+vfjXVqvy7orl+NdLNZp6FzKiT/5oHVS3vtTS8QnKCls6zi+Zqe+QNSXdX0H0os9L0Yc
        DMy0nuq7Pm3haTY/jYkqSizFGYmGWsxFxYkAN+F5wQ8DAAA=
X-CMS-MailID: 20200804012822epcas1p47b75d17e03ac8db6d2307d9c9d48c435
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200715012304epcas1p23e9f45415afc551beea122e4e1bdb933
References: <CGME20200715012304epcas1p23e9f45415afc551beea122e4e1bdb933@epcas1p2.samsung.com>
        <20200715012249.16378-1-kohada.t2@gmail.com>
        <015d01d6663e$1eb8c780$5c2a5680$@samsung.com>
        <TY2PR01MB287579A95A7994DE2B34E425904D0@TY2PR01MB2875.jpnprd01.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thank you for your reply.
> 
> > > diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> > > 573659bfbc55..09b85746e760 100644
> > > --- a/fs/exfat/dir.c
> > > +++ b/fs/exfat/dir.c
> > > @@ -33,6 +33,7 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,  {
> > >  	int i;
> > >  	struct exfat_entry_set_cache *es;
> > > +	struct exfat_dentry *ep;
> > >
> > >  	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
> > >  	if (!es)
> > > @@ -44,13 +45,9 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
> > >  	 * Third entry  : first file-name entry
> > >  	 * So, the index of first file-name dentry should start from 2.
> > >  	 */
> > > -	for (i = 2; i < es->num_entries; i++) {
> > > -		struct exfat_dentry *ep = exfat_get_dentry_cached(es, i);
> > > -
> > > -		/* end of name entry */
> > > -		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
> > > -			break;
> > >
> > > +	i = 2;
> > > +	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
> > As Sungjong said, I think that TYPE_NAME seems right to be validated in exfat_get_dentry_set().
> 
> First, it is possible to correctly determine that "Immediately follow the Stream Extension directory
> entry as a consecutive series"
> whether the TYPE_NAME check is implemented here or exfat_get_dentry_set().
> It's functionally same, so it is also right to validate in either.
> 
> Second, the current implementation does not care for NameLength field, as I replied to Sungjong.
> If name is not terminated with zero, the name will be incorrect.(With or without my patch) I think
> TYPE_NAME and NameLength validation should not be separated from the name extraction.
> If validate TYPE_NAME in exfat_get_dentry_set(), NameLength validation and name extraction should also
> be implemented there.
> (Otherwise, a duplication check with exfat_get_dentry_set() and here.) I will add NameLength
> validation here.
Okay.
> Therefore, TYPE_NAME validation here should not be omitted.
> 
> Third, getting dentry and entry-type validation should be integrated.
> These no longer have to be primitive.
> The integration simplifies caller error checking.
> 
> 
> > > -struct exfat_dentry *exfat_get_dentry_cached(
> > > -	struct exfat_entry_set_cache *es, int num)
> > > +struct exfat_dentry *exfat_get_validated_dentry(struct exfat_entry_set_cache *es,
> > > +						int num, unsigned int type)
> > Please use two tabs.
> 
> OK.
> I'll fix it.
> 
> 
> > > +	struct buffer_head *bh;
> > > +	struct exfat_dentry *ep;
> > >
> > > -	return (struct exfat_dentry *)p;
> > > +	if (num >= es->num_entries)
> > > +		return NULL;
> > > +
> > > +	bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
> > > +	if (!bh)
> > > +		return NULL;
> > > +
> > > +	ep = (struct exfat_dentry *)
> > > +		(bh->b_data + EXFAT_BLK_OFFSET(off, es->sb));
> > > +
> > > +	switch (type) {
> > > +	case TYPE_ALL: /* accept any */
> > > +		break;
> > > +	case TYPE_FILE:
> > > +		if (ep->type != EXFAT_FILE)
> > > +			return NULL;
> > > +		break;
> > > +	case TYPE_SECONDARY:
> > > +		if (!(type & exfat_get_entry_type(ep)))
> > > +			return NULL;
> > > +		break;
> > Type check should be in this order :
> > FILE->STREAM->NAME->{CRITICAL_SEC|BENIGN_SEC}
> > I think that you are missing TYPE_NAME check here.
> 
> Types other than the above (TYPE_NAME, TYPE_STREAM, etc.) are checked in the default-case(as below).
> 
> > > +	default:
> > > +		if (type != exfat_get_entry_type(ep))
> > > +			return NULL;
> > > +	}
> > > +	return ep;
> > >  }
> > >
> > >  /*
> > >   * Returns a set of dentries for a file or dir.
> > >   *
> > > - * Note It provides a direct pointer to bh->data via exfat_get_dentry_cached().
> > > + * Note It provides a direct pointer to bh->data via exfat_get_validated_dentry().
> > >   * User should call exfat_get_dentry_set() after setting 'modified' to apply
> > >   * changes made in this entry set to the real device.
> > >   *
> > >   * in:
> > >   *   sb+p_dir+entry: indicates a file/dir
> > > - *   type:  specifies how many dentries should be included.
> > > + *   max_entries:  specifies how many dentries should be included.
> > >   * return:
> > >   *   pointer of entry set on success,
> > >   *   NULL on failure.
> > > + * note:
> > > + *   On success, guarantee the correct 'file' and 'stream-ext' dir-entries.
> > This comment seems unnecessary.
> 
> I'll remove it.
> 
> > > diff --git a/fs/exfat/file.c b/fs/exfat/file.c index
> > > 6707f3eb09b5..b6b458e6f5e3 100644
> > > --- a/fs/exfat/file.c
> > > +++ b/fs/exfat/file.c
> > > @@ -160,8 +160,8 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
> > >  				ES_ALL_ENTRIES);
> > >  		if (!es)
> > >  			return -EIO;
> > > -		ep = exfat_get_dentry_cached(es, 0);
> > > -		ep2 = exfat_get_dentry_cached(es, 1);
> > > +		ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
> > > +		ep2 = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
> > TYPE_FILE and TYPE_STREAM was already validated in exfat_get_dentry_set().
> > Isn't it unnecessary duplication check ?
> 
> No, as you say.
> Although TYPE is specified, it is not good not to check the null of ep/ep2.
> However, with TYPE_ALL, it becomes difficult to understand what purpose ep/ep2 is used for.
> Therefore, I proposed adding ep_file/ep_stream to es, and here
> 	ep = es->ep_file;
> 	ep2 = es->ep_stream;
> 
> How about this?
You can factor out exfat_get_dentry_cached() from exfat_get_validated_dentry() and use it here.
And then, You can rename ep and ep2 to ep_file and ep_stream.
> Or is it better to specify TYPE_ALL?
> 
> 
> BTW
> It's been about a month since I posted this patch.
> In the meantime, I created a NameLength check and a checksum validation based on this patch.
> Can you review those as well?
Let me see the patches.

Thanks!
> 
> BR
> ---
> Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>

