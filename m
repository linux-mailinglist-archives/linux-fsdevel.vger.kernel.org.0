Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331CD73E273
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 16:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFZOuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 10:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFZOuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:50:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339F12E
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 07:50:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QBVZZM031232;
        Mon, 26 Jun 2023 14:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5OhnR991Rpwn8SErTqfTtc6GEgdKu/PbEGbPqU+OM8A=;
 b=MwF6uzVpgc9hL9OAE25Z89NJNK/kVUdRsB3Ly/rUjan0EwgtoeDPU6tBtZWMR78DK+Fz
 wyenHagSTOIC3ZZr5zIbx9CMQupFaIU3APoVD2YuL+v5uPMnVoYmV6PJ0uiGIU9f+F/D
 vtYXGSo9i4OPE4Hb/KssIGwfhSXsO0HSajp8KzNlTvIuJdKVxkJpb3nwhHv3YAjKXVJ4
 apoRERlPRUWQ4VMr0Zkt/VMsZCZiTj+MYC48QjFNaynVfCsKOUb/u4H1Tr53xpotygja
 k3sXYsnnUJoyENzbn+6+4RqP7LfLpcdmLVAmWJjyp6c1EBheF01KdOuVHGcyWPWcZ0vx Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e1225-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 14:50:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35QE5O5Y005239;
        Mon, 26 Jun 2023 14:50:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx96qxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 14:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrLHMU3UZmWNJ5T391iVMsPsEo265ajleZYkDZD0WlkbNdUnJx2GTFhlqNpildluyFz+Y1X/I4Qx1QZE8qUIZmMaCsUrEbsDtH2xbwN2NCISjh7rLon/Ce9Jcd3AwAdjC3+crueB3h82FfRL0026K1m0SMywQldC7uChsFZtKvKAu+0Rg9d78dRkBQO1zrNH+NOf//kQ/EZDL/O3ooqJQYSPgEvS1D4GbOwUwV3LMDyub8zmj9wxSnB+8tE1Kq4C+/pIxsRdrJb23QLGWVoTagTJ3H9zASl6FycyivkC6WEnn5e2KrYqsBFfUnV8FtR/2gknBHazhiCx4UFCCdyicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OhnR991Rpwn8SErTqfTtc6GEgdKu/PbEGbPqU+OM8A=;
 b=CiUaHQSAjm4ZKUGoCYngQnjLo5sEsW9W+bl23drokYg91DPLdnJAAu1/h1haITkcWju+6Eg2JFTK48GSFh0cjyLaCsQbxcuqiSPvLIrt1CLAK1LSyPjcCNmqXQ+HnSE9IwwueQbPlimBmevNZ/tc508No6/lP/GN35RVnVOWJ7ebDJR3pcubd0geIlMtXvwG9WhVJ/LN4Gze3w8noB9lwRu0W7gwTVLVR8qoiFwju4BxQxWeXBoLMQV/SQ0q37TNIEQz2YpMvpZXlTwgPuIUODR6mhAARzCV59MzqPDbodXRkUdkLxunevuIgD5rDYk5Z5yVePGK5ZeCwr8vK6v87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OhnR991Rpwn8SErTqfTtc6GEgdKu/PbEGbPqU+OM8A=;
 b=EczcSyIJ/YwqweQ3Azwj1R/emwVSQh6wl94zKVWQ2KiT4GBxrG0RCnQXAwSuEg45n+Ajr3Sfpuge7u52qh/GeSf92vLsmtVvdfuB00FQYnw+YUurxg690jatgvltabh46qVhIpzf8o/GDadY3ztc8TFcR/og2N68S1Q0hyUP88k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4843.namprd10.prod.outlook.com (2603:10b6:610:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 14:50:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 14:50:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
CC:     Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] libfs: Add directory operations for stable offsets
Thread-Topic: [PATCH v3 1/3] libfs: Add directory operations for stable
 offsets
Thread-Index: AQHZmHhafl085c1CtUSjV1edmqTuz6+ZETsAgAQkKgCAABS4AA==
Date:   Mon, 26 Jun 2023 14:50:31 +0000
Message-ID: <65AB1E24-7714-4296-A501-BD824EE0DBC8@oracle.com>
References: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
 <168605705924.32244.13384849924097654559.stgit@manet.1015granger.net>
 <a291a0db-c631-6e52-1764-1ccadf60ca1a@fastmail.fm>
 <68ccd526-34a5-7c6f-304c-50c7df0cf4b2@fastmail.fm>
