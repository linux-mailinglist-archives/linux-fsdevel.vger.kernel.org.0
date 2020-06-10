Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A692F1F4BA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 04:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgFJC7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 22:59:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:32918 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgFJC7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:59:46 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200610025942epoutp037b205f7bf666e4bd0edcb6f3019a33a5~XD3O4C-h90138901389epoutp03n
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 02:59:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200610025942epoutp037b205f7bf666e4bd0edcb6f3019a33a5~XD3O4C-h90138901389epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591757983;
        bh=qFIgrh0/25RaBSZjjWKHEH9rredZA0YwO8dGahJloC4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Jv6N9lxMiKY1lVAyHCMp9GKH9Rsd7yn1GjWk8KwknZpiDvgu0AcMIFAUQBefhBSeP
         ZGfkISYlY1paFxRuPNQ9mpP6g7ZjZ2ZVjxp8MpRYMY5WITLFa5LbF+HiDG1TP0W6ti
         vy/7ViEWaOvqF0RFraibERd4Yrcegii57E1uNJCU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200610025942epcas1p4f9f621901b6cd2cfb2d8426413bc2788~XD3OesnI00717407174epcas1p4F;
        Wed, 10 Jun 2020 02:59:42 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49hWtP4TQszMqYkX; Wed, 10 Jun
        2020 02:59:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.B1.19033.C9C40EE5; Wed, 10 Jun 2020 11:59:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200610025940epcas1p43774c900e7bc618a943f8b2a3ba8bf56~XD3MJb6660717807178epcas1p4-;
        Wed, 10 Jun 2020 02:59:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200610025940epsmtrp24036306a91a4c6bd94c7382aa87d466b~XD3MI12x11724717247epsmtrp26;
        Wed, 10 Jun 2020 02:59:40 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-9d-5ee04c9c7a17
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.80.08303.B9C40EE5; Wed, 10 Jun 2020 11:59:39 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200610025939epsmtip18d9a1831822a765fcb0908a77363ccf6~XD3L9afKd0141801418epsmtip1t;
        Wed, 10 Jun 2020 02:59:39 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Hyeongseok.Kim'" <hyeongseok@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <03cc01d63e32$1dec4a40$59c4dec0$@samsung.com>
Subject: RE: [PATCH v2] exfat: Set the unused characters of FileName field
 to the value 0000h
