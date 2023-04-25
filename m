Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979FE6EE0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 13:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjDYLJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 07:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjDYLJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:09:45 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FD91FE6
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 04:09:25 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230425110914euoutp02f80d4cc27689f5e35b055aa54022f76e~ZKPGnKhC72911329113euoutp02x
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 11:09:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230425110914euoutp02f80d4cc27689f5e35b055aa54022f76e~ZKPGnKhC72911329113euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682420954;
        bh=Gc4jFl8KquubYFrW8xZv5Gqj3fqTntNDZhVWlXh2E4U=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ZpSJzBmgfMItZFL1GydmZGuV7A9DANq+FLr4aQyVdi24VNkp/SuxI81tY4tcnNRaV
         3TrgU08eOtDduHCeRgPsbbuWnbT/tHv4qBl75aPD8lMuKfp3gUQQybyMeeCLzIy3wC
         b/oxmLOkUJ6jVhljx5E7e8dQa4fwLiz5ctZJI/P0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230425110913eucas1p16ebb723297aa94d2766c734d83183e6b~ZKPGNItUH1270512705eucas1p1e;
        Tue, 25 Apr 2023 11:09:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6E.2B.42423.9D4B7446; Tue, 25
        Apr 2023 12:09:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230425110913eucas1p22cf9d4c7401881999adb12134b985273~ZKPFz5aeZ0812808128eucas1p2k;
        Tue, 25 Apr 2023 11:09:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230425110913eusmtrp2c46b12ef17d135e5deccacac75179df6~ZKPFzHa7Q1014910149eusmtrp2o;
        Tue, 25 Apr 2023 11:09:13 +0000 (GMT)
X-AuditID: cbfec7f2-25927a800002a5b7-37-6447b4d905ba
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.57.10549.9D4B7446; Tue, 25
        Apr 2023 12:09:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230425110913eusmtip20311b17f49b03fde53a0b57a9dc3c58f~ZKPFnrhol0897708977eusmtip2H;
        Tue, 25 Apr 2023 11:09:13 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 25 Apr 2023 12:09:12 +0100
Date:   Tue, 25 Apr 2023 13:00:25 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>, <hughd@google.com>,
        <akpm@linux-foundation.org>, <brauner@kernel.org>,
        <djwong@kernel.org>, <da.gomez@samsung.com>,
        <a.manzanares@samsung.com>, <dave@stgolabs.net>,
        <yosryahmed@google.com>, <keescook@chromium.org>, <hare@suse.de>,
        <kbusch@kernel.org>, <patches@lists.linux.dev>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <p.raghav@samsung.com>
