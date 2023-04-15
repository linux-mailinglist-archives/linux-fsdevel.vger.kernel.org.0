Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDEE6E3274
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDOQfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOQfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:35:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136E440F0;
        Sat, 15 Apr 2023 09:35:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FDfZgi005293;
        Sat, 15 Apr 2023 16:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KmtKPb23UUsSIAU+TxdeiwH1/w5Oho/S4BlBJxaspL4=;
 b=us/6xU/pxp2fU0r9dLY7pSkCdLCKyfLSmDQump5jCR72UEN4O0CY+XhFZNeG5bYIoONH
 JVCPZMczcclzyCl8aS8GsJv6/khy/AsqwuLcew2athWAwXiPndE8a+bm1H1utG76Dhvr
 9RC1dshK75urJON1ZgXgsdlRemhncndzveG7jpPGrAEDOGUE0X1Hq66/7jCxRrbS+Ada
 mptatOdsA3E3oQyXqli2w/Yt9fIrRwCSV1yWOJoHZ/J5G3UzkjuytjJEnCv1PSn6i7Pr
 D56GL3XcyU69ln2NwLOhIQa/ktXHFTX6Ld0SRo3p+LsUsNVFrFNQ07xS4M7BXIqZ1mNh 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhtrm64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 16:34:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33FBsFog007522;
        Sat, 15 Apr 2023 16:34:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc268w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 16:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7z9BRjdoOJJ1eFS2QXFWfVsimJYCvTS8EkrtJ4ngnngurLtrwO5TVWYDw3gIQOp2SLKq555JaOiBsoV75ZZEaiJ4ZvqSXBYsAM0uI9qoqiIHNHQSfTlWbXBZbs7j/l+989jil3IcXxoSqTkYkPP7dpuY4hmaU4wZMpCn0dJ0GQ/PleT/rvKb7Ro2oNF9z8dObn1qL6nT1nTFS9PW3jqyK+ly5nibCyUkxP3FLnzgXqPsv9tzkojYqjbelDPunXAzPN4TUDVDxtI3JspPhrlFb6d1ZW+yQ3vSR7tr0zqU7fkCbh7gatxdEL0Bg+firIN5VacjvLPknm+n+xAZfPfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmtKPb23UUsSIAU+TxdeiwH1/w5Oho/S4BlBJxaspL4=;
 b=aNdnKseFr+7mvlK2eYTmS8A9O1VsT8wAzeosyi2niAlYmWPGAcALcm9os58Wmk4nBZODhmJLBpxkRasL+eU51ZVisIqT+BBWsdhgTfn8OvVA6KI8jRbjiCqnQ4aMh2rVWFQP2bopq1ZuZiOFBmmNXVd+YU3ImNnNoOS3dqNYiAi54PyrIuBMhr0dUeRn/iuePI8+AI5R7Xdg7/5Tzn8qLFeqK0U4EJ+0fS5p0cgXpGUfFeXIwTq7UCm3qkeipyI/zZ19xiWhyZyEvHk2iKJ2jqPGDHpLNXh58PpVZKYXdOxcI/i4h/HydPkvYukP2++7oWLBrCJ9zDtfizx6kkpLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmtKPb23UUsSIAU+TxdeiwH1/w5Oho/S4BlBJxaspL4=;
 b=fcq7d8ULjj6ib+1icRLL+bpJhPWmY2VpkI+pV5gVKe553JWpSfhrvPrVk3HGyf5LGBHFzyg2cXu7VV0e4JPJtNjLtcY9wZ0sDXvNN7sxQIN/UTWBkAXTvlzF6MLwiNVfpaabYFKNjJbutWpWc2HFclsBlVi3F1tddDHI6xiDt9A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 16:34:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 16:34:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Topic: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Index: AQHZbWxjHsN6sWZ220WWP7UeL6JICq8slYaA