Date:   Wed, 10 Jun 2020 11:59:39 +0900
Message-ID: <002a01d63ed3$2ed5e680$8c81b380$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCyiFQHEUSyYSCkK7CIBhZBenp9NAGiDhdLAMvezT6rBSUvEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmvu4cnwdxBsumalj8nfiJyWLP3pMs
        Flv+HWF1YPbYOesuu0ffllWMHp83yQUwR+XYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gAtUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        GBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GQc+3GIqaCJueLMil8sDYzbmLoYOTkkBEwkmrZP
        Z+5i5OIQEtjBKLHx9QNWCOcTo0TDls2MEM5nRomlG9+xw7R8aZoHVbWLUWLDhdtQzktGiX3P
        vjODVLEJ6Er8+7OfDcQWAbJXL9kGFmcWCJDYfGAXI4jNKWAl8eDXfrCpwgLxEv+eXAEaxMHB
        IqAqcX0zD4jJK2ApcXJ/OUgFr4CgxMmZT1ggpshLbH87hxniHgWJn0+XgXWKCDhJ/GjKhSgR
        kZjd2Qb2mYTAW3aJKU032SDqXSSO7dzBCmELS7w6vgXqLymJz+/2soHMkRColvi4H2p8B6PE
        i++2ELaxxM31G8BWMQtoSqzfpQ8RVpTY+XsuI8RaPol3X3tYIabwSnS0CUGUqEr0XToMDXNp
        ia72D+wTGJVmIflrFpK/ZiF5YBbCsgWMLKsYxVILinPTU4sNC4yQY3oTIzgFapntYJz09oPe
        IUYmDsZDjBIczEoivNUP7sQJ8aYkVlalFuXHF5XmpBYfYjQFhvNEZinR5HxgEs4riTc0NTI2
        NrYwMTM3MzVWEudVk7kQJySQnliSmp2aWpBaBNPHxMEp1cBk1Mjn8C6sm9v9ytPnL9Kb+15M
        07jQ67qkdHfPrkyF5bsOGqy7/72aY5WC9fHZj3SFRXZu293G/X+D8rTSZ7smXTzc99TQ5OGB
        2w7PLiiwJ1fuNQ7Odnt079GK60te/ElZOKXezGPfg++hfR29Oy/5a61YsvR3+9w/0z48FPlR
        5P9mJse5UA3RPxyT72ku551tIWV68Otx8Z79+d+1XNbZHtw0zV9pi7SScLbG3O9Znz9qzhG4
        1h2ce9HXbOudJs4pOV7b3l6bd0f8yslFUY6pOj9uM2Q9OaHWc6xZgn19XZGhgZnZ5a0KXQxm
        0inR/6y3hD0UF9/RrJwQelf1YbGmg93dV3c89z/wNnkqGnPPVImlOCPRUIu5qDgRAI2uyucK
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO5snwdxBiuWWVv8nfiJyWLP3pMs
        Flv+HWF1YPbYOesuu0ffllWMHp83yQUwR3HZpKTmZJalFunbJXBlHPtxiKmgibnizIpfLA2M
        25i6GDk5JARMJL40zWPtYuTiEBLYwSjxt3kiVEJa4tiJM8xdjBxAtrDE4cPFEDXPGSV6n+5m
        A6lhE9CV+PdnP5gtAmSvXrKNGcRmFgiQONZ9kR2i4TCjxLvzyxlBEpwCVhIPfu1nB7GFBWIl
        5j5dDbaARUBV4vpmHhCTV8BS4uT+cpAKXgFBiZMzn7BAjNSWeHrzKZQtL7H97RxmiDMVJH4+
        XcYK0ioi4CTxoykXokREYnZnG/MERuFZSCbNQjJpFpJJs5C0LGBkWcUomVpQnJueW2xYYJSX
        Wq5XnJhbXJqXrpecn7uJERwNWlo7GPes+qB3iJGJg/EQowQHs5IIb/WDO3FCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeb/OWhgnJJCeWJKanZpakFoEk2Xi4JRqYNJYnnOWaeV31QSdgqqo27+Z
        DN/PlD28fvrD7xaGT5nUIgIn21x8Xita2SyhUdp0Ytrfwu/LeyrSN80peGi4tqvpWLJgwadC
        V7bP09RUT26s9rpQ+yxV6WNC6brZs06Uz9pz0zvohDmH48Ki9lXJAa2TbktVSXyZ8PdTyVQN
        4+ProhjuFnLo+T97oRK7xqXgCH//QenZ8z0O7dhQcmrvfdPWFeK2QazGf74tU/afJjbt5xuO
        2ukX17389DtkYzfvzS3H3yxmmblvbsKUmVcM3ea8yj209dmOmhXc0to792RWPmnbqqmZcsEw
        2ccndOGdnt2pIQ6npKxKVDqPzMrXkZPwyt/wcv687a8Fel+n1n5TYinOSDTUYi4qTgQAhbX9
        q/UCAAA=
X-CMS-MailID: 20200610025940epcas1p43774c900e7bc618a943f8b2a3ba8bf56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609053051epcas1p2dcc80d99a10bcc83e11fda481239e64a
References: <CGME20200609053051epcas1p2dcc80d99a10bcc83e11fda481239e64a@epcas1p2.samsung.com>
        <1591680644-8378-1-git-send-email-Hyeongseok@gmail.com>
        <03cc01d63e32$1dec4a40$59c4dec0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Some fsck tool complain that padding part of the FileName field is not
> > set to the value 0000h. So let's maintain filesystem cleaner, as exfat's spec.
> > recommendation.
> >
> > Signe-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
Fixed a typo: Signe -> Signed.
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> 
> Looks good to me. Thanks.
Applied. Thanks!

