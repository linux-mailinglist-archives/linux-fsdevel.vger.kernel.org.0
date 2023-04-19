Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF76E7AA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjDSN0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDSN0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:26:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2831A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 06:26:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JBcDsc009201;
        Wed, 19 Apr 2023 13:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VBWSJdeAiB1mf/akeCh1iyghEj6Ah4nRiC7DqTJxOsM=;
 b=CyEMpv51onbGa5usjB90rVOieZe3CI1efYKzBJKiMmpV/qTGuXc1ILfhlt5Fe0xBf4Qu
 46V3jUuVTy9hNjgzyJ9VrLtlAGGmHHdfZvi4Yt2KFvGcdRJTKq1qpfHxmeJN+xO26iF3
 8QwuP/ZsMcbPxTj6MFU7OCnamzIh2Z3oSxOCqy83b6rYdkNceJ5Pg+pcivK16/4xa2qb
 dzQX4WfqO0kKBJptQg2kVxDxQsrqBBG6aATAYxaK7A7Jmvu18TAnW+QHrACRXRA3H1x7
 MjZwHH7svsAT+DAOAx3MoCdJo0PZb3+8io7n+pf+U2isxFzsxpl18/mqaFJE1niMoYHj SA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjh1rbkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:26:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JCFr02037363;
        Wed, 19 Apr 2023 13:26:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjccy41x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhOId6GpVWRie9bmI59HWgHty54utry5uVk/E17bbSPjWC0Axtwz7xLnsPdQocIEVX0cCRDotU0wU7O1ZPHDiLrVn0Bbb8vaSNfDeTmOLaPVNgYM09B3KVs5eHXOMONL8inPHsg1ik1XiUJCptFv8IjH4NfcWC73oQx1+iiBNhGPVYDIAGahIpCauRpNf4o4gqgnhobWkkwusqI0+Ph6xKolHlCkuCkwUmbBPwTD+zJ79WLxmWFm47Ye7UfrrgObr4HTelNBvx9jyfcnd2oM024U4LKmlMmXfbe7bw2jnmx43M+mKIwe2oloWofNth7348IXyZ4csF0Al6xXzDQChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBWSJdeAiB1mf/akeCh1iyghEj6Ah4nRiC7DqTJxOsM=;
 b=Qdqq00lweXacv7/9mGhON6uG9V9qvr0euNCOM7DwcC2qxE7r+eigxPqal/jSlgCShDIZsmjLHTO+JZ/euH/cb6qQ8ccUYXoSTLSSYt6sbJGHTUCZ6grVJG5BaKUb/tWmwjqIgNhxXGGeyVuHcPQtnDJTvCJZUAOl0gm/da6TesRMThc9gJWD9Fs/rWr+rwtFgr34lq7ow/6hmBu4i4qHiohFBuyxkiaM/1W/qW4BvbclNFJiOFklvAYlgweLT8FaSie7ZVrx8u7J50DBpVl0U6V6nPpZMP0hXahz2zWWWBi/k9DD8W32BPJXoGS0i+hGPMqZgVSuM+SFVWftMoEPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBWSJdeAiB1mf/akeCh1iyghEj6Ah4nRiC7DqTJxOsM=;
 b=EvT3b1ke55KjaRZLUHR/d7jJePkmn4Eqz38yUdxxzBepNJwzAxXsHQbm7irKfTxY5T3bhbumjHn/rSW2PMxrccxYmsL4FY/PbmObYQDT0hAukm+3L8mGHGjCPkLASIvWKv7ByE7WPapNmAgaJP6kNlM+vQK99easSTU3kFrUDR4=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by PH0PR10MB5577.namprd10.prod.outlook.com (2603:10b6:510:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:26:11 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1a10:986a:a82a:78d1]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1a10:986a:a82a:78d1%4]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 13:26:11 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "hch@lst.de" <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
        "syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com" 
        <syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] ext4: Handle error pointers being returned from
 __filemap_get_folio
Thread-Topic: [PATCH v2] ext4: Handle error pointers being returned from
 __filemap_get_folio
