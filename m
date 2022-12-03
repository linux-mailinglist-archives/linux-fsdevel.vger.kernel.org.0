Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC796411E5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 01:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiLCAUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 19:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLCAUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:20:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1781F1160;
        Fri,  2 Dec 2022 16:19:59 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2MNt36023463;
        Sat, 3 Dec 2022 00:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Q8oG30xHJmPlPya/zpHEcDY41P0h/jb/oJ3c3SnxwFA=;
 b=HWxQHtqYNz/PzqvOLdUDzyZO4tVnu68pqJmvdzR7asbWvMYuvjp6J4dbz7ONlqgVKKox
 kp600jPqCS+ozXTf462lwkTXhsttgRcW4aGq7/0FIK5KKDLF08Jp6c9Z/2XtEiNWmmsE
 Me2TQlJulwgiPffW+b+d7b+AWloeKXzlxrajHTuEsBssY5vEflOJpevKXYd9VGbpPl2o
 w95+I9vRB218N0BkRGowUKN/t2CQ9Y07M1TmgkoddYiaVvNaWS2y0/fyHT6uQIv12xzP
 SANZ/b1UQK0HjJz8++T1km4qQd1o5Rq8mdheG7qQkOiVN0dp+JuseO/VMwfTYMPDAtsK Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m782hb0h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Dec 2022 00:19:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B2NNig3003235;
        Sat, 3 Dec 2022 00:19:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398dhe28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Dec 2022 00:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo8mfhyukSUe15W2PSLC14Q7BrOFfgaM1bSy/rYPcoY7bnZrMMHld6lF99CjLWbXmhoTQuPvZsl92zqfXgajJL4m2tWnpvlOcFqJeVXlv4lPCdKaXQt/g35y1H3YEiENvoZcJmTafCuyLUL20epS/s6pdPxJpW/coAaVpAaVTgPy6TpijNRYMaIpDafW/A7AmQF2KfVc0XTnLRd4bYN/5sFszHMVv4VH/4Qw7zp2tIuObs9goXDlO8VHyo4mBlsamoENWWoPUUZSI7vVNDkgSAXOngn3sXAdLvGF49N4CBufkb6P82sDNatCKVCE2qeYQmQIULfKslAtjFP9feRvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8oG30xHJmPlPya/zpHEcDY41P0h/jb/oJ3c3SnxwFA=;
 b=VBugp0/KXYaRR1remlToThekVoBosKWemvRAys3ZRsPS8FYPGZAziBWtgoisTKdqHt0BGIDaLC6AQxRVxHha5/veib/jLhASAj+WcRx56cHRvZcTBsb3HPpGaAomKVthLnv3naIriViEbvLlh6+8tQWpm1jyJRbFhiAsSPMHAA6rFgieVG3sCyK7/a+4Yyavp+U2sEcrrJ0OuDMbLyhptjHH54owkHXpTDSb+HTaaW5GlCbNsQVguRac8ZvVo+0WHXh5gMTp2LwNS2uPSkjRVitasM0Gmgt6K3luFnHqh22CEtbAreV5Seo4qVGIT7LgdNcdMOpkKCMJ2DqS1wIUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8oG30xHJmPlPya/zpHEcDY41P0h/jb/oJ3c3SnxwFA=;
 b=nGU8S0wxW2eyNLsQI1JV6K8rvpRfAu6OMmY4NF/tXILvgTPyqHeOXJXUW47N+mvgMaR8gqpWHAHXawfh+asTgZKCWhlvGC7gOhvM55tCBzANF3DgOCdz7x2qeuu0DFU9kgtOeRIc6AJKwT6MAAcOSPtOtdLRt+wcbufBOKYmPJw=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by IA1PR10MB7385.namprd10.prod.outlook.com (2603:10b6:208:42f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Sat, 3 Dec
 2022 00:19:45 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::3cab:6ff7:cb4d:b57c]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::3cab:6ff7:cb4d:b57c%4]) with mapi id 15.20.5880.010; Sat, 3 Dec 2022
 00:19:45 +0000
