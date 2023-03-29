Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986A16CF32C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjC2Taq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjC2Tap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:30:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6DD134;
        Wed, 29 Mar 2023 12:30:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TEivJ7025265;
        Wed, 29 Mar 2023 19:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FgEwqgYaVDCCzCnDRLDmTN9fJQPjA4+/FqTzDBAfBh4=;
 b=XVTckXpl3un4R+eDEe0Xt2776i9De7FpqDpz6FukA+eagI0NQqSWwcT9RtTpiHgbg9+D
 Z7J5h4ha/ateamMjhlTXR5vfk3JD9mTwOsgY4zXDT9btAG391KELgwdhKK1x9SYLE4RQ
 TSgAdn/11FAtR/h5vyLy4CeEvwY2JgRzNJDxFafan33j69+E82PIddqs4o72jmzMGIQz
 0O2uRpNMLXKkK/j9gEEvWQbci+LVeNK0Hehsr3ouhpdTDq8IL36mIYIPBfKq2aSj78Rh
 AveWeNgz6N38JyRZl2jYvb1fMGg6mjFQJfYGdP7thLfCBMzom5luayt5lJOABn4Aw2MY 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqbyrtqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 19:29:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32TJ04Nt010887;
        Wed, 29 Mar 2023 19:29:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdetpvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 19:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGJEhuXcxcOv8rH9nPqyT76xeun9jaj2s2j3tJdq1ZpGmEvFzt/ufeMhlzOVL7z0/lpeyjY3lzKqP1o4zUBWjg7yI0wSY1dTDIBAxeRpn4XL7CjKxYiinWlUYlQzwkNOMi7bKZk1Mh49HIMdRfyrzeVeXS9tyvOw3JFPt+3AeD6Uumhdyu6rHu2x2/o0iepLLkU/RnAQuaHXt2J8YMkvFc8kuTW3jfV/dvG4ul/7b/r/ca0Goz7FX/zgBfFCeYWiADsHKKYnU0qOQQmkY8XYLt3G280S2YGXjNYUy0rPlsxfxXPe9L4KraiBvaBzHjIo+xanRRP61mICBwccMhgvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgEwqgYaVDCCzCnDRLDmTN9fJQPjA4+/FqTzDBAfBh4=;
 b=mD+x6rdaV+9O19XMstQA939UjWGWlh2Ahx6yS6eYhIeSUVxrhIiuC1jrC5YLGSfkGuOgNVBfE9UB1up6F2PUUkmEbjSHGB3HgJUsU79IhSQJgrCQdMOggmhSsLB8wCO8C2mejgQCBTgGyQI6urebp87u35+6SuiX02xlLRa1q2vD5TBA+RtbU5S1VVvZW8DLUAfT+ugQGMPFHKQu/CQH8mHLEplN7S1yiM8SbkQmR1I90S32jwG5sLxXFczVit/On0xqMDLBaWX8Qb892pwZ6WcYL74x9NK2MHUI/N3ow08Uz0ieQGaumpjUAjRxwr5a7KfBHOghXEElnqjFcx3AFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgEwqgYaVDCCzCnDRLDmTN9fJQPjA4+/FqTzDBAfBh4=;
 b=hJeekImUBHdLL62Q5ShhNeW7fkc6j+D8YFD09wP8/eFbRbY+RtmqxzWby2mWyuItqvQEJ7WMhYo5BFPIgtWmQXmjUDsk/3+ivXm87TNYUQdYHeCHuTN+qbkdRXs2MTRX7pCrv9lgKUXtlupn2veGdEw0jXZtuNjuZz25O1FmIx8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Wed, 29 Mar
 2023 19:29:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 19:29:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] consolidate dt_type() helper definitions
