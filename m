Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9C315A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 01:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhBJAB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 19:01:27 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51156 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhBIXvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:51:38 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210209235048epoutp01acb5e93537ff39ae33c23021edc44eae~iOVPgOjG50994909949epoutp01C
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 23:50:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210209235048epoutp01acb5e93537ff39ae33c23021edc44eae~iOVPgOjG50994909949epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612914648;
        bh=Yfwyv25XMm32QG1IHtSFUvcYQNNR9BBObeWhcnK1FCE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mBCKeIcQftIcOcMfaFYXqKRNaxVppqgWmVeNXwPiU60Nfu5vlou+TCaA2OkKvxPYW
         kA+QhaTDHtvSxNosCSHBI8/jaH51Ar0+x1BLIax2FwiFxj3Fd1npcORUB10JeN7K1X
         IzyY2c7y7ZGxfX/ACmSqCRMiEGB0u3xNvKif2AJI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210209235048epcas1p19b606a3e69e8905ca6a3276bcfd68f04~iOVPEr4Uw1737417374epcas1p1P;
        Tue,  9 Feb 2021 23:50:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Db05M4DPSz4x9Pt; Tue,  9 Feb
        2021 23:50:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.B6.10463.7DF13206; Wed, 10 Feb 2021 08:50:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2~iOVNn36Ao2430624306epcas1p14;
        Tue,  9 Feb 2021 23:50:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210209235046epsmtrp2f14ae2e2ca7328098069b18083a2fb3e~iOVNnAAeB1241312413epsmtrp2j;
        Tue,  9 Feb 2021 23:50:46 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-8f-60231fd77323
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.12.13470.6DF13206; Wed, 10 Feb 2021 08:50:46 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210209235046epsmtip287ac00e030c4c6178459d4aaf99f55b1~iOVNXNVy80642306423epsmtip2L;
        Tue,  9 Feb 2021 23:50:46 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Cc:     "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Goldwyn Rodrigues'" <rgoldwyn@suse.com>,
        "'Nicolas Boos'" <nicolas.boos@wanadoo.fr>,
        <sedat.dilek@gmail.com>, "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Luca Stefani'" <luca.stefani.ge1@gmail.com>,
        "'Matthieu CASTET'" <castet.matthieu@free.fr>,
        "'Sven Hoexter'" <sven@stormbind.net>,
        "'Ethan Sommer'" <e5ten.arch@gmail.com>,
        "'Ethan Sommer'" <e5ten.arch@gmail.com>,
        "'Hyeongseok Kim'" <hyeongseok@gmail.com>
