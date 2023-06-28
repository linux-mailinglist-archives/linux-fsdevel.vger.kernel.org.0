Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90E7413D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjF1O2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 10:28:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27176 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbjF1O2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:28:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBT3Xb001813;
        Wed, 28 Jun 2023 14:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=f77tg+ieLAiQktEtc///eNQdoBGa9mRbjYE9z1IMsgA=;
 b=36g0r8Tzq4Blomw28JW5TATheMm4T9T0hp17tiZMLL9KuSZL+JKtpwP+LBMwOghcNYlm
 0lYVNeIUQBBrDw+JlR67q6ebIr1XDFOwTDRCtWS7Bburq8HftIPypQ/2quMkBPsZ+ZAI
 yYRuV7mscLcumPTK6QFXAfclR+QPzmYIcNBXq6n4dWlTPh1pJcJsQSXe3HILs2WrPrVD
 0WvG9BhBoUMmzkeaAmfKfvZsNlCYqVtPoQgLoQyCyur7h3IVNZ6XgqDa2xqrfwqJIPPC
 jlz5ODpj5ExQQA0NhuWosyMKn8Salcw4pIjBSaYjtdhyTLy9UwZ37AbiCBkuiaHJSWJG FQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdfmb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 14:27:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SDOon2019970;
        Wed, 28 Jun 2023 14:27:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxbuhgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 14:27:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbFHNkIyCjNoz9MFguGl0Yvv+YlntmcZL4ngyfxcuW5yALw1WlFI3pMVA/OyxS7/QuYbwejTqnmOTSxLWQ7ioVmuvGhQUbV9gh8JkDVayEHZbDFJ4RaTQGkwxspBJwv2cWXDoz7/qjKbH9I5jkw7hVcQWq7bAqkt99YptufNjnDG3DCjo3k1b1XLD9fu76AoUyx9uuMMe23ICJ9oUXrs03/zDWmGKRWvsUXDOeVoMfBZfKTHwFDPCAOY9ZV3ZPFKuDg5ysd1NNTvb8e43KhoPUpMzFap0HAJSDwQbMN+J5Apj/M+B491fzp3gVfwgr0iQCTAdiAezShjuM1KGDZqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f77tg+ieLAiQktEtc///eNQdoBGa9mRbjYE9z1IMsgA=;
 b=HZfswKIKc4eRq26r47yeLtfk62GO1B4bzwqZwFEllpkVkdg4nstoujf2z9/o/igIePwe4xl0Rrv19IZQZykrKQe0oQAoTc+S8oeej0ffb328khrcKk1Cj+2uHUsEEcUGLgiRm5ZTGJ6o2SNwH96HYjkoSvVililzhxZSHzbTcXjC9/yK4Z/PQjXfVw6kd3DavTnRQcum+tKQ64gsDMXqILy68fsDCZib2GDrG6LqhX3Z9iYzqFAx/JMg0eSJJ5p6o39u6QUKO2eEfoEOGxA9VQ+dLhrFub7bckSjers4ON38y4wwqz9MqED7GaBRTtHTNCIIIfjHIDvLHqk/yQMsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f77tg+ieLAiQktEtc///eNQdoBGa9mRbjYE9z1IMsgA=;
 b=GF1bdDlTJrmI3RYQ4PhxvHq9rvtj2jy6HdBZVUbUksz4XuX4rc6CaUETm8az4a2cWm7q5UBQQ3zeafH5uaeew8IG2a2Je7oqoeJJ9OwlzUoYevAZYy/107oE7dX1vF9+PEf+O3HFCZ5TnoMpTgrk7/o+GXqawgY5KmjHbk+W6Gs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5091.namprd10.prod.outlook.com (2603:10b6:208:30e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 14:27:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.012; Wed, 28 Jun 2023
 14:27:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] libfs: Add directory operations for stable offsets
Thread-Topic: [PATCH v5 1/3] libfs: Add directory operations for stable
 offsets
Thread-Index: AQHZqTllSEr8h0FXA0qN84Tkh41URq+f8ywAgABTtIA=
Date:   Wed, 28 Jun 2023 14:27:38 +0000
Message-ID: <0D524292-5C87-4A55-B10E-9AC394CA00B8@oracle.com>
References: <168789864000.157531.11122232592994999253.stgit@manet.1015granger.net>
 <168789918896.157531.14644838088821804546.stgit@manet.1015granger.net>
 <20230628-geldentwertung-weggehen-97e784bde4f4@brauner>
