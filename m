Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3802253C11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 05:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgH0DPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 23:15:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26435 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgH0DPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:15:53 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200827031550epoutp03cbd6ba7f35885619c4f613c661318342~vAZlJ2iUF1449214492epoutp03a
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 03:15:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200827031550epoutp03cbd6ba7f35885619c4f613c661318342~vAZlJ2iUF1449214492epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598498150;
        bh=GZ8Ba8ECy4RfPgNcJZjrCr0xOmy66RiGHAKlrAMPnb8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=N/FelhPIwo/fqn9z4g6SHJqtoJ3GZ+gLad6NiXZtiWxUJgaJd++dqReqOwGaiyaS7
         zXh3xIyJbFapjFDtqQnbcTPnaW8rSOV3zx5k9dTR2Ukb6/6LRae0979rV1uXJRsO0g
         fufMUoAEQW+Owe+w9NEKyf1No+039xAJF+Kr5vw8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200827031550epcas1p1c393aeadc3593b3e87b95f89eb133ec0~vAZkuqdHs1209312093epcas1p1w;
        Thu, 27 Aug 2020 03:15:50 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BcSY144qRzMqYkY; Thu, 27 Aug
        2020 03:15:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.95.28578.565274F5; Thu, 27 Aug 2020 12:15:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200827031549epcas1p30dce17a8b2e3db1fd99b1260863bc5a4~vAZj0-NTn2179521795epcas1p3a;
        Thu, 27 Aug 2020 03:15:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200827031549epsmtrp1546877ac1f5af5f2d66d5a3e9b6c8c8f~vAZj0YD7c1840018400epsmtrp1D;
        Thu, 27 Aug 2020 03:15:49 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-c8-5f472565652a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.D7.08382.565274F5; Thu, 27 Aug 2020 12:15:49 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200827031549epsmtip208b72bcba134430ad1dea8e483790678~vAZjqOk5_1371913719epsmtip2n;
        Thu, 27 Aug 2020 03:15:49 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826011830.14646-1-kohada.t2@gmail.com>
Subject: RE: [PATCH] exfat: fix pointer error checking
Date:   Thu, 27 Aug 2020 12:15:49 +0900
Message-ID: <011001d67c20$5cdc56b0$16950410$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHVVZ9sPe6nCxYyQFpEVfRu64wY6ALX1/06qTavbqA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmvm6qqnu8wcIz8hY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tl
        aGBgZApUmZCTcWO1Z8EVxoqFr8+xNjCuY+xi5OSQEDCRaGt7wtzFyMUhJLCDUeJ60192COcT
        o8TX0/PZIJxvjBJzf7ezw7Q86utghEjsZZS4N287VP9LRomll7+zgFSxCehK/Puznw3EFhHQ
        kzh58jrYKGaBRiaJ5Se+MIMkOAUsJa6cuww2VljATGLn3vWsIDaLgKrEidZjQCs4OHiBatbM
        ygMJ8woISpyc+QRsPrOAvMT2t3OYIS5SkPj5dBkrxC4riQtPJ7FB1IhIzO5sAztOQmAuh0TP
        zVYWiAYXiUk/3kPZwhKvjm+Bek1K4mV/GzvIXgmBaomP+6HmdzBKvPhuC2EbS9xcv4EVpIRZ
        QFNi/S59iLCixM7fcxkh1vJJvPvawwoxhVeio00IokRVou/SYSYIW1qiq/0D+wRGpVlIHpuF
        5LFZSB6YhbBsASPLKkax1ILi3PTUYsMCU+S43sQITqZaljsYp7/9oHeIkYmD8RCjBAezkgiv
        4EXneCHelMTKqtSi/Pii0pzU4kOMpsCQnsgsJZqcD0zneSXxhqZGxsbGFiZm5mamxkrivA9v
        KcQLCaQnlqRmp6YWpBbB9DFxcEo1MNUfPCshtbK2WrB9T/lD998bjsz9/vClpLafemjFi5u5
        ex+w3OEX/LI3VVKt7fKRSe+/5HyS/512WOuGTVCvGM/MaZXr4uY1BZ5+/qfr/8Mv24pXeS7i
        nbOLcavOmmMm7c+O/V58bh7HrkeRR3PkU/3/Lnplk63nuzmUacaGHA3dGeXK7e1n9Dmt7Z2u
        LtMttj+7lL2Hc/4qwyB/5jR+L9GH193tnRPaF/9gO9SY3H7scOGH3OqPz4T+zPir9WQmI9fu
        8tC97dHKUZfPdtst5zfKCXzlH6jz4rWl0cGJgi3sursKX/+O3bJQLPWYuVvikYmJynK+cWdf
        3dqz4d1FplJ1z5C1FR8fmmsnSq/5n6PEUpyRaKjFXFScCABl4GCsLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXjdV1T3e4OVtTosfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLLb8O8LqwO7xZc5xdo+2yf/YPZqPrWTz2DnrLrtH35ZV
        jB6fN8kFsEVx2aSk5mSWpRbp2yVwZdxY7VlwhbFi4etzrA2M6xi7GDk5JARMJB71dYDZQgK7
        GSUaLilAxKUljp04w9zFyAFkC0scPlzcxcgFVPKcUWL/kznsIDVsAroS//7sZwOxRQT0JE6e
        vM4GUsQs0Mwk8e3ZEmaIji5GiU+f5oJ1cApYSlw5dxnMFhYwk9i5dz0riM0ioCpxovUYI8g2
        XqCaNbPyQMK8AoISJ2c+YQEJMwMtaNsIdiezgLzE9rdzmCHuVJD4+XQZK8QNVhIXnk5ig6gR
        kZjd2cY8gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3
        MYIjSktzB+P2VR/0DjEycTAeYpTgYFYS4RW86BwvxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdG
        4cI4IYH0xJLU7NTUgtQimCwTB6dUAxNP1btrH4R0hOKdstgltV6py03tXl560alZbsOdtIrs
        q93xKY1PXxmzrIzWalsjdNB9frizo9rj9Vv3GbxTjmFZpuww+cupPnlDbZX+2N1x3+f/dWXc
        dt/J4Fttza4XnHn+zyb+iaoTl037WzK98/S3oiYF6+fqIuK3ouZNK8qtnH+40X1dSEHwpru5
        Kdsjn0U4WAobZ/sJZXd8C2DJaDB6M2fFmtaNHkqb+l2ZWFRyyzRDL7iEvA5LPhbeYrV16RXm
        z2si3yjYCwWp171eVWARed1ywuOed7uEY7mPbFT+wxq+Ze9Cw8VmofdXJVru0vnR4MDgtG5u
        e7f62WO8Sh55VxYUluRn8zE/eSKrxFKckWioxVxUnAgANUJ+RhcDAAA=
X-CMS-MailID: 20200827031549epcas1p30dce17a8b2e3db1fd99b1260863bc5a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200826011839epcas1p497990de9fdc044d0cad134c8f7bfd0f5
References: <CGME20200826011839epcas1p497990de9fdc044d0cad134c8f7bfd0f5@epcas1p4.samsung.com>
        <20200826011830.14646-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Fix missing result check of exfat_build_inode().
> And use PTR_ERR_OR_ZERO instead of PTR_ERR.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
Pushed it to exfat #dev.
Thanks for your patch!