Thread-Index: AQHZcrfaUDCojmHzd06W14HxGDO+0q8yn5IA
Date:   Wed, 19 Apr 2023 13:26:10 +0000
Message-ID: <84D9DEFF-6615-435A-9F60-6DDD7F033656@oracle.com>
References: <20230419120923.3152939-1-willy@infradead.org>
In-Reply-To: <20230419120923.3152939-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.21)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR10MB5559:EE_|PH0PR10MB5577:EE_
x-ms-office365-filtering-correlation-id: 8d8a751c-a328-42a4-8fca-08db40d9a438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFIvySA4Z0LWDohUFt8RAf7jqLo9qDcPCSEj6OlfDWLhGzxRf5+nXct4jdGplm8O3oVO3mWod7Lcd5y5nyV8I3vC0RZZcgv3hfE3rr+xeIrsbU0VbG4ym94t0sSYurQ1hMWTTxg+pM5A4iJQgtc25OD5l7wrWmhhc2m0ORJXYrpKg5wOI90wkxAREjp0geodwYBpYuncakjVRjaLPes5gatn66dqdBbGyFN9A7f0t8dKZXcp8py03rUwXcoFx7tFysXWsv6wYPqnyqWQ6Ric0pH1I2wNqVY1FmKicW0buo7RLiVowK1om6jN+Km3Wija7pshqjUAr2T86ouieBVW0ZutWz00D5bQUHqtjMNsN5Sb/v6d92kmVgLgMVBUppZE6QJvrLcydKlm00alPXuBTeVJhzlq+9uAFhet4EOiK7zFyun0bpnAgkC5a5ayLbfYibrRtWZtg2rFo8Ah1gF0IU+4LUrRgkTewm0E6DSYc7SZMe6uLQcLMMjT8NGjapvWShT/wk72TAK3TSO+Bszn37R99QLYRfJxmi5jXp4Y9kWUfIX7ur1+1dOLF7yhURG6IghRUtuTyU7357BWn94ymPuE8ThTej/3pu2FlZ+PPgSW/F1L4VsLrOLTINCpuHFwvpO0zUyAmFreNiTApUPh4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(44832011)(36756003)(38070700005)(2906002)(8936002)(5660300002)(8676002)(41300700001)(122000001)(86362001)(33656002)(38100700002)(478600001)(2616005)(316002)(53546011)(6506007)(6512007)(54906003)(186003)(71200400001)(6486002)(6916009)(4326008)(91956017)(66446008)(64756008)(66476007)(66556008)(66946007)(83380400001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PDDvEOa9YY/B815JOcZy4jNW+KvXT3odwb1ZpLVYtvAYlC9OsQRmyqDV4eQH?=
 =?us-ascii?Q?ndCRKdozzO+UuxwiTC6qgFN4a1gEcAyDkUNQFEfMJswfHOhMN9RwUZv+q5+8?=
 =?us-ascii?Q?jFWe0tWvyhQi+VYwe+DF8pGVKcugAw5b+PTeWkH9PuIjQd+ePP4A/EmCt2N4?=
 =?us-ascii?Q?3Sga7k60gg/DWHvs8mbIYQpx8IebSHE7E92eKsPja6hLyVceylKj6X601SAN?=
 =?us-ascii?Q?qwIVZPqEgN2Kcf4YybycfWMyuyXt/ncHjtAC2oIa7jmrmEp3dw+JJuiqRTPG?=
 =?us-ascii?Q?1DZ6TpSgdQxn5d+Z4EnLMO5LdCNLJ96j6I1gKCtVEeeUudcKQmAoEsc8GslP?=
 =?us-ascii?Q?KY9XN0lgyVEIP3yCSrdh+gJOkBIJw6uAdxdcqUq59yPqSTY8jTQvXU5UYBGV?=
 =?us-ascii?Q?Gw78GdE/CM9Sgb0bV5BAisM5sgvN0iBeUlyct8xfFU9RPWh0LSdwGBU7MkGQ?=
 =?us-ascii?Q?Mpp1JkORV5KU6EdJqKJSTw616b6zpLGoXMZx5TmXr+JrXv9FKzKhF73/Y96f?=
 =?us-ascii?Q?HRuA/H1B5WsNjTy1W4GponRQeYNd2blFQXBZ4CeVfdBrbTbDEU4AcX7osK92?=
 =?us-ascii?Q?elDFUeHlwh0D78gYHFsXOTIH0n9Ux5Bg3EPbBhGlpHxRK0QoxlzuMIqJibZI?=
 =?us-ascii?Q?Vf1ZpVsC6VEjghJog6JSYdWDGQMbrCuNt4jeI0KodNp7DExS4d0ZZLjMPkpi?=
 =?us-ascii?Q?PSXkZ0w9z5KwQDzZHzPIJoOrr51EYiq4AIjMqyx79GK9fwYCsqnnQ+uPS/se?=
 =?us-ascii?Q?6oAj3lkjbKxkxlxiTEORtAANzOUV41axWg1vowj+JIa0AgEGEeVpK7IWiSCE?=
 =?us-ascii?Q?4vSCqCACzAPqjiwtJ6l4HFb/K7bXwDISpcl9bIgJUuA/ME5xRhij5JCmC+gO?=
 =?us-ascii?Q?3uxlEQCetawnrsDbs2bZCwKpSS1V20FcxrwrLLa4klKVNxEFBnBh4an0HgW5?=
 =?us-ascii?Q?gIQ0upe+Z6lmEHmO7F8hleT5bozM9YfV5ND999zEHjfOYu7HEMu0ENwF/zoO?=
 =?us-ascii?Q?L68mOTvrSsTSnJ89J8zY9fkYBvn0bzw05noAY/VixvFCK1lAPra7jJFUJXx+?=
 =?us-ascii?Q?b8Og+3o2H6qP8aRGycd4FpDugLHgBUueiamoUHqw1q/h9KzdUzSg2PF8koUR?=
 =?us-ascii?Q?lXqBEvAg0Jf/+sVkqXA5/Wj+TpWGwMw54tbKtAOx0ez3PmaWPcFjSR84Wc8g?=
 =?us-ascii?Q?E1q9wu9gdZINMXKjiMtjYvpXROB3ISPdh3L0KFkvxUPQ8kZX3gTRYrE3t/a+?=
 =?us-ascii?Q?+ukbKfdHnBDzvrfAFYexqJ/qiO13QhK/8Ov3esM/rNk7StEMGKVfUICjK0OO?=
 =?us-ascii?Q?jmQutrnRdbyy3UdOc15N10hb1zG8vkDc6mT6S9fuXpLPenkRez+NqxlbkZjL?=
 =?us-ascii?Q?RmQ05RD7NDzG5ZUJg2kdM5YzwCJeBGjsUMr6C/UbwoUuw1uNJJJztoCdgrrZ?=
 =?us-ascii?Q?5wKvWcXlPgvlqWzBDeR4AMNfVftubCoQ/XjuTD1WEf6rUf11/9oZ19x8z+18?=
 =?us-ascii?Q?gllgrJLlL8bdjAw+kHN/dui5yx2ZNTCVoQvipiCdGk101UToQ2cR4GanDUCw?=
 =?us-ascii?Q?1+2Osm/wudEKrDYBMU2kXZqAhW19LA9v2n4lorRLMjspuXDdN2EJNW8g/r0C?=
 =?us-ascii?Q?+eqrKZeOCrw0lERX1k3olqAONvFIwhUnOfFFaBCqLbCB1j6B1ozOSLzw85p1?=
 =?us-ascii?Q?xDcVqJJ+Pog8i0FWAnvfDKwFMIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C93A7EF29F0D6459077ECD209786B1D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?05pOM0fdFCRT5eEJlMtpsLfcetHJe1rfPSYj9rKN41hrTfBSnQ+K/HkFXShA?=
 =?us-ascii?Q?1Y4NNV4SOGUdEJ8F2a5IzRk54+bEHNprcwQkWi/pxYIaYdoE8GIlzGGKHqzB?=
 =?us-ascii?Q?sMw8GZESoh7Epzdu/sdhgUBjWOX+dPSEHKsQHDXACkxZ4Kg1k+UnYzc6ip7+?=
 =?us-ascii?Q?Qox9daejgK/k/ZLqQ1ETXCpspdNfOqnuqhurbJAaAHB1xdhkDxHcrnoPIATg?=
 =?us-ascii?Q?MdBIK6Qs6UiFYHcnWC/30rCpXdFecxkU7RKGh8ch5H92StC2UI+UGA9f/YnC?=
 =?us-ascii?Q?ib7kC6i4sPmTyUEgSdMDs5uS2KiCg2Inxx18JWNaYOqZ8IZfI/cmrz/Uo1jM?=
 =?us-ascii?Q?cn+qU4SYNdLQ5hp4e+m5SCBlIdROSCX8m/XNh3rPWst7wIicp6fmNrvRaAr8?=
 =?us-ascii?Q?che2TpYIf5NsLR8E8lywiphrtTbZWqg/Bt4NlnjaNQSenuInMETAlS7Bj7uL?=
 =?us-ascii?Q?SMpun5x4ieQYWMKwjyHlSeCHMIKd8zieEIPQ8jV3K+cyehtVH3J4Ykz5j4um?=
 =?us-ascii?Q?Zuha5FWFNCS6cM4GscSDAfyIeuCNPKY25caHFSRgI7G0hS0qc9D2Dd2uBnMB?=
 =?us-ascii?Q?0kWblVBRlCWrmWv5eYurfE2iY3jaIVek9EjviX+qG06FJbqwGYvUh4I+lr+q?=
 =?us-ascii?Q?VeHEmSHoUfonEnTNPXBdGfg2MetcRqInpWgLJ491sv/afSU5MOkOxHjed8mo?=
 =?us-ascii?Q?l973h9eWAfDvUbmGxMemQ0HnNGhvcB94L06aOerpvYo9bpDslSK4uxqUshwT?=
 =?us-ascii?Q?SUkDUxfdzoIm4WQM9eOeNnJvto/WuRirtcocjpMyCYYXPruFAjcDvV4tAkCO?=
 =?us-ascii?Q?J9qwX6lZ+GpDJIaAYikMEydlIqQXXGJbbD4XJL3Sm6TvE0r5iVHkwJXsT9Lf?=
 =?us-ascii?Q?M4Vpa9pRK1WgesQQw8kNzh3Rf7Ts9UaUXPY+yhWJu1zhx3pvquJRpFZHTf+S?=
 =?us-ascii?Q?fb7Xbtrmm0835iEudzyUL87DDuMKxN0/NkfaWNlwxv9snq+wr2k9Mbamti8h?=
 =?us-ascii?Q?YBVm5U5YmriHO9e0QOhLLkP0AKobfSIJwPGakwJFHuqdVgk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8a751c-a328-42a4-8fca-08db40d9a438
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 13:26:10.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djMYTzJG3+GVnssMCAhg4/7kZ6hkpHGNYGwrAmAzIFbqb6Pb35xmVNe4tvJhnXTNxbsn79Xvo2eTcardx7Qc+hCXn2JvNrLmE/qRDnXuVQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_08,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190120
X-Proofpoint-GUID: e1S8hkqM6YID6ySwrOYHrJtJBUiaCLVF
X-Proofpoint-ORIG-GUID: e1S8hkqM6YID6ySwrOYHrJtJBUiaCLVF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Apr 19, 2023, at 6:09 AM, Matthew Wilcox (Oracle) <willy@infradead.org=
> wrote:
>=20
> Commit "mm: return an ERR_PTR from __filemap_get_folio" changed from
> returning NULL to returning an ERR_PTR().  This cannot be fixed in either
> the ext4 tree or the mm tree, so this patch should be applied as part
> of merging the two trees.
>=20
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Reported-by: syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com
> Debugged-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Fix typo
>=20
> fs/ext4/inline.c | 17 +++++++++--------
> fs/ext4/inode.c  | 12 ++++++------
> fs/ext4/verity.c |  6 ++++--
> 3 files changed, 19 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index b9fb1177fff6..ab220d4bf73f 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -566,8 +566,9 @@ static int ext4_convert_inline_data_to_extent(struct =
address_space *mapping,
> 	 * started */
> 	folio =3D __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
> 			mapping_gfp_mask(mapping));
> -	if (!folio) {
> -		ret =3D -ENOMEM;
> +	if (IS_ERR(folio)) {
> +		ret =3D PTR_ERR(folio);
> +		folio =3D NULL;
> 		goto out;
> 	}
>=20
> @@ -693,8 +694,8 @@ int ext4_try_to_write_inline_data(struct address_spac=
e *mapping,
>=20
> 	folio =3D __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
> 					mapping_gfp_mask(mapping));
> -	if (!folio) {
> -		ret =3D -ENOMEM;
> +	if (IS_ERR(folio)) {
> +		ret =3D PTR_ERR(folio);
> 		goto out;
> 	}
>=20
> @@ -854,8 +855,8 @@ static int ext4_da_convert_inline_data_to_extent(stru=
ct address_space *mapping,
>=20
> 	folio =3D __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN,
> 					mapping_gfp_mask(mapping));
> -	if (!folio)
> -		return -ENOMEM;
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
>=20
> 	down_read(&EXT4_I(inode)->xattr_sem);
> 	if (!ext4_has_inline_data(inode)) {
> @@ -947,8 +948,8 @@ int ext4_da_write_inline_data_begin(struct address_sp=
ace *mapping,
> 	 */
> 	folio =3D __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
> 					mapping_gfp_mask(mapping));
> -	if (!folio) {
> -		ret =3D -ENOMEM;
> +	if (IS_ERR(folio)) {
> +		ret =3D PTR_ERR(folio);
> 		goto out_journal;
> 	}
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 974747a6eb99..7626acc62f7c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1177,8 +1177,8 @@ static int ext4_write_begin(struct file *file, stru=
ct address_space *mapping,
> retry_grab:
> 	folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> 					mapping_gfp_mask(mapping));
> -	if (!folio)
> -		return -ENOMEM;
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
> 	/*
> 	 * The same as page allocation, we prealloc buffer heads before
> 	 * starting the handle.
> @@ -2932,8 +2932,8 @@ static int ext4_da_write_begin(struct file *file, s=
truct address_space *mapping,
> retry:
> 	folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> 			mapping_gfp_mask(mapping));
> -	if (!folio)
> -		return -ENOMEM;
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
>=20
> 	/* In case writeback began while the folio was unlocked */
> 	folio_wait_stable(folio);
> @@ -3675,8 +3675,8 @@ static int __ext4_block_zero_page_range(handle_t *h=
andle,
> 	folio =3D __filemap_get_folio(mapping, from >> PAGE_SHIFT,
> 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> 				    mapping_gfp_constraint(mapping, ~__GFP_FS));
> -	if (!folio)
> -		return -ENOMEM;
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
>=20
> 	blocksize =3D inode->i_sb->s_blocksize;
>=20
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index 3b01247066dd..ce4b720f19a1 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -366,14 +366,16 @@ static struct page *ext4_read_merkle_tree_page(stru=
ct inode *inode,
> 	index +=3D ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
>=20
> 	folio =3D __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> -	if (!folio || !folio_test_uptodate(folio)) {
> +	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>=20
> -		if (folio)
> +		if (!IS_ERR(folio))
> 			folio_put(folio);
> 		else if (num_ra_pages > 1)
> 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> 		folio =3D read_mapping_folio(inode->i_mapping, index, NULL);
> +		if (IS_ERR(folio))
> +			return &folio->page;
> 	}
> 	return folio_file_page(folio, index);
> }
> --=20
> 2.39.2
>=20

