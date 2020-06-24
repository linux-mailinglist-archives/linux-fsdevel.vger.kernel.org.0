Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C174A20695D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 03:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbgFXBMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 21:12:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30894 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387916AbgFXBMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:12:41 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200624011237epoutp0201a3e3da8e1ad55e5636ce0f0e52b59a~bVbuV56Y60753207532epoutp02q
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 01:12:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200624011237epoutp0201a3e3da8e1ad55e5636ce0f0e52b59a~bVbuV56Y60753207532epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592961157;
        bh=0pVFxRdnFVxe4wAzFArPGFi5sLNYQaBwqOmcKD0E55s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=IOoWb/TR3JfOFaxJ5romZGiQkSAsfjEZ8nH2SD7J68Y7g5ZJhKv0fEJYnStmA8cB1
         XLqBdhHNehrcQVZZwcZBFW7EJ9Sw4XiIb/w5JpX8bFDLtVf0zJZkLze3bPN+M9dWm3
         EqgkG+2uOvjWt3nOXytZaRcS+c70rK9d5yn4ESTk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200624011236epcas1p4ef2652e8c4df03503f40a0aeb7887cc5~bVbtsF9MT0995609956epcas1p4y;
        Wed, 24 Jun 2020 01:12:36 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49s4rN0v7FzMqYkj; Wed, 24 Jun
        2020 01:12:36 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.A8.18978.388A2FE5; Wed, 24 Jun 2020 10:12:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200624011235epcas1p1cc118bf256fc7ab47305245fa9fc9ea5~bVbsdnf9Y0583205832epcas1p1x;
        Wed, 24 Jun 2020 01:12:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624011235epsmtrp12f3583977dd92cb880e6f5cac92604b6~bVbsc-S8S0633806338epsmtrp1b;
        Wed, 24 Jun 2020 01:12:35 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-07-5ef2a883235d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.F8.08303.388A2FE5; Wed, 24 Jun 2020 10:12:35 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200624011235epsmtip1ccfe4b39d4f29f6dd539fa21d2c55558~bVbsM0zqV2590125901epsmtip1t;
        Wed, 24 Jun 2020 01:12:35 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200623062219.7148-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 1/2 v5] exfat: write multiple sectors at once
