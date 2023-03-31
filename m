Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541776D1F3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCaLh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCaLhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:37:22 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11811D874
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 04:37:20 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230331113718epoutp042bf4968484b0904906a17b9ae030324a~RffeOB9Ut1719817198epoutp04R
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 11:37:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230331113718epoutp042bf4968484b0904906a17b9ae030324a~RffeOB9Ut1719817198epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680262638;
        bh=ZuZHSgpRkzMy+3V8gsdvemF+mSJo0V42S23UhOB8beA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwoDN7rJP9M6YKXfOMztsSS0Iydzy2Xac5l0j8nSTr86qgfJnywYDbIDSaTTrnqrh
         D2kSlK6WNl9b9+OlLQ78lPLD4KWKDa3LDfao1FjvlYwTcQLeiBlKltKrJC82Wm/x/W
         0u54/frt7s9DhM9hIhSkGRPGuGa2aUcYV3UDESF4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230331113717epcas2p4372eeecc0e0249d4720c35d0c34f1b20~Rffdr2tl-2783927839epcas2p44;
        Fri, 31 Mar 2023 11:37:17 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pnyv06lFbz4x9Ps; Fri, 31 Mar
        2023 11:37:16 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.9C.61927.CE5C6246; Fri, 31 Mar 2023 20:37:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230331113715epcas2p13127b95af4000ec1ed96a2e9d89b7444~RffcE-8Ge2391623916epcas2p1t;
        Fri, 31 Mar 2023 11:37:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331113715epsmtrp2897a245f7160bcef2225149387e7d053~RffcDpyEf0503605036epsmtrp2b;
        Fri, 31 Mar 2023 11:37:15 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-51-6426c5ec4cf6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.F1.31821.BE5C6246; Fri, 31 Mar 2023 20:37:15 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230331113715epsmtip16ab6295c10357528db019d6576e3a8e6~Rffb4eUtH0924509245epsmtip1R;
        Fri, 31 Mar 2023 11:37:15 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     willy@infradead.org
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL
Date:   Fri, 31 Mar 2023 20:37:15 +0900
Message-Id: <20230331113715.400135-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZB3ijJBf3SEF+Xl2@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmme6bo2opBisXGVtMP6xoMX3qBUaL
        87NOsVjs2XuSxeLemv+sFvte72W2eNF5nMmiY8MbRovfP+awWWy8/47Ngcvj34k1bB6bV2h5
        LN7zkslj06dJ7B6Tbyxn9OjbsorR4/MmuQD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGZ+//GAu2Cxasbn9LksD407BLkZODgkBE4mm
        SQ/ZQWwhgR2MEu+3q3cxcgHZnxgl1qzrYIVwPjNK/P+9mQ2m4/3NPWwQiV2MEqtvX2OEcLqY
        JHr7voHNYhPQlvhz5TxYh4iAuMSxqScZQWxmgX+MEnsuS4LYwgKBEs1LtjKD2CwCqhJrr/WD
        1fAK2Eh8XLufCWKbvMTMS9/BZnICbb4y/ScTRI2gxMmZT1ggZspLNG+dzQxyhIRAK4fEicXz
        GCGaXSQerNnBCmELS7w6voUdwpaS+PxuL9Q7xRKPX/+DipdIHF7ymwXCNpZ4d/M5UC8H0AJN
        ifW79EFMCQFliSO3oNbySXQc/ssOEeaV6GgTgmhUkdj+bzkzzKLT+zdBDfeQePzyPzSo2hkl
        5q/+wziBUWEWkm9mIflmFsLiBYzMqxjFUguKc9NTi40KDOERnJyfu4kRnFi1XHcwTn77Qe8Q
        IxMH4yFGCQ5mJRHeQmPVFCHelMTKqtSi/Pii0pzU4kOMpsCwnsgsJZqcD0zteSXxhiaWBiZm
        ZobmRqYG5krivNK2J5OFBNITS1KzU1MLUotg+pg4OKUamLz2l/+p1k0080g11v6jOFW1tstG
        fk/7j7Tph3/LnHWYy9j//lOAXWevTSmv+IWy2d8V9JK3mQdkrHKOMArju8Nz4mTLCf9tPntz
        SgWP9S/Ik1kivfr/6bM/8lVfbub5I/R0iqZWcaTGZ0fR5Z25C5ICXv699UmtfPqB+dPXndFU
        j4+TXBQwayFLy45ei8aF4gHv9tuf0ZRR27pE+NeMJ1ynew5m7o3aXNFa0LQ/5sddxQcnngUJ
        nD9TIKS+Rsf3u9LUVWvFla/tuMCUJmAV66J9YZba44wN3P0v3yt18k5vD5ty7cPUZ2rbH1ha
        eErPDHtm90Xwrkndu0/3Zn/9vqyau1Vd3s/u/yQD73NeS5RYijMSDbWYi4oTATYbRrE1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnO7ro2opBrt+6llMP6xoMX3qBUaL
        87NOsVjs2XuSxeLemv+sFvte72W2eNF5nMmiY8MbRovfP+awWWy8/47Ngcvj34k1bB6bV2h5
        LN7zkslj06dJ7B6Tbyxn9OjbsorR4/MmuQD2KC6blNSczLLUIn27BK6Mz19+MBdsFq3Y3H6X
        pYFxp2AXIyeHhICJxPube9hAbCGBHYwSne/jIOJSEu9Pt7FD2MIS91uOsHYxcgHVdDBJvH91
        BizBJqAt8efKebBmEQFxiWNTTzKCFDGDFG29PB0sISzgL3H01RlWEJtFQFVi7bV+RhCbV8BG
        4uPa/UwQG+QlZl76DjaUE+iiK9N/MkFcZCxxuWMxM0S9oMTJmU9YQGxmoPrmrbOZJzAKzEKS
        moUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAUaGntYNyz6oPeIUYmDsZD
        jBIczEoivIXGqilCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJx
        cEo1MLH2vROdp3e0V4C3x9DatlhYzyryyQXtrJsa2+/fPhZj+pcxYsa0mr3LP+0tcXz0MlxF
        PErdwHn/vHOffFl+Tj7+U1yz9qLyuzO6vB1ysd9zdhawVX+R+y6+fweDfrLYQ49PnQLRyg63
        ZQX+zm5zi+68ynWu7cg+x/sWnvsmGdiobpat4tz/N3rT95O1yv/P3+CVk3pe8u/aVqlog9m/
        4/fmHapUDBFJFchNW7C96HZd65YnTCt6D8W2FqiJqdU5zjyfLDDvyI6zF65eO7hAt7Tjbc6X
        FG9Rk31iT//XT2JKUZdRjVt6b6ICx7rpYsVbxYPZ9/vu538k05DX39ollnigfan8JsX0Gv8r
        7VmmSizFGYmGWsxFxYkA8NKVSvECAAA=