In-Reply-To: <20230628-geldentwertung-weggehen-97e784bde4f4@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5091:EE_
x-ms-office365-filtering-correlation-id: 953e2bdc-fd93-4e9b-1673-08db77e3d2de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ah9ml+fH9AV6qX4BOFP9JRDSqghvqS483Dnjf8GrHjO7nM1tCdSn1uabqCsyQmmgOPgTVXlOwD0dDEL/Y4FjGS9P4RmsFT0QbVpEvzJeDT05jMdH2H6zPYC2vhKlRMZVfPBBsyYhn2CrLXTmlFMnmmaeM/Rb8Y4WhAi6KIJWy4KhVEsgsbYseKayCVGIvq/PDFyascMKGeTHmScLjJh9jWrm2zX7/Fh+9cRAMWxwQUhHg1uWDrczKJdOGo9GonpWkdo3U5qSEYwwEqZ3MJ/vmdttvJoNdzwFvzfBZOGs6PYDO/S9FP371mkPSAij7vT/5xFzC3V81DR6WjM2pgVSKpmEkrCvkNMS8iZUAC7wMl6iKZUpawlopeY0QHYgVudN1hmB52AUBGyWLbd8A+GCWjBN8v2qtCc6okhWZMj1vuH1/n4jUPcCKxxXhkHSLk84iKv5nva0sbQaNxaarH1odTEwA0NxvbkfIDqu7b3YBcGOCnIlWDk6WCRiKZpi0hCPiSn40i8+u17nqwa7iNOM/18IjLIJcnZg5pPtydDnmjOykfxYYHqST8TkZqtkisuK6YZ/Xvy7upqPXJngqGmxxx/yXHX0KELyiJ5+8be937oKS/0XZuqb+jpr//vrBIkqbbhUFiwYuMF6Tm0UCiYPsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(6512007)(66446008)(38070700005)(26005)(66556008)(66476007)(33656002)(122000001)(6916009)(5660300002)(86362001)(8936002)(41300700001)(4326008)(316002)(8676002)(91956017)(66946007)(64756008)(76116006)(38100700002)(36756003)(6506007)(53546011)(6486002)(186003)(2906002)(71200400001)(54906003)(2616005)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/XCwWbL2da/XMRKaDGfJAR62t1d63HGLz0ReGFazMQ+P6GkEmHBAFJeRdlK?=
 =?us-ascii?Q?IEQpxE9B5bVF19P1op3P7YoIsImNYrEgbkSJbSqe7s1tRP94YwC//0D0MeYd?=
 =?us-ascii?Q?bwxaRDq2BUtVNu/9k9TAM5+YSUJsfS1bBLpCDoNFDMHXJvYP403l79j5IXDJ?=
 =?us-ascii?Q?/bX5x2eoHJsYIeCoYoKg1e0CBx5nEb+6RkYGSpyNb/juN+HpW3chnVscuxCe?=
 =?us-ascii?Q?2zCw/GsSjHUjJPFJ4+pBr8PPuPOH136JhYC6sI7o9zfo1161rgcMNfcWJ6OH?=
 =?us-ascii?Q?Y+FLqyW3rApxXfoO3TqDgTPyP+8rLr0Dqx5lWAKOg8e2O5GEYH/O/PCHl79+?=
 =?us-ascii?Q?S/Iw1J6l7opMBR/2iq8rmGnaX54YlAVXKkidmuFut7Y62BgnUNLqpyLXjhP7?=
 =?us-ascii?Q?UCxC+SQwOqy/wKNG9PtA6sLaPfCYd1HFyUqEAQ2k0/PvypDq3b6PKiFyvzqp?=
 =?us-ascii?Q?k8KItAReFTSRfV30urHdH2eRZh393i6dDosrfUfZZ+SV3OEQ7LZIV1fV8E2V?=
 =?us-ascii?Q?gNFnq0I9qMf5igS3su5m8sxwV6/YqpizXT0aj04Rq2mOf3JGlE6bGMsyFowl?=
 =?us-ascii?Q?lqJ6iwTUtxlA6nJeQZ8mtET/aI6JfaIZKmVECHCnH8/g/41hOWhPiboe85HS?=
 =?us-ascii?Q?qupXi1bB8wkOAIOXazR3ImPn9/zExCaOtXTFwxNkzSqKpRrHUa/xPJsDJAdR?=
 =?us-ascii?Q?I1fpV9s28bvMxPYlkYHegBVRZpiIFluUkUBrKf2wTgSnUHB01nkxC7gAdSL4?=
 =?us-ascii?Q?nxeC5Eimlv2KKxynMH3ZIajykhn1iXW/NKX3qbPMIgt+CRft7zRjI2o7asKL?=
 =?us-ascii?Q?z8YmGFMmeyjxNNlSX/NM1BMitd79kkk1/sDssHlIBi/t8teKE5Zmaw4ErH4O?=
 =?us-ascii?Q?OIOWEjQGMBP+ti7xS1LNs7g/tCGyz9tDbh9GRb6bauKdoCNY++T1zzD2Nj6x?=
 =?us-ascii?Q?Hoogrx/ieqO/aAufAqhu5PbwlsA6+wiLTidqXNmHAzMZCW00bFR4kvfJPfOF?=
 =?us-ascii?Q?RU9O2ObMTrUzt9S29H3K6Jo6RhvZTkD6h7GsFaClAkqs3w7EETdOpPaGNTB6?=
 =?us-ascii?Q?jRWHriSYjWuzbjIrkRhaunF5+gBkRdolLQJ8P2wWV2wg5S75NhJawJ5xjCF+?=
 =?us-ascii?Q?LddKGD16lFxCN7RhthsPfXXnJmsOj1Jxwjag34jNzCxQ+7/WtjHa3yUcvHqQ?=
 =?us-ascii?Q?dboXbIwBQf0+HAt7tVFxo7jzC0ye+3phC/DE/NVqaSK9h7mnh29GomQxv4NG?=
 =?us-ascii?Q?qbYPZzVFNKaHng0ogw/CFloyIMepnnX1qLj2Ozdj7FapBXobPmHr4U/lu/aM?=
 =?us-ascii?Q?tCMiNtGJDiB42Aiw+sCarme11qOdFivKx9et995eWrxBD3yR+8u50nd7Iyqh?=
 =?us-ascii?Q?lToWkhm0tvADqcC4I6rQiUYCnzapCkbVwQhsxE6USAeMtVNnGTBzc2W/GLp+?=
 =?us-ascii?Q?CB5TTkgQrgNd9aFsHYzk97kPPaiFqLa3JsPrbVUkcuvAwLeIMtKWdhUpU6kc?=
 =?us-ascii?Q?Iszsrh1PspvWa7nfGCbkXW6IOi7QGHerKVSfGqyVqGxORFZhNUs2ROpyRl43?=
 =?us-ascii?Q?VLF8NaaUEn3DcTfe0wCN3bP2o4Xdv1oganVxjS1PD48rAqxCx6vmQxg7E/ry?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5701C7043EFBD489C06276AD9364886@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AULU1PcPyYmK/lVwhm7RVnBOB/gd/jaAP8fAV7YQ/aD+eYnKumDq3yX10OzU?=
 =?us-ascii?Q?OrFJtMPwxfLbZpQ2XV0Mob2vB3K2EPj2ACtG5Gzc+F/NROJC2idIEW7qzKMj?=
 =?us-ascii?Q?WRIVojq4OP1k94WCKHKHbIUZjNk8pJSvnw3cgthC0qKE3j716q5ZwFQx/fEs?=
 =?us-ascii?Q?hqeVp2+V0eE6ILY7hEpAfMMyMRauVi81HyK+WlxKB80WbrLTEPknW+XA5G3n?=
 =?us-ascii?Q?OU+QvmofUM6UOJJUVafG1312tbhIznpEJP1ubj2V0eguC9Xf6UGrZdet+f4H?=
 =?us-ascii?Q?9x8yERWhgKAumnOv0W1GRtHf2lc1bo8KZk84GBqcrfSXqbgXzIgl0nKnYwp/?=
 =?us-ascii?Q?Ljtd75R5Oov+RIJx/0EJxKhg0vTC9j5jFZ/CgKWOAwjlibQVLbzEpodochJk?=
 =?us-ascii?Q?6F3gf4XclghiWexWEu63V5UZYnKsd2TiTILzbH+A8X3RYKIJC3LSQ6CNWFL0?=
 =?us-ascii?Q?kk14BwJaDp29Sra39vrORSqMY5/pcL5WD3Bj/1CMNVU/6rJcbf16mXlIadWL?=
 =?us-ascii?Q?HiMeRhQLHEDvooLcQ/DlhPuBPebdP6je60X7MhbjUWOMChXy/sJzVrhJqDbl?=
 =?us-ascii?Q?SAmQw5fbcbuzwReV5hizMP+R7/FOaHUk5867uz6hs7KxRULXmYwlEgeyiPbR?=
 =?us-ascii?Q?kqzEkFNcpb3OFrbWKZcXX+7xCWBLjP7FpjJgOyQS88vlO/2CuCU8nuGXZ7B1?=
 =?us-ascii?Q?+u/t82j3kyYbL/G60tF81Xqw1LM9s30nHitYimn+ArRE3IRS6TBqoCzkfJdw?=
 =?us-ascii?Q?L0ZzCgJmidQZSar6vq1z1fnVIiRMDv6XL5G2KB2rWMmZZyGUh4XMDuuVD0o4?=
 =?us-ascii?Q?H+mKdTf7JtNlz+fBO8lDapx328C/mj2IzIjnCYitZq8Nq0dW0V9og5btUZuB?=
 =?us-ascii?Q?ZaYWAGMEY8E/KZiC17sDa6K89xK4q3c92XsuT4+3rFfM9BDovHWf1pf0OhPw?=
 =?us-ascii?Q?SngYkBQUSUR8+RYV7TadoBt/oolly5yi1urr2GpLYb4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953e2bdc-fd93-4e9b-1673-08db77e3d2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 14:27:38.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxI0uXF9tAztsqWpEhq2PVVxra74Uv0Tz3k8AIO2Hrj6sieHJhubOCkb2xM7Y7wHJH/1sGU4IrAiM4tFJb+tVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280128
