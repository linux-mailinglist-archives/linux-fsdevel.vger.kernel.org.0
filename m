Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B916A6E3A41
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDPQUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDPQUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 12:20:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C14E6C;
        Sun, 16 Apr 2023 09:20:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33GDGEZ2006852;
        Sun, 16 Apr 2023 16:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yMB8kUqu5k7Hb6IJlFxFTdHRmjhhoNwAVkcAw5RaDyM=;
 b=0zT8i79v9aM4/qD16PE5EpsbRa/CGgwHtAYyuS445Eo3BPbi5tSqgmkZZ5DOd2K8qQLi
 TehPi0S9E39YQ6kgKOAeUg+1H61wA12dZsPlsPllgDKAPxj9sPGMKUcIn1Cp/6n6kJpP
 aB8IHo5bP+FBXO+WIWJx3R8XxZeGiRf1ykbVImhLw0GqlxmSz7GqR7oh+Jd+pdhResnx
 RJSFygFdw+sXyEgfMTnI0eEu/tpkRqwHCK+zOOvHdHNeUz0rZGSDaR+mt1i5KddEiX5z
 K+WfKTQhpw7kvGT0epm3Wc41bz2e6Fmeey7Ntgx0myTArENvncPMFLcuN3vjnG93tBRB 8w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfu9hrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Apr 2023 16:20:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33GE14nx027831;
        Sun, 16 Apr 2023 16:20:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc994tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Apr 2023 16:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc+Klme6nBR3CfBzPCfKAh8ZB+gEBdqJfZNN87RogMtFWGv3QnepSbn/Gn5s6zQXxPeWgaACtNQ1UzUhdzRSckzp2l/Tq/D1WCc3bFf3SQ84ckK8dU/UORy4L2PODliXiWRvkFsJ9/uA2DaBu+UPTnI2LuLBFc2OuNASkQkrPmKAvYcCX2BYk7V66whFR1irWp/ZTbY0BT0SItcwKzUDtYensr6msWs7y0YnonphYMQt1tNRZv0vwCyT+lwHXxMCt0r6CvImlMYdLhVv9UvlfukkrwZpUY6Z3h2wX1MLbW34SpARDMSnQuG+1T6X6BNpJEpvzagU1rF0c95IMdVu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMB8kUqu5k7Hb6IJlFxFTdHRmjhhoNwAVkcAw5RaDyM=;
 b=UBqFrj3pJLMB53M42jKMRP5Gy1wNEz0kRfdjZLzHaiKEDi0HfeTPFtmNf6QdvUtG54n6mpqDI2nxJUb3n9lNIRDLC8IWDruvNP5UZ/G/SUNokbUxjjlBPDPucRKGeIgV/XT3uy1GbuogZu11KmKyxOETQlSmxClpo93T404RsxPPQU/cCTnkL/22nMYDUi9l01MG+bLWTVueNZFUdVFy1A+uH7CxKyXy0G8YshV03YeaMu5UMdhOprX90aLkHiPU35nSaEytN2HMUy60BdgWHc0q9x5R1sgB0meq5g04MSzxI0meOq3jNhp+BRTl4br8hlvZurykWAgyiaeVZtfiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMB8kUqu5k7Hb6IJlFxFTdHRmjhhoNwAVkcAw5RaDyM=;
 b=a4yTuAdkSRFniF8eqRfWvC+E2Qvy9M5HZfKwzJ9SYGfVzVQIyGyfo853oJai2btYe/IQwcx8mveCg3cJO+D8lRZe0eX9fcKI5B/joRs6JEZRj27TaJjzOuepFlFu+eai9g1p4kE+/n89fCkAADLzAk3C/qUX1h9f8ycE8oBAlxM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Sun, 16 Apr
 2023 16:20:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.045; Sun, 16 Apr 2023
 16:20:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>,
        "fvdl@google.com" <fvdl@google.com>
CC:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Topic: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Index: AQHZb4qhR4jn7R6+a0evVV4Y3qmRcq8si0OAgAAQUgCAABjIgIAAToKAgADRqYCAAErvgA==
Date:   Sun, 16 Apr 2023 16:20:03 +0000
Message-ID: <8046177B-CAF1-4F83-BDE6-45F687409411@oracle.com>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
 <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
 <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
 <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
