Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD050AED6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 06:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443912AbiDVETB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 00:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443914AbiDVES5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:18:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB94EDFD;
        Thu, 21 Apr 2022 21:16:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23M3wfrH019412;
        Fri, 22 Apr 2022 04:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bozxvMMneU15deAhPvgwaP55LeQuFx5UnL6CnQh+ZIc=;
 b=LbBfXpvCKf4zmqWVgUZh976SkPnkrHQ7am+3wAwxcZIkcriKuBOR5bKXbtBPrJJpIl4B
 qJT7fy6lb765ZXZCraT2AOmNbs4XUDGGDXn6BecrFyRagam/6EvzTfOi0/SKJtTbEhww
 PcCxAKSBqZGubnLadCgrAkAvBo20QXo+id6bHhL+ZkTRFYUpPRDEoUP4Lcmaae8cFZ9A
 oA+H+oHz4Efv/pCzR6GsmGCHnkEfR1d9ALGgS0vLAqXDjE5Vuc+5Th5EM82ESbV7+Oh6
 szVvHwuiSUl2c303X2NpY0eDrCbREuJyFxmWlSXQg33qTEP6po2BxIIInbbZ20RVybMJ Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cwbuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 04:15:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23M46mc4028448;
        Fri, 22 Apr 2022 04:15:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fk3av5umy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 04:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfUfDryEb37l/YnhbjKSz1Pc6jkf2PiJr4fA6xgftpRjeTojfm8Z/bBYq12XbKXHI40jeKtBvtPz3W2kyQ0UG/JVBTOEw35+UOFkK8/nofbQXT3ENyJ0K0VxFPM9/1MRvUovKV1J9C+PEXQwkfFvfh3xDZZAztATzNTHw7oe4tgbvc5h6CVyLRuNCY33bipT3R9pVs6KrWJ9fdUVVoV55QXHfhyzMXiC1jZ2w5rPIS9+x/eLoD0O6USNsErbNrX5xV75yAhGUrl75yzYME3DnNhJ+Sj1jbe303zqYOxhYAE4jTSlrpVB0hZScfXacx6wO1M87VGtyaGw1Sv/MzihDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bozxvMMneU15deAhPvgwaP55LeQuFx5UnL6CnQh+ZIc=;
 b=Tbb4VyBCenAoL/z1m/JfWi13QYovl55YKg+IIKL9NFKFf4g+kN+CyhXvZv0gXE+xoOXpTvkV+jYtZD1t5x6ZJfuNERFp/SGPpFO3S/vH+0KkwEPxVHMj4A+d2dU4ogPKjU9W5otYkYIVT6wLsK9nALDR7gti9HP2DRi9ZCNdHV75jdWR/1B3jhPnAqzIzI0R8Tnn2crT9nqzdipQZy6IYs1citnkGGEechBRSjyYUCxTTx90dOLS1XhPuepH0bWx1ckvO0tT3uses/PNHM47X6Ksu/t637OQYlXQ0n380/68MCBXrmGDkiOFRKgLyWDsPRm7kTsbfdP43fVsppxI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bozxvMMneU15deAhPvgwaP55LeQuFx5UnL6CnQh+ZIc=;
 b=Mlfcomq8lgjhfuYbVP+gS9jcAQYNV4oaKnFU3xs+RzMhDND0MdjMz6yRpxYUmhEDyxO7eqWuDnfpjN+k/j8eRSeY7onzBMJbYtoBX6RABXWI/E6gSqrhvsSjgcvYOicoieOTGsKYQr0NylMv7F5bqEny15WOiP2jYmxfn7ZdUEg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3349.namprd10.prod.outlook.com (2603:10b6:a03:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 04:15:39 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 04:15:39 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v8 4/7] dax: introduce DAX_RECOVERY_WRITE dax access mode
Thread-Topic: [PATCH v8 4/7] dax: introduce DAX_RECOVERY_WRITE dax access mode
Thread-Index: AQHYVFsQsaUDJAWZ/UKYy6bMSO9seaz6xSCAgACRaYA=
Date:   Fri, 22 Apr 2022 04:15:39 +0000
Message-ID: <d56480c4-9ede-7340-6e66-c8dca114754d@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
 <20220420020435.90326-5-jane.chu@oracle.com>
 <CAPcyv4jBUE9BTOrqVsFcBUZxzMx6ygax5FihrrccG2sET56Gjg@mail.gmail.com>