X-Proofpoint-GUID: _8qOUIbZRj3Con8Dno1-DV2Kblj4OKtl
X-Proofpoint-ORIG-GUID: _8qOUIbZRj3Con8Dno1-DV2Kblj4OKtl
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 28, 2023, at 5:27 AM, Christian Brauner <brauner@kernel.org> wrote=
:
>=20
> On Tue, Jun 27, 2023 at 04:53:09PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Create a vector of directory operations in fs/libfs.c that handles
>> directory seeks and readdir via stable offsets instead of the
>> current cursor-based mechanism.
>>=20
>> For the moment these are unused.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>=20
> Could we just drop the "stable_" prefix and just have:
>=20
> // internal helpers
> offset_dir_emit()
> offset_get()
> offset_set()
> offset_dir_llseek()
> find_next_offset()
> I'd also collapse offset_iterate_dir() into offset_readdir().

We need to keep offset_iterate_dir(). XA_STATE() works only as a
declaration, so it has to be at the top of a function.

Everything else I can do.


> // exported and published helpers
> simple_offset_init()
> simple_offset_add()
> simple_offset_rename_exchange()
> simple_offset_destroy()
>=20
> struct offset_ctx *(*get_offset)(struct inode *inode);
>=20
> const struct file_operations simple_offset_dir_operations;
>=20
>> fs/libfs.c         |  252 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>> include/linux/fs.h |   19 ++++
>> 2 files changed, 271 insertions(+)
>>=20
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 89cf614a3271..9940dce049e6 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -239,6 +239,258 @@ const struct inode_operations simple_dir_inode_ope=
rations =3D {
>> };
>> EXPORT_SYMBOL(simple_dir_inode_operations);
>>=20
>> +static struct stable_offset_ctx *stable_ctx_get(struct inode *inode)
>> +{
>> + return inode->i_op->get_so_ctx(inode);
>> +}
>=20
> I would suggest to get rid of this helper. It just needlessly hides that
> all we do is inode->i_op->().

--
Chuck Lever