Thread-Topic: [PATCH] consolidate dt_type() helper definitions
Thread-Index: AQHZYnTX1lbp6j483E65wsS4/d6krA==
Date:   Wed, 29 Mar 2023 19:29:55 +0000
Message-ID: <EE203446-8614-4FE5-8776-0C97D3B72B6A@oracle.com>
References: <20230329192425.194793-1-jlayton@kernel.org>
In-Reply-To: <20230329192425.194793-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6389:EE_
x-ms-office365-filtering-correlation-id: 6c3368d8-b063-44e1-d650-08db308bfa2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QzDN5YRUOTQWK7Ag3BG97pruO6OuxDw2umzmBypufGn9HuEmn8FEBeDDPYTkoEg+Ebpy1iv1ExPuGCWCs1PA8dxs1/Nd8ohY3dkkMZE4iQymdUM8WxCaAZUTdI0dAzt6aC8E83OY4MWiGG9juy1pK22dRyCTumetJNpWelPb+E4WBvKjLMrAun5s2vmQvocR8/+mHeCdXgWnLHxQUZuNryLrb7TsP3jSmIijslsf5SUepxyjDeTBs8We/M+bpBwM67m/HcDuxCX4UG3ESCXfveQ2yJYeiPKxIL39ks8ZtaKEeA1nNSEufIbpnfPn2LyHUjxZqQ1koBfvyVbOFdpmAkm8hm2HopCbrfIrBva82mdM+6PIMgRa24L0DJyTkIl8bNjmL71cqJZGRHrQQhxdYTnFb4ojG7XBf5Ylvxqrs3EZuDcDIYVceck08+by22/4ac5StgTWbcHY7YAnYH7BRWsqYhRwjbywFII9z41l6xuFbFPliJdmYbd3QtCEI99en3wT3z3Wmfp05uo35bdKI3P7hlCp85BrrOfgWg47d2PQaJvTjYHG2GXKO0AK3Bhfycgu2JQZLmXODeiBLSABmWXGBX01xrl2OHb6Kfoy8v8GdxDJJ9WLz0K0k3k2f4Jk6yNrk8TXjjbWUvS2v2BgSyr6UeEGVaVfVRAqq1kde0Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(2906002)(122000001)(5660300002)(33656002)(41300700001)(38100700002)(7416002)(6916009)(76116006)(4326008)(64756008)(8676002)(66476007)(8936002)(86362001)(38070700005)(36756003)(66946007)(66556008)(26005)(6486002)(478600001)(6506007)(66446008)(83380400001)(71200400001)(2616005)(53546011)(6512007)(186003)(54906003)(316002)(91956017)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AgVDzBDQ49WyflVbwrzI5Aoz89AOwY/pBiEMu+UmWuymU1oAmDT0Gw2OIWdY?=
 =?us-ascii?Q?h1LRLuuBlQKnKFlhyJh9xYkxAK8WzY0fEn1vzMikw87g9sl4mmWVVxt2rLGm?=
 =?us-ascii?Q?K7D1hgvy2/tnimdKDzn8tuRulgIvKR7LEdEoc1CRtZAmIo3uNsmMUwYIfExX?=
 =?us-ascii?Q?FvtQKKUlCUyveIQt0NTUpm6+rdmNl3W4iSVbHh0Tsj+iMRPEz+IkbQ94mMnE?=
 =?us-ascii?Q?4IDoIocxTgaLApshGEM/tr4Q/OVSxvNhzInItP9LGe1rgFPstrZMRgCZvbVR?=
 =?us-ascii?Q?QREV3gPHDQ5xdesLorVitPBkXRJtd8CpVXhE/6x1YrKPrCZT5hdNiCjkFsyD?=
 =?us-ascii?Q?aXBokOL5Rp3c2fSNCPxwOw7zMjChdtSfHbaJhnlsW4bOvCqFYNJMGJXBK7oX?=
 =?us-ascii?Q?GszlKf/Fp+XXdi1+4gsKjLhzoPnd+cICtfwkrMNAoOA4iMAu2+HVl6P95Aq0?=
 =?us-ascii?Q?sDkMxIEotvJfE9giSCJrFeFxlgQuUJNhX3LETo24ueFW3Bes7VEk6kuYWNQQ?=
 =?us-ascii?Q?82ieaXT4vXY2CwJFu487+OZSJotyHshndyOyRrNauhTp4zO4fnq0TDaOf7fQ?=
 =?us-ascii?Q?sj8ijKsfyqqz0be+0DSQHxT8VSKWIZOTAHNvw9aImX1aUFzHUoTy/NTioKgG?=
 =?us-ascii?Q?YNnU+AOBvrz2BFvMCsHy0OkZXCXIiXoklqi+cNywPE3xv/Snl93doiJknBb2?=
 =?us-ascii?Q?Z6Ve8ynSNSbPeP6TlMyDc/DXxxKJLl74A8wq0SVTz9uJhUzozzS/Tn5fuOFh?=
 =?us-ascii?Q?44mdTTLHli7TVxYcixAzOUs6dfy/t5Nel2vfi8zArLWPq/DjCtocu7Bpq4fP?=
 =?us-ascii?Q?Td3RDDOeSUHXJ0hwlqxdoDuDGJcfqQAIUeNzOddoJFy8Oj0O5YTgNGYtwkuz?=
 =?us-ascii?Q?VEvPDcBx8SeeZLtRYHn8mzQ2X6XQoO6qKiynMXBHT1jglUUFJD0iQWg7mV4t?=
 =?us-ascii?Q?qFXFVJSPV/pPlmgKUUBRTMJd0OhxPf+ZauQLmpG2/6vwQqOkLR9L7UWOPnjD?=
 =?us-ascii?Q?UWWhPw0sNulbcxzL6hIl0kMX+lNRcqd4xw91l3VqnHQrR+Q+t+BzWCmjpdM4?=
 =?us-ascii?Q?xGSrXDJhzgSGw/pZ3sead7TwUKkgUiCK4YeDJ+ixd12uIM/256lbcgfWI8y4?=
 =?us-ascii?Q?5jRRy2UgyCI6mRFNylyjYApv3NPaztTALPbMapTUsg+YS7oGS7dvgocnXrf9?=
 =?us-ascii?Q?H9t98elkTpq2wCrdRdwxNp2fEfxV0RFHNvxOBc9vSDMERXL9/ytycqy8DgGO?=
 =?us-ascii?Q?TMc9XdJIuxFRAakgKn7rT4xXUFXuQCLpGOJd15kcnPYBIeyHQGv5vZBNuVm8?=
 =?us-ascii?Q?J4W4/+rjkUbX3NGaufqoWaQndqj3eN2pkRSCGh6u8zcKVuVxJO2bJBWWODT0?=
 =?us-ascii?Q?jguM4M8KxuwgdGH0XH3gx+2Gdz3gy9zNzrxc7bnouCjr7KGH38QX2mnmtsLz?=
 =?us-ascii?Q?KfEPoIAkMtFyhN50fJzod1WHVxTjTICwgIKJJOdeTnwbyQ/M+IOfGQZTgRne?=
 =?us-ascii?Q?MOB7fs4UpUClJsLdE4Touk+J8PP7K0UpA9eKDSrkISOxTapiDfjOE5qbA6RG?=
 =?us-ascii?Q?i2Hbs69ot6KvD9LlKvmaY50aG7YW+qNvsNq/iD1nZABRvM0FJwI0Y0Vs8GkU?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFAC556D54F3AD4EA7F047B3D67AF169@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sy2vFVYvWmx+CxFBbshOJCKscXGRs9B/dexL0HnqrU0K44aSaJGf6vJ6r8jG?=
 =?us-ascii?Q?XqTP0RZNTAqq0dwl9vHaUt3wBwRc2Lk8TktM0/h+k3XBYhapmHAUJQenOVJ/?=
 =?us-ascii?Q?dkrJG7WEgR64YdCn+zawmM0Ap6DbcddfuZrvKZd/LjdXHZbgSaUMN0vDPwKU?=
 =?us-ascii?Q?NMpwgXX7cIVacMBkA7fLiYqq+gMJlot/MlCNVa0jQSBTrE83F+gO1Y7j08aq?=
 =?us-ascii?Q?HaxxyB/AsLGxE1vITzp4lqYiKPWjIj2CD0Hh6ZEqysP8GrlqIIYTN9ewOZmA?=
 =?us-ascii?Q?NXysJpC8ZXU99F9TtmbYhNT7Tx3VaENHwQ+Pb5UhnWgP+1FmJCSlcWF2pW4C?=
 =?us-ascii?Q?JVksDhY/ixIAM8uOiFTFo6I4pKYd2dnleoTkHjQhIHrFdb+2vdhnBkuc2PvF?=
 =?us-ascii?Q?jONC8ZeJQ+aka3M5SHoboxGrcOisdemPtwhIvm069jdAAjBkZjV5CITM1Y8a?=
 =?us-ascii?Q?WQJ5DGQwpUjLPimQqje49v84NGrltet49SyNyxhj/pwmVW+xWHu3UlS7OdHp?=
 =?us-ascii?Q?Ph2CPkSuKRW/m2O5JVbh58J4ncD5aSrlr2kSMcN+si38eFs0sGUgFK/Bf3DW?=
 =?us-ascii?Q?V2whkKvCM1Ahqfeewykj2g9LqaxOacBhfnFG+YkmXqkSJ1BY4k6Y34296E7T?=
 =?us-ascii?Q?LncGAyPo65+G7YJh1CvaQ9cKRILbjt7JvpDHOofd7VVAMO4VyWaKl+SsNl1G?=
 =?us-ascii?Q?xARjh+gGwl84luKSOMB2k+Grf7LJKccJqD9JopzPhJTwAavZckJV+ZMuSa6G?=
 =?us-ascii?Q?WwOlWpBni5USnf816zedAJeNetFgPmjz5ZEiMYO8nn1zU0tZh6hYCJTRi65w?=
 =?us-ascii?Q?MAws19kRft/VloFTHwINBg5Zlb2O63wQi4xiUnkIE4cJSW9JfxEKIQOcVo4F?=
 =?us-ascii?Q?uscK28zSuezSLFI14TpZpeG1mEegiqpuKcWwCodKO0ge2X0TDOqnt0dHZhUw?=
 =?us-ascii?Q?ecTfAEUajO3tkEqxPW5o55TE3RA9KqYLnzuREMaEttbQQmjNjjvSI6Y22Zcu?=
 =?us-ascii?Q?1M4nm7APNOSXViSgNbYYuEOgkAvoSXV5nrbdP+dS4BeAonyVFZ1BOeK5NiWA?=
 =?us-ascii?Q?AusILGC+uY/VCPnSQQiWQ2doTK5faAOsOUlmGQDPaWGvI+8w4dQVqQBD9JWF?=
 =?us-ascii?Q?AA3B7JtePGsu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3368d8-b063-44e1-d650-08db308bfa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 19:29:55.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vr7i5tNPXLb6rUvQ9t0LfxaFT+hwsvzb4ePQ736PWNUdRV17lconxaLy249O9pgJcmf+ZR3gOIHDHRWyJ7VUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_12,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=963 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290148
