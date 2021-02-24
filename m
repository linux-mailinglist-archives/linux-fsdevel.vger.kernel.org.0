Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1C324794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 00:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhBXXmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 18:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBXXmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 18:42:36 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E3C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 15:41:55 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h4so2542140pgf.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 15:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=4UhgtQR/t587K6mVK4U2DYeO7naX+sDjiM4fag1OV18=;
        b=UCHNVl5Da3JFTBW8+pGqiZqF3bzDtSF0orUCgAF9eV9zayf5gmyBBjXm7SXmYSTtEI
         3c3O4Tr5RVylKRTVn+wVTUZoBik929n7RmjWjX4SktZvsC/hD9Ke4xXa7oxcepeGiO3l
         pgKvHtJeyEQnlw3PHFmYK/0TJeSEPEgEDzbdfD19ZFEoUx/B2CBceyxtZ/Q2uIMLYvoa
         7z5qu4PWPl+15sAcZVr4N+u6JPvTeTLULwvgdmFceP3dnqEdrGbtmnnJYmzOXqnGkP+d
         5ircMiHuexRa81L4k8zeBwxynxEZ975pptAZ9xLyC6IeA4ju+6DrHAm9GBQkkG2kcThT
         afxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=4UhgtQR/t587K6mVK4U2DYeO7naX+sDjiM4fag1OV18=;
        b=CH0BhSLRwKdpv6BHQ5kGbXCKAp0TiXei1lK2jco/1FkilnISPgmUO1nL7GPJu+ijhc
         54OZ4U49lw3dK24k+MFD6GQ1XgrnTVOqRuBXTNMVgyh+SQVrUNTmxcwdojoEZD7pwuT1
         UJmXMTMP0ECmmm60ib05NBOO9jMjhgKSsDUKKBZMDFE4HZ3nv/LkLlErpHxd+MP5QlyD
         QivG2gmN4Wm46vxLpUQZOjHZXPmt/a8KrHrxeccir77m7IcjTc8I5mgdBpkKxtDLneKQ
         Asi8njlT/7iWy+UJV2jO/WxWSAfrnuN1msKHlq8azFzyCeWsNnF9UJ3T1iIiHiLFo1tP
         sGHg==
X-Gm-Message-State: AOAM532Cmvby+9LuDUk04hgQj9HGqQbG+pTvrYYK+uWVQI19vmHFaN1N
        y2hRJCvCgTe8ngeh/Px1LfKgQw==
X-Google-Smtp-Source: ABdhPJyrbBHtNmE8F4ML4DgkDenKEBh2vSSfnpeT2tpY94wj1oiKECGzl+PbPmiO3Oed33HdgAqRFQ==
X-Received: by 2002:a62:2c85:0:b029:1ed:39f4:ca0f with SMTP id s127-20020a622c850000b02901ed39f4ca0fmr380980pfs.11.1614210115277;
        Wed, 24 Feb 2021 15:41:55 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h8sm3675214pfv.154.2021.02.24.15.41.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Feb 2021 15:41:54 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <DC74377C-DFFD-4E26-90AB-213577DB3081@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A23EAC69-E4AD-4741-A190-B2F252287FD8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] Better page cache error handling
Date:   Wed, 24 Feb 2021 16:41:26 -0700
In-Reply-To: <20210224134115.GP2858050@casper.infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
References: <20210205161142.GI308988@casper.infradead.org>
 <20210224123848.GA27695@quack2.suse.cz>
 <20210224134115.GP2858050@casper.infradead.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_A23EAC69-E4AD-4741-A190-B2F252287FD8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 24, 2021, at 6:41 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Wed, Feb 24, 2021 at 01:38:48PM +0100, Jan Kara wrote:
