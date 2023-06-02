Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E86720016
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjFBLHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjFBLH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:27 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E36E4A
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:07:05 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110655euoutp0167029999c156d8b14d9b13b71c094865~k0t8AlBUu0189401894euoutp01t
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602110655euoutp0167029999c156d8b14d9b13b71c094865~k0t8AlBUu0189401894euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704015;
        bh=k6w26tA5MuuVW167a8RaVYBvH9le+QbGGVR79rArU/4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=h8UHQj2/jVHqdxNAasLw3FBNzysehIA1ap5mRDIBZjzJzDX3Rvu7Sjl6PHcxRufE2
         PMp89oVLf83knfN2tPL1NgTqB+YK+3M+mYUkozBYAPMrFRyjt2PAGAaDJBF6Y0KKOP
         OON3vcNMoqwwabRN1k1vI3lvxJjyaT+0RbJt3iu8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602110655eucas1p227675246ff808500707c7c36c19ed8a4~k0t73-8Gr2054620546eucas1p2e;
        Fri,  2 Jun 2023 11:06:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.8F.37758.F4DC9746; Fri,  2
        Jun 2023 12:06:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110655eucas1p158a37f974de602978a3307dc9e4a1356~k0t7qfo190085500855eucas1p1m;
        Fri,  2 Jun 2023 11:06:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230602110655eusmtrp2078bab60da58c0b9d3e545dc16bc4eb8~k0t7p-lp02226722267eusmtrp2f;
        Fri,  2 Jun 2023 11:06:55 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-a9-6479cd4f2f25
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2A.EB.14344.F4DC9746; Fri,  2
        Jun 2023 12:06:55 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110655eusmtip14bd9c332aca74c82127b8f77fbca7809~k0t7hYWXJ3230032300eusmtip1D;
        Fri,  2 Jun 2023 11:06:55 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:54 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 7/8] sysctl: Remove debugging dump_stack
Date:   Fri, 2 Jun 2023 13:06:37 +0200
Message-ID: <20230602110638.789426-8-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7r+ZytTDE4/V7bYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKOD/xI3NBD0vFgSlP2BsY
        tzN3MXJySAiYSDQ2T2bpYuTiEBJYwShxZep+KOcLo8S8m6cZIZzPjBJv5+8CynCAtbTcEoSI
        L2eU6Lo1jx2u6FzTVSYIZwujRMea7ywgS9gEdCTOv7kDtlBEQFzixOnNYGOZBSYwSvSt+wVW
        JCxgIXFr1VMmEJtFQEXiw7s+sDivgI3Eoe9zWCGulZdouz6dEcTmFLCVOHT6DBtEjaDEyZlP
        wOqZgWqat85mhrAlJA6+eAH1qbLEhHW/oebUSpzacgvsUgmBIxwS11uPskAkXCSWNS5nh7CF
        JV4d3wJly0j83zkfqmEyo8T+fx/YIZzVjEAdX5kgqqwlWq48gepwlGjZ8IkdEmJ8EjfeCkJc
        xCcxadt0Zogwr0RHm9AERpVZSH6YheSHWUh+WMDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10v
        OT93EyMwcZz+d/zrDsYVrz7qHWJk4mA8xCjBwawkwisUVp4ixJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgUl0b030Jm/+x1s2HRH78O99pZPY9usfV0Z/
        srrEPfWAtpS0M/vr5G3y6itlZPiF1c3iCm0Prm74y1PNUbZ9r7e/xHR/rpvlx8x3zLe5+P1J
        SspE7clS7O52l3p/X2FJWbZccaVtm3T3q5hr04t32Mw42uZvzn3276+XKX5hhY+FWucam6+f
        KaNlfeN4q6b1jhDH50/k+SZ+dJFlPHGoTT23fArzsyQGve5LdovtWr9/eXLhV+ytM4kX9C2i
        /eVaduzISc7+Xbee75Vgwod6ZxWfaYoPX3FPZ3i5LSim2PFa8qTqRpW1boeurjoaWTNVQfq0
        jPrMpmUsczn2WbzvmPwiTTPUcJ044/yApx2reJVYijMSDbWYi4oTAcGIBbKLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7r+ZytTDBb/E7XYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLOD/xI3NBD0vFgSlP2BsYtzN3MXJwSAiYSLTcEuxi5OIQ
        EljKKPG77TJLFyMnUFxGYuOXq6wQtrDEn2tdbBBFHxkl+jatZIJwtjBKtM3/xQRSxSagI3H+
        zR1mEFtEQFzixOnNjCBFzAITgDrW/QIbKyxgIXFr1VOwBhYBFYkP7/rA4rwCNhKHvs+BWicv
        0XZ9OiOIzSlgK3Ho9Bk2EFsIqGb9mQvsEPWCEidnPgHrZQaqb946mxnClpA4+OIFM8QcZYkJ
        635DzayV+Pz3GeMERpFZSNpnIWmfhaR9ASPzKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCY
        2nbs55YdjCtffdQ7xMjEwXiIUYKDWUmEVyisPEWINyWxsiq1KD++qDQntfgQoynQnxOZpUST
        84FRnVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwKTvVC66pNx3
        +9ea9cyZsr8Xe684YJ2gfNyjzlt524Uew92a31xmPgqd7u58+E9o+Z2qbR7J4nUVKb/8zd/+
        Cnl8v9n96evF0x7vbGE/GVMzd8ttmfQC92XWvreyr+xNXv4udmrDw5kn7ULSlp7/Zre1exJL
        dauN3JT9QU5BTuxORzckfk+bdl13TfllT+vqjmU6bm8iVHOcn5rIvl93quxy11m/NZNit0p+
        y1jw3ungVo4zp/4abay6av38GtNzE5VZBxeKrA47spE5ZtqlHK8nF2MFYlm1zpo0zezJCr51
        7YnbxrMcHk7ndgTMmPmm8OppngXbGuTbly5dPUOo5/2r1bd3uNlvulxWqsDGtcJJiaU4I9FQ
        i7moOBEACqT9ejIDAAA=
X-CMS-MailID: 20230602110655eucas1p158a37f974de602978a3307dc9e4a1356
X-Msg-Generator: CA
X-RootMTR: 20230602110655eucas1p158a37f974de602978a3307dc9e4a1356
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110655eucas1p158a37f974de602978a3307dc9e4a1356
References: <20230602110638.789426-1-j.granados@samsung.com>
        <CGME20230602110655eucas1p158a37f974de602978a3307dc9e4a1356@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unneeded dump_stack in __register_sysctl_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8873812d22f3..07804097f997 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1406,7 +1406,6 @@ struct ctl_table_header *__register_sysctl_table(
 	spin_unlock(&sysctl_lock);
 fail:
 	kfree(header);
-	dump_stack();
 	return NULL;
 }
 
-- 
2.30.2