In-Reply-To: <CAPcyv4jBUE9BTOrqVsFcBUZxzMx6ygax5FihrrccG2sET56Gjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dca5088-667f-4c84-bf43-08da2416c282
x-ms-traffictypediagnostic: BYAPR10MB3349:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3349E8044BDB75C764FD8C9BF3F79@BYAPR10MB3349.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVF1y0qSRBVsNUks91DLstKSmUBg0DtQDH1hCV/oe6hDouWowBShOQTsS/cn8X+jt1uuIeisWoPfTQDGc1gPP1IwRDxvdQPCHMNFKbkd0vWBcHfcMXVVqrPVykvsimqWYN1+zddpmoIUdy0VKNANmhd2UQ5zHwcNPl4i0xIwvBK/E0eVbPduzBg55cScjwNEpLVfSvHSsA1OgBOliE/ehRpjf4FwHwG+tOZdGTz0kRLJyq9dqWPRraHrIcWTI8EBUSJ/g9in/hlAMif8QLpzG9w1u5r2ozoCHrjq8kWYQmmUZrHv37dhdR+P5U+evgnbjHxYvPT+i/T8TvYi5m4rFd3ch0Hm/LUF/yNoESpIwCrY+jMc/Jg2qQDsMZlTztSW899Pmem8IgeDCSZ+Oz28tqa+ivMsecwwIPUCBtmbmL7IYCzWSLbkWIII6s+n5SEFHF+8ZOLV0+kXrxlIeSXMRuDbxemcLqaCFS8+8ccwW+XnJdMlFniGfpJUbV7jbSMkrBq4XOXIPcZuMiU7N2tL4YiJffHNoQ5R/iYr0RZOEur7QSM9jRqQy0twFJDs3qQUZ82M2W9KgjU34eSZLOzW1s/1hyPJhHX2XmmerNpIRzyjFv7JN4jo1sRnHlfboXXTYGeiHwiVVngDkw8pd31pq34ZfSSPVqdsE+xVHLA0FzcNLF5zCTZ0x60lGbpivNsV8aVFl+8OGhc/ay4fBA5e1mLIZ6iIiPAyjZjE/wDYpW2w16ornxw67d/UByAkaV80qkOl7YnhxYSZFC/uT4LxdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(83380400001)(64756008)(66446008)(8936002)(186003)(66476007)(8676002)(66946007)(4326008)(31686004)(6512007)(122000001)(7416002)(53546011)(86362001)(26005)(2616005)(31696002)(5660300002)(54906003)(6486002)(44832011)(66556008)(38070700005)(6916009)(71200400001)(316002)(508600001)(2906002)(6506007)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVRSZVJVTEc4emFGd3R4NnFYWWRWbldwdmtHYkR0N2p4VW1Ocit2NkJHRFM5?=
 =?utf-8?B?alEyY3pkOHJJTy9XNHZyay9wWTZxRGlMM2krcDk2UzhDdkN2MzhoMXh2eERX?=
 =?utf-8?B?Y0VqdkdxV1NHQ08xS1FWdmRTSmx2WGIrc2pkQWtBYzNaTVg5Z1JuSHpHRzdW?=
 =?utf-8?B?bmREZmxneVhpVlp0a1pUYjNCemtRdGZRNXJDN3dQc21CcGhXWWVScmltTlMv?=
 =?utf-8?B?WTNteC9adElFUHY0TnJwT2FzUm1wck4yVE5zYWhTN1B5Q2dvTVF6VXh5ODNt?=
 =?utf-8?B?TmQwUm14U0MxeVlpcThCcnFpRGMrdTVLeXd6TFRSaVJEcGZqdG9lU05OQ3V2?=
 =?utf-8?B?ejB5dU5MUTJTQ0s1YVc0YUZRQWxBZzRpVWk5ck95Rk9qVkNTUDFxL0RiSTNI?=
 =?utf-8?B?ZGE2OXFoNGFJNFM0eWxVUFBWTzFNaHdLVEZaM09HeFhkbDJhei8wZFhhVjVt?=
 =?utf-8?B?aVN0ZitYQ3FXU0E4VWJWaHJhN1ZtN2pLU2xZaXNvMG5CZ3daTlFSeXhlUm54?=
 =?utf-8?B?QTBYSDZRZmcwa2FJTDdNWDVsc3VzU3BKdThDdVU0bFhpUTFTK0xaaXZqVU1Y?=
 =?utf-8?B?b3A1VnVCRXdkcFRUZmNmQXZyTzZXSjZmQVFzT3haZzM5THNwY0hNeG1WV1ND?=
 =?utf-8?B?S1ZOZWluU2RtL0w4d1k3OTgxamRkYW10OHk1aEhRQmYxdGpwMktFWUZybHAv?=
 =?utf-8?B?K0NmMGhlRFdNQmFhVUtQQXRsZVl2bXMvVmF2N3NrcEZNOVlHY2Z5SE1pUzNa?=
 =?utf-8?B?N3FlRkYzaHhqOUxTU1dtU3FSUUNld25neVVRUHNrSjkxZjB3Z3BOSTJ3blhh?=
 =?utf-8?B?YnRLR2ZkMU5nTElpeXA5aC9uaWJrc2cyV3g0eXpSdU9KdGwwdXdPTWE1NU95?=
 =?utf-8?B?MWtkaGg4dGJ5a3NXVkRkYldYT05PY0NSOVNiZHRnOUgxVzN1WUd0R3VadHRV?=
 =?utf-8?B?eURvblV5UjRJNC9IbThUQ3dhRzk3TENjZGFTKzdLNlVPdkpGdG81NlI0TmJN?=
 =?utf-8?B?cWh6V0pQTmo3Wk9QazBzNzZXU2dnb0JXVkNNVFJ4SVNBREJVanFFd3pvajIy?=
 =?utf-8?B?RWZ2c1Y1YnJWZGJ6U2hCQjVScEtLVUJlV0xJQ1FidFIrMDkzQ1FQMTVUWDA3?=
 =?utf-8?B?TjArVUZYVnNteXZReXRtd2wxeVEvaG1PdVlVYXVxbnJTbWNyd0UxRHlhTzNq?=
 =?utf-8?B?YWZJRElqY2EvVWk1Q0JCS3EyUXQybFUzUjhKWWJuamhGZUM4Q29FN2NScnk1?=
 =?utf-8?B?MnE4Ui9XcGNPdXdSc0RCMU56eTJQRVA4eXhlRFB4MFdobENSc0taYTdLczha?=
 =?utf-8?B?OXU2K3RaeUdScFBHOTBxZ2h1aW9YcC9xUk9CTnZmOHNSdVVFNVdKeG92aXUx?=
 =?utf-8?B?eTBhZlE2dHNoUVhuTkpUYlhCZEl6aXZIekcyZjZRa1VkTFF2ZEJZVGJhZTBQ?=
 =?utf-8?B?WHdVL1BpZnNLMzhjL2xqUFUxNklyM242TlhpRktKdXRRMjNXZC9Bd3dHWUV4?=
 =?utf-8?B?ZzhkWFJwNkpJcUcxR1YyZnVybkwwUWF3WjFQUVJDMXJvQjI5aFRCZTRiaDFv?=
 =?utf-8?B?YWFpS3F6RHVyUkxGUUlQWUh3R0NpUzE3ak9hY1VTaG9PT1NKejZJOGdEYlVD?=
 =?utf-8?B?SC9VMVlKM3o2UGZnQ0trRXBiTUFYK3FNUEJqVEQvNGdnVCtNamhnR2pVSzhM?=
 =?utf-8?B?UTl2TDB4ckVobzBoTDFzVkpweXQrVlpuMmlNeExBV2REWmJ4Z1B6NGNuV3N1?=
 =?utf-8?B?aGdzbGdxZ0xwdFhIbld0Y25Wbnh3ZzNZbHU3UE5GdjVQUTVoeGlpK0NsVktj?=
 =?utf-8?B?WXZ5bXZ2L2JPNEdPcllCcC9sUGt0RFZDSkllYjNxWDNOc1N2OE9FMjdlUzdD?=
 =?utf-8?B?bHdSN2J6OVNiZ1A0ZEtJYnpGNXh5d0VIbjQ0K25rd1J0ZkZHV2tmMDBETUp1?=
 =?utf-8?B?K0xGdURZZkxRVVRtYTZiclBkNmY5czBQM21GM2ZkcWFaQVA5Wlo2c0c3T3Ix?=
 =?utf-8?B?Vk9OdGhOYUNIUkNXN0VXb2NpVDZSVldVenJQTE5UaTFYOUc5Y0VheksvWm0w?=
 =?utf-8?B?eDFUbTI3U2dnN2YxaHY3QnBoV3BrWjRka3g4c3lsSm9rbnRyVnoxN0VGL2Y3?=
 =?utf-8?B?eEFSYWdQdWRBRnhQRTJTUGt6VTl1WVJ4MklqVW5Db3lzM1ZpaksvMXhIWUFs?=
 =?utf-8?B?L2dOMVRUTjFxbG1VOUt3Y09Jbk40SXBTUkhlQ2Y2UXptSTNhZ29oZEtnUW9U?=
 =?utf-8?B?UG8reDgwWktXakRqRFpmbG9EMTAzYzJwbjZFeFF5bXU0bk9JN2hiUDlxeElR?=
 =?utf-8?Q?wqYj6GXk2x9jzTNaF0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD8B9897F7532648B8DA52F81DF787CC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dca5088-667f-4c84-bf43-08da2416c282
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 04:15:39.6481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYf0igP++zW13QRz/+IPhowgRgIe0bHTdoudCEMU8tfP2EADN48TeNGjQzRId0mZKnQ8zPGE3LtFLvowOVBjwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_01:2022-04-21,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220015
X-Proofpoint-GUID: aqP9wGl6gv4U-B4l_yFX2WUyE8Yo8b0U
X-Proofpoint-ORIG-GUID: aqP9wGl6gv4U-B4l_yFX2WUyE8Yo8b0U
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMS8yMDIyIDEyOjM1IFBNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IE9uIFR1ZSwgQXBy
IDE5LCAyMDIyIGF0IDc6MDUgUE0gSmFuZSBDaHUgPGphbmUuY2h1QG9yYWNsZS5jb20+IHdyb3Rl
Og0KPj4NCj4+IFVwIHRpbGwgbm93LCBkYXhfZGlyZWN0X2FjY2VzcygpIGlzIHVzZWQgaW1wbGlj
aXRseSBmb3Igbm9ybWFsDQo+PiBhY2Nlc3MsIGJ1dCBmb3IgdGhlIHB1cnBvc2Ugb2YgcmVjb3Zl
cnkgd3JpdGUsIGRheCByYW5nZSB3aXRoDQo+PiBwb2lzb24gaXMgcmVxdWVzdGVkLiAgVG8gbWFr
ZSB0aGUgaW50ZXJmYWNlIGNsZWFyLCBpbnRyb2R1Y2UNCj4+ICAgICAgICAgIGVudW0gZGF4X2Fj
Y2Vzc19tb2RlIHsNCj4+ICAgICAgICAgICAgICAgICAgREFYX0FDQ0VTUywNCj4+ICAgICAgICAg
ICAgICAgICAgREFYX1JFQ09WRVJZX1dSSVRFLA0KPj4gICAgICAgICAgfQ0KPj4gd2hlcmUgREFY
X0FDQ0VTUyBpcyB1c2VkIGZvciBub3JtYWwgZGF4IGFjY2VzcywgYW5kDQo+PiBEQVhfUkVDT1ZF
UllfV1JJVEUgaXMgdXNlZCBmb3IgZGF4IHJlY292ZXJ5IHdyaXRlLg0KPj4NCj4+IFN1Z2dlc3Rl
ZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2
ZXJzL2RheC9zdXBlci5jICAgICAgICAgICAgIHwgIDUgKystLQ0KPj4gICBkcml2ZXJzL21kL2Rt
LWxpbmVhci5jICAgICAgICAgIHwgIDUgKystLQ0KPj4gICBkcml2ZXJzL21kL2RtLWxvZy13cml0
ZXMuYyAgICAgIHwgIDUgKystLQ0KPj4gICBkcml2ZXJzL21kL2RtLXN0cmlwZS5jICAgICAgICAg
IHwgIDUgKystLQ0KPj4gICBkcml2ZXJzL21kL2RtLXRhcmdldC5jICAgICAgICAgIHwgIDQgKyst
DQo+PiAgIGRyaXZlcnMvbWQvZG0td3JpdGVjYWNoZS5jICAgICAgfCAgNyArKystLS0NCj4+ICAg
ZHJpdmVycy9tZC9kbS5jICAgICAgICAgICAgICAgICB8ICA1ICsrLS0NCj4+ICAgZHJpdmVycy9u
dmRpbW0vcG1lbS5jICAgICAgICAgICB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLQ0KPj4gICBkcml2ZXJzL252ZGltbS9wbWVtLmggICAgICAgICAgIHwgIDUgKysrLQ0KPj4g
ICBkcml2ZXJzL3MzOTAvYmxvY2svZGNzc2Jsay5jICAgIHwgIDkgKysrKy0tLQ0KPj4gICBmcy9k
YXguYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKysrKy0tLQ0KPj4gICBmcy9mdXNlL2Rh
eC5jICAgICAgICAgICAgICAgICAgIHwgIDQgKy0tDQo+PiAgIGluY2x1ZGUvbGludXgvZGF4Lmgg
ICAgICAgICAgICAgfCAgOSArKysrKy0tDQo+PiAgIGluY2x1ZGUvbGludXgvZGV2aWNlLW1hcHBl
ci5oICAgfCAgNCArKy0NCj4+ICAgdG9vbHMvdGVzdGluZy9udmRpbW0vcG1lbS1kYXguYyB8ICAz
ICsrLQ0KPj4gICAxNSBmaWxlcyBjaGFuZ2VkLCA4NSBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgvc3VwZXIuYyBiL2RyaXZlcnMv
ZGF4L3N1cGVyLmMNCj4+IGluZGV4IDAyMTFlNmY3YjQ3YS4uNTQwNWViNTUzNDMwIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9kYXgvc3VwZXIuYw0KPj4gKysrIGIvZHJpdmVycy9kYXgvc3VwZXIu
Yw0KPj4gQEAgLTExNyw2ICsxMTcsNyBAQCBlbnVtIGRheF9kZXZpY2VfZmxhZ3Mgew0KPj4gICAg
KiBAZGF4X2RldjogYSBkYXhfZGV2aWNlIGluc3RhbmNlIHJlcHJlc2VudGluZyB0aGUgbG9naWNh
bCBtZW1vcnkgcmFuZ2UNCj4+ICAgICogQHBnb2ZmOiBvZmZzZXQgaW4gcGFnZXMgZnJvbSB0aGUg
c3RhcnQgb2YgdGhlIGRldmljZSB0byB0cmFuc2xhdGUNCj4+ICAgICogQG5yX3BhZ2VzOiBudW1i
ZXIgb2YgY29uc2VjdXRpdmUgcGFnZXMgY2FsbGVyIGNhbiBoYW5kbGUgcmVsYXRpdmUgdG8gQHBm
bg0KPj4gKyAqIEBtb2RlOiBpbmRpY2F0b3Igb24gbm9ybWFsIGFjY2VzcyBvciByZWNvdmVyeSB3
cml0ZQ0KPj4gICAgKiBAa2FkZHI6IG91dHB1dCBwYXJhbWV0ZXIgdGhhdCByZXR1cm5zIGEgdmly
dHVhbCBhZGRyZXNzIG1hcHBpbmcgb2YgcGZuDQo+PiAgICAqIEBwZm46IG91dHB1dCBwYXJhbWV0
ZXIgdGhhdCByZXR1cm5zIGFuIGFic29sdXRlIHBmbiB0cmFuc2xhdGlvbiBvZiBAcGdvZmYNCj4+
ICAgICoNCj4+IEBAIC0xMjQsNyArMTI1LDcgQEAgZW51bSBkYXhfZGV2aWNlX2ZsYWdzIHsNCj4+
ICAgICogcGFnZXMgYWNjZXNzaWJsZSBhdCB0aGUgZGV2aWNlIHJlbGF0aXZlIEBwZ29mZi4NCj4+
ICAgICovDQo+PiAgIGxvbmcgZGF4X2RpcmVjdF9hY2Nlc3Moc3RydWN0IGRheF9kZXZpY2UgKmRh
eF9kZXYsIHBnb2ZmX3QgcGdvZmYsIGxvbmcgbnJfcGFnZXMsDQo+PiAtICAgICAgICAgICAgICAg
dm9pZCAqKmthZGRyLCBwZm5fdCAqcGZuKQ0KPj4gKyAgICAgICAgICAgICAgIGVudW0gZGF4X2Fj
Y2Vzc19tb2RlIG1vZGUsIHZvaWQgKiprYWRkciwgcGZuX3QgKnBmbikNCj4+ICAgew0KPj4gICAg
ICAgICAgbG9uZyBhdmFpbDsNCj4+DQo+PiBAQCAtMTM4LDcgKzEzOSw3IEBAIGxvbmcgZGF4X2Rp
cmVjdF9hY2Nlc3Moc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYsIHBnb2ZmX3QgcGdvZmYsIGxv
bmcgbnJfcGFnZXMsDQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4NCj4+
ICAgICAgICAgIGF2YWlsID0gZGF4X2Rldi0+b3BzLT5kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBn
b2ZmLCBucl9wYWdlcywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGthZGRyLCBwZm4pOw0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgbW9kZSwga2FkZHIsIHBmbik7DQo+PiAgICAgICAg
ICBpZiAoIWF2YWlsKQ0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVSQU5HRTsNCj4+ICAg
ICAgICAgIHJldHVybiBtaW4oYXZhaWwsIG5yX3BhZ2VzKTsNCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21kL2RtLWxpbmVhci5jIGIvZHJpdmVycy9tZC9kbS1saW5lYXIuYw0KPj4gaW5kZXggNzZi
NDg2ZTRkMmJlLi4xM2UyNjMyOTljOWMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21kL2RtLWxp
bmVhci5jDQo+PiArKysgYi9kcml2ZXJzL21kL2RtLWxpbmVhci5jDQo+PiBAQCAtMTcyLDExICsx
NzIsMTIgQEAgc3RhdGljIHN0cnVjdCBkYXhfZGV2aWNlICpsaW5lYXJfZGF4X3Bnb2ZmKHN0cnVj
dCBkbV90YXJnZXQgKnRpLCBwZ29mZl90ICpwZ29mZikNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGlj
IGxvbmcgbGluZWFyX2RheF9kaXJlY3RfYWNjZXNzKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBwZ29m
Zl90IHBnb2ZmLA0KPj4gLSAgICAgICAgICAgICAgIGxvbmcgbnJfcGFnZXMsIHZvaWQgKiprYWRk
ciwgcGZuX3QgKnBmbikNCj4+ICsgICAgICAgICAgICAgICBsb25nIG5yX3BhZ2VzLCBlbnVtIGRh
eF9hY2Nlc3NfbW9kZSBtb2RlLCB2b2lkICoqa2FkZHIsDQo+PiArICAgICAgICAgICAgICAgcGZu
X3QgKnBmbikNCj4+ICAgew0KPj4gICAgICAgICAgc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYg
PSBsaW5lYXJfZGF4X3Bnb2ZmKHRpLCAmcGdvZmYpOw0KPj4NCj4+IC0gICAgICAgcmV0dXJuIGRh
eF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmLCBucl9wYWdlcywga2FkZHIsIHBmbik7DQo+
PiArICAgICAgIHJldHVybiBkYXhfZGlyZWN0X2FjY2VzcyhkYXhfZGV2LCBwZ29mZiwgbnJfcGFn
ZXMsIG1vZGUsIGthZGRyLCBwZm4pOw0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgaW50IGxpbmVh
cl9kYXhfemVyb19wYWdlX3JhbmdlKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBwZ29mZl90IHBnb2Zm
LA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvZG0tbG9nLXdyaXRlcy5jIGIvZHJpdmVycy9t
ZC9kbS1sb2ctd3JpdGVzLmMNCj4+IGluZGV4IGM5ZDAzNmQ2YmIyZS4uMDZiZGJlZDY1ZWIxIDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tZC9kbS1sb2ctd3JpdGVzLmMNCj4+ICsrKyBiL2RyaXZl
cnMvbWQvZG0tbG9nLXdyaXRlcy5jDQo+PiBAQCAtODg5LDExICs4ODksMTIgQEAgc3RhdGljIHN0
cnVjdCBkYXhfZGV2aWNlICpsb2dfd3JpdGVzX2RheF9wZ29mZihzdHJ1Y3QgZG1fdGFyZ2V0ICp0
aSwNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIGxvbmcgbG9nX3dyaXRlc19kYXhfZGlyZWN0X2Fj
Y2VzcyhzdHJ1Y3QgZG1fdGFyZ2V0ICp0aSwgcGdvZmZfdCBwZ29mZiwNCj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9uZyBucl9wYWdlcywgdm9pZCAqKmthZGRy
LCBwZm5fdCAqcGZuKQ0KPj4gKyAgICAgICAgICAgICAgIGxvbmcgbnJfcGFnZXMsIGVudW0gZGF4
X2FjY2Vzc19tb2RlIG1vZGUsIHZvaWQgKiprYWRkciwNCj4+ICsgICAgICAgICAgICAgICBwZm5f
dCAqcGZuKQ0KPj4gICB7DQo+PiAgICAgICAgICBzdHJ1Y3QgZGF4X2RldmljZSAqZGF4X2RldiA9
IGxvZ193cml0ZXNfZGF4X3Bnb2ZmKHRpLCAmcGdvZmYpOw0KPj4NCj4+IC0gICAgICAgcmV0dXJu
IGRheF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmLCBucl9wYWdlcywga2FkZHIsIHBmbik7
DQo+PiArICAgICAgIHJldHVybiBkYXhfZGlyZWN0X2FjY2VzcyhkYXhfZGV2LCBwZ29mZiwgbnJf
cGFnZXMsIG1vZGUsIGthZGRyLCBwZm4pOw0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgaW50IGxv
Z193cml0ZXNfZGF4X3plcm9fcGFnZV9yYW5nZShzdHJ1Y3QgZG1fdGFyZ2V0ICp0aSwgcGdvZmZf
dCBwZ29mZiwNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2RtLXN0cmlwZS5jIGIvZHJpdmVy
cy9tZC9kbS1zdHJpcGUuYw0KPj4gaW5kZXggYzgxZDMzMWQxYWZlLi43N2Q3MjkwMGU5OTcgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21kL2RtLXN0cmlwZS5jDQo+PiArKysgYi9kcml2ZXJzL21k
L2RtLXN0cmlwZS5jDQo+PiBAQCAtMzE1LDExICszMTUsMTIgQEAgc3RhdGljIHN0cnVjdCBkYXhf
ZGV2aWNlICpzdHJpcGVfZGF4X3Bnb2ZmKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBwZ29mZl90ICpw
Z29mZikNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIGxvbmcgc3RyaXBlX2RheF9kaXJlY3RfYWNj
ZXNzKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBwZ29mZl90IHBnb2ZmLA0KPj4gLSAgICAgICAgICAg
ICAgIGxvbmcgbnJfcGFnZXMsIHZvaWQgKiprYWRkciwgcGZuX3QgKnBmbikNCj4+ICsgICAgICAg
ICAgICAgICBsb25nIG5yX3BhZ2VzLCBlbnVtIGRheF9hY2Nlc3NfbW9kZSBtb2RlLCB2b2lkICoq
a2FkZHIsDQo+PiArICAgICAgICAgICAgICAgcGZuX3QgKnBmbikNCj4+ICAgew0KPj4gICAgICAg
ICAgc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYgPSBzdHJpcGVfZGF4X3Bnb2ZmKHRpLCAmcGdv
ZmYpOw0KPj4NCj4+IC0gICAgICAgcmV0dXJuIGRheF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBn
b2ZmLCBucl9wYWdlcywga2FkZHIsIHBmbik7DQo+PiArICAgICAgIHJldHVybiBkYXhfZGlyZWN0
X2FjY2VzcyhkYXhfZGV2LCBwZ29mZiwgbnJfcGFnZXMsIG1vZGUsIGthZGRyLCBwZm4pOw0KPj4g
ICB9DQo+Pg0KPj4gICBzdGF0aWMgaW50IHN0cmlwZV9kYXhfemVyb19wYWdlX3JhbmdlKHN0cnVj
dCBkbV90YXJnZXQgKnRpLCBwZ29mZl90IHBnb2ZmLA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWQvZG0tdGFyZ2V0LmMgYi9kcml2ZXJzL21kL2RtLXRhcmdldC5jDQo+PiBpbmRleCA2NGRkMGIz
NGZjZjQuLjhjZDUxODRlNjJmMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWQvZG0tdGFyZ2V0
LmMNCj4+ICsrKyBiL2RyaXZlcnMvbWQvZG0tdGFyZ2V0LmMNCj4+IEBAIC0xMCw2ICsxMCw3IEBA
DQo+PiAgICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9rbW9k
Lmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9iaW8uaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvZGF4
Lmg+DQo+Pg0KPj4gICAjZGVmaW5lIERNX01TR19QUkVGSVggInRhcmdldCINCj4+DQo+PiBAQCAt
MTQyLDcgKzE0Myw4IEBAIHN0YXRpYyB2b2lkIGlvX2Vycl9yZWxlYXNlX2Nsb25lX3JxKHN0cnVj
dCByZXF1ZXN0ICpjbG9uZSwNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIGxvbmcgaW9fZXJyX2Rh
eF9kaXJlY3RfYWNjZXNzKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBwZ29mZl90IHBnb2ZmLA0KPj4g
LSAgICAgICAgICAgICAgIGxvbmcgbnJfcGFnZXMsIHZvaWQgKiprYWRkciwgcGZuX3QgKnBmbikN
Cj4+ICsgICAgICAgICAgICAgICBsb25nIG5yX3BhZ2VzLCBlbnVtIGRheF9hY2Nlc3NfbW9kZSBt
b2RlLCB2b2lkICoqa2FkZHIsDQo+PiArICAgICAgICAgICAgICAgcGZuX3QgKnBmbikNCj4+ICAg
ew0KPj4gICAgICAgICAgcmV0dXJuIC1FSU87DQo+PiAgIH0NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21kL2RtLXdyaXRlY2FjaGUuYyBiL2RyaXZlcnMvbWQvZG0td3JpdGVjYWNoZS5jDQo+PiBp
bmRleCA1NjMwYjQ3MGJhNDIuLmQ3NGM1YTdhMGFiNCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
bWQvZG0td3JpdGVjYWNoZS5jDQo+PiArKysgYi9kcml2ZXJzL21kL2RtLXdyaXRlY2FjaGUuYw0K
Pj4gQEAgLTI4Niw3ICsyODYsOCBAQCBzdGF0aWMgaW50IHBlcnNpc3RlbnRfbWVtb3J5X2NsYWlt
KHN0cnVjdCBkbV93cml0ZWNhY2hlICp3YykNCj4+DQo+PiAgICAgICAgICBpZCA9IGRheF9yZWFk
X2xvY2soKTsNCj4+DQo+PiAtICAgICAgIGRhID0gZGF4X2RpcmVjdF9hY2Nlc3Mod2MtPnNzZF9k
ZXYtPmRheF9kZXYsIG9mZnNldCwgcCwgJndjLT5tZW1vcnlfbWFwLCAmcGZuKTsNCj4+ICsgICAg
ICAgZGEgPSBkYXhfZGlyZWN0X2FjY2Vzcyh3Yy0+c3NkX2Rldi0+ZGF4X2Rldiwgb2Zmc2V0LCBw
LCBEQVhfQUNDRVNTLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgJndjLT5tZW1vcnlfbWFw
LCAmcGZuKTsNCj4+ICAgICAgICAgIGlmIChkYSA8IDApIHsNCj4+ICAgICAgICAgICAgICAgICAg
d2MtPm1lbW9yeV9tYXAgPSBOVUxMOw0KPj4gICAgICAgICAgICAgICAgICByID0gZGE7DQo+PiBA
QCAtMzA4LDggKzMwOSw4IEBAIHN0YXRpYyBpbnQgcGVyc2lzdGVudF9tZW1vcnlfY2xhaW0oc3Ry
dWN0IGRtX3dyaXRlY2FjaGUgKndjKQ0KPj4gICAgICAgICAgICAgICAgICBpID0gMDsNCj4+ICAg
ICAgICAgICAgICAgICAgZG8gew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGxvbmcgZGFh
Ow0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGFhID0gZGF4X2RpcmVjdF9hY2Nlc3Mod2Mt
PnNzZF9kZXYtPmRheF9kZXYsIG9mZnNldCArIGksIHAgLSBpLA0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgJnBmbik7DQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICBkYWEgPSBkYXhfZGlyZWN0X2FjY2Vzcyh3Yy0+c3NkX2Rldi0+ZGF4
X2Rldiwgb2Zmc2V0ICsgaSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwIC0gaSwgREFYX0FDQ0VTUywgTlVMTCwgJnBmbik7DQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGRhYSA8PSAwKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByID0gZGFhID8gZGFhIDogLUVJTlZBTDsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gZXJyMzsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2RtLmMgYi9k
cml2ZXJzL21kL2RtLmMNCj4+IGluZGV4IDNjNWZhZDdjNGVlNi4uODI1ODY3NmEzNTJmIDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9tZC9kbS5jDQo+PiArKysgYi9kcml2ZXJzL21kL2RtLmMNCj4+
IEBAIC0xMDkzLDcgKzEwOTMsOCBAQCBzdGF0aWMgc3RydWN0IGRtX3RhcmdldCAqZG1fZGF4X2dl
dF9saXZlX3RhcmdldChzdHJ1Y3QgbWFwcGVkX2RldmljZSAqbWQsDQo+PiAgIH0NCj4+DQo+PiAg
IHN0YXRpYyBsb25nIGRtX2RheF9kaXJlY3RfYWNjZXNzKHN0cnVjdCBkYXhfZGV2aWNlICpkYXhf
ZGV2LCBwZ29mZl90IHBnb2ZmLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bG9uZyBucl9wYWdlcywgdm9pZCAqKmthZGRyLCBwZm5fdCAqcGZuKQ0KPj4gKyAgICAgICAgICAg
ICAgIGxvbmcgbnJfcGFnZXMsIGVudW0gZGF4X2FjY2Vzc19tb2RlIG1vZGUsIHZvaWQgKiprYWRk
ciwNCj4+ICsgICAgICAgICAgICAgICBwZm5fdCAqcGZuKQ0KPj4gICB7DQo+PiAgICAgICAgICBz
dHJ1Y3QgbWFwcGVkX2RldmljZSAqbWQgPSBkYXhfZ2V0X3ByaXZhdGUoZGF4X2Rldik7DQo+PiAg
ICAgICAgICBzZWN0b3JfdCBzZWN0b3IgPSBwZ29mZiAqIFBBR0VfU0VDVE9SUzsNCj4+IEBAIC0x
MTExLDcgKzExMTIsNyBAQCBzdGF0aWMgbG9uZyBkbV9kYXhfZGlyZWN0X2FjY2VzcyhzdHJ1Y3Qg
ZGF4X2RldmljZSAqZGF4X2RldiwgcGdvZmZfdCBwZ29mZiwNCj4+ICAgICAgICAgIGlmIChsZW4g
PCAxKQ0KPj4gICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICAgICAgICAgIG5yX3BhZ2Vz
ID0gbWluKGxlbiwgbnJfcGFnZXMpOw0KPj4gLSAgICAgICByZXQgPSB0aS0+dHlwZS0+ZGlyZWN0
X2FjY2Vzcyh0aSwgcGdvZmYsIG5yX3BhZ2VzLCBrYWRkciwgcGZuKTsNCj4+ICsgICAgICAgcmV0
ID0gdGktPnR5cGUtPmRpcmVjdF9hY2Nlc3ModGksIHBnb2ZmLCBucl9wYWdlcywgbW9kZSwga2Fk
ZHIsIHBmbik7DQo+Pg0KPj4gICAgb3V0Og0KPj4gICAgICAgICAgZG1fcHV0X2xpdmVfdGFibGUo
bWQsIHNyY3VfaWR4KTsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9wbWVtLmMgYi9k
cml2ZXJzL252ZGltbS9wbWVtLmMNCj4+IGluZGV4IDRhYTE3MTMyYTU1Ny4uYzc3YjdjZjE5NjM5
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+PiArKysgYi9kcml2ZXJz
L252ZGltbS9wbWVtLmMNCj4+IEBAIC0yMzksMjQgKzIzOSw0NyBAQCBzdGF0aWMgaW50IHBtZW1f
cndfcGFnZShzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBzZWN0b3JfdCBzZWN0b3IsDQo+Pg0K
Pj4gICAvKiBzZWUgInN0cm9uZyIgZGVjbGFyYXRpb24gaW4gdG9vbHMvdGVzdGluZy9udmRpbW0v
cG1lbS1kYXguYyAqLw0KPj4gICBfX3dlYWsgbG9uZyBfX3BtZW1fZGlyZWN0X2FjY2VzcyhzdHJ1
Y3QgcG1lbV9kZXZpY2UgKnBtZW0sIHBnb2ZmX3QgcGdvZmYsDQo+PiAtICAgICAgICAgICAgICAg
bG9uZyBucl9wYWdlcywgdm9pZCAqKmthZGRyLCBwZm5fdCAqcGZuKQ0KPj4gKyAgICAgICAgICAg
ICAgIGxvbmcgbnJfcGFnZXMsIGVudW0gZGF4X2FjY2Vzc19tb2RlIG1vZGUsIHZvaWQgKiprYWRk
ciwNCj4+ICsgICAgICAgICAgICAgICBwZm5fdCAqcGZuKQ0KPj4gICB7DQo+PiAgICAgICAgICBy
ZXNvdXJjZV9zaXplX3Qgb2Zmc2V0ID0gUEZOX1BIWVMocGdvZmYpICsgcG1lbS0+ZGF0YV9vZmZz
ZXQ7DQo+PiAtDQo+PiAtICAgICAgIGlmICh1bmxpa2VseShpc19iYWRfcG1lbSgmcG1lbS0+YmIs
IFBGTl9QSFlTKHBnb2ZmKSAvIDUxMiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBQRk5fUEhZUyhucl9wYWdlcykpKSkNCj4+IC0gICAgICAgICAgICAgICByZXR1
cm4gLUVJTzsNCj4+ICsgICAgICAgc2VjdG9yX3Qgc2VjdG9yID0gUEZOX1BIWVMocGdvZmYpID4+
IFNFQ1RPUl9TSElGVDsNCj4+ICsgICAgICAgdW5zaWduZWQgaW50IG51bSA9IFBGTl9QSFlTKG5y
X3BhZ2VzKSA+PiBTRUNUT1JfU0hJRlQ7DQo+PiArICAgICAgIHN0cnVjdCBiYWRibG9ja3MgKmJi
ID0gJnBtZW0tPmJiOw0KPj4gKyAgICAgICBzZWN0b3JfdCBmaXJzdF9iYWQ7DQo+PiArICAgICAg
IGludCBudW1fYmFkOw0KPj4NCj4+ICAgICAgICAgIGlmIChrYWRkcikNCj4+ICAgICAgICAgICAg
ICAgICAgKmthZGRyID0gcG1lbS0+dmlydF9hZGRyICsgb2Zmc2V0Ow0KPj4gICAgICAgICAgaWYg
KHBmbikNCj4+ICAgICAgICAgICAgICAgICAgKnBmbiA9IHBoeXNfdG9fcGZuX3QocG1lbS0+cGh5
c19hZGRyICsgb2Zmc2V0LCBwbWVtLT5wZm5fZmxhZ3MpOw0KPj4NCj4+ICsgICAgICAgaWYgKGJi
LT5jb3VudCAmJg0KPj4gKyAgICAgICAgICAgICAgIGJhZGJsb2Nrc19jaGVjayhiYiwgc2VjdG9y
LCBudW0sICZmaXJzdF9iYWQsICZudW1fYmFkKSkgew0KPj4gKyAgICAgICAgICAgICAgIGxvbmcg
YWN0dWFsX25yOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgIGlmIChtb2RlICE9IERBWF9SRUNP
VkVSWV9XUklURSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPj4g
Kw0KPj4gKyAgICAgICAgICAgICAgIC8qDQo+PiArICAgICAgICAgICAgICAgICogU2V0IHRoZSBy
ZWNvdmVyeSBzdHJpZGUgaXMgc2V0IHRvIGtlcm5lbCBwYWdlIHNpemUgYmVjYXVzZQ0KPj4gKyAg
ICAgICAgICAgICAgICAqIHRoZSB1bmRlcmx5aW5nIGRyaXZlciBhbmQgZmlybXdhcmUgY2xlYXIg
cG9pc29uIGZ1bmN0aW9ucw0KPj4gKyAgICAgICAgICAgICAgICAqIGRvbid0IGFwcGVhciB0byBo
YW5kbGUgbGFyZ2UgY2h1bmsoc3VjaCBhcyAyTWlCKSByZWxpYWJseS4NCj4+ICsgICAgICAgICAg
ICAgICAgKi8NCj4+ICsgICAgICAgICAgICAgICBhY3R1YWxfbnIgPSBQSFlTX1BGTigNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIFBBR0VfQUxJR04oKGZpcnN0X2JhZCAtIHNlY3RvcikgPDwg
U0VDVE9SX1NISUZUKSk7DQo+PiArICAgICAgICAgICAgICAgZGV2X2RiZyhwbWVtLT5iYi5kZXYs
ICJzdGFydCBzZWN0b3IoJWxsdSksIG5yX3BhZ2VzKCVsZCksIGZpcnN0X2JhZCglbGx1KSwgYWN0
dWFsX25yKCVsZClcbiIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlY3Rv
ciwgbnJfcGFnZXMsIGZpcnN0X2JhZCwgYWN0dWFsX25yKTsNCj4+ICsgICAgICAgICAgICAgICBp
ZiAoYWN0dWFsX25yKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGFjdHVhbF9u
cjsNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPiAN
Cj4gU2ltaWxhciBmZWVkYmFjayBhcyBDaHJpc3RvcGgsIGxldHMga2VlcCB0aGlzIHBhdGNoIGp1
c3QgdG8gdGhlIHNpbXBsZQ0KPiB0YXNrIG9mIHBsdW1iaW5nIHRoZSBAbW9kZSBhcmd1bWVudCB0
byBkYXhfZGlyZWN0X2FjY2VzcygpIGFuZCBzYXZlDQo+IHRoZSBsb2dpYyBjaGFuZ2VzIGZvciBE
QVhfUkVDT1ZFUllfV1JJVEUgdG8gYSBsYXRlciBwYXRjaC4gVGhlIGlkZWENCj4gYmVpbmcgdGhh
dCBpbiBnZW5lcmFsIHlvdSB3YW50IHRvIGxpbWl0IHRoZSBibGFzdCByYWRpdXMgb2YNCj4gcmVn
cmVzc2lvbnMgc28gdGhhdCBpdCBzaW1wbGlmaWVzIHJldmVydHMgaWYgbmVjZXNzYXJ5LiBJZiB0
aGVzZSBsb2dpYw0KPiBjaGFuZ2VzIGhhdmUgYSByZWdyZXNzaW9uIHRoZW4gcmV2ZXJ0aW5nIHRo
aXMgcGF0Y2ggYWxzbyB1bmRvZXMgYWxsDQo+IHRoZSBvdGhlciBpbm5vY2VudCBib2lsZXJwbGF0
ZSBwbHVtYmluZy4NCg0KR290IGl0LCB3aWxsIGRvLg0KDQp0aGFua3MhDQotamFuZQ0K
