Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815AD1AD490
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 04:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgDQCjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 22:39:45 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18003 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgDQCjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:39:45 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200417023942epoutp02bc19f39f13c518f185de82dd3a46edd1~GewWcoyTw0231402314epoutp02V
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2020 02:39:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200417023942epoutp02bc19f39f13c518f185de82dd3a46edd1~GewWcoyTw0231402314epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587091182;
        bh=aCggvvISb3vjRmzdZ3XN/dTBA9tNd8xpqtSM2O/byS8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=FGKe/atoUSf1e5pDPFhdRXx5snb074CzT+xfZuSQFFAb0D0NBec5gR24HqNzWKK0q
         g0KeW3sQbqKcjHMoPJ0yamw1yECQO2eBtE1b5ioRPcOmckwe835Xorkx7RANC4WbmM
         93eiwNffZnHODc4srUEns1drjcLWBbhR6dWg1w8c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200417023941epcas1p3d9ea8a388e181f5b633b36ac8969647e~GewVwymrf0742907429epcas1p3V;
        Fri, 17 Apr 2020 02:39:41 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 493L0D5N6MzMqYkf; Fri, 17 Apr
        2020 02:39:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.4F.04648.CE6199E5; Fri, 17 Apr 2020 11:39:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200417023939epcas1p499c819249017442a881d82cf5e04241b~GewT32Cof1009010090epcas1p49;
        Fri, 17 Apr 2020 02:39:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200417023939epsmtrp128ed0c50efe08f2cdae8e009d7a5c600~GewT2n6ef2543625436epsmtrp1O;
        Fri, 17 Apr 2020 02:39:39 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-99-5e9916eca325
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.B2.04024.BE6199E5; Fri, 17 Apr 2020 11:39:39 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200417023939epsmtip2dfd10ce662583b4fff0517d2c8d264a7~GewTt6TAE1695216952epsmtip22;
        Fri, 17 Apr 2020 02:39:39 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416085121.57495-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Subject: RE: [PATCH v3] exfat: replace 'time_ms' with 'time_cs'
Date:   Fri, 17 Apr 2020 11:39:39 +0900
Message-ID: <003601d61461$7140be60$53c23b20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFivWokrSbtdWWlBCyBJ+5kie97TAJblN7TqVBpbUA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmvu4bsZlxBlvvqlu8OTmVxWLP3pMs
        Fpd3zWGzuPz/E4vFsi+TWSy2/DvC6sDm8WXOcXaPtsn/2D2aj61k8+jbsorR4/MmuQDWqByb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKALlBTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORkL
        l65hK9jIWnFr4UP2BsbdLF2MHBwSAiYSLUfEuxi5OIQEdjBKPNl7jgnC+cQoMbn7OwuE841R
        4sj3HYwwHR2tThDxvYwSM/YdYe5i5ARyXjJKbJkSCGKzCehK/Puznw3EFhFwl1hz7iczSAOz
        wHlGiQkT/oE1cAoESVx/fYAFxBYWsJdYef88K4jNIqAqsfvDeyYQm1fAUuLau29sELagxMmZ
        T8DqmQXkJba/nQM2R0JAQeLn02WsIMeJCFhJvGrzhygRkZjd2Qa2V0LgNZvE+SWNrBD1LhKb
        395lgrCFJV4d38IOYUtJvOxvY4d4slri436o8R2MEi++20LYxhI3128AW8UsoCmxfpc+RFhR
        YufvuYwQa/kk3n3tYYWYwivR0SYEUaIq0XfpMNRSaYmu9g/sExiVZiH5axaSv2YheWAWwrIF
        jCyrGMVSC4pz01OLDQuMkWN6EyM4aWqZ72DccM7nEKMAB6MSD2+C/Yw4IdbEsuLK3EOMEhzM
        SiK8fKZAId6UxMqq1KL8+KLSnNTiQ4ymwGCfyCwlmpwPTOh5JfGGpkbGxsYWJmbmZqbGSuK8
        U6/nxAkJpCeWpGanphakFsH0MXFwSjUw8rbslNFvP871KGa36t+LJ5Q7Jn5ZffXMPk+24C4z
        3feWdlsTc19e+FXX9jRI7OmVnUKxa58vsFTYWiR++B2H4uOqPftfbXlc6nt48nSZ/sx+4eUT
        fjx84XKQc+Gl4rL60ECJqwdXJy7UFlniU7pBxtvpiQL3iZ5Cw9dMgd4e5ZKdEuIveDIVlFiK
        MxINtZiLihMB8nNaE7ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXve12Mw4g+ZzZhZvTk5lsdiz9ySL
        xeVdc9gsLv//xGKx7MtkFost/46wOrB5fJlznN2jbfI/do/mYyvZPPq2rGL0+LxJLoA1issm
        JTUnsyy1SN8ugStj4dI1bAUbWStuLXzI3sC4m6WLkYNDQsBEoqPVqYuRi0NIYDejxMf+w+xd
        jJxAcWmJYyfOMEPUCEscPlwMUfOcUeLv7Q+sIDVsAroS//7sZwOxRQTcJdac+8kMUsQscJFR
        4v+5dWwQHYsZJXat7QHr4BQIkrj++gALiC0sYC+x8v55sDiLgKrE7g/vmUBsXgFLiWvvvrFB
        2IISJ2c+AbuUWUBPom0jI0iYWUBeYvvbOcwQhypI/Hy6jBWkRETASuJVmz9EiYjE7M425gmM
        wrOQDJqFMGgWkkGzkHQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHD9amjsY
        Ly+JP8QowMGoxMObYD8jTog1say4MvcQowQHs5IIL58pUIg3JbGyKrUoP76oNCe1+BCjNAeL
        kjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQZGK17dL8zsj27I+5TN5Z629enEsyn5RuZhL0/Y
        uE/b6lNcqNoVerPdPev5kuaTBm0XjzQ8kjH4u+pOUu7HmJjMvwsO9987znbg5C2NlwyKJ/2m
        J4UrRNb4Llow+WaaXtQ78zKjpUefGkvHyV5Sdsmoffb5Zs/nvc3bLv3kS5rxyqHomanP/EZb
        JZbijERDLeai4kQAYhJhH5sCAAA=
X-CMS-MailID: 20200417023939epcas1p499c819249017442a881d82cf5e04241b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200416085144epcas1p1527b8df86453c7566b1a4d5a85689e69
References: <CGME20200416085144epcas1p1527b8df86453c7566b1a4d5a85689e69@epcas1p1.samsung.com>
        <20200416085121.57495-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Replace "time_ms"  with "time_cs" in the file directory entry structure
> and related functions.
> 
> The unit of create_time_ms/modify_time_ms in File Directory Entry are not
> 'milli-second', but 'centi-second'.
> The exfat specification uses the term '10ms', but instead use 'cs' as in
> "msdos_fs.h".
> 
> Signed-off-by: Tetsuhiro Kohada
> <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> ---
I have run checkpatch.pl on your patch.
It give a following warning.

WARNING: Missing Signed-off-by: line by nominal patch author 'Tetsuhiro
Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>'
total: 0 errors, 1 warnings, 127 lines checked

Please fix it.
Thanks!

