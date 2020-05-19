Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17691D9B24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgESP2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 11:28:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:57507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgESP2a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 11:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589902096;
        bh=CiwR7YvzvIouXQnYC3GA/5qmrQBH6HehUBkJ0yz4hD8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NS5Al6HFrtMsGkGhQWBAUuuSXCgxFl2irosTvyJLdjxyHRf5YhuTNEKIVbYz4yD+4
         pFA+ZkJ1FeqRBzPQ4Wo0kAIiHbxMqRsRWgcOCEzJhuzKGT++P/o5t8ma5AhhnRA0of
         1UTKLiNfW+v58I1caXKgvi5g7I0AyjC8uI7ByZws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([120.242.72.127]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MlNp7-1jDW3X3fXZ-00lqV5; Tue, 19 May 2020 17:28:15 +0200
Date:   Tue, 19 May 2020 23:27:49 +0800
From:   Gao Xiang <hsiangkao@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
Message-ID: <20200519152747.GA11416@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
 <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
 <20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200519151632.GX16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519151632.GX16070@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:0Nr+HQn3nAxRsOJtI4q5EwM86pQQgQZG7KEm9Tq2RencbftXqf+
 C6bC3GYN3AiraPEzGjdJ0pYEjP3UWyuRgHlAC2jU33dpEp/veJnf+e/AXuwA8tV3kNJUViw
 TY4kuIyCOGF+YggGZSBiV0Bjr8mzTPf6fuU8MTvP+sMoBszhGcJblv3cN1Iz+tF7Pcrmx0Z
 oHvd8MimZ124aTrWikk/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDJwCMbauy4=:HXts9pvt4bos19ExLobmwi
 /nonUctgUL/hcYIy8ldyGmnoK0kR4FIE4LMLfMGgBYTYQp1951G4beFUbzUC0UA9ua5hNLx7Y
 a2Gb6AJ4mCNt+eHg0WmEXkhkBWxIrlYShrXWaeD+J3lTWhChDdoOG6EjwuAGG9bIZ7BhsaLlZ
 HibXv4UffXqVFYPNW7s96pkU4cF6mw2ghPG/tV4eMdCwvkUqoKPQfp0uboxiPG5xxAkHbFoWR
 6poYWRAm2h7b6OSOv5kNpmnniR09/rOKwL3oTl8frdHuOjyUnYD9KPaKyIP+VXGAxR7i8oH4u
 BWSTC6vyeMUTjE8Avu5gyi5PbFLepD9SfgVLlKvKnxXAOlCXhB2RIoPnzeySCe5kLapuCaNI4
 E9j6k7VRYpBSyqb3h1cDldvmTHQz2M071t/vB6FPVsUz9MF80xv/4vq9NGiZQy3gGb51lzYeR
 YF05QEoiA+CXJ4Uu/MmXxYE2pt7YuLlvlK6nG56ljtl9d/tVrJ1vuvcYdUir3SbofMy3vie62
 QTcH1eqks6Z43zuZ5JC4eKC9Hmzpkt5hD0+dXYza4x1OqF+ztAjdCUquCN6ZZOcWQ/4roJsFB
 MT3MOlZd1qW7tkaEkwh+DcP3tAMAEEk8wWR7g/UkzxBJg1g5ja9h2csFU7dpnQRQtBF4om4NI
 MZOVsGfUIs2qrZg606qlDiiyy9GWbZMZdzU0kbNoVufvG3DUwrenJouYZbm66qujfBnl30xsh
 onQkSYxfOv2xCGBK4+8V6NLBpQ9NsPuZyRGB3NvldHN+Mrs3L7mzajD0NsGloSeBU/A5zBTDp
 GtE84qOcpBRgjlF+8RzSWx/izmZCC+aszl0c/tCmwJvj/pyrXGk18SVu7Dbnic8CP7z9TOoiS
 lEoEF+s+tPih4AX0ClsofN26HHIaQxU9UdbybgczZrTnLQVYKleHnm9/HrfPJzVMNdRl+vIhN
 D2X/kDxEl7Dhr2gxmSHm1UcsAC1Tiuh2ltiYwm0zdrPtINmSyIl8+3CihAWGx9MVMulCvdEYK
 GiZ+OT0zh2acQk2gIN2Xqy2TpLfX6aaxgue/jyU56GC9t/ecXG6lehxasFnLqovl8SkdJPpF6
 1QqRYnxCYe6v2TYj+/1j9aRN3LuhMvr2YeD0W0pJZSB8KW33qcIUSUAvUxa77UrNLi5NPftUb
 CQvPbqEO4z8p+XDXR6nUevRk4zjHgUKFLvyVG5VCAX1Vyzlo7q3yKhHEJUDWWUShbZlYHtlbl
 cSnCzEVeZSRLGnG5d
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Tue, May 19, 2020 at 08:16:32AM -0700, Matthew Wilcox wrote:
> On Tue, May 19, 2020 at 06:06:19PM +0800, Gao Xiang wrote:
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
> It's fine to use page private like this without incrementing the refcoun=
t,
> and I can't find any problematic cases in EROFS like those fixed by comm=
it
> 8e47a457321ca1a74ad194ab5dcbca764bc70731
>
> So I think the new helpers are not for you, and that's fine.  They'll be
> useful for other filesystems which are using page_private differently
> from the way that you do.

Yes, I agree. Although there are some dead code in EROFS to handle
some truncated case, which I'd like to use in the future. Maybe I
can get rid of it temporarily... But let me get LZMA fixed-sized
output compression for EROFS in shape at first, which seems useful
as a complement of LZ4...

Thanks,
Gao Xiang

