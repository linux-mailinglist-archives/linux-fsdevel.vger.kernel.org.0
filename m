Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A848F4AAE76
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiBFIaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 03:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBFIai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:30:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8184AC06173B;
        Sun,  6 Feb 2022 00:30:38 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2164scSF009011;
        Sun, 6 Feb 2022 08:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yopP0RQu8F/OePGiMiZ9Q9O43E/n2ocb93dihfNKjVs=;
 b=L3lN8YPeucYfn41M3gx1+OtvD7pmZu7dEXwjR3qPdwK5rYKKipLeD1wdlyQTTVO/caJo
 X4X55YyLWTgD/69CyHMufzIQhwqdHTxYG9TK70iFXOuVlowRn0t47RQ3hP+P95jzEz14
 tGTIXI/I9SIOW0BVb5HcB6T5g2N3IwtIVswm8L7efwie3jRaB8+O+s+6sLXvYpJsJycA
 LumD+AjrjhKGQ0iVmQRdepZkSQzejsb73iDZ87ChEzTmovt35R69lFwTON8mMPV3cqvV
 t6FhCkn1LV9sZXcJhPwdmiHWkzJ2zDZnkhmkOcZrSI5Ej2LprRRzP/yfFMHH8ckes+LN IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fu2jurr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:30:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2168FI5o164454;
        Sun, 6 Feb 2022 08:30:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3e1jpkfhqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:30:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmFaEd46d1l/Hta4SLjFXlHw60hYJ9HPEgs/8e6YaocB62d9jRO4OkvLu5PZPQmjDQ7anBRNvQJWadTRxd5tUzq9SD7eGYEF1ClwAlmv6qIOMhZPtMp1mHea4cQt5j6retTRXvk++JSZdkB9EdGIQeIhNUt2mQTNzC8oHlVl0obPPr6VvQLix2Rh72FHZhPa6Xcm9Rf6fQrT8T40nnxjiKX1x/L0zf/GwTlJ1ZMMpY+9H4uJi893XGwUsB1hIKyBM4EsIAJgtUDQJeti6X5bSauU5r+P4YAy+9hBYb9sVLfkCnDyj5oh68qIoeWuqtOZtS31jiqKyNXWaa6vhC1TBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yopP0RQu8F/OePGiMiZ9Q9O43E/n2ocb93dihfNKjVs=;
 b=it8CImQCzheXwsFpyfm93hIf4cYIWujvGubFIvTXGOO9nQq286Jh0anZrRSIhrfZSsWRMuAXjNYCUWnI99BSOlELypSN3c3JNwb3NJMl4D797zv39M3/CuLR3NPl8pARBBZaTvxUDugy7ffqmdKuoA+A0VGBApK5f//os1YyN7BP3n10vu2xebUbsUJz9d43hyMZ5tpOofvATM+shs3mNGaM0RiK3/V51TzPqAt2ScNHvQWzWiuHLYMKwqubctk8fLexQ6dv80jwqi4g+3YCDDEVcKK0mqreWzXW5YHediUyahttHX+zI1MagNo92aacf13t2rOeEde3L8Idw3D0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yopP0RQu8F/OePGiMiZ9Q9O43E/n2ocb93dihfNKjVs=;
 b=vo3mpPUolxcjbNUrYgeZZGHJsKhQe+FX8E5igEtESYmNva0gAlaL5R+K5g31sbJCqA+SKgYuC3QUcHeH2UxKxjljBb7B6OHeg05zQNCok/hkVNyb8yL5QwYnpNSBiDBpXZrelwphBYXYM5zd6qaV0VkUx8tHBBMHsZLdCQM/F7s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3174.namprd10.prod.outlook.com (2603:10b6:a03:159::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 08:30:24 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 08:30:24 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v5 1/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Topic: [PATCH v5 1/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Index: AQHYFI6GHFAsB7tXYk+ZNKUkZMvm/qyARncAgACF2oCAAB3ogIAA9HMAgAEGwwCAA1kGAA==
Date:   Sun, 6 Feb 2022 08:30:24 +0000
Message-ID: <3fc16569-7730-2101-b494-94ef5291cf11@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-2-jane.chu@oracle.com>
 <YfqFWjFcdJSwjRaU@infradead.org>
 <d0fecaaa-8613-92d2-716d-9d462dbd3888@oracle.com>
 <950a3e4e-573c-2d9f-b277-d1283c7256cd@oracle.com>
 <YfvbyKdu812To3KY@infradead.org>
 <CAPcyv4g7Vqp6Z2+EXHdv95oqQxfdvPDAnzBiRG2KqobaHzOAsg@mail.gmail.com>
In-Reply-To: <CAPcyv4g7Vqp6Z2+EXHdv95oqQxfdvPDAnzBiRG2KqobaHzOAsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d363a2c-fb6f-4cb5-6c45-08d9e94aec1d
x-ms-traffictypediagnostic: BYAPR10MB3174:EE_
x-microsoft-antispam-prvs: <BYAPR10MB317414710CBF36B95105CBF8F32B9@BYAPR10MB3174.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUCe7FMcW1DVS6t8PqhaUNu48VFYLTIxHPvNhTjRmu4zrRH71gZZoWYoVVq27QiMVJ+KNlIkjlB7VsGVED91881wX61xbAT5Kk0X2CF/LzBQw6caYBahXtOwjjWybhhoHflt+dqLJm+LKFTPoKu8YbHcmN2WULJmv6gRnBLT9PYmpgh6F4VgcFFNP4Xu4Fw/VNuINTL2fZNtmf7kr0ctVT6+JQ69fFQuP1DU8s/6dRp0WkyWh2wkgW3URivvy9fofWQpiz29itBaAr4PPfq8nI1upbcU0fuWhDC96nHWtfbvwyGH6dDzyJXzjyLpIBLyixpfVGM6C3T1y9hEPCJSTeVlZntJYXTVcyejB5UoGjGzyO9BLoY92vCBkxTM34pqiMbhsjaOUQhUJVp5ijo1B68a34NmzUaMqW+Yo7MWchVpMRfz3s84h7Zb2JQoGCDFL/CEYxomDVtib8cgkW6lkwLjSYr2Kub5aBCEkUpuo8rxazBdwZT5jSusysYDZT4ZbwRsjJxlTJGVfGQqhJ36a7ORlHRTCnOspcEBT13s2gyuQ9zvH7v6Kyv8/JToZBl1g0n2CmoRQ6iWoeuv2D1DJ5j3iurN9vX4sINHUIr07s5BS8Vh2lrIkXAQSpwF4Ty2uDe7FWhPUPbmyHase26gDyu5rvuW3AGf+zUWL9xrf5Euwn0uWBtkC/aXH0Jggc6OZAvmPrEmpTRhzcoKGSkKk/m43/117aLZnx9z/RvLHbSZpBZZKzZQOtZfASCSnJY50bPhlBI+9QsCzHlfglFpJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(26005)(186003)(316002)(6512007)(6506007)(54906003)(71200400001)(122000001)(38100700002)(2906002)(2616005)(31686004)(53546011)(110136005)(31696002)(38070700005)(86362001)(44832011)(66946007)(5660300002)(508600001)(7416002)(8676002)(8936002)(4326008)(66446008)(66476007)(66556008)(76116006)(6486002)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDJkYXowZ3ZhS216bjFxTTQxYVBMaFN1bWF2OHU3WGttSHJCVlF2M3duaTgx?=
 =?utf-8?B?OStrMG1UVENJWG5SUUVEeTc2ajVSbUpERXZTb3c5QTRmTWYzVVJNemlUVWIx?=
 =?utf-8?B?bGo1VUpzaXhSOTFwMU1GaDhhazNFL3VlTjQ2RTIyWGtSSzJ3WXZIeVVldDB3?=
 =?utf-8?B?aU5RenZ5Y0lhNlZFSHpBbnpYRVRqL0M3TUVWa25yTEtqd3dQMkdnaEZwbG43?=
 =?utf-8?B?MFpJTEI0ZlBraDRxYkFKNnNuVGRrVTgrOW9hK2pELzZZN1NZcHM3Nm5VU3Fk?=
 =?utf-8?B?L3FuS0JodjVQdkUzMDdDRlJEVXdLU25rRjJVRWo4amJvenRIOCs3U2k0ZHVB?=
 =?utf-8?B?THQ2VnZtR0NlaTlXOU1IcFM3S1ZlQW05NFp0d2xUdTIrTitEL3pRM0RwY2ls?=
 =?utf-8?B?NkpHdXBJbnNobFkzdXBwY0RUVkRUTktkMFRuWFU5c0xDVXB2Q0xrS2VwQ0Ro?=
 =?utf-8?B?YmFNemJ0V2dvUURQbVJWMnE5MDZ3OXZPWGdZUlFvc0doU2lDK0FmOWhYaStn?=
 =?utf-8?B?Y2ZqYnlKQkxISVFGRHFjYW5EYUZkaEtNcmh3NDdOUFVvcDEzeUlPVzNLcTdq?=
 =?utf-8?B?TE4xYXhOTVdXY2pKVjlqQ2tZLzEyaWJGNHdWVUhmbGNvaS9ZY09VcGxIQ0Jk?=
 =?utf-8?B?TFFqQzFiVlRESmNMRm5HVmhSWTI3emhoNEZJS0F6QTAwL1JybWlsREx3ay90?=
 =?utf-8?B?RlBxZjNGZGdiRXlxRFE1VUd3cFdvYWRPOUVPTzdnNnUxYlYrYmR2cGNJVFhn?=
 =?utf-8?B?NjF3U1BNMHd1NXJvbTF1cmxwNGlvZHVQTnlsbEtIamMybW1yUEdFWGlZSys2?=
 =?utf-8?B?ODRiZUdvTGJqN1ZvT2dTT3g2ckVSMkY1cGozckN2bzJLOHFwZ0Z2elRacWhH?=
 =?utf-8?B?R1VQQ2RMNnRlWE9wZlhxaEtLdzNzclgyd2lTUFJTOGNmWkhvRXpxTjY4U2lp?=
 =?utf-8?B?cTdTOERRcjBGam9vb0JzU215cnpqR205Rkl4VjFDTkd1QXdyMENMenovZWlU?=
 =?utf-8?B?YUM4eE5LSGVQeXAwTHQ5NUxkZ3dvU0FuY3hEdEdLdWxzcG8zRldDRjFZdlRX?=
 =?utf-8?B?RHJCTmpFUmNUWXFpR3RKV25OVEF2Y2cyNDVwYk10ZHdMUUpJdWV2a2FNbVp2?=
 =?utf-8?B?TVRlc2VGT20zTVkvdENyQVRWMnlzNFI0dk93ZUVvZ1M5QXlVakd5SVJ2a2U3?=
 =?utf-8?B?RklFZlg2cHMyUzN1bllhZTIycGhMcnhOVThEakg2TlZyWTdqV0FRNEZsWFJV?=
 =?utf-8?B?NWlmc0tPNWdHTHRQelFCd2V2clM5TEFNaVZyblR2N0JvTU9MUk9RSEdFUDVr?=
 =?utf-8?B?YjhURTJQYzA0Vi9PNitmTlNoRk9QajBEMVVBMGxmMFN5Wk01WVJ3N1o0TlRF?=
 =?utf-8?B?a1c2b2Fuc3dEajdReks2ejNubEowblM5bDhwUzRwZUMxQ3RadkVaRmNGcWRr?=
 =?utf-8?B?cHdsbG1OOVUwRUxocWdjVzZaNUpJMGRqOVFnSXR2TEUxVTkrajBYd1lrcFBr?=
 =?utf-8?B?S1cvUWVqajdxU0tKb3RZMi9JbEJreGNHSFBqbTJTRVVNZS9KVkpSQ1Y1VmlM?=
 =?utf-8?B?bVdMalhBMVdYc0pqT3lnd1VwNndZVHFCcXlJKzhCK295VmNwMkdyaW53OGxu?=
 =?utf-8?B?L0NLZnhXcG9xZ3kydS9jSE9KY2RJRWY4aktnSEdGTXpWNC9zVGw5TlRObWQz?=
 =?utf-8?B?MDdHK1JXM1RmcDQ0UnlOYWo4TExQZzdXOEVZMEtjYmJ3S2h3emlNVzhyNFBS?=
 =?utf-8?B?Y1h4djhobzFqUWdXU1FUc2JkL0M5NUpXcjJLWVZzVTgrT3dCc3pYNndIcnJx?=
 =?utf-8?B?NFJrV1FLZkd5RDJWbVcxOEpYZE1uZ3paSHlnaEl6LzluYWdnVHdwUFNlWkhW?=
 =?utf-8?B?Q2M3SzFsSjdJYXE1OTJ2TitXdFE0SG5uZkZPV2hlem8ra1hUa1prSjgwRkVD?=
 =?utf-8?B?TFZ1ZmRXTDNhdTNsdEtmcnlGS2Q4SnNaTWcrVHZGZmxNdC9BUm1uWEtLd0oz?=
 =?utf-8?B?b3drODhOcEVaTEdnMVRCa2Y4YlVkVE1uMnU1ZjY5M0l2YkhOdzdGb2tEOUgr?=
 =?utf-8?B?c3JZUk5INlFhdlcxYUJ3WkpUTDFSZzFOZ0RwOUVSR1JvMTZLeU80Snk4bXph?=
 =?utf-8?B?aE9rb1lHU1FPM0k3eTNodXo1VE5vRlpxYnN3N29JSmJEVFN6bGNsblBiRkU4?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FD8B29ED170CD41B820970C78775FB7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d363a2c-fb6f-4cb5-6c45-08d9e94aec1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 08:30:24.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teazSoAPKNd9J1HEJOBfrVHtC+GmZ8B720qKbs8uqx0xlUS8V7H4rK2wPav8eVOb9FpaA/OEb0ZVavm97r8I6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3174
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060060
X-Proofpoint-ORIG-GUID: Acn1tSbgj6OZOZqAtYa5r7vf1QpPWIjX
X-Proofpoint-GUID: Acn1tSbgj6OZOZqAtYa5r7vf1QpPWIjX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8zLzIwMjIgOToyMyBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBPbiBUaHUsIEZlYiAz
LCAyMDIyIGF0IDU6NDIgQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3
cm90ZToNCj4+DQo+PiBPbiBXZWQsIEZlYiAwMiwgMjAyMiBhdCAxMTowNzozN1BNICswMDAwLCBK
YW5lIENodSB3cm90ZToNCj4+PiBPbiAyLzIvMjAyMiAxOjIwIFBNLCBKYW5lIENodSB3cm90ZToN
Cj4+Pj4+IFdvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byBtb3ZlIHRoZXNlIGhlbHBlcnMg
b3V0IG9mIGxpbmUgcmF0aGVyDQo+Pj4+PiB0aGFuIGV4cG9ydGluZyBfc2V0X21lbW9yeV9wcmVz
ZW50Pw0KPj4+Pg0KPj4+PiBEbyB5b3UgbWVhbiB0byBtb3ZlDQo+Pj4+ICAgICAgcmV0dXJuIGNo
YW5nZV9wYWdlX2F0dHJfc2V0KCZhZGRyLCBudW1wYWdlcywgX19wZ3Byb3QoX1BBR0VfUFJFU0VO
VCksIDApOw0KPj4+PiBpbnRvIGNsZWFyX21jZV9ub3NwZWMoKSBmb3IgdGhlIHg4NiBhcmNoIGFu
ZCBnZXQgcmlkIG9mIF9zZXRfbWVtb3J5X3ByZXNlbnQ/DQo+Pj4+IElmIHNvLCBzdXJlIEknbGwg
ZG8gdGhhdC4NCj4+Pg0KPj4+IExvb2tzIGxpa2UgSSBjYW4ndCBkbyB0aGF0LiAgSXQncyBlaXRo
ZXIgZXhwb3J0aW5nDQo+Pj4gX3NldF9tZW1vcnlfcHJlc2VudCgpLCBvciBleHBvcnRpbmcgY2hh
bmdlX3BhZ2VfYXR0cl9zZXQoKS4gIFBlcmhhcHMgdGhlDQo+Pj4gZm9ybWVyIGlzIG1vcmUgY29u
dmVudGlvbmFsPw0KPj4NCj4+IFRoZXNlIGhlbHBlcnMgYWJvdmUgbWVhbnMgc2V0X21jZV9ub3Nw
ZWMgYW5kIGNsZWFyX21jZV9ub3NwZWMuICBJZiB0aGV5DQo+PiBhcmUgbW92ZWQgdG8gbm9ybWFs
IGZ1bmN0aW9ucyBpbnN0ZWFkIG9mIGlubGluZXMsIHRoZXJlIGlzIG5vIG5lZWQgdG8NCj4+IGV4
cG9ydCB0aGUgaW50ZXJuYWxzIGF0IGFsbC4NCj4gDQo+IEFncmVlLCB7c2V0LGNsZWFyfV9tY2Vf
bm9zcGVjKCkgY2FuIGp1c3QgbW92ZSB0byBhcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jLg0K
DQpHb3QgaXQsIHdpbGwgZG8uDQoNCnRoYW5rcyENCi1qYW5lDQo=
