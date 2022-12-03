Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5D6411EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 01:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiLCAUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 19:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiLCAUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:20:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E74FF1165;
        Fri,  2 Dec 2022 16:20:02 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2MNk7e030395;
        Sat, 3 Dec 2022 00:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MGRqflOGan6RGNDsx7pI59UDOyfUBN7v0gA0vmWHJfI=;
 b=TCbWBEUutsZjjbjAqCFlsenOmICmm39up28f66t6WRnBlXr0NAEAQ86x6tMUhL5ltZUT
 aQWA4EnOw/GXxE9c3IXiYBDZEVoMCwbMTpKDte54yXG6+rusWdZYMMoyKjKOUhSY0A//
 dkTW/8MCW8ZB8eIl2Hag7JXOmi7F3Zq6Nj0jJThfM6wK3qX59NkxEKMNyeguUZmOKDg7
 GlPscF6N3ULgw7uBJJT9jvjATCEIFJYQDtRtHW6A4YLzMTnrjzrQWCdGSNfXAykkJKDe
 PnD4zfh//Wj4P4pWqEOtwog5EuU42/J5Lyd1Ljsy6tFN0C/d9UCu6eytm3NkiqVUpOoM sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m782j2wqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Dec 2022 00:19:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B2NNkpV040048;
        Sat, 3 Dec 2022 00:19:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398m4xmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Dec 2022 00:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c37j6qtGf5RZf6tEG34GGCjIbAysBql2QtbgFNKclImLr3tAlnazctfeCnDD83jURnOAbgnmgwus3wY2IjT+Lct5yL/Yakyqw4uDMzR2GXVNL9s3RuMkhNrD9hvmSsxKyb1kGDNSQsoOGHuVPhKX5RORJudbyyc5glm1pfBLD1D22LHhTuRFn8oMReFMh6qbAfbvgKWWdL+c8CvZQxT3mPt6u3A/leUF8/IiqaBqUVa3H2uqJli235vo+B5FK/UXL9TdRXuCC1IsvIwgVEoLmx1vRDxd/fF8Rq4UebtO+JeLxkXAbJ/otyjRbhVZnfdbES/wPBeVeqi0VzBuu3E/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGRqflOGan6RGNDsx7pI59UDOyfUBN7v0gA0vmWHJfI=;
 b=cjBFdWyWh5MojiwWo69l7UCFba2Y3OzBRabr6crBbIR7OhRqJLYc7JUaW85QR4Sxub6EtdiaONSKfm/va+w0qQg1bZByBRFtUE2tjlqO71E+Gq3S9Syv3puWdliSK4f8g+h7UWkkXAX2qCxomC/XEd2bWHWGr9fllfaWaTk551DmecOCFlc5vMuirflX0FTj7a1xdhXcL+ND9u1VNcKpIQhKtcPF++hUIzg3xXZ8t1uithtoKZ+o0fWCNn9lzbmsYWH+qMPdIrdgaaOXVT1rVyqMzQZOnbDDJ8lfXc2Af9vYLilN3RuGE9OZrCw3Cl6qyK9ZmHhKYX5FLubuKAINPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGRqflOGan6RGNDsx7pI59UDOyfUBN7v0gA0vmWHJfI=;
 b=jvFN5XyyBvOfCxD0QaRFxEOBCrPcuuYU4QeoXUbdu910P0LJ36lEBsjrLXslEfX8ZCCG8fAGdDp1ARl0C/gSvir59SlakbgohB0uuf3GYR41ra0xRgJWdPuNuRa87I+jcR0uU7T+tYybG8vvpnJUAGTLi+U4880U+YI9JVUaxH0=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by IA1PR10MB7385.namprd10.prod.outlook.com (2603:10b6:208:42f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Sat, 3 Dec
 2022 00:19:48 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::3cab:6ff7:cb4d:b57c]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::3cab:6ff7:cb4d:b57c%4]) with mapi id 15.20.5880.010; Sat, 3 Dec 2022
 00:19:48 +0000
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
Subject: Re: [PATCH v2.1 3/8] fsdax: zero the edges if source is HOLE or
 UNWRITTEN
Thread-Topic: [PATCH v2.1 3/8] fsdax: zero the edges if source is HOLE or
 UNWRITTEN
Thread-Index: AQHZBjBAZ8jqUuEQRUOORlxUSzuLp65bTYcA
Date:   Sat, 3 Dec 2022 00:19:48 +0000
Message-ID: <cbf2d999d0bd7ad86c0533bd76d7adab0492c4bc.camel@oracle.com>
References: <1669908538-55-4-git-send-email-ruansy.fnst@fujitsu.com>
         <1669973145-318-1-git-send-email-ruansy.fnst@fujitsu.com>