Date:   Wed, 24 Jun 2020 10:12:35 +0900
Message-ID: <00ef01d649c4$8b5046c0$a1f0d440$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJz3CXjUro6DoMrwhMUic3Dlt9AmwD7AL/Xp6P4e0A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmgW7zik9xBou32lj8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7tF8bCWbx85Zd9k9+ras
        YvT4vEkugC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxofNV1kLtjFVzJ+5lLmB8R9jFyMnh4SAicTLxzvZuxi5OIQEdjBK3H87iwXC
        +cQocXLhHjYI5zOjRMfWDewwLVMajzBBJHYxSmxvWA9V9ZJR4vWb/WwgVWwCuhL//kDYIgJ6
        EidPXgcrYhZoZJJYfuILM0iCU8BC4tGjn2BFwgKOEme3vGMFsVkEVCVu3HgLZvMKWEq0TTrB
        BmELSpyc+YQFxGYWkJfY/nYOM8RJChI/ny5jhVhmJTFn5X9miBoRidmdbcwgiyUEFnJIbJo8
        nRWiwUViy56vUP8IS7w6vgXKlpJ42d8GZHMA2dUSH/dDze9glHjx3RbCNpa4uX4DK0gJs4Cm
        xPpd+hBhRYmdv+cyQqzlk3j3tYcVYgqvREebEESJqkTfpcNMELa0RFf7B/YJjEqzkDw2C8lj
        s5A8MAth2QJGllWMYqkFxbnpqcWGBYbIsb2JEZxQtUx3ME58+0HvECMTB+MhRgkOZiUR3hC3
        T3FCvCmJlVWpRfnxRaU5qcWHGE2BQT2RWUo0OR+Y0vNK4g1NjYyNjS1MzMzNTI2VxHnFZS7E
        CQmkJ5akZqemFqQWwfQxcXBKNTCdSt5TkRxlsti9x37LB617HE8i72qHmWQtn533IqXjwh6d
        YNvTU7jYstdJ5L+2/2iWw3rryKE319mW3l/E+f6RaULJM54T+wTLpm96yPnM4fmXuxPVr56q
        1zmgE51+52B1SQZz1pMF05iEjmZY/5ZXTp/xSzpwb8X/Zp8ek6OTIplSojYH7o46Mql4E/sz
        XfdNhs+jt3+QfqFXdJLv+ZZ2k8fKR3j0V33qaecQ9Pocvm8N85tre+Iyb0x/mHdyTcG/q6vP
        HhfPnbxw4ru9k2+HhHzRq3704PqJ3s/PJ+67tKl+WyxDp61Mqp9hTquboN1LjTqWp3+Omm7d
        Hx88Pb7uuv9up5ZC5rVeOS1bmX7rK7EUZyQaajEXFScCAF3+gYkxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTrd5xac4g6YWXosfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLLb8O8LqwO7xZc5xdo+2yf/YPZqPrWTz2DnrLrtH35ZV
        jB6fN8kFsEVx2aSk5mSWpRbp2yVwZXzYfJW1YBtTxfyZS5kbGP8xdjFyckgImEhMaTzC1MXI
        xSEksINRon3Oa2aIhLTEsRNngGwOIFtY4vDhYoia54wSExtbwJrZBHQl/v3ZzwZiiwjoSZw8
        eZ0NpIhZoJlJ4tuzJcwQHZ2MEg8Pd7GAVHEKWEg8evQTrENYwFHi7JZ3rCA2i4CqxI0bb8Fs
        XgFLibZJJ9ggbEGJkzOfsIBcwQy0oW0j2GJmAXmJ7W/nQB2qIPHz6TJWiCOsJOas/M8MUSMi
        MbuzjXkCo/AsJJNmIUyahWTSLCQdCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525i
        BMeVltYOxj2rPugdYmTiYDzEKMHBrCTCG+L2KU6INyWxsiq1KD++qDQntfgQozQHi5I479dZ
        C+OEBNITS1KzU1MLUotgskwcnFINTGXJJR+OmR56mLLiyYcvLv8mrmScf973yo5lpg+lO77X
        XO7aej1IY80Zo7/Re5y9m/x8JtUz2y7792BpzNsNC9+J7DjucHtJnP2y1HPyIpVpH/cfnyjz
        VuBCzdIdJVxcK9gVJfa/6QzUDI2LYQ2vf/qgQeDoqdgT04u9/1kz9aziYC8T81ROn95yRnJq
        2bt9l9ju1XYHhG+au4pnUbLK9SN77HgC1vOVlq9s1Dg0P/TPlXlz+C0PmRfvldd/6FXMbcP6
        vufL6zo95bSrv9dM+p9jyvDr265TlZN/ydgdV7Z7k6X84IZR/xt9/abr9QzJh5yaPwnqp2Ut
        ZXziNJ3xt7VABPO6bd/vcWRqdgVveqjEUpyRaKjFXFScCADLdkfZGgMAAA==
X-CMS-MailID: 20200624011235epcas1p1cc118bf256fc7ab47305245fa9fc9ea5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200623062229epcas1p266112bfc61ee58ff8b0ba1cd3e6e6ac6
References: <CGME20200623062229epcas1p266112bfc61ee58ff8b0ba1cd3e6e6ac6@epcas1p2.samsung.com>
        <20200623062219.7148-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Write multiple sectors at once when updating dir-entries.
> Add exfat_update_bhs() for that. It wait for write completion once instead of sector by sector.
> It's only effective if sync enabled.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
Pushed your 2 patches to exfat #dev.
Thanks!

