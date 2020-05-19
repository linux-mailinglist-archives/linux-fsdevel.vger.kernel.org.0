Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7A1D940E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgESKH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 06:07:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:40815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgESKH3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 06:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589882788;
        bh=+UZpikoCSDiNYkpOkgtAFZkoPVCVL9V39mTTHmo5RnU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OYCe8E2lNau8mXcdkFBTDa50UmWb6PEPnr2owHjqOlS8BZw2UzeFUJ8r3WH2NFKhf
         cnw+PkUf3dkRcuehv4sW29J+qtObVlQHUCcJqSbsZCuXZnjX2+V4GVyauaRG6Sq6w1
         nI+vmAar6fAwMLZLTh6+MM6oZj4Z+sx9M79Xbt8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([120.242.72.127]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MbzyJ-1j46lY1mO7-00dZSO; Tue, 19 May 2020 12:06:28 +0200
Date:   Tue, 19 May 2020 18:06:19 +0800
From:   Gao Xiang <hsiangkao@gmx.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
Message-ID: <20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
 <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8\""
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:LTsOTq1mPEelHR2l4o0rGDmComg0jxTf99Vkf8suxa+YY03ofnM
 kUeZeFjDAmpCwnFsBHf3kmSRCIsSEbcvK3Ap6q8pTGMp30JZpDNca/GF/ADZnxTUAVU6TNB
 oJaMiBZlDOe98Kdbx1vhprmzieIrq5i0li7tskswUcm7v+bwi32+8/Z66AMvAY+nE1yW+xV
 BrCzgrlUqli1rAVIZ+5Xw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jXscTq9KYn4=:W3BMIpbm0zHl72sFflO65j
 x3PEswh9uw6Mx9ZTLhyx0/qJsa5wkWWIzmP5mR96adqo6J4j7TS5ZM5W5h/lyusKgxrjADCZu
 XsYqp8+7yNRa/pG+fnERjolHIxLrkBt0ZAtKz+XCylXUtUruO7IIJtxTsj3NC3CXygy7NBtCL
 Crk5tzj7/CGhKHOLKdNKQrHywokGmCiPK4XcN++izNCPfDo5kY9KHPUvv5pV05Dd7+9nrfKak
 LEWCdTp669qgGzcIeO8dRMvTWqduTTfoI3p6xJ4XRa8yH8GsdGWh6RL2YhRxX1kEz8UZnXcCh
 2/fvGFn5SDUNuzI/AlHO0pVr9HJLMH9QCgedJEy25TZenkiwgP4n+qep3fJAlWDL620aYvOGV
 A7sv9XTy8EF6uJ0Y1JE+dKjrUFcXykWe/H2m5Zd8OvQlE6m3y//sOTOP7M8aMpqPc0lOQ/1Rf
 Y43bpwHXdCSaPIHAm/nmarEtXVPQliJc3eY46D6GDE06o7jURQsnqZBEW34SDHCJBBuUFXxcG
 ovm0R0qp3EVBx2TqD2/HCoFStimBw8NWyhfRHTyrmKGL9FVOif6D0Ei+6VXi1cjwNZEHcKjSz
 c35AAaEkig+lD6+hHF3Wi5toHrwzDveIbVHJtahwSVuxnAbHx31lGnRQaoMtimIJRS0RrKosp
 dI5oLhd6lqYefYC/3/+uL3h2iYvlfimWS6KGwDX0PAqqRN7Zdnnn3i8witGQJjMlmYvSwrkNQ
 PQBtoqlv1gObbNMnIDEJxDhsyeuq6vO1U6jEBavLVWJpGEH6RJ3L8MUoUYkODimPE0xNq/Za0
 d+MSPFBf+6e5j/vaDaYqKn6Nvc7LThgMdpMjUmEXnX9MHXcY9D4przCLI8ExMxpEoBpKOGx4w
 okdjuqz/Kh0UJYykiwSewoZuCq6bzrsmxcYY6Q/X314pFLjt746UGRIS55mPKUXXbyISoH1ZA
 5glTm2d9braOFn4gmuWo8JV4XUfpZwBaxW2Eg4Qc9eksLHObgggnbsFwUk32rBniSjKEBViFP
 goRI594CZDZzOkPWlZHdtOaCEPMS/upEwOp1RE04Jv80ZQw5CyapzsuFyK0rnbmtkYm0Hr14A
 /ZGuCnkHfPuWjaN1Bmpq5Ksevq2BGPcP/5RuX0jdSBK5aQM2kTCi+sUlSkEES817LUWRJEUlM
 mg5giDlq8JnUHQ9G197JDZCLZ+YzBhJrnUCGEjyUbLG8QMadWiIdXpEN7Eym2waT6GsmnOBge
 O7npqi7ha43LyhfsQ
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 09:35:59AM +0200, Guoqing Jiang wrote:
> On 5/19/20 7:12 AM, Andrew Morton wrote:
> > On Sun, 17 May 2020 23:47:18 +0200 Guoqing Jiang <guoqing.jiang@cloud.=
ionos.com> wrote:
> >
> > > We can cleanup code a little by call detach_page_private here.
> > >
> > > ...
> > >
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct address=
_space *mapping,
> > >   	if (rc !=3D MIGRATEPAGE_SUCCESS)
> > >   		goto unlock_buffers;
> > > -	ClearPagePrivate(page);
> > > -	set_page_private(newpage, page_private(page));
> > > -	set_page_private(page, 0);
> > > -	put_page(page);
> > > +	set_page_private(newpage, detach_page_private(page));
> > >   	get_page(newpage);
> > >   	bh =3D head;
> > mm/migrate.c: In function '__buffer_migrate_page':
> > ./include/linux/mm_types.h:243:52: warning: assignment makes integer f=
rom pointer without a cast [-Wint-conversion]
> >   #define set_page_private(page, v) ((page)->private =3D (v))
> >                                                      ^
> > mm/migrate.c:800:2: note: in expansion of macro 'set_page_private'
> >    set_page_private(newpage, detach_page_private(page));
> >    ^~~~~~~~~~~~~~~~
> >
> > The fact that set_page_private(detach_page_private()) generates a type
> > mismatch warning seems deeply wrong, surely.
> >
> > Please let's get the types sorted out - either unsigned long or void *=
,
> > not half-one and half-the other.  Whatever needs the least typecasting
> > at callsites, I suggest.
>
> Sorry about that, I should notice the warning before. I will double chec=
k if
> other
> places need the typecast or not, then send a new version.
>
> > And can we please implement set_page_private() and page_private() with
> > inlined C code?  There is no need for these to be macros.
>
> Just did a quick change.
>
> -#define page_private(page)=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=
=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  ((page)->private)
> -#define set_page_private(page, v)=C3=82 =C3=82 =C3=82 =C3=82 =C3=82  ((=
page)->private =3D (v))
> +static inline unsigned long page_private(struct page *page)
> +{
> +=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  return page->private;
> +}
> +
> +static inline void set_page_private(struct page *page, unsigned long
> priv_data)
> +{
> +=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  page->private =3D priv_data;
> +}
>
> Then I get error like.
>
> fs/erofs/zdata.h: In function =C3=A2=E2=82=AC=CB=9Cz_erofs_onlinepage_in=
dex=C3=A2=E2=82=AC=E2=84=A2:
> fs/erofs/zdata.h:126:8: error: lvalue required as unary =C3=A2=E2=82=AC=
=CB=9C&=C3=A2=E2=82=AC=E2=84=A2 operand
> =C3=82  u.v =3D &page_private(page);
> =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  ^
>
> I guess it is better to keep page_private as macro, please correct me in
> case I
> missed something.

