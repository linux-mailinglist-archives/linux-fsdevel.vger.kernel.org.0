Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758BC70876E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjERSDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjERSDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 14:03:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A648EF9;
        Thu, 18 May 2023 11:03:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFIjwb012428;
        Thu, 18 May 2023 18:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SSga5UBtgYPzXGU06bzs3uzFvEyawUGkgZptylcJ8D8=;
 b=ncmZ+w8mUTIlFSXqdEDkoJ8SJHliWsP8oTJcQUfieQOIHNoy0NJXr9nkVYO6w9liJavW
 RcjJIDVUJwldLy9VPDVaiLc68Ptcjgk35gtTS5eefaq01JUmotTkCFE5qzUB/EkjObDB
 73olwsCzb/lw7HLi+uUqHXy7loSZ6y/K0dfDOoz1+CIIm3jUNUULaKe362cZrknTQQVn
 oJmJYrsijVkdCWo/oxB5/qbdw8iTJUfqWlLIm1NEWW4uwJluaRiL3WXulMMKZjqzvUFL
 B4SoNTM3TLa0wYoQVubJqa/YsfyYLt6ItpW6hA11gbF39h7ij1i4JXiDluocO6OQeN2C dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpk5tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 18:03:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IGMn5n036376;
        Thu, 18 May 2023 18:03:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm0446ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 18:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLcC4NFA0jm7O1CRhyhxhP069aL/NEkjsu8bX/HqI0Hs/cbhpPLauzFyTPSPpqa5qRFtykRaW4OooT4j9ZyDaDRNxHZuIurE3veDFlaxveFFOlG8oEKfjiWV6FIkrfL0R+AdLSbFF9vGqb24Obd7LG1twJO8Fwx6V+tTri/tLcF3Qr1QF4D9LUDXwU2yLyxc/rh2MPDuff8MVSv1Ps1MO4YZLm0faYnNJcgdGLzpuy6wJ73WwYrZJw3qGN5L7cWFj9ZegZpedz5WNiKEgIMXsVpTGJhfo+VWpt6g+mGjAuPlO4bhaX4eUdog1cHcKGVfHiP6mKiEuqgdJhxWwMPyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSga5UBtgYPzXGU06bzs3uzFvEyawUGkgZptylcJ8D8=;
 b=e9hNyt2Gc68lTSzxsTTjhgA5oULWDhzEVGl4shjZEzKFQuk/mtxJBjxRIyXaLcnhAswHnWFod93CrNi2YQtANqyaCaTaeXrW+EQ83WBoMpjba6l7m6kTE/YQh0X2bEueZ5hS92Nr26MT1loNlrht9aV5gOVFEMIPqTxVKU4Wri2hQpzzIexhGMyZGk5wpHcqaJ9gyFQVwoLTXn+ItC7Q4/9+dvQkZKXf55KROkywdzNemQuErr6z3+FMWENFn1dXOnFi5ZPA4PPA8enCVhnjdGOnnSH7AMLNStMuDmVuW/9xJbWwoARb4JzDNeJOaEgapOhkXpBA3F6xAGP+mNYIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSga5UBtgYPzXGU06bzs3uzFvEyawUGkgZptylcJ8D8=;
 b=ZHpgNsowLfE/d+ugiBqxA65/+E37tMlWticqCOP7hAgA8MXDSpdUWhp3tF5ffkYz+Wk0bk67szl+QszhfRDzospx17oHZQKrrQTFv9bDvlRn0yMMOpEqCCCoemA7pdAnoPRsmxBhVg9NR+INNdTMT05piLbNPvocts3iMd1yRKI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Thu, 18 May 2023 18:03:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 18:03:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] NFSD: enable support for write delegation