In-Reply-To: <68ccd526-34a5-7c6f-304c-50c7df0cf4b2@fastmail.fm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4843:EE_
x-ms-office365-filtering-correlation-id: 941d1abb-2503-4369-aa83-08db7654b072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pWfPf/b3tKELnROaWc8iCpVWzJWL0BZiXOt8YBIxcT/no5jQil+ylNvMcBs+hLhHLz4APoJz1f+HJu5xZRnpAjZtM9IUFtFXVF4hKCQT5a+LsVb8Hbv41+q5pkLcB27Wk+R73QdvEHGwc+zzlPaAMdwVjXZct2OqWOX6z08ltxDe46UgRhzDAEI+0HThQHh9bkrlybUI/LI50ji7qimiHwHJlcFXV5m7FczDe/olhEGO7p+qyyBoOwyazCA6IkdHi5xH1XevLG0A6B3HqOyDGxmiVW6asjjmaKncQR3Os7+R2qDkG4jGlpMi5d9803NWx9fba9ezzEl3qm5Qrgx/J1mRLLBlPJCdcidQv5HlREXb3o8YpfTQ6Nrqb9FH9wHx/RhNEyO4bb8EecK+F/odW0ehCmWCX7C8PtPi3SEnYuIzGQdI1TIbrY0BLel74aMbpVQ22bxYPd82UohdrtEtdYNAOYuXwUM0NFon1Uoyj2GYVRRdids/bw+fLL31V5214PSDJ1ys5s0Up0YUBg/6eR/pGyZBV+rqmRTJN2gw4F79XinafeNPZ80+yF7dBloSQ5IvCDdeI2TqoyDqrSqLdGSwqRQ/R4yQmVuuPVAyVx2DXi+u3VEUd2GczE3cp2rB5uuao9ayQvoye2kaSDUgiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(66446008)(36756003)(33656002)(5660300002)(64756008)(6916009)(38070700005)(8936002)(8676002)(41300700001)(86362001)(66556008)(66476007)(91956017)(38100700002)(122000001)(76116006)(316002)(4326008)(66946007)(26005)(6512007)(53546011)(2906002)(478600001)(6506007)(186003)(71200400001)(2616005)(83380400001)(54906003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lilD5sjsao6q2hQ59+8SyMeX+f2ZzhpRIXPCTjUAIV5CnqxtGvGXbjSdlj1A?=
 =?us-ascii?Q?fIR8Iap7Fiofy5q83o+bH1vKftlI3G9dbo+0pDi5q4pEsyKPlCRHHds87BQD?=
 =?us-ascii?Q?z8kOhTPF0X+j2F7MSPJWfU4J0Hd/M4gMlnKjC7xKQNnEwR/znm7iM4le/VNM?=
 =?us-ascii?Q?4pjC3YK8ZrzSRKdgSOtxItsV6JRNeuvmXrz7BIxBOsM9EJp4x9Zw0dE4yDHi?=
 =?us-ascii?Q?Ehm9Keeap4M/8Mdbh4/sax8OeK9cNPrXQWtCV3Go0nykpK8y3YOQTBnxnYsu?=
 =?us-ascii?Q?iz42lKGNRI9e3Ta9pWIrw8NTfhXMG+vyCL5xh41SnihJhQL70W5yizWhFRtx?=
 =?us-ascii?Q?bf0oVQBCoiMLu1WkckvwGGUjuCxhCDRpNpCfjJYdV2GOE0iFBa79wjaTR3BW?=
 =?us-ascii?Q?WqfcACVob1sZyxhe8suBrTXd8TFZfKwR6e0xb6vylNDJVzCtWuERfJM5MVZv?=
 =?us-ascii?Q?mLMaeMzBIcCqEUEcQCJmJ8WqxuFp6Dn7ZtuFNpwmdGISLqVE3rTaGFJkJ205?=
 =?us-ascii?Q?6gGUrj6hvAMdUQ1B0EmCsIUKVHodIOSPn/qb4R796d4bQPFCDFhaqyS63mwK?=
 =?us-ascii?Q?oLZXJ0xFRrlQvGy6aEElKCx6WCsdhsTelwTHcNFcssAcg7sePi/B5XdgyF7x?=
 =?us-ascii?Q?1XQZoB/kd5W5L/VwbxpZtALFxfR4ZOvIIBiq3pUX6PHnJDcO0pVaCu1rb8Lx?=
 =?us-ascii?Q?0T/2LKY4VCEx77RNkUMreGkVliii6TnWtnTwQyxP6inhR7P94xqpEhjxBeIa?=
 =?us-ascii?Q?5g3qhesbHeCUAnloF6RojDlL14WT+D+8WzmDELZJuuVgE05wZ5n3IsRG+9bK?=
 =?us-ascii?Q?sIqZrveHw8lmNpcWYOH4Zr+x5PcdWJVHF8oKkekSnfRpN9K3kELcPlHACL00?=
 =?us-ascii?Q?0Tc/fJScEj5eWJfLrXW6qM+VvxsSObtV1z6wt94o3T7boam1hgphAaT0swuc?=
 =?us-ascii?Q?2AOzGyQ9z/VDj8albTKRFYjle3c7oS4k0t5JqJBb5jykwuLwbVqhEnC7FpsT?=
 =?us-ascii?Q?cSWyFAaQKcfhQoHqovH6GiVxbt0PZ3GeUoPbyKab8h78hm4J2wf77kQ3jFrf?=
 =?us-ascii?Q?1ZXPniKfIH70eNz6RVxIaRVDvaChmqYZPyXTobg5ykqkoQsXsyNi74k2+Pl+?=
 =?us-ascii?Q?KxUongKV0sfg5w0gcYDLfapv140d+U1chdwjtnCgZO23C1s50kWHkH4gb/8N?=
 =?us-ascii?Q?SjCfv4uV8SbWlBC2MzJWYpZaytZIpyCIMiqBOzCVwvzxM6ybtzJb75ZxfBpk?=
 =?us-ascii?Q?h3l7ITmGk7xfRp99gUiAVwKo6v1t/ldKE86KqLCOZmtf1osqAFIxXWPXLWra?=
 =?us-ascii?Q?mC9aR4zoJiXqosLnKD8QgTIXgS8vCni0hHC1sYVgYpOfETMR5I2ywuDyLn6h?=
 =?us-ascii?Q?RbSSBCkSVaHPj+hymoHrJH+bHVK1IiO6jMBgTNM018wCoD9NMH2C/66p9nkl?=
 =?us-ascii?Q?1N7uPN318HUxre01ygHogMLracbBZ5bdahxNbkhJB6Kuk8O+uaeZEU1PHoIE?=
 =?us-ascii?Q?If8IuO61DbcAEKCkPr9daScyvlTqcFS6aItuSXZWahMKJilIp408HH5k/2OQ?=
 =?us-ascii?Q?ID8H2kL4p9cAsQMsB5U6sVTWwmd1UQ7SPWbVk4mRXfsiP6/iHM414J8eDquf?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF58BBDD662B8A489EAFACEA7B9B2BD1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/JgDIIpAO1IfKEsl5fhihd9HQVTGiKOvGibfwmCvoVSq2CY3wRgvJ65muOkk?=
 =?us-ascii?Q?O/9YnZBg+Xy41OR16uVjaA+KKl3RTqdXhx1ggwRAd+2NpbrgT91vyYZMPwDk?=
 =?us-ascii?Q?hGw/U6XanFfil3+fdodXawENH27kZtY1BAzK4+yt/5M0CNwTZD7gkZGNlIO2?=
 =?us-ascii?Q?a+xj8ktGr/yk6bCInif4bsl1coIrJHMsVb8w7S3bpWsfjhH6Zycj5GkYnNVe?=
 =?us-ascii?Q?DEGu0H2Hij2DH4iYWENxiBeXJhWFe+UXusYS5y1yjMd1RCdDTZu7z1hbJm5r?=
 =?us-ascii?Q?8zlqmGBdYspHr/wKKD4XQioOml+gZzc5FgF+u+5k9Q1IiRXJ/R09wWJrooFx?=
 =?us-ascii?Q?Gid6fEoZeYrTKGSfeGM0HASq4P3eQntDcBg2IHsI3Cq0rgGQeuAW0B+jd0zH?=
 =?us-ascii?Q?/RLB4d8rEBBMvUGWkCyVQRndhNsu2BikGQNGylGkUtGsypaa8gad4rRt5IFk?=
 =?us-ascii?Q?Nlet06VErcPkgW7E0NTIqtl+1k6XKQn4D3+OQVbbK+mkxgUORM0HF4IbwgyN?=
 =?us-ascii?Q?QdSpG3zIpdRDNDjNuBispK9gnsH80YbTfe5V6vU0WQdgDgJoULFulaf8KOQN?=
 =?us-ascii?Q?PuaLqUPZUqFIZ5XtFM7FDQnVjc4FMqKvt2EZfNPG9QpIzhzW3FV7Wtq+/Npj?=
 =?us-ascii?Q?CwEE42ULSBhg8HWDYCRfNWm83qsGyJCNWfcY1Z2StQXEHaBdUA/wzQFEbe8I?=
 =?us-ascii?Q?qTHCSU/svQ/NdXxrOJIJdcIAoo+QAKkNUFVkPI3K+S1fb2hYZEyKKT9RU7Nj?=
 =?us-ascii?Q?+sKlA2UwhSr9E1qEPSWHWwL18DZtvYQtRLjYfbjRJww5Wj8hzE2TUu8zmosv?=
 =?us-ascii?Q?jjs5ODLL6O8M4lTllChx3qZ7e+7dNu4PYLdoCEBodH9CCjNJowm7qSh6H0pO?=
 =?us-ascii?Q?WLpGoleLuxMSgWxoTbjUIuVnoHDoKRTBaPnfHUY4K/WjHWJUNhQXdUNO9/r5?=
 =?us-ascii?Q?72p2oe+wtS9BFXB5G/Jjecn/UtAb4RX1LzmZOpPxpU0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941d1abb-2503-4369-aa83-08db7654b072
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 14:50:31.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hgOaT+gy54x4yR2zPCKi5ilLi/LZrmQexfgdyVzj5qwVPW0U4LRaMhaazNK+WQTilknzcGmjpO3GJKjl6XVIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_11,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=829 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260133
X-Proofpoint-GUID: bXv0T5902VHhxxn6KBBwQtOk5H_qQbwu
X-Proofpoint-ORIG-GUID: bXv0T5902VHhxxn6KBBwQtOk5H_qQbwu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 26, 2023, at 9:36 AM, Bernd Schubert <bernd.schubert@fastmail.fm> =
wrote:
>=20
>=20
>=20
> On 6/24/23 00:21, Bernd Schubert wrote:
>> On 6/6/23 15:10, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>=20
>>> Create a vector of directory operations in fs/libfs.c that handles
>>> directory seeks and readdir via stable offsets instead of the
>>> current cursor-based mechanism.
>>>=20
>>> For the moment these are unused.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   fs/dcache.c            |    1
>>>   fs/libfs.c             |  185 +++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>   include/linux/dcache.h |    1
>>>   include/linux/fs.h     |    9 ++
>>>   4 files changed, 196 insertions(+)
>>>=20
>>> diff --git a/fs/dcache.c b/fs/dcache.c
>>> index 52e6d5fdab6b..9c9a801f3b33 100644
>>> --- a/fs/dcache.c
>>> +++ b/fs/dcache.c
>>> @@ -1813,6 +1813,7 @@ static struct dentry *__d_alloc(struct super_bloc=
k *sb, const struct qstr *name)
>>>       dentry->d_sb =3D sb;
>>>       dentry->d_op =3D NULL;
>>>       dentry->d_fsdata =3D NULL;
>>> +    dentry->d_offset =3D 0;
>>>       INIT_HLIST_BL_NODE(&dentry->d_hash);
>>>       INIT_LIST_HEAD(&dentry->d_lru);
>>>       INIT_LIST_HEAD(&dentry->d_subdirs);
>>> diff --git a/fs/libfs.c b/fs/libfs.c
>>> index 89cf614a3271..07317bbe1668 100644
>>> --- a/fs/libfs.c
>>> +++ b/fs/libfs.c
>>> @@ -239,6 +239,191 @@ const struct inode_operations simple_dir_inode_op=
erations =3D {
>>>   };
>>>   EXPORT_SYMBOL(simple_dir_inode_operations);
>>> +/**
>>> + * stable_offset_init - initialize a parent directory
>>> + * @dir: parent directory to be initialized
>>> + *
>>> + */
>>> +void stable_offset_init(struct inode *dir)
>>> +{
>>> +    xa_init_flags(&dir->i_doff_map, XA_FLAGS_ALLOC1);
>>> +    dir->i_next_offset =3D 0;
>>> +}
>>> +EXPORT_SYMBOL(stable_offset_init);
>>> +
>>> +/**
>>> + * stable_offset_add - Add an entry to a directory's stable offset map
>>> + * @dir: parent directory being modified
>>> + * @dentry: new dentry being added
>>> + *
>>> + * Returns zero on success. Otherwise, a negative errno value is retur=
ned.
>>> + */
>>> +int stable_offset_add(struct inode *dir, struct dentry *dentry)
>>> +{
>>> +    struct xa_limit limit =3D XA_LIMIT(2, U32_MAX);
>>> +    u32 offset =3D 0;
>>> +    int ret;
>>> +
>>> +    if (dentry->d_offset)
>>> +        return -EBUSY;
>>> +
>>> +    ret =3D xa_alloc_cyclic(&dir->i_doff_map, &offset, dentry, limit,
>>> +                  &dir->i_next_offset, GFP_KERNEL);
>> Please see below at struct inode my question about i_next_offset.
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    dentry->d_offset =3D offset;
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL(stable_offset_add);
>>> +
>>> +/**
>>> + * stable_offset_remove - Remove an entry to a directory's stable offs=
et map
>>> + * @dir: parent directory being modified
>>> + * @dentry: dentry being removed
>>> + *
>>> + */
>>> +void stable_offset_remove(struct inode *dir, struct dentry *dentry)
>>> +{
>>> +    if (!dentry->d_offset)
>>> +        return;
>>> +
>>> +    xa_erase(&dir->i_doff_map, dentry->d_offset);
>>> +    dentry->d_offset =3D 0;
>>> +}
>>> +EXPORT_SYMBOL(stable_offset_remove);
>>> +
>>> +/**
>>> + * stable_offset_destroy - Release offset map
>>> + * @dir: parent directory that is about to be destroyed
>>> + *
>>> + * During fs teardown (eg. umount), a directory's offset map might sti=
ll
>>> + * contain entries. xa_destroy() cleans out anything that remains.
>>> + */
>>> +void stable_offset_destroy(struct inode *dir)
>>> +{
>>> +    xa_destroy(&dir->i_doff_map);
>>> +}
>>> +EXPORT_SYMBOL(stable_offset_destroy);
>>> +
>>> +/**
>>> + * stable_dir_llseek - Advance the read position of a directory descri=
ptor
>>> + * @file: an open directory whose position is to be updated
>>> + * @offset: a byte offset
>>> + * @whence: enumerator describing the starting position for this updat=
e
>>> + *
>>> + * SEEK_END, SEEK_DATA, and SEEK_HOLE are not supported for directorie=
s.
>>> + *
>>> + * Returns the updated read position if successful; otherwise a
>>> + * negative errno is returned and the read position remains unchanged.
>>> + */
>>> +static loff_t stable_dir_llseek(struct file *file, loff_t offset, int =
whence)
>>> +{
>>> +    switch (whence) {
>>> +    case SEEK_CUR:
>>> +        offset +=3D file->f_pos;
>>> +        fallthrough;
>>> +    case SEEK_SET:
>>> +        if (offset >=3D 0)
>>> +            break;
>>> +        fallthrough;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return vfs_setpos(file, offset, U32_MAX);
>>> +}
>>> +
>>> +static struct dentry *stable_find_next(struct xa_state *xas)
>>> +{
>>> +    struct dentry *child, *found =3D NULL;
>>> +
>>> +    rcu_read_lock();
>>> +    child =3D xas_next_entry(xas, U32_MAX);
>>> +    if (!child)
>>> +        goto out;
>>> +    spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
>>> +    if (simple_positive(child))
>>> +        found =3D dget_dlock(child);
>>> +    spin_unlock(&child->d_lock);
>>> +out:
>>> +    rcu_read_unlock();
>>> +    return found;
>>> +}
>>> +
>>> +static bool stable_dir_emit(struct dir_context *ctx, struct dentry *de=
ntry)
>>> +{
>>> +    struct inode *inode =3D d_inode(dentry);
>>> +
>>> +    return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len,
>>> +              dentry->d_offset, inode->i_ino,
>>> +              fs_umode_to_dtype(inode->i_mode));
>>> +}
>>> +
>>> +static void stable_iterate_dir(struct dentry *dir, struct dir_context =
*ctx)
>>> +{
>>> +    XA_STATE(xas, &((d_inode(dir))->i_doff_map), ctx->pos);
>>> +    struct dentry *dentry;
>>> +
>>> +    while (true) {
>>> +        spin_lock(&dir->d_lock);
>>> +        dentry =3D stable_find_next(&xas);
>>> +        spin_unlock(&dir->d_lock);
>>> +        if (!dentry)
>>> +            break;
>>> +
>>> +        if (!stable_dir_emit(ctx, dentry)) {
>>> +            dput(dentry);
>>> +            break;
>>> +        }
>>> +
>>> +        dput(dentry);
>>> +        ctx->pos =3D xas.xa_index + 1;
>>> +    }
>>> +}
>>> +
>>> +/**
>>> + * stable_readdir - Emit entries starting at offset @ctx->pos
>>> + * @file: an open directory to iterate over
>>> + * @ctx: directory iteration context
>>> + *
>>> + * Caller must hold @file's i_rwsem to prevent insertion or removal of
>>> + * entries during this call.
>>> + *
>>> + * On entry, @ctx->pos contains an offset that represents the first en=
try
>>> + * to be read from the directory.
>>> + *
>>> + * The operation continues until there are no more entries to read, or
>>> + * until the ctx->actor indicates there is no more space in the caller=
's
>>> + * output buffer.
>>> + *
>>> + * On return, @ctx->pos contains an offset that will read the next ent=
ry
>>> + * in this directory when shmem_readdir() is called again with @ctx.
>>> + *
>>> + * Return values:
>>> + *   %0 - Complete
>>> + */
>>> +static int stable_readdir(struct file *file, struct dir_context *ctx)
>>> +{
>>> +    struct dentry *dir =3D file->f_path.dentry;
>>> +
>>> +    lockdep_assert_held(&d_inode(dir)->i_rwsem);
>>> +
>>> +    if (!dir_emit_dots(file, ctx))
>>> +        return 0;
>>> +
>>> +    stable_iterate_dir(dir, ctx);
>>> +    return 0;
>>> +}
>>> +
>>> +const struct file_operations stable_dir_operations =3D {
>>> +    .llseek        =3D stable_dir_llseek,
>>> +    .iterate_shared    =3D stable_readdir,
>>> +    .read        =3D generic_read_dir,
>>> +    .fsync        =3D noop_fsync,
>>> +};
>>> +EXPORT_SYMBOL(stable_dir_operations);
>>> +
>>>   static struct dentry *find_next_child(struct dentry *parent, struct d=
entry *prev)
>>>   {
>>>       struct dentry *child =3D NULL;
>>> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
>>> index 6b351e009f59..579ce1800efe 100644
>>> --- a/include/linux/dcache.h
>>> +++ b/include/linux/dcache.h
>>> @@ -96,6 +96,7 @@ struct dentry {
>>>       struct super_block *d_sb;    /* The root of the dentry tree */
>>>       unsigned long d_time;        /* used by d_revalidate */
>>>       void *d_fsdata;            /* fs-specific data */
>>> +    u32 d_offset;            /* directory offset in parent */
>>>       union {
>>>           struct list_head d_lru;        /* LRU list */
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 133f0640fb24..3fc2c04ed8ff 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -719,6 +719,10 @@ struct inode {
>>>   #endif
>>>       void            *i_private; /* fs or device private pointer */
>>> +
>>> +    /* simplefs stable directory offset tracking */
>>> +    struct xarray        i_doff_map;
>>> +    u32            i_next_offset;
>> Hmm, I was grepping through the patches and only find that "i_next_offse=
t" is initialized to 0 and then passed to xa_alloc_cyclic - does this reall=
y need to part of struct inode or could it be a local variable in stable_of=
fset_add()?

This is a per-directory value so that each directory can use
the full range of offsets (from zero to UINT_MAX). If there were
only a single next_offset field, then all tmpfs directories
would share the offset range, which is not scalable (not to
mention, it would also be unlike the behavior of other
filesystems).

Yes, we could move this to the shmem-private part of the inode,
but then the API gets a little uglier.


>> I only managed to look a bit through the patches right now, personally I=
 like v2 better as it doesn't extend struct inode with changes that can be =
used by in-memory file system only. What do others think? An alternative wo=
uld be to have these fields in struct shmem_inode_info and pass it as extra=
 argument to the stable_ functions?


--
Chuck Lever


