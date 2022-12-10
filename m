Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9C6490E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 22:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLJVyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 16:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJVyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 16:54:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74E615FC1;
        Sat, 10 Dec 2022 13:54:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BALZFsZ021216;
        Sat, 10 Dec 2022 21:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Dmsru2YDbKoEZ8fUHXv8rbnoXMoQR8Jsyirb8VKiaeU=;
 b=XNofF4I3J8Z/R7LwJPOZClOkSDhoxvGYDdpOPAN21C56qjdooHaBJzXGFVNrw6yu9mOL
 nwXZTD94lWA6BPhHrErslLwEJddaFnLYwLWAN8xGhyWl8rf0v9V1f/GQr4f27RNmgqpq
 bJLOBa9/PIsnxeWC3T5ird6duX9tXLS+71jnnc3Ba/E3R6g81gJPA8l5yrGecwsWAHz6
 GRJgBh/E2ikNAUKqqsR9gdmKlzTPo3LYVALtY6NNy89PQNH6WIHcTH8S4jDrwNVCjMSQ
 4MqStGqIeSnQ3glry60/0wT5X8xLIhYtv9FAj+s0OW29LBz9S3ShiGPItqpTiYX4mNf2 +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj5brnk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 21:53:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BAKbp5d005897;
        Sat, 10 Dec 2022 21:53:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj220c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 21:53:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuGxJGUjMWBr0hAGDcV3Y7rTEIT+jo4xdpg8ak/7IV2mLs6Lz2rU1zBp5p30dQo3dZU5Z4U/HkxcXBVqcyL/iJl4PRhbv3S+i70Z6s1u0RHmdCunbUfsM2c4jW+PIZVfxR7QiS8wRQXA0lvNV1Di9crvzvHngINDpan/LvwvzA3fT6Cvo3idAiQgpBiCFxPA0nFoNpW88fXxlhdNPV7vVC78CaX56MpT8mDYgzBo+Iv2qR7AkRPMxA49ipuFcWt46GTnByZ2pzhzbuaA8I0bnSRkfZmCKYZpYVZnwawFHhjdKbUPidldj7y0jgOTVKKy5cVlWitPQkdhwLP1sb1Phg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmsru2YDbKoEZ8fUHXv8rbnoXMoQR8Jsyirb8VKiaeU=;
 b=T+fd/tLqxtwVCkse+TzR2vQJWJsUfe6/FTB6tSI19FBiDPm4bp+c0kU43X71XvjYnuyp4Gf0u9OT7ZCmWsa9WftWudLDrwLmSJ58gGsi8jRQkbErzmzhy6GYu8kDIqJu4/+A9akwR/WWYp5mj0yR9mceMLSciiPsL+GOQPy+3YkCySEbaCVOAIRahtyiEhAG/UPohxh9RCC6PMKH/H6SSsSo/QAoGVCWW60M/avCmypfkXtWJijmvL6ESWuoCFxTDAS9hvK0Rts9nm9iFFm2XMtY3XnnabV2X5ttCGJ9bv6yYidqdXdxsTWpb/j9n4yzoxY/to5oXKLjm0hbFo3G2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dmsru2YDbKoEZ8fUHXv8rbnoXMoQR8Jsyirb8VKiaeU=;
 b=VCIOilmjvjaA7WhV7wHBtieUlyhRHA+zyZoJxSCbtwoM9wHtUBeR27TRQBXzTsjxWwVnpWAjDVk+A8xegJmcao+3JT1VZuNy8177Qoj7MuaGpFUYElicnSxbBqjpSDfrYjJglzaaOhR8vOOljFy0XIhq85pslV5JTzfOfDFcbXw=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by CO1PR10MB4403.namprd10.prod.outlook.com (2603:10b6:303:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 21:53:55 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 21:53:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, anna <anna@kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven <raven@themaw.net>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david <david@sigma-star.at>,
        "benmaynard@google.com" <benmaynard@google.com>
Subject: Re: [PATCH 0/3 v2] NFS: NFSD: Allow crossing mounts when re-exporting
Thread-Topic: [PATCH 0/3 v2] NFS: NFSD: Allow crossing mounts when
 re-exporting
Thread-Index: AQHZChf8XdRuFhfYVUuBoBZu4IH8sa5nT0OA6nC3O8WVj6kcAA==
Date:   Sat, 10 Dec 2022 21:53:54 +0000
Message-ID: <92ED1723-4F11-4F48-9B4D-089F29AE91A7@oracle.com>
References: <20221207084309.8499-1-richard@nod.at>
 <1AFA78FF-3F09-47E3-BE13-F5BB7F9C779C@oracle.com>
 <1733592831.372285.1670709120777.JavaMail.zimbra@nod.at>
In-Reply-To: <1733592831.372285.1670709120777.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|CO1PR10MB4403:EE_
x-ms-office365-filtering-correlation-id: 3b675a1f-23e5-4c8c-f64d-08dadaf9086b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27RDi0qotXDIgmXUkHN56iU9CNsLuUTEmo8gO4+UEQQeSaSjRzRtQ49YOh/Q3IYf6k8HHpJYJLruxU+FvWbdX+8cCnVoJNlyJwgkON5wmuY+RBMmaE36WO3h/sTpRl8bNwKnGE/EqMPX4eHYl5KfbK/6UKk5PIMxE1PYrD87CEtrAuLQVTuSkOFpS+xPIccFo2i8FsE4VcnQhXkDcWwEfnled/eWvBNoBnp+ysSRr0/VdlGZLPgDOHiwDmpP8H3HrF8VJPIrIo1XcQ82kf5arJHJm0JEei80KhK4aQtozbFaNCFmj7Nci8CKpAQeUoYLS7+GkGEcDSGfoIWBV4Lk5YUKEIyX803oBbUgIWMOfOU8gWUBacsIorDR3os95J+8KQuljZv38iVrkfUNdCa+k1cRYtsusY+PtiSla8x9k1uQ4VEIQSHLnJt87FP0soaPcRRGjmMwmXO1eb+NzJ6FX7olEiTSaDLsCVQ+nTScEN+6Tk+P/ZxOY9kPCOWJjavr4ybd6tq4MkwRGOCDaeYhrS0SZDQBBp3COwCmGUfmt1hp+BvpC+JCbmURuUG9Z144+gZ/lPRXIIHyAqxt07XELvfOkdSAQxcPnd1AcbLCon5CyX+Y7gqczvkNXXFJLtKKsRrecBqJq+V0Y3IsYqDtTXu5AVrJ1nDbIp5llpXcD5kHtLBLZrOp/wCu6QMDUE31HNNglJa54rj6/P4w9fZShlfNySyT41r1hW5aLRya3h8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(71200400001)(6486002)(478600001)(53546011)(2906002)(6506007)(33656002)(66574015)(86362001)(36756003)(6512007)(8936002)(26005)(186003)(38070700005)(7416002)(5660300002)(38100700002)(2616005)(4326008)(41300700001)(122000001)(83380400001)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(8676002)(316002)(6916009)(76116006)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXQ3d0tkRDJwS1lSTHM3OTIyWnppc2RuU2daZGVsYnV2eGlJS1BzRlVnWkE3?=
 =?utf-8?B?VlNXU2FEekNpZm9IVERYcmU5aFhLSDlVTEl4MjJkcHpvNmNVY3pFRVRzaWZS?=
 =?utf-8?B?RStyR09URWs3dWIwSHdoMHVyTGV3MEU0aHdnL3NlU2RJeXg3a2d5QUx5WGdM?=
 =?utf-8?B?UFhVK3BHbnlxV2VNUHl4Z3JoSzhZYkpRamRPZTlYeDJTVWJ0V1Z1dDNlMzZC?=
 =?utf-8?B?RlR1QVVoaitwZGNPSVpRaG5zYmNIcUJnZ2w0TmhwWmxoMnFCeEVEemJqcTZG?=
 =?utf-8?B?cU5icko2bjJHdEtqV0RlU2QxdFZTMmR1aUpWRnRKbzNxK3VHWWFGRlRvTnJy?=
 =?utf-8?B?cnpoWGRNV01Odmh4OGNFdnBwdklSZjVhaGFWZGdqbVZFcTZFcmtsRTh0NmlE?=
 =?utf-8?B?Q2djRGM5TEQ3NFFqeDRRWWdzMVJYay9aWlVpeVZxZ3NhOUNlRzkzSTVIOXhx?=
 =?utf-8?B?TE1kdFBNUm03dXRoZHpFVUhlY0lvb1BtWGsxMGxZaWJqYmNDZnhoUkd1MVUy?=
 =?utf-8?B?aWJ6THNqTVlVOUU3QmwwK29xUlBHSDIzSkpOc3pPN0Q5RENFbCt5K1NmM3pK?=
 =?utf-8?B?bDhUNTJsdlZaK01GT1pUOFBTRVdwQkxPYlRCMTZOcWV6K3lEL3FrRm5sK1BD?=
 =?utf-8?B?czVZV1NGdFdYZEFHQmVRYWxueVphWlFjbUxnZW5CRjN4SjBJQ1pIaFFINkJL?=
 =?utf-8?B?YzBWMTJBc2VhVmVzK2ppbis3U0lHUjVySUNMQmdIeUhNa3VRRVZZQjlXOWxV?=
 =?utf-8?B?Mk0yVUdBRTJHU1RrZDgvQ3FhMHByNnBXOVc5UlJCMS8yVnRrUFNVVm8rVEE4?=
 =?utf-8?B?ei8wcFVnRWgxY0pWa1p2U0YrbmwyL0dWN3NBamVBRm03YmN1eHpOWkJ6Wi9L?=
 =?utf-8?B?Q21pS1F0WEx6elk1c0J0OUlVK2ZLSHltSzM0NWZGM0VGelFQcHZnWTBXL2FC?=
 =?utf-8?B?MTAwUDB1Ykx2M3I1RjBYZnZ2bXdPUjFwR0tyaEdUcFE0eHQvbE5OTHk1Y0lu?=
 =?utf-8?B?YUg1cDZha3BIZUVPVXpPTExBZFZ1OSs2WUFKczhzWnY1d0VHYTRwQ3JtRmFF?=
 =?utf-8?B?VWxybHI0SXBpRit4NVh0THhrRGpOSk4yNzIxcmNjSWZKQTVnUzZ6OUFIT0xm?=
 =?utf-8?B?bGVzdlA1OFRxZnFYc1VpRU95VVhMalkyM0lDcnFVaEhvYXdTQWF6bjJxREs1?=
 =?utf-8?B?N2k1MU5WWW05MUZ0ckRObDYyQTNPNGhnVUJKVVRHeWQvZmdIUjNjN3c2RVFD?=
 =?utf-8?B?MWcyOHhEMTRyOE9xNUIvNEYzUzJUWWZiMHdocEJzK0JBRmI1dW5ZNWRDS1M1?=
 =?utf-8?B?NDhyY0hqWnhROHhtV1Ivbzd1SExua3pMWFZOQ2I4eVYyUDV0NGUzZVFPeXYx?=
 =?utf-8?B?eDNpV28vbURNZm9DdWt5RlNtVEdMUEZReGs3dUVoNDZHNEd6T1hHQUp3eklU?=
 =?utf-8?B?cEkzMkJJUENqYTB3Q2xOREFRcU0yRmdjampZeDlQZWdmOVQwZmVRNEJHbmEy?=
 =?utf-8?B?NEt1dkpvWEFVSE9DOXFkUmpFbGFuMkhOaWhabCtub2lWWnhDWUp6ZUtGTGFh?=
 =?utf-8?B?aGY3SVU5ZkVOeUo3V0JiTzYxTjhSU0M4cUVxZnhuNTZIMXA3WmVVaVV3RFdm?=
 =?utf-8?B?N2hnQTE3bnc3ZTJ0QjZkVG9CcG5rTm0zL0o4Y09Zc3pjK3RsYjY3NUk4ODNW?=
 =?utf-8?B?ZUJJTVlHRHYwNlptZ1lkYXFvNzBtMWRhK1FKQlphVDJjUVpvTlViK25qWldv?=
 =?utf-8?B?TXZpVVN1M0xwQkVGRkY3WjZSVlBHR0Z5OC9ZTDdFLzN5ZHlFUk5jZFp6NlRP?=
 =?utf-8?B?a25TR0FmcERMMlFmQ2U5QnFXTmIxZTlrTmFpZ1Zsayt5NnFwNzVCZTc4eU0v?=
 =?utf-8?B?emxxWnVKMEk1RHI1UjEyUTk1MUZXNUlUUEI0L09YKys0d0dHNXkwSTcrWXlq?=
 =?utf-8?B?djJvZlFkaUJVaXRYZFFsWmhsK3VwV1JFZlZKNlpOanpFME1xSmpqNHdYUURX?=
 =?utf-8?B?U2JkbXlIbkpUMDYxN2EvVm9IY1ZoN1pQOGEyY1QyUjdGaGZUZ3hLN2d3Uk1X?=
 =?utf-8?B?NlVhRlYrRTRpMXdJRTRFSFpXSmdFYTlTVUV4cHBmY3VRdXpPK3FiNzBXNXBa?=
 =?utf-8?B?dngyY3R2U1VuWnd2by9zaHNSOEdZcDhlNmpBdTQvRFgrYnJtUVgySmQyM09t?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DBBA64B0FED034D92D7B920DFDB163F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b675a1f-23e5-4c8c-f64d-08dadaf9086b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 21:53:54.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKGYhc2Prw1MCN9NELBVtEMNk+0kH/qmF7IoPDhNKrsJLwiZNRxzkRpL8QmhqlXDfH8I5Z001MPpTiHUnT/Khg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=908
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212100202
X-Proofpoint-GUID: q6cnWLyQgM0hzRdX0iY-31YFJPVXoYdj
X-Proofpoint-ORIG-GUID: q6cnWLyQgM0hzRdX0iY-31YFJPVXoYdj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gRGVjIDEwLCAyMDIyLCBhdCA0OjUyIFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgPHJp
Y2hhcmRAbm9kLmF0PiB3cm90ZToNCj4gDQo+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0t
LS0NCj4+IFZvbjogImNodWNrIGxldmVyIiA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+PiBS
aWNoYXJkIFdlaW5iZXJnZXIgKDMpOg0KPj4+IE5GU0Q6IFRlYWNoIG5mc2RfbW91bnRwb2ludCgp
IGF1dG8gbW91bnRzDQo+Pj4gZnM6IG5hbWVpOiBBbGxvdyBmb2xsb3dfZG93bigpIHRvIHVuY292
ZXIgYXV0byBtb3VudHMNCj4+PiBORlM6IG5mc19lbmNvZGVfZmg6IFJlbW92ZSBTX0FVVE9NT1VO
VCBjaGVjaw0KPj4+IA0KPj4+IGZzL25hbWVpLmMgICAgICAgICAgICB8IDYgKysrLS0tDQo+Pj4g
ZnMvbmZzL2V4cG9ydC5jICAgICAgIHwgMiArLQ0KPj4+IGZzL25mc2QvdmZzLmMgICAgICAgICB8
IDggKysrKysrLS0NCj4+PiBpbmNsdWRlL2xpbnV4L25hbWVpLmggfCAyICstDQo+Pj4gNCBmaWxl
cyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IC0t
DQo+Pj4gMi4yNi4yDQo+Pj4gDQo+PiANCj4+IFRoaXMgc2VyaWVzIGlzIGEgYml0IGxhdGUgZm9y
IGluY2x1c2lvbiBpbiB2Ni4yLiBUaGUgbmV4dCBvcHBvcnR1bml0eQ0KPj4gd2lsbCBiZSB2Ni4z
IGluIGEgY291cGxlIG9mIG1vbnRocy4gSSBwcmVmZXIgdG8gaGF2ZSBhICJmaW5hbCIgdmVyc2lv
bg0KPj4gb2YgcGF0Y2hlcyBieSAtcmM1Lg0KPj4gDQo+PiBJJ20gd2FpdGluZyBmb3IgcmV2aWV3
IGNvbW1lbnRzIG9uIHYyIG9mIHRoaXMgc2VyaWVzLg0KPiANCj4gT2shIERvIHlvdSB3YW50IG1l
IHRvIHJlc2VuZCB0aGUgc2VyaWVzIGluIGFueSBjYXNlIGJ5IHY2LjItcmM1IG9yIG9ubHkNCj4g
aWYgbmV3IGNvbW1lbnRzIGFyaXNlPw0KDQpJZiB2MiBnYXJuZXJzIG5vIG5ldyBjb21tZW50cywg
dGhlbiBzZW5kIGEgcmVtaW5kZXIgd2l0aCBhIFVSTCB0byB0aGlzDQp0aHJlYWQgb24gbG9yZS5r
ZXJuZWwub3JnLiBJIHdpbGwgcHVsbCB0aGUgc2VyaWVzIGZyb20gdGhlcmUuDQoNCg0KLS0NCkNo
dWNrIExldmVyDQoNCg0KDQo=