X-Proofpoint-GUID: M663MTDKtQT_3s3E9fUt7mpkd9TTGmcC
X-Proofpoint-ORIG-GUID: M663MTDKtQT_3s3E9fUt7mpkd9TTGmcC
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 29, 2023, at 3:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> There are 4 functions named dt_type() in the kernel. Consolidate the 3
> that are basically identical into one helper function in fs.h that
> takes a umode_t argument. The v9fs helper is renamed to distinguish it
> from the others.
>=20
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

One (non-blocking) comment below.


> ---
> fs/9p/vfs_dir.c    | 6 +++---
> fs/configfs/dir.c  | 8 +-------
> fs/kernfs/dir.c    | 8 +-------
> fs/libfs.c         | 9 ++-------
> include/linux/fs.h | 6 ++++++
> 5 files changed, 13 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index 3d74b04fe0de..80b331f7f446 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -41,12 +41,12 @@ struct p9_rdir {
> };
>=20
> /**
> - * dt_type - return file type
> + * v9fs_dt_type - return file type
>  * @mistat: mistat structure
>  *
>  */
>=20
> -static inline int dt_type(struct p9_wstat *mistat)
> +static inline int v9fs_dt_type(struct p9_wstat *mistat)
> {
> 	unsigned long perm =3D mistat->mode;
> 	int rettype =3D DT_REG;
> @@ -128,7 +128,7 @@ static int v9fs_dir_readdir(struct file *file, struct=
 dir_context *ctx)
> 			}
>=20
> 			over =3D !dir_emit(ctx, st.name, strlen(st.name),
> -					 v9fs_qid2ino(&st.qid), dt_type(&st));
> +					 v9fs_qid2ino(&st.qid), v9fs_dt_type(&st));
> 			p9stat_free(&st);
> 			if (over)
> 				return 0;
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 4afcbbe63e68..43863a1696eb 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1599,12 +1599,6 @@ static int configfs_dir_close(struct inode *inode,=
 struct file *file)
