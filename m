Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51547BA340
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 17:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjJEPw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjJEPvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88891685B
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 07:12:08 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231005114454epoutp012ce108d05dca899fdddcf8a3eec8f10d~LM3x7jcf_0573605736epoutp01e
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 11:44:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231005114454epoutp012ce108d05dca899fdddcf8a3eec8f10d~LM3x7jcf_0573605736epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696506294;
        bh=iEVX4yqkPVrc5PKehTVpr+/Rv/QJ9ycbbD25yZnJocs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=tuSkITpM3VaSn/v0Fmwrws7mXYS+26Qea2ePtWdj66MYA7m6i1yTIxzgshmjT8qRn
         5m9tSsztqOc29pAMtMMlIlj11aDZI6sBLRsd6EQIhHUPoQA2uEJbrDHTirrZOuTkJ1
         DJ6c17H/HE8EYKsMFdfc8k7ENz6nNS6usLTAn3nM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231005114453epcas2p3ba8b1fd7f48e1ec8593b0c175d41b69c~LM3xWxyh70367803678epcas2p38;
        Thu,  5 Oct 2023 11:44:53 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S1V913Gqtz4x9Pq; Thu,  5 Oct
        2023 11:44:53 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-15-651ea1b5d4fe
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.D2.19471.5B1AE156; Thu,  5 Oct 2023 20:44:53 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 02/13] fs: Restore support for F_GET_FILE_RW_HINT and
 F_SET_FILE_RW_HINT
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        Jorn Lee <lunar.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230920191442.3701673-3-bvanassche@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231005114352epcms2p7afd86990733bd82d00a78c43d5b3f810@epcms2p7>
Date:   Thu, 05 Oct 2023 20:43:52 +0900
X-CMS-MailID: 20231005114352epcms2p7afd86990733bd82d00a78c43d5b3f810
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmme7WhXKpBvNmilusvtvPZvH68CdG
        i2kffjJb/L/7nMni5SFNi1UPwi3OvprLbrFy9VEmi5/LVrFb7L2lbbFn70kWi+7rO9gsTq54
        wWKx/Pg/JotVHXMZLc7/Pc5qMfX8ESYHQY/LV7w9Lp8t9di0qpPNY/fNBjaPj09vsXi833eV
        zaNvyypGj8+b5Dw2PXnLFMAZlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQ
        l5ibaqvk4hOg65aZA/SHkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3
        uDQvXS8vtcTK0MDAyBSoMCE749q+fSwFx5kqVs6dwtTAOJOpi5GTQ0LARGL+rFNgtpDAHkaJ
        P98Kuhg5OHgFBCX+7hAGCQsLxEkcureZHaJESWL9xVnsEHE9iVsP1zCC2GwCOhLTT9wHi4sI
        uEk0XN3F1sXIxcEs8I1FouvwUxaIXbwSM9phbGmJ7cu3gjVzClhJdE56zgoR15D4sayXGcIW
        lbi5+i07jP3+2HxGCFtEovXeWagaQYkHP3dDxSUlbs/dBFWfL/H/ynIou0Zi24F5ULa+xLWO
        jWA38Ar4SvT+XwC2l0VAVeL9pS9Qc1wk5rydAVbDLCAvsf3tHGZQmDALaEqs36UPYkoIKEsc
        uQVVwSfRcfgvO8yHDRt/Y2XvmPcEGuJqEut+rmeawKg8CxHQs5DsmoWwawEj8ypGqdSC4tz0
        1GSjAkPdvNRyePQm5+duYgQnai3fHYyv1//VO8TIxMF4iFGCg1lJhDe9QSZViDclsbIqtSg/
        vqg0J7X4EKMp0KcTmaVEk/OBuSKvJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILU
        Ipg+Jg5OqQYmb2NW5nkhHZzbujzluIoebnBV4pCZf/wZ/7+zbwPYLoq8nV3XHHzjwC3eQvXX
        HtrG82S8X3nFPvxhVMq5bd0j+wv3OdWkz3do9x9d8yT8W3CXe6G07oTwzMMss1ptOw782Vac
        cnTFJstna47PNJgUYuV52KRsx4wjG6cLfzmhfev9j5VVc77N8uZ9ut3tidgh4Vdrf768lVe9
        eKGJW2bXheIirmypgKUG01cmf/7+Rab/fNdOmTThCIusDonAQ7rrt02Nve6Uuc0rfGJJJxPH
        /jvsvt16Pnv3zjTel5vmEWwtofnsX/Wb+m0sE2+Vs+Qutlbcs/BEn61f0eUtH+6kz0iq4+2/
        ke0zvffuzVuLlViKMxINtZiLihMBsjUqZF0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920191549epcas2p35174687f1bebe87c42a658fa6aa57bff
References: <20230920191442.3701673-3-bvanassche@acm.org>
        <20230920191442.3701673-1-bvanassche@acm.org>
        <CGME20230920191549epcas2p35174687f1bebe87c42a658fa6aa57bff@epcms2p7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Restore support for F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT by
> reverting commit 7b12e49669c9 ("fs: remove fs.f_write_hint").
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daejun Park <daejun7.park@samsung.com>