X-CMS-MailID: 20230331113715epcas2p13127b95af4000ec1ed96a2e9d89b7444
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331113715epcas2p13127b95af4000ec1ed96a2e9d89b7444
References: <ZB3ijJBf3SEF+Xl2@casper.infradead.org>
        <CGME20230331113715epcas2p13127b95af4000ec1ed96a2e9d89b7444@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew Wilcox. 
We appreciate you join this topic and revise our sentences sophisticatedly.

>On Thu, Mar 23, 2023 at 07:51:05PM +0900, Kyungsan Kim wrote:
>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>
>No, that's not true.  You can allocate kernel memory from ZONE_MOVABLE.
>You have to be careful when you do that, but eg filesystems put symlinks
>and directories in ZONE_MOVABLE, and zswap allocates memory from
>ZONE_MOVABLE.  Of course, then you have to be careful that the kernel
>doesn't try to move it while you're accessing it.  That's the tradeoff.

You are correct.
In fact, the intention of the sentence was to generally explain the movability preference of a kernel and user context.
We have been aware that a kernel context is able to allocate from ZONE_MOVABLE
using GFP_MOVABLE and implementing the movable callbacks, migrate_page(), putback_page(), isolate_page().
We had studied that the z3fold/zsmalloc allocator of zswap also allocate from ZONE_MOVABLE.
But we did not aware that symlinks and dentries are allocated from ZONE_MOVABLE.
Thank you for letting us know the additional cases.

Let me revise the part. In regards to page movability, 
a kernel context prefers unmovable in general, but some kernel contexts are movable such as symlink, dentry, and zswap.
an user context prefers movable in general, but some user contexts are unmovable such as DMA buffer.

>
>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>
>I think you mean "migrated".  It can't be swapped unless you put the
>page on the LRU list, inviting the kernel to swap it.

"migrated" is correct.

>
>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>
>This sounds dangerously confused.  Do you want the EXMEM to be removable
>or not?  If you do, then allocations from it have to be movable.  If
>you don't, why go to all this trouble?

I'm sorry to make you confused. We will try more to clearly explain our thought.
We think the CXL DRAM device should be removable along with HW pluggable nature.
For MM point of view, we think a page of CXL DRAM can be both movable and unmovable. 
An user or kernel context should be able to determine it. Thus, we think dedication on the ZONE_NORMAL or the ZONE_MOVABLE is not enough.

