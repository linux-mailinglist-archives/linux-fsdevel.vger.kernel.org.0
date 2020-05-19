Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD271D9554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgESLcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 07:32:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:33459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgESLcR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 07:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589887906;
        bh=hRMRg6Lv78ncJMoeyZ4EITlOg2oYw3JEq0mqTDbNMN0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=e0/LXciTA0OGKQP+NXxfdYrnVtGQZLitHfAAPvlux+Kpw+XG3ac7qp9kW6pzG70rf
         zrmlxWAt1VN8CTKsR59aQKGJr2MEjkHuh55eUSr71ELhnWT9dGWd1k/u3E3/YDVHGK
         iCCX2W+GHVm2Z1dXGsqYZfjG5800Mx8AHwEclNMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([120.242.72.127]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MGyxN-1jnQfg1CbL-00E4r0; Tue, 19 May 2020 13:31:46 +0200
Date:   Tue, 19 May 2020 19:31:23 +0800
From:   Gao Xiang <hsiangkao@gmx.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
Message-ID: <20200519113121.GA3219@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
 <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
 <20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1>
 <d731fde0-6503-42f5-67b3-a4359a06bbb6@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8\""
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d731fde0-6503-42f5-67b3-a4359a06bbb6@cloud.ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:FbLyrywyenvDxq6aIQbvrqL266P53NxiYLxeyZACWnmIzm8nZPt
 YyPIDtFdvRVedmBz/rBU1icTOCWjP4TWUrWBbeY4qFiiaRk+h14+FQ4kB7FAtTe2Tq7v2M/
 b7Hd24vdWC38b0+j9dWSiF10Wsftozl3U+oWHP3fzeJk5zvtoIJ9SJsu3ZV3GakMzIrunWt
 mMMQ+8s8uVyxalD9Aeo+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GVmOb+nbDr8=:EQfG8ykcXCFGI3SZwhLY0N
 q+JzUeqWKUH0UUM7KMGPvuB0J+E5QISiP4unYHUWpUo777ugDggB/HM7+/hAy2IKFbL7+U0H+
 WZvD2V6aZji2bVZQQspsYxmSEoMdAkcH3AF8KMQb3G7YbDEnVMqUNNe5B5aP8CkbqzItiyS1o
 oR4UokFDe5ZwpMMvm3dBVMbGlf/k6jp49PDMQ2vHuclP1E6Fib1wIpfUZh5myWVvKhU284teF
 RUqqOtUdee40v1H7ZPg9BPmwxrI9STLj8Zjpc8ZYHccLQrFwymeJMzWBHQxiof3KCcpA56XZj
 3TKKBLjss1Q1pBatHLLLbEN2gf0BnCH4teVCvO9TTE17o6fpcKiiEs4OAsNlEeNK+vxo1YyP/
 h1GqgIVxJrgoggPlUTayK+F9Qj1IlKiZ6IujtllM/ia48mF0D3pj1n7jc/lwLJB79ka+2RK+C
 o6eJo/9dsBdS/xV0ZOwTBCe3MclXC0wePGDD3f1d5IlGEpYxZcXYkQXvd/hQg7Mf/aCA3FugA
 kKTzFi4njtcp24KD4Cj3JKiRxC9UYFPtvOcrmAS+YGgMow/EBDNKP1NUAh8g2IoZN+DdEvp7P
 VhKXr42vCatwfeRkfgH5cwAlE4kac4WX7m7FWkIbPFvHEhJa0tsKB4d6ZOQGcjl9W/Cx9++tH
 GI8jfgHcVkS6CUmyrMkAU7WOdH9U8gTOunR7YX7PmJSu/4dSQ2IzxOpMYSDW6DGjnuf0c8sp6
 YUCekVj1O6mF+93euAPtJhKUZVwVtU6G+5b8QIZaNP3bsrWRYmW1ZAnlHCrAfMr/RfMIrJkyb
 05OcAicdFfVrbwx4ROK9AJkP86YWJ2+hoHvlhMNAkN5gD9kYthY3oAuDjdowciGozKvrTrtOM
 D4/lk9eIr4NZ8EsOLZE0j58010wEBWiGrOBhgjcwWDMzZh0O3kg7hOVMhPZ0QUzvlzzySm8h8
 D1TLhhGIyi0ga+JksYt5PemSs7xK37x9nYWor7E9shadfLEoNiicO4z+M2o9mtfBQU8pMp8HJ
 fD+2yai09TLbCmfh7OkcFV2dnZ4AEjGOOfKHq5rJzChTT8Rp3HDpCJDmdnqjAiyGMUHj/wyeV
 yE/jO7Ai4PadFFVHHfSRnoSveoO5rZdRCiHKHMORhyCi6+rfIclWV0EsPFBMM2VlCsUohRsTW
 cbsw4csGIlCuQCZvnvbGvJyf+eLG4VgV+S9pye+C+w1JdSa8D4PR4U4tfCe4kVmpypIcQkz8L
 E7EZKnT0VTSOx7VFv
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 01:02:26PM +0200, Guoqing Jiang wrote:
> On 5/19/20 12:06 PM, Gao Xiang wrote:
> > On Tue, May 19, 2020 at 09:35:59AM +0200, Guoqing Jiang wrote:
> > > On 5/19/20 7:12 AM, Andrew Morton wrote:
> > > > On Sun, 17 May 2020 23:47:18 +0200 Guoqing Jiang <guoqing.jiang@cl=
oud.ionos.com> wrote:
> > > >
> > > > > We can cleanup code a little by call detach_page_private here.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/mm/migrate.c
> > > > > +++ b/mm/migrate.c
> > > > > @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct add=
ress_space *mapping,
> > > > >    	if (rc !=3D MIGRATEPAGE_SUCCESS)
> > > > >    		goto unlock_buffers;
> > > > > -	ClearPagePrivate(page);
> > > > > -	set_page_private(newpage, page_private(page));
> > > > > -	set_page_private(page, 0);
> > > > > -	put_page(page);
> > > > > +	set_page_private(newpage, detach_page_private(page));
> > > > >    	get_page(newpage);
> > > > >    	bh =3D head;
> > > > mm/migrate.c: In function '__buffer_migrate_page':
> > > > ./include/linux/mm_types.h:243:52: warning: assignment makes integ=
er from pointer without a cast [-Wint-conversion]
> > > >    #define set_page_private(page, v) ((page)->private =3D (v))
> > > >                                                       ^
> > > > mm/migrate.c:800:2: note: in expansion of macro 'set_page_private'
> > > >     set_page_private(newpage, detach_page_private(page));
> > > >     ^~~~~~~~~~~~~~~~
> > > >
> > > > The fact that set_page_private(detach_page_private()) generates a =
type
> > > > mismatch warning seems deeply wrong, surely.
> > > >
> > > > Please let's get the types sorted out - either unsigned long or vo=
id *,
> > > > not half-one and half-the other.  Whatever needs the least typecas=
ting
> > > > at callsites, I suggest.
> > > Sorry about that, I should notice the warning before. I will double =
check if
> > > other
> > > places need the typecast or not, then send a new version.
> > >
> > > > And can we please implement set_page_private() and page_private() =
with
> > > > inlined C code?  There is no need for these to be macros.
> > > Just did a quick change.
> > >
> > > -#define page_private(page)=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82=
 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  ((page)->private)
> > > -#define set_page_private(page, v)=C3=82 =C3=82 =C3=82 =C3=82 =C3=82=
  ((page)->private =3D (v))
> > > +static inline unsigned long page_private(struct page *page)
> > > +{
> > > +=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  return page->private;
> > > +}
> > > +
> > > +static inline void set_page_private(struct page *page, unsigned lon=
g
> > > priv_data)
> > > +{
> > > +=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  page->private =3D priv_d=
ata;
> > > +}
> > >
> > > Then I get error like.
> > >
> > > fs/erofs/zdata.h: In function =C3=A2=E2=82=AC=CB=9Cz_erofs_onlinepag=
e_index=C3=A2=E2=82=AC=E2=84=A2:
> > > fs/erofs/zdata.h:126:8: error: lvalue required as unary =C3=A2=E2=82=
=AC=CB=9C&=C3=A2=E2=82=AC=E2=84=A2 operand
> > > =C3=82  u.v =3D &page_private(page);
> > > =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  ^
> > >
> > > I guess it is better to keep page_private as macro, please correct m=
e in
> > > case I
> > > missed something.
> > I guess that you could Cc me in the reply.
>
> Sorry for not do that ...
>
> > In that case, EROFS uses page->private as an atomic integer to
> > trace 2 partial subpages in one page.
> >
> > I think that you could also use &page->private instead directly to
> > replace &page_private(page) here since I didn't find some hint to
> > pick &page_private(page) or &page->private.
>
> Thanks for the input, I just did a quick test, so need to investigate mo=
re.
> And I think it is better to have another thread to change those macros t=
o
> inline function, then fix related issues due to the change.

I have no problem with that. Actually I did some type punning,
but I'm not sure if it's in a proper way. I'm very happy to improve
that as well.

>
> > In addition, I found some limitation of new {attach,detach}_page_priva=
te
> > helper (that is why I was interested in this series at that time [1] [=
2],
> > but I gave up finally) since many patterns (not all) in EROFS are
> >
> > io_submit (origin, page locked):
> > attach_page_private(page);
> > ...
> > put_page(page);
> >
> > end_io (page locked):
> > SetPageUptodate(page);
> > unlock_page(page);
> >
> > since the page is always locked, so io_submit could be simplified as
> > set_page_private(page, ...);
> > SetPagePrivate(page);
> > , which can save both one temporary get_page(page) and one
> > put_page(page) since it could be regarded as safe with page locked.
>
> The SetPageUptodate is not called inside {attach,detach}_page_private,
> I could probably misunderstand your point, maybe you want the new pairs
> can handle the locked page, care to elaborate more?

It doesn't relate to SetPageUptodate.
I just want to say that some patterns might not be benefited.

These helpers are useful indeed.

>
> > btw, I noticed the patchset versions are PATCH [3], RFC PATCH [4],
> > RFC PATCH v2 [5], RFC PATCH v3 [6], PATCH [7]. Although I also
> > noticed the patchset title was once changed, but it could be some
> > harder to trace the whole history discussion.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20200419051404.GA30986@hsian=
gkao-HP-ZHAN-66-Pro-G1/
> > [2] https://lore.kernel.org/linux-fsdevel/20200427025752.GA3979@hsiang=
kao-HP-ZHAN-66-Pro-G1/
> > [3] https://lore.kernel.org/linux-fsdevel/20200418225123.31850-1-guoqi=
ng.jiang@cloud.ionos.com/
> > [4] https://lore.kernel.org/linux-fsdevel/20200426214925.10970-1-guoqi=
ng.jiang@cloud.ionos.com/
> > [5] https://lore.kernel.org/linux-fsdevel/20200430214450.10662-1-guoqi=
ng.jiang@cloud.ionos.com/
> > [6] https://lore.kernel.org/linux-fsdevel/20200507214400.15785-1-guoqi=
ng.jiang@cloud.ionos.com/
> > [7] https://lore.kernel.org/linux-fsdevel/20200517214718.468-1-guoqing=
.jiang@cloud.ionos.com/
>
> All the cover letter of those series are here.
>
> RFC V3:https://lore.kernel.org/lkml/20200507214400.15785-1-guoqing.jiang=
@cloud.ionos.com/
> RFC V2:https://lore.kernel.org/lkml/20200430214450.10662-1-guoqing.jiang=
@cloud.ionos.com/
> RFC:https://lore.kernel.org/lkml/20200426214925.10970-1-guoqing.jiang@cl=
oud.ionos.com/
>
> And the latest one:
>
> https://lore.kernel.org/lkml/20200430214450.10662-1-guoqing.jiang@cloud.=
ionos.com/

Yeah, I noticed these links in this cover letter as well.
I was just little confused about these version numbers, especially
when the original patchset "[PATCH 0/5] export __clear_page_buffers
to cleanup code" included. That is minor as well.

Thanks for the explanation.

Thanks,
Gao Xiang

>
>
> Thanks,
> Guoqing
