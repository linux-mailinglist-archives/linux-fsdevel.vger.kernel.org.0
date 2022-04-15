Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB839502DA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 18:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355789AbiDOQWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiDOQWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:22:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B7E090;
        Fri, 15 Apr 2022 09:19:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FFepTm012649;
        Fri, 15 Apr 2022 16:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0tk0czkvJUVeOs66Tgk7QHaXiKOCtCliypxkZKBYUUQ=;
 b=NW5LYxUsHC+Oi6IdL8PIuQWiOCX0We+xTPY5LR6uH21kiSsJAqI5Qj8WqTRHGzqCflXt
 ose3HgpQRBf+0s18FyslaKV72KED94dlDCcU6Hww5s2puDs3J6Wt/mJkHgtddYe8Bqbe
 tM0nZf0hYrVO4K+R3V0b9y3q8Y0jsNYvKuNl1g6TEgQwJWhTI6KI9xhxoiAJKuydm2SS
 clDQq6l125NdW7Bto62twNEAlwxFSIA80bRL2QivSMsdP4HYKTCSqNNelBDHTSfTZKVF
 cZ69840IvXeUvH50Y1FPK15GuBjCZlTnbY6g5VCdbzFAPmXV3XtgYpbvGzPAnAng1QYF 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu7r3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 16:19:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FGFqPU003939;
        Fri, 15 Apr 2022 16:19:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k62uk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 16:19:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoHmF9OrP0A7uH9TOPoTyB68zA9Ch3Sg3HipJVgDnkCKJWeTLLBMRLNTx50yutST6FqyofIEBc8zw1aUzppzMOyK60c2aVoB7ASs18t5bIDgXxQfBGLXpv4mBDoNlLWHV7jL3CiktqxiKxlAor3YUWwGxuUvkAh839ABcxTvytowFkl09xPSVRjTB8dM5xPxwewjKXRrxM8Y4PIJmGEf4JecSv91wSI5MMqBk3NuvBmiCn1Z7QW6Cx5bHQtuwZd2XQGZyNMyZw7WMTzodmArMoMenbytzIKlQ/yB8f8D+Bqp3LD+mNEpNY1TG3Vgjt0cUpAWuGJdfaU0pfPR+gCI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tk0czkvJUVeOs66Tgk7QHaXiKOCtCliypxkZKBYUUQ=;
 b=c8hrQPVkAE39Wr42UXsLc6DVAzS0KJnnjOf0NTSna2wzGqjnktq/br4CTGY2uu/FAPkgCsvS7AqWoENpVqq3XR/Mre2dKR6vXdrc1s0ylges+N5XKfWq17l2eVq2hTgDvcvpDSgpImJ8TgQWcKdaab6ZNWGICZD8xvvdqZ0tTGnWjXHb6Lq5vpBQ65Zc33byXODAFoPajx0SThZB7010riKahe1ILFf+iFbQP/Vfi5P4H6gUYPGRxFrD5fdOcMKbnLPKOdQRs6XmW7CK6jIDz+A+ieRkIWxBHfeAMu5/JYPzPLy2BpmvkzUzBlnkjYps8CEMhdzyb+t7+GXSNViWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tk0czkvJUVeOs66Tgk7QHaXiKOCtCliypxkZKBYUUQ=;
 b=ez9UCJFxICrKwnRaM5emOD0/ahz3VsTQ5JK67Foizrwwqwv4w9YtjBoy6SYHfSobnn+PJZajudsMSKS3Db6lwFSk6Cw1Dv9awv55vxX1zQsY7XadQe4vKXzcItSEXdDySsqVsGPEgG3Ld511mpBN36NmT83lyiUo1DnnmZVDpi0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB3978.namprd10.prod.outlook.com (2603:10b6:5:1fa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 16:18:57 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 16:18:57 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [PATCH v7 3/6] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Topic: [PATCH v7 3/6] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Index: AQHYSSYcmxaMmXFgxUqypAmHkAJB9qzrZR4AgAMnHoCAADFSgIACeSgA
Date:   Fri, 15 Apr 2022 16:18:57 +0000
Message-ID: <b3f0bfcd-9e7c-cc71-e91d-d0f28053dea9@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-4-jane.chu@oracle.com>
 <CAPcyv4jx=h+1QiB0NRRQrh1mHcD2TFQx4AH6JxnQDKukZ3KVZA@mail.gmail.com>
 <b511a483-4260-656a-ab04-2ba319e65ca7@oracle.com>
 <CAPcyv4jpwzMPKtzzc=DEbC340+zmzXkj+QtPVxfYbraskLKv8g@mail.gmail.com>
In-Reply-To: <CAPcyv4jpwzMPKtzzc=DEbC340+zmzXkj+QtPVxfYbraskLKv8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37b33543-6d89-4516-675a-08da1efba4a0
x-ms-traffictypediagnostic: DM6PR10MB3978:EE_
x-microsoft-antispam-prvs: <DM6PR10MB39787C42692967FE149DAA0AF3EE9@DM6PR10MB3978.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1+0xrki9fEjsd4NtzS2bnD4PWNgZ+vyztShShChTON9DKREm4T2snnjb0GY4CukzMfgGYvyrzl9TTWAmieCIaBo5cvz58TRELJZ4f+pQKybzgYLvj0z380rN4mvUcIeYcB2s5opx6bLSERml/SZeiIQPvce/xLRMiLb1rrQrb+aRnh3cHvGnGysLiLJwOb3bFnx5hSaYGMZbatXsXMWLobCvnIsXdLZS096zwk7fOtaFW4aTfA1zfIXyYLyDA8/58fOoJ7Csov3PxJg20kUmXDjEC3SbwgUhD8E4ZGNPDZgw8a5mMl9e0hysEkPOLPzAaOACNi4McGjf/21ZAA7VEST/0DaXK5r88T9vkUGn/tH88YNrS4pMd0iFR5Uh05WD3Ie4PI0+SyJ8knxVGhKWYNsk+lXvKiVO7/mCG/N5mhuuS8jhuy/u7aiCln8Js2PtXEBq1TLiduunmUCwsDTfircZI5POxNYWuZpp+GBj+VOZ1Vi4ieKHF6sysNwXFMUVJCYa4G5vtqiiL8JOuDI8Bxe2bW+uwg7fNLwrmalGWsuUlOlpyIUL4xMoVfJeVYqls3AMv17d5HSWCUm8Fg27j/CugaBhAyRiyw1lOAKOSf86k80fLQSljljfLnkUho9FgpVBc8hublhIrEyYgD0Br2F/SYtJVaiaSHL/Vxw6BJe+2cSDpy8iFI2ophfBzQ0c9mqqkVqJm4EvtddtCVzQHxHWBXxSis3t/YicMab7VwmwAsg/ONDEIdtmf14dFnKB8uTh/eAOUvTQSdQzG3Y/qdK9Y9CoQz1C19k9SqshxY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(64756008)(66946007)(6486002)(66556008)(4326008)(66446008)(83380400001)(76116006)(2906002)(8936002)(7416002)(44832011)(5660300002)(36756003)(54906003)(86362001)(6916009)(316002)(2616005)(6506007)(508600001)(53546011)(6512007)(26005)(186003)(31696002)(122000001)(38100700002)(71200400001)(31686004)(38070700005)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU1MZkx5alVCN1NMdkFJNk9iTGdUT1pGZnlvYXhPSi9QMk4vc1B5bW5jRUFk?=
 =?utf-8?B?TTRWNXBGWFNOajNQRjFqQVVqZTl1bHdVd2NScWRtendJNU1ORmwvTDR1S29h?=
 =?utf-8?B?TDExbU9mTHJ2NDJBelhqUHZSMHJEaVFBbkVnbjhxazNNNldnQlFJZVRFZTRi?=
 =?utf-8?B?Y1p0aGNDRUJDQkNYelNHcXdkekE2R3NOVmRJWDlJQVdKZ3cwT1dmNlVsLzlU?=
 =?utf-8?B?c2xjbit5NUNYQ05tbWRLa2o5aXB3Ry96alBmVHQydlF4bTN0Yk9Hd0ZobUhq?=
 =?utf-8?B?Rk9JR1dtd3o2djlqTENzdkUzdWc0dTN0cXhHSHd6Q3RESkp1OVJ1ZFQybnZm?=
 =?utf-8?B?a3JWcHFFYkJhSEFxMWhTcWFsd2tHQkZTaWMzUGFXVTVRTTdKYnhKbGdqYkh3?=
 =?utf-8?B?bFJsTGQ2M1pwL0NtelFVYy8rSlBZSm85a3ArNkJrNFgwZWFiSHI3cFRRNHUz?=
 =?utf-8?B?NEhYNTRUR2NadWFQVFhkWHdwOUpHSEdvYkt5WTZFRUZITzdJKzZINEI4dEUx?=
 =?utf-8?B?T3c4THE5V283K045ZnBHRk5jSTFUbFNuTEpmd0JNV0FyMFJ4bHBJSm5YTGl1?=
 =?utf-8?B?MGJJMWFuVjhZTk9GZUU2S0tqd1h0OEJvYVhvOUpGL2pkZ044MjBRNTBwdVY4?=
 =?utf-8?B?U2t4NjRyeTNqTmJFYWFEc0JDUU56Z0VOcjZReitwREZNeWhRYm0zSGJZVC9s?=
 =?utf-8?B?ZEl2R01ZbmEwdDcvekRPZ0kxbVE1WDM5SXhUeU5wQ3QrT1pVbTVjSTBsUmI5?=
 =?utf-8?B?M05uSVNjY3FCcnBKbTQ0ZTNlMVNITDdMa0V4SytUVVYwdk5QaDBYUFFodDUv?=
 =?utf-8?B?N2V5TkxYQmFmUytLS2ZBKzFRblpqWG92SGl6UXoxOTBiU2FrNmYyQzJCckto?=
 =?utf-8?B?S0J5WVJQOVV1a0duZnlvSEdrTkdsUEVUUnd1NG55WjlHem0zQ044emlYZlVL?=
 =?utf-8?B?MG5ZQXhqaHhZYzU3TXJ2cUhLVmxZaE5KaVRrMG1IcXEyZVExcXlGclRvRElY?=
 =?utf-8?B?TFJpOUduRkNJNEFJbldYbVNickx4bVNaRStpRHBSSm4wYnI2STZrdjVaZW9T?=
 =?utf-8?B?YlBZNDEyNWZJVG9QTklPb3ZmbW82clpQektQdTFDZnM2M0lhQy9tL1ZMVlZG?=
 =?utf-8?B?OElhUG1nTWNqOTc1b25aeHorcHBXNFp6djRRYzVLcTdzV2xMS2JuQ0RZQ3Vr?=
 =?utf-8?B?bXRhZkhaZmpmQWQ0TVB2WXJYeFZXTEFuQXpoMk5BYjdmT0dqNFdJRUc4VUNS?=
 =?utf-8?B?NUVjenhzRU1jTGlzQ09kMituUHB2MEVkY3FyTVo4ZEIzT3UweHJMeG1sRG5G?=
 =?utf-8?B?SmQ0WDJuNnRIK3dpajY2S1lHNWJQbnlvM2hMNnYzNjdlU1dEN1Z6NUpxZk56?=
 =?utf-8?B?Lzh0QmVUdkhIZytDVlByTGJmQzRmTjJYbEwvTDVvSGFibUFyMXBoZFdVT3pa?=
 =?utf-8?B?dUcxcTROYWdSRTgxbW1jSk4zWXFrNVZtdm52TXlOd3dHNVY4K25hTHdsSHY2?=
 =?utf-8?B?ZFF1VWphODJuUDczUDhCYnBRUzRIdXBIYk5wSVYxWHNWMjdTdUZEN1ROOW1t?=
 =?utf-8?B?aXZSNXRreUVHajhOM2YxVE9tdW1FdVlnVmJKZTBaVVYzRkJNUTl5bXZBQ25y?=
 =?utf-8?B?WkpUalVGUzdJWHJLWEdZamc4eks1OFZlNGYzVGkwMnI3TmwyR3d5am15TGRS?=
 =?utf-8?B?dlJ1cTFKeG5ySW1IaXBob3FKZzRlalIwSjg1eU9uRHJ4bFVGeGVQOWhNajQr?=
 =?utf-8?B?NHpjbTk3UEdMb2h6M3R0aFhqeTB6OGszNGthRTh3NzFqVmlnanoydlI0b2wr?=
 =?utf-8?B?T3lZVWM0SFg5OXV1YzU1dWtqN1BTWCttUm9JcytGQTdjb1IxWlJ0eXdlREtq?=
 =?utf-8?B?bGxoOXpyMHYyblFzbGNHZEJRQjhzRVBaVGFYSTdPalA4dElQNFZqN3hmOE1h?=
 =?utf-8?B?clpXbXBZV2pUeVlTRDY2S09FZVpjTy9sUUQ3cllFTGxwVUpCU2daeDBKN0xE?=
 =?utf-8?B?VUp4UkhoZ1BiRFBjbUN0aC96bnN4UmUxeEtkUzRmbmVpNXhUUXFUR2dJU3NO?=
 =?utf-8?B?QmNSN0pQSkEvaUhMbzk3dTd4Y3p3c0RNbXdpODZMeEIzNGxpbkhLOXFOeUhB?=
 =?utf-8?B?bEFMeHh1aDZNd3FOY3Q5TUtQeHhzUk1teUR1YXB5dWpEdU5idDB0UWxYOFMr?=
 =?utf-8?B?WEY2MVNwZWNsUFVSRVMzVmRhOWR2NXQxMzI0WEtqREhhOC9iRmxlUllOamRo?=
 =?utf-8?B?UkZ6MVBBdHZ3a0NLR3ZpSlpDWDVRUUVFNjRxRy83Q1JZUWZxRlF1T05oK0tS?=
 =?utf-8?Q?ajpTM3Tw7SR13rhQfP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <271F86A4BEF6A145A1503974C9B11412@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b33543-6d89-4516-675a-08da1efba4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 16:18:57.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eYH7GuBPoWJuR7dSdPGD1hQeABO6tL4RBGOyBdxHPAwU5o2yIWoSpSFj3nNEfBcOl0yPJUsZcXcS3hMgtjUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3978
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150093
X-Proofpoint-ORIG-GUID: fM0BYJool8UnlPbd1opG_axTbXY17yTk
X-Proofpoint-GUID: fM0BYJool8UnlPbd1opG_axTbXY17yTk
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMy8yMDIyIDc6MzIgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gV2VkLCBBcHIg
MTMsIDIwMjIgYXQgNDozNiBQTSBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gT24gNC8xMS8yMDIyIDQ6MjcgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4+PiBP
biBUdWUsIEFwciA1LCAyMDIyIGF0IDEyOjQ4IFBNIEphbmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUu
Y29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gVGhlIHNldF9tZW1vcnlfdWMoKSBhcHByb2FjaCBkb2Vz
bid0IHdvcmsgd2VsbCBpbiBhbGwgY2FzZXMuDQo+Pj4+IEZvciBleGFtcGxlLCB3aGVuICJUaGUg
Vk1NIHVubWFwcGVkIHRoZSBiYWQgcGFnZSBmcm9tIGd1ZXN0DQo+Pj4+IHBoeXNpY2FsIHNwYWNl
IGFuZCBwYXNzZWQgdGhlIG1hY2hpbmUgY2hlY2sgdG8gdGhlIGd1ZXN0LiINCj4+Pj4gIlRoZSBn
dWVzdCBnZXRzIHZpcnR1YWwgI01DIG9uIGFuIGFjY2VzcyB0byB0aGF0IHBhZ2UuDQo+Pj4+ICAg
IFdoZW4gdGhlIGd1ZXN0IHRyaWVzIHRvIGRvIHNldF9tZW1vcnlfdWMoKSBhbmQgaW5zdHJ1Y3Rz
DQo+Pj4+ICAgIGNwYV9mbHVzaCgpIHRvIGRvIGNsZWFuIGNhY2hlcyB0aGF0IHJlc3VsdHMgaW4g
dGFraW5nIGFub3RoZXINCj4+Pj4gICAgZmF1bHQgLyBleGNlcHRpb24gcGVyaGFwcyBiZWNhdXNl
IHRoZSBWTU0gdW5tYXBwZWQgdGhlIHBhZ2UNCj4+Pj4gICAgZnJvbSB0aGUgZ3Vlc3QuIg0KPj4+
Pg0KPj4+PiBTaW5jZSB0aGUgZHJpdmVyIGhhcyBzcGVjaWFsIGtub3dsZWRnZSB0byBoYW5kbGUg
TlAgb3IgVUMsDQo+Pj4NCj4+PiBJIHRoaW5rIGEgcGF0Y2ggaXMgbmVlZGVkIGJlZm9yZSB0aGlz
IG9uZSB0byBtYWtlIHRoaXMgc3RhdGVtZW50IHRydWU/IEkuZS46DQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hY3BpL25maXQvbWNlLmMgYi9kcml2ZXJzL2FjcGkvbmZpdC9tY2UuYw0K
Pj4+IGluZGV4IGVlOGQ5OTczZjYwYi4uMTE2NDFmNTUwMjVhIDEwMDY0NA0KPj4+IC0tLSBhL2Ry
aXZlcnMvYWNwaS9uZml0L21jZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9hY3BpL25maXQvbWNlLmMN
Cj4+PiBAQCAtMzIsNiArMzIsNyBAQCBzdGF0aWMgaW50IG5maXRfaGFuZGxlX21jZShzdHJ1Y3Qg
bm90aWZpZXJfYmxvY2sNCj4+PiAqbmIsIHVuc2lnbmVkIGxvbmcgdmFsLA0KPj4+ICAgICAgICAg
ICAgKi8NCj4+PiAgICAgICAgICAgbXV0ZXhfbG9jaygmYWNwaV9kZXNjX2xvY2spOw0KPj4+ICAg
ICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGFjcGlfZGVzYywgJmFjcGlfZGVzY3MsIGxpc3Qp
IHsNCj4+PiArICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGFsaWduID0gMVVMIDw8IE1DSV9N
SVNDX0FERFJfTFNCKG1jZS0+bWlzYyk7DQo+Pj4gICAgICAgICAgICAgICAgICAgc3RydWN0IGRl
dmljZSAqZGV2ID0gYWNwaV9kZXNjLT5kZXY7DQo+Pj4gICAgICAgICAgICAgICAgICAgaW50IGZv
dW5kX21hdGNoID0gMDsNCj4+Pg0KPj4+IEBAIC02Myw4ICs2NCw3IEBAIHN0YXRpYyBpbnQgbmZp
dF9oYW5kbGVfbWNlKHN0cnVjdCBub3RpZmllcl9ibG9jaw0KPj4+ICpuYiwgdW5zaWduZWQgbG9u
ZyB2YWwsDQo+Pj4NCj4+PiAgICAgICAgICAgICAgICAgICAvKiBJZiB0aGlzIGZhaWxzIGR1ZSB0
byBhbiAtRU5PTUVNLCB0aGVyZSBpcyBsaXR0bGUgd2UgY2FuIGRvICovDQo+Pj4gICAgICAgICAg
ICAgICAgICAgbnZkaW1tX2J1c19hZGRfYmFkcmFuZ2UoYWNwaV9kZXNjLT5udmRpbW1fYnVzLA0K
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQUxJR04obWNlLT5hZGRyLCBMMV9D
QUNIRV9CWVRFUyksDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBMMV9DQUNI
RV9CWVRFUyk7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFM
SUdOKG1jZS0+YWRkciwgYWxpZ24pLCBhbGlnbik7DQo+Pj4gICAgICAgICAgICAgICAgICAgbnZk
aW1tX3JlZ2lvbl9ub3RpZnkobmZpdF9zcGEtPm5kX3JlZ2lvbiwNCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTlZESU1NX1JFVkFMSURBVEVfUE9JU09OKTsNCj4+Pg0KPj4N
Cj4+IERhbiwgSSB0cmllZCB0aGUgYWJvdmUgY2hhbmdlLCBhbmQgdGhpcyBpcyB3aGF0IEkgZ290
IGFmdGVyIGluamVjdGluZyA4DQo+PiBiYWNrLXRvLWJhY2sgcG9pc29ucywgdGhlbiByZWFkIHRo
ZW0gYW5kIHJlY2VpdmVkICBTSUdCVVMvQlVTX01DRUVSUl9BUiwNCj4+IHRoZW4gcmVwYWlyIHZp
YSB0aGUgdjcgcGF0Y2ggd2hpY2ggd29ya3MgdW50aWwgdGhpcyBjaGFuZ2UgaXMgYWRkZWQuDQo+
Pg0KPj4gWyA2MjQwLjk1NTMzMV0gbmZpdCBBQ1BJMDAxMjowMDogWFhYLCBhbGlnbiA9IDEwMA0K
Pj4gWyA2MjQwLjk2MDMwMF0gbmZpdCBBQ1BJMDAxMjowMDogWFhYLCBBTElHTihtY2UtPmFkZHIs
DQo+PiBMMV9DQUNIRV9CWVRFUyk9MTg1MTYwMDQwMCwgTDFfQ0FDSEVfQllURVM9NDAsIEFMSUdO
KG1jZS0+YWRkciwNCj4+IGFsaWduKT0xODUxNjAwNDAwDQo+PiBbLi5dDQo+PiBbIDYyNDIuMDUy
Mjc3XSBuZml0IEFDUEkwMDEyOjAwOiBYWFgsIGFsaWduID0gMTAwDQo+PiBbIDYyNDIuMDU3MjQz
XSBuZml0IEFDUEkwMDEyOjAwOiBYWFgsIEFMSUdOKG1jZS0+YWRkciwNCj4+IEwxX0NBQ0hFX0JZ
VEVTKT0xODUxNjAxMDAwLCBMMV9DQUNIRV9CWVRFUz00MCwgQUxJR04obWNlLT5hZGRyLA0KPj4g
YWxpZ24pPTE4NTE2MDEwMDANCj4+IFsuLl0NCj4+IFsgNjI0NC45MTcxOThdIG5maXQgQUNQSTAw
MTI6MDA6IFhYWCwgYWxpZ24gPSAxMDAwDQo+PiBbIDYyNDQuOTIyMjU4XSBuZml0IEFDUEkwMDEy
OjAwOiBYWFgsIEFMSUdOKG1jZS0+YWRkciwNCj4+IEwxX0NBQ0hFX0JZVEVTKT0xODUxNjAxMjAw
LCBMMV9DQUNIRV9CWVRFUz00MCwgQUxJR04obWNlLT5hZGRyLA0KPj4gYWxpZ24pPTE4NTE2MDIw
MDANCj4+IFsuLl0NCj4+DQo+PiBBbGwgOCBwb2lzb25zIHJlbWFpbiB1bmNsZWFyZWQuDQo+Pg0K
Pj4gV2l0aG91dCBmdXJ0aGVyIGludmVzdGlnYXRpb24sIEkgZG9uJ3Qga25vdyB3aHkgdGhlIGZh
aWx1cmUuDQo+PiBDb3VsZCB3ZSBtYXJrIHRoaXMgY2hhbmdlIHRvIGEgZm9sbG93LW9uIHRhc2s/
DQo+IA0KPiBQZXJoYXBzIGEgYml0IG1vcmUgZGVidWcgYmVmb3JlIGtpY2tpbmcgdGhpcyBjYW4g
ZG93biB0aGUgcm9hZC4uLg0KPiANCj4gSSdtIHdvcnJpZWQgdGhhdCB0aGlzIG1lYW5zIHRoYXQg
dGhlIGRyaXZlciBpcyBub3QgYWNjdXJhdGVseSB0cmFja2luZw0KPiBwb2lzb24gZGF0YSBGb3Ig
ZXhhbXBsZSwgdGhhdCBsYXN0IGNhc2UgdGhlIGhhcmR3YXJlIGlzIGluZGljYXRpbmcgYQ0KPiBm
dWxsIHBhZ2UgY2xvYmJlciwgYnV0IHRoZSBvbGQgY29kZSB3b3VsZCBvbmx5IHRyYWNrIHBvaXNv
biBmcm9tDQo+IDE4NTE2MDEyMDAgdG8gMTg1MTYwMTQwMCAoaS5lLiB0aGUgZmlyc3QgNTEyIGJ5
dGVzIGZyb20gdGhlIGJhc2UgZXJyb3INCj4gYWRkcmVzcykuDQoNCkkgd291bGQgYXBwZWFyIHNv
LCBidXQgdGhlIG9sZCBjb2RlIHRyYWNraW5nIHNlZW1zIHRvIGJlIHdvcmtpbmcgDQpjb3JyZWN0
bHkuIEZvciBleGFtcGxlLCBpbmplY3RpbmcgOCBiYWNrLXRvLWJhY2sgcG9pc29uLCB0aGUNCi9z
eXMvZGV2aWNlcy9MTlhTWVNUTTowMC9MTlhTWUJVUzowMC9BQ1BJMDAxMjowMC9uZGJ1czAvcmVn
aW9uMC9iYWRibG9ja3MNCmNwYXR1cmVzIGFsbCA4IG9mIHRoZW0sIHRoYXQgc3BhbnMgMksgcmFu
Z2UsIHJpZ2h0PyAgSSBuZXZlciBoYWQgaXNzdWUgDQphYm91dCBtaXNzaW5nIHBvaXNvbiBpbiBt
eSB0ZXN0cy4NCg0KPiANCj4gT2guLi4gd2FpdCwgSSB0aGluayB0aGVyZSBpcyBhIHNlY29uZCBi
dWcgaGVyZSwgdGhhdCBBTElHTiBzaG91bGQgYmUNCj4gQUxJR05fRE9XTigpLiBEb2VzIHRoaXMg
cmVzdG9yZSB0aGUgcmVzdWx0IHlvdSBleHBlY3Q/DQoNClRoYXQncyBpdCwgQUxJR05fRE9XTiBm
aXhlZCB0aGUgaXNzdWUsIHRoYW5rcyEhDQpJJ2xsIGFkZCBhIHBhdGNoLCBzdWdnZXN0ZWQtYnkg
eW91Lg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL25maXQvbWNlLmMgYi9kcml2
ZXJzL2FjcGkvbmZpdC9tY2UuYw0KPiBpbmRleCBlZThkOTk3M2Y2MGIuLmQ3YTUyMjM4YTc0MSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hY3BpL25maXQvbWNlLmMNCj4gKysrIGIvZHJpdmVycy9h
Y3BpL25maXQvbWNlLmMNCj4gQEAgLTYzLDggKzYzLDcgQEAgc3RhdGljIGludCBuZml0X2hhbmRs
ZV9tY2Uoc3RydWN0IG5vdGlmaWVyX2Jsb2NrDQo+ICpuYiwgdW5zaWduZWQgbG9uZyB2YWwsDQo+
IA0KPiAgICAgICAgICAgICAgICAgIC8qIElmIHRoaXMgZmFpbHMgZHVlIHRvIGFuIC1FTk9NRU0s
IHRoZXJlIGlzIGxpdHRsZSB3ZSBjYW4gZG8gKi8NCj4gICAgICAgICAgICAgICAgICBudmRpbW1f
YnVzX2FkZF9iYWRyYW5nZShhY3BpX2Rlc2MtPm52ZGltbV9idXMsDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQUxJR04obWNlLT5hZGRyLCBMMV9DQUNIRV9CWVRFUyksDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTDFfQ0FDSEVfQllURVMpOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQUxJR05fRE9XTihtY2UtPmFkZHIsIGFs
aWduKSwgYWxpZ24pOw0KPiAgICAgICAgICAgICAgICAgIG52ZGltbV9yZWdpb25fbm90aWZ5KG5m
aXRfc3BhLT5uZF9yZWdpb24sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5W
RElNTV9SRVZBTElEQVRFX1BPSVNPTik7DQo+IA0KPiANCj4+IFRoZSBkcml2ZXIga25vd3MgYSBs
b3QgYWJvdXQgaG93IHRvIGNsZWFyIHBvaXNvbnMgYmVzaWRlcyBoYXJkY29kaW5nDQo+PiBwb2lz
b24gYWxpZ25tZW50IHRvIDB4NDAgYnl0ZXMuDQo+IA0KPiBJdCBkb2VzLCBidXQgdGhlIGJhZGJs
b2NrcyB0cmFja2luZyBzaG91bGQgc3RpbGwgYmUgcmVsaWFibGUsIGFuZCBpZg0KPiBpdCdzIG5v
dCByZWxpYWJsZSBJIGV4cGVjdCB0aGVyZSBhcmUgY2FzZXMgd2hlcmUgcmVjb3Zlcnlfd3JpdGUo
KSB3aWxsDQo+IG5vdCBiZSB0cmlnZ2VyZWQgYmVjYXVzZSB0aGUgZHJpdmVyIHdpbGwgbm90IGZh
aWwgdGhlDQo+IGRheF9kaXJlY3RfYWNjZXNzKCkgYXR0ZW1wdC4NCg0KdGhhbmtzIQ0KLWphbmUN
Cg0K
