Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F81FC90E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgFQIld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 04:41:33 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:33312 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgFQIlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:41:32 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200617084129epoutp01b1dbecfe19e232cf9a67ba9983b7c381~ZSCpVte9w2459724597epoutp01v
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 08:41:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200617084129epoutp01b1dbecfe19e232cf9a67ba9983b7c381~ZSCpVte9w2459724597epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592383289;
        bh=gh6W5yGrV5Q3pLGykvDTaDSZ77Dm0FvSvxUgpDFLAOQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=u6m/KG+5gmaxmqW9rpT01E7bltegiiqSEvOOLleifSKTukau5JDPzTAuECUcQFWHj
         Qrzqxe8MnEcchYHWwQmBsUA8egdqSUYDGUUIq030vfDcLsfn6kEErBTZfvA8wCIGsa
         TKAnOjc9q1/kSwOv4CE809wJ7ve+bS1mAowjlLNU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200617084129epcas1p4bddc803e422c6a63a2ad977ce81f2a41~ZSCpE71MB3009130091epcas1p4F;
        Wed, 17 Jun 2020 08:41:29 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49mz7W2ck3zMqYkp; Wed, 17 Jun
        2020 08:41:27 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.50.28581.737D9EE5; Wed, 17 Jun 2020 17:41:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200617084126epcas1p40e74869e9d0aa50ccc3ca7285712ceb2~ZSCmiTcgH2746027460epcas1p4P;
        Wed, 17 Jun 2020 08:41:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200617084126epsmtrp27819972cf5f2d905d187fda3f6080885~ZSCmhXFf41225612256epsmtrp2b;
        Wed, 17 Jun 2020 08:41:26 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-c4-5ee9d7377685
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.33.08303.637D9EE5; Wed, 17 Jun 2020 17:41:26 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200617084126epsmtip225bb24d6730469f22c009e9cb1d6c5c7~ZSCmXu9_M1775117751epsmtip2m;
        Wed, 17 Jun 2020 08:41:26 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <414101d64477$ccb661f0$662325d0$@samsung.com>
