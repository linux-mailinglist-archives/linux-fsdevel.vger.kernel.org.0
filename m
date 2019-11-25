Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3D51085C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfKYAGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:06:54 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:26194 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKYAGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:38 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191125000636epoutp011b223fad33b7651350ca4781815a3cfb~aPxj5Ox5t0876508765epoutp01D
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191125000636epoutp011b223fad33b7651350ca4781815a3cfb~aPxj5Ox5t0876508765epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640396;
        bh=cebDS4wJnJkhFo4uYCXo0DH3otueb9YFlYeYEY3vVQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTVHdummgQG0/n3k3L2dPWNFe98aWXy2+s+DqFw5wi07Sc+XWIxTQlaFi5QX/XQsy
         Q6Ifw/JAP4ISeGKVfsUrA41iNRJ7RIQmYNfUCmUhmjeDF7wXjdqxDOoiP1gOMrGJN4
         xvIxT2DSueu8HJT4aEg4TfWU2p5dIEtJhO+9C61U=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191125000635epcas1p14215333a8f23834ce76efe627abe66e6~aPxjSbKl30808008080epcas1p1D;
        Mon, 25 Nov 2019 00:06:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47LnQ30FHCzMqYkp; Mon, 25 Nov
        2019 00:06:35 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.32.48019.A0B1BDD5; Mon, 25 Nov 2019 09:06:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000634epcas1p2e99dba9fd777b57618bb57bf9fa44c53~aPxigVeVc0156901569epcas1p2V;
        Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191125000634epsmtrp1ffee81abec10a18ab5d57d4fad84a828~aPxifnbjA2803828038epsmtrp1Z;
        Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
X-AuditID: b6c32a38-6b4789c00001bb93-b4-5ddb1b0a0ddf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.11.06569.A0B1BDD5; Mon, 25 Nov 2019 09:06:34 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000634epsmtip24113a61532f652adfd671405686cf1b4~aPxiWbuyf2000720007epsmtip2a;
        Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 13/13] MAINTAINERS: add exfat filesystem
Date:   Sun, 24 Nov 2019 19:03:26 -0500
Message-Id: <20191125000326.24561-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7O5stPqbWh0LZgaCM6U5z81Suooscyh9Cf8IQPc3DJu3G
        zhQrKqlYsmLaXbxkFF3U0pXD1BRDK60o0Mp7BUVaJnY30dC2nUX9e77nfZ73eXm/l8RUXiKG
        zLW5eKeNs1CEAm/sXJmgVsQOZ2quvE1hOt+dkjFHLtcTTHXtAwnT/2oIY1rbHuHM85YKgpkv
        G5My0+cPMfMTR3HGP3dfyvR+/oJvjGCby17J2PbKGzL27mAhwXr9NYCt97/E2YYn+9nvt5ew
        HXcmCHZ4tBFPl2dYUsw8l8M743ib0Z6TazMZqO07sjZn6fQaWk2vYZKpOBtn5Q3UlrR0dWqu
        JTAsFZfPWfICVDonCFTi+hSnPc/Fx5ntgstA8Y4ci4PWOBIEzirk2UwJRrt1La3RrNYFlNkW
        8+GrsxLHlLTAfbUbFIJCqQfISQSTkG9gRBbEKtgEUM0jygMUAfwNoKr7Xbj4mAKooqRG8tfR
        fPZZuNAG0BWfVyLaA5axMykeQJIEXIV++6ODdBTcgBrK74X0GOwHaHSoNBQdCdeh0rmfeBDj
        cDkq9nhDWAkNyH3qFhDDlqJa3z0siOUBvvtxIxZshGA/gcaOf5KJoi1osm42bIhE413+MB+D
        Pha7ZcGBENyPvrZjIl0E0IdfBhFr0WC9TxqUYHAlqm9JFOllqHm2MtQRgwvR5M8TUrGLEhW5
        VaJkOfL2doZXEos8x76EQ1l0rvo6Ia6nBCDPp1asBCwp+5dwEYAasIh3CFYTL9COpP//6zYI
        3WI80wRan6V1AEgCaoHSd3MoUyXl8oW91g6ASIyKUqY+HchUKXO4vft4pz3LmWfhhQ6gCyzy
        JBYTbbQHLtvmyqJ1q7VaLZOkT9brtNRiJTndk6mCJs7F7+F5B+/865OQ8phCoJ6d1E/0dxU9
        fvi6+HkT3IRP6UeijUMwdtePp+NrXiiqPBGSeVOsIhLsLJ+Z+d6bbPqWrKYLdl+WjpxueX+t
        Dm41VLVP9KW70+Q7dfwwvq02e9pw5JK37MWBgZd0n7JnxYV90Lgq8c1c0UF9j7fuZOn04vMz
        lmrzZHeq/etwBoULZo6Ox5wC9weyTKQHoQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvC6X9O1Yg32tWhaHH09it2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLP7Pes5q8WN6vcX/Ny0sFlv+HWG1uPT+A4sDt8fOWXfZ
        PfbPXcPusftmA5tH35ZVjB7rt1xl8dh8utrj8yY5j0Pb37B53H62jSWAM4rLJiU1J7MstUjf
        LoEro2nZb6aCb6wVbctOMDYwNrB2MXJySAiYSOyceo6li5GLQ0hgN6PEruftUAlpiWMnzjB3
        MXIA2cIShw8XQ9R8YJTYcH4rK0icTUBb4s8WUZByEQFHid5dh8HmMAs8ZpQ4cf4JI0hCWMBa
        Ysa/rywgNouAqkR/Vx+YzStgK9E2aSMjxC55idUbDjCD2JxA8ROntoHZQgI2Eu2HjrJNYORb
        wMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOIC1tHYwnjgRf4hRgINRiYeXY8Ot
        WCHWxLLiytxDjBIczEoivG5nb8QK8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKa
        nZpakFoEk2Xi4JRqYJzeXOAur3c1Ic1MYqcS73OJyy9rv2uVGe5gTWas+qR3MXtNuondztlv
        Yz7c7GWbdFV68s0o40u7a6fV77Av7q7MYje617rjqcmuIuWpSX8uWbf6BXO3cSiu7re/cm36
        dGEWrcI9Dq8bf8Tf6D3P/Mxjxpxd+890a23aLf16jqZPtxJrncDONCWW4oxEQy3mouJEAFue
        kZJcAgAA
X-CMS-MailID: 20191125000634epcas1p2e99dba9fd777b57618bb57bf9fa44c53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000634epcas1p2e99dba9fd777b57618bb57bf9fa44c53
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
        <CGME20191125000634epcas1p2e99dba9fd777b57618bb57bf9fa44c53@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself and Sungjong Seo as exfat maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d61ef301811..41a69751840c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6215,6 +6215,13 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
+EXFAT FILE SYSTEM
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sungjong Seo <sj1557.seo@samsung.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/exfat/
+
 EXFAT FILE SYSTEM
 M:	Valdis Kletnieks <valdis.kletnieks@vt.edu>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.17.1

