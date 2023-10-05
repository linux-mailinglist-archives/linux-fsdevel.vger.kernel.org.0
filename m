Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6860C7BA33F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjJEPwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjJEPvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:11 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E150A6732
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 07:08:15 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231005114232epoutp03a36533a7cf81b6232e53c602ab6988f3~LM1tpSYXg2827628276epoutp039
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 11:42:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231005114232epoutp03a36533a7cf81b6232e53c602ab6988f3~LM1tpSYXg2827628276epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696506152;
        bh=RaqlpIsybY7isNdJPZ+dlNkbk//ngeJwiwfFIdHnM4M=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=mnq89GfuFTRMXkwxq48ruvqOjdrYzcIqgI2SdDejt2VarLSFZgPX639StZ5Z7CeF/
         nkPc+LFnx5LEFqtl8TYNmmZBgT+oKoIk6XNZldhK51R7ddD9QxeEGpTEn4Dbp44B9i
         DyDKF34yzZrz4gpxfk6qZuuxKRdEjhoIIa2FwftQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231005114231epcas2p1a952d840706a3e01b24bfe4c76f46c5b~LM1tBgJqb0941909419epcas2p1F;
        Thu,  5 Oct 2023 11:42:31 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S1V6H2cVQz4x9Pv; Thu,  5 Oct
        2023 11:42:31 +0000 (GMT)
X-AuditID: b6c32a43-6f7ff70000002187-97-651ea127e9fc
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.97.08583.721AE156; Thu,  5 Oct 2023 20:42:31 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 01/13] fs/f2fs: Restore the whint_mode mount option
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daejun Park <daejun7.park@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        Jorn Lee <lunar.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230920191442.3701673-2-bvanassche@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231005114130epcms2p6dce038397dbb42edad7d8089a17f4bf0@epcms2p6>
Date:   Thu, 05 Oct 2023 20:41:30 +0900
X-CMS-MailID: 20231005114130epcms2p6dce038397dbb42edad7d8089a17f4bf0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmua76QrlUgz/LeC1W3+1ns5j24Sez
        xempZ5ksnhxoZ7R4eUjTYtWDcIuVq48CRdbPYrbYe0vbYs/ekywW3dd3sFmcXPGCxWL58X9M
        Fqs65jJaTD1/hMmB3+PyFW+Py2dLPTat6mTz2H2zgc1jcd9kVo+PT2+xePRtWcXo8XmTXABH
        VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtDhSgpl
        iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTs
        jL4Hp1gLdjBVrJ5/mrGBsYOpi5GDQ0LAROLeHKsuRi4OIYEdjBIH/zcyg8R5BQQl/u4Q7mLk
        5BAWcJeYMes3O4gtJKAksf7iLHaIuJ7ErYdrGEFsNgEdiekn7oPFRQTcJBqu7mIDmcksMJVF
        YsrdLWwgCQkBXokZ7U9ZIGxpie3Lt4I1cwpYSfTf7YSKa0j8WNbLDGGLStxc/ZYdxn5/bD4j
        hC0i0XrvLFSNoMSDn7uh4pISt+dugqrPl/h/ZTmUXSOx7cA8KFtf4lrHRrBdvAK+EguO7ASL
        swioSkx8doAVosZF4t/7H2A3MwvIS2x/OwccJswCmhLrd+lDgk1Z4sgtFogKPomOw3/ZYT5s
        2PgbK3vHvCdMELaaxLqf65kmMCrPQgT0LCS7ZiHsWsDIvIpRLLWgODc9NdmowBAetcn5uZsY
        wSlYy3kH45X5//QOMTJxMB5ilOBgVhLhTW+QSRXiTUmsrEotyo8vKs1JLT7EaAr05URmKdHk
        fGAWyCuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgSkswVBmVXbA
        V6l1C6N2r/c8GbApg1fat85M/kvbhgyWqs4YdzH9OwVKjMdPceUpL1iyJ0xpS76h3z1vEbug
        xcnK1jObA6XV6rLDX35M04jtL1lSn5GdPyv9nujU5aX34riseQvbzbVjSjOn/RTfuGH75ueT
        lG7s2qAscGa9hOWDwvfPxBfvLtr2S8Q9YMm3fVUuIkEH62dP0byTrPH57Ybn+q8YOwRFxeq5
        bdQCfvvJ/9sRPePveU2xiXPb705aGXRNckF/Y9neQl4Bharw2z5Hy09vOVc066i4secng+qj
        SlK8NsUXGg8F1l1WKn3tlmA6Y6tuSNDbRVeFzSzUP4d7lWsvblG8n2on+eqoEktxRqKhFnNR
        cSIAXgy9j0oEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920191557epcas2p34a114957acf221c0d8f60acbb3107c77
References: <20230920191442.3701673-2-bvanassche@acm.org>
        <20230920191442.3701673-1-bvanassche@acm.org>
        <CGME20230920191557epcas2p34a114957acf221c0d8f60acbb3107c77@epcms2p6>
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


> Restore support for the whint_mode mount option by reverting commit
> 930e2607638d ("f2fs: remove obsolete whint_mode").
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daejun Park <daejun7.park@samsung.com>