Subject: Re: [RFC 2/8] shmem: convert to use folio_test_hwpoison()
Message-ID: <20230425110025.7tq5vdr2jfom2zdh@localhost>
MIME-Version: 1.0
In-Reply-To: <ZEMRbcHSQqyek8Ov@casper.infradead.org>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7o3t7inGDyfrW4xZ/0aNovXhz8x
        Wqy+uYbR4vITPos9iyYxWTz91MdiMenQNUaLM925FntvaVvs2XuSxeLyrjlsFvfW/Ge1uDHh
        KVD5iUuMFr9/AMW274p0EPCY3XCRxWPBplKPzSu0PDat6mTz2PRpErvHiRm/WTxebJ7J6DF1
        dr3H5tPVHp83yQVwRXHZpKTmZJalFunbJXBl/LhxhbngMG/F+iutbA2M07m7GDk4JARMJKas
        l+5i5OIQEljBKLHvxHs2COcLo8SrO/9Zuhg5gZzPjBJ778WC2CANp1Z9Y4EoWs4ocWTLT0YI
        B6jozPSbUO1bGCX+/v3GCtLCIqAq0behjxVkH5uAlkRjJzuIKSKgIfFmixFIObPATWaJi7cn
        MoOUCws4Sfye38AEYvMKmEs8vH0ayhaUODnzCdhFnEBXvFm5gRHiIiWJhs1nWCDsWom9zQfY
        QYZKCOzmlHg7YzITRMJF4smTDnYIW1ji1fEtULaMxP+d86FqqiWe3vjNDNHcwijRv3M9GySQ
        rCX6zuSA1DALZEicWd3FCBF2lHjazQFh8knceCsIUcEnMWnbdGaIMK9ER5sQxHA1idX33rBA
        hGUkzn3im8CoNAvJX7OQjIewdSQW7P7ENguog1lAWmL5Pw4IU1Ni/S79BYysqxjFU0uLc9NT
        iw3zUsv1ihNzi0vz0vWS83M3MQLT4el/xz/tYJz76qPeIUYmDsZDjBIczEoivLyV7ilCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamLqjbhv1RQRvNfxZ
        Ofdz7pdfIsbRuUz7tuvJBEZITj5/+ljptPIHefFCDoZx5+IX35uxYG2NfFTmI9N7P904ufmX
        Xmp+VZ16tKtpJUOW3pYXN7jEc/hrODd81vxr4xJaOClXTGhHdPzcGxlflv8V/68cqNKwaJ1O
        mYeOpI1J71Y1kffntvo/fiH/Ilq6RslVvXJdzNmbqWZd64xN3p73uXVSU87detXKo5WX1eMV
        Ao9Kfz+k/czg9UcW34PpUyTFOg1lDqzftCfGLnHmkrNi5287vkyXDX4mVCy1PfNa8urn2/0S
        zdz0/q30Y3udvV5Uaeq6r7Eaa3svZ3XrPWT1/fFvyY6n5ZFFVaoVTpkZSizFGYmGWsxFxYkA
        lh6Iw/YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xe7o3t7inGByezmsxZ/0aNovXhz8x
        Wqy+uYbR4vITPos9iyYxWTz91MdiMenQNUaLM925FntvaVvs2XuSxeLyrjlsFvfW/Ge1uDHh
        KVD5iUuMFr9/AMW274p0EPCY3XCRxWPBplKPzSu0PDat6mTz2PRpErvHiRm/WTxebJ7J6DF1
        dr3H5tPVHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTm
        ZJalFunbJehlzJ4uWNDMXfHo8FnGBsYPHF2MnBwSAiYSp1Z9Y+li5OIQEljKKHFz/2RGiISM
        xMYvV1khbGGJP9e62CCKPjJKfN/2gx3C2cIocWDTFLAOFgFVib4NfUAdHBxsAloSjZ3sIKaI
        gIbEmy1GIOXMAjeZJS7ensgMUi4s4CTxe34DE4jNK2Au8fD2aSaImRMZJb7134NKCEqcnPmE
        BcRmFtCRWLD7ExvIUGYBaYnl/8A+4AT64M3KDVBHK0k0bD7DAmHXSnS+Os02gVF4FpJJs5BM
        moUwaQEj8ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAaN927OfmHYzzXn3UO8TIxMF4iFGC
        g1lJhJe30j1FiDclsbIqtSg/vqg0J7X4EKMpMCQmMkuJJucD001eSbyhmYGpoYmZpYGppZmx
        kjivZ0FHopBAemJJanZqakFqEUwfEwenVAPTzoR9s8tC7lw6lCf9LeB75a7fOgn/fGfWSSye
        7H/ovKLE3nNn+zuXXe9qa5R6qMJxVER3Xf6R1as/rP2zI3JXwpLLN/07w2YcO66fVhVg7is7
        52dP4/yCG1qTGH3/1KVYyz7xOryn46nV0q5Zk5gu6+1JnxOs7rCri/H620VaXd7J9xbNSAxM
        3ddWENPxOEpYV3R3J8/PQnstg+fS6cXiE+uyGh9Pb315ifVCoTvnn121bx/VKVy/+uVF0Puc
        x8el7k9+ma21/Wnhpcs/P4QLV5/4s0XUfaLbTPPtlr+rvu/cUOFnwcJn9bNVf4Z1ZlyRxxw2
        Qesvm3UN1F6/VHSR7dmfFdrX82umSqrQd8kUJZbijERDLeai4kQAA3U0pX8DAAA=
X-CMS-MailID: 20230425110913eucas1p22cf9d4c7401881999adb12134b985273
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----t5a.LUSxvZ8UNChTG7xN-7.3lkNPyOm_Ty_DrQaWPiPzU4rz=_ea8fb_"
X-RootMTR: 20230425110913eucas1p22cf9d4c7401881999adb12134b985273
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230425110913eucas1p22cf9d4c7401881999adb12134b985273
References: <20230421214400.2836131-1-mcgrof@kernel.org>
        <20230421214400.2836131-3-mcgrof@kernel.org>
        <ZEMRbcHSQqyek8Ov@casper.infradead.org>
        <CGME20230425110913eucas1p22cf9d4c7401881999adb12134b985273@eucas1p2.samsung.com>
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

------t5a.LUSxvZ8UNChTG7xN-7.3lkNPyOm_Ty_DrQaWPiPzU4rz=_ea8fb_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Apr 21, 2023 at 11:42:53PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 21, 2023 at 02:43:54PM -0700, Luis Chamberlain wrote:
> > The PageHWPoison() call can be converted over to the respective folio call
> > folio_test_hwpoison(). This introduces no functional changes.
> 
> Um, no.  Nobody should use folio_test_hwpoison(), it's a nonsense.
> 
> Individual pages are hwpoisoned.  You're only testing the head page
> if you use folio_test_hwpoison().  There's folio_has_hwpoisoned() to
> test if _any_ page in the folio is poisoned.  But blindly converting
> PageHWPoison to folio_test_hwpoison() is wrong.

I see a pattern in shmem.c where first the head is tested and for large
folios, any of pages in the folio is tested for poison flag. Should we
factor it out as a helper in shmem.c and use it here?

static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
...
	if (folio_test_hwpoison(folio) ||
	    (folio_test_large(folio) &&
	     folio_test_has_hwpoisoned(folio))) {
	..
> 
> If anyone knows how to poison folio_test_hwpoison() to make it not
> work, I'd appreciate it.

IMO, I think it will be clear if folio_test_hwpoison checks if any of the
page in the folio is poisoned and we should have a explicit helper such
as folio_test_head_hwpoison if the callers want to only test if the head
page is poisoned (although I am not sure if that is useful).

------t5a.LUSxvZ8UNChTG7xN-7.3lkNPyOm_Ty_DrQaWPiPzU4rz=_ea8fb_
Content-Type: text/plain; charset="utf-8"


------t5a.LUSxvZ8UNChTG7xN-7.3lkNPyOm_Ty_DrQaWPiPzU4rz=_ea8fb_--