Thread-Topic: [PATCH v3 2/2] NFSD: enable support for write delegation
Thread-Index: AQHZiRjK2+pv1cqK90qCm9rFy+BQfK9gBbuAgAA/mgCAAAFTAIAADK0AgAAAi4A=
Date:   Thu, 18 May 2023 18:03:33 +0000
Message-ID: <3A7E2D1B-B24B-4920-85EF-D6AE029B57D6@oracle.com>
References: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
 <1684366690-28029-3-git-send-email-dai.ngo@oracle.com>
 <1B8D8A68-6C66-4139-B250-B3B18043E950@oracle.com>
 <21ad5e62-b3d1-2f74-d3fb-819f4e6a2325@oracle.com>
 <C3B5A73F-2504-407A-9B62-A130CAA5E2C9@oracle.com>
 <5fab1724-090b-9c22-5555-bf3df7ea165c@oracle.com>
In-Reply-To: <5fab1724-090b-9c22-5555-bf3df7ea165c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6037:EE_
x-ms-office365-filtering-correlation-id: ba42077f-d36f-49c1-3da6-08db57ca3231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkO9hKozRU7zGSh5G6cSeTRlzZrUok7fxXWe03rN/cqHEFRvphL+A0M7xkMrGvfFYs37md061gvp/wd3+2NbFWKjjk63GBBBQIUYavsu9wmsxcCsVF20ZosquNVB+V0EYom1hcCk/fNqciLk2sEhi1YQJAGn5oqt636itVNDA0CVQJ4+KWegP5OOy44F41gHlc2sJ+IJ1yzYL0t/fyRQ3bwzFbPPQoXDg+fzD3+hTBO9ZTxsB3pNLhKTsnT7RH4zj/6cUxfJyXt24PX4AXoLe8AAMYMVx+y/ieoQDE8xrxRSId0BJhGTR7oB1MM+aFy3/annokRXFhnIgY/Iq+0hwbYi/4xQ8axlmi31enBttrUm+/2DbUbwDo6sjrcV1s8EW97OnjRVoRnm2yoQJc3jfAWndnb+ZtWzOVisvdXx4CV9xnRngXw3VtemjxTbqdfklTn7XcorLpB2AJeMjD5emWPKlZA38LTShsNGT5PzTHrrFeBAAbD51gRErCXSbQlqJmYVF1CvqFOugGI7urVsT422KstJIoiss0DDupMuTTjO3vKWsRY/S+vZ/NnEEohSqbyYvj9eo3nUDdQIhJnxDWvaVDqzoMtuVDB6mlgiEF8BQ5uZATnHuO84yywGQ/iWGPTDa+2dRm0ar4iLqZGSmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(26005)(6512007)(6506007)(53546011)(36756003)(83380400001)(86362001)(33656002)(38070700005)(2616005)(38100700002)(122000001)(186003)(6486002)(37006003)(54906003)(5660300002)(478600001)(2906002)(316002)(6862004)(4326008)(8676002)(6636002)(8936002)(41300700001)(91956017)(66446008)(64756008)(66476007)(66556008)(66946007)(76116006)(66899021)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KzE07w83zKH+VlpaqbTjcLIFlzZggqqm5fD4KB//AgYO7chSCvTpzIN5+3Eh?=
 =?us-ascii?Q?VCJ+FqoJXFOpwtLuslpYArWT8L2HhIMDZEzTud9Rp2gUqsH/gt3To4uRATYQ?=
 =?us-ascii?Q?yno8haCgTiczIsgjg1xGZ0FRIlD6ztPSzy7I/+JdQiJB8zKWhmUXQZqxoWqN?=
 =?us-ascii?Q?yQFNYAoFCH0KRYShp1SZKdPM+pf9fWB3bjhPyY438YT0A43PRlP1B+4rx1GB?=
 =?us-ascii?Q?URZbXs8dLDNk0ghxd0xnxu1k0Z4FQ4qCgSzNZ4U1w3ciHY2eLPDd5YNF+ZmS?=
 =?us-ascii?Q?hw7T/1lbANX7ssA0N8K4UFjNIJ0ChELg70QKdMQKoh9/9nRz8tHux6zfikTE?=
 =?us-ascii?Q?XvbDsuRmoTDtqcpkC0QHuveU0BezCcPtzDtyGM6xk8WV4F4pTf14rPtQAJGx?=
 =?us-ascii?Q?3N9hMJRhDKC2RvQVT3pK7D2uGY8p0R5jVoxh4v/ILh7ORzLUbJ+vHvq/ORR6?=
 =?us-ascii?Q?5zr9Fi7K9JyBTtt/XJE43y2SCYe+DwQ7dl0in16xMSFGQo5hfDoUSJvM7Ypv?=
 =?us-ascii?Q?5dnrNmyYOZ/B92e4yKvWAEp/T40ozpvqoc152pRScIYWGTyPUtUwC14zp4YD?=
 =?us-ascii?Q?pUOjKYyxND1TSTcHIlBTRVDZM7vET4y1mml2j7eyEz7ayGpRwhQaPXlbfJw3?=
 =?us-ascii?Q?jOPijqbMRPiejDoqZ0Lge+mkIf2c+BhELztzEyOzAtrAnnfV1FVXdEjF7ZOB?=
 =?us-ascii?Q?zR5fGys3ugh3Mqb+cwmgYIH5mSsrxJUWnxrPaFincftu7XPP2t++zf7yIT2N?=
 =?us-ascii?Q?NY376Bhaxd+8EoqkTlN5Mm0DjPyha3Wuzw+58Vgn9MUQPZifZFM9gymfIRsy?=
 =?us-ascii?Q?mLeFESEFXQ0e0wizAx8zkrgFQEoSdOCQPhvQamNDyGu6hh67Vh78lqc6kbHN?=
 =?us-ascii?Q?chg+Ut6NEskmO6Yl64ROSjjzE6uHvW6I9naN++cR7DOV2S10AzYTdIm2qiG9?=
 =?us-ascii?Q?YuG7sDqHZyoMrGjk/LiO1cwniAcy9UXuevlL42hL+ynivkab5aIVY7UQgqSy?=
 =?us-ascii?Q?dXqBKFEZkFmAAOzZIM97Oa3LtOHeNzyGEeArH7vCs+7Q/OSYh+kbRlaH/T0/?=
 =?us-ascii?Q?07v3YMCNpSzFbHHon7wVWIKePXGGcaeYkJIua/sDw0GrPBNq2RrEJNqdTwQS?=
 =?us-ascii?Q?eDIsYorJOtIHVKt+fmaQs9cQXa+CIjrdLJWCdZ7vJGLZINLM6zOpnUS4hEaE?=
 =?us-ascii?Q?o1+tje2IASfK47BplzvT799bdVQ5rIVKKvwtxxIc5kkgiA8/hXgklLCRDwUZ?=
 =?us-ascii?Q?q58wQ93I0qxK3WCnFoDMpYNmyFMRwywwexsd9b8TQ4MouBoJexV+QB3tryI8?=
 =?us-ascii?Q?YEn6nKRFK1z3nh1zaGuD12EiKWjD7/Y2+Ofe21GPVh0qk44hndigCkc76SKL?=
 =?us-ascii?Q?37Cl73IAIne5bMOlNpzTz52rHT3wJ/CuBEQgSQt5sE9E/0xyFBngVpJZfxSf?=
 =?us-ascii?Q?aFR/IflYMVke8vss4EYe6qXtzhP+QqYv2wpWJXCsL/bb7fPdpkyTHKhf2gXp?=
 =?us-ascii?Q?1WN9YDTxgl0HXXTMyHYsbrBVLHW58gKL7HPlJb/vOfqbdnWYoCYU7a9ERSIP?=
 =?us-ascii?Q?KznXWTVuUCGEKJHzFh+slxkpvc9cMM7kCKF+BfNEFpAAR9dt2YG8lCBiJMiM?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F430B8EB4EF97448FAA02C923379699@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cCn84LBAYexPyPKytEkCVYU8JT+5Ekk9HjuiysbPOHDkFP1IzVLxjdGHAE5N9XoKOj8hT+TRgL6yEMvSIUrSLfJtgCX00sk6BZlPmTb5DOGYIRBneipNK9zLQRvaD2CmaD56b1jCAWquwUu1X1D4RtfO7j42IHgT+sM9X9Lv6p0OalJMP6gl3xe1ftZNW0J9tELrbj059br/dRDrV0DeJSilqmAmaG4cvyVsVKKE8T74sezyiEbJkoDvjGqRXIcIETgZI1SoQ6vNnSIeT7VXP8EipvYrnManMAffgq5+pl6uH/t4WHwkz7D1nWzlplBbkV30coFmDTZtWr2AVrZXqh0wSGpxyTnhiFSJUMs2z+m6XggyNl+S5ph079Zq87wEic55J5o8AzrQKt4h+nIjy2JTVGNd73lrI1rYLDyD7g0rrvGdt4kPjkfNHwIYYztM7Maj2uRhW5E8Ovnm/d0Lcd8njA8v1k4tcDlfyRsMeG/Y6LbZYIvcAyudPH7ju+VfTc6IJtoARHThvlPempAi7XAPnrLQQJrMnrwWzSoHyoD9oYG63LbhjsS3FxVpAQwN91K9pxDk7DgIqIUk7gqZXkDAqTKdsGXTo4uCDuDNVxGgqQEnK1nfwcK6BE1ZOvHFL0E74p7MmZNl95NidF/dmyc4fA8EsmdISehxpWSa8f11LEmHWug3GOqWBNlQPPJopggseCeD/TNCX1tqAPrpTTjvP/XvafPNUrkq8Id1OBiC+ADpPalDZzE8kz2bb9QVTlzlHjg7QgBw5DW1zwWb7ijVP3/vau3+x9RlHhtZPz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba42077f-d36f-49c1-3da6-08db57ca3231
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 18:03:33.9937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OU5hVXrfYyaZj8hSTyWR36M5hrsp4gRGbaDYGoxixqKXsU8646Gv3xGH2FMaQVrxiTchm/oXmeBmI4vDQOYF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=894
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180147
X-Proofpoint-GUID: fbf7TwunbxRuz20BamIuxnRhof3kCAf1
X-Proofpoint-ORIG-GUID: fbf7TwunbxRuz20BamIuxnRhof3kCAf1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 18, 2023, at 2:01 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 5/18/23 10:16 AM, Chuck Lever III wrote:
>>=20
>>> On May 18, 2023, at 1:11 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>>=20
>>> On 5/18/23 6:23 AM, Chuck Lever III wrote:
>>>>> On May 17, 2023, at 7:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>=20
>>>>> This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WR=
ITE
>>>>> if there is no conflict with other OPENs.
>>>>>=20
>>>>> Write delegation conflict with another OPEN, REMOVE, RENAME and SETAT=
TR
>>>>> are handled the same as read delegation using notify_change,
>>>>> try_break_deleg.
>>>> Very clean. A couple of suggestions, one is down below, and here is
>>>> the other:
>>>>=20
>>>> I was thinking we should add one or two counters in fs/nfsd/stats.c
>>>> to track how often read and write delegations are offered, and
>>>> perhaps one to count the number of DELEGRETURN operations. What do
>>>> you think makes sense?
>>> I'm not sure what these counters will tell us, currently we already
>>> has a counter for number of delegations handed out.
>> I haven't found that, where is it? Certainly, if NFSD already
>> has one, then no need to add more.
>=20
> num_delegations in nfs4state.c
>=20
>>=20
>> It would be nice one day, perhaps, to have a metric of how many
>> delegations a client holds. That's not for this series.
>=20
> okay.
>=20
>>=20
>>=20
>>> I think a counter
>>> on how often nfsd has to recall the write delegation due to GETATTR can
>>> be useful to know whether we should implement CB_GETATTR.
>> I hesitated to mention that because I wonder if that's something
>> that would be interesting only for defending a design choice,
>> not for site-to-site tuning. In other words, after we plumb it
>> into NFSD, it will never actually be used after CB_GETATTR
>> support is added.
>>=20
>> Do you believe it's something that administrators can use to
>> help balance or tune their workloads?
>=20
> You're right. That is just for ourselves to determine if CB_GETATTR
> is needed.

To be clear, such a counter, I agree, would be useful /to us/.
I'm just not sure how we could add something that would not
become part of the kernel/userspace API. Anyone have thoughts
about that?


--
Chuck Lever