In-Reply-To: <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5087:EE_
x-ms-office365-filtering-correlation-id: fe7b7912-2d21-4286-c839-08db3e966f40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fk46KsdBPz3VJrHMmssEpzwIh2Urvs5ZdCCPdxjJeQIWcZzgLH3S9dYjo+khyrJM/tY+LA/pNL3S/J2vwcN6Qb30MBuhCJQVli8cozbXBs0xLJxV5s2BnqExX9oWcE0uxogdXDi5bkxAuM3W7L04a/1Qkxr0hg/aElCodhZV3PXsMJpM/rpnxgElHutrpvxe5aE9GJ0y1My1d5Dh9PLrpOFtK27mihpoVBw7oun75woZThYtqgQAgmLLK2FaRziTRObFZOma0WPwLLj8Li1jeAyEL+tyNkKuMuyemzrmhisP79CSWBXJf1Bpr+LhWADxSKCL2WwnSP02/KBHG8LJovGLJGQTKlCNQyUewEc00IJht1CkcCoQQ8fmZ21KWwWguMtHyYhrY+1gazLc26zVhpijBThNuKWk4OpRgcKQdmY+26y8CVscv5aucvIOIpNGm8NAL3QHxaLhVf1YBxD8/T2H4+dHRLyUWIcuWlXKHQgfQTiEvMLpA4tgFi0E6w4yF2QTq/vQ6ZHNjPdfJVEHHP9+/URUdgEKH/mpii3NyRomu8ZdXqEqelUXGMAAP+sqQlCxGEStKIuRNBxNB2DqGr94c5UzBkkQi/WrkwSq1duDFUcx7RxFoyWgouVKkX1ELRTuH5Nt6cAuyfOQNd5dMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(36756003)(33656002)(54906003)(110136005)(4326008)(316002)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(6486002)(71200400001)(8936002)(8676002)(5660300002)(41300700001)(2906002)(38070700005)(86362001)(122000001)(38100700002)(2616005)(6512007)(6506007)(26005)(186003)(53546011)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pQuhsdQx5ni/0PN1nG7T/o9xOe6zex0QXH7D6lK0wDrC5EzbnX2V6xu+t1D9?=
 =?us-ascii?Q?SSMDAslOBIN3Bucq/PSuqAywwLfnJX1wt1lBYyTTE4Lw8uYkMu1Zyd+ohOZV?=
 =?us-ascii?Q?uhj6zImrp3ztXLu44baS0vio73HF499qn5BlcedgxJcuQf7Gif3Jj6Y4taUs?=
 =?us-ascii?Q?RV6r65UiXEpjyj6F0XmUXbJj9oddv74YgX5JWhglI3Cq2VzNzsU7FzjqBOhj?=
 =?us-ascii?Q?SvQ7ar0Sm1/jPGAKSlqCUrEMa3ZB5wl5ALXZSdbw5gXQy/8qNXcS+aMccD+2?=
 =?us-ascii?Q?5mypNMYtMLtd/Y6xJh/zi1AQyPq6q/c42tivdLxsWxaPPyyvW6MqBcGk7OnC?=
 =?us-ascii?Q?KQppzRTEhXnvhEvTcfVVc5tJjr4zSPuxUTvjZs9l2LjrznhC+1ZI/ldW23dz?=
 =?us-ascii?Q?s8YB5oOonuFE0UsrdJ/KHSQmvYI1jv99CDxQJqa49lP9ECrRHztVy7JETyvi?=
 =?us-ascii?Q?xD/rQ3J7kbEn1ld0nCNdMJU8UIwRauRr4nbCXGFuErIWYWQM+O0qfKHP/TGa?=
 =?us-ascii?Q?z+z2BwSd6fr6tbVjrcFlYCRZQMcb+gC80SP9Qg3+8858d02mUoutRjS6shVR?=
 =?us-ascii?Q?enSuCBSvok+Rr080iKmX/VqrVFkFJvwC/yHWwNdaL4r4RV7wb9qrd7y5Jrl+?=
 =?us-ascii?Q?gU0l084KzdUhMQIL566kzHCL7BnRtBN92LEw8lpaF65mmeM8jU8YLBQ/pkAX?=
 =?us-ascii?Q?g3reBB4FmG5k/Gxm4Usr+3xJUM32F70QzjzR3xhmCGvyiaoJ97QvEOMxqDgy?=
 =?us-ascii?Q?C+RO2Q9xVKNTiqnXBlgTjigZ5Pn/izdCGXTo/Ciutmbe6blvzYgwRnw6lvyF?=
 =?us-ascii?Q?B/MIojeH6EFOMPhCyO+KQRZA0r4MWYgWKzwR0dYqQsd4+/Fg+/ZMsFEPfKgB?=
 =?us-ascii?Q?4fQvNpjsaffvqP+AyhhHVGvTKZ+sthKD1fubpbVXHQLcqfyG8pdzEirPEfEs?=
 =?us-ascii?Q?D/NqjrsxpryYM5ta1Qs4U3nuxKp3pbWtaZHd1AjhRRypNrI+ISatni3qQbap?=
 =?us-ascii?Q?B0DDrDvvdiywo68j4wJgQF6SD8DYIJhpY2WZehapHrP8kAdnQACWW1aAgeJ/?=
 =?us-ascii?Q?XZr9cNwxUVTB/PhBg0rpbQbMWkfkTY5jyG0DoY48c/U2n+yKfYXN0NT3eMgo?=
 =?us-ascii?Q?svgCxO3TjKxW6i3b3tvGWaAKuTJTptrcD//FQEEY3qlh1FHYm3kC/0C+qidS?=
 =?us-ascii?Q?cnHzOfIKERD29ax9HX7oYQbpxI3eC8y1U034PkSoPEjdvtNhI6hOlNLnvPwe?=
 =?us-ascii?Q?CswQAyMWsOgJATOxIt2VdKCkbqzuUTyJHp4Bm0CZS9ZUUfKZLslaWgCPcT9Z?=
 =?us-ascii?Q?ykCzYCBh0/+wq4QkCw4P7YpvweAjzRWm26UV1GdcNy9o85ZxRpJUyKmQg1uq?=
 =?us-ascii?Q?p3E6OJk5Q0qc2uPri+GaHUImQD0hhJEeawkRIdHvubKvSbFrncXPKj3VYwMi?=
 =?us-ascii?Q?bEwshi+1JGl3gIB7rnrXfvYSIq6hHHQRiKqqNs3pRokk37GB74de1aFP3d+Z?=
 =?us-ascii?Q?m1nwZ0atosCUlDshHdxA2wLJgwnRQu08NzrZQAJ8RaOdMLQVYuVsrB7qiHRG?=
 =?us-ascii?Q?Cxsj0sr7sWvx3nzqMYr049bArTeA2qUkDrX1BzKrU1o8Mt+U26q8jP+KD7Aa?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3F7D97B368C774CB06D2009541239DA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dAWjw4EeVUHye7uKpS6sUbFd/NMs3AqR1HFH/9oNvltxan2gKcEm27VRptCkT2udU2523Pkktlw902Xez+8BB+hD1kgNjhelsMgtPe4hYSei7A2W7LVKeCYzvO+nvgizkrBUUsJbTltprKVEo6zbfnav5yd7FqB2TwVBW44LXN6W/7iC1+8c2zUBfjD9kCKrhyqhCfT4jyqa6SqFO2OpfpqciOvGCpHfzWHA4nmD2N4m6/YFJfNbGbGgui885afg6wbCyjjxY5hid4FedZWB/MUb0lD8pu6jUmEvz4sj6Ce1gSVnPiqPFyfWjis8ylCI8OxU8r1aLZFmFNEMsBGUBw6hwRvH2s/Xfgy/GgPByTBlZ3HB/X94mnMlzouTVDCXTgwkfAa/VARo7k6YhDiiOuDyHutayWrMrio6vyQnTo8CuPIGwj4wk8uRUrUdMbYHC1ljhEH1h7AFWUf6rNIJSewEPbdPOXgiDZcORiOJlAq1v3gbhP92RqJm/Vr9FqUixFPJqX7ri6VciXnjf2RYCKuTi30gvC95zIZk4MaQoTPiUm5BedU9AOBiqi3+Obf8qIGqYGgiOYU22ZXUDCxJz/ulcV1n+qMlMtpfvlWhtE+0DkMpWxIID6q0+V/ritdZFEb33m5gBq6iuHg+vgN6OjKCZ+/U7gwiwhPS5n9xsesCSbJqr+g651mB/I+BvPvFWcm/XMghQLVwJCOlkgnzT23mjQ5BbfgjKBsphX1HO2OGeXMWyDDVEHY9AidSn71+V+H+ZSS3b0qekRXiNLvOgfIn0lDP8BpS8eQ6gCSIwCtNhsrr2Ne06/u2i6Xkqg1I41pW4E35TcU5qXgAu89jYEduHpB/uiOqmU9h70yhbo+GBCYsBV+I/3ix9LzhegiS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7b7912-2d21-4286-c839-08db3e966f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2023 16:20:03.5446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjuseC4SJfPyLf5x/sdFmGCNF2EbEJCvsjeci+bzO7mw5AXEeOWwTaFuFdeFZ85hMZRy38FJqvXVUdtE87apQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-16_11,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=965 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304160153