> 	return 0;
> }
>=20
> -/* Relationship between s_mode and the DT_xxx types */
> -static inline unsigned char dt_type(struct configfs_dirent *sd)
> -{
> -	return (sd->s_mode >> 12) & 15;
> -}
> -
> static int configfs_readdir(struct file *file, struct dir_context *ctx)
> {
> 	struct dentry *dentry =3D file->f_path.dentry;
> @@ -1654,7 +1648,7 @@ static int configfs_readdir(struct file *file, stru=
ct dir_context *ctx)
> 		name =3D configfs_get_name(next);
> 		len =3D strlen(name);
>=20
> -		if (!dir_emit(ctx, name, len, ino, dt_type(next)))
> +		if (!dir_emit(ctx, name, len, ino, dt_type(next->s_mode)))
> 			return 0;
>=20
> 		spin_lock(&configfs_dirent_lock);
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index ef00b5fe8cee..0b7e9b8ee93e 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1748,12 +1748,6 @@ int kernfs_rename_ns(struct kernfs_node *kn, struc=
t kernfs_node *new_parent,
> 	return error;
> }
>=20
> -/* Relationship between mode and the DT_xxx types */
> -static inline unsigned char dt_type(struct kernfs_node *kn)
> -{
> -	return (kn->mode >> 12) & 15;
> -}
> -
> static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
> {
> 	kernfs_put(filp->private_data);
> @@ -1831,7 +1825,7 @@ static int kernfs_fop_readdir(struct file *file, st=
ruct dir_context *ctx)
> 	     pos;
> 	     pos =3D kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
> 		const char *name =3D pos->name;
> -		unsigned int type =3D dt_type(pos);
> +		unsigned int type =3D dt_type(pos->mode);
> 		int len =3D strlen(name);
> 		ino_t ino =3D kernfs_ino(pos);
>=20
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 4eda519c3002..d0f0cdae9ff7 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -174,12 +174,6 @@ loff_t dcache_dir_lseek(struct file *file, loff_t of=
fset, int whence)
> }
> EXPORT_SYMBOL(dcache_dir_lseek);
>=20
> -/* Relationship between i_mode and the DT_xxx types */
> -static inline unsigned char dt_type(struct inode *inode)
> -{
> -	return (inode->i_mode >> 12) & 15;
> -}
> -
> /*
>  * Directory is locked and all positive dentries in it are safe, since
>  * for ramfs-type trees they can't go away without unlink() or rmdir(),
> @@ -206,7 +200,8 @@ int dcache_readdir(struct file *file, struct dir_cont=
ext *ctx)
>=20
> 	while ((next =3D scan_positives(cursor, p, 1, next)) !=3D NULL) {
> 		if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
> -			      d_inode(next)->i_ino, dt_type(d_inode(next))))
> +			      d_inode(next)->i_ino,
> +			      dt_type(d_inode(next)->i_mode)))
> 			break;
> 		ctx->pos++;
> 		p =3D &next->d_child;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..777a3641fc5d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2885,6 +2885,12 @@ extern void iterate_supers(void (*)(struct super_b=
lock *, void *), void *);
> extern void iterate_supers_type(struct file_system_type *,
> 			        void (*)(struct super_block *, void *), void *);
>=20
> +/* Relationship between i_mode and the DT_xxx types */
> +static inline unsigned char dt_type(umode_t mode)
> +{
> +	return (mode >> 12) & 15;

Was wondering if there are appropriate symbolic constants
that could be used instead of naked integers? NBD if not.


> +}
> +
> extern int dcache_dir_open(struct inode *, struct file *);
> extern int dcache_dir_close(struct inode *, struct file *);
> extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
> --=20
> 2.39.2
>=20

--
Chuck Lever


