Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587F732062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 21:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjFOThp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFOTho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:37:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F42954;
        Thu, 15 Jun 2023 12:37:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJgU9001305;
        Thu, 15 Jun 2023 19:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kxoKPyrnGm+RICm55wCSerH+xjtGiwn5/kGXz8kqlK8=;
 b=n0ZonO7EwN9PAATe3+r5xhEjh0KO6VZL+lvDW5MC96NfX/kARq0UHxcpXv0Jrr96Z3KE
 m8JBXF4QY3H4h4hOMcrYIJtwvM0O7LnUwi2ULwpbdkvI1/H2o6xk4dOD6aVCrPzwfeDN
 fjsX+f0QvPafiHGq+hpTuxsbl9BL4KzdJNF6sX7uygxJC9odXzv1MdcijPUcT7LmQaK7
 1WcuE6Ln30Z4LyZbHvvlZoqjMak0zpzMX6bzYHPljMaH7cO7LjW0Z0+VtnpsfOqaHBz6
 oHIKTeT7z0O+ZqJI1tTRuhtJofuW2oF/4NEWN5//0NK2DjYr2zGaInaoBoKMc+wlXPsP vA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs22wdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 19:37:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FI7WtH038975;
        Thu, 15 Jun 2023 19:37:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm741r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 19:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ModTglwvPYK9dUVpSI0B+HppaAE9R+wRSyPIAHkqU8E/ZCXJBnjiUgNdAhjqXlrM/ATKa2Gu8MgIqXgUvXbZD1YWgHUr3wEhNXzCIQfIwHCXmuX8g40xQ43J4y9H0o9b4uD1dAd8+8MhicH6JibkdtvGazbepmk21qe8vA9RB6vZu63w5FGr+XeoEVyJGue9upp8Pgy/8tIqCqQ3cci53E6lJUOTevCq0p9/lQYAW7urjfEeQcaggBFEgJCzSFDVCQd/2LNNrmOqD4K2Kkot/d/20Vkf/GICAcSo1otj/ygCQT1MkNuRZnK6DTb/M98OTN08u7AizYr8JnXFWKK01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxoKPyrnGm+RICm55wCSerH+xjtGiwn5/kGXz8kqlK8=;
 b=UGsuB70o/1K1DqywyVjkn7WFVrO8XFMxy2m0CWrNEbg+94Wpbge8shhQ3urnnNF0/BYz3KEc78+GeRJ3oynTSXAjLRj9jSu7m15w8JrUREY6E9dKQxs/aZg7fA21GbX+0uf7oF4xDALqj/UM9iEILxNvVa2GbEMXM7sozjgG0RqgibaZBmj28OInAcSzgj/i+t4fnge25+K+VECIUnzB/I9J7pgqewMLzM2LtYmfJCuquyZK/2/sA/3Xxm4i8u9t0Nxmf5vi5o0zrMqqnMZ4QQXRTVNRvXmJkITHX/kWo+p1RRTPSgfZEtKvbj7E0lxH6l2i7lilRt6rPrJDwW+rYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxoKPyrnGm+RICm55wCSerH+xjtGiwn5/kGXz8kqlK8=;
 b=SWzMc6ylr+u9OU7VhaQkowdyxXXFlvgNIZ2ch8Ogy9relEZUxv6FXRrsHpo9mkrCxVNZ2FwdtegEvfrTdIqqxeEiiMWJ1iIuH8HuFdyw9ZVQgUZzNh8xpjO1eOMK3+wdsCLWXi8lBtbV/H5fggNCMJla6mZMPvl5m0ZlN86xqAQ=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by CH2PR10MB4389.namprd10.prod.outlook.com (2603:10b6:610:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 19:37:34 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 19:37:34 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 10/11] md: make bitmap file support optional