X-Proofpoint-GUID: wbc5FP23If6b94JvMg0J-TvKoYABnxgO
X-Proofpoint-ORIG-GUID: wbc5FP23If6b94JvMg0J-TvKoYABnxgO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Apr 16, 2023, at 7:51 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2023-04-16 at 08:21 +0900, Tetsuo Handa wrote:
>> On 2023/04/16 3:40, Jeff Layton wrote:
>>> On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
>>>> On 2023/04/16 1:13, Chuck Lever III wrote:
>>>>>> On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.SAK=
URA.ne.jp> wrote:
>>>>>>=20
>>>>>> Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP=
_NOFS
>>>>>> does not make sense. Drop __GFP_FS flag in order to avoid deadlock.
>>>>>=20
>>>>> The server side threads run in process context. GFP_KERNEL
>>>>> is safe to use here -- as Jeff said, this code is not in
>>>>> the server's reclaim path. Plenty of other call sites in
>>>>> the NFS server code use GFP_KERNEL.
>>>>=20
>>>> GFP_KERNEL memory allocation calls filesystem's shrinker functions
>>>> because of __GFP_FS flag. My understanding is
>>>>=20
>>>>  Whether this code is in memory reclaim path or not is irrelevant.
>>>>  Whether memory reclaim path might hold lock or not is relevant.
>>>>=20
>>>> . Therefore, question is, does nfsd hold i_rwsem during memory reclaim=
 path?
