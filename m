Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3B202DE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 02:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgFVA1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 20:27:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:29390 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgFVA1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 20:27:22 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200622002720epoutp041d7bb3bec1117483b2a3f56c02ff2540~athnLXswm2887028870epoutp043
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 00:27:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200622002720epoutp041d7bb3bec1117483b2a3f56c02ff2540~athnLXswm2887028870epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592785640;
        bh=jCPcOeaRvhdkHyFgABEEVptIERkV666narv0UilYcno=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Ym1FQJdM3dQisyoacsy73mwG3+7DIQxWxAbzlgirE44BA1nnBUTJiPdXmHn6Ox0yG
         cURqkHcHpExyIQ8CnORFnfbCwjyWrF8Vga3qdSPR5Yj2AW5uHB009l5+mRydi4rgWD
         Wki8fiz0dYLgI4C7RbTVVQErW9thw1tMsd+vTT2g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200622002719epcas1p1f213bae64a3d5bffe6d1dfc570e3055c~athmr1Wvm3266532665epcas1p1P;
        Mon, 22 Jun 2020 00:27:19 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49qqx25VxrzMqYkZ; Mon, 22 Jun
        2020 00:27:18 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.4D.18978.5EAFFEE5; Mon, 22 Jun 2020 09:27:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200622002716epcas1p1f72a6a18e7d7c86990d34f118296eddd~athj8YmPl1151811518epcas1p1g;
        Mon, 22 Jun 2020 00:27:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200622002716epsmtrp112c643bf8dd52aa8876b012e106efd6a~athj7phab0409704097epsmtrp1E;
        Mon, 22 Jun 2020 00:27:16 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-a6-5eeffae590a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.FE.08382.4EAFFEE5; Mon, 22 Jun 2020 09:27:16 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200622002716epsmtip1c27d0d0fff5f48bcb67c70c7b29aa0ab~athjyeArn3252932529epsmtip1O;
        Mon, 22 Jun 2020 00:27:16 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <1592480606-14657-1-git-send-email-sj1557.seo@samsung.com>