Thread-Topic: [PATCH 10/11] md: make bitmap file support optional
Thread-Index: AQHZn1W4nHdQXGJuKUaBf0+qdf+LdK+MQvAA
Date:   Thu, 15 Jun 2023 19:37:34 +0000
Message-ID: <E1479601-17FF-4B4E-911F-2C5710CA627F@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-11-hch@lst.de>
In-Reply-To: <20230615064840.629492-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|CH2PR10MB4389:EE_
x-ms-office365-filtering-correlation-id: 50bc3186-ce87-4275-8510-08db6dd7f791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eWpwEYuWFCc0/SJ92Oy2ibvoJjQv4AdmtjstMG7mYFBy829ApkIDKLcxy6tJynmrJe9ZOZE5XroKVA6HV19I3HASX9gVcf72eKkebWapLDqhdksbHwtN4PqUzadzstVTNSHH2gC7bB6JTvZxxVzvjddeXkguZ5LN6Af/D5l9CNpVmxfHrGOQ9NqN/gSG5C/D1mxsOrcwBSakOof2CspMM9v1zZJ3rwWsYUORMt4vz7NPmMXWvNcSQFocxCMhxNAZtY9eUvvO8ANbGPRSO3KroxBkYWVIEhDnZDX8nSFIWx5W3V6wQlt7cKjQjT3y5LCnt4C5ftoJUJkPhwcB1bLPUvglMRWnJ5UCYOSm6lizFVPT58EQoi4AbSnS8yuJHXRSvT9Qx31C+H8oZvFM5nME2552TmYpP/xGJ254efaYC0oX7S4HqdlTe0cohHd+5O1gGDfJ1w0TMCqrm6wDzk5++lW+JWqGkVMfFtIYFaxjgY9wQeI04bAzulBcN2rwQukTU7yuMCa8LrCKuqog4pPd6PApcawgGdWdBK8ee23X5F03uPMkoIpBBobpr53KUDJNQKGyUinX7cvuNQqiXwIpQ1JcfI1eeL+5jAUsG0ek/FpkwY6S85JH+Y1z2XbUdbCwGFnn4pEt8qE6oQhF5LGxaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(36756003)(86362001)(33656002)(38100700002)(478600001)(122000001)(38070700005)(41300700001)(8676002)(6486002)(8936002)(4326008)(54906003)(316002)(5660300002)(44832011)(6506007)(53546011)(6512007)(186003)(26005)(2906002)(2616005)(64756008)(66476007)(76116006)(71200400001)(66446008)(66556008)(66946007)(6916009)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9gSG4VRwK7IMV/cgRq7EnWJG/qcmNGUrJv1thw7k0YET+tQG4wc85iHm+Xxq?=
 =?us-ascii?Q?MbRlhvh2H9UR1YPljlwLXrQsQSr+GTnCT/UnRoJ39H0U8AbqgMRvO7r9HgaL?=
 =?us-ascii?Q?LbaA1pi9pyuAxk9goHf804vXTes8e8/GCt7DkWq0OqSRf+/+1FROOOpzwIVI?=
 =?us-ascii?Q?SwbXz/mXkUtlR2zwOCTl5QdVVdWldUijl+euFXcCQx2ftOQTFFOkvaeXLFqM?=
 =?us-ascii?Q?P5C+a0guzsuQwtLsR0IMr1UGXjpfjENe4Gq/YkNEMlnGylrpmuz3D7JhnTee?=
 =?us-ascii?Q?+C0CW/rlZPuJx9DwwcvaYWe1faM1ugB8XnnSKuT1MEepFJEkHhTsRxBM4R6b?=
 =?us-ascii?Q?8fb5dQj2feSWJalteP+r1eavUz5/Ww6yKhxTZlh5s9FwFG/JL237ieu7af43?=
 =?us-ascii?Q?DnCZThqboRyq1OPSuuAHxKjAWfmjzCV5rqt9ScOTVd1zi+vMFcSspIOgFab2?=
 =?us-ascii?Q?D9UcfBv09W6teKn1flQNy8qt8+H+5BQ2eDYDqzDMoWze55ysF/z4Jvs2Qa7u?=
 =?us-ascii?Q?k5rgm8jge6pDDLYxxVqs+otQ8wUroBYmc7YNNjJy7I+iTHfPO+sNAsYM3WCY?=
 =?us-ascii?Q?m63dRSBxtqYTUt6X8XAAv2Uw0VLIyZu0xS2ReUeCP6J8TG+v4fnfKDUEr1Ie?=
 =?us-ascii?Q?WUWopFE2/clNTLpNLm5Jx92HLXZQ/M+4DijOF9mJzXJW1D2+z0Ik1sgLi/63?=
 =?us-ascii?Q?UkjSpwffx6a5+WE2xC64AsBiysjK+4JmZO8pWU8obW7ETjm8I5UrPMrrsLmL?=
 =?us-ascii?Q?9E+MPrE9Nj87Qi1XRTzfJHk9bDe8+VMGZEOwW/yOV9m3z8O0zEZSY5vNXW6B?=
 =?us-ascii?Q?Nfqn7uDwZfFnnYUVbrwapt/lHaq/kdwdT12ZeLqvVotnSOcCH6b8eR7XNIOS?=
 =?us-ascii?Q?5O+7+eYe3fSLpzZRGgLPlCEIdHp9IcZdqKnQ1fta1k7jndHuFyP81Pc0x1Ip?=
 =?us-ascii?Q?X9zp5DJZA2RPuiXvViRfWXpPgQ502t6MY6g4reK6zd6DrRxoOUlSO4i28u0G?=
 =?us-ascii?Q?jGj3NkW6aZlTAlXXo/lJC9TiynITmhXsCH/qF0NKYvmAPmqG9KhsWfW0Zy88?=
 =?us-ascii?Q?DHsBloZrEm+cKgMt9bxzCq54uc+SjlZ7DgvT5OXZS4YRmHQ9zed9wAfbunNA?=
 =?us-ascii?Q?XbswNypPAq1yHmOJuyfuZn7CD44LOUljqkeL/BrG+Y+sr3GukS0MXYLat16x?=
 =?us-ascii?Q?ehjTUMQtDDTM71foNSYEaB5FZkfCcn6XIPnDsTvoBCM4lCQO+6Z1+kNC/VE/?=
 =?us-ascii?Q?aOhV/SrA72fC51MwW81FYC4fxDEWkF4aRcYkRcj8bHzt95MqFliYZWEPwuWy?=
 =?us-ascii?Q?+Twg0McCxG95/k6qksUSuNiiRaIoeq2FjiaG85Kif+8P7SvIh+rtAkgA/6PX?=
 =?us-ascii?Q?oiKQSK1o0bn9XM3SX5BXsKc1uGvnTE2FADM4mg7QB6Aw5TYPyuqIbnBkiMK/?=
 =?us-ascii?Q?EUiTpHW+46mxov5TOffnjgeifwTIKBdTv3eMkqZGLkixy54a+SSwu932Qdy8?=
 =?us-ascii?Q?qC5YBiqk5yXGW/snjiAz9t2JX9izdi9ptoiWSRmK6uDXe4Ihd2e4ggZMmpG3?=
 =?us-ascii?Q?6JPZX9zHS+840eNv5SBOhKNH2daStf3nJggK7I0357u2ULPiXjH4R0YtVBAS?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BAC414F2D0664468B7FCC2501469E18@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +c02I8XIGU50oMXCCtaVM8eg13WyXvGXgc0jtopiZLvg6eYdFgHaxJnL60YpHOvGeyIGoqAc1RYjGM7ztQgTgGyqCCNzfede6SRnDNepmTo0L5tR+5T+iQsGMgwHsE1/lcZHpxBvFRCuVkiS3NvEqKzTxr/HWpGH/K8vS64woUcxIsooMN9kX5RB5O7x/+9PdwJvsn9mjnRvchEB2tmM2DAIpz0LA6ziNm8un+K2OSpHWlSCVDImgmECLPUHUEM/0YO9p/CpVaBtgQphzrdTzh2SBzy3S9SJyQJ95JrOckpg4+D/5O//aT82pNFjGsd1ELIC49AfYeSTydNkS8nDakJbHtnr8PDtDHPI5GYooRpIRE+UV9Ulwjb4FRSQN/M3jyQnfw5FgCW59mO4+8VqUM/pBav8aj1FmFQFPhPauJDYWMdSVu6pSXe537WTfAtYdIWhL3Od71deCnNuZRr+vBPrhzODOHWnwP+f/u4P6Bm1deQbJ82XPSiADFRUazNI4b4G+tr57ORQ5rtr2ADFNtXTHGtENUT+d6B+IXyf/jcvZbbGqI7YCudezR64K7edqJPP1K9yiIzSSaXu/bvSHQeP9CD+tjZ4ds7iwZO/DU7OZwlIN8m6GIeB+qs2mRDwkzC1gH0sW3K/qjCd39B6+BiI9mfTxgezpiKzH+rT5qVqFfVtoUkLEvJKrSeHB2FR/69CkEYIGYrYqUgrSRYOxuZyAqtEkWzW2iozjq1c2RaP1x+jzZY1dsVIktK29faoQCRxJ/FQiLC6PoSetVmQ6tUvThAU+SFWushcf1cbBEvbwnO7JejdIdxRB6SXQ7Y6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bc3186-ce87-4275-8510-08db6dd7f791
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 19:37:34.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmVMv7t5AT7+2qGYlvp5bX+LzwKXlmNlifgZ9+roHoOifvRseHcBDvo9qOjkVg+hza8b532s/JJ4KNUQ7k6OQB5ujpatht9+FDg12ti7VqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_15,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150168
X-Proofpoint-GUID: JXcRLxP5UkYrNOICtq1AOZYonIgYTNSA
X-Proofpoint-ORIG-GUID: JXcRLxP5UkYrNOICtq1AOZYonIgYTNSA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 14, 2023, at 11:48 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> The support for write intent bitmaps in files on an external files in md
> is a hot mess that abuses ->bmap to map file offsets into physical device
> objects, and also abuses buffer_heads in a creative way.
>=20
> Make this code optional so that MD can be built into future kernels
> without buffer_head support, and so that we can eventually deprecate it.
>=20
> Note this does not affect the internal bitmap support, which has none of
> the problems.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/Kconfig     | 10 ++++++++++
> drivers/md/md-bitmap.c | 15 +++++++++++++++
> drivers/md/md.c        |  7 +++++++
> 3 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index b0a22e99bade37..9712ab9bcba52e 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -50,6 +50,16 @@ config MD_AUTODETECT
>=20
>  If unsure, say Y.
>=20
> +config MD_BITMAP_FILE
> + bool "MD bitmap file support"
> + default y
> + help
> +  If you say Y here, support for write intent bitmaps in files on an
> +  external file system is enabled.  This is an alternative to the intern=
al
> +  bitmaps near the MD superblock, and very problematic code that abuses
> +  various kernel APIs and can only work with files on a file system not
> +  actually sitting on the MD device.
> +
> config MD_LINEAR
> tristate "Linear (append) mode (deprecated)"
> depends on BLK_DEV_MD
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index ed402f4dad182d..1e29088b1f081a 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -295,6 +295,7 @@ static void write_sb_page(struct bitmap *bitmap, unsi=
gned long pg_index,
>=20
> static void md_bitmap_file_kick(struct bitmap *bitmap);
>=20
> +#ifdef CONFIG_MD_BITMAP_FILE
> static void write_file_page(struct bitmap *bitmap, struct page *page, int=
 wait)
> {
> struct buffer_head *bh =3D page_buffers(page);
> @@ -408,6 +409,20 @@ static int read_file_page(struct file *file, unsigne=
d long index,
>       ret);
> return ret;
> }
> +#else /* CONFIG_MD_BITMAP_FILE */
> +static void write_file_page(struct bitmap *bitmap, struct page *page, in=
t wait)
> +{
> +}
> +static int read_file_page(struct file *file, unsigned long index,
> + struct bitmap *bitmap, unsigned long count, struct page *page)
> +{
> + return -EIO;
> +}
> +static void free_buffers(struct page *page)
> +{
> + put_page(page);
> +}
> +#endif /* CONFIG_MD_BITMAP_FILE */
>=20
> /*
>  * bitmap file superblock operations
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index cf3733c90c47ed..c9fcefaf9c073b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7020,6 +7020,13 @@ static int set_bitmap_file(struct mddev *mddev, in=
t fd)
>=20
> if (mddev->bitmap || mddev->bitmap_info.file)
> return -EEXIST; /* cannot add when bitmap is present */
> +
> + if (!IS_ENABLED(CONFIG_MD_BITMAP_FILE)) {
> + pr_warn("%s: bitmap files not supported by this kernel\n",
> + mdname(mddev));
> + return -EINVAL;
> + }
> +
> f =3D fget(fd);
>=20
> if (f =3D=3D NULL) {
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

