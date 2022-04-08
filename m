Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512984F9DCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiDHTyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 15:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiDHTyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:54:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB221605C3;
        Fri,  8 Apr 2022 12:52:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238HppOa006371;
        Fri, 8 Apr 2022 19:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gd/CJTMRs0W+Jj8oypFBsr2wxCM7EulqqxQfu2zlnmg=;
 b=X2cGZSSNfDgbSE4c0vz8yQheRMOCkcuztB6kBDtH0bkT7Eflma3BPbaaoj68vSrkQQJE
 iNw/M20+dyjYaEK/UMqJR/eEx+7MNqQNyJQyb3RJdZwWqwcKUm0eZiT6Sg3gljHiT4kF
 DQVxvuxqzvep+07ku01alpq9xD3GBDuYwj6M1c9oBI8Uogeqhq6jCgE6b/MAQpWsq7dN
 l0sYBzPsDqPBQvCEpZJh6w6dziwICojc5GE5DK9d8tXKMvSSgRpL8hlS/8b5NZ6aTg7u
 X+zy4tsMCXAOd2gX4nk/xJduvvKr4b5cHIGxGqtO9ltplindDgGrBvegqu6SGDh5fnmG cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31r76k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 19:52:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238Jotev022495;
        Fri, 8 Apr 2022 19:52:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y98uec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 19:52:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoAGfc6hoSFRQ5Ce6iwknwtVf6toXY9csWCv7gk4COcUqjQrZq9QrzvQt6nL2jf6fb/K+SbeSoCUaksulQjaCboq+OivLSWY+XRZLioDLe3eOnyQFpk1K47JvUdyeEPth2gc43DzoZHvePaD5ecS+BlwkLQHj5dTcv4Xks3Vquf7pikedFk73nU3Iv2VDRhVqq0KM9KSHlrokm64KrI1SNvbYOKVGLSK0Ck6g34RbJnAPKFtn4nY/hyoCWi34o/e4alMlMgud24n6W2EUGH5IWEvy4sWhs+7sHVCo8NJe2r1B4ZZyRv85Ng+f2PtZ67Or+/KCiKS+bjNWsaCJ8gGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd/CJTMRs0W+Jj8oypFBsr2wxCM7EulqqxQfu2zlnmg=;
 b=jgAbED4TR8zwLYjBsnM5Qzkqg6Co3CNNR0I8MGY7GoYiUX8iT2GquyShKaPCgLKQo4y4MybjeKVK+RbRy+CaMeNdJdHqpxAH6LTMBVmwZG+KA17hTcEAeziEjf3wxC3d9/WPK0RE3/gim6hozl3nTk2BeoFxrbV1ekqVlwrjkFENVNTPn94YUDnCzkB4eubpIhdOL2mIs4eRJ110yyznggYhDiUm6XiK2aY0+n6z2gXkZmPIyZozsGte6G3DfAZNkL1QaA252xmIH0Sj1NjiaxL3ZXIQQ7pkp7hnO6lSKSb3aaAaeZsemqf7D/09Sw7wc8eycOvlbKqV8RyG3+YW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd/CJTMRs0W+Jj8oypFBsr2wxCM7EulqqxQfu2zlnmg=;
 b=MmcPNnfFKnGgjgWjOPia7EwRmNN/BqWsD88iCIlGgTXMQvJY5gqUgausqqdmUpddu1stL/TlUMW70xk/qUNS78Pr31F5yVCskBNCCn66lF8e9LCh4ji8XkbrOb54c+DMK1pm45R+HGqFjJbeeyECf1k9X2Rx5t4Vt+5VQ9X2lpg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2877.namprd10.prod.outlook.com (2603:10b6:805:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 19:52:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 19:52:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
Thread-Topic: Regression in xfstests on tmpfs-backed NFS exports
Thread-Index: AQHYSdpNL2d3Xru4B0OzHZJ1LCngEazjlm2AgAE//ICAADMPAIABKSsAgAAyAwCAAAv0gA==
Date:   Fri, 8 Apr 2022 19:52:20 +0000
Message-ID: <E99BC043-47BE-49FF-A882-0CF1820B500B@oracle.com>
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com>
 <11f319-c9a-4648-bfbb-dc5a83c774@google.com>
 <2B7AF707-67B1-4ED8-A29F-957C26B7F87A@oracle.com>
 <c5ea49a-1a76-8cf9-5c76-4bb31aa3d458@google.com>
 <C7966059-D583-4B20-A838-067BAE86FB3E@oracle.com>
 <8058d02d-d8b2-4d7a-a535-a78719e996@google.com>
In-Reply-To: <8058d02d-d8b2-4d7a-a535-a78719e996@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76a7d22e-bbd9-412d-e9ff-08da19994b27
x-ms-traffictypediagnostic: SN6PR10MB2877:EE_
x-microsoft-antispam-prvs: <SN6PR10MB287728C06E1B4E7DC5C1E5B293E99@SN6PR10MB2877.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vAW08oZjQXIV11FjoQjg0te6kbn4KEIgQoR/TJZCxzNdrCXxRU9YQympm1zYQ0TH9CH5cNdtHQsE/Ujt0Couvl4B/AZfm0Nf2tWFpmlJCt35cjsoFfgHcHdtlKYqClTqj+HlBqWDA8pEXGMb77PmJ4KVR9Krr63GHF17Ijr4uBGNopyV8qm+VO2IKgDeI65TUOiK1I9G5BgqYYqZUBlmDNwknI1JY5EWEUQQwjpb8qrbMZEWqPj4HdUGqhxsG0SdJC1nJg43zpL5vH8Q4/R5Qsg+tnAxL7J8yd43r2j0BpYfeMH4djUQa7u6Mz9Rcedr8ngxXeLEbj/iOUtctHDArBrfpMQIV4AK0/OnGLL93A2bdMqVghC4zrpgsR/axpB/wabWbMnnNNVLvTlu4/ZPqJv3CV2+xJvX+PJfnAobZqD2Hqw2zkA0Dc/DUJTjKmoDFLPvAYyeqYYnnULNmxXJXAR20v4/xJDCIzuUKUbsrtwzKgXwnZ651Ao3Nho/VrYdUmIfJCM7cPiVecE83f0887Aefcb/WbMkDrD4VIPr7eldOVswMVpWr5vNEiWyeX7+UXV5EuPqLMTma54dAJw3lVpZPV4OePYPsFGG/iA7QWqYTc7LYSVeAYsVJDd0ly/UNAhYhu0ryJC0jtNFGXLOzJacUPAXzYxrF28OWfVs9gkr2d24ghLiZFU8u+kiauQzuWgOXLIrKggZM5bQI/EvJqyHECnhEaZqxUC2yaIauUoojYXKEWbDlVf4NzmUv4g1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(6916009)(54906003)(5660300002)(36756003)(66476007)(66556008)(38100700002)(76116006)(2906002)(122000001)(91956017)(66946007)(8676002)(33656002)(4326008)(71200400001)(66446008)(64756008)(7416002)(86362001)(26005)(316002)(53546011)(186003)(8936002)(6512007)(2616005)(6506007)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VlHToBi5Q25YCs6OiUMZ6c7tzoY27BAT6EtVLdO4XLM00WFJUNjva8rInpyU?=
 =?us-ascii?Q?+gkEJbqy2D0my5GWf81TrTmOmGVcvCItZD7eOVLpoJRI4hDSnx6uHj016LIE?=
 =?us-ascii?Q?FXWTFfkCtE2XUX/17nOVoIciNvoa5028E66E9nn+jFBnblkbTRL3JTGTeDKb?=
 =?us-ascii?Q?Ti9KnwGobE03pWkJOFnV7qIcEFcDlIPxax6w+QrFcFAntw2idi4J+G7qjYGl?=
 =?us-ascii?Q?8yPDDUmeUS2RpqEGw06+K4EG1R/tcV+IaplrrLh2nqdTgJA/2zDjHuUguyfW?=
 =?us-ascii?Q?eyAOjfvSo/uAoEpAU1Mh+9ZX54v2gM0GehNjblMjldnVqP2nYViXyb4lrh39?=
 =?us-ascii?Q?Yhn1Wu9CepPcJne3kxGPCBey2Myd+ldONWzY9qi8p+pfYv1zaSuiXeJ2n8cP?=
 =?us-ascii?Q?3tHu+oilurHA8Hsmy3ZA9qwOxEOzyccm81LBxX5XtVoHbe+y+CpQ3G0YYpZM?=
 =?us-ascii?Q?vk6I3dwC+2JZc03ZFGk905CC22XjGMtyeUr17wuS9CvZRrndLUwniYYwxSAP?=
 =?us-ascii?Q?NjZVEIHLjmXZ6wXHpSMyNctWh8US11VCHRZHuGKAHZUamGxMhyAxS5AAMbHJ?=
 =?us-ascii?Q?eAK3WdY4NwnouQr6kYhSgzBNo7mlahhNxvnIryFxeZsPWnwbuUb7Oh5uekO8?=
 =?us-ascii?Q?qB7SIF4sJxdjIWIIr00vf2EO9Q70WICdbq1lM8F5oJe4T1B8okLFn2EL5eX5?=
 =?us-ascii?Q?UpQ8BXW65ThK31X1cWYnJYVjYEpIw2L/Ugwn5s8sYCouJRi9HqMK5PUCJMqe?=
 =?us-ascii?Q?Xtc9/Pnv+pCtMADb2Ubn7ptOxydfzkECR/nTF2rpgmU2yjtuf6o9jw3AsmsU?=
 =?us-ascii?Q?0bpIHSMYjBXw3hC1Sh1rZrkK6B1d1G3k5DWE4aC4cZCWHkbp8rIvc6OE26mA?=
 =?us-ascii?Q?C12RU8rY4lkmYYtqbh1N6FP2OcgJAxYMQoM8PHrFsaG+a6Xm3rPTT/FjJIfo?=
 =?us-ascii?Q?AICnfZ5yygcSyGLGPZiVyxjVrOKTiw7tBaAcrVLx7idhGDOU9N6fmlRG3IbD?=
 =?us-ascii?Q?FatT3mutzrVlrX3de4wzDWRxdGpbzHKsoxxZG9OoA5/aBpolzFez2L9oQ9FN?=
 =?us-ascii?Q?5IBSSc5NQuZWNiuig1utSQpETimwkJ/FY73ISaspCG4jgKdLeOxQYTkMs3tk?=
 =?us-ascii?Q?QtjwNXveN3sjBFoUTtGd6D5zH3FlqlZcgEgTGkvP5UoV1aLzcTWCfW/FY8+H?=
 =?us-ascii?Q?yH7Q9ddslwi/OKQ5EWV2efFJEjmpQmx9t5Zi4SAy2uZm4w9+aELzlsbLy/be?=
 =?us-ascii?Q?PxaxnjwLoI/cmQvUYyZcceJqiL+NWitXiqEfDnPTjjgeBYgEc8svoN3ecwD5?=
 =?us-ascii?Q?YTPUc9JvzQX/YgCCY8N5puNkKOMoE92IIHFT0RrYlWXrClEiLYISXMNzqCav?=
 =?us-ascii?Q?3Yy8okVPkooCmVFReMpymdUd47aYQBELnkl/QAZVQsnNInBxKOUZcF3vIkaG?=
 =?us-ascii?Q?2jUNigCn3hv8GtF6ErVldDHDlagS0Gab8GNyB7SCaLrmR5JGp9DgUoHHqJbz?=
 =?us-ascii?Q?c+R+F1wqV0VevMurFMokalqsXtT0VCX9Jaj/OG1xli74Wdhtm2RJ+B5NcKGe?=
 =?us-ascii?Q?bMDRcQWjjLMPsxnOl2SowZskwIV5vaU5klLCprNusl9gLOsR68juTgcgTz0k?=
 =?us-ascii?Q?ibzCJW5OK2LRnEo8ygfInaDv4NdbmYoNvd7yB5XalbNUc1oGJIEvYPg9XSsF?=
 =?us-ascii?Q?VppYupZccNw48/vDy5zCk2/MTlmTgkCMNLV2p/GxaxddSN8vzmcHmD5+jSY4?=
 =?us-ascii?Q?UJ3fDu4eDmHJKOd3LtILlrQMdnzntvQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53DCE6478193E54B86897606D003416F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a7d22e-bbd9-412d-e9ff-08da19994b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 19:52:20.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fl8x3awYsRUbECsIjxKqw0A2e8ncYTTV0WBszWTz8+6mIi0NkAPgAyYSfaJ3Bl0l1uvxPl5CqiMV/Ldi2O8RQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2877
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_07:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080100
X-Proofpoint-GUID: ZC2GdCcdd8krDcEzEm8YKouVRMHB4R3H
X-Proofpoint-ORIG-GUID: ZC2GdCcdd8krDcEzEm8YKouVRMHB4R3H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 8, 2022, at 3:09 PM, Hugh Dickins <hughd@google.com> wrote:
>=20
> On Fri, 8 Apr 2022, Chuck Lever III wrote:
>>> On Apr 7, 2022, at 6:26 PM, Hugh Dickins <hughd@google.com> wrote:
>>> On Thu, 7 Apr 2022, Chuck Lever III wrote:
>>>>=20
>>>> 847 static int
>>>> 848 nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer=
 *buf,
>>>> 849                   struct splice_desc *sd)
>>>> 850 {
>>>> 851         struct svc_rqst *rqstp =3D sd->u.data;
>>>> 852         struct page **pp =3D rqstp->rq_next_page;
>>>> 853         struct page *page =3D buf->page;
>>>> 854=20
>>>> 855         if (rqstp->rq_res.page_len =3D=3D 0) {
>>>> 856                 svc_rqst_replace_page(rqstp, page);
>>>> 857                 rqstp->rq_res.page_base =3D buf->offset;
>>>> 858         } else if (page !=3D pp[-1]) {
>>>> 859                 svc_rqst_replace_page(rqstp, page);
>>>> 860         }
>>>> 861         rqstp->rq_res.page_len +=3D sd->len;
>>>> 862=20
>>>> 863         return sd->len;
>>>> 864 }
>>>>=20
>>>> rq_next_page should point to the first unused element of
>>>> rqstp->rq_pages, so IIUC that check is looking for the
>>>> final page that is part of the READ payload.
>>>>=20
>>>> But that does suggest that if page -> ZERO_PAGE and so does
>>>> pp[-1], then svc_rqst_replace_page() would not be invoked.
>>=20
>> To put a little more color on this, I think the idea here
>> is to prevent releasing the same page twice. It might be
>> possible that NFSD can add the same page to the rq_pages
>> array more than once, and we don't want to do a double
>> put_page().
>>=20
>> The only time I can think this might happen is if the
>> READ payload is partially contained in the page that
>> contains the NFS header. I'm not sure that can ever
>> happen these days.
>=20
> I'd have thought that if a page were repeated, then its refcount would
> have been raised twice, and so require a double put_page().  But it's
> no concern of mine.  The only thing I'd say is, if you do find a good
> way to robustify that code for duplicates, please don't make it
> conditional on ZERO_PAGE - that's just a special case which I
> mis-introduced and is now about to go away.

100% agree on both counts: not sure (yet) why get_page() was not
used here, and a special case for ZERO_PAGE would be a band-aid.

Anyway, I haven't found a case yet where a duplicate struct page
appears in rq_pages with current kernels.


--
Chuck Lever



