Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7D670EAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 01:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjARAfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 19:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjARAe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:34:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEA746154;
        Tue, 17 Jan 2023 16:03:41 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLwehC024590;
        Wed, 18 Jan 2023 00:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=whkpCj/BtIX/ATEYNddFKbtdMo5n02C1l9+PDYv7dLc=;
 b=lXyzVYQAPyNBxot95c/aF8jxa8PXPPn4rjVMyyi56F/Mq0410yf5zfCXrTOxMgRR+gJW
 BUWR69wzD8re9YNfHi4DrdCqMSdxNSYvQ043da8UdEwWs2Ne5QAaoO3FhKRk21X2Su4d
 ZQuY+GSh2hsqgeCnZn8xWPR26knCnOxPxqLaISMA2H/Qx1GuM2RXr98Yym2OsQnF7HmG
 GRNm02GKVoLDXV3qVXG4pCkLTachOq6ifvgtlklHjdicKJfKwQqUM4Yp1v05oLa0Iz1G
 vNBjPnfAAR0triy8Fq5iOzxx1Hq1J3YsXRFUDvGQzQm+A6EyuGF1K5ZX4eN/uJ5SLEDW pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaaebrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 00:03:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HNXqS7022730;
        Wed, 18 Jan 2023 00:03:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n65f50yh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 00:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIZb5Fr9ASfOFJ2BPMIdOiLW7IDjKe7TtLZvoXv3VTF1g3hNXIDOSaNw4yqKpnM3VgN4YD3XM94LexVIUU9lNqH62zpaWCTBWv6c0xn7cJ28S+5P+zdS6PyESjMIG1vkyQxnPfc5F/KjVHLK0qaA7VW5NWSLsZoeDZEx0x1RHZFuNSrQZVh8uOZs1ShgByevbe7oHYMqjCsvDdq7TQ6W9PJE9YCh6uL6hEcMC4OOKV9XxcmCpfJNUkdyCaZF8e+Hgq2anOAWgZRh2+DY2tkdZ3cCLw/Qlollotb2qJZHmBkhnSfvIqWU+GBFRCW70UEvkTSvSddeuc3ECmpaGl0v6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whkpCj/BtIX/ATEYNddFKbtdMo5n02C1l9+PDYv7dLc=;
 b=LKohdsgsLrfxuZ2kwSMqJfOoXo/y8D7kB1aFAA86bRrY2oNvmUcnyWyc8Gpm0Bc4xMN4xh96qw/hfqV9Gy7vOmZdcH+sQTJEB9xAIH0Yq1IFCnKRevwUxqL3pG5ZXD98pSokQ5HfhAi+Z7dIRGPxXQnnsoogj15Ac7c3AHbYu4lkXmoVenjPpGuM7rEGwv63XgVddQjhXHH/le0vIuMjHoGOsQCyAW5Q1qzZBbRkYhSy80nE7mOWvHNQKR0B3/7I813k7YxK/OOvcSn6HSLJ6Y0JIHxb5Sr1bgjd67rc7jZXm0rYE0Win26kXIxyqWh2d6SUwGC6zRlhKsUZRHI7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whkpCj/BtIX/ATEYNddFKbtdMo5n02C1l9+PDYv7dLc=;
 b=N4WPTbMbR9zfQdF5rD82w+2rSRBEIbfqE01M8Ia10kE4ak8P+N05tsYzpcTP6vCdue02qAyw4IYWHLxmOTWeMIUXlYguGwOliWJg7uenjIfp/XJ1ARzSYwQJt285ib8D1teiLkooODrH+U2HAe6tJ0tUrqd2GDU+3+fi7VQZYqs=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB6662.namprd10.prod.outlook.com (2603:10b6:806:2b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Wed, 18 Jan
 2023 00:03:29 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::eaff:9f55:4641:db38]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::eaff:9f55:4641:db38%5]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 00:03:29 +0000
From:   Allison Henderson <allison.henderson@oracle.com>
To:     "djwong@kernel.org" <djwong@kernel.org>
CC:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 04/14] xfs: document the user interface for online fsck
Thread-Topic: [PATCH 04/14] xfs: document the user interface for online fsck
Thread-Index: AQHZHJ5SV0oVuMUD1U6yXXybMDYMx66jZ1gA
Date:   Wed, 18 Jan 2023 00:03:29 +0000
Message-ID: <4098826a3f69a53fd23df08eb8ffbb733d7f75ce.camel@oracle.com>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
         <167243825217.682859.14201039734624895373.stgit@magnolia>