>>> We allocate a page and try to read it.  29 threads pile up waiting
>>> for the page lock in filemap_update_page().  The error returned by =
the
>>> original I/O is shared between all 29 waiters as well as being =
returned
>>> to the requesting thread.  The next request for index.html will send
>>> another I/O, and more waiters will pile up trying to get the page =
lock,
>>> but at no time will more than 30 threads be waiting for the I/O to =
fail.
>>=20
>> Interesting idea. It certainly improves current behavior. I just =
wonder
>> whether this isn't a partial solution to a problem and a full =
solution of
>> it would have to go in a different direction? I mean it just seems
>> wrong that each reader (let's assume they just won't overlap) has to =
retry
>> the failed IO and wait for the HW to figure out it's not going to =
work.
>> Shouldn't we cache the error state with the page? And I understand =
that we
>> then also have to deal with the problem how to invalidate the error =
state
>> when the block might eventually become readable (for stuff like =
temporary
>> IO failures). That would need some signalling from the driver to the =
page
>> cache, maybe in a form of some error recovery sequence counter or =
something
>> like that. For stuff like iSCSI, multipath, or NBD it could be doable =
I
>> believe...
>=20
> That felt like a larger change than I wanted to make.  I already have
> a few big projects on my plate!
>=20
> Also, it's not clear to me that the host can necessarily figure out =
when
> a device has fixed an error -- certainly for the three cases you list
> it can be done.  I think we'd want a timer to indicate that it's worth
> retrying instead of returning the error.
>=20
> Anyway, that seems like a lot of data to cram into a struct page.  So =
I
> think my proposal is still worth pursuing while waiting for someone to
> come up with a perfect solution.

Since you would know that the page is bad at this point (not uptodate,
does not contain valid data) you could potentially re-use some other
fields in struct page, or potentially store something in the page =
itself?
That would avoid bloating struct page with fields that are only rarely
needed.  Userspace shouldn't be able to read the page at that point if
it is not marked uptodate, but they could overwrite it, so you wouldn't
want to store any kind of complex data structure there, but you _could_
store a magic, an error value, and a timeout, that are only valid if
!uptodate (cleared if the page were totally overwritten by userspace).

Yes, it's nasty, but better than growing struct page, and better than
blocking userspace threads for tens of minutes when a block is bad.

Cheers, Andreas






--Apple-Mail=_A23EAC69-E4AD-4741-A190-B2F252287FD8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA25CYACgkQcqXauRfM
H+AAERAAj0OTDKFuMVf0UEx4aC5GMp8vcZnxg7PM1tYxaxK9IkCzbmIvx0Cg52lp
5QkaINbs7U16rCrNRY8gkpl9VbU5p8zEyAGfbnZqTjxz8n++vx0LvsOxMjIgzDDn
KdcgrpkMZ0oFiSXcBjoE4+kCroWA1pM7hACvDkgBAZQV3sWZANmqZCAeDLpWz1kK
q+6shGiG/w410YHh/y72g1X2e+/9oSZ7xjGHx2IxuHXh6XEPHu8h2Oy2TusPpJ7P
VEmuCRQ19eDJSUw57F03p8MdQ3kD3dhPXWquO3vv2rcCsG/CAwF54O7CWGTwdSWl
60Zutxxlgst3zZHdgnLcHquHC2yitRz8ejSc5u/PUYYK8HQJ8wGtoc87dUUJYFZg
vBzYrOIHlBmqgoQ0lUj3WMS+GvHtyeWYRybImQXZ0Q8NL10kBmtT7GdlWhWBAdy7
YEZczQUSnOuRpJenXKVOkCHzH+Asu8Hicc9QiAii6iAts/gFw/E88dGACyM5cGqN
jkc/5bjuhev2rbQgXTesFlXUb/fVDmKKKIV/mMjHWc7vx3xHbNoRPkXy2JhVA1Km
25iTbybhiZCdm+IqMVXmSOyrzeIrsWhgA/k4JBZ0LMVPmq5mu7+QzIMYzthkGxla
7CRd0zvTR1bNWlhpffPHu3kIUzdI+7QTAdNHJA7TqF22tbgod4k=
=H6NE
-----END PGP SIGNATURE-----

--Apple-Mail=_A23EAC69-E4AD-4741-A190-B2F252287FD8--