Subject: RE: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
Date:   Wed, 17 Jun 2020 17:41:26 +0900
Message-ID: <001f01d64483$16ce1f20$446a5d60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF0BoMPlscPSpT3Th8lCwQKqdMbhQJGtMGMAcFEUC2pgLlC4A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmvq759ZdxBteOCVr8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7tF8bCWbx85Zd9k9+ras
        YvT4vEkugC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxsutD1gLpnNW/P/9gqmBcQt7FyMHh4SAicS1t25djJwcQgI7GCVaXkpD2J8Y
        JT7OyOhi5AKyPzNK3F+/iw0kAVLfvH4JC0RiF6NEw/dNrBDOS0aJWS8bwarYBHQl/v3ZD2aL
        CERLHNtxnhGkiFngCqPEg0ezmEASnAJWEm2LHrGBnCEsYCmx8LoySJhFQFViwoStLCA2L1D4
        2/dOdghbUOLkzCdgcWYBeYntb+cwQ1ykIPHz6TJWiF1OEi9mP2GGqBGRmN3ZxgyyV0JgLofE
        5Qt7oF5wkfh1+g8ThC0s8er4FnYIW0ri87u9bJBgqZb4uB9qfgejxIvvthC2scTN9RtYQUqY
        BTQl1u/ShwgrSuz8PZcRYi2fxLuvPawQU3glOtqEIEpUJfouHYZaKi3R1f6BfQKj0iwkj81C
        8tgsJA/MQli2gJFlFaNYakFxbnpqsWGBCXJMb2IEJ1Itix2Mc99+0DvEyMTBeIhRgoNZSYTX
        +feLOCHelMTKqtSi/Pii0pzU4kOMpsCgnsgsJZqcD0zleSXxhqZGxsbGFiZm5mamxkrivCet
        LsQJCaQnlqRmp6YWpBbB9DFxcEo1MBk6zPt1Q9l4/1veUH6e2zE+T++e2Lx8QUCA+dNa1msz
        hBQ3T9i03X5z14H1peUJUX29H1582nA2JTJzVtbE+9rslotLzLMfbT1WUlzUE87O9f7Sok83
        xDJnSi5m5Gb7ErLv76u/S4TkF0gdVpBKF7/O/ec3k9SVGZkn3yp9OvN2S9x9/h2THx7ojl+5
        7fbf7QKR0o7BCmGB15LEZhuklpq/r5ugONPw5WT/suYHQvs5EtNZDH3dIvoZf4bbXzd6OUFQ
        9/zcTU9j/OZanDNT631zeB3PokDn6y+LmKsPbheI+zvxwUE3y/erZUtEnuxTuq8bF+THr/Lh
        /oa63z1/U3aZTp3caKkefb3Hfo3A989KLMUZiYZazEXFiQB3tWnRLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXtfs+ss4gx8txhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgyni59QFrwXTOiv+/XzA1MG5h72Lk5JAQMJFoXr+EpYuR
        i0NIYAejRGf/V6iEtMSxE2eYuxg5gGxhicOHiyFqnjNKHD+5jRmkhk1AV+Lfn/1sILaIQLTE
        1b9/WUBsZoFrjBLfp2dDNGxnlHgx8yRYA6eAlUTbokdsIEOFBSwlFl5XBgmzCKhKTJiwFayX
        Fyj87XsnO4QtKHFy5hOomdoSvQ9bGSFseYntb+cwQ9ypIPHz6TJWiBucJF7MfsIMUSMiMbuz
        jXkCo/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4r
        La0djHtWfdA7xMjEwXiIUYKDWUmE1/n3izgh3pTEyqrUovz4otKc1OJDjNIcLErivF9nLYwT
        EkhPLEnNTk0tSC2CyTJxcEo1MPUs7/k/r/fH/smR6yaWr3v6J/7JJ6vzxY+/Pqq6s2dPPuOt
        uiy3KLVG8ftiecezLnhE52UFvVfTPvj1X+fsDPW7U/4UrWqJ+PdP5XCbiOqPdyJ2+RF+GlrG
        kp+nCs+bOmVN/YZJlrH1kY2zFDbfyTEucJV6O8E0rvFu8/V1mivXyK/v/Hh96oe2Jdp9vT8T
        DK5WXw0++PXEpwV8JxnN1HTKq4QXmu/8eSzP7NOShc7p6/Uctm+f/t6iK53FT2XVBV5joRWJ
        jitqvti3PGbwsVZ9fn/p9WWS0zy/pHrvOZAQ32RVcnvRQzNH46WNk74eauJUcDC2OBw0dRXD
        7LMqW3bPSereLmP388QH1tV981uUWIozEg21mIuKEwFo64rBGgMAAA==
X-CMS-MailID: 20200617084126epcas1p40e74869e9d0aa50ccc3ca7285712ceb2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
        <20200616021808.5222-1-kohada.t2@gmail.com>
        <414101d64477$ccb661f0$662325d0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > remove EXFAT_SB_DIRTY flag and related codes.
> >
> > This flag is set/reset in exfat_put_super()/exfat_sync_fs() to avoid
> > sync_blockdev().
> > However ...
> > - exfat_put_super():
> > Before calling this, the VFS has already called sync_filesystem(), so
> > sync is never performed here.
> > - exfat_sync_fs():
> > After calling this, the VFS calls sync_blockdev(), so, it is
> > meaningless to check EXFAT_SB_DIRTY or to bypass sync_blockdev() here.
> > Not only that, but in some cases can't clear VOL_DIRTY.
> > ex:
> > VOL_DIRTY is set when rmdir starts, but when non-empty-dir is
> > detected, return error without setting EXFAT_SB_DIRTY.
> > If performe 'sync' in this state, VOL_DIRTY will not be cleared.
> >
> 
> Since this patch does not resolve 'VOL_DIRTY in ENOTEMPTY' problem you mentioned, it would be better
> to remove the description above for that and to make new patch.
> 
> > Remove the EXFAT_SB_DIRTY check to ensure synchronization.
> > And, remove the code related to the flag.
> >
> > Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied. Thanks!