I guess that you could Cc me in the reply.

In that case, EROFS uses page->private as an atomic integer to
trace 2 partial subpages in one page.

I think that you could also use &page->private instead directly to
replace &page_private(page) here since I didn't find some hint to
pick &page_private(page) or &page->private.


In addition, I found some limitation of new {attach,detach}_page_private
helper (that is why I was interested in this series at that time [1] [2],
but I gave up finally) since many patterns (not all) in EROFS are

io_submit (origin, page locked):
attach_page_private(page);
...
put_page(page);

end_io (page locked):
SetPageUptodate(page);
unlock_page(page);

since the page is always locked, so io_submit could be simplified as
set_page_private(page, ...);
SetPagePrivate(page);
, which can save both one temporary get_page(page) and one
put_page(page) since it could be regarded as safe with page locked.


btw, I noticed the patchset versions are PATCH [3], RFC PATCH [4],
RFC PATCH v2 [5], RFC PATCH v3 [6], PATCH [7]. Although I also
noticed the patchset title was once changed, but it could be some
harder to trace the whole history discussion.

[1] https://lore.kernel.org/linux-fsdevel/20200419051404.GA30986@hsiangkao=
-HP-ZHAN-66-Pro-G1/
[2] https://lore.kernel.org/linux-fsdevel/20200427025752.GA3979@hsiangkao-=
HP-ZHAN-66-Pro-G1/
[3] https://lore.kernel.org/linux-fsdevel/20200418225123.31850-1-guoqing.j=
iang@cloud.ionos.com/
[4] https://lore.kernel.org/linux-fsdevel/20200426214925.10970-1-guoqing.j=
iang@cloud.ionos.com/
[5] https://lore.kernel.org/linux-fsdevel/20200430214450.10662-1-guoqing.j=
iang@cloud.ionos.com/
[6] https://lore.kernel.org/linux-fsdevel/20200507214400.15785-1-guoqing.j=
iang@cloud.ionos.com/
[7] https://lore.kernel.org/linux-fsdevel/20200517214718.468-1-guoqing.jia=
ng@cloud.ionos.com/

Thanks,
Gao Xiang

>
> Thanks,
> Guoqing
>
>
>