From:   Allison Henderson <allison.henderson@oracle.com>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2.1 1/8] fsdax: introduce page->share for fsdax in
 reflink mode
Thread-Topic: [PATCH v2.1 1/8] fsdax: introduce page->share for fsdax in
 reflink mode
Thread-Index: AQHZBi/uwefsY7fJSkScPIsJaDvL465bTYGA
Date:   Sat, 3 Dec 2022 00:19:45 +0000
Message-ID: <289c34d1e1482660f06e0a558a1983990a2f6bbf.camel@oracle.com>
References: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
         <1669972991-246-1-git-send-email-ruansy.fnst@fujitsu.com>
In-Reply-To: <1669972991-246-1-git-send-email-ruansy.fnst@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|IA1PR10MB7385:EE_
x-ms-office365-filtering-correlation-id: 5c1e9c3a-c76f-4894-a9c6-08dad4c414f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xhw3Rd/M4nGeYqWpY3S6cznRLmwBziHR9iL6kgp3oB3XVSIfBvxRWCWhIoBz0r/7Wz/OfuakaFUIgiytgeo0IU3xDyCrdpd0xt2d4dhn1kzrgLWTq5bGphPBGc4u5zZWF71hZpsgIJFM34rl1M+xWYBXyh/MvscbAYAlgC82MODxQWR6v8yqocuIFmsF9QwgwlSXTbEhQhoBu0TlUETgpAb8FtEP/iLDdj/o+CrV4DODi6yvy2HMn4eu95fqRo2d6O+ho20qwgeDKM2mFtSus4kvKQBsQ7CHwvE7+m+S6FBEF7Dn44JpCOgsCr/NvXdX/rUPz5tPkHTQNVBbjY6txuekgplZJ2f4bfoaSxTnyLxqFdFoUmnoHUK1pBrhwpMiMmw9bUNHJGfUb72zzJrjiHM18n5AwLmlLuoOYckZF6M/ccH0U+Q70gPrTOkGxhoiXNXPKa5xfSMVtZ7lx7J+/IP6FiYGvmNulDeDQW+boZOAJ+aZoZX/JCCnGF1s2e1pXrK8aPvRCOrPNh9zu9dD4iuFeEUVcNq4l9cGZv+PuCQ7aaKqZoSzZ4Ftohd7Nb84Rfsem4B66765HiMxqclF3EqG1jsPfflLJuYv5jXP72jQDnkzSJJ3yh7FLvjzsa5jj9Hvbt/b+HnDRXsJizRBIcyIWd9H98gColt7l+uOGjnMDa4G9Yv8l48UC2TndMl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(6512007)(26005)(316002)(54906003)(110136005)(8936002)(36756003)(71200400001)(41300700001)(6506007)(5660300002)(38100700002)(122000001)(83380400001)(2906002)(38070700005)(4326008)(44832011)(2616005)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(8676002)(186003)(76116006)(478600001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGU4VmtUY3RxM0tnOHU3b2ZNOVFYVmdXTnArZTM1bEJzNzNaU0VHaTh6NFQx?=
 =?utf-8?B?R1grb0JnZ25nUTYvall0QWI2NWZIbjBMTHVBZEpkUFNEL2pZanJhWDhueldj?=
 =?utf-8?B?bnNiL0RRQ3NBWjJndk5FdzVtL3k4OWcybDZnd0hDaG5RZzdlRUlWbXV2UlBF?=
 =?utf-8?B?RnZaVGZXL2MrS1RyU3JDcGI4TjhnMldubDBQbVdscm9BMnBnc0pOckZjNmgv?=
 =?utf-8?B?SThvWjVFMTJCNEZiVGwxUHNFUVp1RTJjcWhGU0RZdlY5RzVITHc0VlEwTENM?=
 =?utf-8?B?L2pHTzl4bEJuQkhRc0Q2ZEFpNUpBdk1RZVgxL1FhU3Y2Yjk3dXhKU0F5T2Zi?=
 =?utf-8?B?dVdnSWNhWkZCYUErVDNwYUd1ZEhubWtHUDlEMkNHRUdRbk5nRjdLaFF3cHVU?=
 =?utf-8?B?a0QxWjRWQzJhYWtvMi91aU5mKzFWV08yU1dzNXlqNjZ0L1QyNXN6TVY2eXNx?=
 =?utf-8?B?c1lmQjltK1F1SGhDNFlmL3JsU21tQVRjK0lKK3p1d01Ic0pHZDhEaW1KTEdq?=
 =?utf-8?B?cDhnaGZGREVRTnRCeitaSDlxT2hKZk1SbTZwVVk3anVyamFXR29mdWg1dlA2?=
 =?utf-8?B?NlNRRkE3dDRmY3hBanFoSEdpMERvOTJWVzM4QzdKQUZpWStKMDkvRXBxcnNB?=
 =?utf-8?B?QjFtZ2xSbll5YTNna1l4WWViSDFsMnJYMjVBdXpWRlN3RklQRW9qVVZUVnFZ?=
 =?utf-8?B?MFB4ZUUwZVh0SUY1WmhzMFRnQ0tVeUdTWVdtRzViT0lGZUw5S1dRTUNjbVdR?=
 =?utf-8?B?WkhHaDljYzdoZzcvRzd4bVNhdmgzS2YybzRyL3JoZmV1NU1OR2djby9haFpG?=
 =?utf-8?B?azhQalRSNmUyUnpRNXYwbEluTVVUK05WeGg2YWlOWTJKSm9BYU5tc2hRMWhl?=
 =?utf-8?B?cXM3QzN5Y09vTFFWM0VEeWlBVHU1R3FwcGNMeVhNcXd2b200WGU1ajdXeHBp?=
 =?utf-8?B?b2EyQ1JQelpvaWw4RnA5Y25yQTdvVDZYNWhFd2g5dGFDejljMlZwWHU1SVZu?=
 =?utf-8?B?RUpodyt0M3ZxRDBxSm84U2xvSngrRzdEQTNtUTd1Z0NKUGl5TUh5MHViVTda?=
 =?utf-8?B?cjRwM3dpdy9FRXNvZlJXb1BqcTRzZTE0Y013dE5BNGVJMDdyTGkwbE1iTTdH?=
 =?utf-8?B?TUFrTDlsMEYwRlp5Wm0rbjlaS0p4YkhaLzN4bFN4aWh2T2dqeER6ZW5kazdv?=
 =?utf-8?B?MmxpNWY5MnZ1eEJibDU5dlltM1ZobWZ5UnJXUHdlUm1LaUdNNE9UWFVqS3gx?=
 =?utf-8?B?RngwT3hPRGx1UmRBQkQ2VzZjOGlweitjUmlEQmgyZDB4bEFPenhMYWNlWGkv?=
 =?utf-8?B?MTBiWTFqSXo3bU1CSlNTWXBnTzUzV0wzZk51ejNBY1ZqOUdIWkdFM082ZUph?=
 =?utf-8?B?Q01pMVNJeHdwa2NQR2MxQUZ2c3hySXhaZVF3aEZXR3laVENncVZHY0JnSjlo?=
 =?utf-8?B?a1Nodjd3eEpJN3RIK0RJMjM5SWZBVkc4aXNrbVp3UXEzaGJmUm1KMXdsa3VY?=
 =?utf-8?B?M0FPN0Z3NStEU3hqODhuYU5rOHVQbjRXY0ZOZkF3YWJHRUthN2FVcHVqNTR4?=
 =?utf-8?B?YkRwUzBDZlV3bVpEbnlQeTJpdnptUG1ueXBZZG95eTVzOFZkcFJFSzJ4b3I3?=
 =?utf-8?B?eUpOWnFTbmFmWTdUUzdtYzRKMDEzQnduUi9YenlPWnI0K0JVTlF5L2NHUWJp?=
 =?utf-8?B?aWFzYkw3M3BDdTM1Zzg3RThwZDFQdzhtckkyMlBmQkhBWm1xNEtuM1RrWTdx?=
 =?utf-8?B?aHJFdHE3UDVkK2I4TzJjbzd4VUNjK0V6Q0k4aGc4RmtOd2gxRFM3WVJUaGoz?=
 =?utf-8?B?RU9HcjZlTXUyOWNMaTRCa09sK0dmemIwNU1QTmdST21naTFDYVpURTNLRUg0?=
 =?utf-8?B?RUQwalpvaEgwVDJCUUcrbWM0a3FIa3pLUjdVdE9SK2dhYnFYazllbWtxcHdX?=
 =?utf-8?B?Q2lpUFFNSlU0d1l3TmoyQmZ1azFpeFNJMW5YamMyalQ5SUZHcG50cFdCU294?=
 =?utf-8?B?RVZhemdIUGEyakFOZWlzc2JoVlptdE01Uk5BSzJqc0E0MlVGRjNqVlJNUndY?=
 =?utf-8?B?ek9lQ2puZ3N5QVJ2NlpyUTZRQ2tRSFdyaGc5Uk9BM1FBYjR2UUw3aTdMMktC?=
 =?utf-8?B?R1FKTEFLZHdUeERQK29aRTNIb01GNW5yMXl2NXV6cTJzd1hXRTE1MGh6UE1a?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57A2F465C5038F40BC0A20D9E46F347E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aTJ5RXJMMEpQTWphZUlzbmlCc3M2Ymo2Y2QzUkJwOHhROVd5TEg3UGN3dThH?=
 =?utf-8?B?dDVzYlFZNDcyV3RMWjhMRVEvMnkxR0lHM0IzNXUyMENLRG1nMjEwWDdXNUhh?=
 =?utf-8?B?VUVwTXdNZWJLQjA2MThIeHRQbzdFTUFDcTV2NzFtTERhSGJVb2N3OGpIQ0hw?=
 =?utf-8?B?TGgvUGcxN3dURURFU2dlcXg5eHE5NktDN0U4cHBYa1VrSENneS9aaXprZWsy?=
 =?utf-8?B?TzM3S2E0aWRLNGNoZnNtckE1dFhVRmE5akxDNitQcnl4eUFoSDUrcytCWkg5?=
 =?utf-8?B?SkVLaTZGNk9MSHhqM1F2TzJQcEtDTGs2ZlIyY3RxdkkydDFHMnIvREw3VktE?=
 =?utf-8?B?UlBlbFRQZXFQNXNtWjhVQ053b0Njb3A5S3A5Z1dBa3docldZaUF5NDBsNU9u?=
 =?utf-8?B?SGhNZTJEUG9xNnc0Vm9hcVZhNHkzUFEwWkRBU3k5Z0J3TVk0VG9wRWpvU2NL?=
 =?utf-8?B?V3B5a2psbWxUZHB5NEJuWHRNK2pYalZ2bmJHTm5QSWhUNUpiRUkydGVHZnRY?=
 =?utf-8?B?M2VNRG1ybWNSWUJ3T0xYa3JFNjExYXhQYi9OaFlRcnJRelE5blNheGF5VXJF?=
 =?utf-8?B?eE5SZG12ejkzVFRhVVRCUmN4UUZiVUhGVytqOXpoVWYxYk9NQVZDZE1OWEk3?=
 =?utf-8?B?djQyYk9GZUQ1M0oyV29aeHpqdGZ0UE9nWGNLbnFkR2dTWVhqZURQYStsbC9O?=
 =?utf-8?B?bDJJdnlDaUJ3N1ZaTmxhRjJLYWh6K09jNDFDUDZTQzUvVkxXdFBjTzFtZEk2?=
 =?utf-8?B?Q2xNeDlzNCtLY29Oekh4dWk3d1lpbkZSaGdGQ3FDZHVtQzh6YUFkcmtpY25Y?=
 =?utf-8?B?ZlZXUEdyS2gyZDJ5cDFwWUp3TXBkb0ZQRDUwUm4vTG13VTN1NHdudXN0MVFE?=
 =?utf-8?B?bFhLcE5IeWpYVjhNYk4xU1FrVHRGM2c5aGdFRzVwSUdMOVJsTFVhZExDMkVP?=
 =?utf-8?B?VzVSZUN3TjhHWjFqcFRrczljbHdFRS9mUmFSTXBzREFxaUp5ZGhCamFlaHdD?=
 =?utf-8?B?ai9YS0N0M0xBbU5vd3YyMUd5SkU1UVp1bnhqQTh1bXRyK0RVOElJWUNoY0NI?=
 =?utf-8?B?RUhlOGd4OU90R0oxUkxoMEgxS2JKUHVtQjgwOUFsK1ZxRGlaRngwVTlQang1?=
 =?utf-8?B?ZnBXOXNiNk9YZ293TGdNZ3NPK0s3d05hNkFYb3lENllMTXpWZkdIQy9STSt0?=
 =?utf-8?B?Nk4vaTZXZ3ZjTjdDT0M2MkdoamxJSThYREdaS29iR2dzK1g3Ym55WHZDUHd6?=
 =?utf-8?B?Skg3Q2JMVmliRnRqNG5QaTR3L2U5MFVqblFzV1BtSmFLSjhPWWFzNFQ3WllP?=
 =?utf-8?B?SWFZUGJzZE41c09VcGo2N1JyOUhHK3d1Nm92ckdLWXNTa2RqbCtjQWwzanN3?=
 =?utf-8?B?Z0pabHdmRVJSSEZaOW5pKzlFSGVPRUpPUjRsRkR4YWhzY2NoY3dsMFM5NWlW?=
 =?utf-8?Q?4H4TjSnr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1e9c3a-c76f-4894-a9c6-08dad4c414f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 00:19:45.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sskTBhLtSMc7nWB7i8sAW5mDfPRwshHC2hzz8FkD1H7qYho5ZyK+UQtcLb1Go4GKKbeCdpW9gdIZJhVjILYDCdNxzCfnrT5uL85yPjXkZm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212030001
X-Proofpoint-ORIG-GUID: Mg-w_Wcdiv6WFYhSxMQeFj6JXUezMerx
X-Proofpoint-GUID: Mg-w_Wcdiv6WFYhSxMQeFj6JXUezMerx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTAyIGF0IDA5OjIzICswMDAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6Cj4g
ZnNkYXggcGFnZSBpcyB1c2VkIG5vdCBvbmx5IHdoZW4gQ29XLCBidXQgYWxzbyBtYXByZWFkLiBU
byBtYWtlIHRoZQo+IGl0Cj4gZWFzaWx5IHVuZGVyc3Rvb2QsIHVzZSAnc2hhcmUnIHRvIGluZGlj
YXRlIHRoYXQgdGhlIGRheCBwYWdlIGlzCj4gc2hhcmVkCj4gYnkgbW9yZSB0aGFuIG9uZSBleHRl
bnQuwqAgQW5kIGFkZCBoZWxwZXIgZnVuY3Rpb25zIHRvIHVzZSBpdC4KPiAKPiBBbHNvLCB0aGUg
ZmxhZyBuZWVkcyB0byBiZSByZW5hbWVkIHRvIFBBR0VfTUFQUElOR19EQVhfU0hBUkVELgo+IApU
aGUgbmV3IGNoYW5nZXMgbG9vayByZWFzb25hYmxlIHRvIG1lClJldmlld2VkLWJ5OiBBbGxpc29u
IEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xlLmNvbT4KCj4gU2lnbmVkLW9mZi1i
eTogU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5zdEBmdWppdHN1LmNvbT4KPiAtLS0KPiDCoGZzL2Rh
eC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMzggKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4gLS0KPiDCoGluY2x1ZGUvbGludXgvbW1fdHlwZXMu
aMKgwqAgfMKgIDUgKysrKy0KPiDCoGluY2x1ZGUvbGludXgvcGFnZS1mbGFncy5oIHzCoCAyICst
Cj4gwqAzIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9mcy9kYXguYyBiL2ZzL2RheC5jCj4gaW5kZXggMWM2ODY3ODEwY2Jk
Li5lZGJhY2IyNzNhYjUgMTAwNjQ0Cj4gLS0tIGEvZnMvZGF4LmMKPiArKysgYi9mcy9kYXguYwo+
IEBAIC0zMzQsMzUgKzMzNCw0MSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBkYXhfZW5kX3Bmbih2
b2lkICplbnRyeSkKPiDCoMKgwqDCoMKgwqDCoMKgZm9yIChwZm4gPSBkYXhfdG9fcGZuKGVudHJ5
KTsgXAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBm
biA8IGRheF9lbmRfcGZuKGVudHJ5KTsgcGZuKyspCj4gwqAKPiAtc3RhdGljIGlubGluZSBib29s
IGRheF9tYXBwaW5nX2lzX2NvdyhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZykKPiArc3Rh
dGljIGlubGluZSBib29sIGRheF9wYWdlX2lzX3NoYXJlZChzdHJ1Y3QgcGFnZSAqcGFnZSkKPiDC
oHsKPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gKHVuc2lnbmVkIGxvbmcpbWFwcGluZyA9PSBQQUdF
X01BUFBJTkdfREFYX0NPVzsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gKHVuc2lnbmVkIGxvbmcp
cGFnZS0+bWFwcGluZyA9PQo+IFBBR0VfTUFQUElOR19EQVhfU0hBUkVEOwo+IMKgfQo+IMKgCj4g
wqAvKgo+IC0gKiBTZXQgdGhlIHBhZ2UtPm1hcHBpbmcgd2l0aCBGU19EQVhfTUFQUElOR19DT1cg
ZmxhZywgaW5jcmVhc2UgdGhlCj4gcmVmY291bnQuCj4gKyAqIFNldCB0aGUgcGFnZS0+bWFwcGlu
ZyB3aXRoIFBBR0VfTUFQUElOR19EQVhfU0hBUkVEIGZsYWcsIGluY3JlYXNlCj4gdGhlCj4gKyAq
IHJlZmNvdW50Lgo+IMKgICovCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBkYXhfbWFwcGluZ19zZXRf
Y293KHN0cnVjdCBwYWdlICpwYWdlKQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgZGF4X3BhZ2VfYnVt
cF9zaGFyaW5nKHN0cnVjdCBwYWdlICpwYWdlKQo+IMKgewo+IC3CoMKgwqDCoMKgwqDCoGlmICgo
dWludHB0cl90KXBhZ2UtPm1hcHBpbmcgIT0gUEFHRV9NQVBQSU5HX0RBWF9DT1cpIHsKPiArwqDC
oMKgwqDCoMKgwqBpZiAoKHVpbnRwdHJfdClwYWdlLT5tYXBwaW5nICE9IFBBR0VfTUFQUElOR19E
QVhfU0hBUkVEKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogUmVzZXQgdGhlIGluZGV4IGlmIHRoZSBwYWdl
IHdhcyBhbHJlYWR5IG1hcHBlZAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
cmVndWxhcmx5IGJlZm9yZS4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHBhZ2UtPm1hcHBpbmcpCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYWdlLT5pbmRleCA9
IDE7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhZ2UtPm1hcHBpbmcgPSAodm9p
ZCAqKVBBR0VfTUFQUElOR19EQVhfQ09XOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcGFnZS0+c2hhcmUgPSAxOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwYWdlLT5tYXBwaW5nID0gKHZvaWQgKilQQUdFX01BUFBJTkdfREFYX1NIQVJF
RDsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IC3CoMKgwqDCoMKgwqDCoHBhZ2UtPmluZGV4Kys7Cj4g
K8KgwqDCoMKgwqDCoMKgcGFnZS0+c2hhcmUrKzsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB1
bnNpZ25lZCBsb25nIGRheF9wYWdlX2Ryb3Bfc2hhcmluZyhzdHJ1Y3QgcGFnZSAqcGFnZSkKPiAr
ewo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiAtLXBhZ2UtPnNoYXJlOwo+IMKgfQo+IMKgCj4gwqAv
Kgo+IC0gKiBXaGVuIGl0IGlzIGNhbGxlZCBpbiBkYXhfaW5zZXJ0X2VudHJ5KCksIHRoZSBjb3cg
ZmxhZyB3aWxsCj4gaW5kaWNhdGUgdGhhdAo+ICsgKiBXaGVuIGl0IGlzIGNhbGxlZCBpbiBkYXhf
aW5zZXJ0X2VudHJ5KCksIHRoZSBzaGFyZWQgZmxhZyB3aWxsCj4gaW5kaWNhdGUgdGhhdAo+IMKg
ICogd2hldGhlciB0aGlzIGVudHJ5IGlzIHNoYXJlZCBieSBtdWx0aXBsZSBmaWxlcy7CoCBJZiBz
bywgc2V0IHRoZQo+IHBhZ2UtPm1hcHBpbmcKPiAtICogRlNfREFYX01BUFBJTkdfQ09XLCBhbmQg
dXNlIHBhZ2UtPmluZGV4IGFzIHJlZmNvdW50Lgo+ICsgKiBQQUdFX01BUFBJTkdfREFYX1NIQVJF
RCwgYW5kIHVzZSBwYWdlLT5zaGFyZSBhcyByZWZjb3VudC4KPiDCoCAqLwo+IMKgc3RhdGljIHZv
aWQgZGF4X2Fzc29jaWF0ZV9lbnRyeSh2b2lkICplbnRyeSwgc3RydWN0IGFkZHJlc3Nfc3BhY2UK
PiAqbWFwcGluZywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywKPiBib29sIGNvdykKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVu
c2lnbmVkIGxvbmcgYWRkcmVzcywKPiBib29sIHNoYXJlZCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDC
oMKgdW5zaWduZWQgbG9uZyBzaXplID0gZGF4X2VudHJ5X3NpemUoZW50cnkpLCBwZm4sIGluZGV4
Owo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgaSA9IDA7Cj4gQEAgLTM3NCw4ICszODAsOCBAQCBzdGF0
aWMgdm9pZCBkYXhfYXNzb2NpYXRlX2VudHJ5KHZvaWQgKmVudHJ5LAo+IHN0cnVjdCBhZGRyZXNz
X3NwYWNlICptYXBwaW5nLAo+IMKgwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF9tYXBwZWRfcGZuKGVu
dHJ5LCBwZm4pIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwYWdl
ICpwYWdlID0gcGZuX3RvX3BhZ2UocGZuKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoY293KSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkYXhfbWFwcGluZ19zZXRfY293KHBhZ2UpOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoc2hhcmVkKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkYXhfcGFnZV9idW1wX3NoYXJpbmcocGFnZSk7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFdBUk5fT05fT05DRShwYWdlLT5tYXBwaW5nKTsK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYWdlLT5t
YXBwaW5nID0gbWFwcGluZzsKPiBAQCAtMzk2LDkgKzQwMiw5IEBAIHN0YXRpYyB2b2lkIGRheF9k
aXNhc3NvY2lhdGVfZW50cnkodm9pZCAqZW50cnksCj4gc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1h
cHBpbmcsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGFnZSAqcGFn
ZSA9IHBmbl90b19wYWdlKHBmbik7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoFdBUk5fT05fT05DRSh0cnVuYyAmJiBwYWdlX3JlZl9jb3VudChwYWdlKSA+IDEpOwo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZGF4X21hcHBpbmdfaXNfY293KHBhZ2Ut
Pm1hcHBpbmcpKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAvKiBrZWVwIHRoZSBDb1cgZmxhZyBpZiB0aGlzIHBhZ2UgaXMgc3RpbGwKPiBzaGFyZWQg
Ki8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChw
YWdlLT5pbmRleC0tID4gMCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGRh
eF9wYWdlX2lzX3NoYXJlZChwYWdlKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLyoga2VlcCB0aGUgc2hhcmVkIGZsYWcgaWYgdGhpcyBwYWdlIGlz
IHN0aWxsCj4gc2hhcmVkICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAoZGF4X3BhZ2VfZHJvcF9zaGFyaW5nKHBhZ2UpID4gMCkKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y29udGludWU7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9IGVsc2UKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBXQVJOX09OX09OQ0Uo
cGFnZS0+bWFwcGluZyAmJiBwYWdlLT5tYXBwaW5nCj4gIT0gbWFwcGluZyk7Cj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvbW1fdHlwZXMuaCBiL2luY2x1ZGUvbGludXgvbW1fdHlwZXMuaAo+
IGluZGV4IDUwMGU1MzY3OTZjYS4uZjQ2Y2FjMzY1N2FkIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
bGludXgvbW1fdHlwZXMuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1fdHlwZXMuaAo+IEBAIC0x
MDMsNyArMTAzLDEwIEBAIHN0cnVjdCBwYWdlIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC8qIFNlZSBwYWdlLWZsYWdzLmggZm9yIFBBR0VfTUFQUElOR19G
TEFHUyAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGdvZmZfdCBpbmRleDvCoMKgwqDCoMKgwqDCoMKgwqDC
oC8qIE91ciBvZmZzZXQgd2l0aGluCj4gbWFwcGluZy4gKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVuaW9uIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZ29mZl90IGluZGV4
O8KgwqDCoMKgwqDCoMKgwqDCoMKgLyogT3VyIG9mZnNldAo+IHdpdGhpbiBtYXBwaW5nLiAqLwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHVuc2lnbmVkIGxvbmcgc2hhcmU7wqDCoMKgwqAvKiBzaGFyZQo+IGNvdW50IGZvciBm
c2RheCAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
fTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKioK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBAcHJp
dmF0ZTogTWFwcGluZy1wcml2YXRlIG9wYXF1ZSBkYXRhLgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFVzdWFsbHkgdXNlZCBmb3IgYnVmZmVyX2hl
YWRzIGlmCj4gUGFnZVByaXZhdGUuCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGFnZS1m
bGFncy5oIGIvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmgKPiBpbmRleCAwYjBhZTUwODRlNjAu
LmM4YTNhYTAyMjc4ZCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MuaAo+
ICsrKyBiL2luY2x1ZGUvbGludXgvcGFnZS1mbGFncy5oCj4gQEAgLTY0MSw3ICs2NDEsNyBAQCBQ
QUdFRkxBR19GQUxTRShWbWVtbWFwU2VsZkhvc3RlZCwKPiB2bWVtbWFwX3NlbGZfaG9zdGVkKQo+
IMKgICogRGlmZmVyZW50IHdpdGggZmxhZ3MgYWJvdmUsIHRoaXMgZmxhZyBpcyB1c2VkIG9ubHkg
Zm9yIGZzZGF4Cj4gbW9kZS7CoCBJdAo+IMKgICogaW5kaWNhdGVzIHRoYXQgdGhpcyBwYWdlLT5t
YXBwaW5nIGlzIG5vdyB1bmRlciByZWZsaW5rIGNhc2UuCj4gwqAgKi8KPiAtI2RlZmluZSBQQUdF
X01BUFBJTkdfREFYX0NPV8KgwqDCoDB4MQo+ICsjZGVmaW5lIFBBR0VfTUFQUElOR19EQVhfU0hB
UkVEwqDCoMKgwqDCoMKgwqDCoDB4MQo+IMKgCj4gwqBzdGF0aWMgX19hbHdheXNfaW5saW5lIGJv
b2wgZm9saW9fbWFwcGluZ19mbGFncyhzdHJ1Y3QgZm9saW8gKmZvbGlvKQo+IMKgewoK