Date:   Sat, 15 Apr 2023 16:34:56 +0000
Message-ID: <45099985-B9DE-4842-9D0F-58A5205CD81D@oracle.com>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
In-Reply-To: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4614:EE_
x-ms-office365-filtering-correlation-id: 3474cd9f-8e60-413c-363b-08db3dcf58d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U9v0a0lxpgNAA3kDJ2xlvDzfb9GD8PKu78kPsJfOGpDUbpPWWNCTy9tgz/tiewzI041doFxt/g2b78rXxiJtsdFAIAB1Y784Ek+/Dysql6yPbRXbtkC5XiHZhCjpE/WKD8X+nX4WwPxm+lVdNGM+N1H3Wc3eRGdd1SHLcbX0MdS1zaxmdqb5HJttLQAYR8R3bRTeUjnr8YZZi7lFfgp3L+4IaXfnJacc0L6e1ZhXRDGU7QbmQeEY/Db7+9Q50lvfn1OIZUsySdeBwcIeyt7TqYqQJtl/4MAj8AxqoSH53us+Sb/WGZNCFUuvrBeFjk6gKhpL72YhhaIlGV47n0nCOU6wBZLMZA5rK2sE/rNNrXlJw3pgNJiFCzuuOfl8UUfNrXC7Axnt95VyYvRO0rlGqLE+w3q0vktLCAKGL/BKx/B5kc5sRkv4Ji5KJaDDnJTsecu2Ej3/HHxe++v34GbNA5MraDhqIX4lM+K8nHrWssY7mODKJcfZP2DJDTAlcVh+ZPy02mBcIhJj9ZDr3B+xkdYogLpUyrEVJX4V+M7NvAjPPGJJQ+FT1DGqp7HBASAYeEY7mce9NUhgKcwh50rQuFkU3e2ajY8CHRUmUl9QJjF/c3iduLdx0EtpB0REZBpN5JJ9V5RysnJLqWQorP/KWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(41300700001)(66446008)(66476007)(64756008)(2616005)(66556008)(66946007)(76116006)(91956017)(36756003)(186003)(2906002)(38070700005)(83380400001)(5660300002)(33656002)(8936002)(8676002)(86362001)(71200400001)(6486002)(478600001)(6512007)(122000001)(53546011)(6506007)(26005)(316002)(38100700002)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzZlWUhnY2F5b1lNVVRJZXdKYVA4b0hWZUNxVk4xa2lUVkc3SmtYcXRLWU13?=
 =?utf-8?B?UzVETGpUS3dxdW1aRThsU3dlNVJ2VUZPbi9NVHExOTBoZXZpb2V3b1hFWm9H?=
 =?utf-8?B?aXR4UlhMekk2SEU5OTIvSmlTV2x6TnFpNjBLakhaZHR0dDR0K1dacUtHdCt2?=
 =?utf-8?B?blV2MTdkZkFVTUJnMWZsZm5icVFOazBqWlRCQUU5TC8zUy9CU2tDSy9YTjBw?=
 =?utf-8?B?c0c5ZENvV3ZndGhVMVdIdGMrVEwxbjNNdFMxTVd6SUNpdGJWWFl4UXVuTVc1?=
 =?utf-8?B?dStVOC9jcXI5M2hsbzFZaDk5cXV2Q215QTBmVzhpNURVQ3NUTGo3V2hBRllo?=
 =?utf-8?B?a1FURXdOdTJqRE1OZ0FQTDZkUGFrcjRMajBOZzNPTnpVS3E0ejMyd09pL3dn?=
 =?utf-8?B?OVFjeG9lR2VhTWd0ejNqZzhhTEw0U2dXeFZXb29CamQxaFBQWTh6emJaUTI0?=
 =?utf-8?B?Q3ZISEdFYVQ3WXRFWFp2U0pPRW0wSjBQYzNTTXZOUCtYVWwwMEVWbXVkU0dK?=
 =?utf-8?B?eHhUVklwOWxyK2N2N3IwK3hmcVRpZW1jRzB4OHNUU3RTM0J5VjFzRU9xZ01z?=
 =?utf-8?B?aDFJMnVIUkZzeWl4bFRkZ1FDY1ZKT3FZc0tSaTAreWc1TFMvb09jV04zZ25L?=
 =?utf-8?B?TTFEUms2OXdxcWhjbzlrR2VJeWV4R085Q3VzVEJlWnBMcDZ5WmhQM2xpT3RS?=
 =?utf-8?B?aXI2b2NBdnMvL0F4S2pCODZqR1pFVUppSkM0dGdpbjgzMHNkMENyUmRlVFk5?=
 =?utf-8?B?R0xUT1Q3ejlibWF1T1o4VERPV3NxYWVlMncxcWIydzhqS3IyU0FOb1M0UGVj?=
 =?utf-8?B?ZFErbHJZdHVuRWJIb2RDai9ZdjZXOGtKeXVWOU8wOHRiZkxkUnhjQTRFQXI3?=
 =?utf-8?B?ZWVUaG94K2p4d0dUcDNIaFZ2QVJDSUVLZiszUHlVWE5tZFBuWU82SUQ2a0E4?=
 =?utf-8?B?YkNUYTlaM09YUkVHdE9qVUw3UzZ2amdRenJaTEUvV1VIclMwK0l2QWFlM21B?=
 =?utf-8?B?QkZZNkxBOTdVaERKMTFyemJkZkoyUnhEUnVXcnN1cWhZK3dzeHlrRUl6ak55?=
 =?utf-8?B?TTgrTThBQWdCUTEzc3VrWjNCNlVlM2svMENXTzB4VWpEZkJXcTZJUVNZY2tv?=
 =?utf-8?B?KzB2dHQ1b2thU1hnMk1GWFA5a0QrZHdJZ2Y4T3VSQUtkOHJUSHIrWFg0U2ZO?=
 =?utf-8?B?MElNT1ZEL0RDZjc3eVJwdFhvUFh1b1NKVi9TUEtyOVJQQ2xYSm4yWi90N3RY?=
 =?utf-8?B?ZDBjUU1HQWp3Y0grTzExQjdnRTlQdHZQbThLMGVkUFZZVm9Td3lDWDZxZk91?=
 =?utf-8?B?S3JvaURMNzBCeHE5ekFvRFUvNnBNZFVTakc1U09WODhuTnBEaCs0SlphK3VF?=
 =?utf-8?B?WUlxL09Gb0J3dDJFek9SQWRldWc4ZzhNWkY5RGlzb1psYW1uV0FjNXNlSTFz?=
 =?utf-8?B?d0Y2WEZ6NVVFMG56cnhQczgwRElXNzlFc1dSL0RGM2NYMVZUMk5ZQXMxZHpq?=
 =?utf-8?B?V3hveS9TczgzdkRBby9zNWxiank1K0VuN1JqdFJ0NGtmNWZPclhOaExJa05w?=
 =?utf-8?B?NEE2YXJrYlB6NEpQeG03NkpaNXVqQ2IweGE2MUFERkQxaU9PUlc1UzgrNUw5?=
 =?utf-8?B?Y09pZ2lMSEhGaWJXSU5DQkJlYmlSS2I3Z3JkVHBmb1hjR2QrWWRYWGpFMTAv?=
 =?utf-8?B?TEQyZU5oQk1GUTJCQnlkZkNjWkZtWEc4aVVleXQ3d3FheWFQSEt5TEFDbEVj?=
 =?utf-8?B?MGdmYTNOSnpPekFQMElTOTM1ZWFjNG5OU0gyNkFEaEtRVFZwMzZaTEhFVXVC?=
 =?utf-8?B?RXBBZExOUDU2Z3BiZGRSZ3FESzR3RFB2bEtRRHRZc1d1aE1PZ05LRGJWb3hL?=
 =?utf-8?B?aGJybjhnaGxjTzVGVXFNa1U3akVnTEVWb0Z2U2xxZ0VrWXZZRXA0K3JCQWln?=
 =?utf-8?B?WTVObnlqVWFqRlVUQVlwTjllSEV2M3ByWWtZRWQ2NmVEZVZSWjF2dzdBbXBv?=
 =?utf-8?B?ajE5YkxzRHNDcytUWTlXdjZSeHBkNjk5dFptU21SMU5OTEw1MUdsaHdpR3RQ?=
 =?utf-8?B?QTRnaHJVM20vdVRSZ0IyZTRseFFnbHcvZ0VlbThCNG13M01BN0xqZE4ydkM4?=
 =?utf-8?B?Uk1lSEs5SmdhWXBTcjBUYmlUMnp5ZGt2THUxMzVzdWJoYWNIbzIwclNaMHNQ?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA2C3DC7CC4B24E9CDB20B223106FC1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AxA7RzMQ2cQ4KbLfxHK5mIov5hOK3anNWtzSCp9Ksgjwe8U1tsG3PlhDwi/o9j2MHiOVCBGzjhD6TACaG+mH1VW3BVKJBZxK4VMLnJXtZ5W/r7DeAwOiF9c70DkbcABcM03DSh3bvHWZkn7pXr7pfb6Yi5fN6JOypTnM3GDZnYGFPa0GmjLKrnAw3Mhkd7vaMLt2La4K57JmKdor/Ty3h5WgrS1iTSzZJAA/pDe5kDylmJ9KpzHuPBr0N0QJGpM0oeT1We81gC3EQxSyqj/lGAPQqA42/mhwKaB/O680x7XJQJeGZiGVihYzrcA4mmfEVNCocJlrQdnI4w5iANadko31yru+RdZbHOMFWAtxaTJZIa/6rUCXK4NqrjoU9+093XXuLYa2IxyJD2dt3+/R0vcISbq2byHKCXZkgB29EzpVKpDjYBhX93JgiFhDlsYxSNuYIRtnIMt5eoY4gephJpUrXm4q9AtZb3oVXMRtw/WYRA7fxivPm0JpOQDZqZgQ69n7fo+3esJjG5HsItQFfV7Xwv5PtWcENrpF4NNZrm9JBk7ON41ELspEDOWUW+xu/oLLxracjWqzdYI0jC202DRv7F29AD6GXM19ilolwtSsrWQ8uPdoi9iMDeFQXroAmaJyDahcOaeNr8ozrW+F1TjYDDjTKiM3HEKewpCN9RCvHde8DocQ7NgM/dFoX2sGylBBSdnOpAXuUqQGDAiBT7b45njkoboYfnu8aRN8xbGSV/o7taz+m9A/igqOmFTf5OMUlRqZNDVhebPBa4ExljPEgDpOhAHMHFFb/BTupkmqzAwnxpMYE96qHG1+CRY9RPnBfDMB588XgenOzxcWYg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3474cd9f-8e60-413c-363b-08db3dcf58d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2023 16:34:56.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkOdQa2/zusrIy5c5VxsyxCSN1jg7CnPPH/znSkmC9dRxpm6LJ2aprxf2P2xDWxSsvkiI1eGp/hZr1wPidpm2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_08,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150152