Subject: [ANNOUNCE] exfatprogs-1.1.0 version released
Date:   Wed, 10 Feb 2021 08:50:46 +0900
Message-ID: <000001d6ff3e$62f336d0$28d9a470$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adb/Pa6th4yELZeSR5GVSDSMGqBObg==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmvu51eeUEg7l/5S0+3+xlt+g88pTN
        4tr99+wWfyd+YrLYs/cki8XlXXPYLP6tb2a3aDh2hMWi7e8uVovWK1oW66aeYLF4veEZqwOP
        R/+6z6weO2fdZffYsvghk8fEH9PYPNZvucri8XmTnMfnu+tZA9ijcmwyUhNTUosUUvOS81My
        89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5VUihLzCkFCgUkFhcr6dvZFOWX
        lqQqZOQXl9gqpRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZHTueMRSMIetYt7Dw2wN
        jO2sXYycHBICJhKTdj5mA7GFBHYwStxu8u5i5AKyPzFKzJr3nxnC+cYoseTkC7iOTZ9XskAk
        9jJKdM2/zgrhvGSUmHDxIDNIFZuArsS/P/vB5ooIJEvse72fEaSIWeAcs8SeM7PAEsICphJL
        F39jAbFZBFQlHq1/AxbnFbCUeLHyFSOELShxcuYTsBpmAXmJ7W/nMEOcoSDx8+kyVogFehLb
        1zezQdSISMzubAO7W0JgC4fE6+ZTTBANLhK3eptYIGxhiVfHt7BD2FISn9/tBWrmALKrJT7u
        h5rfwSjx4rsthG0scXP9BlaQEmYBTYn1u/QhwooSO3/PZYRYyyfx7msPK8QUXomONiGIElWJ
        vkuHoQ6Qluhq/wC11EPi8sfFrBMYFWcheXIWkidnIXlmFsLiBYwsqxjFUguKc9NTiw0LTJAj
        exMjOBFrWexgnPv2g94hRiYOxkOMEhzMSiK8zjOVEoR4UxIrq1KL8uOLSnNSiw8xmgKDfSKz
        lGhyPjAX5JXEG5oaGRsbW5iYmZuZGiuJ8yYZPIgXEkhPLEnNTk0tSC2C6WPi4JRqYMpc9TLU
        oLNmnnzXojRxmfqnPIwrxBIkuo29mkKYb1y7svl28y+967z1dnO9zrXmssf++ZF3+sTbTULl
        7t8U1EvXTku4lbDxXNvaXIVKvk/aSeaZmXvLXSv6LzbE9YbNE3hnoMZgdv3NO9tjnHMDNqze
        nb9qQWvkHXH7QMMb9+/FRi2PMLBx3299SNZsX5iP4PGIK4dvrHq1b+7G0qrwohXx/XVWPpPi
        AtzC7L11Z39YkDqzfqvPp/u/HyhH1vfymjBvOaCzl2NJgItsjblesfrT7fZynoUcudfZJiq+
        mWnlqSN46uj1GLZs+X3/brAvO7JW5tJUcbUNb9gkhJwu5VVJXnCZnDs1+KHsxD1GSizFGYmG
        WsxFxYkA2Z54wU0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXveavHKCwb0X+hafb/ayW3Qeecpm
        ce3+e3aLvxM/MVns2XuSxeLyrjlsFv/WN7NbNBw7wmLR9ncXq0XrFS2LdVNPsFi83vCM1YHH
        o3/dZ1aPnbPusntsWfyQyWPij2lsHuu3XGXx+LxJzuPz3fWsAexRXDYpqTmZZalF+nYJXBmd
        Ox6xFMxhq5j38DBbA2M7axcjJ4eEgInEps8rWboYuTiEBHYzSly79IURIiEtcezEGeYuRg4g
        W1ji8OFiiJrnjBIHb29nB6lhE9CV+PdnPxuILSKQLLHv9X5GkCJmgWvMEnevQiSEBUwlli7+
        xgJiswioSjxa/wYszitgKfFi5StGCFtQ4uTMJywgy5gF9CTaNoKFmQXkJba/ncMMcY+CxM+n
        y1ghdulJbF/fzAZRIyIxu7ONeQKj4Cwkk2YhTJqFZNIsJB0LGFlWMUqmFhTnpucWGxYY5qWW
        6xUn5haX5qXrJefnbmIEx5eW5g7G7as+6B1iZOJgPMQowcGsJMLrPFMpQYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamAvHUAmvpDYHSpWesHX2/atay
        LHh98pHri62ONrIPpy4vmfdIK6W7/18/f+apbenikV85itOLU22n5lv6m5ouj8g7Frpu1SQr
        Wd91n1bzWJmtrgye0Zu016nH/WfsISX2+3Kb77YnBcsKOgmslSzoO6nT+LNv0+awTTzai7UO
        KKWvcooxnJTxSvPX0h394i955uzk77mr+07itS8z8xGDpqtb81/xTrtZkpToqGNXEMG6+3Gz
        wjy2w+551XH3+7dryV5/fuF2UZttz8NNyrt/8cas1mthO5Zpnrx322vpjqlTPi75tvpWz6fb
        tcX+Wpc8uBbekb711IL/+4W4mz/d756Kub3v2f4D2/tXWnAosRRnJBpqMRcVJwIAqbxScx4D
        AAA=
X-CMS-MailID: 20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2
References: <CGME20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folk,

We have released exfatprogs 1.1.0 version. In this release, exfatlabel
has been added to print or re-write volume label and volume serial value.
Also, A new dump.exfat util has been added to display statistics from
a given device(Requested by Mike Fleetwood(GParted Developer)).

Any feedback is welcome!:)

CHANGES :
 * fsck.exfat: Recover corrupted boot region.

NEW FEATURES :
 * exfatlabel: Print or set volume label and serial.
 * dump.exfat: Show the on-disk metadata information and the statistics.

BUG FIXES :
 * Set _FILE_OFFSET_BITS=64 for Android build.

The git tree is at:
      https://github.com/exfatprogs/exfatprogs

The tarballs can be found at:
      https://github.com/exfatprogs/exfatprogs/releases/download/1.1.0/exfatprogs-1.1.0.tar.gz