In-Reply-To: <167243825217.682859.14201039734624895373.stgit@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SA1PR10MB6662:EE_
x-ms-office365-filtering-correlation-id: 9bcbc5dc-7085-4feb-bd87-08daf8e76e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xSFuPsMgHczmOkNbn/EMO1Ek/Xmwj4Lqe3UDaJHoSCVriq4EtA4SiN31weBRpiSd9slibXJDeCyo5ZwQA5bNLXpqxLvokdsqblLXIZLyX7A0w02y9d+LqD3Z9pzVVl9Q83MUHzoCcHFeJhd1ss0Imnp6jyezVe8GLtoBf4Of+fKZknOyrPI96AhtEpBUZDPOnuO0F2zciGEPOf3y4pYc5Ogv7dhPjKRscODUJYGzSnj1g5nPQCn7StDvSvko17vldLXlSvVF9tmpuoIUjbn5YG6N4j3MmOS+ZMr/k1od3/7zmQwBAS7/IUTH12A2R6lz76RVp0LxlK+xDnX3khlNPxMyRoYZZluhhT414IJjno4+RCpwtKlZyezg3xo2W/nhhF7HZshm724qOQOTpanEJzPcMPRtLv8R8yjx9EjNRgCmKb7YT93MroM88ox2VbvJNl05pp+Dx27kHPm+52fkRIdSde/P22qzb6MUdzn5txG0K8exdxFJldrS4DDe7dTypcc/B5FKHXlOVsoBonPlDJ9tIx2U9i89wsaLil3EI3xW5BJAUdRRtO1M4mP8rGLh5hh4APpsetvtJ5qxWYKznayKTlVXe5PK0sdyuyUKT2MaNZVWFQ05h4aJVHa49Xqvc3mRKNbIRJXky5NEO1ic1zq/JRYVx0rH/J877zpDeFk2icFYjgtpin4+qlcy6Vw8pn0smo7LFb2TP5pwsyq7qgn0CLYVOAPe4W7ljsCXOsNePobpLD5N88E7gghu9ozINyV9OSurIuSpAiU+L5B+Rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(122000001)(38100700002)(36756003)(86362001)(44832011)(6486002)(5660300002)(41300700001)(8936002)(316002)(6916009)(64756008)(66946007)(66556008)(66446008)(66476007)(76116006)(8676002)(4326008)(2906002)(4001150100001)(2616005)(83380400001)(966005)(54906003)(478600001)(71200400001)(26005)(38070700005)(6506007)(6512007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXUvYitYWGFpYVAvaFpnT3JwVzZlZGZIUXIwVFJlNHQvWGRPY2hTYW9ZTFZX?=
 =?utf-8?B?Wk53M2tkTnNUdlcwM1ZRRU9wcU5VSGxkQi9La2IrVTV1U2dvU0dheE1LOEFi?=
 =?utf-8?B?WTNGMzVVdGZKSnVLZlVSeXNockpROFhaZFJ4aWYwaWgxNjBUUlpYbHMzMkZW?=
 =?utf-8?B?WGdzcklQMEJVMTlnYTBYSHBDTjFPc3dtbUtQaUR3ODlZQTRwRXRiMjRMQXVa?=
 =?utf-8?B?QWJucmt0U3gxQUE5K2JQRTVIVHArK2RmblNISlhBaTRmelUrZ0VjbkQySUla?=
 =?utf-8?B?NVJQcEJNTzU0L1FhbFRrNjhJcUFQUHRyWGp1UEZLdDFtL0t4YWtCdHlKem0r?=
 =?utf-8?B?Y0h0YVFXWXRGNUFydEY5RXBkakhYSFk2dlNQVW1rY21QYWdSRTJpNjlLMkkv?=
 =?utf-8?B?dzA1ZnZwWXZIUEpyb3hXK2VjZTRUU1ZndjEzZHRqSFVKYkExWHBmUGZRcS80?=
 =?utf-8?B?SnVhL3kvam14Qi9FSEtIQWp5bmRBVTM3MHRBU2VaYzNrOW9qUUUxMXlDYlVQ?=
 =?utf-8?B?Sk1MbVpMZ3hnSFQwSXpPaVZvRXY2YVRva2ZQeFBKOG5CVkE4SldscjlBWnpY?=
 =?utf-8?B?U2hCNVNXdkhmSlBsVG5NeUFlUFROSmxtSVYzQ1huTkJoaDRiVDNVNzRmSGZK?=
 =?utf-8?B?VnRtU3hLVW8rclNGOUN2djRwMGF6cnIyNTVGSytYckNsS1ltL2ljVUw5UldJ?=
 =?utf-8?B?QnBOYjkvZWJkQitxZVpncHB5eURYQks5cjhwU0NCd25KZGhkQ0ViTEhDNDd0?=
 =?utf-8?B?bXRWWlFrOCs1S0FBMWNCRjZuV1o1ZE1SUGNodWlPWElBU2l1elN4YTFyRHdr?=
 =?utf-8?B?eDVHak1Sb0VjTTZZemU1SEFlWS9RTUZueTVQNnB1MWJMYmRqRmlCNjlNd0FS?=
 =?utf-8?B?OXJSbERDTzVKYTFEaXdVa3FCelk2YkVkRjVyK2FIRk1MV05JSFhnNU5ua1Uz?=
 =?utf-8?B?aDkzcjA0OW9UbkVaTnRaekdTZ2E1UjY0dlV6L21STWIveGg0am5vUHhTWnJY?=
 =?utf-8?B?UWVGSExvU2UwaURMUTFBUERlM3NxOWk1ZWk0VVdzS1pVNk5obEN0THIrd2pp?=
 =?utf-8?B?SkxyQ0J0VzVIME5DWGM2YzZUazd3TTZhemIxb0RuU21XUmcvSWQrV2hRUzFl?=
 =?utf-8?B?T25KL3RDTmRFYTBxb1NoZmpYM2VBNlJ1ZTdwVmFOQnhjZ2FzWkF1cDVrenJM?=
 =?utf-8?B?TVhiTlM0NFlETStnTHVGK290S21ZbjNHK1kyNXlpZUlkU2oxUUc4YUFtWlZj?=
 =?utf-8?B?SDFEL0h0cG4zZmVZTXR4RW8vdnE4QUh1T1ArVGw2UkdyRVRJdFMxNTRSdmlt?=
 =?utf-8?B?QXJOYjBydllaM0ZOWlJHTHlVN3cwMHV5TFJiZ2M2OVF6T2xGd1A4ajA3VDk5?=
 =?utf-8?B?MGFhR3ByNVVVamhmT2NjbTFsNXVGMXRDRU5WT2lOM0s5L0R1eVhFdW9PeEYr?=
 =?utf-8?B?bWlJNDVxa0FTQzZqd0NldDFkT3ZIbTZMVmRBR0dMdkF2c0E5d3MreTBzWlNV?=
 =?utf-8?B?ZStwMWJFRlJHUnlPODhJcjdkaTlDcCtlbGErZHkyVDFCcmlJTHZpRmRwb0Rx?=
 =?utf-8?B?bm92bXlFM0s4aE5GNE4vb1lvK0FLTG1EaHAzYURJV21sSVVzMUhqL1d6dzBJ?=
 =?utf-8?B?MWFDTVFMZWxCSkZRamdaMkdqNXNKMWl3c2d4dURKamE0OE5CMkxFc2NNMDZR?=
 =?utf-8?B?c2Y5MndsUjh6K2p4UXlDV25pRHcvVlUwUFRNcXQxRkUydWRKZWE5aUpkSjgz?=
 =?utf-8?B?a3l3QjJnbU5iVXdQSVhLdVZYYTZ3NlIvSTJQYU1Za1V6a1A0V0JzMjBhNUl5?=
 =?utf-8?B?bWZvSzhPcGtpdmJLM0tTLzB4T3cxRHVycm94WmYwazYzT1lxQUlidlcwWGNj?=
 =?utf-8?B?R1dmbm5oQlF0bmhiS2I5MnBvRitycXVpTmVhOWdNWXdTaFRDaXg1Nk9tWkNh?=
 =?utf-8?B?SkZuYXh4alFsenJlRmE3UWtIYXVyNHlIOHMyZDMwSHlaMXk3bExHb3N3b3c0?=
 =?utf-8?B?R1JYMURuVTR3UTBBbE1pZmxMM291WmhHRThHZ2VralZyc1JsMlNIUnRmNmpx?=
 =?utf-8?B?MWZPKzBHSUF4WjhLcmxvemRELzM2cGlCRWdVOGVTdURRbmFMMlNwbFhRUytY?=
 =?utf-8?B?QjFMTlp4d3FJMHB4NUhMelRiTCtkSG9UKzk2a082M3ZlZEVSMEkvMGlRSDFT?=
 =?utf-8?Q?k+jlsNlWr87RD5c8+yl1h3U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F104827E7CA204BBD8274451BDBFC6A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pjGIORnxvB33p9f24jWqb27oJl/wO1OFpt0MXrtuxB3orreVYYHsuNGVTSztnh7EgUWPHw5I1t5Ln8MBZEUiD/o9RrBruabD37n428FfrtQ0sAzuROPMK2aO2UEkm2Z1p97norhl78G7u3x8dY4Dxo3ylgJxvdx7dkFcK+uoJTBAawpu0V8+1lMEUzu2k4TjqPskLr5fjEsuLMc9i9ATw2gkeRlNL8OHxM1/GF/79djnKGBzfg/er8hHUUv7+iltUJN/ToCdzCGgJurkFEMoBbrwM3Ja6GxavD33lry2fuM8hXJfuqsMm5fvJ5TZvv1IX7IKXyPGNeJpW5fm4rwuusbjJDNHsLw91nIaZxZmT5GBalUtxKRzix8SILRh9Z61HdFmhXj5HuJn1j75QtrZJtFO5tngbY8X1ep7r18ikZRJ7JiRI2uX1bhE3pV7vYDEyW3fOCtClpl7mBZhBmgBJ8SiZpH6y/SQ39OLiNtktfDm4q2cT9Gin3nvI4eEYD0712CWC8taxvJuQfVMxZHcHkLw1Hn+EgUa8A4//JNgGB6hL85VvZeYZDW4U0jgkNXd0FmZXNqSkGIT1gz4o/oNLL/TN/NnwcvZOTA1i8cTI9JvhXyvBYQSbtZG4VjMKToy+LPdVr2iW/Eax5tBKbTvI9nLm93sm5LwE1pA7TuBZu2kMtOtMmrw3Y7R9zupdXqbB7QnJOhHSSezPlJUjY7c7VLPKCnAlBR5x2/5vI3O+FngERoT7rOTFIuR2l3usSs1S/72+XpmkiHLFecFRUNitOMlgHFMAI8eYJJ6uWdDBa9cvN4jK143Yv9+QKcw2UMZcmjhMiGwWT3sEdWqHgYcEIZQm7mfPDJAOAKw5DmVdvADXWKepab2Tj1Op4bGDdqa
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcbc5dc-7085-4feb-bd87-08daf8e76e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 00:03:29.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FZLHVkmKeDb52FrZY9r4T3wOtLmpm1D7uI7Ho0+aL5wq72mFb7RQ/WTvlZsT/74aEnsKX92lT/zTgr4TUcQLSW4A9fExVLNWLwVKVz2T4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_11,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170192
X-Proofpoint-GUID: HQVeCgf1vjDW_AeI8Gim0rOZPD8SwZqz
X-Proofpoint-ORIG-GUID: HQVeCgf1vjDW_AeI8Gim0rOZPD8SwZqz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTMwIGF0IDE0OjEwIC0wODAwLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6
DQo+IEZyb206IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+DQo+IA0KPiBTdGFy
dCB0aGUgZm91cnRoIGNoYXB0ZXIgb2YgdGhlIG9ubGluZSBmc2NrIGRlc2lnbiBkb2N1bWVudGF0
aW9uLA0KPiB3aGljaA0KPiBkaXNjdXNzZXMgdGhlIHVzZXIgaW50ZXJmYWNlIGFuZCB0aGUgYmFj
a2dyb3VuZCBzY3J1YmJpbmcgc2VydmljZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhcnJpY2sg
Si4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiDCoC4uLi9maWxlc3lzdGVtcy94
ZnMtb25saW5lLWZzY2stZGVzaWduLnJzdMKgwqDCoMKgwqDCoMKgwqAgfMKgIDExNA0KPiArKysr
KysrKysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMTQgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3hmcy1vbmxp
bmUtZnNjay1kZXNpZ24ucnN0DQo+IGIvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy94ZnMtb25s
aW5lLWZzY2stZGVzaWduLnJzdA0KPiBpbmRleCBkNjMwYjZiZGJlNGEuLjQyZTgyOTcxZTAzNiAx
MDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy94ZnMtb25saW5lLWZzY2st
ZGVzaWduLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3hmcy1vbmxpbmUt
ZnNjay1kZXNpZ24ucnN0DQo+IEBAIC03NTAsMyArNzUwLDExNyBAQCBQcm9wb3NlZCBwYXRjaHNl
dHMgaW5jbHVkZSBgZ2VuZXJhbCBzdHJlc3MNCj4gdGVzdGluZw0KPiDCoDwNCj4gaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZGp3b25nL3hmc3Rlc3RzLWRl
di5nDQo+IGl0L2xvZy8/aD1yYWNlLXNjcnViLWFuZC1tb3VudC1zdGF0ZS1jaGFuZ2VzPmBfDQo+
IMKgYW5kIHRoZSBgZXZvbHV0aW9uIG9mIGV4aXN0aW5nIHBlci1mdW5jdGlvbiBzdHJlc3MgdGVz
dGluZw0KPiDCoDwNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvZGp3b25nL3hmc3Rlc3RzLWRldi5nDQo+IGl0L2xvZy8/aD1yZWZhY3Rvci1zY3J1Yi1z
dHJlc3M+YF8uDQo+ICsNCj4gKzQuIFVzZXIgSW50ZXJmYWNlDQo+ICs9PT09PT09PT09PT09PT09
PQ0KPiArDQo+ICtUaGUgcHJpbWFyeSB1c2VyIG9mIG9ubGluZSBmc2NrIGlzIHRoZSBzeXN0ZW0g
YWRtaW5pc3RyYXRvciwganVzdA0KPiBsaWtlIG9mZmxpbmUNCj4gK3JlcGFpci4NCj4gK09ubGlu
ZSBmc2NrIHByZXNlbnRzIHR3byBtb2RlcyBvZiBvcGVyYXRpb24gdG8gYWRtaW5pc3RyYXRvcnM6
DQo+ICtBIGZvcmVncm91bmQgQ0xJIHByb2Nlc3MgZm9yIG9ubGluZSBmc2NrIG9uIGRlbWFuZCwg
YW5kIGEgYmFja2dyb3VuZA0KPiBzZXJ2aWNlDQo+ICt0aGF0IHBlcmZvcm1zIGF1dG9ub21vdXMg
Y2hlY2tpbmcgYW5kIHJlcGFpci4NCj4gKw0KPiArQ2hlY2tpbmcgb24gRGVtYW5kDQo+ICstLS0t
LS0tLS0tLS0tLS0tLS0NCj4gKw0KPiArRm9yIGFkbWluaXN0cmF0b3JzIHdobyB3YW50IHRoZSBh
YnNvbHV0ZSBmcmVzaGVzdCBpbmZvcm1hdGlvbiBhYm91dA0KPiB0aGUNCj4gK21ldGFkYXRhIGlu
IGEgZmlsZXN5c3RlbSwgYGB4ZnNfc2NydWJgYCBjYW4gYmUgcnVuIGFzIGEgZm9yZWdyb3VuZA0K
PiBwcm9jZXNzIG9uDQo+ICthIGNvbW1hbmQgbGluZS4NCj4gK1RoZSBwcm9ncmFtIGNoZWNrcyBl
dmVyeSBwaWVjZSBvZiBtZXRhZGF0YSBpbiB0aGUgZmlsZXN5c3RlbSB3aGlsZQ0KPiB0aGUNCj4g
K2FkbWluaXN0cmF0b3Igd2FpdHMgZm9yIHRoZSByZXN1bHRzIHRvIGJlIHJlcG9ydGVkLCBqdXN0
IGxpa2UgdGhlDQo+IGV4aXN0aW5nDQo+ICtgYHhmc19yZXBhaXJgYCB0b29sLg0KPiArQm90aCB0
b29scyBzaGFyZSBhIGBgLW5gYCBvcHRpb24gdG8gcGVyZm9ybSBhIHJlYWQtb25seSBzY2FuLCBh
bmQgYQ0KPiBgYC12YGANCj4gK29wdGlvbiB0byBpbmNyZWFzZSB0aGUgdmVyYm9zaXR5IG9mIHRo
ZSBpbmZvcm1hdGlvbiByZXBvcnRlZC4NCj4gKw0KPiArQSBuZXcgZmVhdHVyZSBvZiBgYHhmc19z
Y3J1YmBgIGlzIHRoZSBgYC14YGAgb3B0aW9uLCB3aGljaCBlbXBsb3lzDQo+IHRoZSBlcnJvcg0K
PiArY29ycmVjdGlvbiBjYXBhYmlsaXRpZXMgb2YgdGhlIGhhcmR3YXJlIHRvIGNoZWNrIGRhdGEg
ZmlsZSBjb250ZW50cy4NCj4gK1RoZSBtZWRpYSBzY2FuIGlzIG5vdCBlbmFibGVkIGJ5IGRlZmF1
bHQgYmVjYXVzZSBpdCBtYXkgZHJhbWF0aWNhbGx5DQo+IGluY3JlYXNlDQo+ICtwcm9ncmFtIHJ1
bnRpbWUgYW5kIGNvbnN1bWUgYSBsb3Qgb2YgYmFuZHdpZHRoIG9uIG9sZGVyIHN0b3JhZ2UNCj4g
aGFyZHdhcmUuDQo+ICsNCj4gK1RoZSBvdXRwdXQgb2YgYSBmb3JlZ3JvdW5kIGludm9jYXRpb24g
aXMgY2FwdHVyZWQgaW4gdGhlIHN5c3RlbSBsb2cuDQo+ICsNCj4gK1RoZSBgYHhmc19zY3J1Yl9h
bGxgYCBwcm9ncmFtIHdhbGtzIHRoZSBsaXN0IG9mIG1vdW50ZWQgZmlsZXN5c3RlbXMNCj4gYW5k
DQo+ICtpbml0aWF0ZXMgYGB4ZnNfc2NydWJgYCBmb3IgZWFjaCBvZiB0aGVtIGluIHBhcmFsbGVs
Lg0KPiArSXQgc2VyaWFsaXplcyBzY2FucyBmb3IgYW55IGZpbGVzeXN0ZW1zIHRoYXQgcmVzb2x2
ZSB0byB0aGUgc2FtZSB0b3ANCj4gbGV2ZWwNCj4gK2tlcm5lbCBibG9jayBkZXZpY2UgdG8gcHJl
dmVudCByZXNvdXJjZSBvdmVyY29uc3VtcHRpb24uDQo+ICsNCj4gK0JhY2tncm91bmQgU2Vydmlj
ZQ0KPiArLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsNCkknbSBhc3N1bWluZyB0aGUgYmVsb3cgc3lz
dGVtZCBzZXJ2aWNlcyBhcmUgY29uZmlndXJhYmxlIHJpZ2h0Pw0KPiArVG8gcmVkdWNlIHRoZSB3
b3JrbG9hZCBvZiBzeXN0ZW0gYWRtaW5pc3RyYXRvcnMsIHRoZSBgYHhmc19zY3J1YmBgDQo+IHBh
Y2thZ2UNCj4gK3Byb3ZpZGVzIGEgc3VpdGUgb2YgYHN5c3RlbWQgPGh0dHBzOi8vc3lzdGVtZC5p
by8+YF8gdGltZXJzIGFuZA0KPiBzZXJ2aWNlcyB0aGF0DQo+ICtydW4gb25saW5lIGZzY2sgYXV0
b21hdGljYWxseSBvbiB3ZWVrZW5kcy4NCmJ5IGRlZmF1bHQuDQoNCj4gK1RoZSBiYWNrZ3JvdW5k
IHNlcnZpY2UgY29uZmlndXJlcyBzY3J1YiB0byBydW4gd2l0aCBhcyBsaXR0bGUNCj4gcHJpdmls
ZWdlIGFzDQo+ICtwb3NzaWJsZSwgdGhlIGxvd2VzdCBDUFUgYW5kIElPIHByaW9yaXR5LCBhbmQg
aW4gYSBDUFUtY29uc3RyYWluZWQNCj4gc2luZ2xlDQo+ICt0aHJlYWRlZCBtb2RlLg0KIlRoaXMg
Y2FuIGJlIHR1bmVkIGF0IGFueXRpbWUgdG8gYmVzdCBzdWl0IHRoZSBuZWVkcyBvZiB0aGUgY3Vz
dG9tZXINCndvcmtsb2FkLiINCg0KVGhlbiBJIHRoaW5rIHlvdSBjYW4gZHJvcCB0aGUgYmVsb3cg
bGluZS4uLg0KPiArSXQgaXMgaG9wZWQgdGhhdCB0aGlzIG1pbmltaXplcyB0aGUgYW1vdW50IG9m
IGxvYWQgZ2VuZXJhdGVkIG9uIHRoZQ0KPiBzeXN0ZW0gYW5kDQo+ICthdm9pZHMgc3RhcnZpbmcg
cmVndWxhciB3b3JrbG9hZHMuDQo+ICsNCj4gK1RoZSBvdXRwdXQgb2YgdGhlIGJhY2tncm91bmQg
c2VydmljZSBpcyBhbHNvIGNhcHR1cmVkIGluIHRoZSBzeXN0ZW0NCj4gbG9nLg0KPiArSWYgZGVz
aXJlZCwgcmVwb3J0cyBvZiBmYWlsdXJlcyAoZWl0aGVyIGR1ZSB0byBpbmNvbnNpc3RlbmNpZXMg
b3INCj4gbWVyZSBydW50aW1lDQo+ICtlcnJvcnMpIGNhbiBiZSBlbWFpbGVkIGF1dG9tYXRpY2Fs
bHkgYnkgc2V0dGluZyB0aGUgYGBFTUFJTF9BRERSYGANCj4gZW52aXJvbm1lbnQNCj4gK3Zhcmlh
YmxlIGluIHRoZSBmb2xsb3dpbmcgc2VydmljZSBmaWxlczoNCj4gKw0KPiArKiBgYHhmc19zY3J1
Yl9mYWlsQC5zZXJ2aWNlYGANCj4gKyogYGB4ZnNfc2NydWJfbWVkaWFfZmFpbEAuc2VydmljZWBg
DQo+ICsqIGBgeGZzX3NjcnViX2FsbF9mYWlsLnNlcnZpY2VgYA0KPiArDQo+ICtUaGUgZGVjaXNp
b24gdG8gZW5hYmxlIHRoZSBiYWNrZ3JvdW5kIHNjYW4gaXMgbGVmdCB0byB0aGUgc3lzdGVtDQo+
IGFkbWluaXN0cmF0b3IuDQo+ICtUaGlzIGNhbiBiZSBkb25lIGJ5IGVuYWJsaW5nIGVpdGhlciBv
ZiB0aGUgZm9sbG93aW5nIHNlcnZpY2VzOg0KPiArDQo+ICsqIGBgeGZzX3NjcnViX2FsbC50aW1l
cmBgIG9uIHN5c3RlbWQgc3lzdGVtcw0KPiArKiBgYHhmc19zY3J1Yl9hbGwuY3JvbmBgIG9uIG5v
bi1zeXN0ZW1kIHN5c3RlbXMNCj4gKw0KPiArVGhpcyBhdXRvbWF0aWMgd2Vla2x5IHNjYW4gaXMg
Y29uZmlndXJlZCBvdXQgb2YgdGhlIGJveCB0byBwZXJmb3JtDQo+IGFuDQo+ICthZGRpdGlvbmFs
IG1lZGlhIHNjYW4gb2YgYWxsIGZpbGUgZGF0YSBvbmNlIHBlciBtb250aC4NCj4gK1RoaXMgaXMg
bGVzcyBmb29scHJvb2YgdGhhbiwgc2F5LCBzdG9yaW5nIGZpbGUgZGF0YSBibG9jayBjaGVja3N1
bXMsDQo+IGJ1dCBtdWNoDQo+ICttb3JlIHBlcmZvcm1hbnQgaWYgYXBwbGljYXRpb24gc29mdHdh
cmUgcHJvdmlkZXMgaXRzIG93biBpbnRlZ3JpdHkNCj4gY2hlY2tpbmcsDQo+ICtyZWR1bmRhbmN5
IGNhbiBiZSBwcm92aWRlZCBlbHNld2hlcmUgYWJvdmUgdGhlIGZpbGVzeXN0ZW0sIG9yIHRoZQ0K
PiBzdG9yYWdlDQo+ICtkZXZpY2UncyBpbnRlZ3JpdHkgZ3VhcmFudGVlcyBhcmUgZGVlbWVkIHN1
ZmZpY2llbnQuDQo+ICsNCj4gK1RoZSBzeXN0ZW1kIHVuaXQgZmlsZSBkZWZpbml0aW9ucyBoYXZl
IGJlZW4gc3ViamVjdGVkIHRvIGEgc2VjdXJpdHkNCj4gYXVkaXQNCj4gKyhhcyBvZiBzeXN0ZW1k
IDI0OSkgdG8gZW5zdXJlIHRoYXQgdGhlIHhmc19zY3J1YiBwcm9jZXNzZXMgaGF2ZSBhcw0KPiBs
aXR0bGUNCj4gK2FjY2VzcyB0byB0aGUgcmVzdCBvZiB0aGUgc3lzdGVtIGFzIHBvc3NpYmxlLg0K
PiArVGhpcyB3YXMgcGVyZm9ybWVkIHZpYSBgYHN5c3RlbWQtYW5hbHl6ZSBzZWN1cml0eWBgLCBh
ZnRlciB3aGljaA0KPiBwcml2aWxlZ2VzDQo+ICt3ZXJlIHJlc3RyaWN0ZWQgdG8gdGhlIG1pbmlt
dW0gcmVxdWlyZWQsIHNhbmRib3hpbmcgd2FzIHNldCB1cCB0bw0KPiB0aGUgbWF4aW1hbA0KPiAr
ZXh0ZW50IHBvc3NpYmxlIHdpdGggc2FuZGJveGluZyBhbmQgc3lzdGVtIGNhbGwgZmlsdGVyaW5n
OyBhbmQNCj4gYWNjZXNzIHRvIHRoZQ0KPiArZmlsZXN5c3RlbSB0cmVlIHdhcyByZXN0cmljdGVk
IHRvIHRoZSBtaW5pbXVtIG5lZWRlZCB0byBzdGFydCB0aGUNCj4gcHJvZ3JhbSBhbmQNCj4gK2Fj
Y2VzcyB0aGUgZmlsZXN5c3RlbSBiZWluZyBzY2FubmVkLg0KPiArVGhlIHNlcnZpY2UgZGVmaW5p
dGlvbiBmaWxlcyByZXN0cmljdCBDUFUgdXNhZ2UgdG8gODAlIG9mIG9uZSBDUFUNCj4gY29yZSwg
YW5kDQo+ICthcHBseSBhcyBuaWNlIG9mIGEgcHJpb3JpdHkgdG8gSU8gYW5kIENQVSBzY2hlZHVs
aW5nIGFzIHBvc3NpYmxlLg0KPiArVGhpcyBtZWFzdXJlIHdhcyB0YWtlbiB0byBtaW5pbWl6ZSBk
ZWxheXMgaW4gdGhlIHJlc3Qgb2YgdGhlDQo+IGZpbGVzeXN0ZW0uDQo+ICtObyBzdWNoIGhhcmRl
bmluZyBoYXMgYmVlbiBwZXJmb3JtZWQgZm9yIHRoZSBjcm9uIGpvYi4NCj4gKw0KPiArUHJvcG9z
ZWQgcGF0Y2hzZXQ6DQo+ICtgRW5hYmxpbmcgdGhlIHhmc19zY3J1YiBiYWNrZ3JvdW5kIHNlcnZp
Y2UNCj4gKzwNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvZGp3b25nL3hmc3Byb2dzLWRldi5nDQo+IGl0L2xvZy8/aD1zY3J1Yi1tZWRpYS1zY2FuLXNl
cnZpY2U+YF8uDQo+ICsNCj4gK0hlYWx0aCBSZXBvcnRpbmcNCj4gKy0tLS0tLS0tLS0tLS0tLS0N
Cj4gKw0KPiArWEZTIGNhY2hlcyBhIHN1bW1hcnkgb2YgZWFjaCBmaWxlc3lzdGVtJ3MgaGVhbHRo
IHN0YXR1cyBpbiBtZW1vcnkuDQo+ICtUaGUgaW5mb3JtYXRpb24gaXMgdXBkYXRlZCB3aGVuZXZl
ciBgYHhmc19zY3J1YmBgIGlzIHJ1biwgb3INCj4gd2hlbmV2ZXINCj4gK2luY29uc2lzdGVuY2ll
cyBhcmUgZGV0ZWN0ZWQgaW4gdGhlIGZpbGVzeXN0ZW0gbWV0YWRhdGEgZHVyaW5nDQo+IHJlZ3Vs
YXINCj4gK29wZXJhdGlvbnMuDQo+ICtTeXN0ZW0gYWRtaW5pc3RyYXRvcnMgc2hvdWxkIHVzZSB0
aGUgYGBoZWFsdGhgYCBjb21tYW5kIG9mDQo+IGBgeGZzX3NwYWNlbWFuYGAgdG8NCj4gK2Rvd25s
b2FkIHRoaXMgaW5mb3JtYXRpb24gaW50byBhIGh1bWFuLXJlYWRhYmxlIGZvcm1hdC4NCj4gK0lm
IHByb2JsZW1zIGhhdmUgYmVlbiBvYnNlcnZlZCwgdGhlIGFkbWluaXN0cmF0b3IgY2FuIHNjaGVk
dWxlIGENCj4gcmVkdWNlZA0KPiArc2VydmljZSB3aW5kb3cgdG8gcnVuIHRoZSBvbmxpbmUgcmVw
YWlyIHRvb2wgdG8gY29ycmVjdCB0aGUgcHJvYmxlbS4NCj4gK0ZhaWxpbmcgdGhhdCwgdGhlIGFk
bWluaXN0cmF0b3IgY2FuIGRlY2lkZSB0byBzY2hlZHVsZSBhIG1haW50ZW5hbmNlDQo+IHdpbmRv
dyB0bw0KPiArcnVuIHRoZSB0cmFkaXRpb25hbCBvZmZsaW5lIHJlcGFpciB0b29sIHRvIGNvcnJl
Y3QgdGhlIHByb2JsZW0uDQo+ICsNCj4gKyoqUXVlc3Rpb24qKjogU2hvdWxkIHRoZSBoZWFsdGgg
cmVwb3J0aW5nIGludGVncmF0ZSB3aXRoIHRoZSBuZXcNCj4gaW5vdGlmeSBmcw0KPiArZXJyb3Ig
bm90aWZpY2F0aW9uIHN5c3RlbT8NCj4gKw0KPiArKipRdWVzdGlvbioqOiBXb3VsZCBpdCBiZSBo
ZWxwZnVsIGZvciBzeXNhZG1pbnMgdG8gaGF2ZSBhIGRhZW1vbiB0bw0KPiBsaXN0ZW4gZm9yDQo+
ICtjb3JydXB0aW9uIG5vdGlmaWNhdGlvbnMgYW5kIGluaXRpYXRlIGEgcmVwYWlyPw0KPiArDQo+
ICsqQW5zd2VyKjogVGhlc2UgcXVlc3Rpb25zIHJlbWFpbiB1bmFuc3dlcmVkLCBidXQgc2hvdWxk
IGJlIGEgcGFydCBvZg0KPiB0aGUNCj4gK2NvbnZlcnNhdGlvbiB3aXRoIGVhcmx5IGFkb3B0ZXJz
IGFuZCBwb3RlbnRpYWwgZG93bnN0cmVhbSB1c2VycyBvZg0KPiBYRlMuDQpJIHRoaW5rIGlmIHRo
ZXJlJ3MgYmVlbiBubyBjb21tZW50YXJ5IGF0IHRoaXMgcG9pbnQgdGhlbiBsaWtlbHkgdGhleQ0K
Y2FuJ3QgYmUgYW5zd2VyZWQgYXQgdGhpcyB0aW1lLiAgUGVyaGFwcyBmb3Igbm93IGl0IGlzIHJl
YXNvbmFibGUgdG8NCmp1c3QgbGV0IHRoZSBiZSBhIHBvdGVudGlhbCBpbXByb3ZlbWVudCBpbiB0
aGUgZnV0dXJlIGlmIHRoZSBkZW1hbmQgZm9yDQppdCBhcmlzZXMuIEluIGFueSBjYXNlLCBJIHRo
aW5rIHdlIHNob3VsZCBwcm9iYWJseSBjbGVhbiBvdXQgdGhlIFEmQQ0KZGlzY3Vzc2lvbiBwcm9t
cHRzLg0KDQpSZXN0IGxvb2tzIGdvb2QgdGhvDQpBbGxpc29uDQoNCj4gKw0KPiArUHJvcG9zZWQg
cGF0Y2hzZXRzIGluY2x1ZGUNCj4gK2B3aXJpbmcgdXAgaGVhbHRoIHJlcG9ydHMgdG8gY29ycmVj
dGlvbiByZXR1cm5zDQo+ICs8DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L2Rqd29uZy94ZnMtbGludXguZ2l0Lw0KPiBsb2cvP2g9Y29ycnVwdGlvbi1o
ZWFsdGgtcmVwb3J0cz5gXw0KPiArYW5kDQo+ICtgcHJlc2VydmF0aW9uIG9mIHNpY2tuZXNzIGlu
Zm8gZHVyaW5nIG1lbW9yeSByZWNsYWltDQo+ICs8DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Rqd29uZy94ZnMtbGludXguZ2l0Lw0KPiBsb2cvP2g9
aW5kaXJlY3QtaGVhbHRoLXJlcG9ydGluZz5gXy4NCj4gDQoNCg==