X-Proofpoint-GUID: cDaZ7G24aT6YTZSZeISoEQQeKLmbDtru
X-Proofpoint-ORIG-GUID: cDaZ7G24aT6YTZSZeISoEQQeKLmbDtru
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEFwciAxMiwgMjAyMywgYXQgMjoyNiBQTSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IEknZCBsaWtlIHRvIHJlcXVlc3Qgc29tZSB0
aW1lIGZvciB0aG9zZSBpbnRlcmVzdGVkIHNwZWNpZmljYWxseQ0KPiBpbiBORlNEIHRvIGdhdGhl
ciBhbmQgZGlzY3VzcyBzb21lIHRvcGljcy4gTm90IGEgbmV0d29yayBmaWxlDQo+IHN5c3RlbSBm
cmVlLWZvci1hbGwsIGJ1dCBzcGVjaWZpY2FsbHkgZm9yIE5GU0QsIGJlY2F1c2UgdGhlcmUNCj4g
aXMgYSBsb25nIGxpc3Qgb2YgcG90ZW50aWFsIHRvcGljczoNCj4gDQo+ICAgIOKAoiBQcm9ncmVz
cyBvbiB1c2luZyBpb21hcCBmb3IgTkZTRCBSRUFEL1JFQURfUExVUyAoYW5uYSkNCj4gICAg4oCi
IFJlcGxhY2luZyBuZnNkX3NwbGljZV9hY3RvciAoYWxsKQ0KPiAgICDigKIgVHJhbnNpdGlvbiBm
cm9tIHBhZ2UgYXJyYXlzIHRvIGJ2ZWNzIChkaG93ZWxscywgaGNoKQ0KPiAgICDigKIgdG1wZnMg
ZGlyZWN0b3J5IGNvb2tpZSBzdGFiaWxpdHkgKGNlbCkNCj4gICAg4oCiIHRpbWVzdGFtcCByZXNv
bHV0aW9uIGFuZCBpX3ZlcnNpb24gKGpsYXl0b24pDQo+ICAgIOKAoiBHU1MgS2VyYmVyb3MgZnV0
dXJlcyAoZGhvd2VsbHMpDQo+ICAgIOKAoiBORlMvTkZTRCBDSSAoamxheXRvbikNCj4gICAg4oCi
IE5GU0QgUE9TSVggdG8gTkZTdjQgQUNMIHRyYW5zbGF0aW9uIC0gd3JpdGluZyBkb3duIHRoZSBy
dWxlcyAoYWxsKQ0KPiANCj4gU29tZSBvZiB0aGVzZSB0b3BpY3MgbWlnaHQgYmUgYXBwZWFsaW5n
IHRvIG90aGVycyBub3Qgc3BlY2lmaWNhbGx5DQo+IGludm9sdmVkIHdpdGggTkZTRCBkZXZlbG9w
bWVudC4gSWYgdGhlcmUncyBzb21ldGhpbmcgdGhhdCBzaG91bGQNCj4gYmUgbW92ZWQgdG8gYW5v
dGhlciB0cmFjayBvciBzZXNzaW9uLCBwbGVhc2UgcGlwZSB1cC4NCg0KSXQncyBiZWVuIHN1Z2dl
c3RlZCB0aGF0IHRoaXMgaXMgdG9vIG1hbnkgdG9waWNzIGZvciBhDQpzaW5nbGUgc2Vzc2lvbi4g
TGV0IG1lIHByb3Bvc2Ugc29tZSB3YXlzIG9mIGJyZWFraW5nIGl0DQp1cC4NCg0KPiAgICDigKIg
UHJvZ3Jlc3Mgb24gdXNpbmcgaW9tYXAgZm9yIE5GU0QgUkVBRC9SRUFEX1BMVVMgKGFubmEpDQo+
ICAgIOKAoiBSZXBsYWNpbmcgbmZzZF9zcGxpY2VfYWN0b3INCg0KDQpUaGlzIGlzIHByb2JhYmx5
IHdvcnRoIGl0cyBvd24gc2Vzc2lvbi4gV2UgbWlnaHQgd2FudCB0bw0KaW5jbHVkZSBob3cgdG8g
Y29udmVydCBORlNEIHRvIHVzZSBmb2xpb3MsIG9yIG1heWJlIHRoYXQNCmRlc2VydmVzIGl0cyBv
d24gY29udmVyc2F0aW9uLg0KDQo+ICAgIOKAoiBUcmFuc2l0aW9uIGZyb20gcGFnZSBhcnJheXMg
dG8gYnZlY3MgKGRob3dlbGxzLCBoY2gpDQoNCg0KVGhpcyBpcyBzb21ldGhpbmcgd2UgY2FuIHRh
a2UgdG8gdGhlIGhhbGx3YXkgb3IgZGlzY3Vzcw0Kb3ZlciBiZWVycyBvciBhIG1lYWwuDQoNCj4g
ICAg4oCiIHRtcGZzIGRpcmVjdG9yeSBjb29raWUgc3RhYmlsaXR5IChjZWwpDQoNClRoaXMgY291
bGQgYmUgYSBGUy9NTSBzZXNzaW9uLiBBc2lkZSBmcm9tIGRpcmVjdG9yeQ0KY29va2llcywgdGhl
cmUgYXJlIGlzc3VlcyBhYm91dCBleHBvcnRpbmcgYW55IHNobWVtZnMtDQpiYXNlZCBmaWxlc3lz
dGVtIChhdXRvZnMgaXMgYW5vdGhlcikuDQoNCj4gICAg4oCiIHRpbWVzdGFtcCByZXNvbHV0aW9u
IGFuZCBpX3ZlcnNpb24gKGpsYXl0b24pDQoNCkknbGwgbGV0IEplZmYgcHJvcG9zZSBzb21ldGhp
bmcgaGVyZSwgYW5kIHRha2UgdGhpcyBvZmYNCnRoZSBORlNELXNwZWNpZmljIGFnZW5kYS4NCg0K
PiAgICDigKIgR1NTIEtlcmJlcm9zIGZ1dHVyZXMgKGRob3dlbGxzKQ0KDQpQZXJoYXBzIHRoaXMg
dG9waWMgYWxzbyByZXF1aXJlcyB1cyB0byBiZSBkcnVuayBmaXJzdC4NClNlcmlvdXNseSwgdGhv
dWdoLi4uIGl0IGNvdWxkIGJlIGEgcHJldHR5IHNwZWNpYWxpemVkDQpjb252ZXJzYXRpb24sIGFu
ZCB0aHVzIGxlZnQgZm9yIHRoZSBoYWxsd2F5IHRyYWNrLg0KDQpPciwgRGF2aWQgYW5kIEkgY291
bGQgZm9sZCB0aGlzIGludG8gdGhlIGJ2ZWNzIGRpc2N1c3Npb24NCmFib3ZlLCBhcyB0aGVzZSB0
d28gYXJlIHNvbWV3aGF0IHJlbGF0ZWQuDQoNCj4gICAg4oCiIE5GUy9ORlNEIENJIChqbGF5dG9u
KQ0KDQpOZXR3b3JrIGZpbGVzeXN0ZW1zIGhhdmUgc3BlY2lhbCByZXF1aXJlbWVudHMgZm9yIENJ
Lg0KSmVmZiBoYXMgYmVlbiB3b3JraW5nIG9uIHNoYXBpbmcga2Rldm9wcyB0byB3b3JrIGZvcg0K
b3VyIG5lZWRzLCBhbmQgdGhlIHdvcmsgcHJvYmFibHkgaGFzIGJyb2FkZXIgYXBwZWFsDQp0aGFu
IG9ubHkgdG8gTkZTLiBUaGlzIGNvdWxkIGJlIGl0cyBvd24gMzAtbWludXRlIHNlc3Npb24sDQpv
ciBtYXliZSB3ZSd2ZSBnb3QgbW9zdCBldmVyeXRoaW5nIHdvcmtlZCBvdXQgYWxyZWFkeT8NCg0K
PiAgICDigKIgTkZTRCBQT1NJWCB0byBORlN2NCBBQ0wgdHJhbnNsYXRpb24gLSB3cml0aW5nIGRv
d24gdGhlIHJ1bGVzIChhbGwpDQoNCg0KQ291bGQgYmUgaXRzIG93biBzZXNzaW9uLCBidXQgaXQg
bWlnaHQgaGF2ZSBvbmx5IGENCmhhbmRmdWwgb2YgaW50ZXJlc3RlZCBwYXJ0aWVzLg0KDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg==
