Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F11E1E5552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 07:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgE1FF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 01:05:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10988 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1FFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 01:05:55 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200528050553epoutp011ad9bbc18aa29803a32d9714db96adc6~TGMsHkVL00856408564epoutp01d
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 05:05:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200528050553epoutp011ad9bbc18aa29803a32d9714db96adc6~TGMsHkVL00856408564epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590642353;
        bh=Xpl4KdtQS6IHn7dUVSCu2aSIRKN5N8K0wozlMY6vGBs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=uANcr4D5qhy6FfjewlbGMD8qSKFAfVua3qPYSPciVCfrQrY17kkwCA+PTc5XynEPE
         fVQw8IVq4e8QYVPrehAgpGNHJ4wVDKKwzUL5QR1oxuXKkTW8DzBwXmoMi1SycoleAi
         ZlrAg0mlbfz9Sn2j2KW8Neui7ADu7iADoDLboNas=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200528050552epcas1p47bb06270afdda6394638aee05f7da3bd~TGMrelyg52563325633epcas1p4T;
        Thu, 28 May 2020 05:05:52 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49XbJ035ZRzMqYkp; Thu, 28 May
        2020 05:05:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.EC.04395.0B64FCE5; Thu, 28 May 2020 14:05:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200528050551epcas1p434d454bab29e7ff5e4eeb861cc52ad5d~TGMqicsAm1730217302epcas1p48;
        Thu, 28 May 2020 05:05:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200528050551epsmtrp1c14c006826bac76c23935137187058fe~TGMqhud461620716207epsmtrp1O;
        Thu, 28 May 2020 05:05:51 +0000 (GMT)
X-AuditID: b6c32a39-f7bff7000000112b-d1-5ecf46b088dc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.87.08303.FA64FCE5; Thu, 28 May 2020 14:05:51 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200528050551epsmtip1a7f86adf4a45751001185e64ed32b0c7~TGMqWxesV2192621926epsmtip1a;
        Thu, 28 May 2020 05:05:51 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     "'Mori.Takahiro@ab.MitsubishiElectric.co.jp'" 
        <Mori.Takahiro@ab.mitsubishielectric.co.jp>,
        "'Motai.Hirotaka@aj.MitsubishiElectric.co.jp'" 
        <Motai.Hirotaka@aj.mitsubishielectric.co.jp>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Namjae Jeon'" <linkinjeon@kernel.org>,
        "'Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp'" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