In-Reply-To: <1669973145-318-1-git-send-email-ruansy.fnst@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|IA1PR10MB7385:EE_
x-ms-office365-filtering-correlation-id: 3b63c1af-02a4-41e3-4592-08dad4c416d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kU3ppO94UnEFs2qylL9J4uvPsg5op2xmrjR8PtWVOZt0g4Grl0NhurpX8zGMoCQO0uHN0/BffQKB4u9SFfsblQ27/Wby6LJHDUbi67Wugz+IQDHLO/F+LBy/NkXKWu6o3o+AU43JDDoo3C43O+NPPM22fh+4ojtkCLnqAaPPcJZbSRvGaJFwRVOiyRjUHQZbqi0iI9TJ/OaackxFA9Lidz0Bpljk46YaCEfjPFB6uhIUMjv7MGWHo7Vwr8CW9IDfG1gp8946CboyjVc7fvZpULRnWI9LUL6dSCZOVQXVYV23yzyHkUi4UH+sgcpu6EiKyfOKQPktZKpZf9DGd6oFYxqFNmcSomEEhuWPow0W9tLHWnU5bqH/3dN4aDaHgHq+vnIv1N/6dJ/ZWd3pn8tbx95MIJj6Q8izYEzZd9CB4kDOi2xaxJb6UwsEU6sBtPRLiBAZ1SfqwNyPxTUlmklYDKennVz/NQiNKZ5NFz9OaTVECPgu4CBnnqHBK7z+k2/BKbJgTzmFluofqYPnnAgeEB1SYG9M/ue7y6YwIKxTXhQPcNiMFTeM25jESqpjVvFS24352f/oxM0+jcdtOTQ65MOgQJ2UMCYiepkEtbI878Yit623sHQecLpL5KHFCZbNr3okcoCL2kfg4G4Ahe6YHJlV/OkC/zKOM7zf6mZ5GTX+I/WrsjunlghAfZ1aULCM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(6512007)(26005)(316002)(54906003)(110136005)(8936002)(36756003)(71200400001)(41300700001)(6506007)(5660300002)(38100700002)(122000001)(83380400001)(2906002)(38070700005)(4326008)(44832011)(2616005)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(8676002)(186003)(76116006)(478600001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDZIRTNRY0FHZkxIajY3dkJJcE96NzhHSjltVmMra09LQkhPcFNCUkkwRE55?=
 =?utf-8?B?Ymszb1J5TENjb3lRb29TZG9jeG5JOHRVMGViZHBKZGQrekdXZTgvL2J3RkpQ?=
 =?utf-8?B?NDJLR2tJM20vNzgyM0MyWjhVaFRxMzR0QzRVVGNDVWVJaFE3bG12QVRVdHpJ?=
 =?utf-8?B?Ky9ZV2Y4NVN2TVVUNDhCSFVJLzdENEl0NTZoRjczc3g2cG9FZGt2OEVUNjhF?=
 =?utf-8?B?UEM0Q2RjbkRBMXZocTY0T1Y0V2NjYzJQUWN4TkVJMEQxVjhITXhzbFF3VW05?=
 =?utf-8?B?d2wyWCtyTzNJdlJvRW5ZQmMyKzk5K01yQ1VPbHlGM1NSSXZrT0F5bTdoRGZv?=
 =?utf-8?B?azRQUHF3SkxnWWJkdDUvZkRUR0NXWWg4VXQ0K3VYUHFzSTRseDZHdHJjK0Jp?=
 =?utf-8?B?M0lCUXp3aUVnbWE2K3hpY0NPWUI2VzFhV2E2MDNDd09pa3l2MmpFRUtHT21Q?=
 =?utf-8?B?VmJtNkZhYklHdGlkRU5RNTdSQ0JUZVJ6YWs0TTNkMG44WWRtWktuZ01TSGVI?=
 =?utf-8?B?clN4aTJWcnNFWXBUMXVvNVZoL2NNTFhNK2EzRzVBSHgyN3JETTJ6bjJ4em9y?=
 =?utf-8?B?R1dZdkswakg0UGJFTEFBNXp0UzhRWXNGWG5XUGNPNi9EWEpmbXd5a3BvNWdt?=
 =?utf-8?B?bFg1RXdSQk1GZDFRRE0zMW0rVXBFRWUwQnpCSldERDRKQndCZU53Ly9HYVlx?=
 =?utf-8?B?VkVUeGlOZlh3cWs3VDRyQmhGTjY1VmI1ZkNGb0Nsa1F0UGdSSlQ2ZElDOEdU?=
 =?utf-8?B?YVJPTjNwTFlJZWQ1SFY0bmhTbzlDUUhkNW0zYWpTSHhaUU5jeE1JYlpUVEUw?=
 =?utf-8?B?SWhPYjdEV0ZHOU1jOUh5Yitpem8xZi9jK0RJL3MvSFhIcEorMWlVRGZmN2FE?=
 =?utf-8?B?VWI1U3R2YkFENS9EaXRuN1NkL2pnWWpHcWI4MUZoc29SbTlLb3p4c2JwY2pX?=
 =?utf-8?B?bXpsb1Q2d2pUWHZ4ZVZVcXRKVUIwQ2xNRHJUck1XcXc3VXNPNVVhMlNhUkJC?=
 =?utf-8?B?WVdVVVMzczdlLzVldlVPa3VNL0lwZ1FndTlTekpRQXhlbGRLeGE1VHc5TWx1?=
 =?utf-8?B?ZnowVy94aThtMlljUUhHTVl1SlZacmpJd1pqV05kaDZPYXV1eVhpSHlOOXRE?=
 =?utf-8?B?dkx0a3hIRExlR2Z5R2ova1h2TXdVamh5Z1c5Um9mOEpReTE1Z3ZMa3hQY1dm?=
 =?utf-8?B?QXkyTVhVQ1U3U2NDQmZoTWxXOTdCVDY3WGR5b2RrbElUNWJrNW9ZWkFWUzJz?=
 =?utf-8?B?NUkyUzQvWUpYWVAvV1Z2VVc1U0Y3VTJOck1SREdOa2dEYUwwcnZnSy9oZHcv?=
 =?utf-8?B?Mm0zODlYYzJCV2FIajVoV29zOUVFc2dIaXdzdkVxN2tXakRiZGhBSVlwbjhM?=
 =?utf-8?B?L0tIdTZ3eTJEV3BPYVNpaFQrUGJIMW5rdlVoT2Q5M2FDMXVyQk9zOE42RjRU?=
 =?utf-8?B?YlR4cW5XbmgxbXNoZ25WU0RFYzNDOEl3c3ROaHpkUTdDK29mRFpEQkx0M2o1?=
 =?utf-8?B?ekU3NERURnh1Uy9HSWFaWElNaUJrczBUekRCOG10UkVPaXFkdGVzSDlsU0hl?=
 =?utf-8?B?cWFJS2lDdERjZ2hmY052VXZ2SU1NVFRVaHl1amRvNURHRzIzeWZKUTJWSDRn?=
 =?utf-8?B?NzQ0dGVvc0VVckI5SUJrdVV4eGpkQUNoMThwa2x3WWoxUzliKzBBMmxaZlh0?=
 =?utf-8?B?ZFk5L3YvTWlrS2ZKM3dCSzJLVnVuQjZxUVdwYlZpSlhjK2xuSVNxZ1Avemtr?=
 =?utf-8?B?enpRaVFXTm15TFBQMjFTZ0l2OFZqMTdJQ2Z4bUswZEUyd25RZlRiTmJBbUJi?=
 =?utf-8?B?YjVSNWtkVGZCS29UWEdVbHA5cjAzNWsvME9aTmllVU9aZFlieGszeXFTMWM3?=
 =?utf-8?B?RnhwVU1rdHU3bFJkY05KeUtWWHRxRHdITFRIK3c1MHRrN016UmJLbDY0Yk1i?=
 =?utf-8?B?M096NGkzMWhmOXNpekdPeG4yL3BqZ2Foay8zenZxQVM3WUszdTlKU1FDUGR0?=
 =?utf-8?B?YjI3bVJxRUlUQXFrZTJ2ZnoybGlvekJETGVhU0Z2NmpkRjRqZ2NoWGRIWTZ1?=
 =?utf-8?B?NndFbzJTWHVJUTZ5ZTNTa1ArSWtFWlUzQ1lqUStaZ1Y0ZVloWjZHTjZQbnND?=
 =?utf-8?B?TkVIOEpqYU1OdTJqUkJpRDJMMGFjZ1orUU4zN21YMVFkZGV2c2ZkNENLb0w3?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <731A9624ADE69A48904195435E8500BA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T0NNTnVFdFYwWnd5dVNjMzV6TDJDeVo2a3lHSXVERHJlbnZLZHdvVGhhQ0lE?=
 =?utf-8?B?Q2ZWdnNrQ3ZnNGtZUE5ic0RjTlhHVXM0cHBoU1Q1eTEvZ0dKbEtIUmlINDB5?=
 =?utf-8?B?anVIbHpOYk5WYjRMSnlXL1M0ZGJ3ZjVSL0JwS0JVNmRESVVhdlBEWkczeFpT?=
 =?utf-8?B?R05YRXVTM1hpZVJHVXd0SWxWb000SVZ4cElWR296Y2k1NUQvOE1DdC9mNWJK?=
 =?utf-8?B?bDNDK0VtVnV1cjU1U3ZXSTZvMWkvdmtNM3Q1a3pvWTNIMWhORlFvay8rWGlO?=
 =?utf-8?B?RDJINWZwNUNkR2Y1cXJ2YXV2MEpzWEgrVE1JM1VZUUVnUmM4QWJCaU8zK28x?=
 =?utf-8?B?Kzc0cFZvcjU5Z0RJdUhIbE1IdEI3T25ESVVvTHJCL0l1bTU4UXJyaDBCaVNs?=
 =?utf-8?B?RTFON1Z1WFNuSGMyM3lvZktnOXlZYk5LTHNQa2tGSzVBK3JvNW9yd0Y3Y1Q2?=
 =?utf-8?B?b3FlMStPZE1UUDVRWlZyaXNRTVhOWFRpWVMxTEtJZWFlODRFUHE2ZHJjU3FO?=
 =?utf-8?B?NkgyMzExaERaNGpqbHg0K3NZSEJYNHpGcjBGZ2RoOEN3a3pjVk9SQmxrNGsv?=
 =?utf-8?B?OS94RVZ5b0Z1ZDhnM0VrT3IzQk9QM3VVNGRSbHBIRVFabkU5V1owM2NPR3Fl?=
 =?utf-8?B?dnFmVDJIYnd5Y2ZlbWFpd21tODdOWUlaMTZVbVZVbTdhZ25DV2Y3Mzd3eTNF?=
 =?utf-8?B?UVQvQSt2WnlDYkw1VHRReFo3NlQyL2d0dm05cUQySFN5UktDeGdsaGhoNnFr?=
 =?utf-8?B?VUtxbWViaVBUVnArV1dkUlhQNDZUaEMxUitKazA0WmVSanc1aG0wSjlwNU5o?=
 =?utf-8?B?bHkwV1dtVkV0ZUE5ams5V2huV0xkTmpMb3c5dFBmVjRrNjRSR3FiM1UxaWlF?=
 =?utf-8?B?c2E5U1JhK21xV3I1ejZYUHdTaGxBZnd5NHdwZ2xXNWpBSjBJY2hnWVRzeWE5?=
 =?utf-8?B?WmlPc2FVbDE5TGo4RUdvaWx6ODUrMkhwK2MwTjNiQVBNdFh3bXFBT2RTNXNN?=
 =?utf-8?B?eDhWa2lwREtoNTNCQnBHY3cyRk9vcFlEb1NCN2cwRTRiK21Lc1paemUwTndT?=
 =?utf-8?B?Uno4T1IxMzlGMzdFVjUyQXkzb050RkRWWEpQaXFITWlWSXN2cHBxUDd6MXFz?=
 =?utf-8?B?THpKN0NsdTZ5UG1sek9JWnU5MWk3SUlWNm1PUlc4UUtoWlFrUFVyajA3K0Fx?=
 =?utf-8?B?NmVlMThVQTY5eG5mR3ZIU1paRm95dlRDQjM3Qi9wZEhFTjUzVlFxcGV6R2tj?=
 =?utf-8?B?bEhUSEJ1bDJ1MXRoVFRmYmpiNFFqb2lZVC9tSDArN3Z5UTZWUHlXVDRWRVJK?=
 =?utf-8?B?VXFpN0FDM2s4cFc0MTZDS1M5RHR0eDJCayt5c1ZPNDJ5NkVPWnczWm0rRy9l?=
 =?utf-8?B?L3ZJU0RZUjFuWkw5a3VwNHN4a1RuTHFSRUF0TmVwcWRaOUlsWSttYW8wZDRj?=
 =?utf-8?Q?/PMAUH2v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b63c1af-02a4-41e3-4592-08dad4c416d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 00:19:48.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjD1GWt4Q/blLF7TaQMye5JcXaR/wfDT/iSpUdHc680nhKIvjfdXJ9br2s0Y0v/a+gSMJxRxtkwMl74j8UlhqCIRKpYgJ1/onGU470Bsr4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212030001
X-Proofpoint-GUID: bzkr3zsdkoW8GATfY0MuHRQ7xZ0cH6Xl
X-Proofpoint-ORIG-GUID: bzkr3zsdkoW8GATfY0MuHRQ7xZ0cH6Xl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTAyIGF0IDA5OjI1ICswMDAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6Cj4g
SWYgc3JjbWFwIGNvbnRhaW5zIGludmFsaWQgZGF0YSwgc3VjaCBhcyBIT0xFIGFuZCBVTldSSVRU
RU4sIHRoZSBkZXN0Cj4gcGFnZSBzaG91bGQgYmUgemVyb2VkLsKgIE90aGVyd2lzZSwgc2luY2Ug
aXQncyBhIHBtZW0sIG9sZCBkYXRhIG1heQo+IHJlbWFpbnMgb24gdGhlIGRlc3QgcGFnZSwgdGhl
IHJlc3VsdCBvZiBDb1cgd2lsbCBiZSBpbmNvcnJlY3QuCj4gCj4gVGhlIGZ1bmN0aW9uIG5hbWUg
aXMgYWxzbyBub3QgZWFzeSB0byB1bmRlcnN0YW5kLCByZW5hbWUgaXQgdG8KPiAiZGF4X2lvbWFw
X2NvcHlfYXJvdW5kKCkiLCB3aGljaCBtZWFucyBpdCBjb3B5cyBkYXRhIGFyb3VuZCB0aGUKPiBy
YW5nZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0
c3UuY29tPgo+IFJldmlld2VkLWJ5OiBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3Jn
Pgo+IApJIHRoaW5rIHRoZSBuZXcgY2hhbmdlcyBsb29rIGdvb2QKUmV2aWV3ZWQtYnk6IEFsbGlz
b24gSGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPgoKPiAtLS0KPiDCoGZz
L2RheC5jIHwgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAzMCBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvZGF4LmMgYi9mcy9kYXguYwo+IGluZGV4
IGE3NzczOWYyYWJlNy4uZjEyNjQ1ZDZmM2M4IDEwMDY0NAo+IC0tLSBhL2ZzL2RheC5jCj4gKysr
IGIvZnMvZGF4LmMKPiBAQCAtMTA5Miw3ICsxMDkyLDggQEAgc3RhdGljIGludCBkYXhfaW9tYXBf
ZGlyZWN0X2FjY2Vzcyhjb25zdCBzdHJ1Y3QKPiBpb21hcCAqaW9tYXAsIGxvZmZfdCBwb3MsCj4g
wqB9Cj4gwqAKPiDCoC8qKgo+IC0gKiBkYXhfaW9tYXBfY293X2NvcHkgLSBDb3B5IHRoZSBkYXRh
IGZyb20gc291cmNlIHRvIGRlc3RpbmF0aW9uCj4gYmVmb3JlIHdyaXRlCj4gKyAqIGRheF9pb21h
cF9jb3B5X2Fyb3VuZCAtIFByZXBhcmUgZm9yIGFuIHVuYWxpZ25lZCB3cml0ZSB0byBhCj4gc2hh
cmVkL2NvdyBwYWdlCj4gKyAqIGJ5IGNvcHlpbmcgdGhlIGRhdGEgYmVmb3JlIGFuZCBhZnRlciB0
aGUgcmFuZ2UgdG8gYmUgd3JpdHRlbi4KPiDCoCAqIEBwb3M6wqDCoMKgwqDCoMKgwqBhZGRyZXNz
IHRvIGRvIGNvcHkgZnJvbS4KPiDCoCAqIEBsZW5ndGg6wqDCoMKgwqBzaXplIG9mIGNvcHkgb3Bl
cmF0aW9uLgo+IMKgICogQGFsaWduX3NpemU6wqDCoMKgwqDCoMKgwqDCoGFsaWduZWQgdy5yLnQg
YWxpZ25fc2l6ZSAoZWl0aGVyIFBNRF9TSVpFIG9yCj4gUEFHRV9TSVpFKQo+IEBAIC0xMTAxLDM1
ICsxMTAyLDUwIEBAIHN0YXRpYyBpbnQgZGF4X2lvbWFwX2RpcmVjdF9hY2Nlc3MoY29uc3QKPiBz
dHJ1Y3QgaW9tYXAgKmlvbWFwLCBsb2ZmX3QgcG9zLAo+IMKgICoKPiDCoCAqIFRoaXMgY2FuIGJl
IGNhbGxlZCBmcm9tIHR3byBwbGFjZXMuIEVpdGhlciBkdXJpbmcgREFYIHdyaXRlIGZhdWx0Cj4g
KHBhZ2UKPiDCoCAqIGFsaWduZWQpLCB0byBjb3B5IHRoZSBsZW5ndGggc2l6ZSBkYXRhIHRvIGRh
ZGRyLiBPciwgd2hpbGUgZG9pbmcKPiBub3JtYWwgREFYCj4gLSAqIHdyaXRlIG9wZXJhdGlvbiwg
ZGF4X2lvbWFwX2FjdG9yKCkgbWlnaHQgY2FsbCB0aGlzIHRvIGRvIHRoZSBjb3B5Cj4gb2YgZWl0
aGVyCj4gKyAqIHdyaXRlIG9wZXJhdGlvbiwgZGF4X2lvbWFwX2l0ZXIoKSBtaWdodCBjYWxsIHRo
aXMgdG8gZG8gdGhlIGNvcHkKPiBvZiBlaXRoZXIKPiDCoCAqIHN0YXJ0IG9yIGVuZCB1bmFsaWdu
ZWQgYWRkcmVzcy4gSW4gdGhlIGxhdHRlciBjYXNlIHRoZSByZXN0IG9mCj4gdGhlIGNvcHkgb2YK
PiAtICogYWxpZ25lZCByYW5nZXMgaXMgdGFrZW4gY2FyZSBieSBkYXhfaW9tYXBfYWN0b3IoKSBp
dHNlbGYuCj4gKyAqIGFsaWduZWQgcmFuZ2VzIGlzIHRha2VuIGNhcmUgYnkgZGF4X2lvbWFwX2l0
ZXIoKSBpdHNlbGYuCj4gKyAqIElmIHRoZSBzcmNtYXAgY29udGFpbnMgaW52YWxpZCBkYXRhLCBz
dWNoIGFzIEhPTEUgYW5kIFVOV1JJVFRFTiwKPiB6ZXJvIHRoZQo+ICsgKiBhcmVhIHRvIG1ha2Ug
c3VyZSBubyBvbGQgZGF0YSByZW1haW5zLgo+IMKgICovCj4gLXN0YXRpYyBpbnQgZGF4X2lvbWFw
X2Nvd19jb3B5KGxvZmZfdCBwb3MsIHVpbnQ2NF90IGxlbmd0aCwgc2l6ZV90Cj4gYWxpZ25fc2l6
ZSwKPiArc3RhdGljIGludCBkYXhfaW9tYXBfY29weV9hcm91bmQobG9mZl90IHBvcywgdWludDY0
X3QgbGVuZ3RoLCBzaXplX3QKPiBhbGlnbl9zaXplLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgY29uc3Qgc3RydWN0IGlvbWFwICpzcmNtYXAsIHZvaWQgKmRhZGRyKQo+IMKgewo+
IMKgwqDCoMKgwqDCoMKgwqBsb2ZmX3QgaGVhZF9vZmYgPSBwb3MgJiAoYWxpZ25fc2l6ZSAtIDEp
Owo+IMKgwqDCoMKgwqDCoMKgwqBzaXplX3Qgc2l6ZSA9IEFMSUdOKGhlYWRfb2ZmICsgbGVuZ3Ro
LCBhbGlnbl9zaXplKTsKPiDCoMKgwqDCoMKgwqDCoMKgbG9mZl90IGVuZCA9IHBvcyArIGxlbmd0
aDsKPiDCoMKgwqDCoMKgwqDCoMKgbG9mZl90IHBnX2VuZCA9IHJvdW5kX3VwKGVuZCwgYWxpZ25f
c2l6ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgLyogY29weV9hbGwgaXMgdXN1YWxseSBpbiBwYWdlIGZh
dWx0IGNhc2UgKi8KPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCBjb3B5X2FsbCA9IGhlYWRfb2ZmID09
IDAgJiYgZW5kID09IHBnX2VuZDsKPiArwqDCoMKgwqDCoMKgwqAvKiB6ZXJvIHRoZSBlZGdlcyBp
ZiBzcmNtYXAgaXMgYSBIT0xFIG9yIElPTUFQX1VOV1JJVFRFTiAqLwo+ICvCoMKgwqDCoMKgwqDC
oGJvb2wgemVyb19lZGdlID0gc3JjbWFwLT5mbGFncyAmIElPTUFQX0ZfU0hBUkVEIHx8Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3JjbWFwLT50eXBl
ID09IElPTUFQX1VOV1JJVFRFTjsKPiDCoMKgwqDCoMKgwqDCoMKgdm9pZCAqc2FkZHIgPSAwOwo+
IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0ID0gMDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldCA9
IGRheF9pb21hcF9kaXJlY3RfYWNjZXNzKHNyY21hcCwgcG9zLCBzaXplLCAmc2FkZHIsCj4gTlVM
TCk7Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIHJldDsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIXplcm9fZWRnZSkgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBkYXhfaW9tYXBfZGlyZWN0X2FjY2Vz
cyhzcmNtYXAsIHBvcywgc2l6ZSwKPiAmc2FkZHIsIE5VTEwpOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKGNvcHlfYWxsKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldCA9IGNvcHlfbWNfdG9fa2VybmVsKGRhZGRyLCBzYWRkciwgbGVuZ3RoKTsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldCA/IC1FSU8gOiAwOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoemVyb19lZGdlKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtc2V0KGRhZGRyLCAwLCBzaXplKTsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gY29weV9tY190b19rZXJuZWwoZGFk
ZHIsIHNhZGRyLAo+IGxlbmd0aCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdv
dG8gb3V0Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgLyogQ29w
eSB0aGUgaGVhZCBwYXJ0IG9mIHRoZSByYW5nZSAqLwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoaGVh
ZF9vZmYpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gY29weV9tY190
b19rZXJuZWwoZGFkZHIsIHNhZGRyLCBoZWFkX29mZik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmIChyZXQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gLUVJTzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKHplcm9fZWRnZSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG1lbXNldChkYWRkciwgMCwgaGVhZF9vZmYpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldCA9IGNvcHlfbWNfdG9fa2VybmVsKGRhZGRyLCBzYWRkciwKPiBoZWFkX29m
Zik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAo
cmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAtRUlPOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBDb3B5IHRo
ZSB0YWlsIHBhcnQgb2YgdGhlIHJhbmdlICovCj4gQEAgLTExMzcsMTIgKzExNTMsMTkgQEAgc3Rh
dGljIGludCBkYXhfaW9tYXBfY293X2NvcHkobG9mZl90IHBvcywKPiB1aW50NjRfdCBsZW5ndGgs
IHNpemVfdCBhbGlnbl9zaXplLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbG9m
Zl90IHRhaWxfb2ZmID0gaGVhZF9vZmYgKyBsZW5ndGg7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBsb2ZmX3QgdGFpbF9sZW4gPSBwZ19lbmQgLSBlbmQ7Cj4gwqAKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gY29weV9tY190b19rZXJuZWwoZGFkZHIgKyB0
YWlsX29mZiwgc2FkZHIgKwo+IHRhaWxfb2ZmLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0YWls
X2xlbik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTzsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHplcm9fZWRnZSkKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1lbXNldChkYWRkciArIHRhaWxf
b2ZmLCAwLCB0YWlsX2xlbik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsc2Ug
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0g
Y29weV9tY190b19rZXJuZWwoZGFkZHIgKyB0YWlsX29mZiwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHNhZGRyICsgdGFpbF9vZmYsCj4gdGFpbF9sZW4pOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVJTzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDC
oMKgwqDCoMKgwqB9Cj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gK291dDoKPiArwqDCoMKg
wqDCoMKgwqBpZiAoemVyb19lZGdlKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
YXhfZmx1c2goc3JjbWFwLT5kYXhfZGV2LCBkYWRkciwgc2l6ZSk7Cj4gK8KgwqDCoMKgwqDCoMKg
cmV0dXJuIHJldCA/IC1FSU8gOiAwOwo+IMKgfQo+IMKgCj4gwqAvKgo+IEBAIC0xMjQxLDEzICsx
MjY0LDEwIEBAIHN0YXRpYyBpbnQgZGF4X21lbXplcm8oc3RydWN0IGlvbWFwX2l0ZXIKPiAqaXRl
ciwgbG9mZl90IHBvcywgc2l6ZV90IHNpemUpCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgPCAw
KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoMKgwqDC
oMKgwqDCoMKgbWVtc2V0KGthZGRyICsgb2Zmc2V0LCAwLCBzaXplKTsKPiAtwqDCoMKgwqDCoMKg
wqBpZiAoc3JjbWFwLT5hZGRyICE9IGlvbWFwLT5hZGRyKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldCA9IGRheF9pb21hcF9jb3dfY29weShwb3MsIHNpemUsIFBBR0VfU0la
RSwKPiBzcmNtYXAsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrYWRkcik7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgPCAwKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZGF4X2ZsdXNoKGlvbWFwLT5kYXhfZGV2LCBrYWRkciwgUEFHRV9TSVpF
KTsKPiAtwqDCoMKgwqDCoMKgwqB9IGVsc2UKPiArwqDCoMKgwqDCoMKgwqBpZiAoaW9tYXAtPmZs
YWdzICYgSU9NQVBfRl9TSEFSRUQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dCA9IGRheF9pb21hcF9jb3B5X2Fyb3VuZChwb3MsIHNpemUsIFBBR0VfU0laRSwKPiBzcmNtYXAs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrYWRkcik7Cj4gK8KgwqDCoMKgwqDCoMKg
ZWxzZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGF4X2ZsdXNoKGlvbWFwLT5k
YXhfZGV2LCBrYWRkciArIG9mZnNldCwgc2l6ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBy
ZXQ7Cj4gwqB9Cj4gQEAgLTE0MDEsOCArMTQyMSw4IEBAIHN0YXRpYyBsb2ZmX3QgZGF4X2lvbWFw
X2l0ZXIoY29uc3Qgc3RydWN0Cj4gaW9tYXBfaXRlciAqaW9taSwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKGNvdykgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0ID0gZGF4X2lvbWFwX2Nvd19jb3B5KHBvcywgbGVuZ3RoLAo+IFBBR0VfU0laRSwgc3Jj
bWFwLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGthZGRyKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGRheF9p
b21hcF9jb3B5X2Fyb3VuZChwb3MsIGxlbmd0aCwKPiBQQUdFX1NJWkUsCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3JjbWFwLCBrYWRkcik7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gQEAgLTE1NDcs
NyArMTU2Nyw3IEBAIHN0YXRpYyB2bV9mYXVsdF90IGRheF9mYXVsdF9pdGVyKHN0cnVjdAo+IHZt
X2ZhdWx0ICp2bWYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgeGFf
c3RhdGUgKnhhcywgdm9pZCAqKmVudHJ5LCBib29sIHBtZCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDC
oMKgY29uc3Qgc3RydWN0IGlvbWFwICppb21hcCA9ICZpdGVyLT5pb21hcDsKPiAtwqDCoMKgwqDC
oMKgwqBjb25zdCBzdHJ1Y3QgaW9tYXAgKnNyY21hcCA9ICZpdGVyLT5zcmNtYXA7Cj4gK8KgwqDC
oMKgwqDCoMKgY29uc3Qgc3RydWN0IGlvbWFwICpzcmNtYXAgPSBpb21hcF9pdGVyX3NyY21hcChp
dGVyKTsKPiDCoMKgwqDCoMKgwqDCoMKgc2l6ZV90IHNpemUgPSBwbWQgPyBQTURfU0laRSA6IFBB
R0VfU0laRTsKPiDCoMKgwqDCoMKgwqDCoMKgbG9mZl90IHBvcyA9IChsb2ZmX3QpeGFzLT54YV9p
bmRleCA8PCBQQUdFX1NISUZUOwo+IMKgwqDCoMKgwqDCoMKgwqBib29sIHdyaXRlID0gaXRlci0+
ZmxhZ3MgJiBJT01BUF9XUklURTsKPiBAQCAtMTU3OCw5ICsxNTk4LDggQEAgc3RhdGljIHZtX2Zh
dWx0X3QgZGF4X2ZhdWx0X2l0ZXIoc3RydWN0Cj4gdm1fZmF1bHQgKnZtZiwKPiDCoAo+IMKgwqDC
oMKgwqDCoMKgwqAqZW50cnkgPSBkYXhfaW5zZXJ0X2VudHJ5KHhhcywgdm1mLCBpdGVyLCAqZW50
cnksIHBmbiwKPiBlbnRyeV9mbGFncyk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBpZiAod3JpdGUg
JiYKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3JjbWFwLT50eXBlICE9IElPTUFQX0hPTEUgJiYg
c3JjbWFwLT5hZGRyICE9IGlvbWFwLQo+ID5hZGRyKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGVyciA9IGRheF9pb21hcF9jb3dfY29weShwb3MsIHNpemUsIHNpemUsIHNyY21h
cCwKPiBrYWRkcik7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHdyaXRlICYmIGlvbWFwLT5mbGFncyAm
IElPTUFQX0ZfU0hBUkVEKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9
IGRheF9pb21hcF9jb3B5X2Fyb3VuZChwb3MsIHNpemUsIHNpemUsIHNyY21hcCwKPiBrYWRkcik7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBkYXhfZmF1bHRfcmV0
dXJuKGVycik7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KCg==