Subject: RE: [PATCH] exfat: flush dirty metadata in fsync
Date:   Mon, 22 Jun 2020 09:27:16 +0900
Message-ID: <000a01d6482b$e1eb34d0$a5c19e70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDtA/PAf/AkJUVnASwyuxUrAs/RQAI7piHFqqRyXYA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmnu7TX+/jDKZPYLXYs/cki8XlXXPY
        LLb8O8LqwOzRt2UVo8fnTXIBTFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZK
        CnmJuam2Si4+AbpumTlAO5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BYYGBXrF
        ibnFpXnpesn5uVaGBgZGpkCVCTkZp+a8ZSyYz1zxtFO8gfECUxcjJ4eEgInEugf9rF2MXBxC
        AjsYJS6vmsQE4XxilJg34ToLhPONUWL7rD3MMC39TTOhWvYySjR0NbNBOC8ZJS4svwZWxSag
        K/Hvz36gBAeHCJDd98cLJMws4Cxx+MYpsBJOAXeJydtfgd0hLGAp8XbxInYQm0VAVWLinz9s
        IDYvULx5y3lmCFtQ4uTMJywQc+Qltr+dA3WQgsTPp8tYQWwRASuJOw9vskPUiEjM7mxjBrlN
        QuAeu8T799+hnnaRWNP/EsoWlnh1fAs7hC0l8bK/jR3kZgmBaomP+6HmdzBKvPhuC2EbS9xc
        v4EVpIRZQFNi/S59iLCixM7fcxkh1vJJvPvawwoxhVeio00IokRVou/SYail0hJd7R/YJzAq
        zULy2Cwkj81C8sAshGULGFlWMYqlFhTnpqcWGxYYIkf1JkZw6tMy3cE48e0HvUOMTByMhxgl
        OJiVRHhfB7yLE+JNSaysSi3Kjy8qzUktPsRoCgzqicxSosn5wOSbVxJvaGpkbGxsYWJmbmZq
        rCTOKy5zIU5IID2xJDU7NbUgtQimj4mDU6qBqSwqWO6OhfY2xv3v/5++0+GSvPynfouz0+GY
        fwUNxwu7T53ieaLEunfqlL/nSlIjbLhu3i//9lAq339BvKOIT8CTG8z/529xfJizu++58bFo
        z//l1qJd0TM2C7Qeb/hw8fCrFG3pniytta5c/57OC96U88i/59z65JKFZ8uXJujG3brF/Tg4
        /o7s38aGWb5MXzOYtxX9uvN4R8+JPwfz7rOtC516tWRyXm9A8m21u392R5279iFcormkIfKQ
        m63rT9b6mxkhZSE/1qlP0RVf5zSvcd//uVVb21IzBQSXVIeJRM7qfLR4akTYn7A5IUmP1y27
        HlY6ffmFwEknVrYtu9pktV5ydrkT0/rHHA72DUosxRmJhlrMRcWJAJ0Yqt0GBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnO6TX+/jDB4dVbXYs/cki8XlXXPY
        LLb8O8LqwOzRt2UVo8fnTXIBTFFcNimpOZllqUX6dglcGafmvGUsmM9c8bRTvIHxAlMXIyeH
        hICJRH/TTNYuRi4OIYHdjBJN2w6yQCSkJY6dOMPcxcgBZAtLHD5cDFHznFHiU+t9sBo2AV2J
        f3/2s4HUiADZfX+8QMLMAq4S85+vZoOon8Eo8fvORLBlnALuEpO3vwKzhQUsJd4uXsQOYrMI
        qEpM/POHDcTmBYo3bznPDGELSpyc+YQFYqi2xNObT6FseYntb+cwQ9ypIPHz6TJWEFtEwEri
        zsOb7BA1IhKzO9uYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLS
        vHS95PzcTYzgKNDS3MG4fdUHvUOMTByMhxglOJiVRHhfB7yLE+JNSaysSi3Kjy8qzUktPsQo
        zcGiJM57o3BhnJBAemJJanZqakFqEUyWiYNTqoEp3OdX7YQTVeXbDfijcyYLr2efE/3uC//C
        cx/dZktc1Tqr4/719T7eedkaTbPPybc7nv7CVHLlv7viOeY/TRwrVu5wyHwyIbG2N7Douerd
        oLaovk7TJyyZ9mev8s34GPLKT/EU04cnVXs1dbvXx7umvW5d8XIvB2Pgn6lRXx96n9IL05P+
        GPJJWuL/m5car547ntroH551d8WVzRoyyR9vNnh0bIh9KjrpzyR502mOS4QzeHoPTp1qzzJ/
        h2/vlH3GNtx5XvxNMn1n5q9wmmZm6vHyqK2LxqIf1zl9Jj60r/Lf4Hf32+7lN4WtNrFmT1io
        sThKyV7X78W6T73m3xYmb05pEan8bdanp/Zl1ZvLSizFGYmGWsxFxYkAXpqVgPECAAA=
X-CMS-MailID: 20200622002716epcas1p1f72a6a18e7d7c86990d34f118296eddd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200618121007epcas1p1aa0f24b361e0232913bf7477ee0a92c8
References: <CGME20200618121007epcas1p1aa0f24b361e0232913bf7477ee0a92c8@epcas1p1.samsung.com>
        <1592480606-14657-1-git-send-email-sj1557.seo@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> generic_file_fsync() exfat used could not guarantee the consistency of a file because it has flushed
> not dirty metadata but only dirty data pages for a file.
> 
> Instead of that, use exfat_file_fsync() for files and directories so that it guarantees to commit both
> the metadata and data pages for a file.
> 
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Pushed it into exfat #dev. Thanks!