In-Reply-To: <22dfcd8a-4416-e2a7-b8a7-0375660ba465@gmail.com>
Subject: RE: [PATCH] exfat: optimize dir-cache
Date:   Thu, 28 May 2020 14:05:52 +0900
Message-ID: <015501d634ad$a8dcd680$fa968380$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKbEd8GOCYeHYQBe/Vm0kX/gmqw5wMD/7F2AWi7CpYCLmCEuwJD5ds7AXx55Z4BYsdZNqbVRWFQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHebx3d3fS6ja1Tga5bvTBSt1aW9dw0YvUhSzEoMAPWxd92MS9
        sbtJVpRRmFpUGoXOmRVUNLVimZVUkoq23l/Jij4UFWkZWalFttp2jfz2O+f5n3Oe//McmlBd
        oJLpIocHux2CjaXiybauVE3a+VX3TZrTQ0ncj4aXJPcpdJjkqo+cJLir10Ik97jdT3GP/3wl
        uVPfD5Fca7hbtozmv/t75Xz5obCc39VzhuKv+F7J+WCgkuL3twYQ/y04K1eeb8uyYqEQu9XY
        UeAsLHJYjOya9eaVZr1Bo03TZnKLWbVDsGMjm52Tm7aqyBa5FasuEWzeSCpXEEU2Y2mW2+n1
        YLXVKXqMLHYV2lxajStdFOyi12FJL3Dal2g1moX6iHKTzXq89gPlOklufhJsRGWohqhCChqY
        RVBZ1xTheFrFXEZw4cRrUgq+Ihgb3hMXVamYbwjeH8VViI5VjOwUJE07goGRnXFS0B8JggOx
        thSTBuGxDirKiUw6hELPqKiIYK4TECirR9EDBWOEwepwbEJCRDQ00h9jkpkL1xuOkVFWMpng
        fzlKSTwVQnVvY3mCSYFLg/5xD2r4+e6UTBqWD/6eFrmkSYT6yvKYN2BaaDh8dy8pFWRDX0WN
        XOIEGOhtHedk6D9QLpdsboWhjvH+FQg+jBol1sHzc+dlUQnBpMK59gwpPRuu/GpA0tjJ8Hl4
        n0zqooSKcpUkmQv7H3XFSTwTqvZ8kR9ErG+CMd8EY74JBnz/hx1DZABNwy7RbsGi1qWf+NdB
        FFvYeZmXUc+9nE7E0IidpNTw90wqmVAilto7EdAEm6hccfe2SaUsFEq3YLfT7PbasNiJ9JF3
        ryaSkwqckfV3eMxa/UKdTsctMiw26HXsdGXjjzsmFWMRPLgYYxd2/6uLoxXJZSipb3W4flLO
        uub80QU1bbV9luOK9AdbO/Qla4cfFt/MmmPNzvhVd2P5JYO5cv7Grm3dofg1p5s2DM/YqDjb
        23zVO/i5GxdN4ZcwbWW+kbzdTw07avcJy7ff8d16kZr3+2lCcelqX7CnCV41Qsr0+W9w3tKx
        gONi7uACWerz/BTbRxNLilZBO49wi8JfOcT0Q8YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO56t/NxBnufWlj8mHubxeLNyaks
        FhOnLWW22LP3JIvF5V1z2Cwu///EYrHsy2QWiy3/jrA6cHh8mXOc3aNt8j92j+ZjK9k8ds66
        y+6xaVUnm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlLJzxgq1gKUvFlU3zGRsYJzF3MXJw
        SAiYSHxrTOxi5OIQEtjBKPG85wpjFyMnUFxa4tiJM1A1whKHDxdD1DxnlJh2Zi0LSA2bgK7E
        vz/72UBsEQE9iZMnr7OBFDEL7GGW2HnhOiNExzFmiQnXfoBVcQrYSryd+I8JxBYG6vj47SWY
        zSKgKrFv7gKwqbwClhJzbn9ng7AFJU7OfAIWZxbQlnh68ymULS+x/e0cZohLFSR+Pl3GCnFF
        lMScY2vZIWpEJGZ3tjFPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5
        xaV56XrJ+bmbGMHRpqW1g3HPqg96hxiZOBgPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnPfrrIVxQgLpiSWp2ampBalFMFkmDk6pBqYSsRABe/Hckztm/hGxvXRgXm/ukY3P
        vr1dfWLHlyu7poloO7Fx5jy/6HS1UTrT/4zBItG02/uVnA+HaWyduD9pl2KWK6PORy59g49c
        +x3P8y781JHsm2Gz5vr7Q4mu4pa33/55qDHBcfq9fj0Vw48bHvouUf322s3RfUPDwi8vKoVf
        e29IabJi6tJw/D9HNakwf3bdfbWdPybvahJLMS9Mna676MKML9Kl56QL3ojfEAnoz5hZ3jhJ
        9XqwzFLmPUUbakp+7DdYabhs8abkGeIly/9HJSyao1bonSRWdzuywPzFgbf91+5NDN3X9vKO
        8dFrM3q6bh2sZ3LsYpHf6y4+adaLr5v3M0QkreBJ/V6vxFKckWioxVxUnAgAsAmk8yUDAAA=
X-CMS-MailID: 20200528050551epcas1p434d454bab29e7ff5e4eeb861cc52ad5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61
References: <CGME20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61@epcas1p2.samsung.com>
        <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
        <055a01d63306$82b13440$88139cc0$@samsung.com>
        <TY1PR01MB15784E70CEACDA05F688AE6790B10@TY1PR01MB1578.jpnprd01.prod.outlook.com>
        <CAKYAXd_oG6dc7CNiHszKmhabHd2zrN_VOaNYaWRPES=7hRu+pA@mail.gmail.com>
        <000701d63432$ace24f10$06a6ed30$@samsung.com>
        <22dfcd8a-4416-e2a7-b8a7-0375660ba465@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >>>   > In order to prevent illegal accesses to bh and dentries, it
> >>> would be better to check validation for num and bh.
> >>>
> >>>   There is no new error checking for same reason as above.
> >>>
> >>>   I'll try to add error checking to this v2 patch.
> >>>   Or is it better to add error checking in another patch?
> >> The latter:)
> >> Thanks!
> >
> > Yes, the latter looks better.
> 
> I will do so.
> 
> I will post additional patches for error checking, after this patch is merged into tree.
> OK?
Okay.
> 
> 