>>>>=20
>>>=20
>>> No. At the time of these allocations, the i_rwsem is not held.
>>=20
>> Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
>> via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) allo=
cation.
>> That's why
>>=20
>> /*
>> * We're holding i_rwsem - use GFP_NOFS.
>> */
>>=20
>> is explicitly there in nfsd_listxattr() side.
>>=20
>> If memory reclaim path (directly or indirectly via locking dependency) i=
nvolves
>> inode_lock_shared(inode)/inode_lock(inode), it is not safe to use __GFP_=
FS flag.
>>=20
>=20
> (cc'ing Frank V. who wrote this code and -fsdevel)

Frank is no longer at Amazon. I've added his correct address.


> I stand corrected! You're absolutely right that it's taking the i_rwsem
> for read there. That seems pretty weird, actually.

For sure. I certainly didn't expect that.


> I don't believe we
> need to hold the inode_lock to call vfs_getxattr or vfs_listxattr, and
> certainly nothing else under there requires it.
>=20
> Frank, was there some reason you decided you needed the inode_lock
> there? It looks like under the hood, the xattr code requires you to take
> it for write in setxattr and removexattr, but you don't need it at all
> in getxattr or listxattr. Go figure.
>=20
> If there's no reason to keep it there, then in addition to removing
> GFP_NOFS there I think we probably ought to just remove the inode_lock
> from nfsd_getxattr and nfsd_listxattr altogether.
>=20
> Longer term, I wonder what the inode_lock is protecting in setxattr and
> removexattr operations, given that get and list don't require them?
> These are always delegated to the filesystem driver -- there is no
> generic xattr implementation.
>=20
> Maybe we ought to do a lock pushdown on those operations at some point?
> I'd bet that most of the setxattr/removexattr operations do their own
> locking and don't require the i_rwsem at all.
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


